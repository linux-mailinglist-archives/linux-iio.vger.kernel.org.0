Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07122F49B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgG0QQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 12:16:49 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26268 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731302AbgG0QQm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 12:16:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RG7tIW019031;
        Mon, 27 Jul 2020 12:16:41 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5eym2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:16:41 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06RGGdoC050476
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 12:16:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Jul
 2020 12:16:38 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 12:16:38 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RGGShp009603;
        Mon, 27 Jul 2020 12:16:37 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v7 8/9] hwmon: pmbus: adm1266: program configuration
Date:   Mon, 27 Jul 2020 19:18:13 +0300
Message-ID: <20200727161814.14076-9-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727161814.14076-1-alexandru.tachici@analog.com>
References: <20200727161814.14076-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_11:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Writing the configuration Intel hex file to the nvmem,
of an adm1266, with offset 0x30000, will now
trigger the configuration programming.

During this process the adm1266 sequencer will be
stopped and at the end will be issued a seq reset
(see AN-1453 Programming the configuration).

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 179 +++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index f851c6617870..50386c98d714 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -40,7 +40,10 @@
 #define ADM1266_BLACKBOX_INFO	0xE6
 #define ADM1266_PDIO_STATUS	0xE9
 #define ADM1266_GPIO_STATUS	0xEA
+#define ADM1266_STATUS_MFR_2	0xED
+#define ADM1266_REFRESH_FLASH	0xF5
 #define ADM1266_MEMORY_CONFIG	0xF8
+#define ADM1266_MEMORY_CRC	0xF9
 #define ADM1266_SWITCH_MEMORY	0xFA
 #define ADM1266_UPDATE_FW	0xFC
 #define ADM1266_FW_PASSWORD	0xFD
@@ -66,6 +69,11 @@
 
 /* ADM1266 STATUS_MFR defines */
 #define ADM1266_STATUS_PART_LOCKED(x)	FIELD_GET(BIT(2), x)
+#define ADM1266_RUNNING_REFRESH(x)	FIELD_GET(BIT(3), x)
+#define ADM1266_ALL_CRC_FAULT(x)	FIELD_GET(BIT(5), x)
+
+/* ADM1266 STATUS_MFR_2 defines */
+#define ADM1266_MAIN_CONFIG_FAULT(x)	FIELD_GET(GENMASK(9, 8), x)
 
 /* ADM1266 GO_COMMAND defines */
 #define ADM1266_GO_COMMAND_STOP		BIT(0)
@@ -74,6 +82,8 @@
 
 #define ADM1266_FIRMWARE_OFFSET		0x00000
 #define ADM1266_FIRMWARE_SIZE		131072
+#define ADM1266_CONFIG_OFFSET		0x30000
+#define ADM1266_CONFIG_SIZE		131072
 #define ADM1266_BLACKBOX_OFFSET		0x7F700
 #define ADM1266_BLACKBOX_SIZE		64
 
@@ -117,6 +127,11 @@ static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
 		.offset         = ADM1266_FIRMWARE_OFFSET,
 		.bytes          = ADM1266_FIRMWARE_SIZE,
 	},
+	{
+		.name           = "configuration",
+		.offset         = ADM1266_CONFIG_OFFSET,
+		.bytes          = ADM1266_CONFIG_SIZE,
+	},
 };
 
 DECLARE_CRC8_TABLE(pmbus_crc_table);
@@ -520,6 +535,9 @@ static int adm1266_read_mem_cell(struct adm1266_data *data, const struct nvmem_c
 	case ADM1266_FIRMWARE_OFFSET:
 		/* firmware is write-only */
 		return 0;
+	case ADM1266_CONFIG_OFFSET:
+		/* configuration is write-only */
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -676,6 +694,7 @@ static int adm1266_write_hex(struct adm1266_data *data,
 	u8 first_writes[7];
 	u8 byte_count;
 	u8 reg_address;
+	bool to_slaves = false;
 	int ret;
 	int i;
 
@@ -706,7 +725,10 @@ static int adm1266_write_hex(struct adm1266_data *data,
 		if (ret < 0)
 			return ret;
 
-		ret = adm1266_group_cmd(data, reg_address, write_buf, byte_count, true);
+		if (offset == ADM1266_FIRMWARE_OFFSET)
+			to_slaves = true;
+
+		ret = adm1266_group_cmd(data, reg_address, write_buf, byte_count, to_slaves);
 		if (ret < 0) {
 			dev_err(&data->client->dev, "Firmware write error: %d.", ret);
 			return ret;
@@ -731,6 +753,87 @@ static int adm1266_write_hex(struct adm1266_data *data,
 	return 0;
 }
 
+static int adm1266_verify_memory(struct adm1266_data *data)
+{
+	char cmd[2];
+	int ret;
+	int reg;
+
+	cmd[0] = 0x1;
+	cmd[1] = 0x0;
+	ret = adm1266_group_cmd(data, ADM1266_MEMORY_CRC, cmd,
+				sizeof(cmd), true);
+	if (ret < 0)
+		return ret;
+
+	/* after issuing a memory recalculate crc command, wait 1000 ms */
+	msleep(1000);
+
+	reg = pmbus_read_word_data(data->client, 0, 0xFF, ADM1266_STATUS_MFR_2);
+	if (reg < 0)
+		return reg;
+
+	if (ADM1266_MAIN_CONFIG_FAULT(reg)) {
+		dev_err(&data->client->dev, "Main memory corrupted.");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int adm1266_refresh_memory(struct adm1266_data *data)
+{
+	unsigned int timeout = 9000;
+	int ret;
+	u8 cmd[2];
+
+	cmd[0] = 0x2;
+	ret = adm1266_group_cmd(data, ADM1266_REFRESH_FLASH, cmd, 1, true);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Could not refresh flash.");
+		return ret;
+	}
+
+	/* after issuing a refresh flash command, wait 9000 ms */
+	msleep(9000);
+
+	do {
+		msleep(1000);
+		timeout -= 1000;
+
+		ret = pmbus_read_byte_data(data->client, 0, ADM1266_STATUS_MFR);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Could not read status.");
+			return ret;
+		}
+
+	} while (ADM1266_RUNNING_REFRESH(ret) && timeout > 0);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	cmd[0] = 0x1;
+	cmd[1] = 0x0;
+	ret = adm1266_group_cmd(data, ADM1266_MEMORY_CRC, cmd,
+				sizeof(cmd), true);
+	if (ret < 0)
+		return ret;
+
+	/* after issuing a memory recalculate crc command, wait 1000 ms */
+	msleep(1000);
+
+	ret = pmbus_read_byte_data(data->client, 0, ADM1266_STATUS_MFR);
+	if (ret < 0)
+		return ret;
+
+	if (ADM1266_ALL_CRC_FAULT(ret)) {
+		dev_err(&data->client->dev, "CRC checks failed.");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int adm1266_program_firmware(struct adm1266_data *data)
 {
 	u8 write_data[3];
@@ -783,6 +886,77 @@ static int adm1266_program_firmware(struct adm1266_data *data)
 	return ret;
 }
 
+static int adm1266_program_config(struct adm1266_data *data)
+{
+	u8 cmd[2];
+	u8 value;
+	int ret;
+
+	value = ADM1266_GO_COMMAND_STOP | ADM1266_GO_COMMAND_SEQ_RES;
+	ret = pmbus_write_word_data(data->client, 0, ADM1266_GO_COMMAND, value);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Could not stop sequence.");
+		return ret;
+	}
+
+	/* after issuing a stop command, wait 100 ms */
+	msleep(100);
+
+	ret = adm1266_unlock_all_dev(data);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Could not unlock dev.");
+		goto lock_all_devices;
+	}
+
+	value = 0;
+	ret = i2c_smbus_write_block_data(data->client, ADM1266_SWITCH_MEMORY, 1, &value);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Could not switch to main mem.");
+		goto lock_all_devices;
+	}
+
+	/* after issuing a SWITCH_MEMORY command, wait 1000 ms */
+	msleep(1000);
+
+	ret = adm1266_write_hex(data, ADM1266_CONFIG_OFFSET, ADM1266_CONFIG_SIZE);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Could not write configuration.");
+		goto lock_all_devices;
+	}
+
+	ret = pmbus_write_byte(data->client, 0, ADM1266_STORE_USER_ALL);
+	if (ret < 0)
+		return ret;
+
+	/* after issuing a STORE_USER_ALL command, wait 300 ms */
+	msleep(300);
+
+	if (!data->master_dev)
+		goto lock_all_devices;
+
+	ret = adm1266_verify_memory(data);
+	if (ret < 0)
+		goto lock_all_devices;
+
+	cmd[0] = 0;
+	cmd[1] = 0;
+	ret = adm1266_group_cmd(data, ADM1266_GO_COMMAND, cmd, sizeof(cmd), true);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Could not restart sequence.");
+		goto lock_all_devices;
+	}
+
+	/* after issuing a restart sequence command, wait 350 ms */
+	msleep(350);
+
+	ret = adm1266_refresh_memory(data);
+
+lock_all_devices:
+	adm1266_lock_all_dev(data);
+
+	return ret;
+}
+
 /* check if firmware/config write has ended */
 static bool adm1266_check_ending(struct adm1266_data *data, unsigned int offset,
 				 unsigned int size)
@@ -824,6 +998,9 @@ static int adm1266_write_mem_cell(struct adm1266_data *data,
 
 		program_func = &adm1266_program_firmware;
 		break;
+	case ADM1266_CONFIG_OFFSET:
+		program_func = &adm1266_program_config;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1

