import json
import requests

imds_server_base_url = "http://169.254.169.254/metadata/instance?api-version=2021-02-01"

proxies = {
    "http": None,
    "https": None
}

def api(endpoint):
    headers = {'Metadata': 'True'}
    json_obj = requests.get(endpoint, headers=headers, proxies=proxies).json()
    return json_obj


def main():
    instance_json = api(imds_server_base_url)
    print("Instance data:")
    print(json.dumps(instance_json))

if __name__ == "__main__":
    main()
