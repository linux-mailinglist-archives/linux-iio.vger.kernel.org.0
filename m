Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0661E4DA3
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgE0S6K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:58:10 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:6728 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbgE0S55 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:57 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIrXRc004122;
        Wed, 27 May 2020 11:57:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=WBLg3TRrkgy5vmlR9TdJtvpB5OaV8p82cpkATmOddZbIovf6t7jmaWvMmA7Om97pDr+K
 FYXe32dlGxZGmvnxNR25GOXHRXAjE5Wl4uRcCV9bhR0BEaZgU6Hy9cGrMCxNvFbLMGNa
 0pceLlQI9jesXeERyFfO5JRpsBVBH9R7j0a48tjIvywBky8jC4ddUQWiimdSulv78qPW
 SVCHGEj1UzfhCfRw6ftuSXvFY2+zyGy4oJpAP7jhuLeHdD6SMZeod9s4n4gbIE9/FSPX
 zSbufapdW/y2fLBUHDcOu/EC9AukNnadcTYq+AxYGpsF7YjjKBAiAzlue8zBCFvnW8jY KA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap9ews-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOTuYLFCsqOnuXzS4fdnnOu7VRp+QesFdHhWTOB+OEM0LQTzkwEHn2zW4TzWu71184KJqFDVNhX4FD3T0+9dMd3zPl5ZPC284d/bmi2cgADwS6212rYvd+ffZEbwW/BYpqpsvzgVXJMpRSCPB1U5aj78+UpEgAQXfH3tjo6vjvUYv3JsBKXqPHQauRe9jyF11vxRnjYKSD63dM5wM/QexdPMrY2ZQloI/Y85n7gAyjwt1F6BgvFp47rRW14KjHOj0W15MH073CHUb1+1u2LGzgOlR8uzSADC4YuPKKl/N/GtTevP6OMDx7IpM2NnlQwVQLR8e0tiTCbkZ7I68kZB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=bUw5gA+rGJlwbeFPzvMjmUkyJc6OLudFH35rIFRgT/pVsDTs5Uh1tyOMBriRHaigpATOz2SJJ7+fdrwMNjeU+tWMGuz95S7GVc/8IMQNcl1HqnEePCpBs1IL/fc9962ML94Upjs8w5zMSTeBZiSP2IRw7kWisqcn9xpGLmtjV2f+fP/0xNsI1O6yYI/dLc9fW2V+XMh0XDTHKfUVA0qc06RzwASZf/5JzpNxHIjwy5CMT70XhNBE+4z5uGfacV2e3kHC8oQpvIyASye34YiXY7N/qcmq/n9PN/Iomtm2IG4uQZhaucNKImYgjIuiQFKkyIr+5lE61fTVl7lNagwSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=ZCIgrCHmkhZHWzM3uKRcj0wo8ZR8I/T/gnr9hISUh60BpMFQGFOK0wgXfFv4TfUMmzoeifNjU1PY3vdFG+kVUlB7s/cQHsismilCin8bm3Vo9huL878wBpejZ9BABcpXUgoeksrq92l0S+mD+es2bDXYdcz8PvTqtLPEnYudEt4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3470.namprd12.prod.outlook.com (2603:10b6:208:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 18:57:51 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:51 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 07/12] iio: imu: add Kconfig and Makefile for inv_icm42600 driver
Date:   Wed, 27 May 2020 20:57:06 +0200
Message-Id: <20200527185711.21331-8-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0def212c-c45b-49f1-3e26-08d8026fdaec
X-MS-TrafficTypeDiagnostic: MN2PR12MB3470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3470F083CA3FC0285B5F5BFBC4B10@MN2PR12MB3470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTM/5pQbDyNZlBT9qp/ZZsAMTP2OfzI3gdU9Eg73GUsMH6eV5f0UMGcACVsFH+3yVAzZ9bDFVs5FPwCDSJZVVW0ZnP69WPD6rxiaz17Mj5uB/hQ9CT3tyOWV9HiBkthIAzVag5DU8wfXdvUZ75Vq4zDafBIZHPwCGH/y9DHC080jwi+XI5FOVBLKV+EfSiZh/3PyEefzZpKGQm6YEn1q7oiVX4j/RkSalsI36FKYxRpouKpxVvLs55/XhCPscITLMA/RrOiV4dIHSBOnxNV7nbWFUnzD3ZfZ90wJwuawSfBXO24Q4HUljaWI7xEAH1jG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(136003)(346002)(366004)(376002)(8936002)(66476007)(66556008)(36756003)(66946007)(5660300002)(316002)(86362001)(186003)(52116002)(7696005)(26005)(8676002)(478600001)(4326008)(16526019)(1076003)(2616005)(107886003)(6666004)(956004)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r03pYkQ3CC2r7VucXygNfpV4jdSVnWxj/Os8x1F9fMnnwqWD4dqlopZBsO5JISA+Fo+uj/JBHNMc7t5EFmTO3QC19wYjTupLkjh2SxvGN1EEtErakRZpTqnz2ktoiddFvS60SRWEtvmUB50TSjgnAJPKxPwWb5N+xR3E1MH/n49mFDtq1HACMM042Bzzv6jvs/tUc/UZcKRQHostGVfaiEY2aEPNWmZgKCkX/UYZnPHeKZH1nXjXnUtXArprL5YgSaRNMlFnBdYujo/zTuOcvz8s59xaCN/tSToBIwLyG87RBDp7vBpMNLNNdF2HHcgdGQQPeu5nNtAG+OeGIn/Z++GuV8ln2ft2PS1+jHGfEB6jIdovYLHQmndq+W2GwvX4EmfYh3DGnBCuDopEpNj8JvvHjzycXXAtPFpDxW0rQZvDy+YNTOF1hRokHoloM7w+Dx8D6JH6H9y1vjWLXQsLz7PrL86YSSzJ6NsFV/Fo+nc=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0def212c-c45b-49f1-3e26-08d8026fdaec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:51.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj19sE4gsAZsCrQKjZ0xJJUppGqM9Qgd1oKumAR+hAcX8SRGEoqdtA8T9U/sXq7PmmvYAi1WQUExxpt+JbffabkGmo7HY5WUPY07aqWIjoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3470
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=909 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270144
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

