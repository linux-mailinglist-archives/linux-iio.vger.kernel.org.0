Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8EA2073
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfH2QNu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 12:13:50 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:53062 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbfH2QNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 12:13:49 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9rem001995;
        Thu, 29 Aug 2019 08:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=xC3iDkO/dOKCHduCofvu69oSiAk6FHMSt92ahBaO+/w=;
 b=we4eTrIVCJf+ZNZ/36EtCQkZ9ehZ+y2e7tQX3/06YXcX8UmzKyn8F1446Y/JFPFw+XEU
 VLXQG0930Bm65owqrJZmB1XCMc/bAadJWtKjtq2L3qalbp/Xzv/9vJ3b45SMUHrMtA7t
 UWrlI5OpyKi3t80GzGDQ4frglRsY2dh7eLmoq4UA/EBk+WhyV9lqQRRUycYzIjsxxhZa
 13LS0o24ttEHFMqypwhziYGJLf/5nWqIWB2XHcqb8I1s+XBFLlhFcqWVWLTxdQNCaiHV
 FgogkgOUzIND9FWS2hK+qLQ1TvA26onwto/1Xw+pg+H33aTuHVIS4HHsrIvdsPOEBjfZ ug== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0b-00328301.pphosted.com with ESMTP id 2ukyymt18t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKkp4faoAHiGk+wiL9wRa/99wZislw/HfxNTc5+jxb3jexV16SimO/ZsSY9ltirfoTYxpAjlhGR01PKcQNqYaiYN8su93g67PziHN1N+Gi5l/6jZw2vsj7QAp1HE0ZTONmCGKmhXUpEEnMrAD+/dL80E4Ed3p8R2sDpNPUK5xac2WLC4QxRaGRlI8QLkl74i9MU/u/2qtw1q4DLe0XGFYbXyjQcuts0cf14Lkr1nvNl5CqV4SPayAFyN4pDpkmCroQTTvJ1fn8oe3Fv1riM5UoUK8mBLwv8XY3aWIA/kWlQ4lgtF3aSJ4UA2VrHJz2M5DI+JhjvhkiX9WVtqhBXyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC3iDkO/dOKCHduCofvu69oSiAk6FHMSt92ahBaO+/w=;
 b=DcG+Cw3SG3US2WEtbo0B0iFxjma2ShPBkhJLheyX2dLZo17v2Sqt8EqL5GWY0XFFG8zk1EZ3gPtNa7EjAzVlF8m/bmjiqCbI6qyFiH694t5zXnA9/ZlsoLMeMen3ewXsfoG9o1inFLW8apVRym6C3Gpn5j8DDg1LvNkxkVMrITMBzwCzLlpsETFjXy9PDWl+XZ4k7O5Hbuynz27L6HJuQt9w6+Jr6pGZG4LaQk4rzWpBTKieunae8yLnYbcPJ9mHrdLYkZrXrGsummh3SUpHnwNWbaNAgnIJar+R1jgnkB/c0jnuhPztcHcaykYuWTvTDzyLeuPFY5pQD2c9Q2xnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC3iDkO/dOKCHduCofvu69oSiAk6FHMSt92ahBaO+/w=;
 b=T2hC2V36Wag2WXDQeIbEmw3cNKN83yXPtyJB5sfatpm2uV9acNQzKQvEJUfAh7DAyu8x+3YYfWJFso/sL3v1FdX7MiDKRPGHsK2gZbWWkPXVdIm170j7dqoe8+cicqg4feZCG93HMUgLVSu3CmtPVptnXyznNYrUlTLDmYW+Oqw=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB3638.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 15:18:43 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:43 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 6/8] iio: imu: inv_mpu6050: add magnetometer implementation
 for MPU925x
Thread-Topic: [PATCH 6/8] iio: imu: inv_mpu6050: add magnetometer
 implementation for MPU925x
Thread-Index: AQHVXn0LDCBuZOA8OkStPvzl+JKzSQ==
Date:   Thu, 29 Aug 2019 15:18:43 +0000
Message-ID: <20190829151801.13014-7-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 1a836b19-c710-4f35-6e1f-08d72c942ded
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3638;
x-ms-traffictypediagnostic: BYAPR12MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3638DB36BDB10E32F05D18D5C4A20@BYAPR12MB3638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(4326008)(6486002)(256004)(14454004)(1076003)(14444005)(316002)(26005)(102836004)(81166006)(66066001)(81156014)(386003)(6506007)(305945005)(86362001)(2351001)(6916009)(186003)(2501003)(80792005)(7736002)(36756003)(50226002)(2616005)(6512007)(8676002)(478600001)(71190400001)(71200400001)(64756008)(54906003)(66946007)(2906002)(66446008)(6116002)(52116002)(76176011)(66476007)(99286004)(66556008)(8936002)(446003)(486006)(107886003)(5640700003)(53936002)(11346002)(476003)(6436002)(5660300002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3638;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NYb/mlEWMSZw1VDOch4Rfg5N4LXtVELmgGoVgQ+eYkfoqV1xopiOVmoe9eAjB59Hto2muBxQ4oBe6PzKafmJ5NeS9CbHInQsk+UowNm2ZtVp9FLxLFdZEss3BQ2/TBEy80CcSNDQYZuoaGp4TqhFPW3xdzE+LDOrHUtVjcgBtx1Taz5fg4/FcnySiDKylA8n8f1CFoC09y3fnFgebMbb0X7UYTjz6/Gbc7DRFd9fLQaSMZmxaaM7r+hvPhPZSOqPbPzGc27Ei6r+uw4dM83DsAmunwr7qVZ6taqWQoBvt0zMncdmfX+mdBx3j7JKaADENJJ850lfaqRfKLWHXViyc411w7YplUf22IxbJNZd8X1XrfunP0tZkDFwka2XMKxZ/iuRBGXJCzcnBW75H998xz1tm8YpQiDQKIutbn+nIPQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a836b19-c710-4f35-6e1f-08d72c942ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:43.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV5YLSeDyRMQZP4VVkI5hlsLb4h46E1H/7fHIAlzDaMCnhYtGLXUjV2mv/OtD6/UTvvBsiNVL/iX7e0UYdKiiFAnemt3rpOJQ29l6DKsojA=
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

Add implementation for driving MPU9250 magnetometer connected on
i2c auxiliary bus using the MPU i2c master. This is currently not
wired inside the main mpu driver.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile          |   2 +-
 .../iio/imu/inv_mpu6050/inv_mpu9250_magn.c    | 239 ++++++++++++++++++
 .../iio/imu/inv_mpu6050/inv_mpu9250_magn.h    |  27 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   4 +
 4 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h

diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu=
6050/Makefile
index 187f003c81f2..fee41415ebdb 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -5,7 +5,7 @@
=20
 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o
 inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
-inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) +=3D inv_mpu_aux.o
+inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) +=3D inv_mpu_aux.o inv_mpu9250_magn=
.o
=20
 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
 inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu9250_magn.c
new file mode 100644
index 000000000000..0c2230247557
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 TDK-InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <asm/unaligned.h>
+
+#include "inv_mpu_iio.h"
+#include "inv_mpu_aux.h"
+#include "inv_mpu9250_magn.h"
+
+/*
+ * MPU9250 magnetometer is an AKM AK8963 chip on I2C aux bus
+ */
+#define INV_MPU9250_MAGN_I2C_ADDR		0x0C
+
+#define INV_MPU9250_MAGN_REG_WIA		0x00
+#define INV_MPU9250_MAGN_BITS_WIA		0x48
+
+#define INV_MPU9250_MAGN_REG_ST1		0x02
+#define INV_MPU9250_MAGN_BIT_DRDY		0x01
+#define INV_MPU9250_MAGN_BIT_DOR		0x02
+
+#define INV_MPU9250_MAGN_REG_DATA		0x03
+
+#define INV_MPU9250_MAGN_REG_ST2		0x09
+#define INV_MPU9250_MAGN_BIT_HOFL		0x08
+#define INV_MPU9250_MAGN_BIT_BITM		0x10
+
+#define INV_MPU9250_MAGN_REG_CNTL1		0x0A
+#define INV_MPU9250_MAGN_BITS_MODE_PWDN		0x00
+#define INV_MPU9250_MAGN_BITS_MODE_SINGLE	0x01
+#define INV_MPU9250_MAGN_BITS_MODE_FUSE		0x0F
+#define INV_MPU9250_MAGN_BIT_OUTPUT_BIT		0x10
+
+#define INV_MPU9250_MAGN_REG_CNTL2		0x0B
+#define INV_MPU9250_MAGN_BIT_SRST		0x01
+
+#define INV_MPU9250_MAGN_REG_ASAX		0x10
+#define INV_MPU9250_MAGN_REG_ASAY		0x11
+#define INV_MPU9250_MAGN_REG_ASAZ		0x12
+
+/* init magnetometer chip */
+static int inv_magn_init(struct inv_mpu6050_state *st)
+{
+	uint8_t val;
+	uint8_t asa[3];
+	int ret;
+
+	/* check whoami */
+	ret =3D inv_mpu_aux_read(st, INV_MPU9250_MAGN_I2C_ADDR,
+			       INV_MPU9250_MAGN_REG_WIA, &val, sizeof(val));
+	if (ret)
+		return ret;
+	if (val !=3D INV_MPU9250_MAGN_BITS_WIA)
+		return -ENODEV;
+
+	/* reset chip */
+	ret =3D inv_mpu_aux_write(st, INV_MPU9250_MAGN_I2C_ADDR,
+				INV_MPU9250_MAGN_REG_CNTL2,
+				INV_MPU9250_MAGN_BIT_SRST);
+	if (ret)
+		return ret;
+
+	/* read fuse ROM data */
+	ret =3D inv_mpu_aux_write(st, INV_MPU9250_MAGN_I2C_ADDR,
+				INV_MPU9250_MAGN_REG_CNTL1,
+				INV_MPU9250_MAGN_BITS_MODE_FUSE);
+	if (ret)
+		return ret;
+	ret =3D inv_mpu_aux_read(st, INV_MPU9250_MAGN_I2C_ADDR,
+			       INV_MPU9250_MAGN_REG_ASAX, asa, sizeof(asa));
+	if (ret)
+		return ret;
+
+	/* switch back to power-down */
+	ret =3D inv_mpu_aux_write(st, INV_MPU9250_MAGN_I2C_ADDR,
+				INV_MPU9250_MAGN_REG_CNTL1,
+				INV_MPU9250_MAGN_BITS_MODE_PWDN);
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
+	 * sensor sensitivity: 0.15 uT (16 bits)
+	 * 1 uT =3D 0.01 G and value is in micron (1e6)
+	 *
+	 * Hadj =3D H * ((ASA + 128) / 256) * 0.15 * 0.01 * 1e6
+	 * Hadj =3D H * ((ASA + 128) / 256) * 1500
+	 */
+	st->magn_raw_to_gauss[0] =3D (((int32_t)asa[0] + 128) * 1500) / 256;
+	st->magn_raw_to_gauss[1] =3D (((int32_t)asa[1] + 128) * 1500) / 256;
+	st->magn_raw_to_gauss[2] =3D (((int32_t)asa[2] + 128) * 1500) / 256;
+
+	return 0;
+}
+
+/**
+ * Probe magnetometer chip and setup all i2c transfers.
+ * SLV0: read sensor data
+ * SLV1: launch sensor single measurement
+ *
+ * Sampling data requires 2 cycles to read after measurement.
+ * A measurement can take up to ~10ms.
+ */
+int inv_mpu9250_magn_probe(struct inv_mpu6050_state *st)
+{
+	int ret;
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
+			   INV_MPU6050_BIT_I2C_SLV_RNW |
+			   INV_MPU9250_MAGN_I2C_ADDR);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0),
+			   INV_MPU9250_MAGN_REG_DATA);
+	if (ret)
+		return ret;
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
+			   INV_MPU9250_MAGN_I2C_ADDR);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(1),
+			   INV_MPU9250_MAGN_REG_CNTL1);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1),
+			   INV_MPU9250_MAGN_BITS_MODE_SINGLE |
+			   INV_MPU9250_MAGN_BIT_OUTPUT_BIT);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(1),
+			   INV_MPU6050_BIT_SLV_EN | 1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * Read magnetometer data from MPU fifo.
+ * Sampling data requires running the i2c master for 2 cycles.
+ * Use magnetometer maximal supported frequency.
+ */
+int inv_mpu9250_magn_read(const struct inv_mpu6050_state *st, int axis,
+			  int *val)
+{
+	unsigned int user_ctrl, status;
+	__be16 data[3];
+	uint8_t addr;
+	uint8_t d;
+	unsigned int period_ms;
+	int ret;
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
+	d =3D INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU9250_MAGN_FREQ_HZ_MAX);
+	ret =3D regmap_write(st->map, st->reg->sample_rate_div, d);
+	if (ret)
+		return ret;
+
+	/* start i2c master, wait for xfer, stop */
+	user_ctrl =3D st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
+	ret =3D regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
+	if (ret)
+		return ret;
+	/* need to wait 2 periods + half-period margin */
+	period_ms =3D 1000 / INV_MPU9250_MAGN_FREQ_HZ_MAX;
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
+	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK ||
+			status & INV_MPU6050_BIT_I2C_SLV1_NACK)
+		return -EIO;
+	ret =3D regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
+			       data, sizeof(data));
+	if (ret)
+		return ret;
+
+	*val =3D (int16_t)be16_to_cpu(data[addr]);
+
+	return IIO_VAL_INT;
+}
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu9250_magn.h
new file mode 100644
index 000000000000..9899dd6c560c
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 TDK-InvenSense, Inc.
+ */
+
+#ifndef INV_MPU9250_MAGN_H_
+#define INV_MPU9250_MAGN_H_
+
+#include <linux/kernel.h>
+
+#include "inv_mpu_iio.h"
+
+/* Magnetometer maximum frequency */
+#define INV_MPU9250_MAGN_FREQ_HZ_MAX		50
+
+/**
+ * inv_mpu9250_magn_probe() - MPU9250 implementation
+ */
+int inv_mpu9250_magn_probe(struct inv_mpu6050_state *st);
+
+/**
+ * inv_mpu9250_magn_read() - MPU9250 implementation
+ */
+int inv_mpu9250_magn_read(const struct inv_mpu6050_state *st, int axis,
+			  int *val);
+
+#endif
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index 82669ecb4735..5b462672bbcb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
  *  @it_timestamp:	timestamp from previous interrupt.
  *  @data_timestamp:	timestamp for next data sample.
  *  @vddio_supply	voltage regulator for the chip.
+ *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -150,6 +151,9 @@ struct inv_mpu6050_state {
 	s64 it_timestamp;
 	s64 data_timestamp;
 	struct regulator *vddio_supply;
+#ifdef CONFIG_INV_MPU6050_MAGN
+	s32 magn_raw_to_gauss[3];
+#endif
 };
=20
 /*register and associated bit definition*/
--=20
2.17.1

