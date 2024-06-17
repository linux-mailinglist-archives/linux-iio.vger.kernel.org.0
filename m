Return-Path: <linux-iio+bounces-6354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DF90B31D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23EFB2AA33
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33F1BA891;
	Mon, 17 Jun 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dFVpjkGZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D21BA865
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632191; cv=none; b=nwqqiqYc+OZ7rWP5hV9YLcc5V73KlZzF5ZbkvfwLnzmWhUxkz4c5tsZdWzN3Fgyj+ZzyNK8uiWiuxDiiZ+3PMtSi+2bgvnHSKci6jiw2kXLZD2iwAXD4MJZNy7C3mfcBsVxvz0EhqgE4LkmGzNtW2NWBmRFYQwAXsThjJ0ZHl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632191; c=relaxed/simple;
	bh=yZg3W0CF/EzgkZiaio4uCiv0EYa6DTKX0nMHxwiSYDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKO4e8zs1aznmBJqAtHkxICrVMZJ0XkMRr583pPqV5KjF58zxAEFRS22+h2OOmUI7gK0OgUSxEZAAAHKHRLfo6nxVGFXO3uq8RDLrP14GQUFP+lAy4ijE7chQQ0qPhZJQ5Wereapz0nY/PH5kRAZLSiQNiAGkXBoNllrbx7m7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dFVpjkGZ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80c71bbc6f3so1352134241.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632189; x=1719236989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zs4CGtswXRcL4r5zLR2D5+LAoG+l8N82wbiM+7ownU=;
        b=dFVpjkGZ59QkMVvszQdpXP3L0dKycrfrtbgMEmZq2I5lCy9VC6M9lntD0iiOKlk/GY
         pf9WvnJ/YmKsjaxxJFoGyFhP5oAtaP4eiDMoV0MmMrx7S+Ebc2Fhiez75jlj7Bx6gMPB
         UV+j16pLmcq+oBQgTWVoX3XUi/VIJRn3SmsTxJkijN0Ad6pvtW1f1dQMBbcx5HZneZgy
         drvL7NjUG1lO3CTRRXHJ8pvxpsAYmvVgLgnmACoDsdIcgb0jp5sGz1bPAIY8aYvvxq7t
         ChqnOWqMJBsMpVz3oIXf2d3T00jwRsOX1dXIKuDnQUlZTwkjKD+mqrGhAiWn2S0Igv52
         SUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632189; x=1719236989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Zs4CGtswXRcL4r5zLR2D5+LAoG+l8N82wbiM+7ownU=;
        b=uUeOHk7RrQ/pXJrX5Gbqnkn/RSso2O6bsBevx4CorO/pGL0B+bC/RQuXe6fpppX2rJ
         +Y0Jr51zPFJd1hKy0PPOP+YSsRGNUXmmtKSegoI0Hn0V5jwdCIb7l6DxhcuYyq2XGxnx
         AUx5FxzjfVA2yP5yGz8luPJ3ByLI9pAvz1TVlAVOStk88b2FtJrGox17Fw2wau+hp2xf
         fWGalRw1A78QmpDfCRfYzaCVAFAJnNi0AbaIQh7dxnuFvAoDkHIc4V6YsClLu4UErMGn
         GQBWG6otpeWFaKJp48ZnCbvVDDIQ5s/4CDaosyixzEgcUJnR+n4nIaVMCRKPS+z4h7IS
         M+Yg==
X-Gm-Message-State: AOJu0Yy6SPgsS/itjGn08PxP40uJhE3nrGfYShReUSKh0kMUlrRTJIbw
	lmuYta8BPzp3K1zZTmi82mEgDLA7/K+gJS9+pB9wO0KN2XuFqlQfFg+i5Lv1+is=
X-Google-Smtp-Source: AGHT+IEFmgHtaGyOVxmPD/zpG+S8mAUnggR0FqGzztaCLAyq4bVNR5GtCNAnJm1CQv7c1xou1ffjIg==
X-Received: by 2002:a67:b902:0:b0:48d:7702:99e2 with SMTP id ada2fe7eead31-48dae3e00c7mr8793212137.31.1718632188950;
        Mon, 17 Jun 2024 06:49:48 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:48 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:42 -0400
Subject: [PATCH v3 02/41] iio: accel: kxsd9: Make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-2-88d1338c4cca@baylibre.com>
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
 drivers/iio/accel/kxsd9.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index ba99649fe195..03ce032e06ff 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -370,10 +370,8 @@ static int kxsd9_power_down(struct kxsd9_state *st)
 	 * make sure we conserve power even if there are others users on the
 	 * regulators.
 	 */
-	ret = regmap_update_bits(st->map,
-				 KXSD9_REG_CTRL_B,
-				 KXSD9_CTRL_B_ENABLE,
-				 0);
+	ret = regmap_clear_bits(st->map, KXSD9_REG_CTRL_B,
+				KXSD9_CTRL_B_ENABLE);
 	if (ret)
 		return ret;
 

-- 
2.45.2


