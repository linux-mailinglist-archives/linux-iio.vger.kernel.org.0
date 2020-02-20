Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176581661CF
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 17:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgBTQGp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 11:06:45 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:22612 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728574AbgBTQGo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 11:06:44 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KG6fhG014203;
        Thu, 20 Feb 2020 08:06:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=QydfXrWT68EmbxqTQ4ELAZRRO2h6JSEwP4W36aO+8us=;
 b=VvkZhT7Ned2FduwCD5Qr0CdrYNDqvcZghkffFzJBN7jr5sS2IirY4hIJnLfZAofCHfss
 99lP/5OPcst5sncN6Bk6CABEnc5olaTCzDrKsAgbCWYjQiFGV5oEaPVOaax9sKi0pHOB
 47EKqAYRk8T89JXR+8pRTKQLGSUONqX/k2w4Og7bAP7eo8pvWdUmf0fcnrLsHKS5AMNI
 oc6O1fw4zq/TBn4LUkUcBEJgRVl/O6X2821pig/btf5dApZqCx+NGF0+9J9R7MihpaTP
 EWpkAWTLv7KqEnJKfp81HT0slf3RxzjP1Bm9SDz0EJjBQZAGT+N5PiM4KsgCQRryADiM 0A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc90thr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 08:06:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E36Xe8fi0ayGIs/bmlP7ftZXUlQKjAmDy1UKoed65d8MYsccbwsHMBVKCt7rJuHFYv6k3e3bI3CYlcmBjGe2YnBnRrdE2+SiL5yV5fQFt3WOVOFjJJLiV7socVYrEiB2ImnoX1G6LXNIgwMtlDDuE/91SkTtrgjjqfVF605L8lrPZOtcSfCXaHSYxrbwHvG7JFXIfhiKUDl/a2dhEzN1hc7E6KISZLhBfqwjKBqYfZRq9entpVMmYUP4uNO9Qwa3tB7OqjDoYCYyX8yIEe5v2Zt46Su3Trsg1B73gL2/JQIyrdH2HxSHPa7NfS2HvTYxvEKZ9iEUO+5+WjIJKZbH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QydfXrWT68EmbxqTQ4ELAZRRO2h6JSEwP4W36aO+8us=;
 b=gSTvz63hLPkKdcqsobaH0ZEoAEwuTos4dmB2kdc75dmSSFOgKK6jcVrwcHmJiR7q05vrr/wWhW0bbHXahcWjomn6nVjsUb1DKdIIH50wCUecOmX2hMKyPFlnD9BiLQEOa9hmwVknejfjoA/t7aiaIkV3npSYsQ8Ky1gU194yirOT30rMQzBMwixG7M9HXqtzOzcLtDXneozHzUNAddDTwobLkp2gCfUmkw4ueOFgaeEUPmBg4sjqv5tNAD75igXg8DzI+W9BN4L8aHYCdpifu3qt/ctbzYn/QEhbvL/M8fxMAPwE2VGAUoswVzZ/8atBeeEtJCQ63vueWC152UCQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QydfXrWT68EmbxqTQ4ELAZRRO2h6JSEwP4W36aO+8us=;
 b=ahp310GFOBZhwBgMNjvP2CV4g3pCsscLLQhmNbogYQcgDmlEE0Qu1wGerWDOETbZabkaEpnt1xGzFPtK8ObhpbPUlZ35BJhTI5p9Juqg8V9d7tugsedVQXqbi97RkqDBQaoqdAyRD62ps+6d0KydSxjNh/LfGianR786H+ZhhqE=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 20 Feb 2020 16:06:37 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 16:06:36 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH] iio: pressure: icp10100: add driver for InvenSense ICP-101xx
Date:   Thu, 20 Feb 2020 17:05:50 +0100
Message-Id: <20200220160550.30497-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0321.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::21) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0321.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 16:06:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5071fcf5-2a75-44c0-42e7-08d7b61edcd7
X-MS-TrafficTypeDiagnostic: CH2PR12MB3672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3672EDA993E3E149EE135DFFC4130@CH2PR12MB3672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(966005)(36756003)(86362001)(81166006)(2616005)(30864003)(8676002)(66476007)(5660300002)(66946007)(81156014)(478600001)(66556008)(8936002)(956004)(186003)(316002)(6486002)(6666004)(7696005)(16526019)(1076003)(107886003)(26005)(4326008)(52116002)(2906002)(15398625002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3672;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vU/N2dVDxpS2OKxJid357oTg9aYv3E7HAW1cb6IQr35Vl1mBJcSSvIgvTOAL+iL+0gxVKKq6psrdXq7bqxVQxU2pJ1zUtkAx+d7VDzivCxCxJfEQ+pcDNdHQaYsB//ybJBXyJ4Uv5LUM7CqnVQge1Rj+j1bSNsldm9BJxw2TO/ZwZTMERD7A3iAvoVyjxcHRcXpXd4WQoZdyMQ24pctm8nsSTdaTbjyE/1niM0DY/IQXPIz6B45r436EMSY3qgwGszBsqEFuYxkHWg80BOcjGm1BoCqqqhc3QUsIign/qI9AKGiKWxSlnXDGSmMkqDzOEwp2lKlKazDUlSZSGCewI0L4xoLmopi/u5e2eA4WqmStN+N2MKCmdTo4UtIJj85WJdAoUBxwtWd4OhRCzIPCq06qxb7hAyURch1SfSqc/Ki4WlTS80EA0iHf3D8+xrwLf+BHWzc5fZ6zR+hLSCuCs8uc7SHCAlOiSJP2IhuHcr9oKaBgyVxfxfWmZQh3xeeHSxnNyB+PfCpJPf5E/wXYed6zaPSkDfgiyRccXmlEYIo5mU390nLEhv7QiHghG9W7E0PNyioGDsnQYFYkgZDGgw==
X-MS-Exchange-AntiSpam-MessageData: iNTDzg2fHX/Hdjtmrx/D/0XtKUqThLeqhAJYSEgwSEKqvJchj1BUV7QPiChoMqZvU82PSuzUZXkkJ64IwgEbaomlXGcDIz4zzn+A60oMyxe2vyHHQsysfvwszRLx5OCTqul18e4XlNUT+2od3Jitxw==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5071fcf5-2a75-44c0-42e7-08d7b61edcd7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 16:06:36.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOBTGs7HmzJVYKwk8VNMWBXtG2Kh/Wiqfa0znbCudUWzzkcwycdT7ucoXRnF8v+q8DR2iotR5y/skR88pA4S9NyQByPLPE3IWlNFUE3D9vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3672
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

InvenSense ICP-101xx sensors are a family of barometric pressure
and temperature sensor.

These devices are i2c only and use a specific protocol of
commands/responses. Data transfer is secured by using crc8.

Driver provides processed pressure data and temperature raw data.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/pressure/Kconfig    |  11 +
 drivers/iio/pressure/Makefile   |   1 +
 drivers/iio/pressure/icp10100.c | 667 ++++++++++++++++++++++++++++++++
 3 files changed, 679 insertions(+)
 create mode 100644 drivers/iio/pressure/icp10100.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 9c2d9bf8f100..689b978db4f9 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -101,6 +101,17 @@ config HP03
 	  To compile this driver as a module, choose M here: the module
 	  will be called hp03.
 
+config ICP10100
+	tristate "InvenSense ICP-101xx pressure and temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say yes here to build support for InvenSense ICP-101xx barometric
+	  pressure and temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called icp10100.
+
 config MPL115
 	tristate
 
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 5a79192d8cb5..083ae87ff48f 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_DPS310) += dps310.o
 obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
+obj-$(CONFIG_ICP10100) += icp10100.o
 obj-$(CONFIG_MPL115) += mpl115.o
 obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
 obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
new file mode 100644
index 000000000000..78eb9f416157
--- /dev/null
+++ b/drivers/iio/pressure/icp10100.c
@@ -0,0 +1,667 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 InvenSense, Inc.
+ *
+ * Driver for InvenSense ICP-1010xx barometric pressure and temperature sensor.
+ *
+ * Datasheet:
+ * http://www.invensense.com/wp-content/uploads/2018/01/DS-000186-ICP-101xx-v1.2.pdf
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/pm_runtime.h>
+#include <linux/crc8.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+
+#define ICP10100_ID_REG_GET(_reg)	((_reg) & 0x003F)
+#define ICP10100_ID_REG			0x08
+#define ICP10100_RESPONSE_WORD_LENGTH	3
+#define ICP10100_CRC8_WORD_LENGTH	2
+#define ICP10100_CRC8_POLYNOMIAL	0x31
+#define ICP10100_CRC8_INIT		0xFF
+
+enum icp10100_chip {
+	ICP10100,
+};
+
+enum icp10100_mode {
+	ICP10100_MODE_LP,	/* Low power mode: 1x sampling */
+	ICP10100_MODE_N,	/* Normal mode: 2x sampling */
+	ICP10100_MODE_LN,	/* Low noise mode: 4x sampling */
+	ICP10100_MODE_ULN,	/* Ultra low noise mode: 8x sampling */
+	ICP10100_MODE_NB,
+};
+
+struct icp10100_state {
+	struct mutex lock;
+	struct i2c_client *client;
+	struct regulator *vdd;
+	enum icp10100_chip chip;
+	enum icp10100_mode mode;
+	int16_t cal[4];
+};
+
+struct icp10100_command {
+	__be16 cmd;
+	unsigned long wait_us;
+	unsigned long wait_max_us;
+	size_t response_word_nb;
+};
+
+static const struct icp10100_command icp10100_cmd_soft_reset = {
+	.cmd = cpu_to_be16(0x805D),
+	.wait_us = 170,
+	.wait_max_us = 200,
+	.response_word_nb = 0,
+};
+static const struct icp10100_command icp10100_cmd_read_id = {
+	.cmd = cpu_to_be16(0xEFC8),
+	.wait_us = 0,
+	.response_word_nb = 1,
+};
+static const struct icp10100_command icp10100_cmd_read_otp = {
+	.cmd = cpu_to_be16(0xC7F7),
+	.wait_us = 0,
+	.response_word_nb = 1,
+};
+static const struct icp10100_command icp10100_cmd_measure[] = {
+	[ICP10100_MODE_LP] = {
+		.cmd = cpu_to_be16(0x401A),
+		.wait_us = 1800,
+		.wait_max_us = 2000,
+		.response_word_nb = 3,
+	},
+	[ICP10100_MODE_N] = {
+		.cmd = cpu_to_be16(0x48A3),
+		.wait_us = 6300,
+		.wait_max_us = 6500,
+		.response_word_nb = 3,
+	},
+	[ICP10100_MODE_LN] = {
+		.cmd = cpu_to_be16(0x5059),
+		.wait_us = 23800,
+		.wait_max_us = 24000,
+		.response_word_nb = 3,
+	},
+	[ICP10100_MODE_ULN] = {
+		.cmd = cpu_to_be16(0x58E0),
+		.wait_us = 94500,
+		.wait_max_us = 94700,
+		.response_word_nb = 3,
+	},
+};
+
+static const uint8_t icp10100_switch_mode_otp[] =
+	{0xC5, 0x95, 0x00, 0x66, 0x9c};
+
+DECLARE_CRC8_TABLE(icp10100_crc8_table);
+
+static inline int icp10100_i2c_xfer(struct i2c_adapter *adap,
+				    struct i2c_msg *msgs, int num)
+{
+	int ret;
+
+	ret = i2c_transfer(adap, msgs, num);
+	if (ret < 0)
+		return ret;
+
+	if (ret == num)
+		ret = 0;
+	else
+		ret = -EIO;
+
+	return ret;
+}
+
+static int icp10100_send_cmd(struct icp10100_state *st,
+			     const struct icp10100_command *cmd,
+			     __be16 *buf, size_t buf_len)
+{
+	size_t size = cmd->response_word_nb * ICP10100_RESPONSE_WORD_LENGTH;
+	uint8_t data[16];
+	uint8_t *ptr;
+	uint8_t *buf_ptr = (uint8_t *)buf;
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = st->client->addr,
+			.flags = 0,
+			.len = 2,
+			.buf = (uint8_t *)&cmd->cmd,
+		}, {
+			.addr = st->client->addr,
+			.flags = I2C_M_RD,
+			.len = size,
+			.buf = data,
+		},
+	};
+	uint8_t crc;
+	unsigned int i;
+	int ret;
+
+	if (size > sizeof(data))
+		return -EINVAL;
+
+	if (cmd->response_word_nb > 0 &&
+			(buf == NULL || buf_len < (cmd->response_word_nb * 2)))
+		return -EINVAL;
+
+	dev_dbg(&st->client->dev, "sending cmd %#x\n", be16_to_cpu(cmd->cmd));
+
+	if (cmd->response_word_nb > 0 && cmd->wait_us == 0) {
+		/* direct command-response without waiting */
+		ret = icp10100_i2c_xfer(st->client->adapter, msgs,
+					ARRAY_SIZE(msgs));
+		if (ret)
+			return ret;
+	} else {
+		/* transfer command write */
+		ret = icp10100_i2c_xfer(st->client->adapter, &msgs[0], 1);
+		if (ret)
+			return ret;
+		if (cmd->wait_us > 0)
+			usleep_range(cmd->wait_us, cmd->wait_max_us);
+		/* transfer response read if needed */
+		if (cmd->response_word_nb > 0) {
+			ret = icp10100_i2c_xfer(st->client->adapter, &msgs[1], 1);
+			if (ret)
+				return ret;
+		} else {
+			return 0;
+		}
+	}
+
+	/* process read words with crc checking */
+	for (i = 0; i < cmd->response_word_nb; ++i) {
+		ptr = &data[i * ICP10100_RESPONSE_WORD_LENGTH];
+		crc = crc8(icp10100_crc8_table, ptr, ICP10100_CRC8_WORD_LENGTH,
+			   ICP10100_CRC8_INIT);
+		if (crc != ptr[ICP10100_CRC8_WORD_LENGTH]) {
+			dev_err(&st->client->dev, "crc error recv=%#x calc=%#x\n",
+				ptr[ICP10100_CRC8_WORD_LENGTH], crc);
+			return -EIO;
+		}
+		*buf_ptr++ = ptr[0];
+		*buf_ptr++ = ptr[1];
+	}
+
+	return 0;
+}
+
+static int icp10100_read_cal_otp(struct icp10100_state *st)
+{
+	__be16 val;
+	int i;
+	int ret;
+
+	/* switch into OTP read mode */
+	ret = i2c_master_send(st->client, icp10100_switch_mode_otp,
+			      ARRAY_SIZE(icp10100_switch_mode_otp));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(icp10100_switch_mode_otp))
+		return -EIO;
+
+	/* read 4 calibration values */
+	for (i = 0; i < 4; ++i) {
+		ret = icp10100_send_cmd(st, &icp10100_cmd_read_otp,
+					&val, sizeof(val));
+		if (ret)
+			return ret;
+		st->cal[i] = be16_to_cpu(val);
+		dev_dbg(&st->client->dev, "cal[%d] = %d\n", i, st->cal[i]);
+	}
+
+	return 0;
+}
+
+static int icp10100_init_chip(struct icp10100_state *st)
+{
+	__be16 val;
+	uint16_t id;
+	int ret;
+
+	/* read and check id */
+	ret = icp10100_send_cmd(st, &icp10100_cmd_read_id, &val, sizeof(val));
+	if (ret)
+		return ret;
+	id = ICP10100_ID_REG_GET(be16_to_cpu(val));
+	if (id != ICP10100_ID_REG) {
+		dev_err(&st->client->dev, "invalid id %#x\n", id);
+		return -ENODEV;
+	}
+
+	/* read calibration data from OTP */
+	ret = icp10100_read_cal_otp(st);
+	if (ret)
+		return ret;
+
+	/* reset chip */
+	ret = icp10100_send_cmd(st, &icp10100_cmd_soft_reset, NULL, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int icp10100_get_measures(struct icp10100_state *st,
+				uint32_t *pressure, uint16_t *temperature)
+{
+	const struct icp10100_command *cmd;
+	__be16 measures[3];
+	int ret;
+
+	pm_runtime_get_sync(&st->client->dev);
+
+	mutex_lock(&st->lock);
+	cmd = &icp10100_cmd_measure[st->mode];
+	ret = icp10100_send_cmd(st, cmd, measures, sizeof(measures));
+	mutex_unlock(&st->lock);
+	if (ret)
+		goto error_measure;
+
+	*pressure = (be16_to_cpu(measures[0]) << 8) |
+			(be16_to_cpu(measures[1]) >> 8);
+	*temperature = be16_to_cpu(measures[2]);
+
+	pm_runtime_mark_last_busy(&st->client->dev);
+error_measure:
+	pm_runtime_put_autosuspend(&st->client->dev);
+	return ret;
+}
+
+static uint32_t icp10100_get_pressure(struct icp10100_state *st,
+				      uint32_t raw_pressure, uint16_t raw_temp)
+{
+	static int32_t p_calib[] = {45000, 80000, 105000};
+	static int32_t lut_lower = 3670016;
+	static int32_t lut_upper = 12058624;
+	static int32_t inv_quadr_factor = 16777216;
+	static int32_t offset_factor = 2048;
+	int64_t val1, val2;
+	int32_t p_lut[3];
+	int32_t t, t_square;
+	int64_t a, b, c;
+	uint32_t pressure_mPa;
+
+	dev_dbg(&st->client->dev, "raw: pressure = %u, temp = %u\n",
+		raw_pressure, raw_temp);
+
+	/* compute p_lut values */
+	t = (int32_t)raw_temp - 32768;
+	t_square = t * t;
+	val1 = (int64_t)st->cal[0] * (int64_t)t_square;
+	p_lut[0] = lut_lower + (int32_t)div_s64(val1, inv_quadr_factor);
+	val1 = (int64_t)st->cal[1] * (int64_t)t_square;
+	p_lut[1] = offset_factor * st->cal[3] +
+			(int32_t)div_s64(val1, inv_quadr_factor);
+	val1 = (int64_t)st->cal[2] * (int64_t)t_square;
+	p_lut[2] = lut_upper + (int32_t)div_s64(val1, inv_quadr_factor);
+	dev_dbg(&st->client->dev, "p_lut = [%d, %d, %d]\n",
+		p_lut[0], p_lut[1], p_lut[2]);
+
+	/* compute a, b, c factors */
+	val1 = (int64_t)p_lut[0] * (int64_t)p_lut[1] *
+			(int64_t)(p_calib[0] - p_calib[1]) +
+		(int64_t)p_lut[1] * (int64_t)p_lut[2] *
+			(int64_t)(p_calib[1] - p_calib[2]) +
+		(int64_t)p_lut[2] * (int64_t)p_lut[0] *
+			(int64_t)(p_calib[2] - p_calib[0]);
+	val2 = (int64_t)p_lut[2] * (int64_t)(p_calib[0] - p_calib[1]) +
+		(int64_t)p_lut[0] * (int64_t)(p_calib[1] - p_calib[2]) +
+		(int64_t)p_lut[1] * (int64_t)(p_calib[2] - p_calib[0]);
+	c = div64_s64(val1, val2);
+	dev_dbg(&st->client->dev, "val1 = %lld, val2 = %lld, c = %lld\n",
+		val1, val2, c);
+	val1 = (int64_t)p_calib[0] * (int64_t)p_lut[0] -
+		(int64_t)p_calib[1] * (int64_t)p_lut[1] -
+		(int64_t)(p_calib[1] - p_calib[0]) * c;
+	val2 = (int64_t)p_lut[0] - (int64_t)p_lut[1];
+	a = div64_s64(val1, val2);
+	dev_dbg(&st->client->dev, "val1 = %lld, val2 = %lld, a = %lld\n",
+		val1, val2, a);
+	b = ((int64_t)p_calib[0] - a) * ((int64_t)p_lut[0] + c);
+	dev_dbg(&st->client->dev, "b = %lld\n", b);
+
+	/*
+	 * pressure_Pa = a + (b / (c + raw_pressure))
+	 * pressure_mPa = 1000 * pressure_Pa
+	 */
+	pressure_mPa = 1000LL * a + div64_s64(1000LL * b, c + raw_pressure);
+
+	return pressure_mPa;
+}
+
+static int icp10100_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct icp10100_state *st = iio_priv(indio_dev);
+	uint32_t raw_pressure;
+	uint16_t raw_temp;
+	uint32_t pressure_mPa;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = icp10100_get_measures(st, &raw_pressure, &raw_temp);
+		if (ret)
+			goto out_info_proc;
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			pressure_mPa = icp10100_get_pressure(st, raw_pressure,
+							     raw_temp);
+			/* mPa to kPa */
+			*val = pressure_mPa / 1000000;
+			*val2 = pressure_mPa % 1000000;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		case IIO_TEMP:
+			*val = raw_temp;
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		};
+out_info_proc:
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/* 1000 * 175°C / 65536 in m°C */
+			*val = 2;
+			*val2 = 670288;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/* 1000 * -45°C in m°C */
+			*val = -45000;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		mutex_lock(&st->lock);
+		*val = 1 << st->mode;
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int icp10100_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	static int oversamplings[] = {1, 2, 4, 8};
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = oversamplings;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(oversamplings);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int icp10100_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct icp10100_state *st = iio_priv(indio_dev);
+	unsigned int mode;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		/* oversampling is always positive and a power of 2 */
+		if (val <= 0 || !is_power_of_2(val))
+			return -EINVAL;
+		mode = ilog2(val);
+		if (mode >= ICP10100_MODE_NB)
+			return -EINVAL;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		mutex_lock(&st->lock);
+		st->mode = mode;
+		mutex_unlock(&st->lock);
+		iio_device_release_direct_mode(indio_dev);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int icp10100_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info icp10100_info = {
+	.read_raw = icp10100_read_raw,
+	.read_avail = icp10100_read_avail,
+	.write_raw = icp10100_write_raw,
+	.write_raw_get_fmt = icp10100_write_raw_get_fmt,
+};
+
+static const struct iio_chan_spec icp10100_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	}, {
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_all =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	},
+};
+
+static int icp10100_enable_regulator(struct icp10100_state *st)
+{
+	int ret;
+
+	ret = regulator_enable(st->vdd);
+	if (ret)
+		return ret;
+	msleep(100);
+
+	return 0;
+}
+
+static void icp10100_disable_regulator_action(void *data)
+{
+	struct icp10100_state *st = data;
+	int ret;
+
+	ret = regulator_disable(st->vdd);
+	if (ret)
+		dev_err(&st->client->dev, "error %d disabling vdd\n", ret);
+}
+
+static void icp10100_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_put_sync_suspend(dev);
+	pm_runtime_disable(dev);
+}
+
+static int icp10100_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	const void *match;
+	enum icp10100_chip chip;
+	const char *name;
+	struct iio_dev *indio_dev;
+	struct icp10100_state *st;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "plain i2c transactions not supported\n");
+		return -ENODEV;
+	}
+
+	match = device_get_match_data(&client->dev);
+	if (match) {
+		chip = (enum icp10100_chip)match;
+		name = client->name;
+	} else if (id) {
+		chip = (enum icp10100_chip)id->driver_data;
+		name = id->name;
+	} else {
+		return -ENOSYS;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	i2c_set_clientdata(client, indio_dev);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = icp10100_channels;
+	indio_dev->num_channels = ARRAY_SIZE(icp10100_channels);
+	indio_dev->info = &icp10100_info;
+
+	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
+	st->client = client;
+	st->chip = chip;
+	st->mode = ICP10100_MODE_N;
+
+	st->vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(st->vdd))
+		return PTR_ERR(st->vdd);
+	ret = icp10100_enable_regulator(st);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(&client->dev,
+				       icp10100_disable_regulator_action, st);
+	if (ret)
+		return ret;
+
+	/* has to be done before the first i2c communication */
+	crc8_populate_msb(icp10100_crc8_table, ICP10100_CRC8_POLYNOMIAL);
+
+	ret = icp10100_init_chip(st);
+	if (ret) {
+		dev_err(&client->dev, "init chip error %d\n", ret);
+		return ret;
+	}
+
+	/* enable runtime pm with autosuspend delay of 2s */
+	pm_runtime_get_noresume(&client->dev);
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, 2000);
+	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_put(&client->dev);
+	ret = devm_add_action_or_reset(&client->dev, icp10100_pm_disable,
+				       &client->dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int __maybe_unused icp10100_suspend(struct device *dev)
+{
+	struct icp10100_state *st = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regulator_disable(st->vdd);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __maybe_unused icp10100_resume(struct device *dev)
+{
+	struct icp10100_state *st = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = icp10100_enable_regulator(st);
+	if (ret)
+		goto out_unlock;
+
+	/* reset chip */
+	ret = icp10100_send_cmd(st, &icp10100_cmd_soft_reset, NULL, 0);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static UNIVERSAL_DEV_PM_OPS(icp10100_pm, icp10100_suspend, icp10100_resume,
+			    NULL);
+
+static const struct of_device_id icp10100_of_match[] = {
+	{
+		.compatible = "invensense,icp10100",
+		.data = (void *)ICP10100,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, icp10100_of_match);
+
+static const struct i2c_device_id icp10100_id[] = {
+	{ "icp10100", ICP10100 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, icp10100_id);
+
+static struct i2c_driver icp10100_driver = {
+	.driver = {
+		.name = "icp10100",
+		.pm = &icp10100_pm,
+		.of_match_table = of_match_ptr(icp10100_of_match),
+	},
+	.probe = icp10100_probe,
+	.id_table = icp10100_id,
+};
+module_i2c_driver(icp10100_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense icp10100 driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

