Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F022F4B7
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgG0QRY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 12:17:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15988 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731294AbgG0QQg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 12:16:36 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RG7xmi019091;
        Mon, 27 Jul 2020 12:16:35 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5eykp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:16:34 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06RGGXh9050439
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 12:16:33 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Jul 2020 09:16:32 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 09:16:31 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RGGShj009603;
        Mon, 27 Jul 2020 12:16:30 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v7 2/9] hwmon: pmbus: adm1266: Add Block process call
Date:   Mon, 27 Jul 2020 19:18:07 +0300
Message-ID: <20200727161814.14076-3-alexandru.tachici@analog.com>
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

PmBus devices support Block Write-Block Read Process
Call described in SMBus specification v 2.0 with the
exception that Block writes and reads are permitted to
have up 255 data bytes instead of max 32 bytes (SMBus).

This patch adds Block WR process call support for ADM1266.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/Kconfig   |  1 +
 drivers/hwmon/pmbus/adm1266.c | 73 +++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index da34083e1ffd..c04068b665e6 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -28,6 +28,7 @@ config SENSORS_PMBUS
 
 config SENSORS_ADM1266
 	tristate "Analog Devices ADM1266 Sequencer"
+	select CRC8
 	help
 	  If you say yes here you get hardware monitoring support for Analog
 	  Devices ADM1266 Cascadable Super Sequencer.
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 79e8d90886b8..63975eba34ad 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -6,6 +6,7 @@
  * Copyright 2020 Analog Devices Inc.
  */
 
+#include <linux/crc8.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -13,11 +14,80 @@
 #include "pmbus.h"
 #include <linux/slab.h>
 
+#define ADM1266_PMBUS_BLOCK_MAX		255
+
 struct adm1266_data {
 	struct pmbus_driver_info info;
 	struct i2c_client *client;
+	struct mutex buf_mutex;
+	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
 };
 
+DECLARE_CRC8_TABLE(pmbus_crc_table);
+
+/*
+ * Different from Block Read as it sends data and waits for the slave to
+ * return a value dependent on that data. The protocol is simply a Write Block
+ * followed by a Read Block without the Read-Block command field and the
+ * Write-Block STOP bit.
+ */
+static int adm1266_pmbus_block_xfer(struct adm1266_data *data, u8 cmd, u8 w_len, u8 *data_w,
+				    u8 *data_r)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = I2C_M_DMA_SAFE,
+			.buf = data->write_buf,
+			.len = w_len + 2,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD | I2C_M_DMA_SAFE,
+			.buf = data->read_buf,
+			.len = ADM1266_PMBUS_BLOCK_MAX + 2,
+		}
+	};
+	u8 addr;
+	u8 crc;
+	int ret;
+
+	mutex_lock(&data->buf_mutex);
+
+	msgs[0].buf[0] = cmd;
+	msgs[0].buf[1] = w_len;
+	memcpy(&msgs[0].buf[2], data_w, w_len);
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret != 2) {
+		if (ret >= 0)
+			ret = -EPROTO;
+		return ret;
+	}
+
+	if (client->flags & I2C_CLIENT_PEC) {
+		addr = i2c_8bit_addr_from_msg(&msgs[0]);
+		crc = crc8(pmbus_crc_table, &addr, 1, 0);
+		crc = crc8(pmbus_crc_table, msgs[0].buf,  msgs[0].len, crc);
+
+		addr = i2c_8bit_addr_from_msg(&msgs[1]);
+		crc = crc8(pmbus_crc_table, &addr, 1, crc);
+		crc = crc8(pmbus_crc_table, msgs[1].buf,  msgs[1].buf[0] + 1, crc);
+
+		if (crc != msgs[1].buf[msgs[1].buf[0] + 1])
+			return -EBADMSG;
+	}
+
+	memcpy(data_r, &msgs[1].buf[1], msgs[1].buf[0]);
+
+	ret = msgs[1].buf[0];
+	mutex_unlock(&data->buf_mutex);
+
+	return ret;
+}
+
 static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct adm1266_data *data;
@@ -33,6 +103,9 @@ static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *
 	for (i = 0; i < data->info.pages; i++)
 		data->info.func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 
+	crc8_populate_msb(pmbus_crc_table, 0x7);
+	mutex_init(&data->buf_mutex);
+
 	return pmbus_do_probe(client, id, &data->info);
 }
 
-- 
2.20.1

