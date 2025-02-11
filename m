Return-Path: <linux-iio+bounces-15370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2721A3164A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 21:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C775B1889A53
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BE4261586;
	Tue, 11 Feb 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZJiiF5Jj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D826563E;
	Tue, 11 Feb 2025 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303955; cv=none; b=g4ocDkku3M4UYs5zRTflpniZlXc6EL3e0RHdZobjuzW/0JefsAGDnvWiH7QO+o/y+f0gy1TbGKOPg2nmSPKySBJqDyQHmYcxAGFpSkAhHoHhwZ6/LiSXCiehMuTLUYWY0L6eJVkXdeyMi7YXaD9YdGvgzxQm0GBntUboYsIM64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303955; c=relaxed/simple;
	bh=hYVzBQv5ALW1hXi99Cm9LSEWCTQ9wNaFIWUkqldHoy0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVbrE2PWygFmlGWaeuENoCc08EqfbQh/7LivAYQVi8og2VD2+277h7O/LP/A7S4PXI+jTfkEOUmM+w7q8NV2AA/wBJEKYDw5S8YKREoLLVoPPuLkbBSIPbnyK8Ne8KnnFqhx4KFuWLzJM47l/Ygeg3zsdlkgraJTmuzGTP1VBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZJiiF5Jj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BFZPqA012589;
	Tue, 11 Feb 2025 14:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pYe+b
	iI8O0jh83U497MfUQDNmKHCsXpb1xmsU/cBW48=; b=ZJiiF5JjXHDLcwaoPUDsN
	xA87Vmw1UDkeBi0b3LSYZvgDqv/BVYmr+aJi8/Oc+kDcM+dqpfHbokpVEACT1K8C
	hTnTDayiK0y1mLtjzQyF1kYib2s0K+QG+ndj8TlMKfZ6bYzRiMF7XqsZiqd4mGg2
	3Fj01pqIBUb3bW5lE2VD2nTI7kdrAk876+a+tSORaNP6ctr2ZptheJRFCX2HGet1
	hv3FkwPqSN69XwHLFsBXo0JyqGzjz9yHV1Fhxnw6KrNPhRJOXfxuhBCOtJQ1U1Yp
	LHpOeHE/RDHMKb1z1cylZTLNhIEZ8h+bbfZMQ9oVbPeUFimIDUPmQKlothN43x7c
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p529xf87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 14:58:56 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BJwtwb065169
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 14:58:55 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 14:58:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 14:58:55 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BJwFRE031076;
	Tue, 11 Feb 2025 14:58:49 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 5/6] iio: imu: adis16550: add adis16550 support
Date: Tue, 11 Feb 2025 19:57:02 +0200
Message-ID: <20250211175706.276987-6-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211175706.276987-1-robert.budai@analog.com>
References: <20250211175706.276987-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 96-TrnM65MVHORQjJVUsJ8-PHohwRTDO
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67abac01 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=_-Ay4P9v7Kik70hs8QcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: 96-TrnM65MVHORQjJVUsJ8-PHohwRTDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110129

The ADIS16550 is a complete inertial system that includes a triaxis
gyroscope and a triaxis accelerometer. Each inertial sensor in the
ADIS16550 combines industry leading MEMS only technology with signal
conditioning that optimizes dynamic performance. The factory calibration
characterizes each sensor for sensitivity, bias, and alignment. As a
result, each sensor has its own dynamic compensation formulas that
provide accurate sensor measurements.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v7:
- minor changes according to PR suggestions

 drivers/iio/imu/Kconfig     |   13 +
 drivers/iio/imu/Makefile    |    1 +
 drivers/iio/imu/adis16550.c | 1151 +++++++++++++++++++++++++++++++++++
 3 files changed, 1165 insertions(+)
 create mode 100644 drivers/iio/imu/adis16550.c

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index ca0efecb5..15612f0f1 100644
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
+	  sensor containing triaxis gyroscope and triaxis accelerometer.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called adis16550.
+
 source "drivers/iio/imu/bmi160/Kconfig"
 source "drivers/iio/imu/bmi270/Kconfig"
 source "drivers/iio/imu/bmi323/Kconfig"
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 04c77c2c4..e901aea49 100644
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
index 000000000..b4a88e31c
--- /dev/null
+++ b/drivers/iio/imu/adis16550.c
@@ -0,0 +1,1151 @@
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
+#define ADIS16550_BURST_DATA_GYRO_ACCEL_MASK	GENMASK(6, 1)
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
+	(ADIS16550_SYNC_EN_MASK | ADIS16550_SYNC_MODE_MASK)
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
+/* SPI protocol*/
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
+	struct spi_transfer xfer[2];
+	u8 buffer[ADIS16550_BURST_DATA_LEN + sizeof(u32)] __aligned(IIO_DMA_MINALIGN);
+	__be32 din[2] __aligned(IIO_DMA_MINALIGN);
+	__be32 dout[2];
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
+		__din |= FIELD_PREP(ADIS16550_SPI_R_W_MASK, 1);
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
+	bool wr = readval ? false : true;
+	struct spi_device *spi = adis->spi;
+	struct adis16550 *st = container_of(adis, struct adis16550, adis);
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &st->din[0],
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->din[1],
+			.len = 4,
+			.cs_change = 1,
+			.rx_buf = st->dout,
+		}, {
+			.tx_buf = &st->din[1],
+			.rx_buf = &st->dout[1],
+			.len = 4,
+		},
+	};
+
+	spi_message_init(&msg);
+
+	switch (len) {
+	case 4:
+		adis16550_spi_msg_prepare(reg + 1, wr, writeval >> 16,
+					  &st->din[0]);
+		spi_message_add_tail(&xfers[0], &msg);
+		fallthrough;
+	case 2:
+		adis16550_spi_msg_prepare(reg, wr, writeval, &st->din[1]);
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
+		ret = adis16550_spi_validate(adis, st->dout[0], &data);
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
+		ret = adis16550_spi_validate(adis, st->dout[1], &data);
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
+	char buf[12];
+	size_t len;
+	u32 date;
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
+	debugfs_create_file_unsafe("serial_number", 0400, d, st,
+				   &adis16550_serial_number_fops);
+	debugfs_create_file_unsafe("product_id", 0400, d, st,
+				   &adis16550_product_id_fops);
+	debugfs_create_file("firmware_revision", 0400, d, st,
+			    &adis16550_firmware_revision_fops);
+	debugfs_create_file("firmware_date", 0400, d, st,
+			    &adis16550_firmware_date_fops);
+	debugfs_create_file_unsafe("flash_count", 0400, d, st,
+				   &adis16550_flash_count_fops);
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
+	u8 en = freq_hz ? 1 : 0;
+
+	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
+				  ADIS16550_ACCL_FIR_EN_MASK,
+				  FIELD_PREP(ADIS16550_ACCL_FIR_EN_MASK, en));
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
+	u8 en = freq_hz ? 1 : 0;
+
+	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
+				  ADIS16550_GYRO_FIR_EN_MASK,
+				  FIELD_PREP(ADIS16550_GYRO_FIR_EN_MASK, en));
+}
+
+enum {
+	ADIS16550_SCAN_TEMP,
+	ADIS16550_SCAN_GYRO_X,
+	ADIS16550_SCAN_GYRO_Y,
+	ADIS16550_SCAN_GYRO_Z,
+	ADIS16550_SCAN_ACCEL_X,
+	ADIS16550_SCAN_ACCEL_Y,
+	ADIS16550_SCAN_ACCEL_Z,
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
+	ADIS16550_TEMP_CHANNEL(),
+	ADIS16550_GYRO_CHANNEL(X),
+	ADIS16550_GYRO_CHANNEL(Y),
+	ADIS16550_GYRO_CHANNEL(Z),
+	ADIS16550_ACCEL_CHANNEL(X),
+	ADIS16550_ACCEL_CHANNEL(Y),
+	ADIS16550_ACCEL_CHANNEL(Z),
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
+	int ret;
+	u16 dummy;
+	bool valid;
+	struct iio_poll_func *pf = p;
+	__be32 data[ADIS16550_MAX_SCAN_DATA];
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16550 *st = iio_priv(indio_dev);
+	struct adis *adis = iio_device_get_drvdata(indio_dev);
+	__be32 *buffer = (__be32 *)st->buffer;
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
+	/* copy the temperature together with sensor data */
+	memcpy(data, &buffer[3],
+	       (ADIS16550_SCAN_ACCEL_Z - ADIS16550_SCAN_GYRO_X + 2) * 
+	       sizeof(__be32));
+	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const unsigned long adis16550_channel_masks[] = {
+	ADIS16550_BURST_DATA_GYRO_ACCEL_MASK | BIT(ADIS16550_SCAN_TEMP),
+	ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK | BIT(ADIS16550_SCAN_TEMP),
+	0,
+};
+
+static int adis16550_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	u16 burst_length = ADIS16550_BURST_DATA_LEN;
+	struct adis16550 *st = iio_priv(indio_dev);
+	u8 burst_cmd;
+	u8 *tx;
+
+	memset(st->buffer, 0, burst_length + sizeof(u32));
+
+	if (*scan_mask & ADIS16550_BURST_DATA_GYRO_ACCEL_MASK)
+		burst_cmd = ADIS16550_REG_BURST_GYRO_ACCEL;
+	else
+		burst_cmd = ADIS16550_REG_BURST_DELTA_ANG_VEL;
+
+	tx = st->buffer + burst_length;
+	tx[0] = 0x00;
+	tx[1] = 0x00;
+	tx[2] = burst_cmd;
+	/* crc4 is 0 on burst command */
+	tx[3] = spi_crc4(get_unaligned_le32(tx));
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
+	const struct adis16550_sync *sync_mode_data;
+	struct clk *clk;
+	int ret, i;
+	u16 mode;
+
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	if (!clk) {
+		st->clk_freq_hz = st->info->int_clk * 1000;
+		return 0;
+	}
+
+	st->clk_freq_hz = clk_get_rate(clk);
+
+	for (i = 0; i < st->info->num_sync; i++) {
+		if (st->clk_freq_hz >= st->info->sync_mode[i].min_rate &&
+		    st->clk_freq_hz <= st->info->sync_mode[i].max_rate) {
+			sync_mode_data = &st->info->sync_mode[i];
+			break;
+		}
+	}
+
+	if (i == st->info->num_sync)
+		return dev_err_probe(dev, -EINVAL, "Clk rate: %lu not in a valid range",
+				     st->clk_freq_hz);
+
+	if (sync_mode_data->sync_mode == ADIS16550_SYNC_MODE_SCALED) {
+		u16 sync_scale;
+		/*
+		 * In sps scaled sync we must scale the input clock to a range
+		 * of [3000 4500].
+		 */
+
+		sync_scale = DIV_ROUND_CLOSEST(st->info->int_clk, st->clk_freq_hz);
+
+		if (3000 > sync_scale || 4500 < sync_scale)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value:%u for sync_scale",
+					     sync_scale);
+
+		ret = adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
+					sync_scale);
+		if (ret)
+			return ret;
+
+		st->clk_freq_hz = st->info->int_clk;
+	}
+
+	st->clk_freq_hz *= 1000;
+
+	mode = FIELD_PREP(ADIS16550_SYNC_MODE_MASK, sync_mode_data->sync_mode) |
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
+	u16 burst_length = ADIS16550_BURST_DATA_LEN;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct adis16550 *st;
+	struct adis *adis;
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
+	adis = &st->adis;
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->available_scan_masks = adis16550_channel_masks;
+	indio_dev->info = &adis16550_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->adis.ops = &adis16550_ops;
+	st->xfer[0].tx_buf = st->buffer + burst_length;
+	st->xfer[0].len = 4;
+	st->xfer[0].cs_change = 1;
+	st->xfer[0].delay.value = 8;
+	st->xfer[0].delay.unit = SPI_DELAY_UNIT_USECS;
+	st->xfer[1].rx_buf = st->buffer;
+	st->xfer[1].len = burst_length;
+
+	spi_message_init_with_transfers(&adis->msg, st->xfer, 2);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get vdd regulator\n");
+
+	ret = adis_init(&st->adis, indio_dev, spi, &adis16550_data);
+	if (ret)
+		return ret;
+
+	ret = __adis_initial_startup(&st->adis);
+	if (ret)
+		return ret;
+
+	ret = adis16550_config_sync(st);
+	if (ret)
+		return ret;
+
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+						 adis16550_trigger_handler);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	adis16550_debugfs_init(indio_dev);
+
+	return 0;
+}
+
+static const struct spi_device_id adis16550_id[] = {
+	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adis16550_id);
+
+static const struct of_device_id adis16550_of_match[] = {
+	{ .compatible = "adi,adis16550", .data = &adis16550_chip_info },
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
+MODULE_AUTHOR("Robert Budai <robert.budai@analog.com>")
+MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
+MODULE_IMPORT_NS("IIO_ADISLIB");
+MODULE_LICENSE("GPL");
-- 
2.34.1


