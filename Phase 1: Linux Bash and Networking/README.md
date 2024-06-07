# Capstone Project: CloudUploader CLI
A bash-based CLI tool that allows users to quickly upload files to a specified cloud storage solution, providing a simple and seamless upload experience similar to popular storage services.

Your tool should be able to upload a file:

`clouduploader /path/to/file.txt`

## Steps
1. Create a GitHub repo for your project, make sure to leverage branches and commit your code often.
2. Setup & Authentication:
    -   Choose a cloud provider (e.g., AWS S3, Google Cloud Storage, Azure Blob Storage).
    -   Setup authentication. For instance, with Azure, you'd use `az login` to set up your credentials.

3. CLI Argument Parsing:

    - Use bash's built-in `$1`, `$2`, etc., to parse command-line arguments.
    - `$1` could be the filename or path.
    - Optionally, allow additional arguments like target cloud directory, storage class, or any other cloud-specific attributes.

4. File Check:
    - Before uploading, check if the file exists using `[ -f $FILENAME ]`.
    - Provide feedback if the file is not found

5. File Upload:
    - Use cloud provider CLI to upload the file.

6. Upload Feedback:
    - On successful upload, provide a success message.
    - If there's an error, capture the error message and display it to the user.

7. Advanced Features (Optional):
    - Allow multiple file uploads at once.
    - Add a progress bar or percentage upload completion using tools like `pv`.
    - Provide an option to generate and display a shareable link post-upload.
    - Enable file synchronization -- if the file already exists in the cloud, prompt the user to overwrite, skip, or rename.
    - Integrate encryption for added security before the upload.

8. Documentation:
    - Write a README.md file that explains how to set up, use, and troubleshoot the tool. Include a brief overview, prerequisites, usage examples, and common issues.

9. Distribution:
    - Package the script for easy distribution and installation. You can even provide a simple installation script or instructions to add it to the user's `$PATH`.