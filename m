Return-Path: <linux-iio+bounces-18992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E6AA73B5
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F871C071F6
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C17253938;
	Fri,  2 May 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hxIacMxR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB02255F5C
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192507; cv=none; b=EE8U+4Vq6eCxpbAXPKUij47hKknDYswo/oY6I2bjItOSWbwqV6X97+UfRqoOkpBXjqJpMlwAH3h6DH9s+oSJj+ibOeqELM2c5WZtxx/Pq8HWszeSsxytFUJHOVRIEuiUDDO/3J6NgEu32S9JeLtL/6i6qCYhOV86Mufle8ofdCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192507; c=relaxed/simple;
	bh=/r8suY1Up2Qw3JiT04uRdtjQsRncn+ol5tkKKKi4YvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTYTHyRJGe9zIR0OTauHgNsRjwjqB8t5qGUtnWBdizZ9oUoq1aNxWNrWRtcRVYYxk9xNY+qsa23hoan0jjvJ7wMXK3wQ4viIduuPVASukOLwmMWFRzC8vxAhFltAbeaaah3o8xNMD80MGNVIedS9ALlimBIBsQcA/+lCyWneF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hxIacMxR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so12266475e9.1
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746192502; x=1746797302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RB+4ADJTBxuxoLrq2q5axLDiDnl84yPV2iN1+Z+zwY=;
        b=hxIacMxRcQs3BG72JPMQqyii5EI/e6GYhTDv1A2ma+k8Uec6HiAp9E+/1Pa/qaCFcl
         bvEHDhTMYUcoo8jhtn6RsUP70iL0kPdTMFKGTc67m/9lR95nW03w2vPQQyl06V8VRAVD
         kVWXcA31sMt2vPc/1fUSXfjXhxw4J1pcnB1OLzSdFnPRsLVrTc7sFzFRrQ6q3+8A/OXP
         l+gbuPwznwVNbYjM222L/HFm+vkj9+bcg7ghhZDc42IB1Pbg3SUc9MXG0AD2VtM9Yddv
         zA71J5J5OzApLBa/hzRmEiAWs9FMGkDeaX6OZumTnnRgwPnS/VX6vkbcodVPuG6ZeIZO
         hdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192502; x=1746797302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RB+4ADJTBxuxoLrq2q5axLDiDnl84yPV2iN1+Z+zwY=;
        b=i4zAZDI6/CvIlcjusHNR8PY+tig1MSq4gS6oZ5HuYTKtiPNZiru7UNX2zFdY8B/ztz
         MIWzpa3CTcEiUsMpbNC4L1SU5Fb3NS51WDYRWlZKUOLUlJWKGe9m/JMoAGDAyfeJ6XCq
         n0vXQIQr90QOvKGOYLzzSA1Lrjv7mPW5sWz7DVqxZ0G0VPf7NM7RKbDueBLviBD9/xGr
         rcaD1ZEMf/MsJyT1TvOCPgqZpM49m6ROI5X+RCm0paVl0JYgiy34JL8voGYpF1vYAqSz
         cZg3xWZeqKGLQeFVZOZde96Yo59PCup1UYgEWJoLhQxcoGKLG5PJJlcaxpTN7FFCKI8O
         OYWQ==
X-Gm-Message-State: AOJu0YyNOXGuRj52LpWGwHvHyQV8egXeZgHDIy8juyiBnX6Pe4clEstL
	f83b3dPVEdUw2uC1wZzv9kB2speOhRcNJ5wL6k6uk94sCtutf0jvI0PeC3UNY7M=
X-Gm-Gg: ASbGncumqQ7yPUla7LWkZwKUNwVTqPxCbsP6wDY29zco9rcTFa2a02hc8P+6vRwSTdA
	2+JZ8r41/zniUpgglofP/F+q9v3YmGDN1oIaMDE4bDH7LjOixgbcbxpikXSQN293UCN4bAdO1sH
	Rnu1TjlSunB9V+8ePTF8RVSQKMvl1kC3Ww9y9xL7QhCJGLTw/05cmpJSU8ZFLGrM9CzAZEvxvCn
	1RKMOF3HaS+xbx7yx6QD3vtljaKxEEgJcgPQifyg7RGzqm+hkH5/i8r1w/X6e7Eutlw7UYY1L5L
	GsfkeSETep1BdiEiunYtBKalo8FCbv1MSCdS0e7KED9Q
X-Google-Smtp-Source: AGHT+IEgIlcfMb/XuKwOYfgMGDYSXZQ5POyf/PBHKjynVwRRRgEBI6ighVhqJv33JiCr+mBDdnCeZw==
X-Received: by 2002:a05:600c:4fc9:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-441bbedb54emr29454945e9.16.1746192502497;
        Fri, 02 May 2025 06:28:22 -0700 (PDT)
Received: from [192.168.0.2] ([87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc50esm45761065e9.8.2025.05.02.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 06:28:22 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 02 May 2025 15:27:02 +0200
Subject: [PATCH v2 5/5] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-wip-bl-ad7606-calibration-v2-5-174bd0af081b@baylibre.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5681;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=vqrUpAxX+9UwYDkass8KUvKkJQRsyw1vKSCquKwrjPg=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgQOaGeIrHou0jJxfBkGdabri3MKdcclXfeFsx7wWp3d
 uu2up2MHaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACaSXMjwh+OlyhGPE+olVkpZ
 S7KbnumenOwyz4WH2WPej406Bxzj3zH84XHz4J63t0kiUYhj5bH5Bzh5N7RyTIwyOLM14kNUndF
 7dgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support, using resistor values set on devicetree,
values to be set accordingly with ADC external RFilter, as explained in
the ad7606c-16 datasheet, rev0, page 37.

Usage example in the fdt yaml documentation.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  4 ++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 139d8b3f9bb39dd631a71c70539005d719fb5b7b..a167f080e89c8a8d8accaff5904cce31d860edf9 100644
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
@@ -357,6 +366,50 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
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
+		if (ret == -EINVAL)
+			/* Keep the default register value. */
+			continue;
+		if (ret)
+			return ret;
+
+		if (r_gain < AD7606_CALIB_GAIN_MIN ||
+		    r_gain > AD7606_CALIB_GAIN_MAX)
+			return dev_err_probe(st->dev, -EINVAL,
+					     "wrong gain calibration value.");
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
@@ -1410,6 +1463,10 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 				chan->info_mask_separate_available |=
 					BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					BIT(IIO_CHAN_INFO_CALIBCONV_DELAY);
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


