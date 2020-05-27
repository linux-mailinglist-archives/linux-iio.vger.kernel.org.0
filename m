Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C001E4DB6
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgE0S5t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:57:49 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:63822 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728688AbgE0S5s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:48 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIrkEZ004853;
        Wed, 27 May 2020 11:57:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=WK4TDCzZOsrntsfYcwaHyNoddDlfdy1iYNKJVad9LPaJfCjGzGzZ2gXDVMu3jGnjSFaS
 JVgCYaI7+fTBh1k6mMxwo63rvXz2RudPiIk7kLljBJzx178K1LGADTq+JcZ33lFU8vZY
 KAisO+Un954x1DMnN5ZGMDNSJuat7nHtsbGxJyvdBpGzdQNfGZUXkIASdoxIIL13m2I1
 Xwav+/U3Qmm3adOYL2bvJQHWv3fOyRO1R0XlyXvB3KGIzx1rXj/45pluG9E32GKPP9Ch
 GrlHhI4y/w5yxNlP20+DzbjQA4CK/6ENhQjcS8xfAp1kC0kKYKoCsLaovirpy4kFmzTh yQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap9ewr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGvUHfxtGnJVrP7K0yl+WEM8CNcwAQNuxDHkpDMjgUH4+VW/5+CrNvpEakBYKS58kpXoaft5rLhQSHdZlmL5HiYkS6aYZV2WSfQZeKGYp/E41xAiA9XYL03BPP2+deVv/npBFjn5MFOkuzDH2LFue+s5Ek7E7kyl75wKSyGWZpNWVocj8/8wd0cQNIF5hdGN68omaNstlSTh135/pMN1MDqhp7UfbT+FlYgWcRx5KNcw3JXLQqdlrQBBDAYbzrKqpShO8+noZVAfCUjrURi8hrnvgbz43uXaG7hTHOC5Mm01Pk+FGcM/6BdFAbRg0icdvwxGqBJN3RLT8KI3n1+/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=cd36Whtf4j+GMlFURrCXZocFxh1RANA/mHSmt3WZbV6XNFDysG/s3OdTE2sDELW5gKz58R0XZa48+bZ2XT6zQwMsLXaKp52jjOz4cLKNOa0fX0qJcWZG6nOvJ9VzsBIhIq8WRsfjQ94+BtU5pKXGa8Tums1oFQIoMfaI405e40XIQI2lO/TrNdAD/pp/6eNdagXRjsKwwhontfMrbcJK/PfCFQyAUkinpZbwoTjMVro4BE2ZdBICMkIVFY/P2OigK+9H1lGflsb7SzyBsR0dV84YluB+cteWt5NhviWLaE+DDKr91/THTts0pE7DF5+IC+O3rA5a1VhoHFOrxiFFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=BIjcGFdTT7LBQ+8kLlsU8zZHhg/BvNlPUwZmwg3IWt3HwAQRgHk0BjHDG62syBvjH5daL6jrsQLlZ0OyOOMhhvIKpxMdhKqcu/GSxATcWTNc4gzMXXPRdguaXj/xjUCJ8uF/9OAc1WEAeoaL8T1PNX9HwZbdBBD3m0xRjNbjNvk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 18:57:42 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:42 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 02/12] iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
Date:   Wed, 27 May 2020 20:57:01 +0200
Message-Id: <20200527185711.21331-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:41 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a035ee2-2271-4424-1696-08d8026fd5b3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3151F3DAFA54CEB34B6E0AA6C4B10@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC1c5wmMFgrDp6vhwIh7FeTHIwDmt41usP4P8JE8/ySbz1myNDVo2Lgt4ATLi8gff4XE8dWAptBZROSznaCCBYr2koDXoc4sBfxiBI1mF3jJq0WFmmPE/TLCjENcuGnOPlvadNSgRWJSS6OUh0iJbgZIVFegDK8IlFk12L03hRRNIWwb0lw/LjlwiVAKT8SlEJK4I+/3BTVjZTuRgM1Vn6aZnv6WqkvBBgJcQf/GwZUTy/bl/ziITlgdtEaroppxGOlswUnDAGDoVk1PdjbkNAgZb6t0B0R1VAWcXO6DErqsKv4AEysNdU39F5ugXjmMDe/uq8LJAb0K0d/Mm5ygoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(366004)(396003)(376002)(16526019)(478600001)(107886003)(8676002)(5660300002)(186003)(8936002)(316002)(6666004)(6486002)(1076003)(7696005)(66946007)(26005)(2616005)(956004)(2906002)(86362001)(36756003)(52116002)(4326008)(66556008)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: s/xcxLnNK3hEPKeCYCHOfxlhohNI9Aa1rSyOFpzIGXPe9jbCNvuy/lPaO+N+BpI6YxS5kl17JHsFUkIEvdeC1l1EcVArMUSGuxVhglX2+wirdDZCKavidK4BoOnGXTSTrbDeVwF9Sp+5erH6Czjnu9rGqCuow47scVa9AiZTgMKZGzZECSXFgIJNIJjvNy7/+MsalS/Lra0mubxB6B8PeaeWGd6+/BkEoZHSKr5lFvtWGVA2jro+fuRDxSK1qPtgfmfsxtlL6jlw9Sb37Bq3aC9RQnxUT/f5uS7qC0zTij9OuDDL8/47nnErCBDWRulz7TwLPxD/OxgZvTNRXqveQ/i9av346Lrh0ysDjFPriK732pxM/i/A+IZfKB7W3jd3N2g4WSIKDye8fDIU/1/TxXK/XMl1OZaoqVIbKi//LhiqGKskzrzhIjYHC7hOUF0YYxia08WCvzpIzwqvilxwTHnFHpMDLUM+Syi7skPPnIg=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a035ee2-2271-4424-1696-08d8026fd5b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:42.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmf+yvgaHVlxLmwkw6T3RJGjGJgjeZe8XHZO7Ubga0+jCPrfu8DPopEgnrZW8SrH5oHdl+gi/8O8Q3Mtete2q2e3bG645hOa4svMz5x04As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270144
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

