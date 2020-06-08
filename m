Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2574C1F20F7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFHUn4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:43:56 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:55562 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgFHUny (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:43:54 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KgHMg024905;
        Mon, 8 Jun 2020 13:43:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=E53oPA4C0wuO3PEcJfFuaJflkKcYk2okQa7RzdAllWdTShX3qxYB+0h7ekE+rkLXD60C
 OhiHdLmD9crruB4ETWGZzYuENQGXltK9ylqPjQFU4o3v1vjVN4i4EFmI4r/4w9s2kCpr
 CiEzjTDtrcO2n/FFKa67O/eQ/pF1LemXUNE9P8OY/Yt6O6/01QvCYrstmjsKNlZoU+MU
 8i4e7tnvEsOQAhUCNoHCPWo6R//xpTkmjDonlUMKx3vssw++qzwjDEF/eVKuVHyOlTVR
 HOJ9vtE4l4r+r/FiAyRctLYSwdBFoYfQ8Wl6pz+WOyJeg9LH0AxH1geIRh/i99i1Q/Iq vg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0eq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNcSjBeN6sYQ/7h84cHUmPzHYqjR0IB8CoNJmLrHsQL/lABwLf727dgxTYQHYP0kJawv4ha53p42fhzp3CdePq3+ifLP3nnObMj+eGlomqqrA+Wg4x3MLylxG09V+MP+xbqvWhTaR1lDfH3xNEGjPs+f/iMFYZhLrXtyGoS1QWSZZhyMYhL4SOwW3UwDnkivEKoCXvgYFjdmVmMSN5qc3zOYhKyWTC+sz9LmECvNKWiYOACZ/ZBEhYvHCs/MJV9eXjZFWHq3L6ZbE4H/7Uu6/wEwLhSQnHJ7gD1wCQAn/yr16/Wb4gRJ4/IPzZEczbB6kFMJw5hm89EtKeLwvGoGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=JvYijuJ7oUlOzqajH2Tw1myA2wwTOkZRDMH8ZcWuFau8nwroLRLa736zfiXq4XpstAKSFt2ZbusCVjXvm0v4/unLYmhKRSkkhpnVqNRgy9aojciQlPLCw3vfHG4Xs9o6va7swKfpMPB3a5GAvZQajBWj1IqRT480jztjV3sBLseLAHBISbfwbNoe8NXo5kS9AuTu+VUHhABAj/3fcRLfzTE0Nhb+L0P1+AjtSpO0GoKHSCRuVGz6KMixx3Wq4092Jw06yCLw7zWDXXCKcR/4hlFLkvsjgn2L+M1dj2TKakRec+q9QCWSuSpCBsBMxsl3DPMTV12bP/KQKO4t1NJu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jiMf8sqcLDdqCWqdv5GNr9Gk062vMMjfJOvpD2p59M=;
 b=U1CJkef9eqwiOotQCdtmDbpIN1IigO1vPG9XPGvXNvalsYm2jrW9rpf9BOipM2n4l227Ke/53LSqAxTmKH5QBQlrbciSn5Nk3Bs4PICVQxi11XPsetxpLkxuhaJoRe0Tcx8Mwtv20mdCynBsOZBRYe24vvEPeS1UnMu7dVKJtDU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:43:49 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:43:49 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 02/13] iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
Date:   Mon,  8 Jun 2020 22:42:39 +0200
Message-Id: <20200608204250.3291-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:43:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84878f79-13a0-4f04-4fe2-08d80beca5c2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395134E9DF61B49BF99BC7C5C4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3muburTPJxpcI2J18jmPn1YDHEuurLITok8jn0KhGhqIcJxsskq49bc1UEZwyzMj/MCc30zSNe6qBNKtkcZqlJEnkjIobZq2vSP5i6EcIvlb4tZ47lwCV/kJNn01JViM7qQTztQLrqpaV68U7bzKtJYpSeBuTKopomvgIxn8HWinEC8R+fCAd6k6+yES3IsuhyuTzfVU4m5jojBRvkClg9ng2BKVm9djOsnGuFiiP4mzOEWf1fVALSYjMuxloHq3u9CBZBXTGDWwEIf97Q0oQWAa+rcwuF9es3Ggw1AU/mLY43T8zCAU09phLTVty1G4QaO1s7mUb6t5hJzaJjIqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pmnLnz0v04X+tn9UO8n+sgy3rseSsqUE9Jv6eVaomtDSy5YCV//YLKzqOO4dg/RABrYcDLHEGe8w6DXg1xyfBvm7wLGvnb/60o2QO7zszeMyKD95LSRDI++MQCkfWwpI6LKCL6IlZ90/tw6fO1FczIkUi6nwT52aMaFx/Ned0+PZmP4HzLVAVcvudXmmXEDzDjLn59y4zGhEvjowme7NAhBYXJcY/YAyQxDDZeRmxNLaH0lJLhInx/y5g5x9RasdCVmd5PYo6kQVdGDU3j6ojpEeoZXq5PTvMKLxr7cVRpxEeoooi+aLo1OAqcDIaSTslW+KyKhZh0B2XIF0l4hpm8cJ5O8IR1mxMb4sfni8efnHKfRY+HwjWtKzaTmd82hw4drS9vacwFR6Uiwkel8/DD26LcZRn+x1j+jxlMJSjZyztTJHmYzDmvWuZCkUEKpx/iUZEV7vSD0WvpyDi54j76KadV5HQb1aV3yK+LivP3I=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84878f79-13a0-4f04-4fe2-08d80beca5c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:43:49.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDRlX7vvHd25nOPuQwbKAFvKa1ziL9C9A5Jd2LZC2riI+EJH3RAgQX9YiWfTce06MwYwewlCIRbx2AnVpJe8FnrVtRNEFpbRcJD16vDrWmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 cotscore=-2147483648 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080144
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

