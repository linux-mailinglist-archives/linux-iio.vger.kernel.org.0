Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0C1C906F
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGOn0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:26 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:38022 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbgEGOnZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:25 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Ebhba006057;
        Thu, 7 May 2020 07:43:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=eienbKpvciTEuqJXQkvpq+b9N7yM9ZY9yEJ0Caoc8WOyxl805njRCEh3+TWy2pSsNbja
 C97WyWksoiCA/o04UwJwQ70loql0GN4YQ+7OGtw9idBYp2Xr8zRMdJ/U5LI6+Qb9nAay
 HxcghQl8c2+MTy2gnVEFhD8q7FMgImKxaDFToNek7eAKaZKlU+F8ZbrIUgK6TTmAdsMu
 SXLPESET+y6LcnowUm7aTNgTp70bU14Hcw2CmCP4ePTDCofAm+/XUUkwmM8XCFnCe5dK
 QkUcNPOeIN+2si0WvylptrzQ0Z8iaIXiINd8yu7UTBfZOPj1ePFoeh248rf94FG8bzED 5g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ9CtZQXwW4BOKLLp9nglkqQrYIXH870kXUMwu/VkClvS51+uqnlq/5JVmrNjUvVGDAw2yx2IarXAx5wBH3KZPATP/J4HeRZYmuXFaIEntuMP2vaHY4gBobpNdfZuaqKJker06Xmz4EppcYaFn1WsbiKUwkuigFbzuS4ar07r2351rKooZ+a58oCV8iY5F/NQIRGkX8NT16tR1FntmmFyn0neqA19W7nzi+5nGQRRS/0MeEo1b45djMOlEvOtUG6y9cOjPTiEV2DuJll+s2jHNoJNky69FDY81JFRdUuQk6v8Hv93UwUWUVP4wBLQ//ST/8SSareroGhYGm2ujF7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=bBqO35iy4CJzQb+XkrTkk7oPJ0dhin41CmgIKOiGdVYyhWZ+gtPiL1Swq3nHlXDGEAst/2yTNyCw28IewI1J8oZfeLab4nI0Z0G4279ozyjMQZE6Bi733pN8hFu/SqbNNMTib88fP4u7/ETtXxt0mIeELI6GHTB6fr/U2EsfZh0EnNBbxRRwYE++eR6evWsnUYko4w5uSXqe8l7m9AwHp68M8rZIaVjKYZRNAwC6ASP6EgaW6kHfzQR7HEXq7L8b7fNPdfHeS7XSwlcMK0SGK93ajOMDR+w4TCyGfrIt4eEp6MlgJd9iLeDl5qsewcdcKdR7cmUwffxQlHA1kN2KAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=FTar6318Ohq3P8Du+/VZyEuvgwepz0y+wK7C+K7etttZqkQs/SosGFN2Tu7JKo7XEhuThkyD3mYkm4/wY9Z9TnAoKVdcaa3TtsvrOo7CilQIGreT1xCn9S9EAMlacMusv4YQcI78zIlpeFUh7IDSfuTAeCgI4gJAgIexzyPW9ug=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:20 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:20 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 07/12] iio: imu: add Kconfig and Makefile for inv_icm42600 driver
Date:   Thu,  7 May 2020 16:42:17 +0200
Message-Id: <20200507144222.20989-8-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d0f0bf9-761e-423b-f51e-08d7f294fc3e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4269C80D8E27299501E12894C4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bD23nHtkOTtrqzo5NFeCs8OH0ls7FpBwFZacj2kDRu0gR2Jwbf9vH3UR/5KWfLpKp7aTsiiaPx6uyRYQx9z300b8cOHS55uWLFvdcCap6fReC4VtyNdPyYB/gHgcvADd590T697ppaEOPL5apTW4nYoHyodfjwRFao+gcJMY9fbDHsTUK0AB/LluTXEU0EqSa18FUqd5nrhI7RYD+wIHxyahxilEhLuda0q4vZ1T71ANWLd3pl4iRks8g9sdoyqJa9Fv+FrziN1/cCwgK+3WXkt/rHTSybt4GD2VznO+b+BasU+9EQVEC8pjv637Elio36vblCDxTCw4Xd5HJCYPjyuACmDBIOkhGOzt9bqdI8bz5k7EqR6aFwKMOuA4F9t2LtbHvRc57kGf5CmWKjcVp/ePDKNa/11gyNCt9gHnodjWgsMzOB/BBphNJAEbkWXsuDrIS5T657/diX39QawWZ9/fyAVcjZUFB9Vgc85G1knlIPelm8bz24g9EUDD5hnexSnE8zibzj3SNRcerT5DyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: D0vn3kE7+/KDPKtvHmRzT1hhA/SBJMT10LfFiIJBWggBJUlsCz8XJBBJRrVmDkZvt5fSNC9ZQl9FfaxGi8sJnCK+UO65Bo0TBTBEoLcSFoQmw2LNdhVs0VAlF9gKkpeMO9F8ZHetlf7R2agF6R5/kWImfzbedqeIhvw8GUSrm5Ik+JcGF5GeYdWu0QFPrlNOdqj4BzsCF2KT9NrfzAGVri2UXgWSjSw4FhrB1jOWW9e9Vh5AdBT/HXgDeXUt79tt337zrSylEVbzyXAt4zN52y/uMfjiWBCKIXvF9hjRNs3gvBqHQQZ/+s+p+bHWyDFyij+BVH9UsaWvfpXAlTpNa9RVgbZLawC3FN+493dJhdtfpRQpwrfu/j40AluwlyGCBm3Y8MUp336WpK+GuVTxj8AssYQsxJwgT2ext/tLDUFHY/CxHXfz1y1GoFIIF355sG70ZbyFV/o9kdccf+mkT0vQZsEDNz4KMDT+0UoCj0BUEPDVfzzSH2qFB8v090q6r6tYrljL4BDuG1oYMqT23GTNHDFBWkOWfDyNvtzBmdB3eGlbsF/IKemUuHrM2MSK5lOvB6WwkeqlrPWZro8vKeh1sNpyCKWDvXRjYTe8wu9bvFvuWQK3fZcRpVf81MP8yvDC6k6LuFQoqi6VfcZPc+dI3ZJr3dEHTllwlWB9AAihmw9kySfSL3DR6P6meB5Y5jWRMP2NAowhJg760MqiQNX3I2ORVZJpIra4BiYsjmrA5pzc8eBJgtkpep/6/LEdCSyut3S2o+L4mljYp+aYfjRhofHxNnHZfrnqsG+KNJI=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0f0bf9-761e-423b-f51e-08d7f294fc3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:19.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqtKoO6NLvBwFQlYMorKkce8Sm7hncJNuIRVmT10RFvuZAMknG7GFGpX4vDNvli5VebnrAslOfTNKOx43bBr36yYS9J9Q8YdHj8k8OH52uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=964 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
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

