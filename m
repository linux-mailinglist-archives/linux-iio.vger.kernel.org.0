Return-Path: <linux-iio+bounces-8687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E495B550
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93E0B239C6
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC91CB153;
	Thu, 22 Aug 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yVQM6Brg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCB1C9EA5
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330755; cv=none; b=P0q7f0kdOO7DAKTF5iC9HefW8qKtOJ9vrpSWWjJGsy+b6AZ9EJ5knGzlJUVbNonT29v52VNjMYoW5bZbgUu/dZEYNxmGydDktZL89A3GVIqF/QJbWbwhYz87q6nDcU+XNcl2qewixYK1eooqvdC/sXigcacdmxuLfveSlW5ZtKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330755; c=relaxed/simple;
	bh=BQq3yuuLfkThDJna9D1JgPWyr017caa7OeVp4BQHD4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iz7+MsSkaUZzq+46B5I8DthCrcvfWk27GcESyYa/ch8LsSa9FNO4ax7vmaQejW5Dt+r2qBX1DoPywbcLta0iLXmbvtUfYICiLeL84vsdDApaFA5yIOtyvU5iamr4NU0dlAeacIJZnbHjptes1RnPQfnibn4kYNlnsozIk3M7rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yVQM6Brg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428243f928fso7506305e9.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724330751; x=1724935551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHCgooAFPvkDFxrFb/inVvNGAyeXJRZBZky/8+Lq9uc=;
        b=yVQM6BrgIts+/bwAD6Ft9qvc7ACds6HFhfeBkPLswX81IbgsgmLiCcr5OGxZYGIYSw
         qZt7zyKIvtNuil7j4cmTSZXkz9E+gNdzksO7wsJ+WA6rtpdhnbXSaJMJ9IQa9RT4WfxZ
         izY2tehAo9ipu8yFr8CO6lGMugUM9tmSIfBcb8ZP3rBZBh9yzj6oNR0/MyaZHWRg8x70
         S10bPG5KmBCsgOjKAJvmpJV02+bO0mkM4OV2glbB9MuBWnI+jwGUwMqQmiFTNTz9u2Fn
         uMoMdGoBHvulgFhCo8ZmHRC5hUvndR7NcaAKPm5K/SCsDAg55BQBA2J8thXV2GU1Nd8z
         0t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330751; x=1724935551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHCgooAFPvkDFxrFb/inVvNGAyeXJRZBZky/8+Lq9uc=;
        b=B8/f0t7H6A61zVsgEGEuJEwRl2H5l9YkxiFwqOQwKm32tPHB+9sQ6A+s8vDkN8PhUT
         9Akp8OuBl89VX8W4OK8GPcB4lKWYog9NuO03FwoJ7CVdcIUSdBm2CkmdaSadv39r3CX2
         tUw5ouhapzGldPYVYVj4JGGtbBcwL/R3XztGxZv/Z038c3lzemG+b/gWS6YW3jCvTWh7
         YP2iP4pHeqtoJUF/qJWK+0ToRAmtJ3s6PpL+i0G4gjESlappf2Xw33E0SQMUOnJvK9DC
         Zre1Wvpa1UBXdtS3Gq+rlyTtVeoaYgUIgwcJLs2UVKpOSm8oO2Rb1WQHhwlwQx2sXPIc
         THOw==
X-Forwarded-Encrypted: i=1; AJvYcCXR47YH3gh4BCheF7uMqtNFzKRWdVIBvHSd7SvzqDs5KQ4PSWAEPAN/Do0MXaYDEunQvtzrdfpYIBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCKOm8yZ+MKQpGpJvBUqFwAZR/nUqIlUGSWXW/7CoiVqsLo6L
	OBDJr95cr5W5hy8JthVQNZ0k95RbkY5Q6XN1REmteeUvUXl5O/3XyDH4kZxEc78=
X-Google-Smtp-Source: AGHT+IEFXpryc30XDQogMGJVEBcxhb70P0zXx9O7V7kIQu5RfgvrvoyjomL/2qgxblaDKslhKnP+2w==
X-Received: by 2002:a05:600c:1c28:b0:428:e30:fa8d with SMTP id 5b1f17b1804b1-42ac55b274amr15841305e9.6.1724330750977;
        Thu, 22 Aug 2024 05:45:50 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:8da6:6d6d:c8ed:16c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm24032195e9.2.2024.08.22.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:45:50 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 22 Aug 2024 14:45:20 +0200
Subject: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1724330738; l=10594;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=BQq3yuuLfkThDJna9D1JgPWyr017caa7OeVp4BQHD4k=;
 b=U1NIU0lHAAAAAQAAAhcAAAAHc3NoLXJzYQAAAAMBAAEAAAIBALJZcW6pLD4ksSdWnXd5r65Ze
 5Qc5pH7+DmmbKJasOXeVYRPFEmnORS7pwhURG11AMVFmnCVYWj+wPYrbCEeM7XKfO4oQzc66kYB
 7y0RrFwjoWKofytjI026zV5b2pn1JAItgu0Ijth+TSa6KVOTSXqqiVzOTDM1WL0hAIIzpkhE3Vt
 AVJrFDsh/nWed9OpeSS+S6e3ZxyJtlnhqbVIemcDmjwMihtFgTKeJWlxP7KGY/RQKPF/Ef7pS+O
 AckOrxuqGKvpOiNVCmuQEUQM0+r4uvwtja4zRSl+huqW+g1nLyReoZPzFwfJWREd+89dtTJTXN7
 xmmFNdX6KzRKBLVw1RY/R3mhAd+MkrdiNaRNKj+LO1QIxPoW90cPG9WpdVDUZf1VxhdciB6Hlxn
 lfEDFuCxU0n5H+kC4eiZvw+c9D4xX7iVdjPTMEaE6GBQNnMncdljBwA5NVN8WcaUhnAQnq7qhcz
 85L2Br7MPqe3q3J/PHIe0nHO56j7tTY6cFFs/ckqcQSTJigh2rA7InN1d7GqZFLzlewRTGaCY+M
 93d7DCIuxTxJWRpVm7NW1FBeX6d00+dAcQ/dS+jmA3kcdRoWtH160jmmYYvOgrsQTcMIQrPtK+B
 rULRmmIvEIJMF5UfNmxruWmWn6MM/xeejTNszoKqrORpbr7q3BnkKt2y/KdAAAABnBhdGF0dAAA
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIARSGYQiEfzNlBinOirRbYcf/6B5L
 eMUq/St2pr4Kv8iM82PQFDDcJ+J60VUxyFCHin1YmHprOJZXOjDkmaUw+Hvabdn4j7cm1rXCxux
 pdZundtgtAXaY1VzoTVXJr5xg2RimwQPwj81kKwdAeUtkUu51srUMRUdPa5TAU1/T+x1bTNYHBV
 DoBH5ioIZznbgD9TITLV/kxx5bpt+xpIvUHGGNFDX9mtFCMarZRHX1mQpJcNjsn4sckSwbme7qT
 S/TOTmfqMGavFvr3nKKUmeMK0TN+swvGP5+vYdPw2wR9IULLJaS80tWYPjMTnCk/L7Y1QmsmbRH
 n062FJfqrCycZvYttDRzMsOv9ud9s7bPL3K1k/xKtjeOQaTnIdLPNMXh7eTRtnSmMfsZirB+VVU
 +Xn32Lq8T1d6W8o7D1pMZmnD3+wLJerhlDC9ng8VxNO8DsXIIvyfJjmLrS92AHRP6hSX6rJKCP/
 Lo4iOdIY58viwFwrGeTAxd6Zsxeqk17NemyOmSHiTclEsoSaxhFww0Uj7TkqpGdq5LiGuqA2q60
 ulfNMJA2ICm0Cqp7KeO9aGYiJUK0t0z60qd/9rY/eYxkbv4t7M26UIopchdw/wmm5/TpUYa5moS
 8kxUShJpe0TGaIZ/njifD3v35z/gH4hjPabCeURzLzeXWAW56zPamYyM=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

AD4630-24 and AD4630-16 are 2 channels ADCs. Both channels are
interleaved bit per bit on SDO line.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 197 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 173 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index e1e1dbf0565c..dbba5287b630 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -32,6 +32,8 @@
 #define AD4030_REG_PRODUCT_ID_H				0x05
 #define AD4030_REG_CHIP_GRADE				0x06
 #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
+#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE	0x03
+#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -159,10 +161,14 @@ struct ad4030_state {
 	struct {
 		union {
 			u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
-			struct {
-				s32 val;
-				u32 common;
-			} __packed buffered[AD4030_MAX_HARDWARE_CHANNEL_NB];
+			union {
+				s32 diff[AD4030_MAX_HARDWARE_CHANNEL_NB];
+				struct {
+					s32 diff;
+					u32 common;
+				} __packed
+				buffered_common[AD4030_MAX_HARDWARE_CHANNEL_NB];
+			};
 		};
 	} rx_data __aligned(IIO_DMA_MINALIGN);
 };
@@ -171,7 +177,7 @@ struct ad4030_state {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
-	.channel = _idx * 2 + 2,					\
+	.channel = _idx * 3 + 2,					\
 	.scan_index = _idx * 2 + 1,					\
 	.extend_name = "Channel" #_idx " common byte part",		\
 	.scan_type = {							\
@@ -194,8 +200,8 @@ struct ad4030_state {
 		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
-	.channel = _idx * 2,						\
-	.channel2 = _idx * 2 + 1,					\
+	.channel = _idx * 3,						\
+	.channel2 = _idx * 3 + 1,					\
 	.scan_index = _idx * 2,						\
 	.extend_name = "Channel" #_idx " differential part",		\
 	.differential = true,						\
@@ -412,7 +418,7 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned int avg_len)
 static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
 					unsigned int mask)
 {
-	/* Common byte channel is after the "real" differential sample channel */
+	/* Common byte channels are after each differential channel */
 	return mask & AD4030_COMMON_BYTE_CHANNELS_FILTER;
 }
 
@@ -420,18 +426,69 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
 
-	if (st->avg_len)
+	if (st->avg_len) {
 		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
-	else if (ad4030_is_common_byte_asked(st, mask))
-		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
-	else
+	} else if (ad4030_is_common_byte_asked(st, mask)) {
+		switch (st->chip->precision_bits) {
+		case 16:
+			st->mode = AD4030_OUT_DATA_MD_16_DIFF_8_COM;
+			break;
+
+		case 24:
+			st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	} else {
 		st->mode = AD4030_OUT_DATA_MD_24_DIFF;
+	}
 
 	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
 				AD4030_REG_MODES_MASK_OUT_DATA_MODE,
 				st->mode);
 }
 
+/*
+ * @brief Descramble 2 32bits numbers out of a 64bits. The bits are interleaved:
+ * 1 bit for first number, 1 bit for the second, and so on...
+ */
+static void ad4030_extract_interleaved(u8 *src, u32 *ch0, u32 *ch1)
+{
+	u8 h0, h1, l0, l1;
+	u32 out0, out1;
+	u8 *out0_raw = (u8 *)&out0;
+	u8 *out1_raw = (u8 *)&out1;
+
+	for (int i = 0; i < 4; i++) {
+		h0 = src[i * 2];
+		l1 = src[i * 2 + 1];
+		h1 = h0 << 1;
+		l0 = l1 >> 1;
+
+		h0 &= 0xAA;
+		l0 &= 0x55;
+		h1 &= 0xAA;
+		l1 &= 0x55;
+
+		h0 = (h0 | h0 << 001) & 0xCC;
+		h1 = (h1 | h1 << 001) & 0xCC;
+		l0 = (l0 | l0 >> 001) & 0x33;
+		l1 = (l1 | l1 >> 001) & 0x33;
+		h0 = (h0 | h0 << 002) & 0xF0;
+		h1 = (h1 | h1 << 002) & 0xF0;
+		l0 = (l0 | l0 >> 002) & 0x0F;
+		l1 = (l1 | l1 >> 002) & 0x0F;
+
+		out0_raw[i] = h0 | l0;
+		out1_raw[i] = h1 | l1;
+	}
+
+	*ch0 = out0;
+	*ch1 = out1;
+}
+
 static int ad4030_conversion(struct ad4030_state *st,
 			     const struct iio_chan_spec *chan)
 {
@@ -460,12 +517,21 @@ static int ad4030_conversion(struct ad4030_state *st,
 	if (ret)
 		return ret;
 
-	if (st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
+	if (st->chip->num_channels == 2)
+		ad4030_extract_interleaved(st->rx_data.raw,
+					   &st->rx_data.diff[0],
+					   &st->rx_data.diff[1]);
+
+	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
+	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
 		return 0;
 
 	byte_index = BITS_TO_BYTES(chan->scan_type.realbits);
-	for (i = 0; i < st->chip->num_channels; i++)
-		st->rx_data.buffered[i].common = ((u8 *)&st->rx_data.buffered[i].val)[byte_index];
+	/* Doing it backward to avoid overlap when reordering */
+	for (i = st->chip->num_channels - 1; i > 0; i--) {
+		st->rx_data.buffered_common[i].diff = st->rx_data.diff[i];
+		st->rx_data.buffered_common[i].common = ((u8 *)&st->rx_data.diff[i])[byte_index];
+	}
 
 	return 0;
 }
@@ -489,9 +555,9 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
 		goto out_error;
 
 	if (chan->channel % 2)
-		*val = st->rx_data.buffered[chan->channel / 2].common;
+		*val = st->rx_data.buffered_common[chan->channel / 2].common;
 	else
-		*val = st->rx_data.buffered[chan->channel / 2].val;
+		*val = st->rx_data.diff[chan->channel / 2];
 
 out_error:
 	ad4030_enter_config_mode(st);
@@ -582,14 +648,17 @@ static int ad4030_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL_LOG2;
 
 		case IIO_CHAN_INFO_CALIBSCALE:
-			ret = ad4030_get_chan_gain(indio_dev, chan->channel,
-						   val, val2);
+			ret = ad4030_get_chan_gain(indio_dev,
+						   chan->scan_index / 2,
+						   val,
+						   val2);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT_PLUS_MICRO;
 
 		case IIO_CHAN_INFO_CALIBBIAS:
-			ret = ad4030_get_chan_offset(indio_dev, chan->channel,
+			ret = ad4030_get_chan_offset(indio_dev,
+						     chan->scan_index / 2,
 						     val);
 			if (ret)
 				return ret;
@@ -614,11 +683,14 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 		switch (info) {
 		case IIO_CHAN_INFO_CALIBSCALE:
-			return ad4030_set_chan_gain(indio_dev, chan->channel,
-						    val, val2);
+			return ad4030_set_chan_gain(indio_dev,
+						    chan->scan_index / 2,
+						    val,
+						    val2);
 
 		case IIO_CHAN_INFO_CALIBBIAS:
-			return ad4030_set_chan_offset(indio_dev, chan->channel,
+			return ad4030_set_chan_offset(indio_dev,
+						      chan->scan_index / 2,
 						      val);
 
 		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -801,10 +873,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 
 static int ad4030_config(struct ad4030_state *st)
 {
+	int ret;
+	u8 reg_modes;
+
 	st->offset_avail[0] = (int)BIT(st->chip->precision_bits - 1) * -1;
 	st->offset_avail[1] = 1;
 	st->offset_avail[2] = BIT(st->chip->precision_bits - 1) - 1;
 
+	if (st->chip->num_channels > 1)
+		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
+				       AD4030_LANE_MD_INTERLEAVED);
+	else
+		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
+				       AD4030_LANE_MD_1_PER_CH);
+
+	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
+	if (ret)
+		return ret;
+
 	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
 		return regmap_write(st->regmap, AD4030_REG_IO,
 				AD4030_REG_IO_MASK_IO2X);
@@ -891,8 +977,16 @@ static const unsigned long ad4030_channel_masks[] = {
 	0,
 };
 
+static const unsigned long ad4630_channel_masks[] = {
+	/* Differential only */
+	BIT(0) | BIT(2),
+	/* Differential with common byte */
+	GENMASK(3, 0),
+	0,
+};
+
 static const struct iio_scan_type ad4030_24_scan_types[] = {
-	[AD4030_SCAN_TYPE_NORMAL] = {
+	[AD4030_OUT_DATA_MD_24_DIFF] = {
 		.sign = 's',
 		.storagebits = 32,
 		.realbits = 24,
@@ -908,6 +1002,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
 	},
 };
 
+static const struct iio_scan_type ad4030_16_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 16,
+		.shift = 16,
+		.endianness = IIO_BE,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_BE,
+	}
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
@@ -923,14 +1034,52 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.tcyc = AD4030_TCYC_ADJUSTED_NS,
 };
 
+static const struct ad4030_chip_info ad4630_16_chip_info = {
+	.name = "ad4630-16",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(0),
+		AD4030_CHAN_IN(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
+	.precision_bits = 16,
+	.num_channels = 2,
+	.tcyc = AD4030_TCYC_ADJUSTED_NS,
+};
+
+static const struct ad4030_chip_info ad4630_24_chip_info = {
+	.name = "ad4630-24",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(0),
+		AD4030_CHAN_IN(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
+	.precision_bits = 24,
+	.num_channels = 2,
+	.tcyc = AD4030_TCYC_ADJUSTED_NS,
+};
+
 static const struct spi_device_id ad4030_id_table[] = {
 	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
+	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
+	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad4030_id_table);
 
 static const struct of_device_id ad4030_of_match[] = {
 	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
+	{ .compatible = "adi,ad4630-16", .data = &ad4630_16_chip_info },
+	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad4030_of_match);

-- 
2.44.1


