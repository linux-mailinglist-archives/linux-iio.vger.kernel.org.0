Return-Path: <linux-iio+bounces-18838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5AAA0D09
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4FB482F15
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC22D8DA3;
	Tue, 29 Apr 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mzEPRHxQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B62D1F42
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745932094; cv=none; b=UuekdkvxeznjqbsK+8xEW9pOG4UZAFEO1a8pk2km36YQCFSNPEqbP5PVXardIMugf6FjE2CuZQR1WWNvsm0ybbASVRwAwhbmBZFovN3DN8Zb/Ei0tGmxYjJjsZnZrM5CiO4RPAw7wovC/rsd2nUfUv80Wjw3fTQ+AjWIKCXtQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745932094; c=relaxed/simple;
	bh=iiNkKp9S/Y/GaVGbTXmn8udDFVG9/+jXerMR9s94M28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1rqa3F+r2rJ7A6xY1r2EX3u/e4vw9JMUKdt7DPOlrlfd4DVHOLI+BZFFnKtehAxIIZA0cOxc6c7hPquSePscZh3IAowNdtjGxcwL6CliUky7DAMhxuapE2tVVlYRq7S92Fz98HFv4SaoZoOGYFHNgN0WZxEJhFGrQWASYwY/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mzEPRHxQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso53292595e9.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745932091; x=1746536891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mRBcsoz7zVCX+58NW+x3y1+k7FsR0LZXKG0O71RrzY=;
        b=mzEPRHxQNf/nOwTkSR5fWmdmQol70tFLUTMG19I+gcq9Nw7LGo7mgFRfllLVazKRmG
         2F4fvvWicO18R6M2bhvvG2L0DK6f296/E0kE5WOsBH6s8ZfW99Gmtt6t8QBgr0hel+ZM
         9/gLoQKxuRTcQEhhUjxZS6rDJoe8MIL5InRfLQyBpsxbnJ0y/ChckrCBOQTI5r/HD+JF
         f8e0vMocsERF/QIw3mrCy5pPtAvz3Mlqz05nO/KB9fD4LXdIQC6LKLIGLHmrRx7nWgdT
         0fFaT45O/+nGkhXcFD3qvuA3zxhMEltEfiIBhpsPRtvnVob0Hm38jsyjQRpN2cIuUEzF
         JAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745932091; x=1746536891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mRBcsoz7zVCX+58NW+x3y1+k7FsR0LZXKG0O71RrzY=;
        b=AqAZnN9wYh4U7cLrLokfMeDeUoj4CAP9JcrM8rt5EXstBossbilAjt3dru5BwVer37
         0bS95fGnTHIbbvTVVm5Z9j0kEyFlN2xXoXgDNu2WCoognYQIB4M6RGH0PGe3G3xLKKQ8
         bXqe1fm7xOpXo/yfCRJQwrsW0Z7m928XQyaafdAlB2ryjwkcbGi9tFPAg7rFbwQ1JUyG
         Q91OD6ccwjCNoVvY0mUECrDkeOIFPKKIhVKenc3gY1PPegIuBbgARGAaZGk4iEeO5NTV
         DmWJ4hSCDylCnuKxCK7daYfKAygdpRXAi6d9LzfYxtCGEepmJkRR4/ll4eoPY+rtMWAW
         Pb5g==
X-Gm-Message-State: AOJu0YyPRO1PWofROpud2evr9Wd00HFV3sKdZ7IuMDYg2FKsGbJiYQvh
	C/TJijlO+1nt02Hw/Zc+YeA367dtVKRejxFUpRcgpDgnUuk2WrRmZC/UnG4L4/s=
X-Gm-Gg: ASbGncskMfG6Pk3BmlmMrIYudjo+y82TipiUtL3bEAx7kLjsKeg5fgQbYeHwE0fFZPb
	JSJu1jM8G3moSXq/pgnrkU+vebjRLJpbeqY6wXIa1eXPef2qk7KzGt0iE3GND+W4mPsG2g5tPKX
	4ntiTjdGiBkcPfPpX43ktiI2ojFEMmq95Bw7hMg6tGyZHCKIWkmFFXF9zbwsumPPe1QaNGzb/m+
	/KvU/PvbpQ4TL//Wn/J1zNIHOPg1o+qZPwFvjT2MWbLOWs/ToXI/eonYjImL31MyL1Tg1huaPI5
	3EkdLN+cAMeYP4/3rpT77B8HzoY4FktEuNjr+suou3B0AOPgB0YhPgpgxT2fZZJzriPbNn5tSs/
	jIdUm7l1cHp3gnmo93kz0PS8=
X-Google-Smtp-Source: AGHT+IEOoLuBrvZmbUCEFOkGWsAm7+TMD7TUmhgzsQn5/1mS3vwzu2XpWTo3TgZr443jUbgiGRgwrA==
X-Received: by 2002:a05:600c:4693:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-440ab872201mr106757355e9.29.1745932088812;
        Tue, 29 Apr 2025 06:08:08 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5310ad2sm155550565e9.21.2025.04.29.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:08:08 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 29 Apr 2025 15:06:49 +0200
Subject: [PATCH 5/5] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-wip-bl-ad7606-calibration-v1-5-eb4d4821b172@baylibre.com>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5506;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=Ko8yd7lWpMt5mc22SXoTKQ7xTbqRtaJANaR0a/D+dnY=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgQOPfi53zWBe+mrP+1509t2SdZabdefjUPH0/B07P4v
 dRd63yedpSyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZhI+mtGhp0L5puxSWWG+q24
 NvvZTAWenueWkpNd7ttOfvw7f4mk1j1GhknR4a/33ZsnnPGF59cWUWMfwYRrb9ekpM+WlHN9oJ7
 Lww4A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support, using resistor values set on devicetree,
values to be set accordingly with ADC external RFilter, as explained in
the ad7606c-16 datasheet, rev0, page 37.

Usage example in the fdt yaml documentation.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  4 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ec063dd4a67eb94610c41c473e2d8040c91974cf..1ebc7080d3d153a2ba02bc5c126ef9957dc782ab 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -33,6 +33,10 @@
 
 #include "ad7606.h"
 
+#define AD7606_CALIB_GAIN_MIN	0
+#define AD7606_CALIB_GAIN_STEP	1024
+#define AD7606_CALIB_GAIN_MAX	65536
+
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values.
@@ -125,6 +129,8 @@ static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan);
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
+					struct iio_chan_spec *chan);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.max_samplerate = 300 * KILO,
@@ -180,6 +186,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606b_calib_phase_avail,
 };
@@ -195,6 +202,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -246,6 +254,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -357,6 +366,46 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 	return 0;
 }
 
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
+					struct iio_chan_spec *chan)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	struct device *dev = st->dev;
+	int ret;
+
+	device_for_each_child_node_scoped(dev, child) {
+		int reg, r_gain;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return ret;
+
+		/* channel number (here) is from 1 to num_channels */
+		if (reg < 1 || reg > num_channels) {
+			dev_warn(dev, "invalid ch number (ignoring): %d\n", reg);
+			continue;
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &r_gain);
+		if (ret)
+			return ret;
+
+		if (r_gain < AD7606_CALIB_GAIN_MIN ||
+		    r_gain > AD7606_CALIB_GAIN_MAX)
+			return -EINVAL;
+
+		/* Chan reg is 1-based index. */
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
+					  r_gain / AD7606_CALIB_GAIN_STEP);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
@@ -1410,6 +1459,10 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 				chan->info_mask_separate_available |=
 					BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					BIT(IIO_CHAN_INFO_CALIBPHASE_DELAY);
+				ret = st->chip_info->calib_gain_setup_cb(
+					indio_dev, chan);
+				if (ret)
+					return ret;
 			}
 
 			/*
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 4c39de36154ffb80dfbb01bb4f812826bdc55967..e9a59d2afafd43e66137599dbd8220cd6b641e61 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -50,6 +50,8 @@ struct ad7606_state;
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan);
 typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
+typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev,
+					    struct iio_chan_spec *chan);
 
 /**
  * struct ad7606_chip_info - chip specific information
@@ -66,6 +68,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  * @offload_storagebits: storage bits used by the offload hw implementation
+ * @calib_gain_setup_cb: callback to setup of gain calibration for each channel
  * @calib_offset_avail: pointer to offset calibration range/limits array
  * @calib_phase_avail:  pointer to phase calibration range/limits array
  */
@@ -81,6 +84,7 @@ struct ad7606_chip_info {
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
 	u8				offload_storagebits;
+	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
 	const int			*calib_offset_avail;
 	const int			(*calib_phase_avail)[2];
 };

-- 
2.49.0


