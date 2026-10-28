import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

class WorkloadContractTests(unittest.TestCase):
    def test_validation_for_every_public_input(self):
        source=(ROOT/'modules/workload-contract/main.tf').read_text()
        self.assertEqual(source.count('validation {'),4)
    def test_positive_and_negative_native_tests_exist(self):
        folder=ROOT/'modules/workload-contract/tests'
        a=(folder/'positive.tftest.hcl').read_text()
        b=(folder/'negative.tftest.hcl').read_text()
        self.assertGreaterEqual(a.count('assert {'),2)
        self.assertEqual(b.count('expect_failures ='),4)
    def test_terratest_fixture_uses_no_cloud_provider(self):
        source=(ROOT/'examples/dev/main.tf').read_text()
        self.assertNotIn('provider "aws"',source)
        self.assertIn('module "workload"',source)

if __name__=='__main__':unittest.main()
