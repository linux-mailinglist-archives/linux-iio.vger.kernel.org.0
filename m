Return-Path: <linux-iio+bounces-17735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D0A7D897
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C5C174BC3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F2229B38;
	Mon,  7 Apr 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yIFdg0gr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B292288D6
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016011; cv=none; b=uEE307jVkkJPrJ/rp032BDS0AfsTDV4YMl/RMZ4jUIWurz1ZacbJXt2pnH9Cg4JPmCchkvj1IIK9bO00QKodNrt4D1ApKeGcVnlloUF2dmtcjFEgngeIDDkRo8B9n0QjdqVOpqEHoyl8ouYJ40YjuvWwQ7wdqSf9Ok0KDlljZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016011; c=relaxed/simple;
	bh=pCpjDjmBZOzK40k+vljZr2BliJA0xp91AOXjRWTRx0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApksgnY2aKII2i/4pQ3r+Crp78Y2PAl3H8uYCeN1QAMaWZ47K12q2QzXKY33AJZ+ruNIvd4q1c+Rro2DbgOidgxd+iubqAD0CCoFKsq9BfJhPYBcKBNvIqvpdcspdAs9euTBr0L2f6gDtoioGixTE3+slB3WrCF5VmD844gYWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yIFdg0gr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso44900605e9.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744016006; x=1744620806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOf9H7BQRbk9vcOFRZPDyvrAxaPKr+t8x7+lT2OYigQ=;
        b=yIFdg0grHJGVGw0+gsygFH0k/IVKY8xSqACiOs45DwJXts5N0quuuSVZpk8bS+hI6I
         P+i/odY97IRb7kIkW1FyqcaNgJk4x4v4Ycka+hZxYLElJTKnBaHhD9D8l5hwPpTosR/h
         S/a0iGwyFF7coiDzu8YKpb0qcKf7TnSsstiXdT0yS6bGu91FdzINefnkRIFC0VjkyQ79
         ZWh1PdcaSQ43k7964WsXTud/yyl0FWHDzLiZ5drtD8l+R4+hrYaUV2OEpjC4cxvYFsyP
         Ihc+mW1+DXck3Q3hTtutXkIV/iwuE6+yusS6GvquJHCbJPoVrAh1q3egT6ojvT3E13QK
         jm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016006; x=1744620806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOf9H7BQRbk9vcOFRZPDyvrAxaPKr+t8x7+lT2OYigQ=;
        b=fJ6X9uGE4ezRrlyqe5WLNHYt21AmIKcUkaZYuzq1VQer3O9SMky7cxTJn6Q9iPkXhv
         tPmtsOYW+sgRK9Gw/VTBkfYgbPG8CaurAgeGLmKRajMnWym5YTghbHyAWg9hxzl6mAAo
         W2u+LJj5yJMdTkiPvVhNO5+Hrf2B6RgNjvF5NSsFfN3qum5kl1Be5e79CLIDT2+uaviJ
         OmzsoJpL7BlqFk2TmdzHHJmjEe6TXjdzlBBbtk0H9+Qo61b3/SjNsnXbmeIYp4yeiGd4
         btoWZ+N41/jhjk3A5t+eaTGfTVJDaMQT+FjcfSkoM4lT0vG5x3CdzcYDvimGtHj/MOdh
         q8fw==
X-Gm-Message-State: AOJu0YyEwZsFM+N+pJBhI0PGSYs/X6AuCnzlz8mYin4mZNLjbQzFz6VD
	htXgKZHEyjMOCXfxE4Rv5wywxnkdFY1Q9/q3sZcMJ8WEnpUQV0nrgkKNYAX+lH6Wt9dEWNsWfsJ
	y
X-Gm-Gg: ASbGncvS4rzXzOnshbqnmm+xvK+A9e/a6bozAa+oiN6EezstP+5HG3onIu0460Aoav2
	UwUXlgkWCH+WeJgePeTwsryMt1NUVF2KyXS9ZlUUOvrGjYO0yyMUjHatO1KbkIo4o76ndTLAFVo
	7iZiCkc2bsqwTQ5cyO50Eg1oVX0r10CdJQfH1XxnEwZS6//Zbw95MeJ5jmwh6jUSRmtFI6/aHiZ
	mSS9UEP0BEIzppetsqJRtJI6CjndedEbRqz9DoTp0CWOmGCl1fqyXsvS+7AGe286zqMiHeZm9Tp
	QG5N2kMcJkNDWiJJpQGU7K72fk4v3AID+LOvBK55Zt+xrwulXq7b2IG3lwCyUWVBm1e2OQsrgPJ
	xEMLf2VmQIyK9pvQ1ptwEjg==
X-Google-Smtp-Source: AGHT+IEESbUJjv5zNbby1nRneFXpbSe5k56jX92f688Vnu++FT+Kfoz76Ak446pwm5EA80vwmYPa0g==
X-Received: by 2002:a05:600c:1819:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-43ed0c6b9famr79797225e9.17.1744016006024;
        Mon, 07 Apr 2025 01:53:26 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm126966995e9.0.2025.04.07.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:53:25 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 07 Apr 2025 10:52:03 +0200
Subject: [PATCH v3 1/5] iio: dac: adi-axi-dac: add cntrl chan check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-wip-bl-ad3552r-fixes-v3-1-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
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
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/PMnG9U/8FZZrZ1Y86Vm0d8aLM0XaJgz2gVcWMub12
 bOofmdX7yhlYRDjYpAVU2SpS4wwCb0dKqW8gHE2zBxWJpAhDFycAjCRa4sYGdZZ8RndWTNjdst5
 H46K6Dl7Hu/8oCFaJ7hZ4rHxZlsmsUZGhi2PJJKTOWKnC34/tfRBvHBAdSRHTcYGOz7pLYtDVY7
 5sQEA
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


