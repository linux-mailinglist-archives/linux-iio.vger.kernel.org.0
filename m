Return-Path: <linux-iio+bounces-20769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26965ADF412
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B5188B138
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCD2F548A;
	Wed, 18 Jun 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hNCtp7HU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBA2F3656;
	Wed, 18 Jun 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268293; cv=none; b=D2nuvzJiRKvZZzhmDTVl/U3sZZxKAFq7NaOHCHMhrd4QInJpK0ElpbaP9LA8itOETL3zKpwkZ4V6mnjR3BqTR3mjsdkfkRRKwiMAXtauvg6LJ+TBvbL+iJ9HbWXr8dW49D0IKB4ZoQqh17gN+fRto2xKqvKvJYaQecTIHxBUxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268293; c=relaxed/simple;
	bh=ohJZuP3dn0PU/0V+ca3vsVPOb7wEixXemFa32dqprxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDb9TDxs3MDY6VBOgtKcKar5YWsFu9Xj3TA50e1LvkN08W6L5QUBEjBlcbWZ5NQJnwHSROsgekj7xBN6WQx9v8jDNbVQkpkYQxW/5tG/408swsImctqFR/KSvMYdurxHBKmiDY0Fa8q5HT1rp66g/x0cgkdD51TTMU6abp39akI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hNCtp7HU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IGMPdR028436;
	Wed, 18 Jun 2025 13:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kkRp8
	wSxlB97fB4UHPeKvyqAEfwkAw+fwtDdvhK1YtI=; b=hNCtp7HUzOZT/KFtCBQmN
	t+jbIGjRQHVzCHgO+EW47+BCJxXea9MqdaiPrKiLcovWxIRpEA97fyQ+m26rxKFo
	wKHtB0ULHK4JUsLs+v319kO49qgCrYtadsPLaS0cdsfhfpDpt29U0IhMpNGer0i1
	IbMS4PfFDEp3SelB7gxLVeKVB6+AvkX94IjdWteiOGPYAbRlArhMdqPCdtmFwPdr
	jFzLEMTfszmE13/voqZhK2PMjcv7jrVt9HeGu6vkfFgNsA6sn8RwcIo7XkuvDufV
	JInNnlJHhJxNnHMKgfIRiJ/f2Qrj8snazifVpOW/xeeMwngU3ic2UoD77TZtH3Bs
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47bfxcwdc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 13:37:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55IHboGc016164
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Jun 2025 13:37:50 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 18 Jun 2025 13:37:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 18 Jun 2025 13:37:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 18 Jun 2025 13:37:50 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55IHbVxK007482;
	Wed, 18 Jun 2025 13:37:34 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 07/12] iio: adc: ad4170: Add support for buffered data capture
Date: Wed, 18 Jun 2025 14:37:30 -0300
Message-ID: <c8a14b9cb6fd5de15c2033cfeb1df84b193941b9.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1YlMBSJpPxr4PGG6WgyIICUh6dwCNK75
X-Proofpoint-GUID: 1YlMBSJpPxr4PGG6WgyIICUh6dwCNK75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE1MCBTYWx0ZWRfX0VNYqtBqp81g
 p+l9QKoz1PUkniDb6kiGpftJoQ9dS2Ul2IO8GwHUANleMfIkaVxGrmqScywiUZERxs/vsrnTEiD
 eoAWxLk/PdGVALrB3u5uyE9ORCjZsIOSCkMI2I8K067cS82i1/PuSnJuItY348qASsVbi5c5jnp
 CXaCqDzb2X6yow1greVp9FyqoMUzziGr5qffIhNmLCopGimcLMyfrLkDyuYLa18ALq7O4FTAYjX
 ChwsAmsIcX6Z6rizJH2h9nBSTF3JMENdIwwyHBOzPn9Cbd2YdAoyFyUJFmxs0rD7CvuoKUYn7LC
 8HnV3CtJe6tkbdAYbz+HQwY3wOlYdBwOMadHp29rfGEetTryEBFxiW0rN0pIHaqcjHfyhqMM9v9
 j84FwFYciZj2lYCD3ttu7l684SVuZKr2h9Y0faSGUbJSiKmByG30mKHbRjKBx4MkIgzE6jX/
X-Authority-Analysis: v=2.4 cv=Jb28rVKV c=1 sm=1 tr=0 ts=6852f96f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=S2ps9YoUDC_6q7dLIc8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180150

Extend the AD4170 driver to allow buffered data capture in continuous read
mode. In continuous read mode, the chip skips the instruction phase and
outputs just ADC sample data, enabling faster sample rates to be reached.
The internal channel sequencer always starts sampling from channel 0 and
channel 0 must be enabled if more than one channel is selected for data
capture. The scan mask validation callback checks if the aforementioned
condition is met.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6
- Used local variable to minimize the risk of race conditions when checking IIO
  scan_mask.

 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4170.c | 217 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 03966d07a721..b12dcc04c894 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -89,6 +89,8 @@ config AD4170
 	tristate "Analog Device AD4170 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index b229a24b40de..2acd4316b079 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -14,7 +14,11 @@
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
@@ -59,6 +63,7 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
 
@@ -70,6 +75,7 @@
 
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
+#define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
 #define AD4170_ADC_CTRL_MODE_MSK			GENMASK(3, 0)
 
 /* AD4170_CHAN_EN_REG */
@@ -114,9 +120,13 @@
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
@@ -148,6 +158,8 @@
 
 #define AD4170_GAIN_REG_DEFAULT				0x555555
 
+#define AD4170_ADC_CTRL_CONT_READ_EXIT			0xA5
+
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
@@ -184,6 +196,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
 enum ad4170_ref_buf {
@@ -318,6 +331,10 @@ struct ad4170_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
+	__be32 bounce_buffer[AD4170_MAX_CHANNELS];
+	struct spi_message msg;
+	struct spi_transfer xfer;
+	struct iio_trigger *trig;
 	struct completion completion;
 	unsigned int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
@@ -405,6 +422,10 @@ static int ad4170_reg_write(void *context, unsigned int reg, unsigned int val)
 	case 1:
 		st->tx_buf[AD4170_SPI_INST_PHASE_LEN] = val;
 		break;
+	case 0:
+		/* Write continuous read exit code */
+		st->tx_buf[0] = AD4170_ADC_CTRL_CONT_READ_EXIT;
+		return spi_write(st->spi, st->tx_buf, 1);
 	default:
 		return -EINVAL;
 	}
@@ -805,6 +826,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
+		.shift = 8,
 		.endianness = IIO_BE,
 	},
 };
@@ -1386,11 +1408,27 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
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
 
@@ -1676,16 +1714,179 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
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
+	st->trig->dev.parent = dev;
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
@@ -1810,8 +2011,22 @@ static int ad4170_probe(struct spi_device *spi)
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


