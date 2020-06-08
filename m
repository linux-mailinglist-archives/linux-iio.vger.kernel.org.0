Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F431F2104
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgFHUpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:45:39 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:3634 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgFHUn5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:43:57 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KdBDJ019703;
        Mon, 8 Jun 2020 13:43:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=XHtfG5fMpgxOxFCmPOXgjiomhNhTR4WTej3cVnDV+o4rTPjg1V246pOAA4PIbnt20hhj
 nOO0Df5+eLiKVv5gQqlaK849IuPoBGq1C6NcGoo/rCYIeft6XnhRSo+Gs1nY4cGqZbfy
 8Yl0qINpiaixWxGlJO8cyrVn4cqP8+45Ex9A4KXxicqptgNoyn1Ji23styKB9Jxa09He
 giomVxQIrJF3OLwHRUzQoNI/CeFvl3oSbqsYXh+f7PZhLKnsInvU9oc8OQIK6aVBmz2Y
 QJ01zB/1ucQZxImw3C3pUjh7iBbhvmSBO9OLOlR/Iv2gVx4A66ugyFH/cJfDkh6PEPwk xA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-00328301.pphosted.com with ESMTP id 31g8cf0xvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjPb2NMUDE6YZZSipgK5nrsCJMOkqa7j1sivquEAM97THDL441qK48QUdWgGDytDFz+MvHGHnuReEzl0XT43qx8VwSHh+ttlRPL2//Cg8nTiaYqoBFy79BJApsu3pYwufiZfJOQwSoOTvrqmSFRKBh9ZL32N/HmGAp0Ijo+nH/Jl/hBcBwb21dcX+Pw+n+PbZTv7g8dHxuqOirKYJJlaxlixf46Re+O8NMnkgDREwJRI3ji3bc8lhLtE6XCnqhN7HNDdTKn1nr/9HkBYzltaM3CMf/l8vyCoQRFtB3s76ZvE4IvxGJBWHzwh1MI9LcGJLN8NknkwNf5p7iRae1mvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=GrAZE1ynahIQ9SzaS2o3IUOi1iNIeLelhQwdbpfXEZhlEZhmzcEk/IKybev3uILpgAqeGbYfqRIwBH4m0L9iO1WBB5JzsJHWc+SVlw0WMRMXQVnHZ81f7Xv2pInOON/GPcJt9jKCksK3pSMhwxcgAHC6D3l5GeeENyv4fCI7deincuSCqWWkOk/8xT2ERAc9OyI5FtflKzcTAM5RyVz3E/Nd5fQcC1wf+dO7TxL2+BOMRc3/hdXDXtKCghd8JVsSUusSpEIjvpqnsxCLPn7jSqDtFGnfTHWbmffsQF4RkrBJ63VImTvwdWzoeDJyUJehJn6+RTMfT2kmFf7NCs2IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yobIXnKmHVtQN55oixDDsZx17pu/hx9Y5m9OJf2mIOA=;
 b=bOp+xaScuf6wj9W1cXV4sBrNyXgYR6PZYRSi/fd9R2Q5G+uNkI4b+zn2AuCOPF17Db5U33SM3nKZpVd12xbZAR9Hcj9riEb3F3ThrmawrLQ9uqRCpPD0/tyAIRjsNUZK4GD31V5JZ3tJw/ZTSwibvXWlv56luguWTzWnPWTAGvg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:43:51 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:43:51 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 03/13] iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
Date:   Mon,  8 Jun 2020 22:42:40 +0200
Message-Id: <20200608204250.3291-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:43:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e899c61-4547-4d98-802b-08d80beca6be
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3951AE1EFACC8D2DE5E63116C4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QUKsSvz4kM1f/cRmJLiBWUKl6blWs7L55nZHJKeLKz+hQovsiUQfrW2vGqo2VhGwr8zynu9gurPqNNOecoID2ncEo2Cp4P6xQMJtC03dNgKh9UoPnSvFsqqZP64akPnTCNaJBPASh8yx0DexQGneIBktgYn99P2AzQ+gizi/ta5oS151v10EhFIYTdoP3q/CxrXuZzH6ScQQy2iYWYEeBgt8mSUI3fLGpMmqCnmXqY/YMU/PvNzWo/Yrsb6sdGNCWeQlw/Vi+bUzKs+9JASON5HozOm9sYrK1osm0FKceszQ9BLhs8q1xZKwSw31NOQfimeJg0B4OFQbyAhJOSnqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pRUIMhsqLxESskQO0sZw51MNcFqBBAolafyUllDSYxqsqkdVU+dyBEyFobVS2PLd9QvS+/d+ZkPoQgjvYWbHZRB3knCZ/1EUy+DHvQvuVsAZw609r2neN6y7O1KIMsPFBxYFjZMTcVt/4YSkuyqeQQqmEr6aXbG7N0yNjxMULM0KPC7Vb4jAER+87MAjRb/ZYClh658C/LORwifUyfqR3KA9U8Y+siOO6rD8Fb2genqwuJp3v8DWhq04MFn3VicqmNbs1OSrJxSCEPgnvdHfmPByXWBEzMAY/gUOVQigAlSYuz3hCjrK2m3nxkoFCIrhMu/y1kDeQVC2hl2tUSXe1z4wewUKxvzX3WWPBiGjMT0Qs/wLbkR8QehwLiCuVKaU85U/8OGdv9JQQkNj6eISavOz0GWRjlJHCuEFnrhwGcYQTzi1fk1eqxcNp+4uzsZEQnt20a7CdLA6a3E7osqlOx2hI6P4o20pRlWisuGd3nQ=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e899c61-4547-4d98-802b-08d80beca6be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:43:51.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0Y/krFFA0mswe4lolKwxN8zkgsykaZrcFw63PmyrcyRRk7u6vDDuehkj7/gorUvKpyjb0pA1Q356e1ARuaeVaSYycmjQn6O7KboCErvha0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080144
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

