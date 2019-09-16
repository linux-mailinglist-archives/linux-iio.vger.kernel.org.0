Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1DB374C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfIPJmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:42:05 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:41938 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729474AbfIPJmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 05:42:04 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G9eoiS021660;
        Mon, 16 Sep 2019 02:42:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=qSrvncP8uZjIPGyIqTJfnOHst250avxl5ofrnHdGELs=;
 b=q5AC8cQUkJDjPXzvkuqpqhDDfMqpV7oA1ytV6y6IPocloIVDgle8yBTziAlJaYzx3OSg
 YeO8nFT6IGC6uu62i7El4nCVjm8vbQyVri+7fm2ryhEmFjUsqIh7pY5vKopQzunlWYkY
 hZEn1m14aZqLIHjYsB94L0OGZqPUnrQGDmcR1bZoU0MaW8nspCvZnHcEoJ8nJsLHHsd1
 zvMVvI5dHtBgcb8nloPeTHigZlH/oe2+gO+3hzJiv0TgATkPii4fGpFu71gRsuSAMLNZ
 fSx25DZC3tDZyrbMlxVHWV4qFflBRjDOiOPncT81sUfd7wJgof35YWhq0db9IQrLG2Aw sg== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2057.outbound.protection.outlook.com [104.47.34.57])
        by mx0a-00328301.pphosted.com with ESMTP id 2v0upprnga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8KMo2BSDp7Ip93Ake3sJkoMTHKQtnQCahzxDQlHD9zI2yX2MNx2RINpkdBJTQDQudCOO/N7gAW6ZojCYzE362yaV/4eif8D3CNgCKCRZbzpIcuJ5CXEaC+Xu53XyFCEuGm15oVKZ/Xsus2Yw/yJAG8i8JUN0FtHuBSLHJpvCLwbtI6uhoKVncbbItV4iFjcfqt565ALnckYQycR7tdufhWxOd8OyZ4LbfSEw+TQG1cTKvGEul4M32DewUqfFimb36o3g5SSvR0J4ohqJH460cGfSlXvQIJyJSnyTebnW6MPi4nI+R0rvil+/WzUvMxbx7RDzvCL/DJ4PtsG1Q6DIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSrvncP8uZjIPGyIqTJfnOHst250avxl5ofrnHdGELs=;
 b=XfPixynlH+eO/oZP0tvq7sEhwvCQisbC3BgtYsz5OSAAXW9CPtrCDXOQjDEcFvc5mIab59CNauKtXMaGSTjp/sD5C9Rp0HIthnhKgftnKZNaBnKhupcTFCE7WBj4JejLYDFoK/1p9oPoYGfk6mMsd+v2fca+CPnQ4/sLgHPoxxQeDH6sJ3e/OK+l5BD/LA90+m/Kt2mM8IcnlvO2hNjIVFlTHs9sq1GLJ2iGQaHFqS1WA+2K5APshKoS3NE3OEzYY+x/qTtATnVloRB+RsPGDiCAW/cQ/b4LDkglE0sgq3tiCWwhLFQcBDjQVGAn4+lhrV9LmHP2DOQQ6lp68pnacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSrvncP8uZjIPGyIqTJfnOHst250avxl5ofrnHdGELs=;
 b=NBoLJ1nHf0Sh1sSudj3kl4yMzpobOtP0Y3Je9jMkuzSe6tJxk358K+ik/BP4FP5+c9FGNCj2l6iFHG44IBgEpHEp+DTDoRFeLvPCyx//GzYJ6ib/YpTksDDTUSGrI7ZUJKt7SNBYmnIFmp7jbYqaXrCbnJqlb9t5CH21kBWuGEQ=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2632.namprd12.prod.outlook.com (20.176.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 09:42:02 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:42:02 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v3 3/7] iio: imu: inv_mpu6050: add defines for supporting
 9-axis chips
Thread-Topic: [PATCH v3 3/7] iio: imu: inv_mpu6050: add defines for supporting
 9-axis chips
Thread-Index: AQHVbHL+J7h7nl2urk6vBLijqUnoeA==
Date:   Mon, 16 Sep 2019 09:42:02 +0000
Message-ID: <20190916094128.30122-4-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 8fb5b615-6410-4906-116e-08d73a8a2067
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2632;
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB263269FB7641253A8D69DB40C48C0@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(81166006)(99286004)(3846002)(5660300002)(66066001)(2616005)(54906003)(5640700003)(316002)(6916009)(36756003)(71200400001)(6512007)(11346002)(446003)(102836004)(26005)(6486002)(6506007)(2501003)(71190400001)(386003)(2906002)(6436002)(1076003)(305945005)(4326008)(53936002)(7736002)(186003)(6116002)(81156014)(8676002)(52116002)(107886003)(66476007)(25786009)(66446008)(76176011)(2351001)(66946007)(66556008)(8936002)(64756008)(50226002)(80792005)(256004)(14444005)(14454004)(476003)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2632;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VrXjfVYRRH4POfVAbVGyFOAPXyTKYcbolu/WkbEpUCnQNouU8ucnZJ1mlmdjpPxYzvnPUFu7RSG20/VHK/MRVRq++sSjWWrqgQoVSRsOb2y2EX/4P9hKA04k+fv9PDrAtvErRBLaHrA+7BlRUz+ds9gGZz69PDFoOurf0qVxoZsswt8tnyf1G4EvGCg/QtIU7EAeWVIv2rm9VdVe0M7dpusnMtD8ijif9UMSg6jQYN7hhwkBwtViynpOHDhKbdqw8uKDIl8SGGG3dBgKwZ1S9lhw0+HL/wcBC/HqJh9lm8V5oqNpMskzB2TpfQniDe9D0B/jzf1u5B/Y4S0LEQ7kFqQybls0L11KuWoYN99WbOODlhIQjNfp1kexbzQnC6jMFzkuCVNWBcSFespwfcq0ojGUKgPcRgOUT6K0uDMfVV4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb5b615-6410-4906-116e-08d73a8a2067
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:42:02.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bV2kEY32WpHXaV49j5cBmtTl1TO/m++Kit7V02KfiIGqOTea0DYT1rC95OGHmGvwYQDS5LD47wnqRnVxvsSTT8hMrU/ZTiX0MEmpJLoxTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_05:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909160102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add registers defines required for driving chip i2c master ip.
Add MPU9xxx magnetometer scan elements and update data bytes size.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 56 ++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index 7cfd3a05c144..04215bc6e8ab 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -164,9 +164,41 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_ACCEL_CONFIG        0x1C
=20
 #define INV_MPU6050_REG_FIFO_EN             0x23
+#define INV_MPU6050_BIT_SLAVE_0             0x01
+#define INV_MPU6050_BIT_SLAVE_1             0x02
+#define INV_MPU6050_BIT_SLAVE_2             0x04
 #define INV_MPU6050_BIT_ACCEL_OUT           0x08
 #define INV_MPU6050_BITS_GYRO_OUT           0x70
=20
+#define INV_MPU6050_REG_I2C_MST_CTRL        0x24
+#define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D
+#define INV_MPU6050_BIT_I2C_MST_P_NSR       0x10
+#define INV_MPU6050_BIT_SLV3_FIFO_EN        0x20
+#define INV_MPU6050_BIT_WAIT_FOR_ES         0x40
+#define INV_MPU6050_BIT_MULT_MST_EN         0x80
+
+/* control I2C slaves from 0 to 3 */
+#define INV_MPU6050_REG_I2C_SLV_ADDR(_x)    (0x25 + 3 * (_x))
+#define INV_MPU6050_BIT_I2C_SLV_RNW         0x80
+
+#define INV_MPU6050_REG_I2C_SLV_REG(_x)     (0x26 + 3 * (_x))
+
+#define INV_MPU6050_REG_I2C_SLV_CTRL(_x)    (0x27 + 3 * (_x))
+#define INV_MPU6050_BIT_SLV_GRP             0x10
+#define INV_MPU6050_BIT_SLV_REG_DIS         0x20
+#define INV_MPU6050_BIT_SLV_BYTE_SW         0x40
+#define INV_MPU6050_BIT_SLV_EN              0x80
+
+/* I2C master delay register */
+#define INV_MPU6050_REG_I2C_SLV4_CTRL       0x34
+#define INV_MPU6050_BITS_I2C_MST_DLY(_x)    ((_x) & 0x1F)
+
+#define INV_MPU6050_REG_I2C_MST_STATUS      0x36
+#define INV_MPU6050_BIT_I2C_SLV0_NACK       0x01
+#define INV_MPU6050_BIT_I2C_SLV1_NACK       0x02
+#define INV_MPU6050_BIT_I2C_SLV2_NACK       0x04
+#define INV_MPU6050_BIT_I2C_SLV3_NACK       0x08
+
 #define INV_MPU6050_REG_INT_ENABLE          0x38
 #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
 #define INV_MPU6050_BIT_DMP_INT_EN          0x02
@@ -179,6 +211,18 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
=20
+#define INV_MPU6050_REG_EXT_SENS_DATA       0x49
+
+/* I2C slaves data output from 0 to 3 */
+#define INV_MPU6050_REG_I2C_SLV_DO(_x)      (0x63 + (_x))
+
+#define INV_MPU6050_REG_I2C_MST_DELAY_CTRL  0x67
+#define INV_MPU6050_BIT_I2C_SLV0_DLY_EN     0x01
+#define INV_MPU6050_BIT_I2C_SLV1_DLY_EN     0x02
+#define INV_MPU6050_BIT_I2C_SLV2_DLY_EN     0x04
+#define INV_MPU6050_BIT_I2C_SLV3_DLY_EN     0x08
+#define INV_MPU6050_BIT_DELAY_ES_SHADOW     0x80
+
 #define INV_MPU6050_REG_USER_CTRL           0x6A
 #define INV_MPU6050_BIT_FIFO_RST            0x04
 #define INV_MPU6050_BIT_DMP_RST             0x08
@@ -206,6 +250,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
 #define INV_MPU6050_FIFO_COUNT_BYTE          2
=20
+/* MPU9X50 9-axis magnetometer */
+#define INV_MPU9X50_BYTES_MAGN               7
+
 /* ICM20602 FIFO samples include temperature readings */
 #define INV_ICM20602_BYTES_PER_TEMP_SENSOR   2
=20
@@ -233,8 +280,8 @@ struct inv_mpu6050_state {
 #define INV_ICM20602_TEMP_OFFSET	     8170
 #define INV_ICM20602_TEMP_SCALE		     3060
=20
-/* 6 + 6 round up and plus 8 */
-#define INV_MPU6050_OUTPUT_DATA_SIZE         24
+/* 6 + 6 + 7 (for MPU9x50) =3D 19 round up to 24 and plus 8 */
+#define INV_MPU6050_OUTPUT_DATA_SIZE         32
=20
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_ACTIVE_HIGH		0x00
@@ -283,6 +330,11 @@ enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_GYRO_Y,
 	INV_MPU6050_SCAN_GYRO_Z,
 	INV_MPU6050_SCAN_TIMESTAMP,
+
+	INV_MPU9X50_SCAN_MAGN_X =3D INV_MPU6050_SCAN_GYRO_Z + 1,
+	INV_MPU9X50_SCAN_MAGN_Y,
+	INV_MPU9X50_SCAN_MAGN_Z,
+	INV_MPU9X50_SCAN_TIMESTAMP,
 };
=20
 /* scan element definition for ICM20602, which includes temperature */
--=20
2.17.1

