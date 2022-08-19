import json

def extract(json_obj,target_key,keys):
    if type(json_obj) is not dict :
        return
    for key in  json_obj:
        if key == target_key:
            print("value for key {} is {}".format(keys,json_obj[key]))
        extract(json_obj[key],target_key,keys)

def main():
    # Test 1
    test_json_1 = {"a":{"b":{"c":"d"}}}
    keys_1 = 'a/b/c'
    extract(test_json_1,keys_1.split('/')[-1],keys_1)

    # Test 2
    test_json_2 = {"x":{"y":{"z":"a"}}}
    keys_2 = 'x/y/z'
    extract(test_json_2,keys_2.split('/')[-1],keys_2)

if __name__ == "__main__":
    main()
