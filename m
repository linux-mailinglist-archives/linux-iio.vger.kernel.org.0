Return-Path: <linux-iio+bounces-12746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878EF9DAA6A
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC532B20A34
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F344A1FCFDB;
	Wed, 27 Nov 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cIwtw8y/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC41F9EC7
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720083; cv=none; b=oRh/By3mCmIK3VqeoOm+F1ZflWzJ7Y+xrjcKWjtlWzGCv3CxBOx3nEZp/P79hEDtZiM1pH4iXjOkJiDdS7qgKm1pE+qKg3c0DGSycjF5gB4hLp72kLSQ7EyD+eYeW1046ICTs+0YS49C9BjV/fTIHD30BILUmpM4KsrnByKzT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720083; c=relaxed/simple;
	bh=dkTnukD2rrkruTwfH798eaeGxe3q8221q3Q+tAj6IYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrUslP7AcL9XABGZWgWcfufUcGL3njQa8SEb0xze4nUwHpleEppZJcK5wM4JToi25k+XJEwnRvzMKb6/AraftGOP5/wLslfUXD6eYHAYz6FhV6/H2hY5P7gNrHnCtr3d6wwv0CQwA5CSxotB6mXrDCKKiqOP72jOzATNwpPSTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cIwtw8y/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382442b7d9aso5230460f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732720079; x=1733324879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8sEiFdmMWi2hzthhwzHkLTong+QNvgFETpYvC/h2tk=;
        b=cIwtw8y/zkOlxUMWTDQFGRphIspEGJJch+wCZSXMMCsBacB609zMMQKQpJCv+jQX+s
         v1VtdthMcHFcxL4qel9doQXN6AumNAKv13AN/1Kwo0qigMoY30VGkT+Krcwx/bgHtRH+
         k1Z9qgiLW0bSpXNekuj4P1OBlHb2cA1qqPOu4hiig649sGQUP71gmoFy2XpHOAXZEcBv
         ADP2oXqdese7Amb/59gb3LOwG/KXa9FxROs11bo/roykGPzAFOgerDdiUGA0AVy7Qd1m
         Ky55yjGLxnZLA1XKUQ97IwcAa8U8vpMY6k/sYScrmmkj+pQ97LiYGM42GuKK1t5c4fu0
         XmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732720079; x=1733324879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8sEiFdmMWi2hzthhwzHkLTong+QNvgFETpYvC/h2tk=;
        b=sCF24ge6EAPkx6CyMJxbOC85AVfrQdWeRbNXKaxpgA1F08ADU1umEV7aj11fzICbA1
         2m0mWpCVx4XCPSARHLQAE0mOTjVdxX+Qi60fg/Dp7NJcsKTcWZhbq6LRrRyQNmOoQ2Y6
         k278eVLhq7FsCPg3p0KOc2zCwpmv7vM7ZPDTERyYSXBG1uJX4JwQgSXDqr6VAlx7L+mC
         Bn80FQ6EI3Ua1SGG88N5ukyyTLE0q0eQbYGYZBGH4zCO7fz88u7yadrCVxpKn3pzqLnC
         pK5mwTpZ3Hsn6MAS2vlUr3ayZlaDPC8iI03O857vmqLPI32/9YqgLp/27ejIN63iYkhI
         nBpA==
X-Forwarded-Encrypted: i=1; AJvYcCWw16WyXs0C/VWTK9EhsAfDkHsYY3w2wT/uFBDDk0/ujKGDent+Sr191Lc8UrTP+Aoc1PGBjp/8Ae4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tIHttbS01il0HYisygtDE5TRcdki6zOJ9DpJsMJj2Bc2bwcA
	nJsIcFGLkgCEvUF5TawVvCAsClhYoKVxzn/pGHsq+jVW9M+XSeMbSNHZnlQB/buOP/CndBnyxB+
	Ag2M=
X-Gm-Gg: ASbGnctAKMENMBRc6kXMmOg2ngoI8kH6gtk3N+nsqdsEkPVH1b+WyilfoLBjl4iYjn+
	AlZgXJVgwaOmcGewufFobkBLMVt/OAS7sk0dd973sHNmbVo94IToVxoyrx7p6DyXSdNYmdm94e6
	58+tEUYU/DjWF/h2t2kij4kfoLydgUHomIjKlUfPuditWMFjWhsVhytR1N8ikUW40ozBjNMTTpy
	U+OVmEZiWlKolKzYOh2mdHVz3Q5Z7EJAR/ZY+9Uy88wOU/TNoQeBsfIqre1+psn4Pz2hnBbpRAm
	n3Gx
X-Google-Smtp-Source: AGHT+IEQrX5uqS4EOwz/UfuI3dVm5HPlvFdXAk/LsUp4rW3OcjjVUXNq7Kc3Ko0v9nnQlqxBIAWZHg==
X-Received: by 2002:a5d:47a2:0:b0:382:3816:f50e with SMTP id ffacd0b85a97d-385c6ec0c20mr2502982f8f.34.1732719613277;
        Wed, 27 Nov 2024 07:00:13 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad6270sm16432660f8f.14.2024.11.27.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 05/10] iio: adc: ad_sigma_delta: Handle CS assertion as intended in ad_sd_read_reg_raw()
Date: Wed, 27 Nov 2024 15:59:34 +0100
Message-ID: <20241127145929.679408-17-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=dkTnukD2rrkruTwfH798eaeGxe3q8221q3Q+tAj6IYI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPerHUffRNjnKdY3og9fWY46C7ZE5BO0lhvf IA8qsTdgOqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz3gAKCRCPgPtYfRL+ ToLWB/9qRLATUVF9QLKhnDVq/Fqgs8YANLiyhskJLCuYqV8wZ6DL2YGBntNzUx8MF5RERMlie2d mINrjNIYs7mLZHSHl1h34P4PV3m8a/p4IdDmJu77F0+ze7feFaNZNvNvU6zp+bDo3EXiMfWU3WH rT2uq3VY2d/UGiRESNtbDo+LH7p67OlhSaoW9BLcoz+61IlIvjlKSfXF+r6gh4T3+MiCjUr2GAU aykf4rYZNvk4hGPVNeFU2bFDLSc4gphW2mGN4Jdbq9OdImjzvVqnnnoHPUeAAWj8LssE6Q33FSN x5Jhmsit0lhMT/2jU960cnLgUYG7MV+i8HSB2MBlK6eBzi+c
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When struct ad_sigma_delta::keep_cs_asserted was introduced only
register writing was adapted to honor this new flag. Also respect it
when reading a register.

Fixes: df1d80aee963 ("iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion")
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7f4eae5244dc..a2efd2145373 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -109,7 +109,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 		}, {
 			.rx_buf = val,
 			.len = size,
-			.cs_change = sigma_delta->bus_locked,
+			.cs_change = sigma_delta->keep_cs_asserted,
 		},
 	};
 	struct spi_message m;
-- 
2.45.2


