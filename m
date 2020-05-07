Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3516A1C9065
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEGOnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:20 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:26054 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgEGOnR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:17 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047EbhbY006057;
        Thu, 7 May 2020 07:43:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=guxiu81OBChS1YnA49t3W141td/mF6MlvFvEZ+dC/EU=;
 b=QNBRP1/HJ6qEBorQHeP2Cd3M9d0kUS3RVBUSb9rKFQPIlbwM3gP/eNehUXn42+vpDJgz
 57x5lHfgDqLWiLrd5ux2GgngejUxnmhJLKwEcZFP24QlPAgrVVRgTKSeizqUP9gaBWGj
 9mVAVNVSEaGBxzar48MawjvUjnA9a5ru4i67VnybqKrViBqSRZYaUjBbD8yPFF4XkODz
 BDP9th2LRJPC8+UhqfmzE5vLHMhd57V27WoVPpk2bxect9h2m9Mc5We4mE5vWwn8d9bO
 JfYKZPyoxZxrVNWNuQDMqrpwRx0SqLVNFln1xNr2MWYzxCVoYvP32RHfPX6DBjr1h7dL 7Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l60h+dv1xQ9W1WrwLeC3+lJDfe5IujimzJie4A7e7pQKYwFGZU5jD1ZfEoElQhBV9HHQWKAlRbZGtNSejTSKQjaZUW6+eo83jq/yNfzyXBF5c04T3/r9YQ/b8hfH9bZ5vVgvuGTHlEnnYYNuHktXXKogYVZ0I7tyxIvyvA8pC+qruF6KNqn2atbQtrCTmw6ayGDD36FqABkuq6h56t7cLAHzmuvb7qD4UqvXGoniQv5m/T1FPwFrJ2LOxZaX4o0q4sFwCyKGBHJknY9hjDin7l/eYv6MgsN2dmNBHpZF0SAcK7ejS3BVFg7ECtXRKa4SVByAR1L5ym3TZ+fsmKiMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guxiu81OBChS1YnA49t3W141td/mF6MlvFvEZ+dC/EU=;
 b=dt+Cs6TAwSVtRI9kGxPdKDzQ9fvnCRQrEKTq7mBOr+I1ulV6iK+fGtOGy8SQCixmwx0Zkya9mqy0GKsXBzJV9k7APhN+UehoTX/AyggB5RTk8cZBQzNF5rrJT54O4GWrevDOo/s5YHZZ3QwiIYrnbw3E0pA7IL99u0WP2QwJvXSlWzxELb7SgJkhU1agE45Re9Rdk9irkfnI0R4I7XubG32wiPLrL2qakPPmrGOR3mYET2gD8qBp3dRLhvmuOINwCYNuWXvqy6RJ4yzbL24UMrVyYmPrGfKHrAS69V08LUptmMDeZyE6VKzF6AfKja0XPTi0CjBLzp1/Oyx0yOgYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guxiu81OBChS1YnA49t3W141td/mF6MlvFvEZ+dC/EU=;
 b=i2ri2etEVgPEF235g1Bxw+wd/07yuSxnd8RiT8ZkbbzgKP0BC1hCPrSclennCTwR2bt6Vq4Kqkrb3xwIx8Ssdd23KCACMrZs5SdjE+N3ntOgo6s0NLiBK37L2NFQo+L1iFr7HxzSCdDfPOQHFEhl8G2Q0SwOoVR//Fur+GjeJwc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:11 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:11 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 03/12] iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
Date:   Thu,  7 May 2020 16:42:13 +0200
Message-Id: <20200507144222.20989-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f2104d-787e-4710-baa9-08d7f294f70c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4269D2B12A7C8872ABE3043CC4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPgkhNY4WewqVg9sFZUOVlKj/1ylBm22ojrhWAbIXy/NH5+Yzse8zCExFSFj/3m9xp6IeJGp8b7Unc+hFC2SWY4/PW1G1CbSQdVAnYeHsBO855tqyTmwZR5JwR0zSw1yQu/VN++WQeFqJp+66fqy6Ur/lv+Rjj42OBYWZk3BvF+MUixOQpnnuSZstFt58mfvnAbTzrDZze3/QROh1FpZO9qz5ouhs0lRcUkdpfaKe2n90HYbcOQyKL+oDFvdjEOPQoLUei7JmpbtO6qJ76gV23pCYXh9JllyAcunaEkabbi2XhX8xHC8n+wuGsCbWbPwK1r+er6Tg/tLz0pFIEB31ytB5Yjfe2AzecAvSEkvW73m+lh4Ija0Wj9C9swduVa5m2Vz5/gLinj147FKuirKf4QSCT6iYDWVH8Yw+QrWzFl8kQoM8+/03deOWDA6ASN4xzL8N0QVKzHOZs1TkU93BYB56fKKCkZeJ11USX7dEZB6jE2GP6ltXAM+kD5PbbksaeB8Fk3/QJsyqRpHxws+TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(6666004)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Dh23YC+MTF6Tmku1vAlsRo+0ppr+QYSRd2xbEKfyY5zySPkxjVKmZ+yy5oqEEom7V9pYg/VxDW8fJrbuLV3UZcWHiTxiCZ1ipAhIufl0SevlGVumJEtnZxthMGiIJxt1ArTjyNpQepFvBB+tYU8M/I03XarKICPyraulZqRX9lB7T7ogkN1iWiF6tFDuf73kZ8YtpLqURC17ZUE7GX5pAsJFIVbOvAP7t5OWtIc09FjXQwVfowUSLU/clppAp4h/hs8Qa57Y3SyUJ59na7z1j254RY3wBYaYcXnXtRJzYqlidggDwIOvk4t9BTMUFD2ykO2b6l46e2FNF7DVb1rx4BJJe6K7+z1kVd54P8+Xwun14UXyfeHy5243/zyYMYD/Q5WxkoVHl09xsuK1YrXABMYOIPBBaiRVd2UZFomDQUnFbxLFqTCM3mV7iJC0zEefXOL/xCGACpMWqObOwEByKORnC4RxnOWd3rmbJlwdfUn4/aOYpAJjfaR4mBOifrkzDju+hCiEXWgJQIhvlZIL0QCkbstywKDA2K8/EpXJo9aXsu/7myM3pa3eH4VoQiegxnwNF5alZqa8u0QmyZwA+wYu0briDmy1jw3FYM0gBjV/JoXDyidaGroHF4vrDxKq0NoIqJcizUef2JqLb7L1kaceirYN6uOK/yk3qTv2U9v6mPs1bEXUn1C7moggqZdUq8saY7nDDYATlkaamVYD8QIGV7T2Uu5w9FfpAl9kmLywuwWJuecMHCf3HsDIoH23zERZFtlgxiUGvmPahzf9nnrxFISIeDKVpC6K/AaZ+74=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f2104d-787e-4710-baa9-08d7f294f70c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:11.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFXFbrhGQxHNHQLhPG707z1e5u9yDIcoCytyVueRE3pInTWnYwU3yJTSlq+3OyZKma+RsCd6EB+nOMb1xB5T/qNNLjdEOc1jNxJdWeA+Udw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add SPI driver for InvenSense ICM-426xxx devices.

Configure bus signal slew rates as indicated in the datasheet.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
new file mode 100644
index 000000000000..835ced68a3a3
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 InvenSense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <linux/of_device.h>
+
+#include "inv_icm42600.h"
+
+static int inv_icm42600_spi_bus_setup(struct inv_icm42600_state *st)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/* setup interface registers */
+	mask = INV_ICM42600_INTF_CONFIG6_MASK;
+	val = INV_ICM42600_INTF_CONFIG6_I3C_EN |
+	      INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN |
+	      INV_ICM42600_INTF_CONFIG6_I3C_DDR_EN;
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	mask = INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY;
+	val = 0;
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	/* set slew rates for I2C and SPI */
+	mask = INV_ICM42600_DRIVE_CONFIG_I2C_MASK |
+	       INV_ICM42600_DRIVE_CONFIG_SPI_MASK;
+	val = INV_ICM42600_DRIVE_CONFIG_I2C(INV_ICM42600_SLEW_RATE_20_60NS) |
+	      INV_ICM42600_DRIVE_CONFIG_SPI(INV_ICM42600_SLEW_RATE_INF_2NS);
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_DRIVE_CONFIG,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	/* disable i2c bus */
+	mask = INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK;
+	val = INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				  mask, val);
+}
+
+static int inv_icm42600_probe(struct spi_device *spi)
+{
+	const void *match;
+	const struct spi_device_id *spi_id;
+	enum inv_icm42600_chip chip;
+	struct regmap *regmap;
+
+	match = device_get_match_data(&spi->dev);
+	spi_id = spi_get_device_id(spi);
+	if (match)
+		chip = (enum inv_icm42600_chip)match;
+	else if (spi_id)
+		chip = (enum inv_icm42600_chip)spi_id->driver_data;
+	else
+		return -EINVAL;
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm42600_core_probe(regmap, chip,
+				       inv_icm42600_spi_bus_setup);
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
+static const struct spi_device_id inv_icm42600_ids[] = {
+	{"icm42600", INV_CHIP_ICM42600},
+	{"icm42602", INV_CHIP_ICM42602},
+	{"icm42605", INV_CHIP_ICM42605},
+	{"icm42622", INV_CHIP_ICM42622},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, inv_icm42600_ids);
+
+static struct spi_driver inv_icm42600_driver = {
+	.probe = inv_icm42600_probe,
+	.id_table = inv_icm42600_ids,
+	.driver = {
+		.of_match_table = inv_icm42600_of_matches,
+		.name = "inv-icm42600-spi",
+		.pm = &inv_icm42600_pm_ops,
+	},
+};
+module_spi_driver(inv_icm42600_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-426xx SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

