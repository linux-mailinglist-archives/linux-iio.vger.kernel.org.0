Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055EA203B32
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgFVPiC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:02 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:49866 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729444AbgFVPiB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:01 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFa4C6021446;
        Mon, 22 Jun 2020 08:37:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=IxgputHStiLFZYyJ1ETCr3q7u0cHydS9FUAPyRtppueuNzekUAQAbQxIbpG4EK1hfSze
 WhXv7XcqExLO6drf8dmuh5tiw9MwDyk/Ci6P7lY4IGSnDlhDYvR6FhVa0RgYOZ6/qFpl
 cn7yP9yxML9HrrFq9cufwV3Z+akqajcETVu2g2UgDwCcXQdUopXtfZO1n6mXDGUASSEU
 rmLixXR3TGyYs7yUqXBW+suBMwQg5qkCwVH6TtXrvtTOfCaj7ee9U5YoVy9UlYN9x4y/
 r03ekWPOOJF5uEec2tkObs0iKzHJlHifHbxsIPW+oFEop9SvPD3HGQFEtyb26lumSGLt xg== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0a-00328301.pphosted.com with ESMTP id 31sdxnrtxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGWGlREWvEoqu4iGWETqWCfcJ0ynCe0Il7oE9Ne7xdNnuSolxFv/tOpKNdevnjJ2PNenLKpJf0MApShm4fpzZYKVYji6Wpq0h7UReFRtI+RWkgiLvPk54Ams9R0e9+VkqLjxGR/S6GjLLL+esFW7QpPqIb+vpVtZdc2NFzYmaV3pFFJspFgB40i68knBgjmmKb+vFlQg/VNYCctEfE5oVS8ZWKqqr5KZmR5HW1O9MVq8htF4GmchaU4VeA32hTe1NrWm/nMb0Rz2lePkZEOIKXUNUSidkpyW3n/ecRO8IT+5vt+3TEYVH/mHPSCsWbc/8pggMfcJBP0IShFzbuOG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=luPeIYeTGrEa9gfnjiNV8u1gCsHjnWlxaB3wJpfgYQpEQeuyvI/l4qk0ZTzhlATyqyC0xChOSCbEGP7C1roxdMjVYDHF/mWw8glvyq5jvDMsaGL/MPlNWKPBFy8vnbISoXv1nCStxcBdK+v2ME/T2bRUFWZM2SReIDwjV1jMaIGVdhUKAUe3l3O1H55vbofNx1QCnGFF2Npa2p68XvJ4kMypTXV9R3dN7TRE0spwHfq34W8S43rhJenbVHU0bHGBqV4QI5HAEssWX3/5a4YWuKWBMzjcdpG6HH+SlxlTpMQ1bOV7OEP8aVATBC/OQBHw9Zi+bI9hNNZ/yy2yGpoT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=bcxhBcgJHJyIoXZ0AN1kjTk+WH2NAarDMONF8h83GQkb7Xk+OosHRXG2R9oskIBr1zB503CjPl0ozEoEc5liB56x5rqN0XXoVUXO/BJ66k2gcWxvjlV/dmfp+4nSoJoeZGiHQOpfuuDdUbqlValiCs4QDeog35wgeKebjY/hJGk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:37:57 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:37:57 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 02/13] iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
Date:   Mon, 22 Jun 2020 17:37:18 +0200
Message-Id: <20200622153729.12702-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:37:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f867b15a-5430-4bab-9b4a-08d816c23cd8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45014656019A25AE9FC78E48C4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHjCUouwXIitHhhao1hW2N0gdxvjEEUXeabIcO47YrBsztHDo+olLXFjkvtp1BPqeD7FvhCyqTvM4x3NqR1UrjVVBcV+x1fDWleV3spyCRoZbuYvqQPT9wP1ls66RBGPn6EBNaBvg8reC+50WnwAAy+xMzv2cEBA9/9fDW5iBnLUFkOHweiQIMoEy7ytyTdkgl6fLkIykUjoeElkftT0Wb1ZoCTJgNkcfxRDQHMPx7wthvfl0ZlKIm4uY1BejFWjc3Q4A++pXsKp91mDjk+3blhPrKAzch158xwFQynXB7aMSAewz2A4ebnkvwWbwkCYyPhPnh0npCGy3v7mMye+sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(83380400001)(107886003)(86362001)(36756003)(478600001)(6486002)(6666004)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: K2GkLKvVi0slqp9lkmxSRQuoYfZpYLOYwhtlisWwVYc+Q5MI3mffSe8q1/wHEy6SAO4BqGC6UHSZIytsoXvdCo2kc+pBRM18nD3cJmFjdquJuP41tGZwB4S6UOv8sUteP7cd88ovfxtqsy3icQu/9vs2Phn+/GgXe60XVUsdvPvzuZ0lFum6g0zslTTE0zNTtxAduzvZorRaMad7X3nLphziBS31EW+BaM+d129+DsemtuV2WCfSMlzIGL7UHNJIpgH5p6jNRccQgyl8WzKdAZa1eweOXJw9XnCFLjb7QxxSf5xwhupTYZhBUfgCw9JbDQSjwQ1D/UuosVTv+zPIa1uop5IyIiI1Lef+oPBEH8SQUVFI3r0Zh0yL3IOyUUVK/7vy87w0yw1gN0K6JPQnQf1PBfNZKBjUbU6t42/HP+orepTMAC5O16PHETE7btITK90YLfSxy37JWPyOT/ANqvYW5e8w6umOfClN2fhujys=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f867b15a-5430-4bab-9b4a-08d816c23cd8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:37:57.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSzwqBAHZVScaeLjHd7QY1h3AFQws9YFI4o3uv6C/11PD8wqNUl03oPyyElRK+hhVq2E6zqxw70CvzRtXHB4S/G1YkTad2uBqDrmC8iUjCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 cotscore=-2147483648 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add I2C driver for InvenSense ICM-426xxx devices.

Configure bus signal slew rates as indicated in the datasheet.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
new file mode 100644
index 000000000000..4789cead23b3
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm42600.h"
+
+static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/* setup interface registers */
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
+				 INV_ICM42600_INTF_CONFIG6_MASK,
+				 INV_ICM42600_INTF_CONFIG6_I3C_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
+				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);
+	if (ret)
+		return ret;
+
+	/* set slew rates for I2C and SPI */
+	mask = INV_ICM42600_DRIVE_CONFIG_I2C_MASK |
+	       INV_ICM42600_DRIVE_CONFIG_SPI_MASK;
+	val = INV_ICM42600_DRIVE_CONFIG_I2C(INV_ICM42600_SLEW_RATE_12_36NS) |
+	      INV_ICM42600_DRIVE_CONFIG_SPI(INV_ICM42600_SLEW_RATE_12_36NS);
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_DRIVE_CONFIG,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	/* disable SPI bus */
+	return regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				  INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS);
+}
+
+static int inv_icm42600_probe(struct i2c_client *client)
+{
+	const void *match;
+	enum inv_icm42600_chip chip;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENOTSUPP;
+
+	match = device_get_match_data(&client->dev);
+	if (!match)
+		return -EINVAL;
+	chip = (enum inv_icm42600_chip)match;
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm42600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_i2c_bus_setup);
+}
+
+static const struct of_device_id inv_icm42600_of_matches[] = {
+	{
+		.compatible = "invensense,icm42600",
+		.data = (void *)INV_CHIP_ICM42600,
+	}, {
+		.compatible = "invensense,icm42602",
+		.data = (void *)INV_CHIP_ICM42602,
+	}, {
+		.compatible = "invensense,icm42605",
+		.data = (void *)INV_CHIP_ICM42605,
+	}, {
+		.compatible = "invensense,icm42622",
+		.data = (void *)INV_CHIP_ICM42622,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, inv_icm42600_of_matches);
+
+static struct i2c_driver inv_icm42600_driver = {
+	.driver = {
+		.name = "inv-icm42600-i2c",
+		.of_match_table = inv_icm42600_of_matches,
+		.pm = &inv_icm42600_pm_ops,
+	},
+	.probe_new = inv_icm42600_probe,
+};
+module_i2c_driver(inv_icm42600_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

