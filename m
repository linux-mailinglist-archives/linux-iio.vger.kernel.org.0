Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D4A1F5A
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 17:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfH2Ph1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 11:37:27 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:56170 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfH2Ph1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 11:37:27 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9ren001995;
        Thu, 29 Aug 2019 08:18:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=udsw7c3C+8DqbLgrH6g/o7PRZLWKMoCB96VTql8/46c=;
 b=xwmXgVOQlA1oZjc99Itft6jWVUyOLtxPzKiNJNsaxm5fl87ZZABjvWREGVGo25YRWKxn
 OKJpdGCs94tXaF/gKu+jC1S5VT/xcS3+C5v0e+90pOMXlXfVb4oFJXWCUKXjA05ynIYW
 G8QSFfKaLLxekgrAVuS5thQXP1UOpwitArPb8ACDxyvh5tnmt+bK2MYTBcxzHqtkevY4
 VW/QLRzrV7AEJpt4/lixbSTXp3nK9x0FPBgyTmjPFTMaIZEzbqtITY+vKDUX48mfxJlF
 AnT5rcFEfgASLckgio9kRZRHvchk2KFhuXUdZbMGVVZ3wZZbWzvEqErtvahZiNYOGLaQ 8g== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0b-00328301.pphosted.com with ESMTP id 2ukyymt18t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD+BASoyx+3WI5kaQNY6nodtGqIdvl50D3BVpRnHa0KYbmt7v7z601UVkunMBvggvMCiaz93feDzwgHFJVRxhRSjtZqAZyF9jzPCHg2gB2cOVk42/kVNpCa8h0U62hZmno8Q1vSxmZcc513M7FQA065IJXJJ2RUkQskEF6jjhOjlxd5rG0xPL7oPYMx4BQ+BlcPJOVjA5NaJlC1U/XnkAs8ouM6x1FUoVrNAg+2QOVrrWfxc8F3fVSof+gXXBjdI4jdGAyB4U1y4kXUghgiEZXu37BNvcdU9A8F0YrtGGKSuZcC6gnHV4yn4ZFgt6zMKa6dNHbFSRKSAQA/BnRsQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udsw7c3C+8DqbLgrH6g/o7PRZLWKMoCB96VTql8/46c=;
 b=lxwk/H/V2DjeAQUX4b69tzFBCrfDWmkvi4etG2X0q4neH7P4J2VZGWLbldu1h/v9ye0woZhSbFs6lw9oU0AjNtadW7zO3qUa+OnpSdFuFzYUIQFs+GNm11OWvbXeJkaZ1dyFVFWxEZrvSA4AyQ/w2L2JMJToGfGPGsaI+YgZ8K72QYUHGFgo3Zq7ieQunyx8rriQHI8ncHam4M1wU5FDFdD33zaHt41tPsqZmdCB1aiDGRDFwpWGtTrLgVpGZu5ukVUeih86zjcRVo8UfSTIXHz3y1wp8fcD2J7k3WfJud47ufAwU/kNACDdikLz8OKxkxpy8MRT7c6poS2B5dR6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udsw7c3C+8DqbLgrH6g/o7PRZLWKMoCB96VTql8/46c=;
 b=gFqGZSZeFKQyTaarP5V62/tLVZx+Eu4Kr1f/0qoh3J1mmUNJeeEfxb8g/E2x1bpx8jUPkq0H++fAKGhhJYF1nrtfmnaZHtFkJPEYWvbOyMvh5WfQTenmoONQB3cVc6ej1bN0ASidw2bF4AEfXgnsylztLbTZZfJYbf4Z3A2ZL4M=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB3638.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 15:18:45 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:45 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 7/8] iio: imu: inv_mpu6050: add magnetometer support inside
 mpu driver
Thread-Topic: [PATCH 7/8] iio: imu: inv_mpu6050: add magnetometer support
 inside mpu driver
Thread-Index: AQHVXn0MYpJzl4x+WUecu/G2bHQLjw==
Date:   Thu, 29 Aug 2019 15:18:45 +0000
Message-ID: <20190829151801.13014-8-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: cd3601aa-ed6a-4cbd-03cc-08d72c942ed4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3638;
x-ms-traffictypediagnostic: BYAPR12MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB363850FF94240D390BFE552FC4A20@BYAPR12MB3638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(4326008)(6486002)(256004)(14454004)(1076003)(14444005)(316002)(26005)(102836004)(81166006)(66066001)(81156014)(386003)(6506007)(305945005)(86362001)(2351001)(6916009)(186003)(30864003)(2501003)(80792005)(7736002)(36756003)(50226002)(2616005)(6512007)(8676002)(478600001)(71190400001)(71200400001)(64756008)(54906003)(66946007)(2906002)(66446008)(6116002)(52116002)(76176011)(66476007)(99286004)(66556008)(8936002)(446003)(486006)(107886003)(5640700003)(53936002)(11346002)(476003)(6436002)(5660300002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3638;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b5F2U2X+Wcz+6xACixEUGlwgt/lAu6pxxHUJ255C6MVAQd+c0T12fzgTJ5dfSlVjyzZK/r6BrgR2gaBR2Pz2p2G9nGH+9dPfICZZC/2mw/YUiKjY4Q9RqyrLouN7CeUKiaockaMTj60ZJ/nJO2pfuu0cG96v7oRQIcrYKusH1a+HkiwnSawzg5i1q3JxXundTWhbmHEZo40pUlAvOVAzFVGaCrgwg6p1a+njmFBUb1JdhyFJwPZRLDsCa5sCqKRoXghSNa+kEfZ7LXNNRDxer9o+uiICoC/Zu6az88KME5H3eu72oIYg1A7qWkq1suNDpHHEt29eXc7wxYPgLRuvJQdlak5sGIpV/V1Ln25wO+zr6DcsUAZrhMSeG+mKcmk6bojCXelJ/u1uNjb9FwguCsSTllHfJ/p7bGuNXfYKKgU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3601aa-ed6a-4cbd-03cc-08d72c942ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:45.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zetAYztGTdbgIfLcitZDsjKxS0rEB/ForIr9OF7zaNRrauOWguCfonbAHvHLQexHL4uk8vYN2Wbx87yGSr9dZvkGSvIDeGQzSJGtLWKS3ZM=
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

Add inv_mpu_magn layer to manage several chip specific
implementations and be noop when Kconfig option is not set.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile       |   3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 140 ++++++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 120 ++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h | 107 ++++++++++++++++
 5 files changed, 368 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h

diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu=
6050/Makefile
index fee41415ebdb..6f5baac29f81 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -5,7 +5,8 @@
=20
 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o
 inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
-inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) +=3D inv_mpu_aux.o inv_mpu9250_magn=
.o
+inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) +=3D inv_mpu_aux.o inv_mpu_magn.o \
+	inv_mpu9250_magn.o
=20
 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
 inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index b17f060b52fc..d08cec6a8a7a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -16,7 +16,9 @@
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+
 #include "inv_mpu_iio.h"
+#include "inv_mpu_magn.h"
=20
 /*
  * this is the gyro scale translated from dynamic range plus/minus
@@ -332,6 +334,11 @@ static int inv_mpu6050_init_config(struct iio_dev *ind=
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
@@ -411,6 +418,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev=
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
@@ -469,6 +479,8 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 				*val2 =3D INV_MPU6050_TEMP_SCALE;
=20
 			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_MAGN:
+			return inv_mpu_magn_get_scale(st, chan, val, val2);
 		default:
 			return -EINVAL;
 		}
@@ -710,6 +722,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct=
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
@@ -795,8 +812,13 @@ inv_get_mount_matrix(const struct iio_dev *indio_dev,
 		     const struct iio_chan_spec *chan)
 {
 	struct inv_mpu6050_state *data =3D iio_priv(indio_dev);
+	const struct iio_mount_matrix *matrix =3D &data->orientation;
=20
-	return &data->orientation;
+#ifdef CONFIG_INV_MPU6050_MAGN
+	if (chan->type =3D=3D IIO_MAGN)
+		matrix =3D &data->magn_orient;
+#endif
+	return matrix;
 }
=20
 static const struct iio_chan_spec_ext_info inv_ext_info[] =3D {
@@ -864,6 +886,102 @@ static const unsigned long inv_mpu_scan_masks[] =3D {
 	0,
 };
=20
+#ifdef CONFIG_INV_MPU6050_MAGN
+
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
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU9X50_SCAN_GYRO_X),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU9X50_SCAN_GYRO_Y),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU9X50_SCAN_GYRO_Z),
+
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU9X50_SCAN_ACCL_X),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU9X50_SCAN_ACCL_Y),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU9X50_SCAN_ACCL_Z),
+
+	/* Magnetometer resolution is 16 bits */
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 16, INV_MPU9X50_SCAN_MAGN_X),
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Y, 16, INV_MPU9X50_SCAN_MAGN_Y),
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCAN_MAGN_Z),
+};
+
+static const unsigned long inv_mpu9x50_scan_masks[] =3D {
+	/* 3-axis accel */
+	BIT(INV_MPU9X50_SCAN_ACCL_X)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Z),
+	/* 3-axis gyro */
+	BIT(INV_MPU9X50_SCAN_GYRO_X)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Z),
+	/* 3-axis magn */
+	BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	/* 6-axis accel + gyro */
+	BIT(INV_MPU9X50_SCAN_ACCL_X)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Z)
+		| BIT(INV_MPU9X50_SCAN_GYRO_X)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Z),
+	/* 6-axis accel + magn */
+	BIT(INV_MPU9X50_SCAN_ACCL_X)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Z)
+		| BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	/* 6-axis gyro + magn */
+	BIT(INV_MPU9X50_SCAN_GYRO_X)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Z)
+		| BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	/* 9-axis accel + gyro + magn */
+	BIT(INV_MPU9X50_SCAN_ACCL_X)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
+		| BIT(INV_MPU9X50_SCAN_ACCL_Z)
+		| BIT(INV_MPU9X50_SCAN_GYRO_X)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
+		| BIT(INV_MPU9X50_SCAN_GYRO_Z)
+		| BIT(INV_MPU9X50_SCAN_MAGN_X)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
+		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	0,
+};
+
+#endif
+
 static const struct iio_chan_spec inv_icm20602_channels[] =3D {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
 	{
@@ -1145,6 +1263,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int ir=
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
@@ -1167,14 +1290,25 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,
 	else
 		indio_dev->name =3D dev_name(dev);
=20
-	if (chip_type =3D=3D INV_ICM20602) {
+	switch (chip_type) {
+#ifdef CONFIG_INV_MPU6050_MAGN
+	case INV_MPU9250:
+	case INV_MPU9255:
+		indio_dev->channels =3D inv_mpu9250_channels;
+		indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu9250_channels);
+		indio_dev->available_scan_masks =3D inv_mpu9x50_scan_masks;
+		break;
+#endif
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
index 5b462672bbcb..cfc11cb0a36c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -130,6 +130,7 @@ struct inv_mpu6050_hw {
  *  @data_timestamp:	timestamp for next data sample.
  *  @vddio_supply	voltage regulator for the chip.
  *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
+ *  @magn_orient:	magnetometer sensor chip orientation if available.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -153,6 +154,7 @@ struct inv_mpu6050_state {
 	struct regulator *vddio_supply;
 #ifdef CONFIG_INV_MPU6050_MAGN
 	s32 magn_raw_to_gauss[3];
+	struct iio_mount_matrix magn_orient;
 #endif
 };
=20
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_magn.c
new file mode 100644
index 000000000000..2bb40dae0429
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -0,0 +1,120 @@
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
+#include "inv_mpu9250_magn.h"
+
+int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
+{
+	int ret;
+
+	/* probe and init mag chip */
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		/* configure i2c master aux port */
+		ret =3D inv_mpu_aux_init(st);
+		if (ret)
+			return ret;
+		return inv_mpu9250_magn_probe(st);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rat=
e)
+{
+	int max_freq;
+	uint8_t d;
+
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		max_freq =3D INV_MPU9250_MAGN_FREQ_HZ_MAX;
+		break;
+	default:
+		return 0;
+	}
+
+	/*
+	 * update i2c master delay to limit mag sampling to max frequency
+	 * compute fifo_rate divider d: rate =3D fifo_rate / (d + 1)
+	 */
+	if (fifo_rate > max_freq)
+		d =3D fifo_rate / max_freq - 1;
+	else
+		d =3D 0;
+
+	return regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL, d);
+}
+
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
+int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *v=
al)
+{
+	int ret;
+
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		ret =3D inv_mpu9250_magn_read(st, axis, val);
+		break;
+	default:
+		ret =3D -ENODEV;
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_magn.h
new file mode 100644
index 000000000000..efa2ec1b3b2f
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
@@ -0,0 +1,107 @@
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
+#ifdef CONFIG_INV_MPU6050_MAGN
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
e);
+
+/**
+ * inv_mpu_magn_set_orient() - fill magnetometer mounting matrix
+ * @st: driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise
+ *
+ * Fill magnetometer mounting matrix using the provided chip matrix.
+ */
+int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st);
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
al);
+
+#else		/* CONFIG_INV_MPU6050_MAGN */
+
+static inline int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
+{
+	return 0;
+}
+
+static inline int inv_mpu_magn_get_scale(const struct inv_mpu6050_state *s=
t,
+					 const struct iio_chan_spec *chan,
+					 int *val, int *val2)
+{
+	return -EINVAL;
+}
+
+static inline int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st=
,
+					int fifo_rate)
+{
+	return 0;
+}
+
+static inline int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
+{
+	return 0;
+}
+
+static inline int inv_mpu_magn_read(const struct inv_mpu6050_state *st, in=
t axis,
+				    int *val)
+{
+	return 0;
+}
+
+#endif		/* CONFIG_INV_MPU6050_MAGN */
+
+#endif		/* INV_MPU_MAGN_H_ */
--=20
2.17.1

