import csv
import os

READ_PATH = "trial.csv"
WRITE_PATH = "output.csv"

def convert_data(dir):
    data = []
    with open(dir) as file:
        data = file.readlines()
    with open(WRITE_PATH, "w", newline = "") as infile:
        csvwriter = csv.writer(infile)
        skip = False
        for row in data:
            newrow = ""
            for char in row:
                if skip:
                    skip = False
                    continue
                if char in ["#", "$", "%", "^"]:
                    newrow += "\\" + char
                elif char == "<":
                    newrow += repr("$\leftarrow$")
                    skip = True
                else: newrow += char
            newrow = newrow.replace("\n", "") + "\\\\"
            print(newrow)
            csvwriter.writerow([newrow])

convert_data(READ_PATH)
