Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011B8B374F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfIPJmM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:42:12 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:46068 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729494AbfIPJmL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 05:42:11 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G9eoe4021657;
        Mon, 16 Sep 2019 02:42:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=1+eq/nwvj82vzfIJxXfs/PzE+8W3aPtP5X/lR1mbnGM=;
 b=kCQLrubGy1xeUtedJdU4oZu8ER207vCMULGc0YUbNhpY5fLx4eJAWRMOz917Imh9jUc/
 WmR1b/4BsXZWZTRxt3ruiLQOFzeYBOUdqtkiYRL1Odh/Y3N7RJKJ3ViYOOMkFEc20PYd
 DChrMaeg9NtFPPQ0/HG2iukY00278WiKuW+ffGDK2xcaKHH3B4zdAifsG8xJaWaR9qGr
 ejLnS2y3aq6gZ1mpfbZKgenmimHjGAF474rmncbCk4VhBKUq3J56chdtgO1n1/IPFAg1
 JYezyPhVHVtCWtd8/uXt97MD5crI6dwTkAb4dmjFtIKN4EyB4AG2flPf4tA6l/4QEoOQ mg== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2051.outbound.protection.outlook.com [104.47.34.51])
        by mx0a-00328301.pphosted.com with ESMTP id 2v0upprngh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPsCvJIqAVVV/dbbCi1vzREOjy3cJ/ShceHUHBVV0w8RlAUkfFDrxiMwL2UtCiMgWsAzuxeJp4JHjDHkFV0dSLh3Cu5m3lMunh5AsLwQA7UbeJjdWPY1T9ZoempSUofTSnUIN6jxzeFLS5ggyDbOuWtxpEMJ8dQXoJHKYRNH46fCnFmwyrTmfmnQ8wsaXzByTVLZ9dUdIzfsrtyJpqTYTuDSMaf/ft9oaw8YlVtKP/55JZ2VJ9fFjQU5bwEbDZQ+E4JKyjn6r0DxWZjg9ovLwI87IZYq50cVHEwnBi8uXqyF4N2DZj1OJCrylRdmuw83b2uUuso9bA8RgSYlvFFFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+eq/nwvj82vzfIJxXfs/PzE+8W3aPtP5X/lR1mbnGM=;
 b=mnFPu0DVznqzXCYEPx6xcjKY/DuxywV10Qc5m9MwBVeGm7y606ech6pWi+Jc2/1lx7qxac4pgTI/ZdGETc9xaF3leYgx+geRz5LiVk94Bwj5OIfm3p5mcNmh1iJvdQjNOpyAwv29I41BjjDPlFkofygRnyNrzYfaktTayAG8xHzsoafUmYqMI5Mty/HD/xfsDcEtC/9TzxfA3MBKzpDXD4kEyMfZpGKiZeMRx4Xenrb5w5JRvz7reQObQcdk9jGWKVYXpztn2cUK3XGtqtggkkotlTA5hULNUiOvFPUW6wt4Uki52+TnzG9Ok42qR1ymFiPEDGKRJMF3Fad8R2psBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+eq/nwvj82vzfIJxXfs/PzE+8W3aPtP5X/lR1mbnGM=;
 b=Hij4sA7MbraUQcT8sQs4xO7ua3aKOSKJ3RNfW/fGQQCJ80Qx8VFTqx3BldFK9EENhGNwVsUQnpRoS8QYc103EWKVziP8VwO3oqIw1AI8ksTm4aoGPiMRp1WJ54Cg1Mj9jG+aFbEYoOPGTQKrw2oGICRpWqKlh2GlOskjp/Hd5Nw=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2632.namprd12.prod.outlook.com (20.176.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 09:42:09 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:42:09 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v3 7/7] iio: imu: inv_mpu6050: add fifo support for
 magnetometer data
Thread-Topic: [PATCH v3 7/7] iio: imu: inv_mpu6050: add fifo support for
 magnetometer data
Thread-Index: AQHVbHMCQpk/5dAC+0Sq68NzJIITJg==
Date:   Mon, 16 Sep 2019 09:42:09 +0000
Message-ID: <20190916094128.30122-8-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: b0c1c09c-5fd7-4708-14f8-08d73a8a2496
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2632;
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB263291B16191E6F7F49ED19DC48C0@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(81166006)(99286004)(3846002)(5660300002)(66066001)(2616005)(54906003)(5640700003)(316002)(6916009)(36756003)(71200400001)(6512007)(11346002)(446003)(102836004)(26005)(6486002)(6506007)(2501003)(71190400001)(386003)(2906002)(6436002)(1076003)(305945005)(4326008)(53936002)(7736002)(186003)(6116002)(81156014)(8676002)(52116002)(107886003)(66476007)(25786009)(66446008)(76176011)(2351001)(66946007)(66556008)(8936002)(64756008)(50226002)(80792005)(256004)(14444005)(14454004)(476003)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2632;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MyGPUWCji8+ZY7NvfK203dbXeeATcfqz/slU6Xb1bKMSH6NQ/7mmCEF6D/JVRuHZ6dCqma9UaHcvniLCjjWoR0mxj2VRHUpqS6+8DLv+ywOaA4hu0hdlKt9f+OUwubvVQoQgwxeBS85usTLC2eWCbUyjxQUyCA8Mjr560dc6cDuQwjcGHA+OWFEOxhdC8c5N6z/a7CP/K5j7yLxM07InudWJ/IJ8XcMwpCskS3kBjRmcuoVYgeDTKMt/r+l52s2+kyHjmtMEkcv6tBhOwH3Qtbna1Bb74tJjN7/VhQ4zqAKHYqVw5B1JEEHmLf9j+7LcUa6JeTfem9IKF8h81rDZslEZUnhGUn3b4Pquf3s/H52tN3XaCNK/8E6Zl9W4B1rlMR9X6RyJGvdrpd9V4ngiXAk8NU5NNFCnIzRxBRfyleE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c1c09c-5fd7-4708-14f8-08d73a8a2496
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:42:09.4205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBoXcyYbzeaMMtGbgMUI2qgdoakNxNC8MueriXwBT1h1Tn9padFD7Hb0eiIOHiUdj4LUCZMErws1/BulHlswkb++JR6gUA7Z+YEIGyYtpsg=
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

Put read magnetometer data by mpu inside the fifo.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 86 ++++++++++++++++---
 4 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index f1c65e0dd1a5..354030e9bed5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -104,6 +104,7 @@ static const struct inv_mpu6050_chip_config chip_config=
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
index 953f85618199..52fcf45050a5 100644
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
index 5f9a5de0bab4..bbf68b474556 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -124,7 +124,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
=20
 	/* enable interrupt */
 	if (st->chip_config.accl_fifo_enable ||
-	    st->chip_config.gyro_fifo_enable) {
+	    st->chip_config.gyro_fifo_enable ||
+	    st->chip_config.magn_fifo_enable) {
 		result =3D regmap_write(st->map, st->reg->int_enable,
 				      INV_MPU6050_BIT_DATA_RDY_EN);
 		if (result)
@@ -141,6 +142,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 		d |=3D INV_MPU6050_BITS_GYRO_OUT;
 	if (st->chip_config.accl_fifo_enable)
 		d |=3D INV_MPU6050_BIT_ACCEL_OUT;
+	if (st->chip_config.magn_fifo_enable)
+		d |=3D INV_MPU6050_BIT_SLAVE_0;
 	result =3D regmap_write(st->map, st->reg->fifo_en, d);
 	if (result)
 		goto reset_fifo_fail;
@@ -190,7 +193,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	}
=20
 	if (!(st->chip_config.accl_fifo_enable |
-		st->chip_config.gyro_fifo_enable))
+		st->chip_config.gyro_fifo_enable |
+		st->chip_config.magn_fifo_enable))
 		goto end_session;
 	bytes_per_datum =3D 0;
 	if (st->chip_config.accl_fifo_enable)
@@ -202,6 +206,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	if (st->chip_type =3D=3D INV_ICM20602)
 		bytes_per_datum +=3D INV_ICM20602_BYTES_PER_TEMP_SENSOR;
=20
+	if (st->chip_config.magn_fifo_enable)
+		bytes_per_datum +=3D INV_MPU9X50_BYTES_MAGN;
+
 	/*
 	 * read fifo_count register to know how many bytes are inside the FIFO
 	 * right now
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c
index dd55e70b6f77..d7d951927a44 100644
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
@@ -26,6 +26,60 @@ static void inv_scan_query(struct iio_dev *indio_dev)
 			 indio_dev->active_scan_mask);
 }
=20
+static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+
+	inv_scan_query_mpu6050(indio_dev);
+
+	/* no magnetometer if i2c auxiliary bus is used */
+	if (st->magn_disabled)
+		return;
+
+	st->chip_config.magn_fifo_enable =3D
+		test_bit(INV_MPU9X50_SCAN_MAGN_X,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_MAGN_Y,
+			 indio_dev->active_scan_mask) ||
+		test_bit(INV_MPU9X50_SCAN_MAGN_Z,
+			 indio_dev->active_scan_mask);
+}
+
+static void inv_scan_query(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		return inv_scan_query_mpu9x50(indio_dev);
+	default:
+		return inv_scan_query_mpu6050(indio_dev);
+	}
+}
+
+static unsigned int inv_compute_skip_samples(const struct inv_mpu6050_stat=
e *st)
+{
+	unsigned int gyro_skip =3D 0;
+	unsigned int magn_skip =3D 0;
+	unsigned int skip_samples;
+
+	/* gyro first sample is out of specs, skip it */
+	if (st->chip_config.gyro_fifo_enable)
+		gyro_skip =3D 1;
+
+	/* mag first sample is always not ready, skip it */
+	if (st->chip_config.magn_fifo_enable)
+		magn_skip =3D 1;
+
+	/* compute first samples to skip */
+	skip_samples =3D gyro_skip;
+	if (magn_skip > skip_samples)
+		skip_samples =3D magn_skip;
+
+	return skip_samples;
+}
+
 /**
  *  inv_mpu6050_set_enable() - enable chip functions.
  *  @indio_dev:	Device driver instance.
@@ -34,6 +88,7 @@ static void inv_scan_query(struct iio_dev *indio_dev)
 static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 {
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+	uint8_t d;
 	int result;
=20
 	if (enable) {
@@ -41,14 +96,11 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio=
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
-			/* gyro first sample is out of specs, skip it */
-			st->skip_samples =3D 1;
 		}
 		if (st->chip_config.accl_fifo_enable) {
 			result =3D inv_mpu6050_switch_engine(st, true,
@@ -56,22 +108,32 @@ static int inv_mpu6050_set_enable(struct iio_dev *indi=
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
+		}
+		st->skip_samples =3D inv_compute_skip_samples(st);
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
@@ -90,6 +152,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio=
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

