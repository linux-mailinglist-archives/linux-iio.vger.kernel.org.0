Return-Path: <linux-iio+bounces-15305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8FA2FD4D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 23:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914D2188ACF7
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 22:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC525A323;
	Mon, 10 Feb 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z4odNCuW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6325A2C5
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227065; cv=none; b=pOrK6QDCbxLub6BBSVifWDpKy9Y+F9VCQNPKFO9eSjglJzD6MDtzCWLaH+iezy1q/0/2pO/tab18XEX5DRSn9W49/Lp+/xdfTDPeMldLZbyfofI2WNqCSwXgVd52Cd8fY4g+YIC8vBjncoH9zlCkTxA3e9MBpDjanPs2gJhjovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227065; c=relaxed/simple;
	bh=K5V5TnWu+110nnHuULWw1Pwd0QiBFgzUapmy9BeC2p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4IAevGLES+AIBZIC4NB7vy4rnZTAS1fkpGVxbmzo4S2piEHJKw2nC0yFBgzRfUvDtDPVV0Gl4y70Tw/KmDTW4wCuoQo+TFB/NgektB/h7SpuxBmuzJuWED1bk+IDvWeX1mo7+6gd2mReCHnIKPHh9MT7gMZ7O/5xX5FcMUiUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z4odNCuW; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3ace3d30eso1142680b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227062; x=1739831862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAgdP5/7nbSCpei3bdgHz+Kvp3J/VbeQ+Dc9cWuRxQY=;
        b=z4odNCuWEIdXw6egWdAWzvkDfUm2yp9LCjnZQvBCOP3qcsaxfCXnX9ztT4tAzJgMaI
         oDzp3usrGdpGtWbm0FqUkKrpmWAEIq0wPRJUUbuLHncebfsQtZRIdXurTcE0coBezaot
         JCqwfqdc21V6HhF23eOTpr1Hv00Dk390SFpGVTMpKQAG5hTBVYYJCwcIsgcO9kiueCqz
         pcz1nbGaOl3KNFWRBj/DCKZxfPkD/u9KWoJF+RASmhfD3E5roTW7Q9RZbtvCdUfMt4C1
         4t7qWk6gsXi17m+oWug7qVV/Df5lYt5w/9r/5UtGtJtXuARRfAjocCTg95E9CRvg5S42
         AFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227062; x=1739831862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAgdP5/7nbSCpei3bdgHz+Kvp3J/VbeQ+Dc9cWuRxQY=;
        b=gBWyB8oYwQM6UCXCR07Rz+EG4sa1Lr12qwTxfbenbvIDP2z6+ICovNvQMZ/7TkI/xh
         HQZv1NKZ1mR/nVMJLNgU6i2GkGXApAqlsgTMr0gneS264xEPt+XOj7eSs0RDU9TPUcAo
         zQ1S7hDbBm+eW0cCHAd8tio9aFUTohgyO0NTT4CXVei1ECwSJYXQSbib0P1+EPIdcC6X
         pRzJqNhixmssKD92VSI6vxSbLE90Du9JOawkvHt5hQxXbvdMZ4nHwUNtOGyHlC4A6VeT
         ePexpdCFqU+kMu8wZtUdO7O7FX6kitJZWct0PwMSZYdwGEBaKIsoKk7qRWB9FFLjrrUK
         hVxg==
X-Forwarded-Encrypted: i=1; AJvYcCXqVxA4y+TzftTl9M83rEwjhXRWSihTAu0toHydry80LhDB068A0Hqmc6qlQxGaaB9iggtUCc0sUvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywch49RGYZWxRegWfprZ3Jwomx+TxxzfG9j66HJYY6nh+SlO2gD
	II6/GrbI88xh29BhiIsJsF4K9XDK5QFnI3HwCOW9r238JTmFgbvVN53YR9QguvU=
X-Gm-Gg: ASbGnct9n5UcmSYXpfxKFGFDJWXCiTtppOT/LOeVK3ESRjxX8knB6icUwudN359kpeU
	iGliBtWpSL4d0DRhpnKMQnzCxjYmYuIgxYp4uUCBHTrswVrmpzlmfhOZeUoCGNrQditC4WFUCPR
	iJ/bsk1Lu3Qp9T56nIa/VFF9yY2vCPuKa1G6R+wIcum+acdd2FLp7lMxcoJ9dp+mz7F3Vfq8ZCJ
	MFpLm18gtbdA8TKD8URk2fURnafKBn57VWoJReAJtXoNMTTEv8TD5aorLAx9taOBuONCfEMFZm8
	febmAMPYnvtopAShDGjSVMbyI3pt9qtuZeHIo8HldZChaAM=
X-Google-Smtp-Source: AGHT+IGCum5h1AQwvUJNh3Kk51lVy6xq7QJ+B7z8EkY33CFant2nucCBaXwDqcXBpkDagMClSCsXTA==
X-Received: by 2002:a05:6808:4099:b0:3f3:b0ae:7998 with SMTP id 5614622812f47-3f3b0ae7b3fmr3901508b6e.17.1739227062548;
        Mon, 10 Feb 2025 14:37:42 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:30 -0600
Subject: [PATCH v3 04/15] bus: ts-nbus: use gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-4-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
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

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value_cansleep().

ts_nbus->data->ndescs is validated to be 8 during probe, so will have
the same value as the hard-coded 8 that is removed by this change.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/bus/ts-nbus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index d3ee102a13893c83c50e41f7298821f4d7ae3487..b4c9308caf0647a3261071d9527fffce77784af2 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -109,8 +109,7 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 
 	values[0] = 0;
 
-	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc,
-				       ts_nbus->data->info, values);
+	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
 	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
 	gpiod_set_value_cansleep(ts_nbus->ale, 0);
@@ -150,12 +149,11 @@ static int ts_nbus_read_byte(struct ts_nbus *ts_nbus, u8 *val)
  */
 static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 {
-	struct gpio_descs *gpios = ts_nbus->data;
 	DECLARE_BITMAP(values, 8);
 
 	values[0] = byte;
 
-	gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
+	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 }
 
 /*

-- 
2.43.0


