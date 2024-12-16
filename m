Return-Path: <linux-iio+bounces-13545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C49F33A2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053E47A338E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117D136331;
	Mon, 16 Dec 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aIgMqYVw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B533BBF2;
	Mon, 16 Dec 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360599; cv=none; b=QHH3iQLm3xT1rPkfdmwaBafRCbQ4BWQQbvqwReyXEVjuLgPdztT8TDIBh1jyPqIDNMRncCUOYm6d/MwplME1QbWXJWH0QfZSzrlpDkI0fXKeT4YWvtlAmTcjv/RJ5yQsWoefzQYCJdGXo2wXEs4tiyBCM+osmf5SntYO51TV25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360599; c=relaxed/simple;
	bh=g94CpLbqGAx5IYszf8PJhjaC+66rvmSaeAzAqu+roEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XL+xGJUXHtGDTcoYId+XwcNCqAJLycEFWXM4GfkoUNyOVM4SaN+XtTlUNImVME/nHTgZRCfJl8B+jdk1RY5QHxeFErH9YtIY4c1NOZ2B6Sg7RZW5iWTfrZrTgHXDjXm8NMy2sfGvIaeOiQHANYpiRPS+3K68paj4Hb+zmiexCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aIgMqYVw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCFq4L001211;
	Mon, 16 Dec 2024 09:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ns4KU
	/dDo513cL96HrksdXlnoley1nnblg0DTvyJVAo=; b=aIgMqYVwVkGty8bsEnb/T
	6WKgA72Q0PMRMYfqwI5FXoVkcdk8pzRhnqnXBpuM/9en8aOIZ6Yc9N2kDjmTG38i
	TXS146M97yzcczLlgDCTcoFw/k1GUyBtU4lSL2hTboFIlGmsVd7lfenM6exwlElt
	+U3XKZqIdecBEPFFB1kPJ4zZuq+x5n7UmHe+NEROFa+Ww4p2gHv/Q4oqnCiqckp5
	P4dmxL7zcJnOn4uHSIbp6s+a6Ozg0Suv/vhSRRKKsEqqj0KXj8fmY7nJJmhuwIQB
	MqbDD6Lf2iwgZCG6JGB71qoA80GpltyNsplw6r5N7LKPDqOzV4bXEsA2w7Qvzz1H
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43jm2d0kh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:49:37 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BGEnaj9044481
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 09:49:36 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:49:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:49:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 16 Dec 2024 09:49:36 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BGEmKdn018405;
	Mon, 16 Dec 2024 09:49:28 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shen
 Jianping <Jianping.Shen@de.bosch.com>,
        Robert Budai
	<robert.budai@analog.com>,
        "Alex Lanzano" <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH v3 6/7] iio: imu: adis16550: add adis16550 support
Date: Mon, 16 Dec 2024 16:48:12 +0200
Message-ID: <20241216144818.25344-7-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216144818.25344-1-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _JJHR6IRXQ3H-Dn3BF95JjKjfDWaq6w5
X-Proofpoint-GUID: _JJHR6IRXQ3H-Dn3BF95JjKjfDWaq6w5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160124

The ADIS16550 is a complete inertial system that includes a triaxis
gyroscope and a triaxis accelerometer. Each inertial sensor in
the ADIS16550 combines industry leading MEMS only technology
with signal conditioning that optimizes dynamic performance. The
factory calibration characterizes each sensor for sensitivity, bias,
and alignment. As a result, each sensor has its own dynamic com-
pensation formulas that provide accurate sensor measurements

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v3:
- freed xbuf
- fixed code styling related issues
- removed the sensor type enum and used separate structures for providing chip info data


 drivers/iio/imu/Kconfig     |   13 +
 drivers/iio/imu/Makefile    |    1 +
 drivers/iio/imu/adis16550.c | 1222 +++++++++++++++++++++++++++++++++++
 3 files changed, 1236 insertions(+)
 create mode 100644 drivers/iio/imu/adis16550.c

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index ca0efecb5b5c..c4e06ebbe058 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -52,6 +52,19 @@ config ADIS16480
 	  Say yes here to build support for Analog Devices ADIS16375, ADIS16480,
 	  ADIS16485, ADIS16488 inertial sensors.
 
+config ADIS16550
+	tristate "Analog Devices ADIS16550 and similar IMU driver"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	select CRC32
+	help
+	  Say yes here to build support for Analog Devices ADIS16550 inertial
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called adis16550.
+
 source "drivers/iio/imu/bmi160/Kconfig"
 source "drivers/iio/imu/bmi270/Kconfig"
 source "drivers/iio/imu/bmi323/Kconfig"
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 04c77c2c4df8..e901aea498d3 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ADIS16400) += adis16400.o
 obj-$(CONFIG_ADIS16460) += adis16460.o
 obj-$(CONFIG_ADIS16475) += adis16475.o
 obj-$(CONFIG_ADIS16480) += adis16480.o
+obj-$(CONFIG_ADIS16550) += adis16550.o
 
 adis_lib-y += adis.o
 adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_trigger.o
diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
new file mode 100644
index 000000000000..6e9d98dee0d8
--- /dev/null
+++ b/drivers/iio/imu/adis16550.c
@@ -0,0 +1,1222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADIS16550 IMU driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/crc32.h>
+#include <linux/debugfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/imu/adis.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/lcm.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/swab.h>
+#include <linux/unaligned.h>
+
+#define ADIS16550_REG_BURST_GYRO_ACCEL		0x0a
+#define ADIS16550_REG_BURST_DELTA_ANG_VEL	0x0b
+#define ADIS16550_BURST_DATA_GYRO_ACCEL_MASK	GENMASK(5, 0)
+#define ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK	GENMASK(12, 7)
+
+#define ADIS16550_REG_STATUS		0x0e
+#define ADIS16550_REG_TEMP		0x10
+#define ADIS16550_REG_X_GYRO		0x12
+#define ADIS16550_REG_Y_GYRO		0x14
+#define ADIS16550_REG_Z_GYRO		0x16
+#define ADIS16550_REG_X_ACCEL		0x18
+#define ADIS16550_REG_Y_ACCEL		0x1a
+#define ADIS16550_REG_Z_ACCEL		0x1c
+#define ADIS16550_REG_X_DELTANG_L	0x1E
+#define ADIS16550_REG_Y_DELTANG_L	0x20
+#define ADIS16550_REG_Z_DELTANG_L	0x22
+#define ADIS16550_REG_X_DELTVEL_L	0x24
+#define ADIS16550_REG_Y_DELTVEL_L	0x26
+#define ADIS16550_REG_Z_DELTVEL_L	0x28
+#define ADIS16550_REG_X_GYRO_SCALE	0x30
+#define ADIS16550_REG_Y_GYRO_SCALE	0x32
+#define ADIS16550_REG_Z_GYRO_SCALE	0x34
+#define ADIS16550_REG_X_ACCEL_SCALE	0x36
+#define ADIS16550_REG_Y_ACCEL_SCALE	0x38
+#define ADIS16550_REG_Z_ACCEL_SCALE	0x3a
+#define ADIS16550_REG_X_GYRO_BIAS	0x40
+#define ADIS16550_REG_Y_GYRO_BIAS	0x42
+#define ADIS16550_REG_Z_GYRO_BIAS	0x44
+#define ADIS16550_REG_X_ACCEL_BIAS	0x46
+#define ADIS16550_REG_Y_ACCEL_BIAS	0x48
+#define ADIS16550_REG_Z_ACCEL_BIAS	0x4a
+#define ADIS16550_REG_COMMAND		0x50
+#define ADIS16550_REG_CONFIG		0x52
+#define ADIS16550_GYRO_FIR_EN_MASK	BIT(3)
+#define ADIS16550_ACCL_FIR_EN_MASK	BIT(2)
+#define ADIS16550_SYNC_MASK	\
+			(ADIS16550_SYNC_EN_MASK | ADIS16550_SYNC_MODE_MASK)
+#define ADIS16550_SYNC_MODE_MASK	BIT(1)
+#define ADIS16550_SYNC_EN_MASK		BIT(0)
+/* max of 4000 SPS in scale sync */
+#define ADIS16550_SYNC_SCALE_MAX_RATE	(4000 * 1000)
+#define ADIS16550_REG_DEC_RATE		0x54
+#define ADIS16550_REG_SYNC_SCALE	0x56
+#define ADIS16550_REG_SERIAL_NUM	0x76
+#define ADIS16550_REG_FW_REV		0x7A
+#define ADIS16550_REG_FW_DATE		0x7C
+#define ADIS16550_REG_PROD_ID		0x7E
+#define ADIS16550_REG_FLASH_CNT		0x72
+/* spi protocol*/
+#define ADIS16550_SPI_DATA_MASK		GENMASK(31, 16)
+#define ADIS16550_SPI_REG_MASK		GENMASK(14, 8)
+#define ADIS16550_SPI_R_W_MASK		BIT(7)
+#define ADIS16550_SPI_CRC_MASK		GENMASK(3, 0)
+#define ADIS16550_SPI_SV_MASK		GENMASK(7, 6)
+/* burst read */
+#define ADIS16550_BURST_N_ELEM		12
+#define ADIS16550_BURST_DATA_LEN	(ADIS16550_BURST_N_ELEM * 4)
+#define ADIS16550_MAX_SCAN_DATA		12
+
+struct adis16550_sync {
+	u16 sync_mode;
+	u16 min_rate;
+	u16 max_rate;
+};
+
+struct adis16550_chip_info {
+	const struct iio_chan_spec *channels;
+	const struct adis16550_sync *sync_mode;
+	char *name;
+	u32 num_channels;
+	u32 gyro_max_val;
+	u32 gyro_max_scale;
+	u32 accel_max_val;
+	u32 accel_max_scale;
+	u32 temp_scale;
+	u32 deltang_max_val;
+	u32 deltvel_max_val;
+	u32 int_clk;
+	u16 max_dec;
+	u16 num_sync;
+};
+
+struct adis16550 {
+	const struct adis16550_chip_info *info;
+	struct adis adis;
+	unsigned long clk_freq_hz;
+	u32 sync_mode;
+};
+
+enum {
+	ADIS16550_SV_INIT,
+	ADIS16550_SV_OK,
+	ADIS16550_SV_NOK,
+	ADIS16550_SV_SPI_ERROR,
+};
+
+/*
+ * This is a simplified implementation of lib/crc4.c. It could not be used
+ * directly since the polynomial used is different from the one used by the
+ * 16550 which is 0b10001
+ */
+static u8 spi_crc4(const u32 val)
+{
+	int i;
+	const int bits = 28;
+	u8 crc = 0xa;
+	/* ignore 4lsb */
+	const u32 __val = val >> 4;
+
+	/* Calculate crc4 over four-bit nibbles, starting at the MSbit */
+	for (i = bits - 4; i >= 0; i -= 4)
+		crc = crc ^ ((__val >> i) & 0xf);
+
+	return crc;
+}
+
+static int adis16550_spi_validate(const struct adis *adis, __be32 dout,
+				  u16 *data)
+{
+	u32 __dout;
+	u8 crc, crc_rcv, sv;
+
+	__dout = be32_to_cpu(dout);
+
+	/* validate received message */
+	crc_rcv = FIELD_GET(ADIS16550_SPI_CRC_MASK, __dout);
+	crc = spi_crc4(__dout);
+	if (crc_rcv != crc) {
+		dev_err(&adis->spi->dev,
+			"Invalid crc, rcv: 0x%02x, calc: 0x%02x!\n",
+			crc_rcv, crc);
+		return -EIO;
+	}
+	sv = FIELD_GET(ADIS16550_SPI_SV_MASK, __dout);
+	if (sv >= ADIS16550_SV_NOK) {
+		dev_err(&adis->spi->dev,
+			"State vector error detected: %02X", sv);
+		return -EIO;
+	}
+	*data = FIELD_GET(ADIS16550_SPI_DATA_MASK, __dout);
+
+	return 0;
+}
+
+static void adis16550_spi_msg_prepare(const u32 reg, const bool write,
+				      const u16 data, __be32 *din)
+{
+	u8 crc;
+	u32 __din;
+
+	__din = FIELD_PREP(ADIS16550_SPI_REG_MASK, reg);
+
+	if (write) {
+		__din |= FIELD_PREP(ADIS16550_SPI_R_W_MASK, true);
+		__din |= FIELD_PREP(ADIS16550_SPI_DATA_MASK, data);
+	}
+
+	crc = spi_crc4(__din);
+	__din |= FIELD_PREP(ADIS16550_SPI_CRC_MASK, crc);
+
+	*din = cpu_to_be32(__din);
+}
+
+static int adis16550_spi_xfer(const struct adis *adis, u32 reg, u32 len,
+			      u32 *readval, u32 writeval)
+{
+	int ret;
+	u16 data = 0;
+	struct spi_message msg;
+	__be32 __din[2], __dout[2];
+	bool wr = readval ? false : true;
+	struct spi_device *spi = adis->spi;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &__din[0],
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &__din[1],
+			.len = 4,
+			.cs_change = 1,
+			.rx_buf = __dout,
+		}, {
+			.tx_buf = &__din[1],
+			.rx_buf = &__dout[1],
+			.len = 4,
+		},
+	};
+
+	spi_message_init(&msg);
+
+	switch (len) {
+	case 4:
+		adis16550_spi_msg_prepare(reg + 1, wr, writeval >> 16,
+					  &__din[0]);
+		spi_message_add_tail(&xfers[0], &msg);
+		fallthrough;
+	case 2:
+		adis16550_spi_msg_prepare(reg, wr, writeval, &__din[1]);
+		spi_message_add_tail(&xfers[1], &msg);
+		spi_message_add_tail(&xfers[2], &msg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = spi_sync(spi, &msg);
+	if (ret) {
+		dev_err(&spi->dev, "Spi failure %d\n", ret);
+		return ret;
+	}
+	/*
+	 * When writing a register, the device will reply with a readback on the
+	 * transfer so that we can validate if our data was actually written..
+	 */
+	switch (len) {
+	case 4:
+		ret = adis16550_spi_validate(adis, __dout[0], &data);
+		if (ret)
+			return ret;
+
+		if (readval) {
+			*readval = data << 16;
+		} else if ((writeval >> 16) != data && reg != ADIS16550_REG_COMMAND) {
+			dev_err(&spi->dev,
+				"Data not written: wr: 0x%04X, rcv: 0x%04X\n",
+				writeval >> 16, data);
+			return -EIO;
+		}
+
+		fallthrough;
+	case 2:
+		ret = adis16550_spi_validate(adis, __dout[1], &data);
+		if (ret)
+			return ret;
+
+		if (readval) {
+			*readval = (*readval & GENMASK(31, 16)) | data;
+		} else if ((writeval & GENMASK(15, 0)) != data && reg != ADIS16550_REG_COMMAND) {
+			dev_err(&spi->dev,
+				"Data not written: wr: 0x%04X, rcv: 0x%04X\n",
+				(u16)writeval, data);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int adis16550_spi_read(struct adis *adis, const u32 reg,
+			      u32 *value, const u32 len)
+{
+	return adis16550_spi_xfer(adis, reg, len, value, 0);
+}
+
+static int adis16550_spi_write(struct adis *adis, const u32 reg,
+			       const u32 value, const u32 len)
+{
+	return adis16550_spi_xfer(adis, reg, len, NULL, value);
+}
+
+static ssize_t adis16550_show_firmware_revision(struct file *file,
+						char __user *userbuf,
+						size_t count, loff_t *ppos)
+{
+	struct adis16550 *st = file->private_data;
+	char buf[7];
+	size_t len;
+	u16 rev;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16550_REG_FW_REV, &rev);
+	if (ret)
+		return ret;
+
+	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static const struct file_operations adis16550_firmware_revision_fops = {
+	.open = simple_open,
+	.read = adis16550_show_firmware_revision,
+	.llseek = default_llseek,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t adis16550_show_firmware_date(struct file *file,
+					    char __user *userbuf,
+					    size_t count, loff_t *ppos)
+{
+	struct adis16550 *st = file->private_data;
+	u32 date;
+	char buf[12];
+	size_t len;
+	int ret;
+
+	ret = adis_read_reg_32(&st->adis, ADIS16550_REG_FW_DATE, &date);
+	if (ret)
+		return ret;
+
+	len = scnprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", date & 0xff,
+			(date >> 8) & 0xff, date >> 16);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static const struct file_operations adis16550_firmware_date_fops = {
+	.open = simple_open,
+	.read = adis16550_show_firmware_date,
+	.llseek = default_llseek,
+	.owner = THIS_MODULE,
+};
+
+static int adis16550_show_serial_number(void *arg, u64 *val)
+{
+	struct adis16550 *st = arg;
+	u32 serial;
+	int ret;
+
+	ret = adis_read_reg_32(&st->adis, ADIS16550_REG_SERIAL_NUM, &serial);
+	if (ret)
+		return ret;
+
+	*val = serial;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(adis16550_serial_number_fops,
+			 adis16550_show_serial_number, NULL, "0x%.8llx\n");
+
+static int adis16550_show_product_id(void *arg, u64 *val)
+{
+	struct adis16550 *st = arg;
+	u16 prod_id;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16550_REG_PROD_ID, &prod_id);
+	if (ret)
+		return ret;
+
+	*val = prod_id;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(adis16550_product_id_fops,
+			 adis16550_show_product_id, NULL, "%llu\n");
+
+static int adis16550_show_flash_count(void *arg, u64 *val)
+{
+	struct adis16550 *st = arg;
+	u16 flash_count;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16550_REG_FLASH_CNT, &flash_count);
+	if (ret)
+		return ret;
+
+	*val = flash_count;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(adis16550_flash_count_fops,
+			 adis16550_show_flash_count, NULL, "%lld\n");
+
+static void adis16550_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct adis16550 *st = iio_priv(indio_dev);
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+
+	debugfs_create_file_unsafe("serial_number", 0400,
+				   d, st, &adis16550_serial_number_fops);
+	debugfs_create_file_unsafe("product_id", 0400,
+				   d, st, &adis16550_product_id_fops);
+	debugfs_create_file("firmware_revision", 0400,
+			    d, st, &adis16550_firmware_revision_fops);
+	debugfs_create_file("firmware_date", 0400, d,
+			    st, &adis16550_firmware_date_fops);
+	debugfs_create_file_unsafe("flash_count", 0400,
+				   d, st, &adis16550_flash_count_fops);
+}
+
+enum {
+	ADIS16550_SYNC_MODE_DIRECT,
+	ADIS16550_SYNC_MODE_SCALED,
+};
+
+static int adis16550_get_freq(struct adis16550 *st, u32 *freq)
+{
+	int ret;
+	u16 dec = 0;
+	u32 sample_rate = st->clk_freq_hz;
+
+	adis_dev_auto_lock(&st->adis);
+
+	if (st->sync_mode == ADIS16550_SYNC_MODE_SCALED) {
+		u16 sync_scale;
+
+		ret = __adis_read_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE, &sync_scale);
+		if (ret)
+			return ret;
+
+		sample_rate = st->clk_freq_hz * sync_scale;
+	}
+
+	ret = __adis_read_reg_16(&st->adis, ADIS16550_REG_DEC_RATE, &dec);
+	if (ret)
+		return -EINVAL;
+	*freq = DIV_ROUND_CLOSEST(sample_rate, dec + 1);
+
+	return 0;
+}
+
+static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
+{
+	u16 dec;
+	int ret;
+	u32 sample_rate = st->clk_freq_hz;
+	/*
+	 * The optimal sample rate for the supported IMUs is between
+	 * int_clk - 1000 and int_clk + 500.
+	 */
+	u32 max_sample_rate = st->info->int_clk * 1000 + 500000;
+	u32 min_sample_rate = st->info->int_clk * 1000 - 1000000;
+
+	if (!freq_hz)
+		return -EINVAL;
+
+	adis_dev_auto_lock(&st->adis);
+
+	if (st->sync_mode == ADIS16550_SYNC_MODE_SCALED) {
+		unsigned long scaled_rate = lcm(st->clk_freq_hz, freq_hz);
+		int sync_scale;
+
+		if (scaled_rate > max_sample_rate)
+			scaled_rate = max_sample_rate / st->clk_freq_hz * st->clk_freq_hz;
+		else
+			scaled_rate = max_sample_rate / scaled_rate * scaled_rate;
+
+		if (scaled_rate < min_sample_rate)
+			scaled_rate = roundup(min_sample_rate, st->clk_freq_hz);
+
+		sync_scale = scaled_rate / st->clk_freq_hz;
+		ret = __adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
+					  sync_scale);
+		if (ret)
+			return ret;
+
+		sample_rate = scaled_rate;
+	}
+
+	dec = DIV_ROUND_CLOSEST(sample_rate, freq_hz);
+
+	if (dec)
+		dec--;
+
+	dec = min(dec, st->info->max_dec);
+
+	return __adis_write_reg_16(&st->adis, ADIS16550_REG_DEC_RATE, dec);
+}
+
+static int adis16550_get_accl_filter_freq(struct adis16550 *st, int *freq_hz)
+{
+	int ret;
+	u16 config = 0;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16550_REG_CONFIG, &config);
+	if (ret)
+		return -EINVAL;
+
+	if (FIELD_GET(ADIS16550_ACCL_FIR_EN_MASK, config))
+		*freq_hz = 100;
+	else
+		*freq_hz = 0;
+
+	return 0;
+}
+
+static int adis16550_set_accl_filter_freq(struct adis16550 *st, int freq_hz)
+{
+	bool en = false;
+
+	if (freq_hz)
+		en = true;
+
+	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
+				  ADIS16550_ACCL_FIR_EN_MASK,
+				  (u32)FIELD_PREP(ADIS16550_ACCL_FIR_EN_MASK, en));
+}
+
+static int adis16550_get_gyro_filter_freq(struct adis16550 *st, int *freq_hz)
+{
+	int ret;
+	u16 config = 0;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16550_REG_CONFIG, &config);
+	if (ret)
+		return -EINVAL;
+
+	if (FIELD_GET(ADIS16550_GYRO_FIR_EN_MASK, config))
+		*freq_hz = 100;
+	else
+		*freq_hz = 0;
+
+	return 0;
+}
+
+static int adis16550_set_gyro_filter_freq(struct adis16550 *st, int freq_hz)
+{
+	bool en = false;
+
+	if (freq_hz)
+		en = true;
+
+	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
+				  ADIS16550_GYRO_FIR_EN_MASK,
+				  (u32)FIELD_PREP(ADIS16550_GYRO_FIR_EN_MASK, en));
+}
+
+enum {
+	ADIS16550_SCAN_GYRO_X,
+	ADIS16550_SCAN_GYRO_Y,
+	ADIS16550_SCAN_GYRO_Z,
+	ADIS16550_SCAN_ACCEL_X,
+	ADIS16550_SCAN_ACCEL_Y,
+	ADIS16550_SCAN_ACCEL_Z,
+	ADIS16550_SCAN_TEMP,
+	ADIS16550_SCAN_DELTANG_X,
+	ADIS16550_SCAN_DELTANG_Y,
+	ADIS16550_SCAN_DELTANG_Z,
+	ADIS16550_SCAN_DELTVEL_X,
+	ADIS16550_SCAN_DELTVEL_Y,
+	ADIS16550_SCAN_DELTVEL_Z,
+};
+
+static const u32 adis16550_calib_bias[] = {
+	[ADIS16550_SCAN_GYRO_X] = ADIS16550_REG_X_GYRO_BIAS,
+	[ADIS16550_SCAN_GYRO_Y] = ADIS16550_REG_Y_GYRO_BIAS,
+	[ADIS16550_SCAN_GYRO_Z] = ADIS16550_REG_Z_GYRO_BIAS,
+	[ADIS16550_SCAN_ACCEL_X] = ADIS16550_REG_X_ACCEL_BIAS,
+	[ADIS16550_SCAN_ACCEL_Y] = ADIS16550_REG_Y_ACCEL_BIAS,
+	[ADIS16550_SCAN_ACCEL_Z] = ADIS16550_REG_Z_ACCEL_BIAS,
+
+};
+
+static const u32 adis16550_calib_scale[] = {
+	[ADIS16550_SCAN_GYRO_X] = ADIS16550_REG_X_GYRO_SCALE,
+	[ADIS16550_SCAN_GYRO_Y] = ADIS16550_REG_Y_GYRO_SCALE,
+	[ADIS16550_SCAN_GYRO_Z] = ADIS16550_REG_Z_GYRO_SCALE,
+	[ADIS16550_SCAN_ACCEL_X] = ADIS16550_REG_X_ACCEL_SCALE,
+	[ADIS16550_SCAN_ACCEL_Y] = ADIS16550_REG_Y_ACCEL_SCALE,
+	[ADIS16550_SCAN_ACCEL_Z] = ADIS16550_REG_Z_ACCEL_SCALE,
+};
+
+static int adis16550_read_raw(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      int *val, int *val2, long info)
+{
+	struct adis16550 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
+	u16 scale;
+	int ret;
+	u32 tmp;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return adis_single_conversion(indio_dev, chan, 0, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = st->info->gyro_max_val;
+			*val2 = st->info->gyro_max_scale;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_ACCEL:
+			*val = st->info->accel_max_val;
+			*val2 = st->info->accel_max_scale;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			*val = st->info->temp_scale;
+			return IIO_VAL_INT;
+		case IIO_DELTA_ANGL:
+			*val = st->info->deltang_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_DELTA_VELOCITY:
+			*val = st->info->deltvel_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		/* temperature centered at 25°C */
+		*val = DIV_ROUND_CLOSEST(25000, st->info->temp_scale);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = adis_read_reg_32(&st->adis,
+				       adis16550_calib_bias[idx], val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = adis_read_reg_16(&st->adis,
+				       adis16550_calib_scale[idx], &scale);
+		if (ret)
+			return ret;
+
+		*val = scale;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = adis16550_get_freq(st, &tmp);
+		if (ret)
+			return ret;
+
+		*val = tmp / 1000;
+		*val2 = (tmp % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			ret = adis16550_get_accl_filter_freq(st, val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			ret = adis16550_get_gyro_filter_freq(st, val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adis16550_write_raw(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       int val, int val2, long info)
+{
+	struct adis16550 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
+	u32 tmp;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		tmp = val * 1000 + val2 / 1000;
+		return adis16550_set_freq_hz(st, tmp);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return adis_write_reg_32(&st->adis, adis16550_calib_bias[idx],
+					 val);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return adis_write_reg_16(&st->adis, adis16550_calib_scale[idx],
+					 val);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			return adis16550_set_accl_filter_freq(st, val);
+		case IIO_ACCEL:
+			return adis16550_set_gyro_filter_freq(st, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+#define ADIS16550_MOD_CHAN(_type, _mod, _address, _si) \
+	{ \
+		.type = (_type), \
+		.modified = 1, \
+		.channel2 = (_mod), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_CALIBBIAS) | \
+			BIT(IIO_CHAN_INFO_CALIBSCALE), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.address = (_address), \
+		.scan_index = (_si), \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = 32, \
+			.storagebits = 32, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define ADIS16550_GYRO_CHANNEL(_mod) \
+	ADIS16550_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
+	ADIS16550_REG_ ## _mod ## _GYRO, ADIS16550_SCAN_GYRO_ ## _mod)
+
+#define ADIS16550_ACCEL_CHANNEL(_mod) \
+	ADIS16550_MOD_CHAN(IIO_ACCEL, IIO_MOD_ ## _mod, \
+	ADIS16550_REG_ ## _mod ## _ACCEL, ADIS16550_SCAN_ACCEL_ ## _mod)
+
+#define ADIS16550_TEMP_CHANNEL() { \
+		.type = IIO_TEMP, \
+		.indexed = 1, \
+		.channel = 0, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.address = ADIS16550_REG_TEMP, \
+		.scan_index = ADIS16550_SCAN_TEMP, \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = 16, \
+			.storagebits = 32, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define ADIS16550_MOD_CHAN_DELTA(_type, _mod, _address, _si) { \
+		.type = (_type), \
+		.modified = 1, \
+		.channel2 = (_mod), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.address = (_address), \
+		.scan_index = _si, \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = 32, \
+			.storagebits = 32, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define ADIS16550_DELTANG_CHAN(_mod) \
+	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+			   ADIS16550_REG_ ## _mod ## _DELTANG_L, ADIS16550_SCAN_DELTANG_ ## _mod)
+
+#define ADIS16550_DELTVEL_CHAN(_mod) \
+	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+			   ADIS16550_REG_ ## _mod ## _DELTVEL_L, ADIS16550_SCAN_DELTVEL_ ## _mod)
+
+#define ADIS16550_DELTANG_CHAN_NO_SCAN(_mod) \
+	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+			   ADIS16550_REG_ ## _mod ## _DELTANG_L, -1)
+
+#define ADIS16550_DELTVEL_CHAN_NO_SCAN(_mod) \
+	ADIS16550_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+			   ADIS16550_REG_ ## _mod ## _DELTVEL_L, -1)
+
+static const struct iio_chan_spec adis16550_channels[] = {
+	ADIS16550_GYRO_CHANNEL(X),
+	ADIS16550_GYRO_CHANNEL(Y),
+	ADIS16550_GYRO_CHANNEL(Z),
+	ADIS16550_ACCEL_CHANNEL(X),
+	ADIS16550_ACCEL_CHANNEL(Y),
+	ADIS16550_ACCEL_CHANNEL(Z),
+	ADIS16550_TEMP_CHANNEL(),
+	ADIS16550_DELTANG_CHAN(X),
+	ADIS16550_DELTANG_CHAN(Y),
+	ADIS16550_DELTANG_CHAN(Z),
+	ADIS16550_DELTVEL_CHAN(X),
+	ADIS16550_DELTVEL_CHAN(Y),
+	ADIS16550_DELTVEL_CHAN(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(13),
+};
+
+static const struct adis16550_sync adis16550_sync_modes[] = {
+	{ ADIS16550_SYNC_MODE_DIRECT, 3000, 4500 },
+	{ ADIS16550_SYNC_MODE_SCALED, 1, 128 },
+};
+
+static const struct adis16550_chip_info adis16550_chip_info = {
+	.num_channels = ARRAY_SIZE(adis16550_channels),
+	.channels = adis16550_channels,
+	.name = "adis16550",
+	.gyro_max_val = 1,
+	.gyro_max_scale = IIO_RAD_TO_DEGREE(80 << 16),
+	.accel_max_val = 1,
+	.accel_max_scale = IIO_M_S_2_TO_G(102400000),
+	.temp_scale = 4,
+	.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+	.deltvel_max_val = 125,
+	.int_clk = 4000,
+	.max_dec = 4095,
+	.sync_mode = adis16550_sync_modes,
+	.num_sync = ARRAY_SIZE(adis16550_sync_modes),
+};
+
+static const struct adis16550_chip_info adis16550w_chip_info = {
+	.num_channels = ARRAY_SIZE(adis16550_channels),
+	.channels = adis16550_channels,
+	.name = "adis16550w",
+	.gyro_max_val = 1,
+	.gyro_max_scale = IIO_RAD_TO_DEGREE(80 << 16),
+	.accel_max_val = 1,
+	.accel_max_scale = IIO_M_S_2_TO_G(102400000),
+	.temp_scale = 4,
+	.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+	.deltvel_max_val = 125,
+	.int_clk = 4000,
+	.max_dec = 4095,
+	.sync_mode = adis16550_sync_modes,
+	.num_sync = ARRAY_SIZE(adis16550_sync_modes),
+};
+
+static u32 adis16550_validate_crc(const u32 *buf, const u8 n_elem,
+				  const u32 crc)
+{
+	int i;
+	u32 crc_calc;
+	u32 crc_buf[ADIS16550_BURST_N_ELEM - 2];
+	/*
+	 * The crc calculation of the data is done in little endian. Hence, we
+	 * always swap the 32bit elements making sure that the data LSB is
+	 * always on address 0...
+	 */
+	for (i = 0; i < n_elem; i++)
+		crc_buf[i] = swab32(buf[i]);
+
+	crc_calc = crc32(~0, crc_buf, n_elem * 4);
+	crc_calc ^= ~0;
+
+	return (crc_calc == crc);
+}
+
+static irqreturn_t adis16550_trigger_handler(int irq, void *p)
+{
+	u32 crc;
+	u16 dummy;
+	bool valid;
+	int ret, i = 0;
+	u8 data_offset = 4;
+	struct iio_poll_func *pf = p;
+	__be32 data[ADIS16550_MAX_SCAN_DATA];
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16550 *st = iio_priv(indio_dev);
+	struct adis *adis = iio_device_get_drvdata(indio_dev);
+	__be32 *buffer = adis->buffer;
+
+	ret = spi_sync(adis->spi, &adis->msg);
+	if (ret)
+		goto done;
+	/*
+	 * Validate the header. The header is a normal spi reply with state
+	 * vector and crc4.
+	 */
+	ret = adis16550_spi_validate(&st->adis, buffer[0], &dummy);
+	if (ret)
+		goto done;
+
+	crc = be32_to_cpu(buffer[ADIS16550_BURST_N_ELEM - 1]);
+	/* the header is not included in the crc */
+	valid = adis16550_validate_crc((u32 *)&buffer[1],
+				       ADIS16550_BURST_N_ELEM - 2, crc);
+	if (!valid) {
+		dev_err(&adis->spi->dev, "Burst Invalid crc!\n");
+		goto done;
+	}
+
+	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_GYRO_X)) {
+		memcpy(&data[i], &buffer[data_offset], (ADIS16550_SCAN_ACCEL_Z -
+						ADIS16550_SCAN_GYRO_X + 1) *
+						sizeof(__be32));
+		i += ADIS16550_SCAN_ACCEL_Z - ADIS16550_SCAN_GYRO_X + 1;
+	}
+	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_TEMP))
+		data[i++] = buffer[data_offset - 1];
+	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_DELTANG_X))
+		memcpy(&data[i], &buffer[data_offset],
+		       (ADIS16550_SCAN_DELTVEL_Z - ADIS16550_SCAN_DELTANG_X + 1) *
+		       sizeof(__be32));
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const unsigned long adis16550_channel_masks[] = {
+	ADIS16550_BURST_DATA_GYRO_ACCEL_MASK | BIT(ADIS16550_SCAN_TEMP),
+	ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK | BIT(ADIS16550_SCAN_TEMP),
+};
+
+static int adis16550_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	struct adis *adis = iio_device_get_drvdata(indio_dev);
+	u16 burst_length = ADIS16550_BURST_DATA_LEN;
+	u8 burst_cmd;
+	u8 *tx;
+
+	if (*scan_mask & ADIS16550_BURST_DATA_GYRO_ACCEL_MASK)
+		burst_cmd = ADIS16550_REG_BURST_GYRO_ACCEL;
+	else
+		burst_cmd = ADIS16550_REG_BURST_DELTA_ANG_VEL;
+
+	if (adis->xfer)
+		memset(adis->xfer, 0, 2 * sizeof(*adis->xfer));
+	if (adis->buffer)
+		memset(adis->buffer, 0, burst_length + sizeof(u32));
+
+	tx = adis->buffer + burst_length;
+	tx[0] = 0x00;
+	tx[1] = 0x00;
+	tx[2] = burst_cmd;
+	/* crc4 is 0 on burst command */
+	tx[3] = spi_crc4(get_unaligned_le32(tx));
+
+	adis->xfer[0].tx_buf = tx;
+	adis->xfer[0].len = 4;
+	adis->xfer[0].cs_change = 1;
+	adis->xfer[0].delay.value = 8;
+	adis->xfer[0].delay.unit = SPI_DELAY_UNIT_USECS;
+	adis->xfer[1].rx_buf = adis->buffer;
+	adis->xfer[1].len = burst_length;
+
+	spi_message_init_with_transfers(&adis->msg, adis->xfer, 2);
+
+	return 0;
+}
+
+static int adis16550_reset(struct adis *adis)
+{
+	return __adis_write_reg_16(adis, ADIS16550_REG_COMMAND, BIT(15));
+}
+
+static int adis16550_config_sync(struct adis16550 *st)
+{
+	struct device *dev = &st->adis.spi->dev;
+	const struct adis16550_sync *sync;
+	struct clk *clk;
+	u32 sync_mode;
+	u16 mode;
+	int ret;
+
+	if (!device_property_present(dev, "adi,sync-mode")) {
+		st->clk_freq_hz = st->info->int_clk * 1000;
+		return 0;
+	}
+
+	ret = device_property_read_u32(dev, "adi,sync-mode", &sync_mode);
+	if (ret)
+		return 0;
+
+	if (sync_mode >= st->info->num_sync) {
+		dev_err(dev, "Invalid sync mode: %u for %s\n", sync_mode,
+			st->info->name);
+		return -EINVAL;
+	}
+
+	sync = &st->info->sync_mode[sync_mode];
+	st->sync_mode = sync->sync_mode;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	st->clk_freq_hz = clk_get_rate(clk);
+	if (st->clk_freq_hz > sync->max_rate || st->clk_freq_hz < sync->min_rate)
+		return dev_err_probe(dev, -EINVAL,
+				     "Clk rate: %lu not in a valid range:[%u %u]\n",
+				     st->clk_freq_hz, sync->min_rate, sync->max_rate);
+
+	if (sync->sync_mode == ADIS16550_SYNC_MODE_SCALED) {
+		u16 sync_scale;
+		u32 scaled_freq = 0;
+		/*
+		 * In pps scaled sync we must scale the input clock to a range
+		 * of [3000 45000].
+		 */
+		ret = device_property_read_u32(dev, "adi,scaled-output-hz",
+					       &scaled_freq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "adi,scaled-output-hz property not found");
+
+		if (scaled_freq < 3000 || scaled_freq > 4500)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value:%u for adi,scaled-output-hz",
+					     scaled_freq);
+
+		sync_scale = DIV_ROUND_CLOSEST(scaled_freq, st->clk_freq_hz);
+
+		ret = adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
+					sync_scale);
+		if (ret)
+			return ret;
+
+		st->clk_freq_hz = scaled_freq;
+	}
+
+	st->clk_freq_hz *= 1000;
+
+	mode = FIELD_PREP(ADIS16550_SYNC_MODE_MASK, sync->sync_mode) |
+	       FIELD_PREP(ADIS16550_SYNC_EN_MASK, true);
+
+	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
+				  ADIS16550_SYNC_MASK, mode);
+}
+
+static const struct iio_info adis16550_info = {
+	.read_raw = &adis16550_read_raw,
+	.write_raw = &adis16550_write_raw,
+	.update_scan_mode = adis16550_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
+};
+
+enum {
+	ADIS16550_STATUS_CRC_CODE,
+	ADIS16550_STATUS_CRC_CONFIG,
+	ADIS16550_STATUS_FLASH_UPDATE,
+	ADIS16550_STATUS_INERIAL,
+	ADIS16550_STATUS_SENSOR,
+	ADIS16550_STATUS_TEMPERATURE,
+	ADIS16550_STATUS_SPI,
+	ADIS16550_STATUS_PROCESSING,
+	ADIS16550_STATUS_POWER,
+	ADIS16550_STATUS_BOOT,
+	ADIS16550_STATUS_WATCHDOG = 15,
+	ADIS16550_STATUS_REGULATOR = 28,
+	ADIS16550_STATUS_SENSOR_SUPPLY,
+	ADIS16550_STATUS_CPU_SUPPLY,
+	ADIS16550_STATUS_5V_SUPPLY
+};
+
+static const char * const adis16550_status_error_msgs[] = {
+	[ADIS16550_STATUS_CRC_CODE] = "Code CRC Error",
+	[ADIS16550_STATUS_CRC_CONFIG] = "Configuration/Calibration CRC Error",
+	[ADIS16550_STATUS_FLASH_UPDATE] = "Flash Update Error",
+	[ADIS16550_STATUS_INERIAL] = "Overrange for Inertial Signals",
+	[ADIS16550_STATUS_SENSOR] = "Sensor failure",
+	[ADIS16550_STATUS_TEMPERATURE] = "Temperature Error",
+	[ADIS16550_STATUS_SPI] = "SPI Communication Error",
+	[ADIS16550_STATUS_PROCESSING] = "Processing Overrun Error",
+	[ADIS16550_STATUS_POWER] = "Power Supply Failure",
+	[ADIS16550_STATUS_BOOT] = "Boot Memory Failure",
+	[ADIS16550_STATUS_WATCHDOG] = "Watchdog timer flag",
+	[ADIS16550_STATUS_REGULATOR] = "Internal Regulator Error",
+	[ADIS16550_STATUS_SENSOR_SUPPLY] = "Internal Sensor Supply Error.",
+	[ADIS16550_STATUS_CPU_SUPPLY] = "Internal Processor Supply Error.",
+	[ADIS16550_STATUS_5V_SUPPLY] = "External 5V Supply Error",
+};
+
+static const struct adis_timeout adis16550_timeouts = {
+	.reset_ms = 1000,
+	.sw_reset_ms = 1000,
+	.self_test_ms = 1000,
+};
+
+static const struct adis_data adis16550_data = {
+	.diag_stat_reg = ADIS16550_REG_STATUS,
+	.diag_stat_size = 4,
+	.prod_id_reg = ADIS16550_REG_PROD_ID,
+	.prod_id = 16550,
+	.self_test_mask = BIT(1),
+	.self_test_reg = ADIS16550_REG_COMMAND,
+	.cs_change_delay = 5,
+	.unmasked_drdy = true,
+	.status_error_msgs = adis16550_status_error_msgs,
+	.status_error_mask = BIT(ADIS16550_STATUS_CRC_CODE) |
+			BIT(ADIS16550_STATUS_CRC_CONFIG) |
+			BIT(ADIS16550_STATUS_FLASH_UPDATE) |
+			BIT(ADIS16550_STATUS_INERIAL) |
+			BIT(ADIS16550_STATUS_SENSOR) |
+			BIT(ADIS16550_STATUS_TEMPERATURE) |
+			BIT(ADIS16550_STATUS_SPI) |
+			BIT(ADIS16550_STATUS_PROCESSING) |
+			BIT(ADIS16550_STATUS_POWER) |
+			BIT(ADIS16550_STATUS_BOOT) |
+			BIT(ADIS16550_STATUS_WATCHDOG) |
+			BIT(ADIS16550_STATUS_REGULATOR) |
+			BIT(ADIS16550_STATUS_SENSOR_SUPPLY) |
+			BIT(ADIS16550_STATUS_CPU_SUPPLY) |
+			BIT(ADIS16550_STATUS_5V_SUPPLY) |
+			BIT(ADIS16550_STATUS_CRC_CODE),
+	.timeouts = &adis16550_timeouts,
+};
+
+static const struct adis_ops adis16550_ops = {
+	.write = adis16550_spi_write,
+	.read = adis16550_spi_read,
+	.reset = adis16550_reset,
+};
+
+static int adis16550_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct adis16550 *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
+
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->available_scan_masks = adis16550_channel_masks;
+	indio_dev->info = &adis16550_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->adis.ops = &adis16550_ops;
+
+	struct spi_transfer *xfer_tmp = kcalloc(2, sizeof(*st->adis.xfer), GFP_KERNEL);
+
+	if (!xfer_tmp)
+		return -ENOMEM;
+
+	void *buffer_tmp = kzalloc(ADIS16550_BURST_DATA_LEN + sizeof(u32),
+				   GFP_KERNEL);
+	if (!buffer_tmp) {
+		kfree(st->adis.xfer);
+		return -ENOMEM;
+	}
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret) {
+		dev_err_probe(dev, ret,
+			      "Failed to get vdd regulator\n");
+		goto free_on_error;
+	}
+
+	ret = adis_init(&st->adis, indio_dev, spi, &adis16550_data);
+	if (ret)
+		goto free_on_error;
+
+	ret = __adis_initial_startup(&st->adis);
+	if (ret)
+		goto free_on_error;
+
+	ret = adis16550_config_sync(st);
+	if (ret)
+		goto free_on_error;
+
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+						 adis16550_trigger_handler);
+	if (ret)
+		goto free_on_error;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		goto free_on_error;
+
+	adis16550_debugfs_init(indio_dev);
+
+	st->adis.xfer = no_free_ptr(xfer_tmp);
+	st->adis.buffer = no_free_ptr(buffer_tmp);
+
+	return 0;
+
+free_on_error:
+	kfree(xfer_tmp);
+	kfree(buffer_tmp);
+
+	return ret;
+}
+
+static const struct spi_device_id adis16550_id[] = {
+	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
+	{ "adis16550w", (kernel_ulong_t)&adis16550w_chip_info},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adis16550_id);
+
+static const struct of_device_id adis16550_of_match[] = {
+	{ .compatible = "adi,adis16550",
+		.data = &adis16550_chip_info },
+	{ .compatible = "adi,adis16550w",
+		.data = &adis16550w_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adis16550_of_match);
+
+static struct spi_driver adis16550_driver = {
+	.driver = {
+		.name = "adis16550",
+		.of_match_table = adis16550_of_match,
+	},
+	.probe = adis16550_probe,
+	.id_table = adis16550_id,
+};
+module_spi_driver(adis16550_driver);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_ADISLIB);
-- 
2.34.1


