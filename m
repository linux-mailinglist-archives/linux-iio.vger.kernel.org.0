Return-Path: <linux-iio+bounces-10085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F43198F870
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919571C21D86
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F01C0DD6;
	Thu,  3 Oct 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxYVEHtn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21831B85EB;
	Thu,  3 Oct 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989497; cv=none; b=NNUNRB3SARap2BCKYMyhI9MK18bGmI0TqTbXjkSgAh6qT4XnkjgqiC1CEMAXwGqOXG3iKcNt6BhVgs4Yyd0poVDQ0aVBRK5AX0rY85yUoLOzAiagCDhEvbMZfrE0n7iTg9e90VDJQTLCUAKEv6+Op2/v7eYAUCJUVq9u1hpnTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989497; c=relaxed/simple;
	bh=YZs3ZXnNhdkbmML8544Wx8zMstwgjP3YkWnOJFipDvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gI2e3QY+mARg1IVgeMXnaEK+YDgSj18LsEBrSdYGsUkzXIzm2nxUOc68CGg9Nm4VrcxeJsa7VASi/HHOJiU4htw0Hre8oMqOuR2EoxjeJbsNjx5PkLIZDJc8jFSmzuaa5TWX1rWoaJ22eilrB1erEK4wqtcilAHTFJv//LLuY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxYVEHtn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so13287775e9.3;
        Thu, 03 Oct 2024 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989494; x=1728594294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feOIeTPlq8NeF7AiqGZg7SrCBKzWV52BYb0Z6DqS1qg=;
        b=bxYVEHtnWdpXQMljLjf+fo5Z2PMnpuFCC//L/xC2qpNZQMaE9ir7NH0Lf3PCxhkeY1
         WeCmStk31MjFefU+9PjXy/MGHUEhgWeJ7FqqukqaOQSdXori8Hu10utjo9QvxIPukDQG
         MptWoeRjM9m6gvv/elPi20MtIwSbI3P4xI1I0zN9/13yqBZDqe6qoLLvUmR7IzWc2rPh
         C1cv+G4nLm5RZXCFob7eRd8jeuABrLbtAVvaEcAYhfzXLl0dWBOgFWfIwX8Wg93pbXfK
         d77Be1RDMoUkV/TADahKeyzJ/wGnFAX7OWmH6gewFQFB1+Qft5g8am2HXlmAEq0XIWEn
         EWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989494; x=1728594294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feOIeTPlq8NeF7AiqGZg7SrCBKzWV52BYb0Z6DqS1qg=;
        b=tWhlgZYOMsPiz64jpufdjJ+MSF7ySQjGpx0ruqfOG+DK+RKGxh51Y6h+HC9c8PbwG6
         ehDGAHIXgbXmWULCqCFn8/je577vFLu/wFONy13fJ4dU3ZcvhOMIN7HhqMBefCOw5nNT
         rib1crQcU6gV0b+RLWO91HeDbfAmeBT4ND9ekFxGorXWBxLvbjlqhoOqAH32CChLEdKY
         PkuFajwCfVlG+OJOhnsshHyLHqQlZhF1U2Z5vBVs50iwmVapk53foozdbn0aDcBa+ats
         9Gf7sEeP8RN2G1dptwJDNDc1NC0BnoXdHwkvQBC1p2XazKoYQRbadRxK8/cV6qhkqMbD
         z//A==
X-Forwarded-Encrypted: i=1; AJvYcCWWaUh66bDNd6tI8QPjwvR6eYny9CebJqnytGah+p/Hu7rKr4AgZEAZ8C3x7Y6Nw720qYTd0YG0BRg=@vger.kernel.org, AJvYcCWYdAvc7T8D+TOgcmKR4+RkbO/w1m2wsaotV/zteKtr8krqSbtE+eidCaSMTql25ccQjjzSCFBekkA+5gKz@vger.kernel.org
X-Gm-Message-State: AOJu0YzeohIGDqmVNEhKY8q0zxgZ3+Z/wKGGT7ucez5XUYdm3wzWncgk
	E/polAK04RU4+LO52rkVOJznYDQKsaNG0aN1msIxouBM2kozlQDvBI4WgH6s
X-Google-Smtp-Source: AGHT+IE12AX0Mo7nv9ZwrDRao19A3nTaCBPFMENPw748ZqAh06n7VU+1YkPLIRqqkysD3knvlEW59g==
X-Received: by 2002:a05:600c:358f:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42f85ae9134mr2284905e9.25.1727989493537;
        Thu, 03 Oct 2024 14:04:53 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:04:53 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:47 +0200
Subject: [PATCH 01/13] iio: accel: kx022a: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-1-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=811;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=YZs3ZXnNhdkbmML8544Wx8zMstwgjP3YkWnOJFipDvY=;
 b=hpUiAJ7Gc50MT3qBP2FeM0n1WXo5ktL9bsy1VMzZ9I14BgwlQoJih26rzBWMk9ldP+PnShFQl
 Co1+mtkNDYKBULBYZfGtcipBI2a942bSR+frcDprBGx7orn6kzJi7D+
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 516c1a8e4d56..8c3f7cf55d5f 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -447,6 +447,8 @@ config IIO_ST_ACCEL_SPI_3AXIS
 
 config IIO_KX022A
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config IIO_KX022A_SPI
 	tristate "Kionix KX022A tri-axis digital accelerometer SPI interface"

-- 
2.43.0


