Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E736D203B11
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgFVPiE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:04 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:51456 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729539AbgFVPiC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:02 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFaviq023511;
        Mon, 22 Jun 2020 08:38:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=BkxwiGta2O63HOavmOs9pPiDbYIF4BewDnimn6GJoc5BBYwZEE2M5PbusT/zniPHcfEw
 Oc63rcvSLhxPm4BdcNArE612TMzP+HavRUk0g0H9fhRVAsY1RtvkWYpigJK1LJdYrWf0
 dnogql4G7FbZb44e+ZXAMsotKM9EN3N4L+F3sGxtPFjCOXuH3fmvVh2IPSawIvn0HUn5
 wthhW9qmqaWbjApeR6ThejZxjRhc0XVx4XqwDRH6y39WY33vSl72OiiGHApba06WGkV7
 KPpWqOubRvtXOl8DiGO5rS3koQZugPISmBv31OjzfkGct6fx8L0CDigZxCnfgFaT+jse cA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by mx0a-00328301.pphosted.com with ESMTP id 31sdxnrtxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFtRVxNmM24Clyb9Y2gaLTBqW7W3lnzFuCgwYemFXNFx+B7TfTbJw5z6znAMKAUKJlznaJoLXAV5KB6MfM6RC4NGCMhWBC1OUHAvACJVxICKHOHZLQcXGKTkxqryLReDSeYGUm/kOPK5a5tZwAGBLMu6hzLESlEDhKVT26y3ia680HbTmAdssQYrnbTIixuJ6aRZEkZQ34XotoK9PrdPwurTrwxVlVF6nQ2CrWRzeyJAHJl6YNvje9wZsuZJy05kCHz3liDjuHExayNJ/uf8ie6LAw3UtV1C4JQJy4QT+V7HIdwvqy+Kz+extzccqq6s9AjtqoV7nwx2BMXCtvOWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=XMY4FEVenYnSAMOjHQjxpAv2fMqG8GmFA1vjGID8suUwh6Q6TWlJ1mpT3ZWMgHbr4965ok5Z6V4QlDuhcxLmd8nuk7rJxnSx02FZCDc7AagElg1MO857rzxQA9AJPjF/3GyrJ5GsNPF47c3tmEM/0Q4AkDzBp15ff2cLs+I6ameN6yVExUk5Yg1T6iTErhHD3VTPKcYFfJlOgeTHb09OpqCFnzQVLzSSMYgowsTdt7U/DeDf1r+ijqasX17y0ZCY2MMVz9Epr9CrLu7IgNHKf+sVTmU2cMsNMJMpkZAOI41adB3lwtKDPcit+eAb7pUaIF+c8vA123CEPcXFH3O8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=KH4lzREUsYUK0A0Xex1FrBxCwB6NukacPewM6gE4ST9m/GfCS9daO0vkhhnmMJ45ta0aPN57gSHvaI05mUmvr1DBy8JrN4av9bY1GqM6ejUJ2xEzdYn/a+N5V0z9ebejDK87XX84uboUPJe1mlqY9wPI7X5l5mw01oXxUAH5olA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:37:59 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:37:59 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 03/13] iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
Date:   Mon, 22 Jun 2020 17:37:19 +0200
Message-Id: <20200622153729.12702-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:37:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75f20469-9b8e-43bf-9816-08d816c23dd8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB450139AB9DBE642964E16FE9C4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOemBcCU9wbFh3qYX33ArjNQBa7A5NDNiST6Bat0pPw0JGl0SfyKFGTzr7Oy/XCZQgYpDfnkCLzdAGEMFFEKmtIXtLdYohFSr+73coVYbTE/KGwyqc4d8IPayq2ol3JhRgz/CnKjYtHlIs7r0BXcTPx+4tSjZ1amQlCNe5pUGBsb3dr/fGwmva7EtsObLEblT+l1Qd3cNhfZgQvB9BjPeF9bMd1kMJ/eScfqybErAWjsyQVKDI+2zoOUaTfK/QjIZk/m2atK0Qvh+t3Bb1Nw6tvQN7VIrLJgdBqjgk595nw0XW8/eEbNNTcq64tk06TwZOfq6GzxFDnQ2AmwniyiwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(83380400001)(107886003)(86362001)(36756003)(478600001)(6486002)(6666004)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9JhKM/feFZLAXou9+F0mi+J0BQKsoo16O1zdUYJuLINNjvS/M1CGAIHCopnSS7jwaGUrQ0LADJAj1qT2oWWBulKxUf41IqQUtLyZxK3Gc90U+t7ovKf4F4YuuXwWCh7dAGQUU6ILwVwrWzAKEaGUvtMeqsp4FGGsI1KGwgglEe3yH0RFlcJIU94exdFuKQvElDO+0jVh0uC3Fm+FNkVho1sgR4o5XpB5c/Qels0UUVgTFgWwqBM0gfVrm4MXkw9OZlxPS8guJwMuHyepH/ogjrZz0Op20/lGuL9KSbaPZcDOpeVhkZqY6FaYW0Eh14lhyMdl1dGvTT2VDur4I0N6kLvxCALKbyxtUlYEVpQUFqz7jTxGegRGVASClyZiwJ5hGvvLjnLjlJRhXxqACLen11Q7c5k/6RN0yYW6RSiL4UJYEmYCRgwt2C92aCyP7hC8izfVMRDM5ZKHCs64ubjwTuIAMM6kTkMdMNtTOEVyFR8=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f20469-9b8e-43bf-9816-08d816c23dd8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:37:59.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQP/E0zSgeg/fX29jIN8pc0cc7sLC1wmbitJoBejVgyBM+bN8VL6F/TDCKk2HZNutIcr3VajvLRVSd+8rWKyX+P0XdD92Ru2pbs2QJMdcBk=
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

