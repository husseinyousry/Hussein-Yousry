## calculater code using GUI

import tkinter as tk
from tkinter import messagebox

def calculate():
    try:
        num1 = float(entry_num1.get())
        num2 = float(entry_num2.get())
        operator = entry_operator.get()

        if operator == "+":
            result = num1 + num2
        elif operator == "-":
            result = num1 - num2
        elif operator == "*":
            result = num1 * num2
        elif operator == "/":
            if num2 != 0:
                result = num1 / num2
            else:
                result = "Error: Division by zero is not allowed."
        else:
            result = "Error: Invalid operator."

        if isinstance(result, float):
            label_result.config(text=f"Result: {round(result, 3)}")
        else:
            label_result.config(text=result)

    except ValueError:
        messagebox.showerror("Input Error", "Please enter valid numeric values.")

root = tk.Tk()
root.title("calculotor")

tk.Label(root, text="Enter the first number:").grid(row=0, column=0)
entry_num1 = tk.Entry(root)
entry_num1.grid(row=0, column=1)

tk.Label(root, text="Enter the operator (+, -, *, /):").grid(row=1, column=0)
entry_operator = tk.Entry(root)
entry_operator.grid(row=1, column=1)

tk.Label(root, text="Enter the second number:").grid(row=2, column=0)
entry_num2 = tk.Entry(root)
entry_num2.grid(row=2, column=1)

button_calculate = tk.Button(root, text="Calculate", command=calculate)
button_calculate.grid(row=3, column=0, columnspan=2)

label_result = tk.Label(root, text="Result: ")
label_result.grid(row=4, column=0, columnspan=2)

root.mainloop()