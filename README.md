# AWS Glue Reusable Module Project

## Overview

This project demonstrates how to set up a reusable module within the AWS Glue service stack. The key objectives and components include:

1. **Reusable Glue Modules**: The project focuses on creating modular Glue jobs that can be reused across different data transformation tasks, showcasing best practices for modular design in AWS Glue.

2. **Data Transformation**: It includes Glue jobs that read data from S3, perform transformations (such as converting product names to uppercase and lowercase), and write the transformed data back to S3.

3. **Infrastructure as Code**: The project utilizes Terraform to define and provision the necessary AWS infrastructure, including IAM roles, S3 buckets, and Glue jobs, ensuring that the setup is reproducible and manageable.

4. **Utility Functions**: The project contains utility functions for data manipulation, which can be reused in different Glue jobs, promoting code reusability and maintainability.

5. **Testing**: Unit tests are included to validate the functionality of the utility functions, ensuring reliability and correctness in data transformations.

6. **Development Environment**: A `requirements-dev.txt` file is provided for managing development dependencies, facilitating an easy setup for development and testing.

## Requirements

- Python 3.8 or higher
- Apache Spark
- AWS Glue
- Terraform

### Development Requirements

To install the development requirements, run:

```bash
   pip install -r requirements-dev.txt
```

## Usage

1. **Set Up AWS Infrastructure**: Use Terraform to set up the necessary AWS resources. Navigate to the `infra/aws` directory and run:

   ```bash
   terraform init
   terraform apply
   ```

2. **Run Glue Jobs**: After setting up the infrastructure, you can run the Glue jobs defined in the `code/aws_glue` directory. Ensure that the necessary data is available in the specified S3 buckets.

3. **Testing**: To run the tests, use pytest:

   ```bash
   pytest tests/
   ```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

## Acknowledgments

- [AWS Glue Documentation](https://docs.aws.amazon.com/glue/latest/dg/what-is-glue.html)
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)