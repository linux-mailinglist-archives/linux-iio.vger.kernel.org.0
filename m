Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD901E4DB2
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbgE0S6l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:58:41 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:37874 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbgE0S5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:49 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIuleM002104;
        Wed, 27 May 2020 11:57:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=YvvlvDPuqEOcfnoKR+JBXx8lTb6fUZzFGsDlxjkT09O48SrlIBpIaR5npmi8hGx2cTOs
 p7eIFeey3R2vLZCxP4ZD6cvMVwA671ddOgyzIu29Map5lT+ACsNx9bTaWi8YEjO3G2ix
 qpQkhtYK9j9HNGajjfedGIf3cGDMhM9q+9IMVbyCH47ymq5V8EM+rHAM+ShjSQ6B47I1
 f9tsl3UOn113fH4c7hJuVW79giJ/RHMAdR/10ICg2QFTi/AACI90hnQFuVreSWpJ1VxW
 rktjOqTZfHFzVD15xx0wAowYk4t2nfr7zgdIDS4LkXCiWCQWShE3xufqnDRk90viw/dO wQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-00328301.pphosted.com with ESMTP id 3194qh0ncu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtenijK6c5tNhVDGY3b+sM1PemK29VvGi12qdeZC+4uPmyT/oHCA7lWCFe/ENxKhnWCO1FIjp243+QDDFQ7rK2nV0sTplJ2wgP9KaO3nWueGxX9tNHwczNeXRHFnMIT6catNK4DqLw4MRlw6pAxHEAXgM5a5qjthaIHXTbjSFkH+nwDo+wA7EYsxiZ2NL29aL3NNLu4ooD++1tjGczrWm5bcch/w8ukk4EEqv5ylL/2k9hKKg+OgWzQ0QGPoyeo85ZQ87jUKUhEDPuUyL1RKNfEi2fjs8mz/Rm/RUM5+D+FkoyaYnPcCHRKNs2/WlanyEKrx9BEC+skmIi6ly/twEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=Z2LCg2Wgob8MW0MDi2bVcm45yysuFJjUq2QCxdGw55fvKH2HNaGLem2vbQ1mUm4E8Z8YVLeDf9mrPdLp2AzS/oP3AMwJp+UZg37XsmeRq0Yikv3RMhgHfRoODUxn85Z7ou73xpU4ruVQlX2nC2P1aC53215nBYg4cNlGZ+Tzdpqfqo+U92eMdlBD3370ZgLpNwkAYaZID3yzKQBc2Jrm72nbYTCZ5r+a5QCZaGvmhOxiolJdyQ52T9B1vJK7aPSE5Azm7tele0XPgrwZBYtkYv3KVOXMGrhK/rzohcFc2w4NTN32Y+48lJiGMVI8qxjPprH/y8fDA08EaJ1GpyZ3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=QHjJ+nvOV0MG4ri1pq8GtGNNcIRBqP+vuXxb+CyptZn5D06aAcGWMhPoUwNPfM/quFOvuRUVfnC1AGdi4C6r5fkMtfpw2sx/KpPPobWL4QQ4Y2Zv+hjfMS7TGkvZpYlpCDDk89eVy7qk7rxdOepOWTzin1p/yyRR0Zip1fiw6r8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 18:57:44 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:44 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 03/12] iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
Date:   Wed, 27 May 2020 20:57:02 +0200
Message-Id: <20200527185711.21331-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a7b59a-6f41-4ba4-27b6-08d8026fd6b3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31519790C3CC2647EF8D25EAC4B10@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enApABTu42rpM4auQ1E0kni36Xv5KY3H/rg4t6FssbzR9de7ZJC+X51T+3KOmCDi58ly5IJwwRLpUOGx1pvJFOD+Q+4G9DQ1iqzRRWlleM77zyM6QlDicoJip1QV6w1+kCc2gVzY+P+qEkDnPaVrUdhStMEUg+9Vit57buRYfP2dBr3bNaDmkOWq5/geWNhjk6E9hR0NIYyKJYqoNx8bPHUsfjjuRdiuX3IA7qLBpcxBjeVha17Jp98PuN4AgALmsx/uEn7hKITvxwLo9x9nAnnHD/GXK15Mrl7nG8T/80/x9pLMQWrPUicURFrsZ2CJEViw3HOA5OkjemtoOiTMPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(366004)(396003)(376002)(16526019)(478600001)(107886003)(8676002)(5660300002)(186003)(8936002)(316002)(6666004)(6486002)(1076003)(7696005)(66946007)(26005)(2616005)(956004)(2906002)(86362001)(36756003)(52116002)(4326008)(66556008)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tpEwwT56x3GERKw4gg6bOrmYV2TMKjkXwBnyWn3TTXLaHefKhLCZ7WTBn71HzUiTanMLN0o6P8AxDFs0hhDVKa34JsWBFll+k9ZlETxjPSgcVgBtceK/teZNv+tUcPB+MssxPda0d/jddqGW2DokQgvT9Ask8FWJWYuUgMj2CO6IszcWdj+fhWViEsq4S8sul69kR0kiyfaFHuQpznhSPuDqKzBxmpTmu4U9ZiFlUjgIjTbEZIJEznpNyrrN6vIy6D0V5eWkks01FqgnFG4qpZeInz3e7Ter6WZXy4kgzxExq+65fDirdrmkuZX6SxfgdfPA1ztfnwgxXXMwR43wyqLJ9qEl6+SBQFDgDvxpUnS1+JYviBjvVO5LR0eWRqkIL0eeEZ0nG9cW4kxkw4A6pTnIq7Me2KCcRZ38L5kHBj+ECJxv+GcOzRC1XOho1SByN6bJDvClULRXoyN5KPOO/uKI6plBWeDMKc5iDW2o4fQ=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7b59a-6f41-4ba4-27b6-08d8026fd6b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:44.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRJUQbtM9D6f7KeU0H84DimWxvP8og+xYvpNRXg76MGMs5rOpBBLFi4cG62RmPCfYODavp8BqIOobO4FW/QXkOvZ1lAl3l3vQXfW/UnKG2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 cotscore=-2147483648 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add SPI driver for InvenSense ICM-426xxx devices.

Configure bus signal slew rates as indicated in the datasheet.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
new file mode 100644
index 000000000000..a9c5e2fdbe2a
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm42600.h"
+
+static int inv_icm42600_spi_bus_setup(struct inv_icm42600_state *st)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/* setup interface registers */
+	val = INV_ICM42600_INTF_CONFIG6_I3C_EN |
+	      INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN |
+	      INV_ICM42600_INTF_CONFIG6_I3C_DDR_EN;
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
+				 INV_ICM42600_INTF_CONFIG6_MASK, val);
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
+	val = INV_ICM42600_DRIVE_CONFIG_I2C(INV_ICM42600_SLEW_RATE_20_60NS) |
+	      INV_ICM42600_DRIVE_CONFIG_SPI(INV_ICM42600_SLEW_RATE_INF_2NS);
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_DRIVE_CONFIG,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	/* disable i2c bus */
+	return regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				  INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
+}
+
+static int inv_icm42600_probe(struct spi_device *spi)
+{
+	const void *match;
+	enum inv_icm42600_chip chip;
+	struct regmap *regmap;
+
+	match = device_get_match_data(&spi->dev);
+	if (!match)
+		return -EINVAL;
+	chip = (enum inv_icm42600_chip)match;
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_spi_bus_setup);
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
+static struct spi_driver inv_icm42600_driver = {
+	.driver = {
+		.name = "inv-icm42600-spi",
+		.of_match_table = inv_icm42600_of_matches,
+		.pm = &inv_icm42600_pm_ops,
+	},
+	.probe = inv_icm42600_probe,
+};
+module_spi_driver(inv_icm42600_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-426xx SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

