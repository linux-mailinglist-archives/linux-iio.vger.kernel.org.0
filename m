Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43450B0D5E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfILK6n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:58:43 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:20132 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731294AbfILK6m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:58:42 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAt1io012325;
        Thu, 12 Sep 2019 03:58:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=8GWKfZDi3BOUIwnrimpfRqeOg+WJDaylDOMJs6xHCgU=;
 b=kphYfYwAUj6TfGpMfTEVk5k7PyWirovFcAkHucwGO2K/xEf8/U4YUfJRVp9lg44oaXF/
 7iyTRDn8bvk6xlGvUlP6yvQ9yyS3s/Tq+gPgqffulxpdUKPavNL9CIQ/rnIzVvYGinq2
 HEa0YBZPaeOdN9ubT+HubUWlzWJonW1aUWfVfHGiN6UJeKHIMAy4QzSlSfogIu3Gnvh9
 rYLsVaAz06tQmYHwZBELFha7xf+8/pPNhDCHcS464f+NZ/7icWUPKJ3WKoZnGk2XUxFe
 6tacCN9eDoErweSrdObPv1qpRItNlMg6MTsff2udDeIlzg9XyBz9HI/DH2toVR9jxB3E KA== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2051.outbound.protection.outlook.com [104.47.49.51])
        by mx0b-00328301.pphosted.com with ESMTP id 2uv8gn2s9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5orphf+KlbHB7N5jOzH+KK5dm/TDt9Dq+11dKU1r2iXh9ke8rX9EI16UpjqIccIm5KcwmvpVX7/zEkjwvLL7ym4OdqymwJ+gbjQ2ju7brVdgbMFnua+PDQHozbnhsQALRQRRLnEhRBwQIu0LTdlUgzC3fuufmkmFrzDtkBIeVhzlS6IIoJMj6RiBCeVr04nZUhJSZFM5c4BatoYUYTY3EfrTU4xE/zAYuYob3Q0u2NoZP4Qa77BDl5NMWB/yx36cecVvs/78oPd+3m8KZqKQ0vVS+IYZBiszKwpmcPLTEMx7inPqZdFMigvIbawv5SgJLbcVxoUzz4rIxvRk4YGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GWKfZDi3BOUIwnrimpfRqeOg+WJDaylDOMJs6xHCgU=;
 b=eT9Q6/nbWgMJe0YVuR8zo3iBA8+lpZBQisUqZksWlI4zeGjMokf+e8oSTOgsjSVyXTOr5PtlD+0X5eNHGbcZ94QYjCpkbh0TvERK4EDyPLP1PTuw/Xm58WI81w9dFJKPw6Wfe19qzAzyAV7Cg1qC7MyoRQc7g/sEaC5fPFeLc9YUzzw2NexhnlJZerWdNTZSWi8Ia9Q2VF0mXWKczq6dsqnSrM6h6AsqhctOJ8RBTR1bCEV4OXW+Wqd3isR0WkGpwweMOP55OCWPQMVNoKbUOPLpT6g2f0f5uLcvPLDYJvsPodxQly+JNDE5sZdYLwmWKDcDKr0NO0Nyq1CrC5mGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GWKfZDi3BOUIwnrimpfRqeOg+WJDaylDOMJs6xHCgU=;
 b=UY8hsiIEONB9wLzEKpxL/GhV+IWSiQDxkeUQsyM+IPobFrhlPok0pK9y3k5s/isvb+CfUly6ECJDRJErDz2H+misTRSizzSrJ8jcz8Brc+3IPqUSgHaHaiTu1ELzzKi9TKHPExisgj30b5ktNhfU0U9PtXG8pLHFwW82OXAUqAQ=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:58:36 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:58:36 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 6/7] iio: imu: inv_mpu6050: add MPU925x magnetometer
 support
Thread-Topic: [PATCH v2 6/7] iio: imu: inv_mpu6050: add MPU925x magnetometer
 support
Thread-Index: AQHVaVkG052q11dNIkq4KAkIiMgs1w==
Date:   Thu, 12 Sep 2019 10:58:36 +0000
Message-ID: <20190912105804.15650-6-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 5b20a485-87d1-41a2-89c8-08d7377028d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2911;
x-ms-traffictypediagnostic: MN2PR12MB2911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29118666F2D97FE4C94F047AC4B00@MN2PR12MB2911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(86362001)(6116002)(30864003)(3846002)(99286004)(54906003)(2351001)(1076003)(81166006)(81156014)(8676002)(71190400001)(71200400001)(14454004)(476003)(446003)(36756003)(25786009)(80792005)(52116002)(11346002)(2616005)(14444005)(256004)(486006)(6436002)(478600001)(76176011)(386003)(53936002)(305945005)(66066001)(53946003)(6512007)(8936002)(6486002)(26005)(5640700003)(6916009)(102836004)(6506007)(2906002)(107886003)(50226002)(316002)(2501003)(5660300002)(66946007)(4326008)(66446008)(64756008)(66556008)(66476007)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2911;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nLykvjkTsHMgE0nhoc+ttG8i5S0NDZZFjpx7sGEURffkpfJHwaXE+sdGpi+cyL6yBATu8Wv8T9JKQcvhSAZ5fmHfZRq1aQQ+8xUm7CNGzxzZVRMQt+FFw52jDUY0luU1AeUv9UGphpltVTT/chHp6o5QW7OvGp4d+zuySL5969DVq3vrUoX8yPqRVt8LCbmHVrXqjJbj5jvzUs1Vpr+nrxKvb6w+Y1NqHFE7PdmGg8IonWLZ0Id7PmAhY3aChfa4rBSVKFj/2Sr7XGsQyn0y4M4YArS95elWxZTEP3MWVWgTZCr41Wh36FA84ihLYH3KPWBSXqffWi0hsbMpEGukpvhEHYJVAlBaWcQOXZ/Kh4+X7xfS5lkqChRHPPpBWYX5Yw2A+dskbFOQI3lYijaJnQfhVG2jFtQ1uX3jr4+FoMs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b20a485-87d1-41a2-89c8-08d7377028d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:58:36.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLQXJBiswxzaT+8Sz+UmJRTccPervkzkOF5s6KhrniPRIETKpaxxWyovvom8eARAzhcp3z6iaRUfwU6jdbnIOxtv9M02/YcArF03lKEVOHk=
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

Add support of driving MPU9250 magnetometer connected on i2c
auxiliary bus using the MPU i2c master.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile       |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 144 ++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   4 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 355 +++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h |  36 +++
 5 files changed, 537 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h

diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu=
6050/Makefile
index 2cfbd926522f..c103441a906b 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -5,7 +5,7 @@
=20
 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o
 inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o \
-		 inv_mpu_aux.o
+		 inv_mpu_aux.o inv_mpu_magn.o
=20
 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
 inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 7b2e4d81bbba..f1c65e0dd1a5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include "inv_mpu_iio.h"
+#include "inv_mpu_magn.h"
=20
 /*
  * this is the gyro scale translated from dynamic range plus/minus
@@ -332,6 +333,11 @@ static int inv_mpu6050_init_config(struct iio_dev *ind=
io_dev)
 	 */
 	st->chip_period =3D NSEC_PER_MSEC;
=20
+	/* magn chip init, noop if not present in the chip */
+	result =3D inv_mpu_magn_probe(st);
+	if (result)
+		goto error_power_off;
+
 	return inv_mpu6050_set_power_itg(st, false);
=20
 error_power_off:
@@ -411,6 +417,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev=
 *indio_dev,
 		ret =3D inv_mpu6050_sensor_show(st, st->reg->temperature,
 					      IIO_MOD_X, val);
 		break;
+	case IIO_MAGN:
+		ret =3D inv_mpu_magn_read(st, chan->channel2, val);
+		break;
 	default:
 		ret =3D -EINVAL;
 		break;
@@ -469,6 +478,8 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 				*val2 =3D INV_MPU6050_TEMP_SCALE;
=20
 			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_MAGN:
+			return inv_mpu_magn_get_scale(st, chan, val, val2);
 		default:
 			return -EINVAL;
 		}
@@ -710,6 +721,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct=
 device_attribute *attr,
 	if (result)
 		goto fifo_rate_fail_power_off;
=20
+	/* update rate for magn, noop if not present in chip */
+	result =3D inv_mpu_magn_set_rate(st, fifo_rate);
+	if (result)
+		goto fifo_rate_fail_power_off;
+
 fifo_rate_fail_power_off:
 	result |=3D inv_mpu6050_set_power_itg(st, false);
 fifo_rate_fail_unlock:
@@ -795,8 +811,14 @@ inv_get_mount_matrix(const struct iio_dev *indio_dev,
 		     const struct iio_chan_spec *chan)
 {
 	struct inv_mpu6050_state *data =3D iio_priv(indio_dev);
+	const struct iio_mount_matrix *matrix;
+
+	if (chan->type =3D=3D IIO_MAGN)
+		matrix =3D &data->magn_orient;
+	else
+		matrix =3D &data->orientation;
=20
-	return &data->orientation;
+	return matrix;
 }
=20
 static const struct iio_chan_spec_ext_info inv_ext_info[] =3D {
@@ -864,6 +886,98 @@ static const unsigned long inv_mpu_scan_masks[] =3D {
 	0,
 };
=20
+#define INV_MPU9X50_MAGN_CHAN(_chan2, _bits, _index)			\
+	{								\
+		.type =3D IIO_MAGN,					\
+		.modified =3D 1,						\
+		.channel2 =3D _chan2,					\
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE) |	\
+				      BIT(IIO_CHAN_INFO_RAW),		\
+		.scan_index =3D _index,					\
+		.scan_type =3D {						\
+			.sign =3D 's',					\
+			.realbits =3D _bits,				\
+			.storagebits =3D 16,				\
+			.shift =3D 0,					\
+			.endianness =3D IIO_BE,				\
+		},							\
+		.ext_info =3D inv_ext_info,				\
+	}
+
+static const struct iio_chan_spec inv_mpu9250_channels[] =3D {
+	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
+	/*
+	 * Note that temperature should only be via polled reading only,
+	 * not the final scan elements output.
+	 */
+	{
+		.type =3D IIO_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)
+				| BIT(IIO_CHAN_INFO_OFFSET)
+				| BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index =3D -1,
+	},
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
+
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
+
+	/* Magnetometer resolution is 16 bits */
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 16, INV_MPU9X50_SCAN_MAGN_X),
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Y, 16, INV_MPU9X50_SCAN_MAGN_Y),
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCAN_MAGN_Z),
+};
+
+static const unsigned long inv_mpu9x50_scan_masks[] =3D {
+	/* 3-axis accel */
+	BIT(INV_MPU6050_SCAN_ACCL_X)
+		| BIT(INV_MPU6050_SCAN_ACCL_Y)
+		| BIT(INV_MPU6050_SCAN_ACCL_Z),
+	/* 3-axis gyro */
+	BIT(INV_MPU6050_SCAN_GYRO_X)
+		| BIT(INV_MPU6050_SCAN_GYRO_Y)
+		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	/* 3-axis magn */
+	BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	/* 6-axis accel + gyro */
+	BIT(INV_MPU6050_SCAN_ACCL_X)
+		| BIT(INV_MPU6050_SCAN_ACCL_Y)
+		| BIT(INV_MPU6050_SCAN_ACCL_Z)
+		| BIT(INV_MPU6050_SCAN_GYRO_X)
+		| BIT(INV_MPU6050_SCAN_GYRO_Y)
+		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	/* 6-axis accel + magn */
+	BIT(INV_MPU6050_SCAN_ACCL_X)
+		| BIT(INV_MPU6050_SCAN_ACCL_Y)
+		| BIT(INV_MPU6050_SCAN_ACCL_Z)
+		| BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	/* 6-axis gyro + magn */
+	BIT(INV_MPU6050_SCAN_GYRO_X)
+		| BIT(INV_MPU6050_SCAN_GYRO_Y)
+		| BIT(INV_MPU6050_SCAN_GYRO_Z)
+		| BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	/* 9-axis accel + gyro + magn */
+	BIT(INV_MPU6050_SCAN_ACCL_X)
+		| BIT(INV_MPU6050_SCAN_ACCL_Y)
+		| BIT(INV_MPU6050_SCAN_ACCL_Z)
+		| BIT(INV_MPU6050_SCAN_GYRO_X)
+		| BIT(INV_MPU6050_SCAN_GYRO_Y)
+		| BIT(INV_MPU6050_SCAN_GYRO_Z)
+		| BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	0,
+};
+
 static const struct iio_chan_spec inv_icm20602_channels[] =3D {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
 	{
@@ -1145,6 +1259,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int ir=
q, const char *name,
 		return result;
 	}
=20
+	/* fill magnetometer orientation */
+	result =3D inv_mpu_magn_set_orient(st);
+	if (result)
+		return result;
+
 	/* power is turned on inside check chip type*/
 	result =3D inv_check_and_setup_chip(st);
 	if (result)
@@ -1168,14 +1287,33 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,
 	if (inv_mpu_bus_setup)
 		inv_mpu_bus_setup(indio_dev);
=20
-	if (chip_type =3D=3D INV_ICM20602) {
+	switch (chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		/*
+		 * Use magnetometer inside the chip only if there is no i2c
+		 * auxiliary device in use.
+		 */
+		if (!st->magn_disabled) {
+			indio_dev->channels =3D inv_mpu9250_channels;
+			indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu9250_channels);
+			indio_dev->available_scan_masks =3D inv_mpu9x50_scan_masks;
+		} else {
+			indio_dev->channels =3D inv_mpu_channels;
+			indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu_channels);
+			indio_dev->available_scan_masks =3D inv_mpu_scan_masks;
+		}
+		break;
+	case INV_ICM20602:
 		indio_dev->channels =3D inv_icm20602_channels;
 		indio_dev->num_channels =3D ARRAY_SIZE(inv_icm20602_channels);
 		indio_dev->available_scan_masks =3D inv_icm20602_scan_masks;
-	} else {
+		break;
+	default:
 		indio_dev->channels =3D inv_mpu_channels;
 		indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu_channels);
 		indio_dev->available_scan_masks =3D inv_mpu_scan_masks;
+		break;
 	}
=20
 	indio_dev->info =3D &mpu_info;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index 04215bc6e8ab..953f85618199 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -130,6 +130,8 @@ struct inv_mpu6050_hw {
  *  @data_timestamp:	timestamp for next data sample.
  *  @vddio_supply	voltage regulator for the chip.
  *  @magn_disabled:     magnetometer disabled for backward compatibility r=
eason.
+ *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
+ *  @magn_orient:       magnetometer sensor chip orientation if available.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -152,6 +154,8 @@ struct inv_mpu6050_state {
 	s64 data_timestamp;
 	struct regulator *vddio_supply;
 	bool magn_disabled;
+	s32 magn_raw_to_gauss[3];
+	struct iio_mount_matrix magn_orient;
 };
=20
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_magn.c
new file mode 100644
index 000000000000..415d8acece54
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 TDK-InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/string.h>
+
+#include "inv_mpu_iio.h"
+#include "inv_mpu_aux.h"
+
+/*
+ * MPU9250 magnetometer is an AKM AK8963 chip on I2C aux bus
+ */
+#define INV_MPU_MAGN_I2C_ADDR		0x0C
+
+#define INV_MPU_MAGN_REG_WIA		0x00
+#define INV_MPU_MAGN_BITS_WIA		0x48
+
+#define INV_MPU_MAGN_REG_ST1		0x02
+#define INV_MPU_MAGN_BIT_DRDY		0x01
+#define INV_MPU_MAGN_BIT_DOR		0x02
+
+#define INV_MPU_MAGN_REG_DATA		0x03
+
+#define INV_MPU_MAGN_REG_ST2		0x09
+#define INV_MPU_MAGN_BIT_HOFL		0x08
+#define INV_MPU_MAGN_BIT_BITM		0x10
+
+#define INV_MPU_MAGN_REG_CNTL1		0x0A
+#define INV_MPU_MAGN_BITS_MODE_PWDN	0x00
+#define INV_MPU_MAGN_BITS_MODE_SINGLE	0x01
+#define INV_MPU_MAGN_BITS_MODE_FUSE	0x0F
+#define INV_MPU_MAGN_BIT_OUTPUT_BIT	0x10
+
+#define INV_MPU_MAGN_REG_CNTL2		0x0B
+#define INV_MPU_MAGN_BIT_SRST		0x01
+
+#define INV_MPU_MAGN_REG_ASAX		0x10
+#define INV_MPU_MAGN_REG_ASAY		0x11
+#define INV_MPU_MAGN_REG_ASAZ		0x12
+
+/* Magnetometer maximum frequency */
+#define INV_MPU_MAGN_FREQ_HZ_MAX	50
+
+static bool inv_magn_supported(const struct inv_mpu6050_state *st)
+{
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* init magnetometer chip */
+static int inv_magn_init(struct inv_mpu6050_state *st)
+{
+	uint8_t val;
+	uint8_t asa[3];
+	int ret;
+
+	/* check whoami */
+	ret =3D inv_mpu_aux_read(st, INV_MPU_MAGN_I2C_ADDR, INV_MPU_MAGN_REG_WIA,
+			       &val, sizeof(val));
+	if (ret)
+		return ret;
+	if (val !=3D INV_MPU_MAGN_BITS_WIA)
+		return -ENODEV;
+
+	/* reset chip */
+	ret =3D inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
+				INV_MPU_MAGN_REG_CNTL2,
+				INV_MPU_MAGN_BIT_SRST);
+	if (ret)
+		return ret;
+
+	/* read fuse ROM data */
+	ret =3D inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
+				INV_MPU_MAGN_REG_CNTL1,
+				INV_MPU_MAGN_BITS_MODE_FUSE);
+	if (ret)
+		return ret;
+
+	ret =3D inv_mpu_aux_read(st, INV_MPU_MAGN_I2C_ADDR, INV_MPU_MAGN_REG_ASAX=
,
+			       asa, sizeof(asa));
+	if (ret)
+		return ret;
+
+	/* switch back to power-down */
+	ret =3D inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
+				INV_MPU_MAGN_REG_CNTL1,
+				INV_MPU_MAGN_BITS_MODE_PWDN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Sensitivity adjustement and scale to Gauss
+	 *
+	 * Hadj =3D H * (((ASA - 128) * 0.5 / 128) + 1)
+	 * Factor simplification:
+	 * Hadj =3D H * ((ASA + 128) / 256)
+	 *
+	 * Sensor sentivity
+	 * 0.15 uT in 16 bits mode
+	 * 1 uT =3D 0.01 G and value is in micron (1e6)
+	 * sensitvity =3D 0.15 uT * 0.01 * 1e6
+	 *
+	 * raw_to_gauss =3D Hadj * 1500
+	 */
+	st->magn_raw_to_gauss[0] =3D (((int32_t)asa[0] + 128) * 1500) / 256;
+	st->magn_raw_to_gauss[1] =3D (((int32_t)asa[1] + 128) * 1500) / 256;
+	st->magn_raw_to_gauss[2] =3D (((int32_t)asa[2] + 128) * 1500) / 256;
+
+	return 0;
+}
+
+/**
+ * inv_mpu_magn_probe() - probe and setup magnetometer chip
+ * @st: driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise
+ *
+ * It is probing the chip and setting up all needed i2c transfers.
+ * Noop if there is no magnetometer in the chip.
+ */
+int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
+{
+	int ret;
+
+	/* quit if chip is not supported */
+	if (!inv_magn_supported(st))
+		return 0;
+
+	/* configure i2c master aux port */
+	ret =3D inv_mpu_aux_init(st);
+	if (ret)
+		return ret;
+
+	/* check and init mag chip */
+	ret =3D inv_magn_init(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * configure mpu i2c master accesses
+	 * i2c SLV0: read sensor data, 7 bytes data(6)-ST2
+	 * Byte swap data to store them in big-endian in impair address groups
+	 */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(0),
+			   INV_MPU6050_BIT_I2C_SLV_RNW | INV_MPU_MAGN_I2C_ADDR);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0),
+			   INV_MPU_MAGN_REG_DATA);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0),
+			   INV_MPU6050_BIT_SLV_EN |
+			   INV_MPU6050_BIT_SLV_BYTE_SW |
+			   INV_MPU6050_BIT_SLV_GRP |
+			   INV_MPU9X50_BYTES_MAGN);
+	if (ret)
+		return ret;
+
+	/* i2c SLV1: launch single measurement */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(1),
+			   INV_MPU_MAGN_I2C_ADDR);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(1),
+			   INV_MPU_MAGN_REG_CNTL1);
+	if (ret)
+		return ret;
+
+	/* add 16 bits mode */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1),
+			   INV_MPU_MAGN_BITS_MODE_SINGLE |
+			   INV_MPU_MAGN_BIT_OUTPUT_BIT);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(1),
+			    INV_MPU6050_BIT_SLV_EN | 1);
+}
+
+/**
+ * inv_mpu_magn_set_rate() - set magnetometer sampling rate
+ * @st: driver internal state
+ * @fifo_rate: mpu set fifo rate
+ *
+ * Returns 0 on success, a negative error code otherwise
+ *
+ * Limit sampling frequency to the maximum value supported by the
+ * magnetometer chip. Resulting in duplicated data for higher frequencies.
+ * Noop if there is no magnetometer in the chip.
+ */
+int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rat=
e)
+{
+	uint8_t d;
+
+	/* quit if chip is not supported */
+	if (!inv_magn_supported(st))
+		return 0;
+
+	/*
+	 * update i2c master delay to limit mag sampling to max frequency
+	 * compute fifo_rate divider d: rate =3D fifo_rate / (d + 1)
+	 */
+	if (fifo_rate > INV_MPU_MAGN_FREQ_HZ_MAX)
+		d =3D fifo_rate / INV_MPU_MAGN_FREQ_HZ_MAX - 1;
+	else
+		d =3D 0;
+
+	return regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL, d);
+}
+
+/**
+ * inv_mpu_magn_set_orient() - fill magnetometer mounting matrix
+ * @st: driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise
+ *
+ * Fill magnetometer mounting matrix using the provided chip matrix.
+ */
+int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
+{
+	const char *orient;
+	char *str;
+	int i;
+
+	/* fill magnetometer orientation */
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		/* x <- y */
+		st->magn_orient.rotation[0] =3D st->orientation.rotation[3];
+		st->magn_orient.rotation[1] =3D st->orientation.rotation[4];
+		st->magn_orient.rotation[2] =3D st->orientation.rotation[5];
+		/* y <- x */
+		st->magn_orient.rotation[3] =3D st->orientation.rotation[0];
+		st->magn_orient.rotation[4] =3D st->orientation.rotation[1];
+		st->magn_orient.rotation[5] =3D st->orientation.rotation[2];
+		/* z <- -z */
+		for (i =3D 0; i < 3; ++i) {
+			orient =3D st->orientation.rotation[6 + i];
+			/* use length + 2 for adding minus sign if needed */
+			str =3D devm_kzalloc(regmap_get_device(st->map),
+					   strlen(orient) + 2, GFP_KERNEL);
+			if (str =3D=3D NULL)
+				return -ENOMEM;
+			if (strcmp(orient, "0") =3D=3D 0) {
+				strcpy(str, orient);
+			} else if (orient[0] =3D=3D '-') {
+				strcpy(str, &orient[1]);
+			} else {
+				str[0] =3D '-';
+				strcpy(&str[1], orient);
+			}
+			st->magn_orient.rotation[6 + i] =3D str;
+		}
+		break;
+	default:
+		st->magn_orient =3D st->orientation;
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * inv_mpu_magn_read() - read magnetometer data
+ * @st: driver internal state
+ * @axis: IIO modifier axis value
+ * @val: store corresponding axis value
+ *
+ * Returns 0 on success, a negative error code otherwise
+ */
+int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *v=
al)
+{
+	unsigned int user_ctrl, status;
+	__be16 data[3];
+	uint8_t addr;
+	uint8_t d;
+	unsigned int period_ms;
+	int ret;
+
+	/* quit if chip is not supported */
+	if (!inv_magn_supported(st))
+		return -ENODEV;
+
+	/* Mag data: X - Y - Z */
+	switch (axis) {
+	case IIO_MOD_X:
+		addr =3D 0;
+		break;
+	case IIO_MOD_Y:
+		addr =3D 1;
+		break;
+	case IIO_MOD_Z:
+		addr =3D 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set sample rate to max mag freq */
+	d =3D INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU_MAGN_FREQ_HZ_MAX);
+	ret =3D regmap_write(st->map, st->reg->sample_rate_div, d);
+	if (ret)
+		return ret;
+
+	/* start i2c master, wait for xfer, stop */
+	user_ctrl =3D st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
+	ret =3D regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
+	if (ret)
+		return ret;
+
+	/* need to wait 2 periods + half-period margin */
+	period_ms =3D 1000 / INV_MPU_MAGN_FREQ_HZ_MAX;
+	msleep(period_ms * 2 + period_ms / 2);
+	user_ctrl =3D st->chip_config.user_ctrl;
+	ret =3D regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
+	if (ret)
+		return ret;
+
+	/* restore sample rate */
+	d =3D st->chip_config.divider;
+	ret =3D regmap_write(st->map, st->reg->sample_rate_div, d);
+	if (ret)
+		return ret;
+
+	/* check i2c status and read raw data */
+	ret =3D regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
+	if (ret)
+		return ret;
+
+	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK ||
+			status & INV_MPU6050_BIT_I2C_SLV1_NACK)
+		return -EIO;
+
+	ret =3D regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
+			       data, sizeof(data));
+	if (ret)
+		return ret;
+
+	*val =3D (int16_t)be16_to_cpu(data[addr]);
+
+	return IIO_VAL_INT;
+}
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_magn.h
new file mode 100644
index 000000000000..b41bd0578478
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 TDK-InvenSense, Inc.
+ */
+
+#ifndef INV_MPU_MAGN_H_
+#define INV_MPU_MAGN_H_
+
+#include <linux/kernel.h>
+
+#include "inv_mpu_iio.h"
+
+int inv_mpu_magn_probe(struct inv_mpu6050_state *st);
+
+/**
+ * inv_mpu_magn_get_scale() - get magnetometer scale value
+ * @st: driver internal state
+ *
+ * Returns IIO data format.
+ */
+static inline int inv_mpu_magn_get_scale(const struct inv_mpu6050_state *s=
t,
+					 const struct iio_chan_spec *chan,
+					 int *val, int *val2)
+{
+	*val =3D 0;
+	*val2 =3D st->magn_raw_to_gauss[chan->address];
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rat=
e);
+
+int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st);
+
+int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *v=
al);
+
+#endif		/* INV_MPU_MAGN_H_ */
--=20
2.17.1

