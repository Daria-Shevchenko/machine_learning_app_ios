
import os 
import shutil
import pandas as pd 

input_classes_filename = "/Users/dariashevchenko/Desktop/course_work/5/ESC-50-master/meta/esc50.csv"
sounds_directory = "/Users/dariashevchenko/Desktop/course_work/5/ESC-50-master/audio/"
output_directory = "/Users/dariashevchenko/Desktop/course_work/5/ESC-50-master/classes/"

classes_to_include = ["dog","rooster","pig","cow","frog","cat"]

try: 
    os.makedirs(output_directory)
except: 
    if not os.path.isdir(output_directory):
        raise 

for class_name in classes_to_include:
    class_directory = output_directory + class_name + "/"
    try: 
        os.makedirs(class_directory)
    except OSError:
        if not os.path.isdir(class_directory):
            raise 

classes_file = pd.read_csv(
    input_classes_filename, 
    encoding="utf-8",
    header = "infer"
)

for line in classes_file.itertuples(index = False): 
    file_class = line[3] # get the category/class 

    if file_class in classes_to_include:
        file_name = line[0]
        file_src = sounds_directory + file_name
        file_dst = output_directory + file_class + "/" + file_name
        try: 
            shutil.copy2(file_src, file_dst)
        except IOError: 
            raise 



