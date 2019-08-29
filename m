Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1DAA1EBA
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfH2PSp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 11:18:45 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:33528 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfH2PSp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 11:18:45 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9tst024063;
        Thu, 29 Aug 2019 08:18:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=KufskYDzb4SYFi/x95CIozryUIEqGs9hb5qYF2fn/F4=;
 b=toFJMzmE8xYKDH/a0CY1RVyJoVHLMWy4McDlydJ7lmK/uT9TQzYi21ioJsjT4nNBwU10
 tUpr17+N/uuilyrey5yXbknMwHx/HeeyCoIGK8kznoMt4U0qwI81ooziDm6BkeM392b4
 Rfe9KN8owMVmMghYN81vaMPKDIFdUTxM3zqfC9dK6DFLOtUbgSx/ch74uTpV6C6E6rJm
 QkZbwjOHT/yR/NE68QPKkgnPr9Hf6yYl1NSIecAGDHffQGGuBuwewwbVH620Bclms6D3
 fGdSkXMars9qJTSQMCqJlPp5NDB+bRB7QdICs1KwrUYOHJUXwL/EgVWVV4jf7uLALyni RA== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0a-00328301.pphosted.com with ESMTP id 2up71c88kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGgxk4oJPaNTMmwgzDjFESgdEM7fKkOl6U3CykruPMv64slVfsM9JtPNq1SQ1J3J8cltvkhbMr5Rf6d1Bp32aAwQLcyXAWaetRrcvvrqb0tTk1e9MJYSx/XOwyIA2IGE0lnAIhGpuxNpVGciOcs07pO+4Yt4N15QOcyhnsfvs01Pi2ddTqzF6c3tofyhPgMZxN4Eyvi+tGDGSYsN8b280HoWrQqpsTrcpKzhsRx3kgQHi595uK8moulZANQo++0dJkD/1cl3sOds6pzT981ff7KYCreBZh5L+eV5aYJcKE05SVooZakhEe2KcnLFQoUl8BVpCrwUzSvBkCilP85O6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KufskYDzb4SYFi/x95CIozryUIEqGs9hb5qYF2fn/F4=;
 b=RWV+7PTja+D0NgYzgnufOwI+ujHrku1NxNpQrXk1FCsQjxMvrmz0dQeklr3bCpwCNZQKinJQwdGW2vpvU841JwGB330TEVNL8pe77QOH/z7NZGUzYGQTWbabrKJ0Y6ZV0Um57NtMVZSzgEmw5g3NZ6VDJzCQcR4IiqRieEvihSYpGPz4OhT4AMZ5lDjCtCU8H8Lsi6f+9ALnFjtiTSDAm3SCIIQxw7m5H3N9EgpRSBnWO3RichErXoh83JMi6KquIKJvmWj3bP9OkkHxyzC0P5tYwXPHdcZZ8JivDC/Nf8wye07Hzgb3J1L1fM5I6OG4QVtFU3MwnaUgXR7NmifOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KufskYDzb4SYFi/x95CIozryUIEqGs9hb5qYF2fn/F4=;
 b=ATQgDjlZuV7d6gDQai+g4P38wB4CjqD+DMMkslb441ty1d4rAb2eIZSe+KespzV9MEjUUxE8WcVp+jiqXalK5UvAwcA5UDX6QUFnsuE+7sXiYoMPWKhhzc+oUnbCuWArTSGvTZ4eBsiJrMXqzagni6MF1NWsVpcDk2JXib9bXzk=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB3638.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 15:18:42 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:42 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 5/8] iio: imu: inv_mpu6050: helpers for using i2c master on
 auxiliary bus
Thread-Topic: [PATCH 5/8] iio: imu: inv_mpu6050: helpers for using i2c master
 on auxiliary bus
Thread-Index: AQHVXn0KZSl3P1+jXUG7UhFKyFF9/w==
Date:   Thu, 29 Aug 2019 15:18:42 +0000
Message-ID: <20190829151801.13014-6-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: e7d6bef6-7a81-4a81-ee39-08d72c942d05
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3638;
x-ms-traffictypediagnostic: BYAPR12MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB363866B1C1BD5D9DAF51A652C4A20@BYAPR12MB3638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(4326008)(6486002)(256004)(14454004)(1076003)(14444005)(316002)(26005)(102836004)(81166006)(66066001)(81156014)(386003)(6506007)(305945005)(86362001)(2351001)(6916009)(186003)(2501003)(80792005)(7736002)(36756003)(50226002)(2616005)(6512007)(8676002)(478600001)(71190400001)(71200400001)(64756008)(54906003)(66946007)(2906002)(66446008)(6116002)(52116002)(76176011)(66476007)(99286004)(66556008)(8936002)(446003)(486006)(107886003)(5640700003)(53936002)(11346002)(476003)(6436002)(5660300002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3638;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pNla3uWieCxjKeU/tYROxQHIRp2DNW+MT3g9M7KY1LUMtVpAQa4zHFAbnHjhiuMK37bSAqdcvCN3RYwhQNbMSXNin4ufZMh/1FGlA3WncJs5HpUWwmO53lRZgYzayUJ2NlWB1rG1IE6/6HK8dvzk0stF/ovn0KdB5osWuholRVuUlCy1UVr1btwTvuu7xCUfvW3Yq63yDy9JMONYdS++U0/6c0TNW2dqYge+N+jWw7gX5rwHhaWkGS8DlOFV6d69SqkkEpzH1km0hphF3keeGQZPZqnLrSBvICqniqree50TT/qyd56m+T4iCSHRKC5dPVzZLiRN2I45tbbGxWcg3+V/KARRDC6ElXB5qYgSGPxz9Gkc+Ds+i8UOYFx/SZ68yZeMkYSZ2QyWZxPu9QTrJdV15JeE3rxN2/kfr/OOYKc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d6bef6-7a81-4a81-ee39-08d72c942d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:42.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLisoAzUlTXm4jYz5bFnI6VU6Vqz939d4cSu9S2WRba39eBsjcm7O86zffsR2WwOM+eo6PYWrB5r3jBkZzXuLtPqnNMNio7S06sepiyMCtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_07:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908290164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add helper functions to use the i2c auxiliary bus with the MPU i2c
master block.

Support only register based chip, reading and 1 byte writing. These
will be useful for initializing magnetometers inside MPU9x50 chips.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile      |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 191 ++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h |  46 ++++++
 3 files changed, 238 insertions(+)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h

diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu=
6050/Makefile
index 33bec09fee9b..187f003c81f2 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -5,6 +5,7 @@
=20
 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o
 inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
+inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) +=3D inv_mpu_aux.o
=20
 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
 inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_aux.c
new file mode 100644
index 000000000000..afb957567c12
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 TDK-InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+
+#include "inv_mpu_iio.h"
+
+/*
+ * i2c master auxiliary bus transfer function.
+ * Requires the i2c operations to be correctly setup before.
+ */
+static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
+{
+	/* use 50hz frequency for xfer */
+	const unsigned int freq =3D 50;
+	const unsigned int period_ms =3D 1000 / freq;
+	uint8_t d;
+	unsigned int user_ctrl;
+	int ret;
+
+	/* set sample rate */
+	d =3D INV_MPU6050_FIFO_RATE_TO_DIVIDER(freq);
+	ret =3D regmap_write(st->map, st->reg->sample_rate_div, d);
+	if (ret)
+		return ret;
+
+	/* start i2c master */
+	user_ctrl =3D st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
+	ret =3D regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
+	if (ret)
+		goto error_restore_rate;
+
+	/* wait for xfer: 1 period + half-period margin */
+	msleep(period_ms + period_ms / 2);
+
+	/* stop i2c master */
+	user_ctrl =3D st->chip_config.user_ctrl;
+	ret =3D regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
+	if (ret)
+		goto error_stop_i2c;
+
+	/* restore sample rate */
+	d =3D st->chip_config.divider;
+	ret =3D regmap_write(st->map, st->reg->sample_rate_div, d);
+	if (ret)
+		goto error_restore_rate;
+
+	return 0;
+
+error_stop_i2c:
+	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
+error_restore_rate:
+	regmap_write(st->map, st->reg->sample_rate_div, st->chip_config.divider);
+	return ret;
+}
+
+int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	/* configure i2c master */
+	val =3D INV_MPU6050_BITS_I2C_MST_CLK_400KHZ |
+			INV_MPU6050_BIT_WAIT_FOR_ES;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_MST_CTRL, val);
+	if (ret)
+		return ret;
+
+	/* configure i2c master delay */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL, 0);
+	if (ret)
+		return ret;
+	val =3D INV_MPU6050_BIT_I2C_SLV0_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV1_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV2_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV3_DLY_EN |
+			INV_MPU6050_BIT_DELAY_ES_SHADOW;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_MST_DELAY_CTRL, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * i2c slave reading using SLV0
+ */
+int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
+		     uint8_t reg, uint8_t *val, size_t size)
+{
+	unsigned int status;
+	int ret;
+
+	if (size > 0x0F)
+		return -EINVAL;
+
+	/* setup i2c SLV0 control: i2c addr, register, enable + size */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(0),
+			   INV_MPU6050_BIT_I2C_SLV_RNW | addr);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0), reg);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0),
+			   INV_MPU6050_BIT_SLV_EN | size);
+	if (ret)
+		return ret;
+
+	/* do i2c xfer */
+	ret =3D inv_mpu_i2c_master_xfer(st);
+	if (ret)
+		goto error_disable_i2c;
+
+	/* disable i2c slave */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
+	if (ret)
+		goto error_disable_i2c;
+
+	/* check i2c status */
+	ret =3D regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
+	if (ret)
+		return ret;
+	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
+		return -EIO;
+
+	/* read data in registers */
+	ret =3D regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
+			       val, size);
+	if (ret)
+		return ret;
+
+	return 0;
+
+error_disable_i2c:
+	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
+	return ret;
+}
+
+/*
+ * i2c slave writing 1 byte using SLV0
+ */
+int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
+		      uint8_t reg, uint8_t val)
+{
+	unsigned int status;
+	int ret;
+
+	/* setup i2c SLV0 control: i2c addr, register, value, enable + size */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(0), addr);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0), reg);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(0), val);
+	if (ret)
+		return ret;
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0),
+			   INV_MPU6050_BIT_SLV_EN | 1);
+	if (ret)
+		return ret;
+
+	/* do i2c xfer */
+	ret =3D inv_mpu_i2c_master_xfer(st);
+	if (ret)
+		goto error_disable_i2c;
+
+	/* disable i2c slave */
+	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
+	if (ret)
+		goto error_disable_i2c;
+
+	/* check i2c status */
+	ret =3D regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
+	if (ret)
+		return ret;
+	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
+		return -EIO;
+
+	return 0;
+
+error_disable_i2c:
+	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
+	return ret;
+}
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_aux.h
new file mode 100644
index 000000000000..bae4eab58e6c
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 TDK-InvenSense, Inc.
+ */
+
+#ifndef INV_MPU_AUX_H_
+#define INV_MPU_AUX_H_
+
+#include <linux/kernel.h>
+
+#include "inv_mpu_iio.h"
+
+/**
+ * inv_mpu_aux_init() - init i2c auxiliary bus
+ * @st: driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int inv_mpu_aux_init(const struct inv_mpu6050_state *st);
+
+/**
+ * inv_mpu_aux_read() - read register function for i2c auxiliary bus
+ * @st: driver internal state.
+ * @addr: chip i2c Address
+ * @reg: chip register address
+ * @val: buffer for storing read bytes
+ * @size: number of bytes to read
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
+		     uint8_t reg, uint8_t *val, size_t size);
+
+/**
+ * inv_mpu_aux_write() - write register function for i2c auxiliary bus
+ * @st: driver internal state.
+ * @addr: chip i2c Address
+ * @reg: chip register address
+ * @val: 1 byte value to write
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
+		      uint8_t reg, uint8_t val);
+
+#endif		/* INV_MPU_AUX_H_ */
--=20
2.17.1

