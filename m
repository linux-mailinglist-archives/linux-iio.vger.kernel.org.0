Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B05A1F56
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfH2Pgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 11:36:48 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:7816 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfH2Pgs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 11:36:48 -0400
X-Greylist: delayed 1087 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 11:36:46 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9reo001995;
        Thu, 29 Aug 2019 08:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=eKJpu0FAG3xTlEJyaTt5j7RpzxzHKBb6JyV+n1KauIE=;
 b=AyIAolWKfPs7vA375sDowh4BgbcVQyG3lJAlKgzmsYLlZhHaPtw54fJYMr+hn8pLy5oy
 pS91bzWZsZwr5L02ttiY9xZboLtImPRrrg83hC1sgH46SiJviD0BKWgPnllPDokv2jfE
 k+WybbmURgYiO2J4N/Q/UrxGMYtohDVobvCJ/tyX0xzyYYYVavDAMnLLbIaHbkO71zXx
 xI/dx/HzZlHmio1BNd1k0pUcolRSAa6DGdQsHY8IdeEGTo1i1V6SOrHWiVDqJSuaSZDp
 Iiemoe7bDeiKYcOqqjP7reVZ9O+kFa+MmRlvtM/dxWbQRvsemqWGjuMN9e4vjFajkvs/ dg== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0b-00328301.pphosted.com with ESMTP id 2ukyymt18t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgXhtJIk8DRNRKWvo97Xn/4RCTvie8RMSUpul4WnbhwDudwI0EFJuaZs1EoKKhYcrBBq547SobwetXwJhyN3X4cU46iDoFFvuIPih20ZYolHn2kjS49Rr+Dp+DuLt/B8oO3ndwmKg6B04hWI+Nq9OP5HPfPiwmiFOU4SI71zjaSSR/jAthXtTQpkz3MTSiJPi9SQUrkrK38wC/EEw1lcudLWWm/Xz8yste6z9oKnduOYs3Kgi99GIzOdRXbIY86XWhtOJKsUCjx/u0uFXZDPEyOaSHyiOu5q1ENNi0vwS6AsaiUKWAwTvP9nzal8w0zPgFCD2zdD6xFjUjVMI+g0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKJpu0FAG3xTlEJyaTt5j7RpzxzHKBb6JyV+n1KauIE=;
 b=mA6lop09cHAFCpbQkWQC8W6mX7o/Q7ExuRpZYi4idswPVutySeEug1Q+3s7YuDurTsEYPfmfb7TQry0CkAByRH8bhTgUue8szj5L/A5uC+c7KGJGdO5ioCM7DSfPxDRkv3AnYDUA4jvCMWHU7Gu8eP1RfX1+HqTP7DLeJll2ZDq2nMyy+vnnnLdUOd8o7oXkDTLEn41fQMN5A1H+iZDiaJckQwgFsnoqr5cw0YGqQo69WbmWkojjMmyc17XE1cdYXSzAH9LgbItfSBxglpz9mvqxtk0y8W6p9gDwr1UdykSOZ3TvoBIJeadCT4Mps8My2frVg7aCE+UWUYnUCFy8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKJpu0FAG3xTlEJyaTt5j7RpzxzHKBb6JyV+n1KauIE=;
 b=K3CYOuVg+PUr/gVi1nMYZLlALk5imQD9u4o0iMpieqI1gZ6/NcT6M19GtZj8Z9aoCM59G8YXWfsjbxsRJ8rpv7eikcXw9EIpyvyOyT9C/sO/F+a5Md7Tlf69JwYVHJGPcBCY1SvckK5Ehsu8LkSG44++qUruvlLlMKlJTD2mKMY=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB3638.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 15:18:47 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:46 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 8/8] iio: imu: inv_mpu6050: add fifo support for magnetometer
 data
Thread-Topic: [PATCH 8/8] iio: imu: inv_mpu6050: add fifo support for
 magnetometer data
Thread-Index: AQHVXn0N9geTb3i1l0qss4zhN1di9Q==
Date:   Thu, 29 Aug 2019 15:18:46 +0000
Message-ID: <20190829151801.13014-9-jmaneyrol@invensense.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
In-Reply-To: <20190829151801.13014-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::29) To BYAPR12MB3366.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::15)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce490043-6b12-4977-a097-08d72c942fd1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3638;
x-ms-traffictypediagnostic: BYAPR12MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB363806675093049142479C9BC4A20@BYAPR12MB3638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(4326008)(6486002)(256004)(14454004)(1076003)(14444005)(316002)(26005)(102836004)(81166006)(66066001)(81156014)(386003)(6506007)(305945005)(86362001)(2351001)(6916009)(186003)(2501003)(80792005)(7736002)(36756003)(50226002)(2616005)(6512007)(8676002)(478600001)(71190400001)(71200400001)(64756008)(54906003)(66946007)(2906002)(66446008)(6116002)(52116002)(76176011)(66476007)(99286004)(66556008)(8936002)(446003)(486006)(107886003)(5640700003)(53936002)(11346002)(476003)(6436002)(5660300002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3638;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Sg1Wc33raqTqXrno/jQdawpZZ2RbvHtQWWPoN0ThW6v0oIDwDp4zziN0XoepcCXgcJaSwZkB6Pn2IP9XkY4bbSAQf9BJo+nk1Co31uIeKky1hePSctJLGaRX3DpvSrcENhv2KTPD61AOTQeK450W78VFaDjz5pCM3akkFiQ8iIcXYGdjzS8un7sobcXJJtgnHUfiqP0ewW6Q+ATAPOxYQtRkAy3en+/AE+2XmjsetaRFGMboHCc7frIgnvzvkv3lgEo2tKyj6ZOkd25D2d/Ro5VY8ChBmqF3cnOrZ6N+6kamd6DIj+ko64nddMwsmLjiIsb3lqG8xuPFR7JMh4S5jyfApHfgDCTlnlyg57sZ3Dty49aXNmai/spAJ4hhNrLV7YmNja3zcsBcy2xFqEk28uKdhwHAAw4m76PhFaivwk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce490043-6b12-4977-a097-08d72c942fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:46.8262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aGOKhD2ftsmeMUR2g+UGvj7rVeb8T690LNiVLhaZSoH/4ts2zoRgZyf9zOb2ufH7vkTdT7ZF2pavWjNPc9v+0UTBH1dbOxtskBaFGCUb2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_07:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908290164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Put read magnetometer data by mpu inside the fifo.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 14 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 90 +++++++++++++++++--
 4 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index d08cec6a8a7a..d4a321fd03a9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -105,6 +105,7 @@ static const struct inv_mpu6050_chip_config chip_config=
_6050 =3D {
 	.divider =3D INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE)=
,
 	.gyro_fifo_enable =3D false,
 	.accl_fifo_enable =3D false,
+	.magn_fifo_enable =3D false,
 	.accl_fs =3D INV_MPU6050_FS_02G,
 	.user_ctrl =3D 0,
 };
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index cfc11cb0a36c..48ed66e39cda 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -86,6 +86,7 @@ enum inv_devices {
  *  @accl_fs:		accel full scale range.
  *  @accl_fifo_enable:	enable accel data output
  *  @gyro_fifo_enable:	enable gyro data output
+ *  @magn_fifo_enable:	enable magn data output
  *  @divider:		chip sample rate divider (sample rate divider - 1)
  */
 struct inv_mpu6050_chip_config {
@@ -94,6 +95,7 @@ struct inv_mpu6050_chip_config {
 	unsigned int accl_fs:2;
 	unsigned int accl_fifo_enable:1;
 	unsigned int gyro_fifo_enable:1;
+	unsigned int magn_fifo_enable:1;
 	u8 divider;
 	u8 user_ctrl;
 };
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c
index 5f9a5de0bab4..f0a5350c1848 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -14,6 +14,7 @@
 #include <linux/poll.h>
 #include <linux/math64.h>
 #include <asm/unaligned.h>
+
 #include "inv_mpu_iio.h"
=20
 /**
@@ -124,7 +125,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
=20
 	/* enable interrupt */
 	if (st->chip_config.accl_fifo_enable ||
-	    st->chip_config.gyro_fifo_enable) {
+	    st->chip_config.gyro_fifo_enable ||
+	    st->chip_config.magn_fifo_enable) {
 		result =3D regmap_write(st->map, st->reg->int_enable,
 				      INV_MPU6050_BIT_DATA_RDY_EN);
 		if (result)
@@ -141,6 +143,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 		d |=3D INV_MPU6050_BITS_GYRO_OUT;
 	if (st->chip_config.accl_fifo_enable)
 		d |=3D INV_MPU6050_BIT_ACCEL_OUT;
+	if (st->chip_config.magn_fifo_enable)
+		d |=3D INV_MPU6050_BIT_SLAVE_0;
 	result =3D regmap_write(st->map, st->reg->fifo_en, d);
 	if (result)
 		goto reset_fifo_fail;
@@ -190,17 +194,19 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	}
=20
 	if (!(st->chip_config.accl_fifo_enable |
-		st->chip_config.gyro_fifo_enable))
+		st->chip_config.gyro_fifo_enable |
+		st->chip_config.magn_fifo_enable))
 		goto end_session;
+
 	bytes_per_datum =3D 0;
 	if (st->chip_config.accl_fifo_enable)
 		bytes_per_datum +=3D INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
-
 	if (st->chip_config.gyro_fifo_enable)
 		bytes_per_datum +=3D INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
-
 	if (st->chip_type =3D=3D INV_ICM20602)
 		bytes_per_datum +=3D INV_ICM20602_BYTES_PER_TEMP_SENSOR;
+	if (st->chip_config.magn_fifo_enable)
+		bytes_per_datum +=3D INV_MPU9X50_BYTES_MAGN;
=20
 	/*
 	 * read fifo_count register to know how many bytes are inside the FIFO
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c
index dd55e70b6f77..fa4928e589b9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -5,7 +5,7 @@
=20
 #include "inv_mpu_iio.h"
=20
-static void inv_scan_query(struct iio_dev *indio_dev)
+static void inv_scan_query_mpu6050(struct iio_dev *indio_dev)
 {
 	struct inv_mpu6050_state  *st =3D iio_priv(indio_dev);
=20
@@ -26,6 +26,52 @@ static void inv_scan_query(struct iio_dev *indio_dev)
 			 indio_dev->active_scan_mask);
 }
=20
+#ifdef CONFIG_INV_MPU6050_MAGN
+static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+
+	st->chip_config.gyro_fifo_enable =3D
+		test_bit(INV_MPU9X50_SCAN_GYRO_X,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_GYRO_Y,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_GYRO_Z,
+			 indio_dev->active_scan_mask);
+
+	st->chip_config.accl_fifo_enable =3D
+		test_bit(INV_MPU9X50_SCAN_ACCL_X,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_ACCL_Y,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_ACCL_Z,
+			 indio_dev->active_scan_mask);
+
+	st->chip_config.magn_fifo_enable =3D
+		test_bit(INV_MPU9X50_SCAN_MAGN_X,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_MAGN_Y,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_MAGN_Z,
+			 indio_dev->active_scan_mask);
+}
+#endif
+
+static void inv_scan_query(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+
+	switch (st->chip_type) {
+#ifdef CONFIG_INV_MPU6050_MAGN
+	case INV_MPU9250:
+	case INV_MPU9255:
+		return inv_scan_query_mpu9x50(indio_dev);
+#endif
+	default:
+		return inv_scan_query_mpu6050(indio_dev);
+	}
+}
+
 /**
  *  inv_mpu6050_set_enable() - enable chip functions.
  *  @indio_dev:	Device driver instance.
@@ -34,6 +80,11 @@ static void inv_scan_query(struct iio_dev *indio_dev)
 static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 {
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+	uint8_t d;
+	unsigned int gyro_skip =3D 0;
+	unsigned int accl_skip =3D 0;
+	unsigned int magn_skip =3D 0;
+	unsigned int skip_samples;
 	int result;
=20
 	if (enable) {
@@ -41,14 +92,13 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio=
_dev, bool enable)
 		if (result)
 			return result;
 		inv_scan_query(indio_dev);
-		st->skip_samples =3D 0;
 		if (st->chip_config.gyro_fifo_enable) {
 			result =3D inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 			if (result)
 				goto error_power_off;
 			/* gyro first sample is out of specs, skip it */
-			st->skip_samples =3D 1;
+			gyro_skip =3D 1;
 		}
 		if (st->chip_config.accl_fifo_enable) {
 			result =3D inv_mpu6050_switch_engine(st, true,
@@ -56,22 +106,40 @@ static int inv_mpu6050_set_enable(struct iio_dev *indi=
o_dev, bool enable)
 			if (result)
 				goto error_gyro_off;
 		}
+		if (st->chip_config.magn_fifo_enable) {
+			d =3D st->chip_config.user_ctrl |
+					INV_MPU6050_BIT_I2C_MST_EN;
+			result =3D regmap_write(st->map, st->reg->user_ctrl, d);
+			if (result)
+				goto error_accl_off;
+			st->chip_config.user_ctrl =3D d;
+			/* mag first sample is always not ready, skip it */
+			magn_skip =3D 1;
+		}
+		/* compute first samples to skip */
+		skip_samples =3D gyro_skip;
+		if (accl_skip > skip_samples)
+			skip_samples =3D accl_skip;
+		if (magn_skip > skip_samples)
+			skip_samples =3D magn_skip;
+		st->skip_samples =3D skip_samples;
 		result =3D inv_reset_fifo(indio_dev);
 		if (result)
-			goto error_accl_off;
+			goto error_magn_off;
 	} else {
 		result =3D regmap_write(st->map, st->reg->fifo_en, 0);
 		if (result)
-			goto error_accl_off;
+			goto error_magn_off;
=20
 		result =3D regmap_write(st->map, st->reg->int_enable, 0);
 		if (result)
-			goto error_accl_off;
+			goto error_magn_off;
=20
-		result =3D regmap_write(st->map, st->reg->user_ctrl,
-				      st->chip_config.user_ctrl);
+		d =3D st->chip_config.user_ctrl & ~INV_MPU6050_BIT_I2C_MST_EN;
+		result =3D regmap_write(st->map, st->reg->user_ctrl, d);
 		if (result)
-			goto error_accl_off;
+			goto error_magn_off;
+		st->chip_config.user_ctrl =3D d;
=20
 		result =3D inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
@@ -90,6 +158,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio=
_dev, bool enable)
=20
 	return 0;
=20
+error_magn_off:
+	/* always restore user_ctrl to disable fifo properly */
+	st->chip_config.user_ctrl &=3D ~INV_MPU6050_BIT_I2C_MST_EN;
+	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
 error_accl_off:
 	if (st->chip_config.accl_fifo_enable)
 		inv_mpu6050_switch_engine(st, false,
--=20
2.17.1

