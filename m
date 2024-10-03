Return-Path: <linux-iio+bounces-10094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948DB98F885
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3332328287B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E661BC063;
	Thu,  3 Oct 2024 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEQbfKJP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13D1CF28D;
	Thu,  3 Oct 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989513; cv=none; b=WFA4VUWJ+hJtKH45LVC6hnwzsCv+RgMrZDFUH5Q5Y885WbLyCk76BGXMwx3mRlE61qvO0nbKHuRsdBHPY2OUZv+jsHnGtxzQjXX4m+DR38Uv2FamkG+pVBxNS59K9hVE4frOlDrT85Ib3HXbpkmCmOzYdUB8H/+U285SSADoUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989513; c=relaxed/simple;
	bh=CguLi4ExkwpedIuXQ8RM0+cYxgpcQ7l6JydNUQgZE/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvNVmjq6N3bieWduI9RTGxx+9n88GtzE4GZIx4cOgT+3fMoRWz5gwEu/KkgPHdapF3SpTP0Qr8EVm83kf0Gpm2RrmM2jkDcJsv3pqh8KIghfyIjxkBVYeE8QKHXDn/6d//oGvTcSpDv+hV6jqfedebX5M9OuAa6J85KwQB88Tgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEQbfKJP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so18281875e9.0;
        Thu, 03 Oct 2024 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989510; x=1728594310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki1JAeP5apWbM96nvOyT2TX3HZEowCpxj4RRdMMPvu8=;
        b=ZEQbfKJPpMJWotmJfrRvJllvN1gwH8980/B0sArlvJWzwBPo5rqvBD21GFd0hKc00x
         3MOsgiVPPZtZOoUudwvHdrC2EO0Pzr3vZogorXJCq9dLpeldEDFewfbaWGTxe+Rjq1zz
         Hm96BRXTCpjiGHs7VmZdYy+4jpVSRJvHeZlmHNsgvB/lRaxd2RL847IOP/EiEt1mN8ph
         0F/g3JOSvggkYNIjYttFOaBGht4phD1ZRpsTwMvCCkT/lIoqyYkj86tsNaqBKbkwvHNe
         AS7KpOYXouIE0crs40frSaQ5e79OWeQcheLy2Wu4JR/bn1IFh0Wg9/NwVtIRs05GGR2N
         NEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989510; x=1728594310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki1JAeP5apWbM96nvOyT2TX3HZEowCpxj4RRdMMPvu8=;
        b=kMRkfPmV+M7RxVAoRB/4j9guS3+8/noMH2+iCKgM3tRnWnkWEaWr57xay1Ffw57b7p
         J5qbnAf3fYDjhm1UEVnimXFGpRBULpUf+/WagtWY1SKoSHBqr9cs5B+VmvuMaV/Nk9N2
         M+0uyoQReUpjaEmP+7Gpi/juHijWr1TnmRteXei8aO8kDwZtqBvnCUJl9zuQDEqhyRGc
         xMl3AtDDvSpQ0W3PNPJtIcETvceQI+4zlnPdd3llISX8IUJJMJiYJ/vP0f3GBEGD/SX5
         e3+uLHQL8q3jmWz58m46LnGIAOu2LEcZjr9Y9g8WMsNpFeO3v9Pd+WRcwwJXC2k8p92o
         mtvw==
X-Forwarded-Encrypted: i=1; AJvYcCV7p/it/ONZyQD+BP0Oksk6HBrYZ3EbzO4Y0inCvX+tyw80ey0/itAQoD+TI1I3b4Vw4AbxJ675U+WQu1aF@vger.kernel.org, AJvYcCWDD0xQwa9HBCnaj0yZxBZRrHfasmAFtg5mjVgAbkHM3MF8NKlvlX/ui/XuSnMXRQAv4CXL3UNGGNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+u7o4kXWa9HbLBJGUxs9AdA+6TmVqpM3X5d+JH+7D6qLuQzxE
	UJO8jbpWrDqh9lLiDnUvxTTJT13ZCULFULgHiN+DAizuSbdfXpgOQb46Ae3n
X-Google-Smtp-Source: AGHT+IG1mNv1SyeuH6bEEQ7tizAamoCjLIOXaRb8ye301a6fKCfNxuqBQrEnJrRRBVW4tngWzhF0ag==
X-Received: by 2002:a5d:6448:0:b0:37c:d123:f3bf with SMTP id ffacd0b85a97d-37d0e6ec0ccmr537581f8f.3.1727989510251;
        Thu, 03 Oct 2024 14:05:10 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:56 +0200
Subject: [PATCH 10/13] iio: light: bu27008: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-10-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=844;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=CguLi4ExkwpedIuXQ8RM0+cYxgpcQ7l6JydNUQgZE/o=;
 b=SQJncED0mHeHDXklLzYt9Nmp64d1QSzbDEAe0QnJv14N5DxYOJCjpaGI7/IHEKnOA0tpmPkRJ
 iFqld8Gs5z8C1iKIlOt9j5rUkwz9YEFwKhmappK2lDIQRG372MEx4UZ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 41ff93d14f78 ("iio: light: ROHM BU27008 color sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 515ff46b5b82..f2f3e414849a 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -335,6 +335,8 @@ config ROHM_BU27008
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_GTS_HELPER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Enable support for the ROHM BU27008 color sensor.
 	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,

-- 
2.43.0


