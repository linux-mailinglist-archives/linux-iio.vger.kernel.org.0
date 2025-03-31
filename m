Return-Path: <linux-iio+bounces-17487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A1A76D2F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 21:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6171188D268
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17951218AA3;
	Mon, 31 Mar 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="16yTkjXF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6A216E24
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447847; cv=none; b=FJC1qc2JWMhARnY0ijd5fJbJZ+6/uujnd+09++coShptBICTFfw9+13hdhTZOTDEot5HgOstpNltgGkkkoEBdRknjTbxZrMW/BRiBLk9Xzpqi0fwarB9IdL7ng8yvPoG6SQLeno8Ih17Tc2GtkK7DXakSLuLu6BJ7shrB5dX/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447847; c=relaxed/simple;
	bh=pCpjDjmBZOzK40k+vljZr2BliJA0xp91AOXjRWTRx0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjZ9pdqWEBtAmkzhqrAQPfVT3zHYcOEli8f/xsPywGs1fJJFmL7HjRkzmpaLAh9J0kLuq8zOS24TQ4O26LXXIeytrKyu+A2UfMLE2UECoq9fvPJJg8cWS9fBwxvxti/DJ0YeasABxvGySK2JpZqiBemjKtJQJM3MQdbj93URKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=16yTkjXF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso856489566b.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743447843; x=1744052643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOf9H7BQRbk9vcOFRZPDyvrAxaPKr+t8x7+lT2OYigQ=;
        b=16yTkjXFtBIglHFhdwmF0nFiytBdEPI/qZmziZNrDzLV3W7VYMuVe4NRLU+lQIqmyr
         CNJIAi3i2TXPlijRe2JUznrJvIUAz8rm4Ryeg8ZOPhVsnldQRKcoKw0WN/iGnolcFMrL
         9kn1zkS1hqHrAZaWOFeVzf5S/nvmoXxPQAu+cDbah41tJxvXonwzTFX5rshoi9YSaotO
         vYc5eAHBTtSWMTOJ6okijT/cT1Mynu+VuovodWMYzKFvJWoraDA5R3L5Yl11X0c2OWZ3
         P3DwvGjlnJl8qfN1kiYdL4fH13hxGk3eKfJXx+mj7TdaRF8mqjQaMmhABfPOQ/hDhLyE
         t4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447843; x=1744052643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOf9H7BQRbk9vcOFRZPDyvrAxaPKr+t8x7+lT2OYigQ=;
        b=fo089eq7J5z4Em3YBpTvBl6GPV21x8YtT1SbGgforoWSlO6ccepxrIhsWqIGu8cz6C
         G/MxSdtBzHFWeE7s66dghjEUBv7omv20d2cUGrViezlrT3FYCJ0/KRxum2GKSwagoxOy
         Aq1NeusaP4G7Zly0TGegYF/bHylIRAmYhVQSaiTekXZBKNEu/G0fewCo+WAnm642KVDt
         IWTIqM8ql2k66/4AIQECooItqwWXRyrYFN7zRE1b6D0+aY0kl0ROHTorIqHPcvHI5Pcr
         RkQvcNBUV3TSQkBASP1rrdViBdyr4ouPmtBRVmE6hLVXWlLvdB7LmlC7Xels7sILEhvo
         zBdw==
X-Gm-Message-State: AOJu0YxVMkufPq1PlCkgMrfiif9nG2NEF7py/nMADEQw3SMenkn5yMas
	/jiqlJFU+M8K7EkQzIWDpWbRnaNvcfq/prtV6UZBXqxzN3CMTQjDLbZTU8IPaQWBzR7BndVuR9g
	K
X-Gm-Gg: ASbGncvlOa1DbFzw/122zAF8bxm7sNjCX/Uwe+RBnrP+B4eyNXnq3FK4vPmflh1eO+v
	FFI24ngN7Vbiy5g6xETiWqjVfHz64OJnZOPJSzbDAgVuR6UasgyiyeaBhItK+1YqKv8OTPzP/ck
	gVHLfeaziInR4fKQY2boUgyt+hABzTHI9ZExAwIptQcVeB2jt4ibtYo6nNqlvuUcWGfAw6Q3Zrh
	T0zWI9NGVxLcT0OrLzDpb3vI1Fu8cle3fxQZ3Zw9cY0PX34FnXG2TVVA2wqJSSR6QMVLYhBINBX
	rZjGq9onwYpnjOpIYcfc3dXyTN+KQr1he9Tkb2JDgv7zvwK5cwYMqJpbcSaLGHIgP1uMYYjYhzd
	DSUDyNXLmhQO7GAwRUv2e1V8+ljjr
X-Google-Smtp-Source: AGHT+IEyejNkLxFRZGWHarGHeID4fM5LIi+a+hGbdyDsdvvbQ4mg/BhGzUVbVkgba/o0+UKlP4fIgg==
X-Received: by 2002:a17:907:6e90:b0:ac3:d1c:89ce with SMTP id a640c23a62f3a-ac7367700fbmr867755566b.9.1743447843171;
        Mon, 31 Mar 2025 12:04:03 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-172.pool80116.interbusiness.it. [80.116.51.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f9cfsm652288566b.122.2025.03.31.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:04:02 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 31 Mar 2025 21:02:44 +0200
Subject: [PATCH v2 1/5] iio: dac: adi-axi-dac: add cntrl chan check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-wip-bl-ad3552r-fixes-v2-1-cdedb430497e@baylibre.com>
References: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
In-Reply-To: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3048;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=LEhJ7d3UZmGONv0UbtL1XfLYWtYo9rliWEIHzqon6QA=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkh/9ezWxmP3Xs18uCfJ+dP2ny03pzVc9jx0p/SEdeQRC
 0/7lsc/jDpKWRjEuBhkxRRZ6hIjTEJvh0opL2CcDTOHlQlkCAMXpwBM5EAMw/+SwJ++Vilf9Pz3
 Pbu5yujl3Ayd/WxlWx7OEHJwWL3Vp5ORkWHG6onLHm4xj4kzmr1sA18at0T5kdAaPV+hdWsP3fm
 wupYbAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add validity check on CNTRL_X channels (valid as 0 to 15).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 892d770aec69c4259de777058801c9ab33c79923..f86acb98b0cffb09bf4d4626f932bf1edc911e2b 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -84,6 +84,7 @@
 #define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
 #define   AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
 
+#define AXI_DAC_CHAN_CNTRL_MAX			15
 #define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
 
 /* 360 degrees in rad */
@@ -186,6 +187,9 @@ static int __axi_dac_frequency_get(struct axi_dac_state *st, unsigned int chan,
 	u32 reg, raw;
 	int ret;
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (!st->dac_clk) {
 		dev_err(st->dev, "Sampling rate is 0...\n");
 		return -EINVAL;
@@ -230,6 +234,9 @@ static int axi_dac_scale_get(struct axi_dac_state *st,
 	int ret, vals[2];
 	u32 reg, raw;
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (tone_2)
 		reg = AXI_DAC_CHAN_CNTRL_3_REG(chan->channel);
 	else
@@ -264,6 +271,9 @@ static int axi_dac_phase_get(struct axi_dac_state *st,
 	u32 reg, raw, phase;
 	int ret, vals[2];
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (tone_2)
 		reg = AXI_DAC_CHAN_CNTRL_4_REG(chan->channel);
 	else
@@ -291,6 +301,9 @@ static int __axi_dac_frequency_set(struct axi_dac_state *st, unsigned int chan,
 	u16 raw;
 	int ret;
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	if (!sample_rate || freq > sample_rate / 2) {
 		dev_err(st->dev, "Invalid frequency(%u) dac_clk(%llu)\n",
 			freq, sample_rate);
@@ -342,6 +355,9 @@ static int axi_dac_scale_set(struct axi_dac_state *st,
 	u32 raw = 0, reg;
 	int ret;
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
 	if (ret)
 		return ret;
@@ -385,6 +401,9 @@ static int axi_dac_phase_set(struct axi_dac_state *st,
 	u32 raw, reg;
 	int ret;
 
+	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
 	if (ret)
 		return ret;
@@ -493,6 +512,9 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
+
 	switch (data) {
 	case IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE:
 		return regmap_update_bits(st->regmap,
@@ -521,6 +543,8 @@ static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 	unsigned int freq;
 	int ret, tone;
 
+	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
+		return -EINVAL;
 	if (!sample_rate)
 		return -EINVAL;
 	if (st->reg_config & AXI_DAC_CONFIG_DDS_DISABLE)

-- 
2.49.0


