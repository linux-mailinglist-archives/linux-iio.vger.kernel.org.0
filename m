Return-Path: <linux-iio+bounces-20501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BECAD62CD
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE4E3AB656
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995725C6F5;
	Wed, 11 Jun 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1bgAP0bz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6325B30F
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681760; cv=none; b=TRhsP++uIPrFR9Sf+T0k2UyUDdocvm625F0mQlRUH6AOy9VO0+JBpnel3yvqVNgB2yFdDLinKLX/OMpKrMjdTgSn5xtlJelFvWZVWRQ/sa8XS61stJGe/tqgOglakagp9lvFpjmPrXc7rGi0BO4x8Ccg9x7pCaC6c9M/bTU9B3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681760; c=relaxed/simple;
	bh=Fa5HFGJPviPDbkysR8aRcatKX4I+wowmJDzu126VxiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LP8H3ruvDd7RbO7cjtQn3nM07LgIDuzsHzfwKVMNM41XT4SU3h8kGEQtw6fbUehGJrObS5EulBAjZptGHMOS+fqTD+25WwsnfpR/S3uRKVgEmHcDtiZTUEkpergFlMQXLbjPzDobe9zH10JveD6/SDuMZoPuqcaIs5bpi+1u6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1bgAP0bz; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4067ac8f6cdso245372b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681755; x=1750286555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9BvUpsqK/JBPl2TbbTXHb6yTJ1fEP8VZTqeB2IMqFw=;
        b=1bgAP0bzexJDmMqcqUkpZIsnRq8Xs+UKrEXPxx2nGlZQWiNQdo2gsEYNnouTr+Lq3+
         sBktmqjMcBXBqwY4H7bmo9KNYWCEwDxX99k7WVRvdJ9cKKN20MkIVozUzRcSNa3pGYQB
         vgFVQ7LeYvLMm3saLwcw7LNrsBU9sfCbFof/7GdcyAUpUAIsxucJsLZPJJKnL6CYUkKT
         XFIRG041iaXwCAxFHCtWlq28Epd7Tupir9ZBwDhFjtkSdYIc6WEOTIGVWJO0Ok20QZXq
         YZ5P/1Npycwio9ReKmn/aE0Ny3boeAy8eY0no9xFVqEHfIrI/oNaJ5r9oKXqk+q+2Jkn
         bBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681755; x=1750286555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9BvUpsqK/JBPl2TbbTXHb6yTJ1fEP8VZTqeB2IMqFw=;
        b=inQBEns5a9r7DaCaCKWU7/uIoQoQftdqwdVgfxX+Xiregi6sf7NOgmS/ZbGUrQaw83
         CVaEHBAn4qChHXVlgZJpIDOqyL3HsUbIiSWpdBvp9XNF6WQLMJhjDTTzsrY0C79ww6I/
         A7LXshZEk6hbYl9kfOpOtRWir8xEq2PmGmVngZ2R57VGdoMYlCPc+5k4SaSRHVQf7vPz
         Wo/tqVzWTQ/Y2T6mWXEv5IsO9KQKB9vFg3Y4P8vhM8LKjNDu3pgPq9R8KH3HjYDZxsKI
         gq30Yp2oQgtCjHsCqfHrQ50YUjE6X5mKTcBtdnT+wFkdyuy3J80RBA9cuwOyBEq9hh3a
         qvuQ==
X-Gm-Message-State: AOJu0YwGQP8Rmvv1PjPqgYWlOA3bXKfGuo94FYFzPk0lxUL/UIbOJAr2
	u6S9WDUEMA19zZDgh62Js5zejwd9N516rTFKeElEhg1bibJLwOu3TRgIpQtKCojZrCk=
X-Gm-Gg: ASbGncvF6X+hM9NoDHtfHVcggVbuym14gB2NUCR6FUeH+y6XatdTdFIKPwwPfRLmjN7
	wZZXcMq1L5/S3UP9/HN3hyeIBIcbPIsj6XxjAEb27ft8qKpc3LApqY+jhwlzmmyey7U90A2V7lp
	2gpUbDAhY8yHjtxwoCaEYuqmXRWschPIrNMH32x6eIxJ1CQ+2Qog53ycER4LST9tmHN6yDA0ilt
	9WFCFp+vgVDmQ3cahndxtiFMRY7fF0RK5MH/bq7weNBfYMCZkR7tGYl1qKt9WK2tLdDRDN3tjzu
	bkWny7u5kOECXtyby96joET6BByERXYn/DD4YFJX/OM6BYu8B6axiB0kAIYaeRzgjQbM
X-Google-Smtp-Source: AGHT+IH4s7lziWY4EX5g9K2vsF1LhCQHLal8KFovkbFZ6XWeE1Gtee1uuWTA5RlWmKL64/b/sVT1OQ==
X-Received: by 2002:a05:6808:3512:b0:409:f8e:72a6 with SMTP id 5614622812f47-40a669bffa8mr423102b6e.1.1749681755112;
        Wed, 11 Jun 2025 15:42:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:01 -0500
Subject: [PATCH 09/28] iio: adc: ti-ads1119: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-9-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Fa5HFGJPviPDbkysR8aRcatKX4I+wowmJDzu126VxiY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgXAO2JaPHgSGAZdorjz1JGy3kAcpjr9Jr7g+
 ungIXqOY0eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFwAAKCRDCzCAB/wGP
 wHxjB/sFWh2ELQP61fduPRox8/3+KyTM+RQlgumdT7LlO1lLAEpiFtW4X7LruzoNcg26HI9DIYM
 5xMgNMPlGQDH43u5zRNeQb95sLGhX38U/gEtybJQi9OUyW5XA7GeaqKbCi0nbrZHcDXAaw653s8
 Q0RMbiOeC7z6YROCPWks3b4eF5km/n+4y0RKw0Ifa3ipSc4Z7II3nQzGglfRIiER6v4xfR7JQsQ
 pOPPQ0zXq7qFUoYOnx0ctpg/4uipiA1WrZfArVpBS+2ma7OGrqtQKtP5I39yVCX6SdgiNFnLCg5
 DI3AqiaO66yFIW4VRSNdwSecT26YAQ4pOsJLv10vRGEbzusn
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads1119.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index d280c949cf476c7bcbc1e046755619ac31d97c63..d2f86e1ec65641feb3625218611fc8ca00e9f64f 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -507,12 +507,10 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
 	struct {
 		s16 sample;
 		aligned_s64 timestamp;
-	} scan;
+	} scan = { };
 	unsigned int index;
 	int ret;
 
-	memset(&scan, 0, sizeof(scan));
-
 	if (!iio_trigger_using_own(indio_dev)) {
 		index = find_first_bit(indio_dev->active_scan_mask,
 				       iio_get_masklength(indio_dev));

-- 
2.43.0


