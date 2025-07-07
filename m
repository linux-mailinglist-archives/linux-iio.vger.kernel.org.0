Return-Path: <linux-iio+bounces-21426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF04EAFB54B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388E63B65A7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712A2BDC0A;
	Mon,  7 Jul 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zc7YCcM8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88017291C23;
	Mon,  7 Jul 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896403; cv=none; b=flyJkyr9J/qmUPwoyADBoIZhdDxMXZXpx14E6uwmF8Rq2bzP1vj2G//8LBy9gbMV+0vxW+MaSy0sPesKgxL5TXLybr66qGfQDS1JNDaBP6HjLOSFxnniABNE3X/fEmKqszCeUa1HfGaG6wAZwhKQtqJdL6Fy7Mwzc4E0U8qJgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896403; c=relaxed/simple;
	bh=mEP+KUaN1YaBpT1zrR/HBNy2iHSei94wv2mXtL1DuIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZ3B9wgJQq+59LNDuiG7f91gfCiXYgepCYKlgMLAUPCeAA3mBg8aFqk6WZtxsEVp1Apc2Q19+2xs0pwiNj88p7Gf1Pi/n5E5YSJnwX6Cn0X8IJ0Xa8iay8FKq5yO/wmSyjn+jtpW021uEPRLbuiDyqHV1Vnq02SWi+Klfhi39f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zc7YCcM8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567DBY4i026983;
	Mon, 7 Jul 2025 09:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sfdAO
	n4Cvg4A2Mb5JeqCJ2L9WFZAHniZNt6psRsfCxg=; b=Zc7YCcM8OtuqJ3ZPm0jdJ
	cxaXdWBN0TmNwGQnFUio+yCIcNRepyEiLCztfaY8SxaUE6sKuynwLE9oFftbZYNR
	J9/fKMf1ZIDdJQBL5sJZdGAljGDAZi9PFHgkzDE/mb9oQv6yVA+SOhScUHERk5a0
	fflzGNq20/1s/7LVvD9MG5FOiwZDJREwIVHrGT9xl/Rc+vrlmlhi3VaKWRlsXxe6
	hY/WhrwJusUsRUc2FzqiafvPm8kNve/T+tobsCMligjDCiDxGPnbva1+AkJPYVkd
	VDRrCFIIfH2T8JvKf1kkeOKmbH/Ln1d5HmTp1v5oTQ74tKyNQkI3Zarj9A1OcLWt
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47rayqh6t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:53:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 567Dr3xh011684
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:53:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 09:53:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:53:03 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567Dqk0f016171;
	Mon, 7 Jul 2025 09:52:49 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 07/12] iio: adc: ad4170-4: Add support for buffered data capture
Date: Mon, 7 Jul 2025 10:52:46 -0300
Message-ID: <10ed544d31aa86eb40f93ea947f151d3d9827952.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AP9nYgXq c=1 sm=1 tr=0 ts=686bd140 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=TEtCmmvL8P_ouh62KQIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MSBTYWx0ZWRfX5fNGT/kOmyrs
 +F9OtNmdj0tysl33FTnrXFXBmsEDYrbpIrnGOu55xY4rcG7jt687cE3gGxxzuzrZIrl0ouhrCm6
 6xU9sAVoTDMq/3IyMpZ2jSmLU56MiDvsMi2vONa7qnb7ZmXKupp79MNfEUz3V9K1XG8b1qsZmMf
 y0BNv4pwzI8KlUMHkMYXL/ae0iIDFEz0Ks5ON96sdMXB5dn2tza3Bxx5vOuHX5dc18Psyxbe9c2
 i93uOIO0H7Zq6ZyVIHrflpEEaeAkvqUR9e7/yl9d9mXAbJTWfeGHoOzYvZPqziMXVvn0AnhQ6ow
 PA461UcVeWfKDxnuw8tYDXChkgJcLdr6QoBBGEn5qKmIi15JDXmnW+L3OwsGpdKSMhoSeD4Cv/7
 WS/LvhJJBSqvNt9EBqDyZOFa7YF7zTAJPpGbD1PPonvej1oiLYaf03NsWWz2qU15lwTNF6Lr
X-Proofpoint-ORIG-GUID: pOlOtdTSFEgyikdhrIRwdXCg-QOgdvhs
X-Proofpoint-GUID: pOlOtdTSFEgyikdhrIRwdXCg-QOgdvhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070081

Extend the AD4170-4 driver to allow buffered data capture in continuous
read mode. In continuous read mode, the chip skips the instruction phase
and outputs just ADC sample data, enabling faster sample rates to be
reached. The internal channel sequencer always starts sampling from channel
0 and channel 0 must be enabled if more than one channel is selected for
data capture. The scan mask validation callback checks if the
aforementioned condition is met.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v7.

 drivers/iio/adc/Kconfig    |   2 +
 drivers/iio/adc/ad4170-4.c | 216 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 79fcb9dc680b..538929b3df6e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -89,6 +89,8 @@ config AD4170_4
 	tristate "Analog Device AD4170-4 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4170-4 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 6ad4637f9829..738f37394402 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -16,7 +16,11 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/math64.h>
@@ -61,6 +65,7 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
 
@@ -72,6 +77,7 @@
 
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
+#define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
 #define AD4170_ADC_CTRL_MODE_MSK			GENMASK(3, 0)
 
 /* AD4170_CHAN_EN_REG */
@@ -116,9 +122,13 @@
 #define AD4170_PIN_MUXING_DIG_AUX1_RDY			0x1
 
 /* AD4170_ADC_CTRL_REG constants */
+#define AD4170_ADC_CTRL_MODE_CONT			0x0
 #define AD4170_ADC_CTRL_MODE_SINGLE			0x4
 #define AD4170_ADC_CTRL_MODE_IDLE			0x7
 
+#define AD4170_ADC_CTRL_CONT_READ_DISABLE		0x0
+#define AD4170_ADC_CTRL_CONT_READ_ENABLE		0x1
+
 /* AD4170_FILTER_REG constants */
 #define AD4170_FILTER_FILTER_TYPE_SINC5_AVG		0x0
 #define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
@@ -150,6 +160,8 @@
 
 #define AD4170_GAIN_REG_DEFAULT				0x555555
 
+#define AD4170_ADC_CTRL_CONT_READ_EXIT			0xA5
+
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
@@ -186,6 +198,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
 enum ad4170_ref_buf {
@@ -325,6 +338,10 @@ struct ad4170_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
+	__be32 bounce_buffer[AD4170_MAX_ADC_CHANNELS];
+	struct spi_message msg;
+	struct spi_transfer xfer;
+	struct iio_trigger *trig;
 	unsigned int pins_fn[AD4170_NUM_ANALOG_PINS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -410,6 +427,10 @@ static int ad4170_reg_write(void *context, unsigned int reg, unsigned int val)
 	case 1:
 		tx_buf[AD4170_SPI_INST_PHASE_LEN] = val;
 		break;
+	case 0:
+		/* Write continuous read exit code */
+		tx_buf[0] = AD4170_ADC_CTRL_CONT_READ_EXIT;
+		return spi_write_then_read(st->spi, tx_buf, 1, NULL, 0);
 	default:
 		return -EINVAL;
 	}
@@ -803,6 +824,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
+		.shift = 8,
 		.endianness = IIO_BE,
 	},
 };
@@ -1392,11 +1414,27 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad4170_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *active_scan_mask)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned int chan_index;
+	int ret;
+
+	iio_for_each_active_channel(indio_dev, chan_index) {
+		ret = ad4170_set_channel_enable(st, chan_index, true);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static const struct iio_info ad4170_info = {
 	.read_raw = ad4170_read_raw,
 	.read_avail = ad4170_read_avail,
 	.write_raw = ad4170_write_raw,
 	.write_raw_get_fmt = ad4170_write_raw_get_fmt,
+	.update_scan_mode = ad4170_update_scan_mode,
 	.debugfs_reg_access = ad4170_debugfs_reg_access,
 };
 
@@ -1700,16 +1738,178 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
 				 AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK);
 }
 
+static int ad4170_prepare_spi_message(struct ad4170_state *st)
+{
+	/*
+	 * Continuous data register read is enabled on buffer postenable so
+	 * no instruction phase is needed meaning we don't need to send the
+	 * register address to read data. Transfer only needs the read buffer.
+	 */
+	st->xfer.rx_buf = &st->rx_buf;
+	st->xfer.len = BITS_TO_BYTES(ad4170_channel_template.scan_type.realbits);
+
+	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
+
+	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->msg);
+}
+
+static int ad4170_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_MODE_MSK,
+				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
+					    AD4170_ADC_CTRL_MODE_CONT));
+	if (ret)
+		return ret;
+
+	/*
+	 * This enables continuous read of the ADC data register. The ADC must
+	 * be in continuous conversion mode.
+	 */
+	return regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				  AD4170_ADC_CTRL_CONT_READ_MSK,
+				  FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
+					     AD4170_ADC_CTRL_CONT_READ_ENABLE));
+}
+
+static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned int i;
+	int ret;
+
+	/*
+	 * Use a high register address (virtual register) to request a write of
+	 * 0xA5 to the ADC during the first 8 SCLKs of the ADC data read cycle,
+	 * thus exiting continuous read.
+	 */
+	ret = regmap_write(st->regmap, AD4170_ADC_CTRL_CONT_READ_EXIT_REG, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_CONT_READ_MSK,
+				 FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
+					    AD4170_ADC_CTRL_CONT_READ_DISABLE));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_MODE_MSK,
+				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
+					    AD4170_ADC_CTRL_MODE_IDLE));
+	if (ret)
+		return ret;
+
+	/*
+	 * The ADC sequences through all the enabled channels (see datasheet
+	 * page 95). That can lead to incorrect channel being read if a
+	 * single-shot read (or buffered read with different active_scan_mask)
+	 * is done after buffer disable. Disable all channels so only requested
+	 * channels will be read.
+	 */
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = ad4170_set_channel_enable(st, i, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static bool ad4170_validate_scan_mask(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	unsigned int masklength = iio_get_masklength(indio_dev);
+	unsigned int enabled;
+
+	/*
+	 * The channel sequencer cycles through the enabled channels in
+	 * sequential order, from channel 0 to channel 15, bypassing disabled
+	 * channels. When more than one channel is enabled, channel 0 must
+	 * always be enabled. See datasheet channel_en register description at
+	 * page 95.
+	 */
+	enabled = bitmap_weight(scan_mask, masklength);
+	if (enabled > 1)
+		return test_bit(0, scan_mask);
+
+	return enabled == 1;
+}
+
+static const struct iio_buffer_setup_ops ad4170_buffer_ops = {
+	.postenable = ad4170_buffer_postenable,
+	.predisable = ad4170_buffer_predisable,
+	.validate_scan_mask = ad4170_validate_scan_mask,
+};
+
+static irqreturn_t ad4170_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned int chan_index;
+	unsigned int i = 0;
+	int ret;
+
+	iio_for_each_active_channel(indio_dev, chan_index) {
+		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			goto err_out;
+
+		memcpy(&st->bounce_buffer[i++], st->rx_buf, ARRAY_SIZE(st->rx_buf));
+	}
+
+	iio_push_to_buffers(indio_dev, st->bounce_buffer);
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_trigger_ops ad4170_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
 static irqreturn_t ad4170_irq_handler(int irq, void *dev_id)
 {
 	struct iio_dev *indio_dev = dev_id;
 	struct ad4170_state *st = iio_priv(indio_dev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(st->trig);
+	else
+		complete(&st->completion);
 
 	return IRQ_HANDLED;
 };
 
+static int ad4170_trigger_setup(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-trig%d",
+					  indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad4170_trigger_ops;
+
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register trigger\n");
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	return 0;
+}
+
 static int ad4170_regulator_setup(struct ad4170_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1834,8 +2034,22 @@ static int ad4170_probe(struct spi_device *spi)
 				       IRQF_ONESHOT, indio_dev->name, indio_dev);
 		if (ret)
 			return ret;
+
+		ret = ad4170_trigger_setup(indio_dev);
+		if (ret)
+			return ret;
 	}
 
+	ret = ad4170_prepare_spi_message(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to prepare SPI message\n");
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      &ad4170_trigger_handler,
+					      &ad4170_buffer_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup read buffer\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.47.2


