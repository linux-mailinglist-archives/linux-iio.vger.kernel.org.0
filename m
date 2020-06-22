Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED23203B15
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgFVPiP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:15 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:42252 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729253AbgFVPiL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:11 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFWD47004964;
        Mon, 22 Jun 2020 08:38:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=e4/4rAJeLeL+expAwpQI1u2vgDkycWFpOtISOSc0SsI2baFkb+BknE8JjdgNXl7CLPLw
 fOi37yWblczAq21129Qk6x0nCxPVs9AwQFURP0IB02LM318zanRxi0tSCzPV23bl1OwZ
 KHXkJ2g7tNqW7oE5NcSi9eBLwdgzCC3zvqjXRX7akUeyN0lE/TSMx1NqG5fXGEJ7Bh89
 YMFIjJpgQ7xq0LCbyR6KHzpWsr6GxUmXbZY6u/pJ0Ai6xKaHqvq9YvQeqnyBEiVII2y8
 msl7OdlwFXmxotNKPRIgsHKe/+00X0QyIfEcVDskw3usCS52wTqWLN8ZKhknSR/1j1fE aw== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0b-00328301.pphosted.com with ESMTP id 31sedp0ukm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaNWVkBGBZL+3xB8cxgsTXgrUqOikUoiSdxP2YzQz8FVOPoqW+CEKbhMYe3LVEPXxLAnf6sz2tg6nvgy9/+DUwodwSavCvk6eLlMABBAJ821kn5EqTZNUHeEs5cHJzuZrojmzPJNNsfhvyY+4oabr4XoGIQFu4XCeyBKtZz7LOeQTJY7ksJvDFCKGnoZwPg0EC7hSDdB1cFTyTXwyQy/hhe6kaVo1liEPzZTBu6U2ou9PaFPIRox9k4rulCCOlYRhZU8JlkrSrDkT4P5bF64qNxURGQ2T5APPH8ZNhuWhhiLLMQlHt7dqTVwpp2o8Pks9OS1jEUhQdI8shvTYaLe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=kX+gcgm0Kko6qzduxVYZ1PkQhT0lbKrZHFRH/Cjtz9W3WMoAzPbZoCa2W3GLdHI0cYmH3SddVkVUTGiTn94LSvE23CZtPWMddwpdMJmSgK6LrBF3Ru9wjGueS/0RZY1dJxFAB4FVeZOpDgAyxOdOSEpFpGz2M+qK6eJKGTGcg4V58G43cu6E73N4WUvr53Lu3nwa/HjBqC9eKEWhnDZ0U1lf7SDUJgBa4qwYqVCX66ZDSjSZ7uHuJl4wAP9rEA3/jXY3U2CfTrkyjlq3cS+T7W/mfhtK9oOnI2GLpRtDzdE8RJ+E0djpq6KLADDgE0BbI+DYu+P+0AOY/fcIl1FZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=IXT0e5tcBtxYc6kr1n9mcjUPqCg8nBPIvSR7EKn1zbZLUPGLjn7kH16vIpluFr1PtP0xDTXmZ43GbT2f6qTExjsCLdPaiQl3jju4ej4aULe9JMZr4ijfGY8t0at+w1C+viWKb88LQOfnHzM7f/oHXGRgVofPB1L+N3zdRABJTWg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:38:06 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:38:05 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 07/13] iio: imu: add Kconfig and Makefile for inv_icm42600 driver
Date:   Mon, 22 Jun 2020 17:37:23 +0200
Message-Id: <20200622153729.12702-8-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:38:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e30dea-ae75-4d9b-5043-08d816c241c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501CF03D44425DDFFEC94CDC4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrP/9H9KCdyTuCyJPP1Lx3dIdvCrHjlLzCURD1gR2TMs/YRqSX/sfBtkX2NtvjnBNADibaWD4SSMlML6SLeB3+mVhwigMVM/DN/2RC7yh8rEaHzqfalEMgVv600swCg56bSRYWoDcxrIEfNGBx0OAAj/hkuQ9k4K6b1oywfWu1vTH57MxJZ9k825xsMJPx/3iw9/sFlWFGRP1pGBNNmGegJTKLmQFgYViGy/0cujLhby6y4iB4CxyNgyPni30Z8vb5aPn+08wUE/L58wQM0gph0eg62QZraKSccN9CUmCiXxoUhKb6O+fNvEU7NAyJRW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(107886003)(86362001)(36756003)(478600001)(6486002)(6666004)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qOM1gGb8QSmkF8nnp9llxAkcJjCCcse7O0rzuXR3hjF2vzd+LOpTiJx3fiR6PVKMo9GqnNHAujSS/VNVJfZWYtqMzIDTUz1dftHp2tNDgbLjN/EbV8yb+Ku+7nqTkBk14+jXZXlo7yliP28NrKTJdee7/xC/kOSzlVlI4pOLXuyLcgtLWyneZrfZgoTk5CsygNqmcHqhsKY4EE6szIv5mtunPmDZ/T+S4TU3K6wc5efFbcNClsE5jTGKYz1cheqd4Xw6ibZeza6WSKDPZWgrQH/7HjCMdMIpLs7i0AQtzbpFCDiIyx4k3gkRms/uCB/yw1dtFWHTJJsWxI7p9U9bu07jt7bFMJdQT/iwnjorEjOPqkV6rWsOOkCeLVPyO/1jgoGCXebJzTrwPZtCaDjVheMmw4SSmfmzj3giC/Ej43CM8lMnGLE8AZQ9JE+Z/uLLdBrQThB9bWd4z67H4gjTCE9XSJTy1bpRLJmMZvtAH7k=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e30dea-ae75-4d9b-5043-08d816c241c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:38:05.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kg99BzAke0vQ+MaJ8sqQkBnI6pAviwYrb9Fdo+7JzncvjVrX13sk6k47JV3moYeH6zzVtPw8JcnHS224Ix2gyG3/9XwvmIO8K01WsEBSEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=972 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add 3 modules: inv-icm42600, inv-icm42600-i2c, inv-icm42600-spi.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/Kconfig               |  1 +
 drivers/iio/imu/Makefile              |  1 +
 drivers/iio/imu/inv_icm42600/Kconfig  | 28 +++++++++++++++++++++++++++
 drivers/iio/imu/inv_icm42600/Makefile | 13 +++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42600/Makefile

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index fc4123d518bc..f02883b08480 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -91,6 +91,7 @@ config KMX61
 	  To compile this driver as module, choose M here: the module will
 	  be called kmx61.
 
+source "drivers/iio/imu/inv_icm42600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 source "drivers/iio/imu/st_lsm6dsx/Kconfig"
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 88b2c4555230..13e9ff442b11 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_FXOS8700) += fxos8700_core.o
 obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
 obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
 
+obj-y += inv_icm42600/
 obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
new file mode 100644
index 000000000000..22390a72f0a3
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INV_ICM42600
+	tristate
+
+config INV_ICM42600_I2C
+	tristate "InvenSense ICM-426xx I2C driver"
+	depends on I2C
+	select INV_ICM42600
+	select REGMAP_I2C
+	help
+	  This driver supports the InvenSense ICM-426xx motion tracking
+	  devices over I2C.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm42600-i2c.
+
+config INV_ICM42600_SPI
+	tristate "InvenSense ICM-426xx SPI driver"
+	depends on SPI_MASTER
+	select INV_ICM42600
+	select REGMAP_SPI
+	help
+	  This driver supports the InvenSense ICM-426xx motion tracking
+	  devices over SPI.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm42600-spi.
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
new file mode 100644
index 000000000000..48965824f00c
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_INV_ICM42600) += inv-icm42600.o
+inv-icm42600-y += inv_icm42600_core.o
+inv-icm42600-y += inv_icm42600_gyro.o
+inv-icm42600-y += inv_icm42600_accel.o
+inv-icm42600-y += inv_icm42600_temp.o
+
+obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
+inv-icm42600-i2c-y += inv_icm42600_i2c.o
+
+obj-$(CONFIG_INV_ICM42600_SPI) += inv-icm42600-spi.o
+inv-icm42600-spi-y += inv_icm42600_spi.o
-- 
2.17.1

