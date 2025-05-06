Return-Path: <linux-iio+bounces-19217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4131AACF3C
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AAF1B67A8E
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EDB21ABBB;
	Tue,  6 May 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tuFG8mL8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8E216E01
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565531; cv=none; b=k4Gpk3NEVHb7ppwLCjmQsIuUBhvU74TmA+Uy1uN2EP/nziukbf08vF7OCGoU6nqGUpEq+6l4fYDr7P165wNnQiYMTmtYPzl0tiS+NwrMzLq/aGyPLA3Shim3qMoxIInivWsEQZ3UWOcOOpMY8OpH//TCeJGeXH3wsgVUwoxT8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565531; c=relaxed/simple;
	bh=z7O+cJ2s2VXn/7thHiJDbQY7RdvV9lwOOzqK+FZqCpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU8NPqs5CcednMQUku5xEnNEoe+jqLFIkXH8IGXb9EIp0ia99dMRaYnl6PtDWx+A9nkwiBgi18ut2dRUB0AFbmsOTuCTt/1rA9b9MCW+NQjj7YPvteyWtcDRSjJw8kWDLJifdtOS8rfB/Xj7E1l21mO6EvYnfvYWIiw5TcUsGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tuFG8mL8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so52424695e9.3
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746565528; x=1747170328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxjDKD+JKSiLqw8gK8zG+KrBnxfs5SYwuaGv7cdl5fk=;
        b=tuFG8mL84FquZoOheVVBWxOFQasfvzWViWkaacoMAJyXImsAIJQrTDp9ow8oSf3ZeM
         cpQpVs1Jak/bo1BBSkTEgyf9qmS401GUmcND2oByYzbTfa9JdkzB4+5+QBa5PXLraczV
         vxnKPBD0Aw4I1CG3nhwI8XLtKyFs2Zg9Tn1UJcMdoeZii2jfBeNHK/J5HHobQlOgUyj8
         YmrOboTw+wUlWhTWlfKidYQU5O39yhtxUOjX4ZRTjZs3PPxhpI8J7NKskuG1XUOtvGC0
         gfSvw1vRw6Lni3O8C8ig7lsJzcpPt0ofO5THHvCs28PSm4uazrHFIi9ziWuxvFT1PRhD
         +jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565528; x=1747170328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxjDKD+JKSiLqw8gK8zG+KrBnxfs5SYwuaGv7cdl5fk=;
        b=NRxshDrHW3UshjY4VymmRR74Re7x8Z+7izidF5AlIZ6Mnxz3HM8lBA+Eim/aZLBFZG
         ecP9m69G5q3w4vNSOYny+aEC5bCeYw/AWikL+DNGiug4Ku3QM8Yf/669uSuevs0qeRq4
         3ypigNIUmDGXF5BTFbvlgG+g9w38F1FOAcfP7aqHvhCUMmTxEmP1skhcQ4PoW8TSHGOo
         0T0UC2grKPgM/LQiMPAM9SAu7FeSLZWWJrZVHceWNB9wocuAtHqY3FTrGbxuLMXYl1pP
         E4++sA8AjWXRWpjTHsWB3ca9TpJSTRHq7nTcGNabUSMS4INfz9hMnKS3v1PoCE6SYbi9
         lQEw==
X-Gm-Message-State: AOJu0YxapQ5GHt6bbzehUlFfg6ieJnN2cpM5TKeLUDU3dflfqhj/kLst
	9z/MKYAqhKNFZu/r4cy+ArNvnN564JYJHFSkCtvl2vBiJNKiT2ZKPBesiTCm0oM=
X-Gm-Gg: ASbGncs5X/ZLiXgXGVUlqk2kAsj+IRYQzggGlEuJ1iwWn8T/k9xgon5XCnozpu2hwbc
	Oo7dJVm32qdMGjaq3/WmJuc/oP5XNl4JRRhKrCoIvCaCxqq2DW4B2ALvSb83ZcPB5sD7FR75Czz
	EajyA4t/Fk1eqLXx7OXoGO1lmfUeKyLYHWw3ZJ3fTvm+wyOdHO8VQWnkbbZ1ploZ2HfwvJ7PHAG
	c32wCg6foNUBHGC6kYbGKmdqcbWraoYVRS/74dsH4cDoNumsyk5cV7VaQPyMKnIuzWSb08RQTBD
	BqyIpe+XjLBOwMngrrFCbdOCjDOLNH/PbDv0gVR1MEV82C07yngSxfDm3PdnvgslMj3hacKx39W
	lc7HiB+scTL2d06eGcLnQkAg=
X-Google-Smtp-Source: AGHT+IH/I6vCXS+EzMw3gIbUrM+QZJy17d3GmYqQtggUh+d00T+nsunpp1HkxxkyT/ZZ+4Ldp/Ngiw==
X-Received: by 2002:a05:600c:5006:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-441d44de12dmr3049785e9.22.1746565527940;
        Tue, 06 May 2025 14:05:27 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d4351abdsm6794475e9.23.2025.05.06.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:05:27 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 06 May 2025 23:03:51 +0200
Subject: [PATCH v3 5/5] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250506-wip-bl-ad7606-calibration-v3-5-6eb7b6e72307@baylibre.com>
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
In-Reply-To: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5739;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=P/FuxJZA+9kES7o8SpZCT2TnVHvYO5j9LvTN2jJFlis=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQqvSYb7upmDlGwPPAjCt+jzb1+BmrOz3byPtZXjL22
 xdt5d08HaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACZiKM/w39XKa/n7HcWltiHn
 3DYW79QLWLLIjffi7mmB6gmCEU2pbxn+B+twGNwW4WFwFilxef0w4veF/t6tPT3noo+nbmB93vm
 BHQA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support, using resistor values set on devicetree,
values to be set accordingly with ADC external RFilter, as explained in
the ad7606c-16 datasheet, rev0, page 37.

Usage example in the fdt yaml documentation.

Tested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  4 ++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index a986eb1284106da4980ac36cb0b5990e4e3bd948..049fd8616769d32778aa238b348b2fb82fa83745 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -33,6 +33,10 @@
 
 #include "ad7606.h"
 
+#define AD7606_CALIB_GAIN_MIN	0
+#define AD7606_CALIB_GAIN_STEP	1024
+#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
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
@@ -357,6 +366,49 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
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
+		u32 reg, r_gain;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return ret;
+
+		/* channel number (here) is from 1 to num_channels */
+		if (reg < 1 || reg > num_channels) {
+			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
+			continue;
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &r_gain);
+		if (ret == -EINVAL)
+			/* Keep the default register value. */
+			continue;
+		if (ret)
+			return ret;
+
+		if (r_gain > AD7606_CALIB_GAIN_MAX)
+			return dev_err_probe(st->dev, -EINVAL,
+					     "wrong gain calibration value.");
+
+		/* Chan reg is 1-based index. */
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
+			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
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
@@ -1410,6 +1462,10 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 				chan->info_mask_separate_available |=
 					BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					BIT(IIO_CHAN_INFO_CONVDELAY);
+				ret = st->chip_info->calib_gain_setup_cb(
+					indio_dev, chan);
+				if (ret)
+					return ret;
 			}
 
 			/*
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f613583a7fa4095115b0b28e3f8e51cd32b93524..94165d217b69d54cbce9109b8c0f9dc0237cf304 100644
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


