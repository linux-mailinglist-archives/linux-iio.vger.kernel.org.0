Return-Path: <linux-iio+bounces-10335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473569953A1
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC52B2418E
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED91E0DFE;
	Tue,  8 Oct 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SbpmhLga"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616C1E0B6F
	for <linux-iio@vger.kernel.org>; Tue,  8 Oct 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402308; cv=none; b=cfJGrklJiEmuFTezLhFFEXk9huN1tbGnCgVpZWsWm0NunEyuH20AkXGm24OfP0LFqKkQeHh1FWBiBPbCMGiy+vF/uSkKqZM0srSrEOvUM1YqTfSjWn0Zt21RW8nMhItqFFlU8jaPM2oqtmC7ypz6JmxLh2Iah1khSQepc4Lq5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402308; c=relaxed/simple;
	bh=0qr+o+mhg975gtIK8X+2WURcWLrr8by7BdhQXzHn5bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GViqAl9cmYFc6lxME/6W4Ggr8Krn0jfyH+6x+GOvkVjbBRnfKzEAqS9hAo5BfOsyteCZi89UghxJw8xxjjobD9kgRiKXEk8F0XTse3vqpG62Pd5Q+v6btrjNNcyBDzk/ws8dV2hugyL2RvsV3u11slkURpFO5pxB2Zf8w1WYQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SbpmhLga; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cc8782869so59417685e9.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2024 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728402304; x=1729007104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAiT8Yfxmo21Z9UKqBEM0v2ua17U/kHDqkRDha1Ll1I=;
        b=SbpmhLga/lfWlYvCY/Xh0u+Upaqsobhxuw14f9KoD0dJiXS/ZIy2DSZhvna8MndFWS
         Q7Gtyzz6LyWUXqy6wWvLnhypLR6cN2ZkP4LIym02Yw0ihignaaYVF0rMFyRqBYkJPtbr
         laFbdwZhvMBrH25OeTdJKm3ahIQZqRjxMa0KzFJOT/qFaJLVU/QGHcwJof5Ng4nSc669
         fhm7G6rxBboRgOfpCNLLuoafn3v4HQhoJgxsIaZz4atfC+Id1Cdfy+fZjIUNhn4gTwFx
         oZFkk0AhZkOpShzK0qTu2H/sYYLfnE3J18KeQU1MhEiTP0565vN+kgGDUsxWrWJ/qRo6
         6HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402304; x=1729007104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAiT8Yfxmo21Z9UKqBEM0v2ua17U/kHDqkRDha1Ll1I=;
        b=WCl6zhD99pEvJjqgDpsjHjqy23YmwRZaPve62nzbfAL+20WhuYuAP7qF8gOq/0Ev8V
         osOONTtJEy+Xr6Q1vGA7px4JtGs5EHS0HYtIl3oSW0Yoq3LnqfH0Px+fuAQ3UwR1jpC6
         /PfEWFtrte8cDrv94X7PKgPlVsFczcKFlJnKGWDshs1Qmemuslmg8BlysbVep8bqlyBx
         l4xylrxpnVcNf7ZmUl11UuynVe66YtotU2phFNpdhNa1Lv4CPdeM3BKhkvQZ53LTNgX4
         iDs/cZgTgWzMXd5lvgo1vlchbT5cN+kPtJx8+1w3xEh2NB2FH7eAJ8pNp4QEqwrZpC78
         rw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAJMLNtBJhcD6ViqUL4maxcJWC1/XoY4n0BNx78+Y7GvD80x303w4Tm/w/AypIIMwC9xWFFMBe/wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtsDu742bUh3bmsyWFXu3Ul89PPZ7RA7y0ydH9zn6f7PF1NOJ
	dJPG/1A/E+LWhiN6btmj406JToB1FAvh100HhYSXebBqlxo2cnTjJ/TiJex10Hk=
X-Google-Smtp-Source: AGHT+IE99hMLk0JH4HcDxA0SCwR4PIuO6uvL/Ws+oCwtZs3Y8QwWi3yEo9stJ8JTBJyjkQ0//+nT7w==
X-Received: by 2002:a05:600c:468b:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-42f85ab6a7fmr134787185e9.16.1728402304031;
        Tue, 08 Oct 2024 08:45:04 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d826sm129591215e9.26.2024.10.08.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:45:02 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Oct 2024 17:43:34 +0200
Subject: [PATCH v5 02/10] iio: dac: adi-axi-dac: update register names
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-2-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dletchner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Non functional, readability change.

Update register names so that register bitfields can be more easily
linked to the register name.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 137 +++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index b8b4171b8043..04193a98616e 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -35,35 +35,37 @@
  */
 
 /* Base controls */
-#define AXI_DAC_REG_CONFIG		0x0c
-#define	   AXI_DDS_DISABLE		BIT(6)
+#define AXI_DAC_CONFIG_REG			0x0c
+#define   AXI_DAC_CONFIG_DDS_DISABLE		BIT(6)
 
  /* DAC controls */
-#define AXI_DAC_REG_RSTN		0x0040
-#define   AXI_DAC_RSTN_CE_N		BIT(2)
-#define   AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
-#define   AXI_DAC_RSTN_RSTN		BIT(0)
-#define AXI_DAC_REG_CNTRL_1		0x0044
-#define   AXI_DAC_SYNC			BIT(0)
-#define AXI_DAC_REG_CNTRL_2		0x0048
-#define	  ADI_DAC_R1_MODE		BIT(5)
-#define AXI_DAC_DRP_STATUS		0x0074
-#define   AXI_DAC_DRP_LOCKED		BIT(17)
+#define AXI_DAC_RSTN_REG			0x0040
+#define   AXI_DAC_RSTN_CE_N			BIT(2)
+#define   AXI_DAC_RSTN_MMCM_RSTN		BIT(1)
+#define   AXI_DAC_RSTN_RSTN			BIT(0)
+#define AXI_DAC_CNTRL_1_REG			0x0044
+#define   AXI_DAC_CNTRL_1_SYNC			BIT(0)
+#define AXI_DAC_CNTRL_2_REG			0x0048
+#define   ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
+#define AXI_DAC_DRP_STATUS_REG			0x0074
+#define   AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
+
 /* DAC Channel controls */
-#define AXI_DAC_REG_CHAN_CNTRL_1(c)	(0x0400 + (c) * 0x40)
-#define AXI_DAC_REG_CHAN_CNTRL_3(c)	(0x0408 + (c) * 0x40)
-#define   AXI_DAC_SCALE_SIGN		BIT(15)
-#define   AXI_DAC_SCALE_INT		BIT(14)
-#define   AXI_DAC_SCALE			GENMASK(14, 0)
-#define AXI_DAC_REG_CHAN_CNTRL_2(c)	(0x0404 + (c) * 0x40)
-#define AXI_DAC_REG_CHAN_CNTRL_4(c)	(0x040c + (c) * 0x40)
-#define   AXI_DAC_PHASE			GENMASK(31, 16)
-#define   AXI_DAC_FREQUENCY		GENMASK(15, 0)
-#define AXI_DAC_REG_CHAN_CNTRL_7(c)	(0x0418 + (c) * 0x40)
-#define   AXI_DAC_DATA_SEL		GENMASK(3, 0)
+#define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
+#define AXI_DAC_CHAN_CNTRL_3_REG(c)		(0x0408 + (c) * 0x40)
+#define   AXI_DAC_CHAN_CNTRL_3_SCALE_SIGN	BIT(15)
+#define   AXI_DAC_CHAN_CNTRL_3_SCALE_INT	BIT(14)
+#define   AXI_DAC_CHAN_CNTRL_3_SCALE		GENMASK(14, 0)
+#define AXI_DAC_CHAN_CNTRL_2_REG(c)		(0x0404 + (c) * 0x40)
+#define   AXI_DAC_CHAN_CNTRL_2_PHASE		GENMASK(31, 16)
+#define   AXI_DAC_CHAN_CNTRL_2_FREQUENCY	GENMASK(15, 0)
+#define AXI_DAC_CHAN_CNTRL_4_REG(c)		(0x040c + (c) * 0x40)
+#define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
+#define   AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
 
 /* 360 degrees in rad */
-#define AXI_DAC_2_PI_MEGA		6283190
+#define AXI_DAC_2_PI_MEGA			6283190
+
 enum {
 	AXI_DAC_DATA_INTERNAL_TONE,
 	AXI_DAC_DATA_DMA = 2,
@@ -89,7 +91,7 @@ static int axi_dac_enable(struct iio_backend *back)
 	int ret;
 
 	guard(mutex)(&st->lock);
-	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_RSTN,
+	ret = regmap_set_bits(st->regmap, AXI_DAC_RSTN_REG,
 			      AXI_DAC_RSTN_MMCM_RSTN);
 	if (ret)
 		return ret;
@@ -98,12 +100,14 @@ static int axi_dac_enable(struct iio_backend *back)
 	 * designs really use it but if they don't we still get the lock bit
 	 * set. So let's do it all the time so the code is generic.
 	 */
-	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_DRP_STATUS, __val,
-				       __val & AXI_DAC_DRP_LOCKED, 100, 1000);
+	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_DRP_STATUS_REG,
+				       __val,
+				       __val & AXI_DAC_DRP_STATUS_DRP_LOCKED,
+				       100, 1000);
 	if (ret)
 		return ret;
 
-	return regmap_set_bits(st->regmap, AXI_DAC_REG_RSTN,
+	return regmap_set_bits(st->regmap, AXI_DAC_RSTN_REG,
 			       AXI_DAC_RSTN_RSTN | AXI_DAC_RSTN_MMCM_RSTN);
 }
 
@@ -112,7 +116,7 @@ static void axi_dac_disable(struct iio_backend *back)
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 
 	guard(mutex)(&st->lock);
-	regmap_write(st->regmap, AXI_DAC_REG_RSTN, 0);
+	regmap_write(st->regmap, AXI_DAC_RSTN_REG, 0);
 }
 
 static struct iio_buffer *axi_dac_request_buffer(struct iio_backend *back,
@@ -155,15 +159,15 @@ static int __axi_dac_frequency_get(struct axi_dac_state *st, unsigned int chan,
 	}
 
 	if (tone_2)
-		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan);
+		reg = AXI_DAC_CHAN_CNTRL_4_REG(chan);
 	else
-		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan);
+		reg = AXI_DAC_CHAN_CNTRL_2_REG(chan);
 
 	ret = regmap_read(st->regmap, reg, &raw);
 	if (ret)
 		return ret;
 
-	raw = FIELD_GET(AXI_DAC_FREQUENCY, raw);
+	raw = FIELD_GET(AXI_DAC_CHAN_CNTRL_2_FREQUENCY, raw);
 	*freq = DIV_ROUND_CLOSEST_ULL(raw * st->dac_clk, BIT(16));
 
 	return 0;
@@ -194,17 +198,18 @@ static int axi_dac_scale_get(struct axi_dac_state *st,
 	u32 reg, raw;
 
 	if (tone_2)
-		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_3_REG(chan->channel);
 	else
-		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_1_REG(chan->channel);
 
 	ret = regmap_read(st->regmap, reg, &raw);
 	if (ret)
 		return ret;
 
-	sign = FIELD_GET(AXI_DAC_SCALE_SIGN, raw);
-	raw = FIELD_GET(AXI_DAC_SCALE, raw);
-	scale = DIV_ROUND_CLOSEST_ULL((u64)raw * MEGA, AXI_DAC_SCALE_INT);
+	sign = FIELD_GET(AXI_DAC_CHAN_CNTRL_3_SCALE_SIGN, raw);
+	raw = FIELD_GET(AXI_DAC_CHAN_CNTRL_3_SCALE, raw);
+	scale = DIV_ROUND_CLOSEST_ULL((u64)raw * MEGA,
+				      AXI_DAC_CHAN_CNTRL_3_SCALE_INT);
 
 	vals[0] = scale / MEGA;
 	vals[1] = scale % MEGA;
@@ -227,15 +232,15 @@ static int axi_dac_phase_get(struct axi_dac_state *st,
 	int ret, vals[2];
 
 	if (tone_2)
-		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_4_REG(chan->channel);
 	else
-		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_2_REG(chan->channel);
 
 	ret = regmap_read(st->regmap, reg, &raw);
 	if (ret)
 		return ret;
 
-	raw = FIELD_GET(AXI_DAC_PHASE, raw);
+	raw = FIELD_GET(AXI_DAC_CHAN_CNTRL_2_PHASE, raw);
 	phase = DIV_ROUND_CLOSEST_ULL((u64)raw * AXI_DAC_2_PI_MEGA, U16_MAX);
 
 	vals[0] = phase / MEGA;
@@ -260,18 +265,20 @@ static int __axi_dac_frequency_set(struct axi_dac_state *st, unsigned int chan,
 	}
 
 	if (tone_2)
-		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan);
+		reg = AXI_DAC_CHAN_CNTRL_4_REG(chan);
 	else
-		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan);
+		reg = AXI_DAC_CHAN_CNTRL_2_REG(chan);
 
 	raw = DIV64_U64_ROUND_CLOSEST((u64)freq * BIT(16), sample_rate);
 
-	ret = regmap_update_bits(st->regmap,  reg, AXI_DAC_FREQUENCY, raw);
+	ret = regmap_update_bits(st->regmap, reg,
+				 AXI_DAC_CHAN_CNTRL_2_FREQUENCY, raw);
 	if (ret)
 		return ret;
 
 	/* synchronize channels */
-	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+	return regmap_set_bits(st->regmap, AXI_DAC_CNTRL_1_REG,
+			       AXI_DAC_CNTRL_1_SYNC);
 }
 
 static int axi_dac_frequency_set(struct axi_dac_state *st,
@@ -312,16 +319,16 @@ static int axi_dac_scale_set(struct axi_dac_state *st,
 
 	/*  format is 1.1.14 (sign, integer and fractional bits) */
 	if (scale < 0) {
-		raw = FIELD_PREP(AXI_DAC_SCALE_SIGN, 1);
+		raw = FIELD_PREP(AXI_DAC_CHAN_CNTRL_3_SCALE_SIGN, 1);
 		scale *= -1;
 	}
 
-	raw |= div_u64((u64)scale * AXI_DAC_SCALE_INT, MEGA);
+	raw |= div_u64((u64)scale * AXI_DAC_CHAN_CNTRL_3_SCALE_INT, MEGA);
 
 	if (tone_2)
-		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_3_REG(chan->channel);
 	else
-		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_1_REG(chan->channel);
 
 	guard(mutex)(&st->lock);
 	ret = regmap_write(st->regmap, reg, raw);
@@ -329,7 +336,8 @@ static int axi_dac_scale_set(struct axi_dac_state *st,
 		return ret;
 
 	/* synchronize channels */
-	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+	ret = regmap_set_bits(st->regmap, AXI_DAC_CNTRL_1_REG,
+			      AXI_DAC_CNTRL_1_SYNC);
 	if (ret)
 		return ret;
 
@@ -355,18 +363,19 @@ static int axi_dac_phase_set(struct axi_dac_state *st,
 	raw = DIV_ROUND_CLOSEST_ULL((u64)phase * U16_MAX, AXI_DAC_2_PI_MEGA);
 
 	if (tone_2)
-		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_4_REG(chan->channel);
 	else
-		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+		reg = AXI_DAC_CHAN_CNTRL_2_REG(chan->channel);
 
 	guard(mutex)(&st->lock);
-	ret = regmap_update_bits(st->regmap, reg, AXI_DAC_PHASE,
-				 FIELD_PREP(AXI_DAC_PHASE, raw));
+	ret = regmap_update_bits(st->regmap, reg, AXI_DAC_CHAN_CNTRL_2_PHASE,
+				 FIELD_PREP(AXI_DAC_CHAN_CNTRL_2_PHASE, raw));
 	if (ret)
 		return ret;
 
 	/* synchronize channels */
-	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+	ret = regmap_set_bits(st->regmap, AXI_DAC_CNTRL_1_REG,
+			      AXI_DAC_CNTRL_1_SYNC);
 	if (ret)
 		return ret;
 
@@ -437,7 +446,7 @@ static int axi_dac_extend_chan(struct iio_backend *back,
 
 	if (chan->type != IIO_ALTVOLTAGE)
 		return -EINVAL;
-	if (st->reg_config & AXI_DDS_DISABLE)
+	if (st->reg_config & AXI_DAC_CONFIG_DDS_DISABLE)
 		/* nothing to extend */
 		return 0;
 
@@ -454,13 +463,14 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 	switch (data) {
 	case IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE:
 		return regmap_update_bits(st->regmap,
-					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
-					  AXI_DAC_DATA_SEL,
+					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
+					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
 					  AXI_DAC_DATA_INTERNAL_TONE);
 	case IIO_BACKEND_EXTERNAL:
 		return regmap_update_bits(st->regmap,
-					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
-					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
+					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
+					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
+					  AXI_DAC_DATA_DMA);
 	default:
 		return -EINVAL;
 	}
@@ -475,7 +485,7 @@ static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 
 	if (!sample_rate)
 		return -EINVAL;
-	if (st->reg_config & AXI_DDS_DISABLE)
+	if (st->reg_config & AXI_DAC_CONFIG_DDS_DISABLE)
 		/* sample_rate has no meaning if DDS is disabled */
 		return 0;
 
@@ -580,7 +590,7 @@ static int axi_dac_probe(struct platform_device *pdev)
 	 * Force disable the core. Up to the frontend to enable us. And we can
 	 * still read/write registers...
 	 */
-	ret = regmap_write(st->regmap, AXI_DAC_REG_RSTN, 0);
+	ret = regmap_write(st->regmap, AXI_DAC_RSTN_REG, 0);
 	if (ret)
 		return ret;
 
@@ -601,7 +611,7 @@ static int axi_dac_probe(struct platform_device *pdev)
 	}
 
 	/* Let's get the core read only configuration */
-	ret = regmap_read(st->regmap, AXI_DAC_REG_CONFIG, &st->reg_config);
+	ret = regmap_read(st->regmap, AXI_DAC_CONFIG_REG, &st->reg_config);
 	if (ret)
 		return ret;
 
@@ -613,7 +623,8 @@ static int axi_dac_probe(struct platform_device *pdev)
 	 * want independent channels let's override the core's default value and
 	 * set the R1_MODE bit.
 	 */
-	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2, ADI_DAC_R1_MODE);
+	ret = regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
+			      ADI_DAC_CNTRL_2_R1_MODE);
 	if (ret)
 		return ret;
 

-- 
2.45.0.rc1


