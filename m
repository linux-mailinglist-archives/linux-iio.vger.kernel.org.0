Return-Path: <linux-iio+bounces-27511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557EDCFDBB4
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 13:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 609CA303E426
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07361319614;
	Wed,  7 Jan 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vMtPRhEu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FDE318131
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789325; cv=none; b=qkVkwWZQ3zs6ge5wTtzgwU0DDebVWzvBdjnMolucJy/DMnnACvACw9Uwy7m2DFiS7WI2eVS03TCn1aeINKmpVTfXJkGNxavA53eJdsosKzg8bYBaEAEIjZ5OG2+N1qPfMc9Wy5dWxvAFQbX0s6ar8BzFssGQQTXSEMMOvvlbjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789325; c=relaxed/simple;
	bh=zyNybYwclOAgoLMp37uQ0NnOoXvMnK5xY2bEsHaNd5Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7CSqpWiFFS4CQ9Vx+GpUgmTVjYPOf3P6xWAItVhdaH2qiEcHjh9KmKbSCH9KtNIFDkbn640ZAqCGkoRNCeb8siBu9VZhY+sCj8BQoy1+IjlGCDFbumV+DVeHue5tDDln1M62wBMgdJpNWgzAPh5hOOSgl4DlRfpZlu9IaQNN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vMtPRhEu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so409094166b.2
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 04:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767789321; x=1768394121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRMuLRBuKMDy+OE+n+VG4mSVFewbK1ysyeDDOy9wez8=;
        b=vMtPRhEutmy7wg0wNJIS1rY/TZiD0M1JHldyBIBmcKYdJLOupCwOfvX/w7BxNadt0u
         tfr9u05gaxB3FF8TraHPkrBL3EXrEJIBziInnC/VSX9px9oHMeKithAjzMOekWTdXPMe
         mURS+oB3jnyY2QJfgJ70HIfi+Mp5DHtY3kDu1ijJrKjBOKjHB0NZkEx1Q6nBuIr6hrMB
         q321kxAAiQaVGoomie4l2t5rgQZHfOW8TvJ6oEiJI/5U9Hngizk3lkU9oR+LkgFmwBzC
         UUGsJIbvuaf8dZw9n8hSYDHXhP0txoG1FqyF90sxEmCC6jmtKhZFtimC2DLhCKhTXypN
         St+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789321; x=1768394121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZRMuLRBuKMDy+OE+n+VG4mSVFewbK1ysyeDDOy9wez8=;
        b=PkJa0t36cK+K9A+wsYN5W65rBbdNALdKZVR7kky/WyPlj1CEBoiNbFluLCYSgEjlJf
         56oiVaSpT0YLjpV0uF9nxlUrWJJW34r7sdlIowDd9Ipmt4HAPCwHzWptpQc5oo3v8qMw
         8vWM7JRy5UMAisxVoadRJ0y0e+z2dQ9Rl5GQIC4Is1Qw6BlzTMycPkQPLS93O7xXUcI0
         aP5b0oFK5RcWLA+avB8UxGxwf3+YtNRg/IOMmwjpWpa2MyU9fgc6AqJWWUXOPoYt5KrK
         D3cyvxdmEvjJmHp8lv1Z3zra+sIdNI3SJknsns4jg8v/hvgKxxEOeZ11Q57C3iubcqX2
         di/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlNDz7ukd6g17wDFF5jnRM8VZaZ6uYhzuWRS4OmAAOH+VMuTTvQy+as52R//aaAcYP1+Rvv9AI04s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkAwL0RkA3EDJgKI/W39ueI6fKpQ1L0Cv0wKyr/AZWavdIB1I
	HGk0ubUgiR+O6THI/Ph3etRcqFjr3jUh9+45Qj6P0DmhO9Ne4A0170QCA3UHwBcwaM0=
X-Gm-Gg: AY/fxX7j64lyTjgRnuygGvqAinNLS9cYAt7TRyPaYFWfZOK+Kgkdjqle4SGwDGJkRLx
	iFS859cr2gk5C6KJRTQJIRosldH/IPIDUU3qGUZliFHkaNauDs5jJRry2HuJ2yVQ8DQovB3p2s8
	h9FoGIvhSJ0CwOVvOV7tcL10AUC+n9h7lDNokM378GuA4a0wEl3Zexn2gPhAivGWmVIaVMs8zep
	g8SJk0LF8tmEvTPgcEWbUjVqLNFoAZXTbEikmNFH1j4ETyxmyswJr/L/K1qyZKJgW5X7vps7/Fs
	oORmaJRNLVgjF1oUChpVjZb8HkOI9izv4GMpoA+0fUCiAMoupcw8zSyTJIwCGn+uXMXj/GtOhFr
	mraMpAtbe8h8uzEVSpavvMP0nO7VyCho1z+V8/A76Ns3f8eUTcLHawLaAPi95BioyDLFiT0QdX/
	OwFlzB1onuhDN3dRuqQTagsUYKEiGOWLPuyus/jeA=
X-Google-Smtp-Source: AGHT+IEK837wCDq8vTB0efIIImamkMFbdXkQacFMsw+ngxZ0FIc8+0sf5pGpib7uy0EUvDT8ppdiTA==
X-Received: by 2002:a17:907:3e1c:b0:b73:b0eb:16f5 with SMTP id a640c23a62f3a-b8444f4aa5amr241071766b.31.1767789321507;
        Wed, 07 Jan 2026 04:35:21 -0800 (PST)
Received: from localhost (mob-176-245-211-45.net.vodafone.it. [176.245.211.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2bc6bbsm508492166b.27.2026.01.07.04.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:35:21 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: accel: adxl380: Store sampling frequency index in odr struct member
Date: Wed,  7 Jan 2026 13:35:17 +0100
Message-Id: <20260107123518.4017292-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260107123518.4017292-1-flavra@baylibre.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=flavra@baylibre.com; h=from:subject; bh=zyNybYwclOAgoLMp37uQ0NnOoXvMnK5xY2bEsHaNd5Q=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpXlL/jooTA19mfEfmr2kRfl+dsgc/hX2E7zUMg PEDwK35P7+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaV5S/wAKCRDt8TtzzpQ2 X3VkC/9m75RAyWD2okE3IgiqJYcRP60CEb5HwVPWCCezOuLxIT2YJ6SwX/45G+QVbIPhybusbBF XoDTumgUDd375EVA8HZ5upsxEdlK0nJ+SJgIYLpYg7jku0HUDzKJKqThAQHmYngxsSPNptFad3G 2BaaqWeEw87XxO8xMrOcyiDx1CG1Famvj/6V6o3ZHSzxxBFjKNP92872aand3ApoBJfzQxY+856 iHfYTeohSW7TAbqsCPFiJGuCdvo5EjLhwGi5e5FnWmoN/4RpgdZeGr7wWbyJtA0CWanf7hTzRaf 8xsnNfvCKw+4aA6Mvbsba0GWw2FDV8Z2+SiKcsOQ9b/wII/TvCGwfgLr8HAnF9kEtzb71qZulvo zWzzuO6BD8Xj5FuwIvm56Pyc6l7jQHdXDXmP4uB5Lz/HA0DuuFYDUwarZ7rFk2sXNNDsTyU867J 48sU0YVoYOw5fUBgmxvyQEQCh7T24KIqnfEMpB5O064okGbOPAtRXtCdLjtiuZOlirlUg=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The ADXL380 driver assumes that acceleration samples are always retrieved
via the high-performance DSM signal path; as a result, the sampling
frequency value depends exclusively on the decimation filter settings in
the TRIG_CFG register.
In preparation for adding support for sampling frequency values that rely
on the low-power SAR signal path (on which the decimation filters are not
supported), use the (currently unused) 'odr' member of struct adxl380_state
to store the sampling frequency value, and when userspace requests the
current frequency value, retrieve it from the struct instead of calculating
it from the decimation filter settings.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index ce3643c5deb8..bbf1f88ca781 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -417,17 +417,7 @@ static int adxl380_read_chn(struct adxl380_state *st, u8 addr)
 
 static int adxl380_get_odr(struct adxl380_state *st, int *odr)
 {
-	int ret;
-	unsigned int trig_cfg, odr_idx;
-
-	ret = regmap_read(st->regmap, ADXL380_TRIG_CFG_REG, &trig_cfg);
-	if (ret)
-		return ret;
-
-	odr_idx = (FIELD_GET(ADXL380_TRIG_CFG_SINC_RATE_MSK, trig_cfg) << 1) |
-		  (FIELD_GET(ADXL380_TRIG_CFG_DEC_2X_MSK, trig_cfg) & 1);
-
-	*odr = st->chip_info->samp_freq_tbl[odr_idx];
+	*odr = st->chip_info->samp_freq_tbl[st->odr];
 
 	return 0;
 }
@@ -500,6 +490,7 @@ static int adxl380_set_odr(struct adxl380_state *st, u8 odr)
 	if (ret)
 		return ret;
 
+	st->odr = odr;
 	ret = adxl380_set_measure_en(st, true);
 	if (ret)
 		return ret;
-- 
2.39.5


