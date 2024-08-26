#!/bin/bash

# �ű�����·��
SCRIPT_PATH="$HOME/Dawn.sh"

# ������Կ����
function generate_key() {
    # �����������Ӻ�Ŀ���ļ���
    URL="https://github.com/hemilabs/heminetwork/releases/download/v0.3.2/heminetwork_v0.3.2_linux_amd64.tar.gz"
    FILENAME="heminetwork_v0.3.2_linux_amd64.tar.gz"
    DIRECTORY="heminetwork_v0.3.2_linux_amd64"
    KEYGEN="./keygen"
    OUTPUT_FILE="$HOME/popm-address.json"

    # �����ļ�
    echo "�������� $FILENAME..."
    wget -q $URL -O $FILENAME

    # ��������Ƿ�ɹ�
    if [ $? -eq 0 ]; then
        echo "������ɡ�"
    else
        echo "����ʧ�ܡ�"
        exit 1
    fi

    # ��ѹ�ļ�
    echo "���ڽ�ѹ $FILENAME..."
    tar -xzvf $FILENAME

    # ����ѹ�Ƿ�ɹ�
    if [ $? -eq 0 ]; then
        echo "��ѹ��ɡ�"
    else
        echo "��ѹʧ�ܡ�"
        exit 1
    fi

    # ɾ��ѹ���ļ�
    echo "ɾ��ѹ���ļ�..."
    rm $FILENAME

    # �����ѹ���Ŀ¼
    echo "����Ŀ¼ $DIRECTORY..."
    cd $DIRECTORY

    # ���ɹ�Կ
    echo "�������ɹ�Կ..."
    $KEYGEN -secp256k1 -json -net="testnet" > $OUTPUT_FILE

    # ��ʾ���ɵĹ�Կ
    echo "��Կ������ɡ�����ļ���$OUTPUT_FILE"
    echo "���ڲ鿴��Կ�ļ�����..."
    cat $OUTPUT_FILE

    # �ȴ��û���������������˵�
    echo "��������������˵���..."
    read -n 1 -s
}

# ���нڵ㺯��
function run_node() {
    DIRECTORY="heminetwork_v0.3.2_linux_amd64"

    # �����ѹ���Ŀ¼
    echo "����Ŀ¼ $DIRECTORY..."
    cd $HOME/$DIRECTORY || { echo "Ŀ¼ $DIRECTORY �����ڡ�"; exit 1; }

    # ���û������������нڵ�
    echo "���û��������������ڵ�..."

    # ��ʾ�û��滻ʵ��ֵ
    echo "���滻 <private_key> Ϊ���ʵ��˽Կ��"
    echo "POPM_STATIC_FEE ��Ĭ��ֵΪ 50 (��λ��sat/vB)�������Ҫ����ֵ�����ڽű����滻��"

    # ���û����������������Ҫ�滻ʵ��ֵ��
    export POPM_BTC_PRIVKEY="<private_key>"
    export POPM_STATIC_FEE="50"  # Ĭ�Ϸ���Ϊ 50 sat/vB
    export POPM_BFG_URL="wss://testnet.rpc.hemi.network/v1/ws/public"

    # �����ڵ�
    echo "�����ڵ�..."
    ./popmd

    # �������˵�
    echo "��������������˵���..."
    read -n 1 -s
}

# ���˵�����
function main_menu() {
    while true; do
        clear
        echo "�ű��ɴ����������������д������ @ferdie_jhovie����ѿ�Դ�����������շ�"
        echo "================================================================"
        echo "�ڵ����� Telegram Ⱥ��: https://t.me/niuwuriji"
        echo "�ڵ����� Telegram Ƶ��: https://t.me/niuwuriji"
        echo "�ڵ����� Discord ��Ⱥ: https://discord.gg/GbMV5EcNWF"
        echo "�˳��ű����밴���� ctrl + C �˳�����"
        echo "��ѡ��Ҫִ�еĲ���:"
        echo "1. ������Կ"
        echo "2. ���нڵ�"
        echo "3. �˳�"

        read -p "������ѡ�� [1-3]: " option

        case $option in
            1)
                generate_key
                ;;
            2)
                run_node
                ;;
            3)
                echo "�˳��ű���"
                exit 0
                ;;
            *)
                echo "��Чѡ�������ѡ��"
                ;;
        esac
    done
}

# ִ�����˵�����
main_menu
