Return-Path: <linux-iio+bounces-6387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074290B298
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8801C2305C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CD1CEA0C;
	Mon, 17 Jun 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qNszndL/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067801CF3EF
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632262; cv=none; b=luwRmpUFXfo4kGliDbQr3Glcl+vusGxFiVlXYzwXEpnsVXaCueac6xxg1kqkU6ic1li1/ipjlei24CyoHxIeJfEIj1UgbKm1wwBGdxsFR8SsNMvST4atSfd41Dl8b3qk4Jmk6APJyg/DYNH3yVJLyZozd+Fvt1IE9DzgrYyP6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632262; c=relaxed/simple;
	bh=NDx/K6ep/W55tpcxMxrlQJ2+ADx4bn4sLDv234tkO70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3L45tgdAvEn0SOBLN/C3AjprEwkAT82gSJ/kH/63qAGC3ZjNpD5rZjPFkhEG/1zgmRnCJbFSYl/eB1Fwz6i4/5eTfKwOqIZIs5PYYUhThbS+K9ODzf3f6CMpQktulDLfqjw9nUMOJHrGjzpeRrfkYZ7Z7eq6crpOCtO/FyNtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qNszndL/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-795569eedcaso228741585a.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632260; x=1719237060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCh+HIY0adNQEnDSauX7K8bw5POFZegMypjkhgGy1wk=;
        b=qNszndL/cAKYAXgVh4+LmEW2QmjdgcZiNswGv8EB5cTIcznmmlCDWtYvUI3cVgpvlY
         o/pdgxjASZVIVnfsS7StCagr0MtH96xJphB8ZFHjmMw97g3MZ3bIaMq3/AdFoo2LTl44
         5U7mryedH1QcxsKJIrjbUf2rp3GErgeyOBKl9IT6ZHPgUDEGYiXioAEqBRwbY0+95X7L
         WD1IvvMFTugf51hW++AwmecHLl99V/m3LNd59ReeAySYjtLa3ndeFPQa/bCFK5KTf+34
         BpP8H7JfmP4yIOfl9urJ1suE8j6NE+T75X6kfZ+sVYwTdnMeHPjYvM0lxzOTsoGLFqUz
         OV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632260; x=1719237060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCh+HIY0adNQEnDSauX7K8bw5POFZegMypjkhgGy1wk=;
        b=HvpFqTQOycsrwUqX2Mdma6GdFGvpJ0Zk5S5wxsbz/Ox0dRGhIVaoAlyH3f3YI6hYwn
         suf6s2WV5GUMf1nS8M7mYjXRb0z/QXWsTvjced2P4AUH9qX0QbjqcKXa8J8PPXwfl63P
         BJGjmYFh7eWInt3/BBG+LURdexIa6darjBYyywRAPq4A2X6Z2gzIGVoWkFrLB8zxILdl
         GpdCGbTNV1WLJNmQYtewF5iMpWs5QPATSF2Ocof81UZiaVsKHErsY4JmTVNow4Lpm8F8
         0d4aInJUSymJyZ9kNHnkBr59iGg1a2MGUAtt9/W9l7OrUkmzyQ6rm0ovo8OYT69U2ER6
         McnA==
X-Gm-Message-State: AOJu0Yxa4Em9j518JDn2G/JFXs+Gv2Y43QExvuQlLedpSqlxg3faU32a
	OnWcceRbyR4+jJBud5xiLSUr/e77JVkC0PZ5AMs4TufDUW9c2XHxHKzC7HeiT3M=
X-Google-Smtp-Source: AGHT+IENId7QjpgihvaST50kcENjvnWyxdiSnte4lhDV+Skn20e41tG2cguOi5hNHA7+JrD8WB9kUA==
X-Received: by 2002:a05:620a:1a29:b0:795:50fa:c0be with SMTP id af79cd13be357-798d243ab42mr1258423585a.39.1718632259895;
        Mon, 17 Jun 2024 06:50:59 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:59 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:15 -0400
Subject: [PATCH v3 35/41] iio: pressure: bmp280-core: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-35-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 09f53d987c7d..ef7f546839e4 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1566,8 +1566,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 			goto exit;
 
 		/* Disable programming mode bit */
-		ret = regmap_update_bits(data->regmap, BMP580_REG_NVM_ADDR,
-					 BMP580_NVM_PROG_EN, 0);
+		ret = regmap_clear_bits(data->regmap, BMP580_REG_NVM_ADDR,
+					BMP580_NVM_PROG_EN);
 		if (ret) {
 			dev_err(data->dev, "error resetting nvm write\n");
 			goto exit;

-- 
2.45.2


