Return-Path: <linux-iio+bounces-10090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433AB98F87A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08789281F63
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8E1CC173;
	Thu,  3 Oct 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSNbMSkl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26F1C6F54;
	Thu,  3 Oct 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989506; cv=none; b=a4+uPvJuLsiMMH5ZTwpNxpR3IwXDXUrFK5/q4AzSaSziR7cT7UMe1ugUuKXUiV4Rxn8nCvedZ9aBcxjrec1gqSyXUHIkUr5IWZvqwsmDKmbvWsWaduaROGHe3nwsfdOWS1XhladlKdTA11iccLbLkueuMIxFW8zCwLLHBmIZpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989506; c=relaxed/simple;
	bh=XD59c28xbYCxr4/KbA8MK4CIcyt8Kn/gccLgAtnCnlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLSrDYguafrp80aB2Y6ZACsA6w4Bo7IeTxI+13Bwv+/IaTkejYH+Jg5AQK45ND2ofbgRe+qYxtslqVyjj0EibubhP04OBvNU2UyRV7AnYoJuDtdCMONFrPLKBLGHqZcOCoUu+Tv3bivZSqFxIH0SD2uXNqrKZreR5I5gJbKOEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSNbMSkl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso18068855e9.2;
        Thu, 03 Oct 2024 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989503; x=1728594303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mclFQb/IEqLdXS1L3KMoEr5Yg8KzsL34jXvZK/E3Fts=;
        b=hSNbMSklVLs6buuJ9wpyLFfPuxtG8hb/+M2+SHVhX5mRQ+JJKdXNy0ZFzBeNAsozvL
         VoEa2LRrWZ0nNEIGmsp6RLzYHorn0kI1uRzU2ukT9D1Zm9OdAklw5W0dk5dR/AiIeDEQ
         B114q5tsatPgd3TMdxW2pi4RTMOqiD5IFmVG2ODtrkTVZKUlnqBbHZeL6FeDeRK4zbgX
         n93JO2NZrhrTky2tyr5o88nMRlX4ugLngBqzEdVZ3pmCg6BTRyi6g4lSeYH3alQoaZys
         +TwXJLxE6a9DGqKkjFQx3BDmOSopEMgnyCbYL33amhbzmdgpZ+5rI4mLvsPJ7r+RTozf
         xR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989503; x=1728594303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mclFQb/IEqLdXS1L3KMoEr5Yg8KzsL34jXvZK/E3Fts=;
        b=KFqCBHLxLehVssyRq7kjbOJOd3pMm5Jwp37WXAQxn8MHLgQzPM+zDsYi+XP1Lo2m2R
         qh1fcc47w4P06zYzrEqgFm7WVeu5j/59hv/nv1swwZ4HXpeutgoLoFpvDtdMYq0+FUdf
         Ll2fTL+2B+BL8vSvRxh25HCSrWi+rgfcNrt9WHNifFm59Gse5nhIW/uDC/TOpQaFlYFK
         VVjkAwwbUHfcLGO4JoUoWazFlPaGS5/mfv8GHir6eKQLdceoDruhD/Wm5LQpGzTRy86q
         jodtyaVJyDwB62P5KS4CECFGgJLvVcunwlI6V/fcIt1VA04/QaywE6enIG94naD1oa82
         u1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUEousK6YtjeupwYBtLw65Zg71JnGsO6EQR083/1dXGKtGSGwZF1suC0fZbCRWwX/6KmF9ZvFu1PBM=@vger.kernel.org, AJvYcCXws1AdNVXY2luokA1BKt6go1s4XbpTmAyHxXV4ZE9MbSe+ddzhhHjceueTwHStuYsMu7S/sgGHGaGh7qvg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7eTKByM5wNYg78Vq1cmoEhexBHyJVUYQnazub1xDAZH1Nog5
	JGUPXBADdmB4KMP/i80Qb+d7yFO/Y078sA4YV7it3ev9FiSb0SlnmbIPE/MD
X-Google-Smtp-Source: AGHT+IHw0jXmw9jJ5zG7S2cy+1n2kZN4B7eud70dJ8/6s5ZVLI+Rbgup6c0ci/aBn9pwLiGIAf/RZg==
X-Received: by 2002:a5d:4e45:0:b0:37c:d2e3:1298 with SMTP id ffacd0b85a97d-37d0e8f10a0mr454565f8f.55.1727989502745;
        Thu, 03 Oct 2024 14:05:02 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:52 +0200
Subject: [PATCH 06/13] iio: adc: ti-lmp92064: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-6-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
In-Reply-To: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>, 
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, 
 Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ondrej Jirman <megi@xff.cz>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=843;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=XD59c28xbYCxr4/KbA8MK4CIcyt8Kn/gccLgAtnCnlI=;
 b=a1u74riVYTcV4+ki4RB77MwTyGKVxGu2pHjSttfC9SDEGJKCWMtX9P/TyGU5DuRmDUHDPuQJo
 sr2tgXQp2CyBKghL148qE9OKXEJN+fsB2lFa9tLNNX43a4j3lwF4lsF
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 6c7bc1d27bb2 ("iio: adc: ti-lmp92064: add buffering support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1206a5487334..1bf915c3d053 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1532,6 +1532,8 @@ config TI_LMP92064
 	tristate "Texas Instruments LMP92064 ADC driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the LMP92064 Precision Current and Voltage
 	  sensor.

-- 
2.43.0


