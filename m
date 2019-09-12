Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D0B0D5D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfILK6l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:58:41 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:20824 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731298AbfILK6l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:58:41 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAtDEV012938;
        Thu, 12 Sep 2019 03:58:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=1+eq/nwvj82vzfIJxXfs/PzE+8W3aPtP5X/lR1mbnGM=;
 b=Ee3Yks7Ch+L9sBCIhSdyPROFWxLop8lhVF5I0QNeJj8pSbIs5GForIjU3DprvWxKkgC0
 Og9wtmQOWEmZFsVNakk0oIfrT3f9U4h0s9MWwnJVBWO0R7E8VqidStQU8ghS9dw+3J0D
 CPscem9+Ol5tcanZNo9Kmt1/jaLyMkJmsD/8rD+ImVh+OJiSqqmaID56q0K8KBnjS9lc
 RFIYkwYzvsHoiKMy6cjaM44I19Ly2EGiVNqczNywaNRkzC2R26OJ9325kLghh+e1ox/m
 SpC1HUTRedY4iwjM2b9iXR0goCnvmEYizOxcFBt7md6z+HkSVIm4TdjGo7qawq9ieL8w UQ== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
        by mx0b-00328301.pphosted.com with ESMTP id 2uv8gn2s9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCG3XLWq2JJuc5DdomYBOP9b30sYV758zfEijK/1NttYrjzUWfSaknBYx1drNIHqZnJm5SQ/AXgI5h4k+gQbDJFlj+Hd/p9x23KG2lsLtVZvXFANvqrBGauOyrr2VALqjhU9lmvyfwp18ppjrve4jxX7zrNW1e1rbeb4BzPtA1mnWlqRxI8NDFbjiA95KcLgoOLw3+qUBScJ5Rcf9RXrMlq8/YHWldBUR0UW00Mm9JAqopAPJ+eeVuzYi8LB9VZX8LMUc82A9V35ZxF1eFE6qWymwYGFg5XRoVLuQbmDihDdywmqb70ijLoYLXe8/YvDyL3yFChdqkNS/KGDYp/HEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+eq/nwvj82vzfIJxXfs/PzE+8W3aPtP5X/lR1mbnGM=;
 b=apSf/sVWoJ5aj7jKdqAcuZZc1eHG0Cf0+JR+awRFxbpXa5kCqyqrbU2qBC4OGXP01fEHCx/FZxueRPMlgzc7QHYGl5T/AYx1rg+R4hAqmPknxI2coI5XbuzwV+Pay/w1xLaOOHjuoSFSOd1/bZHrL3TL/lp0XKLm9LUkPrVnmGK3XUUXRhpAW6c3e1oEirKDvmc6F3KJUTl1PDeku8U7qWpT6Qj1VmbRdgWP4Yp2pQoyvPj7BqOP0WJ8GTuYjLjG7qfDboB60a6z3XUOZjR1l53QeJgTxNekRQMbMsnpMRQaboBpzZKpGVLfZT3xMBzy/jm67WXikYf9o8Dqn7m64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+eq/nwvj82vzfIJxXfs/PzE+8W3aPtP5X/lR1mbnGM=;
 b=NFLqPwFxieS5V/LnLW6NO76VvarUS3GMJTXN9svjJnZLEdxOEzf6LwTSWev4LcSN7zLvGgK+sENptRyreihrk+pooT/tB1Fzy+YuJ2L1c4cP3BpHysXKuZ3KtTgTcHhogpqkOg31e7rY4PmtwhDgyVkXaqo0NEVk5Ra1nsBdMCo=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:58:37 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:58:37 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 7/7] iio: imu: inv_mpu6050: add fifo support for
 magnetometer data
Thread-Topic: [PATCH v2 7/7] iio: imu: inv_mpu6050: add fifo support for
 magnetometer data
Thread-Index: AQHVaVkHqrNnPr7fmkeG9N0Jt7k2aw==
Date:   Thu, 12 Sep 2019 10:58:37 +0000
Message-ID: <20190912105804.15650-7-jmaneyrol@invensense.com>
References: <20190912105804.15650-1-jmaneyrol@invensense.com>
In-Reply-To: <20190912105804.15650-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9604de88-a289-497f-aa8c-08d7377029b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2911;
x-ms-traffictypediagnostic: MN2PR12MB2911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2911EE9CD1AB71F721335A72C4B00@MN2PR12MB2911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(86362001)(6116002)(3846002)(99286004)(54906003)(2351001)(1076003)(81166006)(81156014)(8676002)(71190400001)(71200400001)(14454004)(476003)(446003)(36756003)(25786009)(80792005)(52116002)(11346002)(2616005)(14444005)(256004)(486006)(6436002)(478600001)(76176011)(386003)(53936002)(305945005)(66066001)(6512007)(8936002)(6486002)(26005)(5640700003)(6916009)(102836004)(6506007)(2906002)(107886003)(50226002)(316002)(2501003)(5660300002)(66946007)(4326008)(66446008)(64756008)(66556008)(66476007)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2911;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /r4lh655nlP5Tn854M93BwPevX85mni/ygmJB8cpgSFuiiSpbjRVt72e4W+irloyizwwTwLKe+IkGA/GyspD9AHgNydHF9NsFJlO/zdfjj5V8Bk+Qfj/lof8LNw05azIFFxiiKOsOrRaZ+xTdgq5e3iYAgLW5IoBIJIvvwvxu91soNP1evQlB5mYdNUjSPyD7FiK3EStvAi2HxRzt/75VJ+Bj46JuNrUjQVcb1mZ0OSPcouZHfEVIDhAgtTuigXnH4egW2xJWQkPbTFUJKqJLUh5VwopTC44eJ0F+7UjgKE7RhknC9+KOQ0D6YfhAzL3uCsX48xpWgD4EwqCV58S5ICF5F/oSu1K7FHjCltDbsWiSFz8zIfJfa58EE3thtUhHZZVVCFfIM67Ylh+AIgR1v2exjFZP87gGdHakpmpwnk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9604de88-a289-497f-aa8c-08d7377029b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:58:37.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7puslD949PsjUBbXsAe/lza3ijCKaLkjvji+nOkpVgPt7RMF5MNpPPGOi6+AJWyWamujIss/OSC4tkREi1gZdhrSvcrWJHsUxvDMYGonkp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_05:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909120116
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

