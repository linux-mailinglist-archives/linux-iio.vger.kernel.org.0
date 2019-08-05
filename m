Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF788195D
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHEMem (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 08:34:42 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:26146 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfHEMem (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 08:34:42 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 08:34:41 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x75COijV014373
        for <linux-iio@vger.kernel.org>; Mon, 5 Aug 2019 05:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=zeSBTJ6KXsalOEOkkzs8syMcAMzqv7cNVKW/Pg7z/OQ=;
 b=iwbCvj6rdo2xcZAZgREAvljyYi+3G7fixcSXXNbkzv64DuoOu0pD/lhgYsOJW7nZHSIq
 XMbiF71731XKMGF0Gb/NJIaZvXOM0ZaqbVZn8YdKYbSAkVztC/nTty5ZOW459fl4642f
 0VvvGhOKIURJfXsy/GUcCNUxsABEbBE3TmcTtxBHrVFhmpFRoyOTVLwPNHDMFw0OLXLx
 0y8yegGu7ymgIRenMpyiXpWHuWgZnq86637hPbtwYdfujLdZjKSpYzVs4Klkd/wc2utN
 yfZ9vbITJNkNdRJ5ihShbJ5rRIFveIh1xXkqKM5MtNcIgSPGqx+8g4+F5X9ePIifWp5k QQ== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2059.outbound.protection.outlook.com [104.47.42.59])
        by mx0b-00328301.pphosted.com with ESMTP id 2u5sv9gejk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2019 05:26:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1CuudqlUJRQ9GAxntZR4eQ4uKoL0V7/qnpqgJpXjkfC81gHQHG2RFkJHYKOvLaJ8+R5GBmpZ+Ch5GISPQxnkVw4L/tSZzNDGCmmBANc7haoxYTaB6xPPxRBphVkpuo0KatlTBwAk29ZghhUUwjIQ3bxg990colyPdtLYh7Ni98mnFHMQZLErZn5jTR2+LHQJWV3sWDfoNgueqT7aVG+WflSqHPwfWFUfg0GAAN6VGCWHT6jZL1gegT1W6rCR+eLHjel5Wda8xGUwOXOePgM7179o4AUg+AfZPFvFTosKMtoahsOIrEWfdeOx5yMNgcshDv95Oh2z8mw8aEnvaAtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeSBTJ6KXsalOEOkkzs8syMcAMzqv7cNVKW/Pg7z/OQ=;
 b=aSXxl9GF0FrOH/DImmmN2QOGYsTtGtWdkalyVvO/fLYHgplplJAldIi6WhTRYanAEuXe8siv8kRCAdnGu6APxJkVK/SDSXr/80BENVn666+YLHDm/FsxxxN9UUrOBQb1If+wVvb2A3lMuvjoxD++5XrAeHnbJGf3huAkJk36++DTUGQECi+5RPS7K/FbxG5rpKFi5exTjwMSSuvAOti1kiK3X5zXAAuN/25I42Al8Q5jg6FujM1lx6GArVe3M5igoDVmtwofoXp2sSYE0izdK60L4J25GTCiPHIMxCHI4alDrM3lneq1BNtUiLz5NHNIxfQG731fSexCf5DNOlVo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=invensense.com;dmarc=pass action=none
 header.from=invensense.com;dkim=pass header.d=invensense.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeSBTJ6KXsalOEOkkzs8syMcAMzqv7cNVKW/Pg7z/OQ=;
 b=L8EVAX7QicbBfRabLMjEKFF7JMGQL8c2q1aqzBxugVkFB2htI8+Ew6QCZHP2hsjAvDw9RT47jPMB3gxov6zXGGhh5/fVP5fHoxrmSeiyIDiCqrW53XmJJMhZ/nlE13Rt44DIgVCMB6jf6e2q773CxspClInI+pPyT9JTIw5RTG0=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3776.namprd12.prod.outlook.com (10.255.236.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Mon, 5 Aug 2019 12:26:51 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::41c:622e:62ef:3dd5]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::41c:622e:62ef:3dd5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 12:26:51 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH] iio: imu: inv_mpu6050: be more explicit on supported chips
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: be more explicit on supported
 chips
Thread-Index: AQHVS4kOwNNOyka2oEGDk90WJFWHrQ==
Date:   Mon, 5 Aug 2019 12:26:50 +0000
Message-ID: <20190805122630.8476-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::36) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1826449-207a-48ae-f729-08d719a030ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3776;
x-ms-traffictypediagnostic: MN2PR12MB3776:
x-microsoft-antispam-prvs: <MN2PR12MB3776C799D9D60A684C59765CC4DA0@MN2PR12MB3776.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(346002)(136003)(376002)(189003)(199004)(6512007)(102836004)(7736002)(66946007)(5660300002)(107886003)(2501003)(66476007)(66556008)(64756008)(66446008)(2351001)(256004)(4326008)(26005)(486006)(86362001)(2616005)(476003)(66066001)(305945005)(80792005)(3846002)(68736007)(386003)(6506007)(186003)(53936002)(6436002)(6116002)(5640700003)(71190400001)(2906002)(8936002)(81156014)(81166006)(14454004)(1076003)(8676002)(99286004)(52116002)(50226002)(71200400001)(6486002)(36756003)(478600001)(316002)(25786009)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3776;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EI218Ni2Ftp2aM8Camf6NyttkFsY3LViZ2BnsBGhx8dBMPzPtJsizIUxwKJpJBDljos95a79sZBkQmnIn4Fusa314ov9JpxPFPF/4dGdLAVWw2PJumRYb/dTpk1ZqpZ9yybTdyMEHFbdQqy9gLjN6v4Dr+cARcD7Yi2W+/8Qy0y2AvQ06eW3ZQfoORscds11+gTfNmXMO6ASCHDGcEgPgylfDMzISXlPP8MCC0jBhM2DWyEPyeE2yP69FsjeTYxKsEhw7roCnOMNE98md8vGtyN7Xhz4TzvT8Uc96mEuD8E3vu7hq4fP8h0PrkPJ8FKPIf9e49uWYzbI/3uXg+7lxJaks4hyveqYuExl1r5CJBNU7pxwUmq5pMeEcpUAyuiQW3gMLmWibZfVggKuee9I09qmK8qTQQWHyKSXvz+jyUU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1826449-207a-48ae-f729-08d719a030ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 12:26:51.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3776
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-05_06:2019-07-31,2019-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=917 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908050138
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since every chip has a different whoami, we are not supporting all
existing variant of all chips. Add an explicit supported chips
list in Kconfig description.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6=
050/Kconfig
index 395f3bd7de0a..e4c4c12236a7 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -14,8 +14,9 @@ config INV_MPU6050_I2C
 	select INV_MPU6050_IIO
 	select REGMAP_I2C
 	help
-	  This driver supports the Invensense MPU6050/6500/9150 and
-	  ICM20608/20602 motion tracking devices over I2C.
+	  This driver supports the Invensense MPU6000/6050/6500/6515,
+	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
+	  over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
=20
@@ -25,7 +26,8 @@ config INV_MPU6050_SPI
 	select INV_MPU6050_IIO
 	select REGMAP_SPI
 	help
-	  This driver supports the Invensense MPU6050/6500/9150 and
-	  ICM20608/20602 motion tracking devices over SPI.
+	  This driver supports the Invensense MPU6000/6050/6500/6515,
+	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
+	  over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
--=20
2.17.1

