Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B7B374E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfIPJmK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:42:10 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:43960 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729494AbfIPJmK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 05:42:10 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G9eoe2021657;
        Mon, 16 Sep 2019 02:42:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=/93Xht5RW6q6ygBUH7bi+/qPp3+50Zd+Q0HD31fCt9w=;
 b=ngvjfXVK2O3AHZ5KDOgnRXuwPDzm2Xl2sBDBBn1SpgIFfxHPN1txy2hRnCxLkQHI3WCc
 wnsOOqG5IFd4Lc3xDsvMavc0eSVjtrzSOHLGmkJ/XvD4Rc6Hv/5w40CmyvXcyxliU5ii
 rg5D9WGuTXuQDp5+bvnAoNZ21uVDJ9h7l6u24oUCATrks3QWqtrXzhqe7PIeq7TJHXDA
 cTIFAj99t9ChywpANMnzLBPA/Te9gPUoeU4hJjLjivvwkagJ2J6JLAs2Th0I6Ai5xiY6
 9nJ+2CIEm5gjLkVbI4tttbjDJYjOJG8RRtLN8EM33nD8Mf8EAEHRFU4nNvfhueZTfOk6 cw== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2053.outbound.protection.outlook.com [104.47.34.53])
        by mx0a-00328301.pphosted.com with ESMTP id 2v0upprngf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuQDeK5Zm/PDGV+IgXdpQDk0ACNRUz9O2ga8SUDorwS2lZcICFYBx9QbUaSBNXzY9eSppS4FAwYKHpJ0sl0lAYoowN1i+hhMyyy1aFwM4AS3kSx1xGOqbaN+fWd/yqTU2M564995An37UHthiBjXLQTLpFNbdwaXNG+I6jCg+JXwfotw4bw3XzCXI3sS7xgeiSsmsFlLbyUwblMmWsG+yggbTBwac9Qx7gjkzupfsnRleGoPwq2OQ8eY/R5xjyMFNzEGUaUusEIAH157DPkvRybLdGc0t5JXZV4i1b3/fWb833er3oJ71mJHBuF2rz++q2q5Lt7KdV6LEBLbcpCMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/93Xht5RW6q6ygBUH7bi+/qPp3+50Zd+Q0HD31fCt9w=;
 b=fbRB6mwTOyeQelZF/BWJDyjgghPBfphAluH8Y+/zaunVs0lzvIyVKqjReK/GpUAkrIMAxUBmbYHQZamygY50Di7OaLnt2CbvZ1JC/lLcMKcAruBJFVxZ/eO/zckBJrzK5G5wNRn/ofhnEbvMUE4usDZhKlJJ3y155glKWmieyNxgO/NrWZg3o2JBTa1kfGnvS4ZMuBuuzZzfzlPUCrLDlBdaPqmETpeul5CegJEBAAsTsHmjt6AcFSshO3QYuNMQFjUYXGsfbmu9gMK6rudXtRKxRL8aCltaBBbByydy1Y+FVsrFf5tg7kRVAzNjeCf/ayh+gJr76eCxuLVvM2GFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/93Xht5RW6q6ygBUH7bi+/qPp3+50Zd+Q0HD31fCt9w=;
 b=DshrHmuNQ1FXqYnSeT6bSJCWalxXqJ8veBe6QFI6BSVCkpK0gTiTWw0zkavxRB+6ZmmUJwweaqIeyRX3MK/gkmdH8h6jgbZoyvZmzHj3VWn0ALbZ2M2JtOEsBYwbfg4iTb0RSEfKd7jhXT/ntTECgnHuWf6fKLAAaF006VKVi1o=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2632.namprd12.prod.outlook.com (20.176.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 09:42:06 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:42:06 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v3 5/7] iio: imu: inv_mpu6050: helpers for using i2c master on
 auxiliary bus
Thread-Topic: [PATCH v3 5/7] iio: imu: inv_mpu6050: helpers for using i2c
 master on auxiliary bus
Thread-Index: AQHVbHMARxYqkKq9JU667WDpt7kq+A==
Date:   Mon, 16 Sep 2019 09:42:05 +0000
Message-ID: <20190916094128.30122-6-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 21fbb5a1-2a27-45fe-3199-08d73a8a227e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2632;
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26321736EAEBCC40B2425B82C48C0@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(81166006)(99286004)(3846002)(5660300002)(66066001)(2616005)(54906003)(5640700003)(316002)(6916009)(36756003)(71200400001)(6512007)(11346002)(446003)(102836004)(26005)(6486002)(6506007)(2501003)(71190400001)(386003)(2906002)(6436002)(1076003)(305945005)(4326008)(53936002)(7736002)(186003)(6116002)(81156014)(8676002)(52116002)(107886003)(66476007)(25786009)(66446008)(76176011)(2351001)(66946007)(66556008)(8936002)(64756008)(50226002)(80792005)(256004)(14444005)(14454004)(476003)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2632;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pfiBpGmmA3w6klKMpEszEKDywzB2qBlIjWglC1Gdv7rSOTWD9/e8Nx3sjCZYR1gx+nWVFo+mbzQPLDhoRq49U/Ka91Shd1vWF+LILJh4rFtBFXavgrKlbz0p150M9zdy03x3Mr3ZDPfOfgu04NT79tV+VSXLSqmvVTHqw4qSE6Ne0IyuAF9D0eJrAWsx+QRNnFK4qdspTdfMK0bjrqNwFio3/KbbgDl0RiPgQDFvm0Rms6bbjm8nRVeqN8/lUXH6hQkNsLyewYYdcZY3Re+/m82ugEr6mFuUM/e6R1zydpDbZfVhr8Z1p7DJb6mpxs+WUL1PBzcxkQY9iDQxWwyon9JLDw3x94HB+RDC58z/jMqeCRHesP8q8yPOxDp1OfecTwCkuk62yanlye5ZQUkkrsrw7jm4E2TNWTmFIj7ZEQg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fbb5a1-2a27-45fe-3199-08d73a8a227e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:42:05.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUA6IeV5XPlagO6FqiNoY00cnZPyELrfi9k3MxBRl7WYBvshq1WEyMzZhUpNqTZJhNZnLGBVleMx0+bpDGVhnXOpYl2vhssSrgLefyMXW54=
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

Add helper functions to use the i2c auxiliary bus with the MPU i2c
master block.

Support only register based chip, reading and 1 byte writing. These
will be useful for initializing magnetometers inside MPU9x50 chips.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile      |   3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 203 ++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h |  19 ++
 3 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h

diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu=
6050/Makefile
index 33bec09fee9b..2cfbd926522f 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -4,7 +4,8 @@
 #
=20
 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o
-inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
+inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o \
+		 inv_mpu_aux.o
=20
 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
 inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_aux.c
new file mode 100644
index 000000000000..576548e28120
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -0,0 +1,203 @@
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
+/**
+ * inv_mpu_aux_init() - init i2c auxiliary bus
+ * @st: driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
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
+
+	val =3D INV_MPU6050_BIT_I2C_SLV0_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV1_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV2_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV3_DLY_EN |
+			INV_MPU6050_BIT_DELAY_ES_SHADOW;
+	return regmap_write(st->map, INV_MPU6050_REG_I2C_MST_DELAY_CTRL, val);
+}
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
+	return regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
+				val, size);
+
+error_disable_i2c:
+	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
+	return ret;
+}
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
index 000000000000..b66997545762
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 TDK-InvenSense, Inc.
+ */
+
+#ifndef INV_MPU_AUX_H_
+#define INV_MPU_AUX_H_
+
+#include "inv_mpu_iio.h"
+
+int inv_mpu_aux_init(const struct inv_mpu6050_state *st);
+
+int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
+		     uint8_t reg, uint8_t *val, size_t size);
+
+int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
+		      uint8_t reg, uint8_t val);
+
+#endif		/* INV_MPU_AUX_H_ */
--=20
2.17.1

