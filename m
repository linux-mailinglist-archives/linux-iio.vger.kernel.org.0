Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A7C1C9060
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGOnR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:17 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:22222 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgEGOnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:16 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047EbhbX006057;
        Thu, 7 May 2020 07:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=er34X0ctctBVY/TXGsxPvBZIbWfDqgkiAj78pIAj8Cs=;
 b=fcTjI6zLLK2EgfR4yEfQu1h6o8POIGrIQfZkewN2+wydxdKHHZB7ksdIjJBhKiYNeoiI
 zJWrpjsjvVA10BgImQFA9pUjW3SYEJqg+rjSTfUSkqKfIisGbguBBgr3Rt1yYfjDmB32
 r7wLHroVNyqcODsYexfvfCzcQp9Yo4iQ6dK3peSKkWbaD7ST5WuTbmp0liDisZZArpPB
 M8vFTrJXEDIqXLbSpsWmPrI6qjkWO8bGwUnGO8qv5oiSi7vIgK7nDCbSWB8hIEn29xM9
 bMHWlTrS9ZQzEuSiJo4BLKtLbVuTVEdTmn6CKchHgRqnQsyWSm2l7b3uqE4yKnx1XCRJ qw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatwj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG0gzy5zyCeQC4WcozcqeVALsDheHasIpnySvnU4fdBIvZj2UnUa2bw5FZDU5zDfKmRNx0OL0EiW6NJHE9btdwjCi2vLTTjSkOvWmX1BXFlNG8d9q1VimsiEg/HGm0PtxJ/7LpQAds5qwYQamwwF3D7sZOhjMyqqzpz7VUO9fF1nBPIxMLU/GqKKpDoVIEaOPszpQb5aME08kcFDxFSaCfs+Pbg1em+wJfro6l0YOVW6HVgyZECF9jm828zEmW8oN/AhF4dX83J0Jiw9IUA61DF7uEUsErlMGDc98Rj95IsB9Q4HUFai0Qm5Y4VquSccyWCHDPS/7I41Xb+f75cMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er34X0ctctBVY/TXGsxPvBZIbWfDqgkiAj78pIAj8Cs=;
 b=lUXF/tVbfVMBY/8DChFiVcVhCxsJWUjWG7ZQn3GZZVGm2AkHKVTZvybRpIkQs5f3+l/Fo84CpcxJMoJ/wcKUu8nLbTwmM1mG5w47vDwVSjOwrNcvM6SZ4m9orlV/JnZ3MGOOBlDPD7XbT7mrkDapiX/0DD4V+SpPSsYZclGrKe6/QFiR/uyLiXVzLfJOVA8VXpe8ERM3p6z5waGm9iQZdhsUIkS2F0NRqYFkJlhwJ6z8KLjYQQQDFo9OCHpy4Z1tQIixHjDMPPDD9eNWaFFBlHzGVCt2xbQgsyvoNVV7X5iapPf0Zx9lFEg9lalac8rdthKxKBjrqZgUj64X0Dx/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er34X0ctctBVY/TXGsxPvBZIbWfDqgkiAj78pIAj8Cs=;
 b=Uf0KAzsnJ5/G7+gXsh4QK9+J6qCGyxfoisQ+z/EZXkf6G8oOdWpG8yXwpNyMfCi/UjI5YVXhjNvA8kxcPJsPEGMXEMGVG9WTiFxns4AJIKRLo9R4Bx/s4uBczST7FQEiqA5Ui49SXGG5ebYjhweIoCV1rIFje6GMbLyYfEOV/e0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:09 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:09 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 02/12] iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
Date:   Thu,  7 May 2020 16:42:12 +0200
Message-Id: <20200507144222.20989-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d962cc-56d4-407f-1a30-08d7f294f5ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42695CDD60FF2218A174E6E1C4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kn8YuyNJD2Y9r0ku8F6frjmqsLfza+SQfsytq3a9E/YmlViqcjXygSGCU3+OyV2JLoXtmy+i4zgdsPl3Uqs0ED+DDDwD0u/zwgauT4ViqDxa9yx5GqbVJ1dAQ2FTczXG5GkxHuvDSjspDnO9mCMDpP6cFEZUZkamTTLfdATjMuHOdK7ZneVH22TZ4by7K7mVLBc2UIEEvUSAyjRRCg3u9WbbCqsFoHh+Za8ChiHf0z7jBq9p33vChI7oUgyQBhL/OY56FxaJb853lSie5JW307rV+S2tncikJNsvkSSUtj/tppQCVyO7f531c2rYOHiX09lCjVg2MqecwSQ2FZdOfUHnbLn2oZFALQD0sHC5abg411C0HVzzNMJSzhT7O27BzlaSBhhjvfH5AfScVZ7UDNmj545BJCW0+ZySW7hkpG61J2S66288PZeOitu+P+bAMSFWAp/I4UKtKNrNTSfgk+TZrWWItNrMROa23cGokBN8zK5NoWqgLS7lxzE81woAh0SOQQ7Z7lBOdIiQMlUaog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(6666004)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ia8nNKRS+K89yLUegzsxo0McCAI2QnxKxuEnoKl3lKMATVsoyrAdbBuG1GaBGfoTJ7BaeMoaPaVAWV3G8h6eHi1C/qrtXTEpPOq3PNrOJ/8qvCFXWBsjxSdMHQ11RFFY/hJUEYt1tAzwv9AFiPu6m0cKoC5eI8QJgVSfxa1qKAzYo6/MpzbDiPr8fLF10NoB+2ws6ucxhaWAbYx88vL4BOxvrq8PHKZ0bnXOHpSi64S0us3oCZdBEKerKLBErXKmbIeymD3+aaJQ8oFSBIAasDC7QUuL0yvK3t+CVddblQzvidy64a6+DxybqPf0cXDNiTEw1IGKlz/+UiYrCv/ENkHrp9R6h9wzv5mQsutloPdFePtXtW9OZgFNA9SzDPTFA4CBl/p/AiybIQ7naaryWCvnPmy+P3SpsMePDnRcu2CLzdqZqEMO2UQBTshulWLO8M6023Wy544MXCtSkV2Jm7GGSMlj+6fbHCJnwEpVAu8tiNUTHLh6M606E2+3qKFQYO2qnXgpOjFNtueSwLePtqH3hEOtYqkzFcgVegbTCRPh3QHvHZH0g8dixI5mx3WnyeZaJ9bzANRI97hHHuDqL8vIjh98AE6CMGaCVU3A2RBGhgTN7fgHK3HZ4Ba6e6S9Mz0TMfs0IbifJvcaxNI2sFP6VA1mK+aj05uYSPUGVCcbnh+R77635L1yYJUhWiUp1EJwqesOwQHFaM3+hDkj7srZTnjQ4P2d5GXeGYa4gAz8YJEKwpq/q+jV5OdU5NUmogxuqCMcwD6zs4RH5ojndKcdwaPIJTXJFE0Ttb/28rQ=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d962cc-56d4-407f-1a30-08d7f294f5ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:09.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhfZf7tBM762Ndi4cEZwmLGFfeT/jTOvJn2r0+G+KVAHR/xec7Vkn+hghHxmsUJzjtrXrNfGwY4XRJdSlQBRGVTUTsgFNXx+ZN1l7t669Jw=
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

Add I2C driver for InvenSense ICM-426xxx devices.

Configure bus signal slew rates as indicated in the datasheet.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
new file mode 100644
index 000000000000..b61f993beacf
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 InvenSense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/of_device.h>
+
+#include "inv_icm42600.h"
+
+static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/* setup interface registers */
+	mask = INV_ICM42600_INTF_CONFIG6_MASK;
+	val = INV_ICM42600_INTF_CONFIG6_I3C_EN;
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
+	val = INV_ICM42600_DRIVE_CONFIG_I2C(INV_ICM42600_SLEW_RATE_12_36NS) |
+	      INV_ICM42600_DRIVE_CONFIG_SPI(INV_ICM42600_SLEW_RATE_12_36NS);
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_DRIVE_CONFIG,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	/* disable SPI bus */
+	mask = INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK;
+	val = INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				  mask, val);
+}
+
+static int inv_icm42600_probe(struct i2c_client *client,
+			      const struct i2c_device_id *id)
+{
+	const void *match;
+	enum inv_icm42600_chip chip;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENOTSUPP;
+
+	match = device_get_match_data(&client->dev);
+	if (match)
+		chip = (enum inv_icm42600_chip)match;
+	else if (id)
+		chip = (enum inv_icm42600_chip)id->driver_data;
+	else
+		return -EINVAL;
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm42600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm42600_core_probe(regmap, chip,
+				       inv_icm42600_i2c_bus_setup);
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
+static const struct i2c_device_id inv_icm42600_ids[] = {
+	{"icm42600", INV_CHIP_ICM42600},
+	{"icm42602", INV_CHIP_ICM42602},
+	{"icm42605", INV_CHIP_ICM42605},
+	{"icm42622", INV_CHIP_ICM42622},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, inv_icm42600_ids);
+
+static struct i2c_driver inv_icm42600_driver = {
+	.probe = inv_icm42600_probe,
+	.id_table = inv_icm42600_ids,
+	.driver = {
+		.of_match_table = inv_icm42600_of_matches,
+		.name = "inv-icm42600-i2c",
+		.pm = &inv_icm42600_pm_ops,
+	},
+};
+module_i2c_driver(inv_icm42600_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

