Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C13B0D5A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfILK6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:58:39 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:19204 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731284AbfILK6i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:58:38 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAtDPK012944;
        Thu, 12 Sep 2019 03:58:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=EkrbfUdO/rrNl3ayqxA+zOH+OAKS1db9sjlwB9x4RHs=;
 b=eWmred045j2PuOemO9sKq1VWnhRgFoFDnDn8PEfojuFDZ+Mm3On5x0IVVb5JJoV6erqG
 PV7xXUzThtzjA5TGx7UorJtKyorgbHseZ9J7gCRqI/lCTIHN3Fngi9HeCz9JKRQvGZM/
 fJeM3z2BK8TdHg00G9/K6jxN9+pEnWbs79WdwG9+lZw7c5L7DE9/zWBjgkQPyqxwHvWP
 VZ9EDZVYz00fKoRlzek9cUmbEtHojA1mL21yzJdGcMC6b893iOpezk0tq7N+IP6jwO4K
 PCYwvxRMun8ZOeDUsiJ/XqlOqD1vuoD2zIAmhUCwc3voEjSuygBw3tHlMV1LP7iHg3uV CA== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
        by mx0b-00328301.pphosted.com with ESMTP id 2uv8gn2s9r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAEfspsUkWGD/wpN0belHsr8e6pd6zRdaj29YWxBz0Hsw0xV/FQHcgyaiG3mMbO12y4YpDLIyZYjbVK6obuSs112FSDnj7SGUjJlv/ZrUzRaLO6WRgMSTRxQOV0BTWOAkruX8HkYgPBSMzYrE67jZ0oqWizQJWQ52tCuAZPuLCHx+rhNB3SFoXjHnhMui3Sivjuh81CmMfEqw9MgitnYRlU5Bor5SryKXYKO5tWV2bXYcnvVVbzWVofj0PmcEK7G0PC2Bm/73s48o98KM2zci6YkZjlgWWdBuKhrlOMfqAahGnaOAWHFr4CnpxeU4umSAPQRvdp5HkA/jDR98iQ/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkrbfUdO/rrNl3ayqxA+zOH+OAKS1db9sjlwB9x4RHs=;
 b=n3ksn8ZfebrCzOpTtyA2DDQpkLFeMnPKrvraXzaYx7tmnGoq/1SGxPd5AB0eUputAbc9VYBSlTns/6w/vH1LXiX75kcyjRhyTuBzyzx0ot3L5oF49CQGZCVOovpT038hwNWJ0WJVTlAEdDOwkKZ1bMiG8TfJRlpTQevNf++7yF10wvN6mvyg8CLvmCJBccSEugzTgRTT8TajZZ9R5VzSDAjIX4l2itb6/If/VyNPypBOoEoG8JPMAE0ZpKx5MjYeZl3BJQrXgN83I67MOOa1o1R5eIMWgDM6XTQh0XJcDhM0FfFAvwKIv6ugHyIeSgIv/7PHJ3KH1TzDh7nBTs2xxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkrbfUdO/rrNl3ayqxA+zOH+OAKS1db9sjlwB9x4RHs=;
 b=XTNdG4zp0fMNuEv+CXT1SzLPkS8PtOeboiInJAfT7Y+GGUv0/IVquVOdrdTwDTYC4y3aUaJu++vphvyMS3NDU7h1K68hdmET+g/gVcI6SE2simzd/8rbEauWEGdUBZV00m26VHIxc3ORAMb0/Vv4PN3kXuRdrCJrS67uBDLQhx8=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:58:34 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:58:34 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 5/7] iio: imu: inv_mpu6050: helpers for using i2c master on
 auxiliary bus
Thread-Topic: [PATCH v2 5/7] iio: imu: inv_mpu6050: helpers for using i2c
 master on auxiliary bus
Thread-Index: AQHVaVkFN2zI+sFPv0CoakMxw8BnLA==
Date:   Thu, 12 Sep 2019 10:58:34 +0000
Message-ID: <20190912105804.15650-5-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 9fc387d2-b379-4bc2-2341-08d737702800
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2911;
x-ms-traffictypediagnostic: MN2PR12MB2911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2911EF00AAF743790F758382C4B00@MN2PR12MB2911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(86362001)(6116002)(3846002)(99286004)(54906003)(2351001)(1076003)(81166006)(81156014)(8676002)(71190400001)(71200400001)(14454004)(476003)(446003)(36756003)(25786009)(80792005)(52116002)(11346002)(2616005)(14444005)(256004)(486006)(6436002)(478600001)(76176011)(386003)(53936002)(305945005)(66066001)(6512007)(8936002)(6486002)(26005)(5640700003)(6916009)(102836004)(6506007)(2906002)(107886003)(50226002)(316002)(2501003)(5660300002)(66946007)(4326008)(66446008)(64756008)(66556008)(66476007)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2911;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +a4AXS5QfOwtBILhlT2rntp0qpmUumFelCdd8oBxxA/JPiuLQjOdf+Lm3PsYA940o163jt01oaZygjVenWpb+1icYrJRmU0YqzfGniJiJ95598pZS/TcoUBWTEMBm8esgUhrqzwli6OnOyGfqmrE434bQGDfj8HZAWMVqwcD0MHnVlQ90VPtoX0I76KezVfUybZM0KyqD69AxJC7i7xBsZHQb3u9OTL1OjwE4ztt+JYQA8VVAFmUjhNexl9HmYgrl6V6GRyldIdwY5JncoDfu6nPJ/rKk5km0zihMNeOMA4V9sin21fpKMfP246+ttQWMpBbmrylQ6VO6TC88McldvJ5U3oPiOjyvWl+u8B8JKOrIbJAT01FXVPN7sdCFHenAwogkrSMIsrRw80PPqfYg3tdBCGwSQ7ZouIXs4aaTLo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc387d2-b379-4bc2-2341-08d737702800
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:58:34.6575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIRbVb1LkRwgq/S0/WiyfhADETy9bvHEIVuFFVaDFYWN/ohHalDkVAyEyqVzjrwwtjEcbqx9Csxr6vWU8RVXJM6n9xc8DhPOPhZ7zCjr12Y=
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

Add helper functions to use the i2c auxiliary bus with the MPU i2c
master block.

Support only register based chip, reading and 1 byte writing. These
will be useful for initializing magnetometers inside MPU9x50 chips.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile      |   3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 184 ++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h |  46 ++++++
 3 files changed, 232 insertions(+), 1 deletion(-)
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
index 000000000000..b4907c1a8bb6
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -0,0 +1,184 @@
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
+
+	val =3D INV_MPU6050_BIT_I2C_SLV0_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV1_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV2_DLY_EN |
+			INV_MPU6050_BIT_I2C_SLV3_DLY_EN |
+			INV_MPU6050_BIT_DELAY_ES_SHADOW;
+	return regmap_write(st->map, INV_MPU6050_REG_I2C_MST_DELAY_CTRL, val);
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
+	return regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
+				val, size);
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

