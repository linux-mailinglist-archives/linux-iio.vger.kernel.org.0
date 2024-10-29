Return-Path: <linux-iio+bounces-11569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7D9B4CCC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F421C22354
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF6918DF86;
	Tue, 29 Oct 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="24oJnyXx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F31591E3
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214185; cv=none; b=OlfU/KOK37x+/77WLdKVYzilaTv28b+UCBP7rI/feJgFN/9YNbZJLwxXJATYzR0uiHvmUOkgKBMQUbuinX4HQWSOEZY54QWv1ZT2+4QyXdGFqRaJ7HdXDx6lDAK84jJA6qpym1V2k6CX6GTGmw5FXBN5tqYhDQil5NJomqqdk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214185; c=relaxed/simple;
	bh=NGmEG63HlhEcqsPK/hMy8gtwnA8QjcFMhz9GIwNmDG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kga8biYPWoi/p8MSjmHtz9nZNbJMOo8ZAOsQfJ9JCZCW4fAHFeHAA70bPtjxmXcxpcm5vlmlE6fcPF9yoODQaUmgriQO2jM16oX/3VV44LETngGBloRvaDu5KR5l7lTyn84p58ma6rnI1NJeZGiUmb8YeOCMAW1XRiZRZZG8Vao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=24oJnyXx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314b316495so50970705e9.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730214178; x=1730818978; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w++5zbuOHNJ0pWm8Mmb2u67bxOltv4u6u2Zk7wNp/QM=;
        b=24oJnyXxlb0Hwp/UudTSaB1KWaLx3ZWbRvzpWXPSEBToO4DOdGgMlrTNqjOTRD5+cF
         Hv2hKW/pY5s5bdon/c7UC6eD/yiINOp7oKZ2jPyaMKcvTyfPlIFW1s6Jlu2zHhnJx5tF
         sxvju2buUOceZ/ykK7CTVpReissJk8ohqG0lfhjw2X9RA2f03fAwyTGX//z+rMgEAHNX
         q9RzgAq6T6vXPLdCJZOjJe8IYQw8HJGAotRvMuibztz67Lwo6WKNefEEKBRXrW/HqDr2
         +voBXcCkN2TNJE/azoz49iKA/1X/gwsKVPyqzO+Z9Pq+Exeo8E0iMRzYM/JBjr5s0F54
         cWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214178; x=1730818978;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w++5zbuOHNJ0pWm8Mmb2u67bxOltv4u6u2Zk7wNp/QM=;
        b=MQqkKWbz39GP4tny3dGIyzJyiOrBfk61chbChdt1mOz3arGGX21RzcdxuZ9vB/NT0z
         XRwBfYLCE+tTbE9HjWRrgZ0k8UI5Rau4YsZ1yC5Q2szNZzPyJRtiq8Rt+5Yzb2d833Uy
         p7XamE4GNiYEIcr9jqoD/BfJztH9bp1hwFK15J00D4Tfj03xP1J+20E0ChuCHhmJQQgj
         MDwbhZ2mBrOH4UVBYDZvxZgGY337cCXkjndRnZI3mb2LZC3PKQUWkjzbfMvIqtsJyuK8
         Uc7omaUqhiFKzs0OHYEhrsje5GQOD5tVT+PraeWpHn9cNMf0+oYqgEWO+S3z93SOi4Vt
         +vSA==
X-Gm-Message-State: AOJu0YzoT2j7q+931hU2WtjXyw7oY4upaaNWgj88fDdAq/TislRwnf7G
	wOKoghP+jbnwDN3k0KqEQ7bftQK0eGXiw+buLHpyYz8Y9QsTY0tEtyx8NQApFko=
X-Google-Smtp-Source: AGHT+IGUNAk24zHH0IYlX/PxStc1ydQRdhaYiAMdjBLJpfDF29ikIASDWldijEV5Usej88Ge8WrA+A==
X-Received: by 2002:a05:600c:5246:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-4319aca3f6cmr90872985e9.11.1730214177686;
        Tue, 29 Oct 2024 08:02:57 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b542d3csm176988125e9.9.2024.10.29.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:02:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Oct 2024 16:02:46 +0100
Subject: [PATCH RFC] iio: adc: ad7380: add alert support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241029-ad7380-add-alert-support-v1-1-d0359401b788@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABX5IGcC/02OsW7DMAxEf8XQXAKSIiSS1wL5gK5FBloiWwK25
 UqOUSDIv0dxM3Qi7ng8vpuqVISq6rubKrRJlTw3Yd46Fb9x/iKQ1LSy2jqjbQBMp4PXbSTAkco
 K9bosuU2XdErHSOhjUu18KcTyu1d/qo/zu7r8mYV+ru3N+toMWAliniZZ+y7ooClSxBiYDVnLw
 4m0s3yI3h9D0Oh5aBn1H6/vXnAORPJONmEsGTgXoI3mlqF5FRYqu5eEuWE0C0d41sw0VjBD8sg
 JIzvbb0Zd7vcH9Po+WR4BAAA=
X-Change-ID: 20241029-ad7380-add-alert-support-4d0dd6cea8cd
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

The alert functionality is an out of range indicator and can be used as an
early indicator of an out of bounds conversion result.

ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to all
channels.

When using 1 SDO line (only mode supported by the driver right now), i.e
data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
used as an alert pin. The alert pin is updated at the end of the
conversion (set to low if an alert occurs) and is cleared on a falling
edge of CS.

The ALERT register contains information about the exact alert status:
channel and direction. Unfortunately we can't read this register because
in buffered read we cannot claim for direct mode.

User can set high/low thresholds and enable event detection using the
regular iio events:

  events/in_thresh_falling_value
  events/in_thresh_rising_value
  events/thresh_either_en

Because we cannot read ALERT register, we can't determine the exact
channel that triggers the alert, neither the direction (hight/low
threshold violation), so we send and IIO_EV_DIR_EITHER event for all
channels. This is ok, because the primary use case for this chip is to
hardwire the alert line to shutdown the device.

When reading a channel raw data, we have to trigger 2 spi transactions: a
first transaction that will trigger a conversion and a second
transaction to read the conversion. By design a new conversion is
initiated on each falling edge of CS. This will trigger a second
interrupt. To avoid that we disable irq in the hard irq handler and
re-enable them in thread handler.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Hello,

The ad738x family includes a built-in alert mechanism for early
detection of out-of-bounds conversion results. This series introduces
this functionality to the ad7380 family, with several open questions.

About High/Low Threshold sysfs entries:
The internal high/low threshold registers are 16 bits and thresholds must
be computed on a 16 bits scale, regardless of the actual ADC resolution,
 meaning SCALE and OFFSET attributes or realbits can't be used to compute
the raw value.

For example, with a 3.3V reference and a 16-bit scale, the calculation for
a 1.3V high threshold is 1300/0.100708 ≈ 13000 >> 4 = 812. User has to
write 812 in sysfs entry. This value is valid for all chips, regardless
of the actual ADC resolution.
Is it okay to have a raw threshold value that is not on the same scale
as the channel raw value? What about when reading back the threshold
values?

About event Handling:
There is an alert register containing two status
bits per ADC, one corresponding to the high limit, and the other to the
low limit. A logical OR of alert signals for all ADCs creates a common
alert value which drives out the alert pin.
Unfortunately we cannot read the alert register to determine the exact
channel and direction, because in buffered read, we cannot claim for
direct mode. So:
* we send an alert event on ALL channels
* we set the direction to IIO_EV_DIR_EITHER (xilinx-xadc is doing that)
Does that work?

Moreover, the user can not reliably read alert register manually because
when reading a channel, we have to do 2 transactions: 1 to trigger
conversion and 1 to read data (this one  will also trigger a new
conversion). When reading alert register, the register will not reflect the
 alert of the first conversion.
Does it make sens to send generic event if user can't read register?

Interrupt Handling:
Should we consider enabling interrupt only once per buffered read? If
thresholds are continuously exceeded a lot of interrupts are generated.

ADI engineers suggest the primary use of this alert pin is as a hardware
shutdown signal for the ADC. Therefore, is it better to skip event
handling and provide threshold configuration only? Would custom
attributes be more appropriate than events in this case?
---
 drivers/iio/adc/ad7380.c | 194 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e8bddfb0d07dbcf3e2a43344a4e0516f4d617548..595542aeaa5768fc577298a58715156b6cc4e7fd 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -30,6 +30,7 @@
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -92,6 +93,24 @@ struct ad7380_chip_info {
 	const struct ad7380_timing_specs *timing_specs;
 };
 
+static const struct iio_event_spec ad7380_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_dir = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_dir = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 enum {
 	AD7380_SCAN_TYPE_NORMAL,
 	AD7380_SCAN_TYPE_RESOLUTION_BOOST,
@@ -193,6 +212,8 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
 	.has_ext_scan_type = 1,							\
 	.ext_scan_type = ad7380_scan_type_##bits##_##sign,			\
 	.num_ext_scan_type = ARRAY_SIZE(ad7380_scan_type_##bits##_##sign),	\
+	.event_spec = ad7380_events,						\
+	.num_event_specs = ARRAY_SIZE(ad7380_events),				\
 }
 
 #define DEFINE_AD7380_2_CHANNEL(name, bits, diff, sign)	\
@@ -481,6 +502,9 @@ struct ad7380_state {
 	bool resolution_boost_enabled;
 	unsigned int ch;
 	bool seq;
+	int high_th;
+	int low_th;
+	bool alert_en;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
 	/* xfers, message an buffer for reading sample data */
@@ -948,12 +972,133 @@ static int ad7380_get_current_scan_type(const struct iio_dev *indio_dev,
 					    : AD7380_SCAN_TYPE_NORMAL;
 }
 
+static int ad7380_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	return st->alert_en ? 1 : 0;
+}
+
+static int ad7380_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     int state)
+{
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		struct ad7380_state *st = iio_priv(indio_dev);
+		int ret;
+
+		if (state == st->alert_en)
+			return 0;
+
+		/*
+		 * According to the datasheet, high threshold must always be
+		 * greater than low threshold
+		 */
+		if (state && st->high_th < st->low_th)
+			return -EINVAL;
+
+		ret = regmap_update_bits(st->regmap,
+					 AD7380_REG_ADDR_CONFIG1,
+					 AD7380_CONFIG1_ALERTEN,
+					 FIELD_PREP(AD7380_CONFIG1_ALERTEN, state));
+
+		if (ret)
+			return ret;
+
+		st->alert_en = state;
+
+		return 0;
+	}
+	unreachable();
+}
+
+static int ad7380_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		*val = st->high_th;
+		break;
+	case IIO_EV_DIR_FALLING:
+		*val = st->low_th;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int ad7380_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		struct ad7380_state *st = iio_priv(indio_dev);
+		int ret;
+
+		/*
+		 * According to the datasheet,
+		 * AD7380_REG_ADDR_ALERT_HIGH_TH[11:0] are the MSB of the 16-bit
+		 * internal alert high register. LSB are set to 0x0.
+		 * AD7380_REG_ADDR_ALERT_LOW_TH[11:0] are the MSB of the 16 bit
+		 * internal alert low register. LSB are set to 0xf.
+		 *
+		 * When alert is enabled the conversion from the adc is compared
+		 * immediately to the alert high/low thresholds, before any
+		 * oversampling. This means that the thresholds are the same for
+		 * normal mode and oversampling mode.
+		 * For 12 and 14 bits, the thresholds are still on 16 bits.
+		 */
+		if (val < 0 || val > 2047)
+			return -EINVAL;
+
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_write(st->regmap,
+					   AD7380_REG_ADDR_ALERT_HIGH_TH,
+					   val);
+			if (!ret)
+				st->high_th = val << 4 | 0xf;
+			return ret;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_write(st->regmap,
+					   AD7380_REG_ADDR_ALERT_LOW_TH,
+					   val);
+			if (!ret)
+				st->low_th = val << 4;
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	}
+	unreachable();
+}
+
 static const struct iio_info ad7380_info = {
 	.read_raw = &ad7380_read_raw,
 	.read_avail = &ad7380_read_avail,
 	.write_raw = &ad7380_write_raw,
 	.get_current_scan_type = &ad7380_get_current_scan_type,
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
+	.read_event_config = &ad7380_read_event_config,
+	.write_event_config = &ad7380_write_event_config,
+	.read_event_value = &ad7380_read_event_value,
+	.write_event_value = &ad7380_write_event_value,
 };
 
 static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
@@ -980,6 +1125,8 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 	st->oversampling_ratio = 1;
 	st->ch = 0;
 	st->seq = false;
+	st->high_th = 0x7ff;
+	st->low_th = 0x800;
 
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
@@ -992,6 +1139,42 @@ static void ad7380_regulator_disable(void *p)
 	regulator_disable(p);
 }
 
+static irqreturn_t ad7380_primary_event_handler(int irq, void *private)
+{
+	disable_irq_nosync(irq);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t ad7380_event_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	s64 timestamp = iio_get_time_ns(indio_dev);
+	struct ad7380_state *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan = &indio_dev->channels[0];
+	int i = 0, j = 0;
+
+	for (i = 0; i < st->chip_info->num_channels - 1; i++) {
+		iio_push_event(indio_dev,
+			       chan->differential ?
+			       IIO_DIFF_EVENT_CODE(IIO_VOLTAGE,
+						   j,
+						   j + 1,
+						   IIO_EV_TYPE_THRESH,
+						   IIO_EV_DIR_EITHER) :
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+						    i,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       timestamp);
+		j += 2;
+	}
+
+	enable_irq(irq);
+
+	return IRQ_HANDLED;
+}
+
 static int ad7380_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -1128,6 +1311,17 @@ static int ad7380_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = st->chip_info->available_scan_masks;
 
+	if (spi->irq) {
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+						&ad7380_primary_event_handler,
+						&ad7380_event_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						indio_dev->name,
+						indio_dev);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret, "Failed to allocate irq\n");
+	}
+
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      ad7380_trigger_handler,

---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20241029-ad7380-add-alert-support-4d0dd6cea8cd
prerequisite-change-id: 20241024-iio-add-macro-for-even-identifier-for-differential-channels-1bd8afdacf42:v1
prerequisite-patch-id: 95f88e2bd4b05642726a4e2431e80d0986f52075
prerequisite-patch-id: 5c66618adbc3a6ffb0d3a186b2a9b2fc8f814364

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


