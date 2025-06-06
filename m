Return-Path: <linux-iio+bounces-20270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7659EAD03E9
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536DD178E2A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480B289356;
	Fri,  6 Jun 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UZLVYr9z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F51CD21C
	for <linux-iio@vger.kernel.org>; Fri,  6 Jun 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219649; cv=none; b=TevizhMDO0MiKdIFmpU4DiZrXMOJvi1uAo/FZOzplOIVNstL2spSASBbubAzUMy2bi0tKUQ9jnCDP9AX0gAaEFsRuPYelu4yJIfcpL3iB+8G+WAV+JnWRqsLkSe2cKy//uuQYx/894qPchyUeFW+/kqFV6HY7yMnwSxeyE9tlMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219649; c=relaxed/simple;
	bh=L/gwxvm6plajhtZUJBhnKB7CkU77xzODIZq6h41Wvi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGU+fam037Gs3yEFlhkxPFoQyYJf5/2CEf2YRh8Vd4Bv/2UXZt5zpbqbNdCFbgfm7Ape3NJvqCdK/nNx7G46COK2YN729w/m8YTaNfPqsKvMjlb9Inmz0do0FvtR4rjkn4k4CPy5dupKwdHxrlFpMjMy3IzLJrT6JB1VbazkVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UZLVYr9z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so21970395e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749219646; x=1749824446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HpQeVbRwMAK/HKOtbrEdsV8ikZIsnrbhJJIVEFRiLg=;
        b=UZLVYr9ztQa6BVFfwr3aiSB10sy0axQE0a3TBQBgJdgvoOT01bcbF9w7lf5YJNChCI
         94BCa6EsDFNQV5At+nHN9o4ATVXdI+lWKKeNcHchwliO/Gglu35YTAJVxLqnjySFxYiy
         1q7emvStVxmdRoE0+0duHjKJ3a+Yotyif/yn3SVJoCzEyfN5HO9mdATCDwqJC42hdX0L
         xMi0X0Z+NmYMVezqyVG0zLF2ZE0Q0DWZEbsUEN14CrMAmYWlhfZweuyNpBBrQqGvnJUB
         3pIA7+epvNvhfWJWZlzfGlTiP8HH3VolCOsrn27dxWgBF7he3/LsAKt/lRXZU5ERtjjR
         vQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219646; x=1749824446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HpQeVbRwMAK/HKOtbrEdsV8ikZIsnrbhJJIVEFRiLg=;
        b=kSBW7DiODbhKCMIppY6AexZeXnpnpcVmPwl0Gbh2Fyavog4ksdbkaT4moO9giZjXfO
         EcZJUGi8adUA28Y9siD2B9844E2U8Z9gOQFLXYMtYxNoX8WQr/D5LUbZUzNMG19/xrhw
         T7qiO+NZuF3niVRlzzvPt8pLUVr0JuNSHzoA8Rmao1jeqYKxVbiejjIJPxh4LQtv8G8o
         vwXJZIJIY7yqjbLKoZU8Egqx0qkLgxSTzbBisHiTplB8uySjN+CrRNyqEqX1S6pYq9Cv
         jFeJ7TCaK3+PgqiQNxm8xheNi5fOpkW057PYfuRegyYbeMlZYZ0Z7ln4vzqF45+3/gGH
         uimQ==
X-Gm-Message-State: AOJu0YxV+U9B6lRA6ZCPFRHylyN3qjUCHIDBvMnMOPmnLjRynkQinExO
	M0CutYDjPAVih7fu8SlTTw/VSRw4XivLwx55z2A8zRXId+FwUVEnDfdX8PwVzG7wqvw=
X-Gm-Gg: ASbGnctsawIl92ABH9eDUBieub6mLeiiNV0RO+t2v9NzprDtT00ftLxK+VnThbsCPHW
	7FMba9zPTZyV1T4kaT8ZibVuxIcFhojvcOs5dyKvTF+geOlcb22H2ymiA56vpNqh6NDx5gTFclS
	jUQ7Ltk3I8kcFsI+76w9N/f0/s+t//QdojAjyXn9/LFSx5JJbG2oR/rjEp8jh7dcCfBgNI41K2G
	mjo+Zrm5Vy2wC22nDcyeH+iFEQtVtd1V0DkN8ZXReXtfj61w8j5L2DQHEEmZIeqAW1NrPfTQdJ0
	P8IryNyTXeikeADSgocrEKwVIsjLwlsQeyq/n3HktfUhA0Drg+tuIdhFYVBODhr6ze/OqtIPxii
	m1CeZ0C/FI7RXP0sgsabalhh/QIdpbFPx3VhH/JEcXQ==
X-Google-Smtp-Source: AGHT+IFkrVts+bEEPUp4BBAtLVZPot/aA/9X0oPRBOSSiEtVNiKU2TRV736+tfIKnO29f0u+64AR8w==
X-Received: by 2002:a05:600c:a08e:b0:43c:fa24:873e with SMTP id 5b1f17b1804b1-45201391375mr39843995e9.13.1749219646003;
        Fri, 06 Jun 2025 07:20:46 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213754973sm25686345e9.35.2025.06.06.07.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:20:45 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 06 Jun 2025 16:19:22 +0200
Subject: [PATCH v9 7/7] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-wip-bl-ad7606-calibration-v9-7-6e014a1f92a2@baylibre.com>
References: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
In-Reply-To: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5283;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=IKWt2EvUAc6fFAR+GqaSzL5Mis4xCa3ugoUhm+8Psbg=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshw+vHs2gXb+MPrOrytJjwNkI28X7Y0uLH1//aN7De9i
 s4JPZvN1VHKwiDGxSArpshSlxhhEno7VEp5AeNsmDmsTCBDGLg4BWAiDy4zMtxgt1teuLT3rqGu
 9Zrtq5u+T3mRsjCj5NCuAl824/A3Ux4w/NPRap+vuKLnh0zcy9Dv1YZKcTXu/Gdeiqr2VXotf5R
 2kwMA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support, using resistor values set on devicetree,
values to be set accordingly with ADC external RFilter, as explained in
the ad7606c-16 datasheet, rev0, page 37.

Usage example in the fdt yaml documentation.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d19682186e7cd73a60541f62adf08d987ba24ec3..d9271894f091a837d29197f7de892c022b7e4152 100644
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
@@ -180,6 +184,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_avail = true,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606b_calib_phase_avail,
 };
@@ -195,6 +200,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_avail = true,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -246,6 +252,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_avail = true,
 	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -306,6 +313,7 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 				  bool *bipolar, bool *differential)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_info *ci;
 	unsigned int num_channels = st->chip_info->num_adc_channels;
 	struct device *dev = st->dev;
 	int ret;
@@ -349,6 +357,14 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 			return -EINVAL;
 		}
 
+		ci = &st->chan_info[reg - 1];
+
+		ci->r_gain = 0;
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &ci->r_gain);
+		if (ret == 0 && ci->r_gain > AD7606_CALIB_GAIN_MAX)
+			return -EINVAL;
+
 		return 0;
 	}
 
@@ -1352,6 +1368,23 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
 	return st->bops->sw_mode_config(indio_dev);
 }
 
+static int ad7606_set_gain_calib(struct ad7606_state *st)
+{
+	struct ad7606_chan_info *ci;
+	int i, ret;
+
+	for (i = 0; i < st->chip_info->num_adc_channels; i++) {
+		ci = &st->chan_info[i];
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(i),
+					  DIV_ROUND_CLOSEST(ci->r_gain,
+						AD7606_CALIB_GAIN_STEP));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ad7606_probe_channels(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -1630,6 +1663,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		st->chip_info->sw_setup_cb(indio_dev);
 	}
 
+	if (st->sw_mode_en && st->chip_info->calib_gain_avail) {
+		ret = ad7606_set_gain_calib(st);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 26db8e3c724f47f68b7d5323f5d1db75b3334540..2951bb731354d64cbec6e8460b3d841a22bb17ec 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -66,6 +66,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  * @offload_storagebits: storage bits used by the offload hw implementation
+ * @calib_gain_avail:   chip supports gain calibration
  * @calib_offset_avail: pointer to offset calibration range/limits array
  * @calib_phase_avail:  pointer to phase calibration range/limits array
  */
@@ -81,6 +82,7 @@ struct ad7606_chip_info {
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
 	u8				offload_storagebits;
+	bool				calib_gain_avail;
 	const int			*calib_offset_avail;
 	const int			(*calib_phase_avail)[2];
 };
@@ -92,6 +94,8 @@ struct ad7606_chip_info {
  * @range:		voltage range selection, selects which scale to apply
  * @reg_offset:		offset for the register value, to be applied when
  *			writing the value of 'range' to the register value
+ * @r_gain:		gain resistor value in ohms, to be set to match the
+ *                      external r_filter value
  */
 struct ad7606_chan_info {
 #define AD760X_MAX_SCALES		16
@@ -99,6 +103,7 @@ struct ad7606_chan_info {
 	unsigned int			num_scales;
 	unsigned int			range;
 	unsigned int			reg_offset;
+	unsigned int			r_gain;
 };
 
 /**

-- 
2.49.0


