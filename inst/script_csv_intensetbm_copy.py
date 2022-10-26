import os # Native python module to deal with Operating System (Here File System)
import csv # Native python module to deal with CSV files
from redcap import Project, RedcapError # Module to access redcap API : https://pycap.readthedocs.io/en/latest/deep.html

def test_function(URL, API_KEY, REF_IDENTIFIER, pathSave):
    
    #URL = 'https://intense-tbm.pacci.ci/api/' # Url to your Redcap server API
    #API_KEY = '4C0097230C6C8E0CA468357CCAED572B' # Generated API Token(jeton) from your redcap project
    project = Project(URL, API_KEY) # Create your project object
    #REF_IDENTIFIER = 'record_id' # The field use as identifier
    metadata_of_fields = project.metadata # Get metadata of all fields of your project : See alternative code
    # in line 17
    list_of_forms = project.forms # Get the your project forms(eCRFs)

    # This part create a CVS file per redcap project form with this records
    for form in list_of_forms:
        list_of_rows =[] # List of rows CSV file => It a list of list
        header_row = [REF_IDENTIFIER] # Initialize the header row (list of columns names)
        # metadata_of_fields = project.export_metadata(forms=[form]) # Possible but more slow  
        # because round trip to the server in the loop
        # For each field, if is in this form, add it in the header row
        for metadata_object in metadata_of_fields:
            if form == metadata_object["form_name"]:
                if metadata_object["field_name"] != REF_IDENTIFIER:
                    header_row.append(metadata_object["field_name"])
        header_row.extend(("redcap_event_name", "redcap_repeat_instrument", "redcap_repeat_instance"))
        list_of_rows.append(header_row) # Add the header row as first row of the CSV file
        data = project.export_records(forms=[form]) # Get the records of this form from Redcap project
        second_field_name = header_row[1]
        # Create a row (here a list) for each record and add it to the list of rows of the CSV file 
        for record_objet in data:
            if record_objet.get(second_field_name) != '':
                data_row = []
                for field_name in header_row:
                    index = header_row.index(field_name)
                    value = record_objet.get(field_name)
                    data_row.insert(index, value)
                list_of_rows.append(data_row)
        # Create CSV file with the name of this form and add his rows(data)
            csv_file = os.path.join(pathSave, f"{form}.csv")
            with open(csv_file, 'w', newline='') as writeFile:
                writer = csv.writer(writeFile)
                writer.writerows(list_of_rows)
            writeFile.close()
    print("All executions are succefull!!!!!!!!")
