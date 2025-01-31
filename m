Return-Path: <linux-iio+bounces-14780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1498A243D1
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BEC7A1B3A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CE21F4293;
	Fri, 31 Jan 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ig2spnB5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD141F3D4C
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355094; cv=none; b=ItU3BitieQJOqBSOvv7xq8zKDEiHQO+b3DSMzKpq5ur/qYafkdxoGVYVBNlxXNsdOY/B/GtSuhgpjEf9a2pE28LUbVPhQM1ulfXVuuVDsSZFaBzbydN7SEQsTbSNRCX3Ipp95clh9KDHWv9KqEPSKAzpeaDWNDaJkD1pDVSrwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355094; c=relaxed/simple;
	bh=rw0sTpvokUQNOxXktkwUiVgyBWFEQak6z7kbvwC+d0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsdBzx7bFOA6RWuAvn9NxrNZ0MQrgsBp/zgoPcs/HQwypM+iLs4WRbrKAORTLU5YUciL0q2F5cPGajLUTVYQSr5WRAu9rvAXLSiafb05tKRfyZ07hK4ReIt+p1EGWbsXmDknD6wdna2fiAyZM0653kcvWvrcTTmDkpWnHOmDgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ig2spnB5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e3284f963so1236525a34.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355091; x=1738959891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Y1Uq2vC9ngxtabj+o6Gf/0MmnPKx34MFqyZVe1ZJHY=;
        b=ig2spnB5ORsHBPO9Y7nXycafF0XrCNtyHpbBQiJlFhRCJzhD+P63NHG7Yc3+rie4wo
         Mr917YqOD9SDmep54TVk1MQRWPTZklSbZHJI0otG2bBK7sL8CU+OGhyYSPEut98gL4Am
         /OamnTc89XUpnCD9s8nMCU1Yp2t50dPGzeYwrwj4B0whOWNhTdqOgAGsfB57FU3Q7ibZ
         +D2hbdgSPZW/fxOr2hN2CCrhN6U1bEW+MkJXEhvm7iZ0xdvgqfME5m+uCnNVxhEQEJMH
         Lx2W6FXmvSWHlwbKU0a4TJ/gjeqx78VIr5vzW4+lr6aucRQxdzZvzXh+n5sjyaEunDVz
         5L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355091; x=1738959891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y1Uq2vC9ngxtabj+o6Gf/0MmnPKx34MFqyZVe1ZJHY=;
        b=OyAlLKewbg3HH4IuXmIThc2otIPFHoTs6/v62mcLyNhQyYBw+JcKQ4DYo/XYKixX5e
         PkHxUw2AAEDkudAW7ftowPFbUs45aPgeIoRehD752cZssngQjC0LgeUY/zmBqq7Yl96K
         zaYrX2fEPqUp65y1gNBFx4T2ft/7OjEMHGfbs5gSpLgxCEmaY5kW5ZBH/Wz1ubx20pun
         TxUOFMtzsBuTdzBL295Toenph3UrMuNrSHZ4EZUPDiDR3SWipbJXulSdVSJQpWVqVyre
         O+DAW42/E/dI1GOKFxiveciNz1hrdNG398sraQP08CO7HEk8H90y/Irb0vcqpfv0dlPm
         j2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcukPLMhoirKTIItdGV6W96T283M7+17yqngORTmPcmQMw4aVOxaD1LsXOLAShIvkNYA5aXLGny4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNrE2o/hXBIqmUowHNmJZ794FOfQekNT5VS4l105aKArFc9N2y
	oJ/zMasb7DcRXx9f64YZQMNzXDAsgwHK/WcnrbWYrPvIVa7HbOLuXH6uu1pXNqc=
X-Gm-Gg: ASbGncsyYWXBeYMni/JrlMB+VnlXtjztg7uf+88e8M5Eda8S9rpMHjmjWo5TUlMTrQK
	9Ys/94N5NkZ8yro3owaY/qT6GrxLVVxr0vPN0DliCJMmxRL69cuXfd1hb+XrZKTKkK1pgci9AOv
	wSTPGqOzmwPKimX4YRU6Ay9cEQiYdlrBeac1mn7tKkmxLymR+Qf4aWnedlkC07fvg8+3agbLJw9
	lYcwIkIVHAgWNhcbM1a68QIXH7161b2dmScpD4RZTTzfXWUzLuxrsuS3cFEXH73qFBH7FrKoBYz
	hnM2sld7l8orols5tGFOagiL5CuxCaIcgOOOpKB1kvD5PfU=
X-Google-Smtp-Source: AGHT+IHpL9OiC+7p99DGjWrddY5GvJC4qVZT5ABdvIbOzG8MeWG3IwFdHaR/KYiBNOSR8xIQZbb8jw==
X-Received: by 2002:a05:6870:ff46:b0:29f:ecfc:32df with SMTP id 586e51a60fabf-2b32f02152dmr8447581fac.14.1738355091503;
        Fri, 31 Jan 2025 12:24:51 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:24:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:42 -0600
Subject: [PATCH 02/13] auxdisplay: seg-led-gpio: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/auxdisplay/seg-led-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-led-gpio.c
index f10c25e6bf126cfaac3e4c353f8bfc6639d94a60..c158b2c2827415e75d0b122914b8b18c043e8c76 100644
--- a/drivers/auxdisplay/seg-led-gpio.c
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -36,8 +36,7 @@ static void seg_led_update(struct work_struct *work)
 
 	bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->buf[0]), 0);
 
-	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segment_gpios->desc,
-				       priv->segment_gpios->info, values);
+	gpiods_set_array_value_cansleep(priv->segment_gpios, values);
 }
 
 static int seg_led_linedisp_get_map_type(struct linedisp *linedisp)

-- 
2.43.0


