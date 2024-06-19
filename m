Return-Path: <linux-iio+bounces-6555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7690E3C8
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B2B287506
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074E73455;
	Wed, 19 Jun 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mRep46lk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AC71B45;
	Wed, 19 Jun 2024 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779813; cv=none; b=Re1/f3oTHwgoeO5KI/6f9yWcoSaSGJqY1FNwxTUTnCnZkrP/27siCU6MFHTwy0WH9+KTqIzjzfkf7cZkeI7tP4fj/pC6iyX2SAp7sW3l8KJe9A6enEEwq1XlbA9wsvkjpSKvssV1o/3eqrY0mcwreBmGLp0EI5Jo4ilhU4nQ69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779813; c=relaxed/simple;
	bh=sOinQ2LIdfxozNRS9YXUni4GLk5guzpmbApMeojUfgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkOwPLWmd765/lwzTFZYnQGAzleXF8/O5huqbZGBjmPktRZy1x/amiThCnfbnyj5LRBQCcR1njP2Pq6LMuacZu0MkSo5ueeQ9clhron16vwm7sq7fBISpHdB278GVZa/aoMLGeZ4nQJ8tKitdyviMtw7bJfs/U7rAUChPTyMbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mRep46lk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J6eDc9001226;
	Wed, 19 Jun 2024 02:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q6gvl
	TONnCZm/kPIGI2IOmOBRh9j3geXAlVq7jpK73w=; b=mRep46lkFrve1vczAouQ5
	0qasOwbfX+LOqtZqHdwALbdUbkIM8O8aOJoQ/EBMaxFty8LgL/DhdJLs1EvlSHUR
	d/X36gflECLFMGkPN1D22cKmTSd0agCEcV9tolWPN6+tXgnIyodWYWbprzQTIBT8
	398Z1i4z1jxf/wwilEC8ES2+34epQENNkTZSQUlptuS4hncw8g9lL2tCay6QeK2C
	x8G/wfhseatQZNUfRZ5oyt8RPXFg8fjPCWzSNZJgJXFwJ12xMJJy97IoVxN4zXEn
	82QxwrmCah0ylwR5m1axtdhNp7TR2qkf7PBYJJNE6TKMUf4vztkE9kOlCkb+o3yy
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yut9280uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 02:49:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45J6nr3a038945
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 02:49:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jun 2024 02:49:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jun 2024 02:49:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jun 2024 02:49:52 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.25])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45J6nEvj011796;
	Wed, 19 Jun 2024 02:49:43 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Michael
 Hennerich" <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v4 5/5] iio: dac: ltc2664: Add driver for LTC2664 and LTC2672
Date: Wed, 19 Jun 2024 14:49:04 +0800
Message-ID: <20240619064904.73832-6-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619064904.73832-1-kimseer.paller@analog.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: G0ajBeVD3Qg-3AryJMGhae9w_Bn9ylEC
X-Proofpoint-ORIG-GUID: G0ajBeVD3Qg-3AryJMGhae9w_Bn9ylEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190049

LTC2664 4 channel, 12-/16-Bit Voltage Output SoftSpan DAC
LTC2672 5 channel, 12-/16-Bit Current Output Softspan DAC

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  11 +
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ltc2664.c | 755 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 768 insertions(+)
 create mode 100644 drivers/iio/dac/ltc2664.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f4a5b5bc8ccc..7a02d9a196fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13082,6 +13082,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
+F:	drivers/iio/dac/ltc2664.c
 
 LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index fb48dddbcc20..3a7691db3998 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -371,6 +371,17 @@ config LTC2632
 	  To compile this driver as a module, choose M here: the
 	  module will be called ltc2632.
 
+config LTC2664
+	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
+	depends on SPI
+	select REGMAP
+	help
+	  Say yes here to build support for Analog Devices
+	  LTC2664 and LTC2672 converters (DAC).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ltc2664.
+
 config M62332
 	tristate "Mitsubishi M62332 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 8432a81a19dc..2cf148f16306 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_DS4424) += ds4424.o
 obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
 obj-$(CONFIG_LTC1660) += ltc1660.o
 obj-$(CONFIG_LTC2632) += ltc2632.o
+obj-$(CONFIG_LTC2664) += ltc2664.o
 obj-$(CONFIG_LTC2688) += ltc2688.o
 obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
new file mode 100644
index 000000000000..9b73b9c6a7a7
--- /dev/null
+++ b/drivers/iio/dac/ltc2664.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LTC2664 4 channel, 12-/16-Bit Voltage Output SoftSpan DAC driver
+ * LTC2672 5 channel, 12-/16-Bit Current Output Softspan DAC driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#define LTC2664_CMD_WRITE_N(n)		(0x00 + (n))
+#define LTC2664_CMD_UPDATE_N(n)		(0x10 + (n))
+#define LTC2664_CMD_WRITE_N_UPDATE_ALL	0x20
+#define LTC2664_CMD_WRITE_N_UPDATE_N(n)	(0x30 + (n))
+#define LTC2664_CMD_POWER_DOWN_N(n)	(0x40 + (n))
+#define LTC2664_CMD_POWER_DOWN_ALL	0x50
+#define LTC2664_CMD_SPAN_N(n)		(0x60 + (n))
+#define LTC2664_CMD_CONFIG		0x70
+#define LTC2664_CMD_MUX			0xB0
+#define LTC2664_CMD_TOGGLE_SEL		0xC0
+#define LTC2664_CMD_GLOBAL_TOGGLE	0xD0
+#define LTC2664_CMD_NO_OPERATION	0xF0
+#define LTC2664_REF_DISABLE		0x0001
+#define LTC2664_MSPAN_SOFTSPAN		7
+
+#define LTC2672_MAX_CHANNEL		5
+#define LTC2672_MAX_SPAN		7
+#define LTC2672_SCALE_MULTIPLIER(n)	(50 * BIT(n))
+
+enum ltc2664_ids {
+	LTC2664,
+	LTC2672,
+};
+
+enum {
+	LTC2664_SPAN_RANGE_0V_5V,
+	LTC2664_SPAN_RANGE_0V_10V,
+	LTC2664_SPAN_RANGE_M5V_5V,
+	LTC2664_SPAN_RANGE_M10V_10V,
+	LTC2664_SPAN_RANGE_M2V5_2V5,
+};
+
+enum {
+	LTC2664_INPUT_A,
+	LTC2664_INPUT_B,
+	LTC2664_INPUT_B_AVAIL,
+	LTC2664_POWERDOWN,
+	LTC2664_POWERDOWN_MODE,
+	LTC2664_TOGGLE_EN,
+	LTC2664_GLOBAL_TOGGLE,
+};
+
+static const u16 ltc2664_mspan_lut[8][2] = {
+	{ LTC2664_SPAN_RANGE_M10V_10V, 32768 }, /* MPS2=0, MPS1=0, MSP0=0 (0)*/
+	{ LTC2664_SPAN_RANGE_M5V_5V, 32768 }, /* MPS2=0, MPS1=0, MSP0=1 (1)*/
+	{ LTC2664_SPAN_RANGE_M2V5_2V5, 32768 }, /* MPS2=0, MPS1=1, MSP0=0 (2)*/
+	{ LTC2664_SPAN_RANGE_0V_10V, 0 }, /* MPS2=0, MPS1=1, MSP0=1 (3)*/
+	{ LTC2664_SPAN_RANGE_0V_10V, 32768 }, /* MPS2=1, MPS1=0, MSP0=0 (4)*/
+	{ LTC2664_SPAN_RANGE_0V_5V, 0 }, /* MPS2=1, MPS1=0, MSP0=1 (5)*/
+	{ LTC2664_SPAN_RANGE_0V_5V, 32768 }, /* MPS2=1, MPS1=1, MSP0=0 (6)*/
+	{ LTC2664_SPAN_RANGE_0V_5V, 0 } /* MPS2=1, MPS1=1, MSP0=1 (7)*/
+};
+
+struct ltc2664_state;
+
+struct ltc2664_chip_info {
+	enum ltc2664_ids id;
+	const char *name;
+	int (*scale_get)(const struct ltc2664_state *st, int c);
+	int (*offset_get)(const struct ltc2664_state *st, int c);
+	int measurement_type;
+	unsigned int num_channels;
+	const struct iio_chan_spec *iio_chan;
+	const int (*span_helper)[2];
+	unsigned int num_span;
+	unsigned int internal_vref_mv;
+	bool manual_span_support;
+	bool rfsadj_support;
+};
+
+struct ltc2664_chan {
+	/* indicates if the channel should be toggled */
+	bool toggle_chan;
+	/* indicates if the channel is in powered down state */
+	bool powerdown;
+	/* span code of the channel */
+	u8 span;
+	/* raw data of the current state of the chip registers (A/B) */
+	u16 raw[2];
+};
+
+struct ltc2664_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct ltc2664_chan channels[LTC2672_MAX_CHANNEL];
+	/* lock to protect against multiple access to the device and shared data */
+	struct mutex lock;
+	const struct ltc2664_chip_info *chip_info;
+	struct iio_chan_spec *iio_channels;
+	int vref_mv;
+	u32 rfsadj_ohms;
+	u32 toggle_sel;
+	bool global_toggle;
+};
+
+static const int ltc2664_span_helper[][2] = {
+	{ 0, 5000 },
+	{ 0, 10000 },
+	{ -5000, 5000 },
+	{ -10000, 10000 },
+	{ -2500, 2500 },
+};
+
+static const int ltc2672_span_helper[][2] = {
+	{ 0, 0 },
+	{ 0, 3125 },
+	{ 0, 6250 },
+	{ 0, 12500 },
+	{ 0, 25000 },
+	{ 0, 50000 },
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 300000 },
+};
+
+static int ltc2664_scale_get(const struct ltc2664_state *st, int c)
+{
+	const struct ltc2664_chan *chan = &st->channels[c];
+	const int (*span_helper)[2] = st->chip_info->span_helper;
+	int span, fs;
+
+	span = chan->span;
+	if (span < 0)
+		return span;
+
+	fs = span_helper[span][1] - span_helper[span][0];
+
+	return fs * st->vref_mv / 2500;
+}
+
+static int ltc2672_scale_get(const struct ltc2664_state *st, int c)
+{
+	const struct ltc2664_chan *chan = &st->channels[c];
+	int span, fs;
+
+	span = chan->span - 1;
+	if (span < 0)
+		return span;
+
+	fs = 1000 * st->vref_mv;
+
+	if (span == LTC2672_MAX_SPAN)
+		return mul_u64_u32_div(4800, fs, st->rfsadj_ohms);
+
+	return mul_u64_u32_div(LTC2672_SCALE_MULTIPLIER(span), fs, st->rfsadj_ohms);
+}
+
+static int ltc2664_offset_get(const struct ltc2664_state *st, int c)
+{
+	const struct ltc2664_chan *chan = &st->channels[c];
+	int span;
+
+	span = chan->span;
+	if (span < 0)
+		return span;
+
+	if (st->chip_info->span_helper[span][0] < 0)
+		return -32768;
+
+	return 0;
+}
+
+static int ltc2664_dac_code_write(struct ltc2664_state *st, u32 chan, u32 input,
+				  u16 code)
+{
+	struct ltc2664_chan *c = &st->channels[chan];
+	int ret, reg;
+
+	guard(mutex)(&st->lock);
+	/* select the correct input register to write to */
+	if (c->toggle_chan) {
+		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
+				   input << chan);
+		if (ret)
+			return ret;
+	}
+	/*
+	 * If in toggle mode the dac should be updated by an
+	 * external signal (or sw toggle) and not here.
+	 */
+	if (st->toggle_sel & BIT(chan))
+		reg = LTC2664_CMD_WRITE_N(chan);
+	else
+		reg = LTC2664_CMD_WRITE_N_UPDATE_N(chan);
+
+	ret = regmap_write(st->regmap, reg, code);
+	if (ret)
+		return ret;
+
+	c->raw[input] = code;
+
+	if (c->toggle_chan) {
+		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
+				   st->toggle_sel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ltc2664_dac_code_read(struct ltc2664_state *st, u32 chan, u32 input,
+				 u32 *code)
+{
+	guard(mutex)(&st->lock);
+	*code = st->channels[chan].raw[input];
+
+	return 0;
+}
+
+static const int ltc2664_raw_range[] = { 0, 1, U16_MAX };
+
+static int ltc2664_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = ltc2664_raw_range;
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc2664_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long info)
+{
+	struct ltc2664_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ltc2664_dac_code_read(st, chan->channel,
+					    LTC2664_INPUT_A, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = st->chip_info->offset_get(st, chan->channel);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->chip_info->scale_get(st, chan->channel);
+
+		*val2 = 16;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc2664_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long info)
+{
+	struct ltc2664_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (val > U16_MAX || val < 0)
+			return -EINVAL;
+
+		return ltc2664_dac_code_write(st, chan->channel,
+					      LTC2664_INPUT_A, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ltc2664_reg_bool_get(struct iio_dev *indio_dev,
+				    uintptr_t private,
+				    const struct iio_chan_spec *chan,
+				    char *buf)
+{
+	struct ltc2664_state *st = iio_priv(indio_dev);
+	u32 val;
+
+	guard(mutex)(&st->lock);
+	switch (private) {
+	case LTC2664_POWERDOWN:
+		val = st->channels[chan->channel].powerdown;
+
+		return sysfs_emit(buf, "%u\n", val);
+	case LTC2664_POWERDOWN_MODE:
+		return sysfs_emit(buf, "42kohm_to_gnd\n");
+	case LTC2664_TOGGLE_EN:
+		val = !!(st->toggle_sel & BIT(chan->channel));
+
+		return sysfs_emit(buf, "%u\n", val);
+	case LTC2664_GLOBAL_TOGGLE:
+		val = st->global_toggle;
+
+		return sysfs_emit(buf, "%u\n", val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ltc2664_reg_bool_set(struct iio_dev *indio_dev,
+				    uintptr_t private,
+				    const struct iio_chan_spec *chan,
+				    const char *buf, size_t len)
+{
+	struct ltc2664_state *st = iio_priv(indio_dev);
+	int ret;
+	bool en;
+
+	ret = kstrtobool(buf, &en);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	switch (private) {
+	case LTC2664_POWERDOWN:
+		ret = regmap_write(st->regmap,
+				   en ? LTC2664_CMD_POWER_DOWN_N(chan->channel) :
+				   LTC2664_CMD_UPDATE_N(chan->channel), en);
+		if (ret)
+			return ret;
+
+		st->channels[chan->channel].powerdown = en;
+
+		return len;
+	case LTC2664_TOGGLE_EN:
+		if (en)
+			st->toggle_sel |= BIT(chan->channel);
+		else
+			st->toggle_sel &= ~BIT(chan->channel);
+
+		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
+				   st->toggle_sel);
+		if (ret)
+			return ret;
+
+		return len;
+	case LTC2664_GLOBAL_TOGGLE:
+		ret = regmap_write(st->regmap, LTC2664_CMD_GLOBAL_TOGGLE, en);
+		if (ret)
+			return ret;
+
+		st->global_toggle = en;
+
+		return len;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ltc2664_dac_input_read(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      char *buf)
+{
+	struct ltc2664_state *st = iio_priv(indio_dev);
+	int ret;
+	u32 val;
+
+	if (private == LTC2664_INPUT_B_AVAIL)
+		return sysfs_emit(buf, "[%u %u %u]\n", ltc2664_raw_range[0],
+				  ltc2664_raw_range[1],
+				  ltc2664_raw_range[2] / 4);
+
+	ret = ltc2664_dac_code_read(st, chan->channel, private, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t ltc2664_dac_input_write(struct iio_dev *indio_dev,
+				       uintptr_t private,
+				       const struct iio_chan_spec *chan,
+				       const char *buf, size_t len)
+{
+	struct ltc2664_state *st = iio_priv(indio_dev);
+	int ret;
+	u16 val;
+
+	if (private == LTC2664_INPUT_B_AVAIL)
+		return -EINVAL;
+
+	ret = kstrtou16(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = ltc2664_dac_code_write(st, chan->channel, private, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int ltc2664_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct ltc2664_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return -EOPNOTSUPP;
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+#define LTC2664_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\
+	.name = _name,							\
+	.read = (_read),						\
+	.write = (_write),						\
+	.private = (_what),						\
+	.shared = (_shared),						\
+}
+
+/*
+ * For toggle mode we only expose the symbol attr (sw_toggle) in case a TGPx is
+ * not provided in dts.
+ */
+static const struct iio_chan_spec_ext_info ltc2664_toggle_sym_ext_info[] = {
+	LTC2664_CHAN_EXT_INFO("raw0", LTC2664_INPUT_A, IIO_SEPARATE,
+			      ltc2664_dac_input_read, ltc2664_dac_input_write),
+	LTC2664_CHAN_EXT_INFO("raw1", LTC2664_INPUT_B, IIO_SEPARATE,
+			      ltc2664_dac_input_read, ltc2664_dac_input_write),
+	LTC2664_CHAN_EXT_INFO("powerdown", LTC2664_POWERDOWN, IIO_SEPARATE,
+			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
+	LTC2664_CHAN_EXT_INFO("powerdown_mode", LTC2664_POWERDOWN_MODE,
+			      IIO_SEPARATE, ltc2664_reg_bool_get, NULL),
+	LTC2664_CHAN_EXT_INFO("symbol", LTC2664_GLOBAL_TOGGLE, IIO_SEPARATE,
+			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
+	LTC2664_CHAN_EXT_INFO("toggle_en", LTC2664_TOGGLE_EN,
+			      IIO_SEPARATE, ltc2664_reg_bool_get,
+			      ltc2664_reg_bool_set),
+	{ }
+};
+
+static const struct iio_chan_spec_ext_info ltc2664_ext_info[] = {
+	LTC2664_CHAN_EXT_INFO("powerdown", LTC2664_POWERDOWN, IIO_SEPARATE,
+			      ltc2664_reg_bool_get, ltc2664_reg_bool_set),
+	LTC2664_CHAN_EXT_INFO("powerdown_mode", LTC2664_POWERDOWN_MODE,
+			      IIO_SEPARATE, ltc2664_reg_bool_get, NULL),
+	{ }
+};
+
+static const struct iio_chan_spec ltc2664_channel_template = {
+	.indexed = 1,
+	.output = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+	.ext_info = ltc2664_ext_info,
+};
+
+static const struct ltc2664_chip_info ltc2664_chip = {
+	.name = "ltc2664",
+	.scale_get = ltc2664_scale_get,
+	.offset_get = ltc2664_offset_get,
+	.measurement_type = IIO_VOLTAGE,
+	.num_channels = 4,
+	.span_helper = ltc2664_span_helper,
+	.num_span = ARRAY_SIZE(ltc2664_span_helper),
+	.internal_vref_mv = 2500,
+	.manual_span_support = true,
+	.rfsadj_support = false,
+};
+
+static const struct ltc2664_chip_info ltc2672_chip = {
+	.name = "ltc2672",
+	.scale_get = ltc2672_scale_get,
+	.offset_get = ltc2664_offset_get,
+	.measurement_type = IIO_CURRENT,
+	.num_channels = 5,
+	.span_helper = ltc2672_span_helper,
+	.num_span = ARRAY_SIZE(ltc2672_span_helper),
+	.internal_vref_mv = 1250,
+	.manual_span_support = false,
+	.rfsadj_support = true,
+};
+
+static int ltc2664_set_span(const struct ltc2664_state *st, int min, int max,
+			    int chan)
+{
+	const struct ltc2664_chip_info *chip_info = st->chip_info;
+	const int (*span_helper)[2] = chip_info->span_helper;
+	int span, ret;
+
+	for (span = 0; span < chip_info->num_span; span++) {
+		if (min == span_helper[span][0] && max == span_helper[span][1])
+			break;
+	}
+
+	if (span == chip_info->num_span)
+		return -EINVAL;
+
+	ret = regmap_write(st->regmap, LTC2664_CMD_SPAN_N(chan), span);
+	if (ret)
+		return ret;
+
+	return span;
+}
+
+static int ltc2664_channel_config(struct ltc2664_state *st)
+{
+	const struct ltc2664_chip_info *chip_info = st->chip_info;
+	struct device *dev = &st->spi->dev;
+	u32 reg, tmp[2], mspan;
+	int ret, span = 0;
+
+	mspan = LTC2664_MSPAN_SOFTSPAN;
+	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
+				       &mspan);
+	if (!ret) {
+		if (!chip_info->manual_span_support)
+			return dev_err_probe(dev, -EINVAL,
+			       "adi,manual-span-operation-config not supported\n");
+
+		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
+			return dev_err_probe(dev, -EINVAL,
+			       "adi,manual-span-operation-config not in range\n");
+	}
+
+	st->rfsadj_ohms = 20000;
+	ret = device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsadj_ohms);
+	if (!ret) {
+		if (!chip_info->rfsadj_support)
+			return dev_err_probe(dev, -EINVAL,
+					     "adi,rfsadj-ohms not supported\n");
+
+		if (st->rfsadj_ohms < 19000 || st->rfsadj_ohms > 41000)
+			return dev_err_probe(dev, -EINVAL,
+					     "adi,rfsadj-ohms not in range\n");
+	}
+
+	device_for_each_child_node_scoped(dev, child) {
+		struct ltc2664_chan *chan;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to get reg property\n");
+
+		if (reg >= chip_info->num_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "reg bigger than: %d\n",
+					     chip_info->num_channels);
+
+		chan = &st->channels[reg];
+
+		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
+			chan->toggle_chan = true;
+			/* assume sw toggle ABI */
+			st->iio_channels[reg].ext_info = ltc2664_toggle_sym_ext_info;
+
+			/*
+			 * Clear IIO_CHAN_INFO_RAW bit as toggle channels expose
+			 * out_voltage/current_raw{0|1} files.
+			 */
+			__clear_bit(IIO_CHAN_INFO_RAW,
+				    &st->iio_channels[reg].info_mask_separate);
+		}
+
+		chan->raw[0] = ltc2664_mspan_lut[mspan][1];
+		chan->raw[1] = ltc2664_mspan_lut[mspan][1];
+
+		chan->span = ltc2664_mspan_lut[mspan][0];
+
+		ret = fwnode_property_read_u32_array(child, "adi,output-range-microvolt",
+						     tmp, ARRAY_SIZE(tmp));
+		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
+			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
+						      tmp[1] / 1000, reg);
+			if (span < 0)
+				return dev_err_probe(dev, span,
+						     "Failed to set span\n");
+
+		}
+
+		ret = fwnode_property_read_u32(child,
+					       "adi,output-range-microamp",
+					       &tmp[0]);
+		if (!ret) {
+			chan->span = ltc2664_set_span(st, 0, tmp[0] / 1000, reg);
+			if (span < 0)
+				return dev_err_probe(dev, span,
+						     "Failed to set span\n");
+		}
+	}
+
+	return 0;
+}
+
+static int ltc2664_setup(struct ltc2664_state *st)
+{
+	const struct ltc2664_chip_info *chip_info = st->chip_info;
+	struct gpio_desc *gpio;
+	int ret, i;
+
+	/* If we have a clr/reset pin, use that to reset the chip. */
+	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
+				     "Failed to get reset gpio");
+	if (gpio) {
+		fsleep(1000);
+		gpiod_set_value_cansleep(gpio, 0);
+	}
+
+	/*
+	 * Duplicate the default channel configuration as it can change during
+	 * @ltc2664_channel_config()
+	 */
+	st->iio_channels = devm_kcalloc(&st->spi->dev,
+					chip_info->num_channels,
+					sizeof(struct iio_chan_spec),
+					GFP_KERNEL);
+	if (!st->iio_channels)
+		return -ENOMEM;
+
+	for (i = 0; i < chip_info->num_channels; i++) {
+		st->iio_channels[i] = ltc2664_channel_template;
+		st->iio_channels[i].type = chip_info->measurement_type;
+		st->iio_channels[i].channel = i;
+	}
+
+	ret = ltc2664_channel_config(st);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(st->regmap, LTC2664_CMD_CONFIG, LTC2664_REF_DISABLE);
+}
+
+static const struct regmap_config ltc2664_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = LTC2664_CMD_NO_OPERATION,
+};
+
+static const struct iio_info ltc2664_info = {
+	.write_raw = ltc2664_write_raw,
+	.read_raw = ltc2664_read_raw,
+	.read_avail = ltc2664_read_avail,
+	.debugfs_reg_access = ltc2664_reg_access,
+};
+
+static int ltc2664_probe(struct spi_device *spi)
+{
+	static const char * const regulators[] = { "vcc", "iovcc", "v-neg" };
+	const struct ltc2664_chip_info *chip_info;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ltc2664_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODEV;
+
+	st->chip_info = chip_info;
+
+	mutex_init(&st->lock);
+
+	st->regmap = devm_regmap_init_spi(spi, &ltc2664_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to init regmap");
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get vref voltage\n");
+	else if (ret == -ENODEV)
+		st->vref_mv = chip_info->internal_vref_mv;
+	else
+		st->vref_mv = ret / 1000;
+
+	ret = ltc2664_setup(st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = chip_info->name;
+	indio_dev->info = &ltc2664_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->iio_channels;
+	indio_dev->num_channels = chip_info->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ltc2664_id[] = {
+	{ "ltc2664", (kernel_ulong_t)&ltc2664_chip },
+	{ "ltc2672", (kernel_ulong_t)&ltc2672_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ltc2664_id);
+
+static const struct of_device_id ltc2664_of_id[] = {
+	{ .compatible = "adi,ltc2664", .data = &ltc2664_chip },
+	{ .compatible = "adi,ltc2672", .data = &ltc2672_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2664_of_id);
+
+static struct spi_driver ltc2664_driver = {
+	.driver = {
+		.name = "ltc2664",
+		.of_match_table = ltc2664_of_id,
+	},
+	.probe = ltc2664_probe,
+	.id_table = ltc2664_id,
+};
+module_spi_driver(ltc2664_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2664 and LTC2672 DAC");
+MODULE_LICENSE("GPL");
-- 
2.34.1


