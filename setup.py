from setuptools import setup, find_packages

setup(
    name="aws-glue-medium",
    version="0.1.0",
    package_dir={"": "code"},
    packages=find_packages(where="code"),
    install_requires=[
        "pyspark>=3.0.0",
    ],
    extras_require={
        "test": [
            "pytest>=7.0.0",
        ],
    },
    python_requires=">=3.8",
)