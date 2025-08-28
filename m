Return-Path: <linux-iio+bounces-23343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78812B3AD13
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 23:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB6E984958
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 21:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBA2D24A2;
	Thu, 28 Aug 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Y+kZ0NC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3602C2347
	for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418136; cv=none; b=KI6fDo4e+/asKFqJCJRM95fN1H/MO3FyoqLxF0uzTk9L54OjLRQ6hvSr9X3F/43hPkJV8NmO+jbA9+BH1zplB1ajEXDPYFJHYRxbscqjZTlgY5twkuEX6CyvXJvirup03D1hm5Pux1r9pbk+cXOT5JybuycAKgezZvNsAts5ZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418136; c=relaxed/simple;
	bh=iyU3X95Wd4NFFnFtBbT4O/SevwCrMEuEm8iJQpnTre8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRNa7M1uL0asCuNiZxeWP966AFZazKF6Bm67qlSt/ZY3Q9jxdv+V3CkyTFJ7nv90M09HKniY+bxp3QY8TevnGLOnE7lAlJ3QTWMhE67uG7x7q93R0F+UsUHuOKvsFM7lrz/81M6/Mr+r4Q/ln54rhQ7a9w3aSPHCxnBZ3hL0HDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0Y+kZ0NC; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74557b76fbeso247507a34.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756418133; x=1757022933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIc3YN+iHIFUqitCd++6zBoGorJA6lxwEwz/tSMv5wQ=;
        b=0Y+kZ0NCWAMci/hXqkmvdMCan/sAm9tvNVLNFgMGN/dgnhvQ71FgtL4N4qiY2IvLjK
         MAtpchHu01nQPvx8twKQeUd/3P58oEggkEmtB/Q8o4lPkEzqQyZe4XgS0uc+FjPIy+cU
         yxfn6a3fWkq3/2TxETZZGHEyAX90tdpkZwDP/g3hSFDUJiEW5+dLUn7Grvg+XFGAaYoP
         eg+4ZJSEwZVVpztILiVAp4XiIK64kB+GEd4Iyy/o5bcMr/nj044kdNSu1PdOt7/mm5Wx
         BNDJIar/dWvKx7yNn3kL8ha0VOchEpTJSewfzBIh73PANwHSykCzN9lsrHD/+dOOq6g0
         45Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756418133; x=1757022933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIc3YN+iHIFUqitCd++6zBoGorJA6lxwEwz/tSMv5wQ=;
        b=DgdXwvjK8FAgb5cjbZmHE4KJK6th+bNdB192y9zoiUQXa6X92Yhg9gLWpnbmavryEg
         QJmyJxQzaNchY6YmeyqAwcfuTf54Tog/ixFHuLVg35LjCl2mcNp8d87Ab2PJe2FDBhq+
         ubRD/7iEXi0CRbUrXni56Yz/tkHVNKfAhwd/XvihNNQHM1ivZzf7ZB0cKm5jca2KD38U
         CIrXdCW4BgF4Z9WB1wl9B4ix15W3CYfkJTkJXbxkR42Rb3jSoHuB8ntB3REMuCnQe3w6
         Y1/jl4da351DUIJdaTCt9C7PcdqQSmg2WGGY13B5iO/tzI6sMIXfrYfQ4SOlD3jFgyEP
         ntQw==
X-Gm-Message-State: AOJu0YyXvMuD+Xg5qdCE/pQu6EzrO1z7reumdJY17vEpQpx4KWSCWt1I
	d2FpuBDEb5+yc+8OpnInS4ioKZqjE3HdO4DsHTnuZhaFtSNP98Hv+R3wXsSrpIo1Te4=
X-Gm-Gg: ASbGncucLQG2hvZkUSIexvVCibce3U8YF5bynTTBG+G4XAPy2h4TPpenf4q4lH5/O8A
	mj30V6nCDaMwH88K0G1r1z1+DntzO/fI0hQm5yVVybs/vD/FNliXv5/4zeWHZvqha4huTC3taU9
	PZZtF6d8RtqsP2RNzRcXS+nltsl7qQ5nP2KWriE3Mg6NhDMwgk+yc8/DDZBeU9ML7f4L8VhkFYr
	CaclknanPj4EhIwl2GuZxk8oC4m6ApSVDgeFAsdyn9ONMztvrDG8/7gvQk+qmi9DX2pZ7YbwwAf
	7VODku60CVbktmq8DK+Cmt50USfco6AAfpUWKpL7RUnnrOhSWyu71DeyvrhbVw1PYcgjmkpLscz
	EOEpMyMP1eK4hDLRM6V3prAJfmaEY
X-Google-Smtp-Source: AGHT+IEYeN5vhpMVp/2uSffquZRWxPUGVpD8Y7ACkIDSxz/pxR79JdeglMFY9WcJefj2t68qdDpm4Q==
X-Received: by 2002:a05:6830:6084:b0:742:fd81:30aa with SMTP id 46e09a7af769-745008fd4f6mr13986440a34.2.1756418133349;
        Thu, 28 Aug 2025 14:55:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:aa84:2d2c:f28c:4102])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7455853804asm136084a34.33.2025.08.28.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:55:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 28 Aug 2025 16:54:54 -0500
Subject: [PATCH v3 3/4] iio: adc: ad7124: add external clock support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-iio-adc-ad7124-proper-clock-support-v3-3-0b317b4605e5@baylibre.com>
References: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
In-Reply-To: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5291; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=iyU3X95Wd4NFFnFtBbT4O/SevwCrMEuEm8iJQpnTre8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBosNBDaKwsAMrA7ZjCJTq1l0ttheirctpj3//Bv
 7WHBtWTjcmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLDQQwAKCRDCzCAB/wGP
 wB9cB/4/zb6FQIhQRso7RSuzcF2hxM3AmcqkGgcNEZLvo6MFf78d1zvnaJZdugY2g9oiZSE6FF1
 KfaYZ+mUNEVWf4BQ38RndNBDtGgf2Vn1/DjRgssG6qMrQA8GPUFe0PENecgQoGvFc09BlhKmRYy
 CD0XW58ln8bVsQ2BRzaF9eeWBhL+BjVZC/zIC74U3kvKGMeDWV30LQiGVZ5mi6A3b39SsY/3LGI
 rTr9TuWCqvmMFN+NKu860WRriNQzAUW9aZWjxOf2fBnyo7LXWdA9s6kHVFwf45YfqDGN0ycywKe
 IkTEF05LDk3grLzWL6LbfRphtpjoSUJYxWFqVSD/MEpim1mu
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for an external clock source to the AD7124 ADC driver.

Previously, the driver only supported using the internal clock and had
bad devicetree bindings that used a fake clock to essentially select
the power mode. This is preserved for backwards compatibility.

If the clock is not named "mclk", then we know that the devicetree is
using the correct bindings and we can configure the chip to use an
external clock source rather than internal.

Also drop a redundant comment when configuring the register fields
instead of adding more.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 83 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 49003c8436463f49a47564644fd8e405579df829..eb5b2028dfad0f62145edff13a24e824b05e0c13 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -18,6 +18,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
@@ -44,6 +45,11 @@
 #define AD7124_STATUS_POR_FLAG			BIT(4)
 
 /* AD7124_ADC_CONTROL */
+#define AD7124_ADC_CONTROL_CLK_SEL		GENMASK(1, 0)
+#define AD7124_ADC_CONTROL_CLK_SEL_INT			0
+#define AD7124_ADC_CONTROL_CLK_SEL_INT_OUT		1
+#define AD7124_ADC_CONTROL_CLK_SEL_EXT			2
+#define AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4		3
 #define AD7124_ADC_CONTROL_MODE			GENMASK(5, 2)
 #define AD7124_ADC_CONTROL_MODE_CONTINUOUS		0
 #define AD7124_ADC_CONTROL_MODE_SINGLE			1
@@ -92,6 +98,8 @@
 #define AD7124_MAX_CONFIGS	8
 #define AD7124_MAX_CHANNELS	16
 
+#define AD7124_INT_CLK_HZ	614400
+
 /* AD7124 input sources */
 
 enum ad7124_ref_sel {
@@ -120,9 +128,9 @@ static const unsigned int ad7124_reg_size[] = {
 };
 
 static const int ad7124_master_clk_freq_hz[3] = {
-	[AD7124_LOW_POWER] = 76800,
-	[AD7124_MID_POWER] = 153600,
-	[AD7124_FULL_POWER] = 614400,
+	[AD7124_LOW_POWER] = AD7124_INT_CLK_HZ / 8,
+	[AD7124_MID_POWER] = AD7124_INT_CLK_HZ / 4,
+	[AD7124_FULL_POWER] = AD7124_INT_CLK_HZ,
 };
 
 static const char * const ad7124_ref_names[] = {
@@ -174,6 +182,7 @@ struct ad7124_state {
 	struct ad_sigma_delta sd;
 	struct ad7124_channel *channels;
 	struct regulator *vref[4];
+	u32 clk_hz;
 	unsigned int adc_control;
 	unsigned int num_channels;
 	struct mutex cfgs_lock; /* lock for configs access */
@@ -249,12 +258,33 @@ static int ad7124_set_mode(struct ad_sigma_delta *sd,
 	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
 }
 
+static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
+{
+	enum ad7124_power_mode power_mode;
+	u32 fclk_hz;
+
+	power_mode = FIELD_GET(AD7124_ADC_CONTROL_POWER_MODE, st->adc_control);
+	fclk_hz = st->clk_hz;
+
+	switch (power_mode) {
+	case AD7124_LOW_POWER:
+		fclk_hz /= 8;
+		break;
+	case AD7124_MID_POWER:
+		fclk_hz /= 4;
+		break;
+	default:
+		break;
+	}
+
+	return fclk_hz;
+}
+
 static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
 {
 	unsigned int fclk, odr_sel_bits;
 
-	fclk = ad7124_master_clk_freq_hz[FIELD_GET(AD7124_ADC_CONTROL_POWER_MODE,
-						   st->adc_control)];
+	fclk = ad7124_get_fclk_hz(st);
 
 	/*
 	 * FS[10:0] = fCLK / (fADC x 32) where:
@@ -1112,7 +1142,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 static int ad7124_setup(struct ad7124_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
-	unsigned int power_mode;
+	unsigned int power_mode, clk_sel;
 	struct clk *mclk;
 	int i, ret;
 
@@ -1156,9 +1186,48 @@ static int ad7124_setup(struct ad7124_state *st)
 				return dev_err_probe(dev, ret,
 						     "Failed to set mclk rate\n");
 		}
+
+		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
+		st->clk_hz = AD7124_INT_CLK_HZ;
+	} else {
+		struct clk *clk;
+
+		clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk),
+					     "Failed to get external clock\n");
+
+		if (clk) {
+			unsigned long clk_hz;
+
+			clk_hz = clk_get_rate(clk);
+			if (!clk_hz)
+				return dev_err_probe(dev, -EINVAL,
+					"Failed to get external clock rate\n");
+
+			/*
+			 * The external clock may be 4x the nominal clock rate,
+			 * in which case the ADC needs to be configured to
+			 * divide it by 4. Using MEGA is a bit arbitrary, but
+			 * the expected clock rates are either 614.4 kHz or
+			 * 2.4576 MHz, so this should work.
+			 */
+			if (clk_hz > MEGA) {
+				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT_DIV4;
+				st->clk_hz = clk_hz / 4;
+			} else {
+				clk_sel = AD7124_ADC_CONTROL_CLK_SEL_EXT;
+				st->clk_hz = clk_hz;
+			}
+		} else {
+			clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
+			st->clk_hz = AD7124_INT_CLK_HZ;
+		}
 	}
 
-	/* Set the power mode */
+	st->adc_control &= ~AD7124_ADC_CONTROL_CLK_SEL;
+	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_CLK_SEL, clk_sel);
+
 	st->adc_control &= ~AD7124_ADC_CONTROL_POWER_MODE;
 	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_POWER_MODE, power_mode);
 

-- 
2.43.0


