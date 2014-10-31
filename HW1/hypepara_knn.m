function [new_accu, train_accu]=hypepara_knn(train_data, train_label, new_data, new_label)

for k=1:2:23
    [new_accu(k), train_accu(k)] = knn_classify(train_data, train_label, new_data, new_label, k)
end