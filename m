Return-Path: <linux-iio+bounces-19491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F7CAB54EB
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7063A17E8A0
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47428E591;
	Tue, 13 May 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WnHu013d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EE28DB79;
	Tue, 13 May 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139766; cv=none; b=kTuEx2RTJF/buSXFe47rPT+AxsxGrDqYf+FnR3WkUMFEXRJEO5pjNbG9GNtSIDL98PBrY/fVc8790vAL7Pa9B7kQgx5KFHJXIDBQFHYnKhzcYDKZoYhbINqEpRod8J2/SouHwRhtzQqjdgjLYE4Y5eU4p/AmyR0hk5Q0NtUPSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139766; c=relaxed/simple;
	bh=has2j4jWPH3NoISEyLgsKHT/FxUD7USWU8QvNuJLtnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8V/P4u5JKo2u9X3LvKrudq4XV3szwEx4iWFoHgfBf4ogo/ShOt91cB1cVL7nWWM6pE54fab0s0tVcUTu/zFRV6s538baVl2ZKYo+aMrTiU4BFRaxLIZNUyD3Efw/mJQ2+UUNPBTnXNgzM6GnXuojYzqKw61wSEHtIIsSrCUAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WnHu013d; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9mP2I024818;
	Tue, 13 May 2025 08:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o3OoB
	pgSA/ObZv3t4C82Mdm3ViXpIWgP6D/tg4P5pCU=; b=WnHu013di6PGtzYpE2ua9
	XlsTD4QbI7//zmzItjxQpznd7Gf80XIEF3eo/S2NcX0caGFqD9gYFWDsfIaasmaQ
	Wmrg7spbz1LYb8t0O8TVJ4/tU/8gzETj0lftdHyTx7GACqPh9jio9+5ZAMNnuwpD
	RyuNkqWjtPbfXOrvmEOnIvdu36TYpBGD86G+wBy5zV4OvGDvBuK2CUPy9fVZqVqG
	DFBEOShF2aa0uAhfGokl+sLaXPE2qp0Hrz6HbuzJgsgxRzriUN99GCyvezks9bky
	J8gTA244aokpV+/wjugjs2HyMMpKpjUSpZDNacxqyrbEWgpm8ovhd/HQ0dYVBGzW
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46m3s98stc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:35:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCZhea041156
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:35:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:35:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:35:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:35:43 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCZOHC007527;
	Tue, 13 May 2025 08:35:27 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 06/10] iio: adc: ad4170: Add support for buffered data capture
Date: Tue, 13 May 2025 09:35:23 -0300
Message-ID: <011bfbcda9f74c1c3853a664b961e7884c3c7333.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8Hxj0ZSdbrxWu7TYZkH-97TmjGprWAl0
X-Authority-Analysis: v=2.4 cv=ZaUdNtVA c=1 sm=1 tr=0 ts=68233ca0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=81--d_VTT1IZEBHsVuEA:9
X-Proofpoint-GUID: 8Hxj0ZSdbrxWu7TYZkH-97TmjGprWAl0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExNyBTYWx0ZWRfX5d6CYG5Uju2u
 LAo9dfWpI/ZJF1ql8dZQiveoMzgvDwXJHR9TsFejw6JWB4uRy2FdDCaUOj9u8Bndpxrz8Ma6uB9
 oDZNJvx9+YjDRZj8jMytRuAXDTo6y64kKhU9ryfgeXuG3V9zuqCUMYA4pKR4sFH4pbxMX0E4MdR
 ft/SVfuvSKLL+A9GeOYpUuwRBgbYKuJ7/pXBD1r+tjL1pV1nwKIvnHfxcwNSGszm8P6QJ4WSYkz
 Km/XNPyS+OUso4s5Yp2qaTSJ7aI9sas9pj5ULqRtwDwaD7JGusTvZb3aCQK1C7K4CxGwW/lV83B
 gojA6O9YYWZ63gpebdc+H9QiLHyCNnOAA7f6mmor/Ab177vG420QVw2/OgYapF3/fDDCssiViek
 ehDlo0M+5pCS3hci0p1GV2WJSfAVTiNgWcWUR8CHkd87frfPO52KfUF1vQAnGOBcsTTLnbvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130117

Extend the AD4170 driver to allow buffered data capture in continuous read
mode. In continuous read mode, the chip skips the instruction phase and
outputs just ADC sample data, enabling faster sample rates to be reached.
The internal channel sequencer always starts sampling from channel 0 and
channel 0 must be enabled if more than one channel is selected for data
capture. The scan mask validation callback checks if the aforementioned
condition is met.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- Made validate_scan_mask() return false if no channel enabled (bitmap_weight() == 0).
- Use local variable device pointer to simplify trigger setup and better wrap lines.
- Tidy up buffer declaration, function returns, comments, and other minor things.
- Fixed data handling in trigger handler which I hadn't noticed to became buggy
  after xfter buffer type was changed from __be32 to u8 array.

 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4170.c | 211 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 211 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 594b9f55ec0a..0d3d3af862f8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -75,6 +75,8 @@ config AD4170
 	tristate "Analog Device AD4170 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 218f768042fe..e8856c911dfd 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -12,7 +12,11 @@
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
@@ -55,6 +59,7 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
 
@@ -66,6 +71,7 @@
 
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
+#define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
 #define AD4170_ADC_CTRL_MODE_MSK			GENMASK(3, 0)
 
 /* AD4170_CHAN_EN_REG */
@@ -110,9 +116,13 @@
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
@@ -143,6 +153,8 @@
 
 #define AD4170_GAIN_REG_DEFAULT				0x555555
 
+#define AD4170_ADC_CTRL_CONT_READ_EXIT			0xA5
+
 /* Analog pin functions  */
 #define AD4170_PIN_UNASIGNED				0x00
 
@@ -182,6 +194,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
 enum ad4170_ref_buf {
@@ -309,9 +322,13 @@ struct ad4170_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
+	__be32 bounce_buffer[AD4170_MAX_CHANNELS];
+	struct spi_message msg;
+	struct spi_transfer xfer;
+	struct iio_trigger *trig;
+	struct completion completion;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
-	struct completion completion;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -396,6 +413,10 @@ static int ad4170_reg_write(void *context, unsigned int reg, unsigned int val)
 	case 1:
 		st->tx_buf[2] = val;
 		break;
+	case 0:
+		/* Write continuous read exit code */
+		st->tx_buf[0] = AD4170_ADC_CTRL_CONT_READ_EXIT;
+		return spi_write(st->spi, st->tx_buf, 1);
 	default:
 		return -EINVAL;
 	}
@@ -556,6 +577,7 @@ static int ad4170_link_channel_setup(struct ad4170_state *st,
 
 /*
  * Sets the ADC operating mode. Supported modes are
+ * - Continuous conversion mode (default)
  * - Single conversion mode
  * - Idle mode
  */
@@ -824,6 +846,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.scan_type = {
 		.realbits = 24,
 		.storagebits = 32,
+		.shift = 8,
 		.endianness = IIO_BE,
 	},
 };
@@ -1431,11 +1454,27 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
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
 
@@ -1716,16 +1755,170 @@ static int ad4170_initial_config(struct iio_dev *indio_dev)
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
+	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_CONT);
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
+	ret =  ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
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
+
+	/*
+	 * The channel sequencer cycles through the enabled channels in
+	 * sequential order, from channel 0 to channel 15, bypassing disabled
+	 * channels. When more than one channel is enabled, channel 0 must
+	 * always be enabled. See datasheet channel_en register description at
+	 * page 95.
+	 */
+	if (bitmap_weight(scan_mask, masklength) > 1)
+		return test_bit(0, scan_mask);
+
+	return bitmap_weight(scan_mask, masklength) == 1;
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
+	unsigned int i;
+	int ret;
+
+	iio_for_each_active_channel(indio_dev, i) {
+		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			goto err_out;
+
+		memcpy(&st->bounce_buffer[i], st->rx_buf, ARRAY_SIZE(st->rx_buf));
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
@@ -1836,8 +2029,22 @@ static int ad4170_probe(struct spi_device *spi)
 				       indio_dev->name, indio_dev);
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


