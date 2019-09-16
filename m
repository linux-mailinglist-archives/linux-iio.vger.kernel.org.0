Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB3B374D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfIPJmI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:42:08 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:40260 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729474AbfIPJmH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 05:42:07 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G9bq3b020213;
        Mon, 16 Sep 2019 02:42:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=JAKwGiFTFotUo8jb0RCLXa/EiExAAk96mejMPX5/rlHwHF6aVryPuKabKH/Isf79/iBv
 Hsf75zAzXzST0ri989xL+MAUj+Tmgg42dIRhXic3zLrGDB/FtfOEAxXswQdG/JNUmIua
 lh3+MAr0TVcFA53SQtVPvcK/bltLzyAGKEilcU8uIT/sJR23ligmjJVSVjKJhcBGe49y
 Tt1vferTPdnnkiWA3SXeBKXimD9kv2Zl1pWk4ya0krU9AUdKYNnguVzLstuHdlytA6NK
 XPHT6pIAgfFcu/PCnD8oysk88IGwjto1fa/R6ovzPLPuR1okKE6eM2Z7y4grX6Lbs5l7 4A== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2050.outbound.protection.outlook.com [104.47.34.50])
        by mx0b-00328301.pphosted.com with ESMTP id 2v152crh4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEvdRdpm8MYvQMVPYB0GI+OIaDLTz9XrHG2aPrJVa88hHUM90j7qve/ky8m/88lVilUVGUAqW3OHifZYzXvj4IycOmPjhPDb49h4ys2sdbdVvX9FcDXq1X1Gt12ya19WspBsKuby5iY/CtL27ycivs4Uj2irWvnT5ZyDN/oKZoZNqCtCinvZGaASXy+WhT6xS0VHJMAfzk/izW04dXw3D3iNlP+hlXH6nf5hIUfuPMLn0qjATCH/CmIRXt5cjli4CPzlIzOtgIdCRrKubZFGAtMvYRopnIfjCHpcRzS2wl3DSvcVTuB6UeCiH9eolYuQuBJ2/1Vqgi6PWaf3xSqBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=IVnSy6av/79X1qATDyWAmeWAklFus2Pxxr82YRSsTKk4zTbrMqEGDWnrhcKG2iygz7JLCp7+WtT7jUpYGB+fXxtVKZ0D7+hTSRGrRvAtMMC1ZQ5tNmo43ku3SIT/si7KVw/6OHuimOPp+CAOTVpr0WJNQLy891qFjH2KmTtGNXu4Ru5JAKw2+9NV6UO92hzLQJBvP5fLDyxbDAyIJqNBIGdIVMjO0UjSSkEWGlm+PD08NrMpRoO1jaqeECeyK6m0F9Akjyr06hT29OtkNvAxvuTrJ0EdkaSeHnmwYbWMlaZZbLq9aOUyWad9tTROUabDn/Zz5duz93WdOFDRHJJ63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=I62V6GVBRmtLEKnHD3gqShp27nu/wOi/UFk9GAmXsuwhEgl2pYhg8gxZfTbH+5OuEOD+T2NLiXItYWkHs2Q0yiwTt9etkN2S6X1RecRKuxqZgPgoK8wa2QcvqhEGrSQKNbzemFJr0pCzUGafOTnezK0ssZ9i0l6ehwgGIRP+szU=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2632.namprd12.prod.outlook.com (20.176.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 09:42:04 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:42:04 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v3 4/7] iio: imu: inv_mpu6050: fix objects syntax in Makefile
Thread-Topic: [PATCH v3 4/7] iio: imu: inv_mpu6050: fix objects syntax in
 Makefile
Thread-Index: AQHVbHL/LpHLz1dnzk6xA7nwUTCyTg==
Date:   Mon, 16 Sep 2019 09:42:04 +0000
Message-ID: <20190916094128.30122-5-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
In-Reply-To: <20190916094128.30122-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR12MB3366.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::15)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 240e3366-04a4-471d-e8df-08d73a8a2175
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2632;
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB263294EB77C825C15ADE864EC48C0@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(81166006)(99286004)(3846002)(5660300002)(66066001)(2616005)(54906003)(5640700003)(316002)(6916009)(36756003)(71200400001)(6512007)(11346002)(446003)(102836004)(26005)(6486002)(6506007)(2501003)(71190400001)(386003)(4744005)(2906002)(6436002)(1076003)(305945005)(4326008)(53936002)(7736002)(186003)(6116002)(81156014)(8676002)(52116002)(107886003)(66476007)(25786009)(66446008)(76176011)(2351001)(66946007)(66556008)(8936002)(64756008)(50226002)(80792005)(256004)(14454004)(476003)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2632;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mjfqC7VtvhI3JKKW+bQ6G6u2chlGMqplquPx++KAkilgXCR/axJn+VgFgTfNIU7EegbU7dXf+9RdxwCqPFE3wU8TzG0S+QMJEvjY0nRLPNxS0kD8DtMZ601A7eV/40waJ54W2b8ZSAVsOSDtIJeE30vqSAajo0WFmIiBlhNUf0ZudM9xRgXr2uOHn4Q11aOkopqVxss0LcshqtZeLRrI8/hQCOEOMAvYSchTxkuGZX3wtQRfqGgKaZQPq7gMlEb0klE3A5sfURjNeW07c09HVR91ay7sq2iOtUwwAQkI9XS8hc8YSaPOqDWIkxsfH5Dc+4pMOFAkZ65AueRraPcK9l5vJuZIy4PWLdvCDNtMFtpRoSRNfGKDf3S7b/GHQ0zl8tXjecfuKNvtE+r2kHY4I8ydAvg9Oo1gikwJNjSHCps=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240e3366-04a4-471d-e8df-08d73a8a2175
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:42:04.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Lu/eYfaaO40fSV9eR4ceDSZwFF3XcWyxB8+g7D5nkFer0kl3/tuRToF7ZbYVBbFY4z5x1qgcguMIZwsOH7r0RUrvHThljwOIY/z4BHEL/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_05:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=926 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the correct syntax *-y for declaring object files.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu=
6050/Makefile
index 70ffe0d13d8c..33bec09fee9b 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -4,10 +4,10 @@
 #
=20
 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o
-inv-mpu6050-objs :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
+inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
=20
 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
-inv-mpu6050-i2c-objs :=3D inv_mpu_i2c.o inv_mpu_acpi.o
+inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o
=20
 obj-$(CONFIG_INV_MPU6050_SPI) +=3D inv-mpu6050-spi.o
-inv-mpu6050-spi-objs :=3D inv_mpu_spi.o
+inv-mpu6050-spi-y :=3D inv_mpu_spi.o
--=20
2.17.1

