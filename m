Return-Path: <linux-iio+bounces-10089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E330B98F878
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211341C21EB1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B61CB330;
	Thu,  3 Oct 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQVrD42F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D81C0DFD;
	Thu,  3 Oct 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989504; cv=none; b=lhFlBD+E7iJe2WHlqphShoZTYM1e2JEAfDoqXPW33CyEwqQOKoSHx4DYqm31jnxI+yf+2fy92O/JXCwFC8wy8Dt+tvy3wYDPFHjAqrM5x7inQP5HpgSkzldpcIhWhB9bRQMN9FpKI/IEyDyGUJ8uu8CDQJbDpPLouE3MBwUF0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989504; c=relaxed/simple;
	bh=om7nGa7e38LSyDcypOxeDmfhQmu0fTKuJNT54Q/SfS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWLi7FjSqvsGcTPa7sQnjiPSiACuz0kr3hS6DVZnv+GvV/bd+ulAYc/+GGGqU1OMzoen8o24YGvDCYtntStznNBtJYMBnG9b4yZS/vVnj6hBI0ibQl4HTtHJF94fDxiovtmBzxnLNfYlO4aZpGcwD7uiUIROvcT80c8a+KQz9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQVrD42F; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ccc600466so817534f8f.1;
        Thu, 03 Oct 2024 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989501; x=1728594301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5dRsCWrSpVZQ5FgxVkWtchmDx38MXT+edotpWIhtuQ=;
        b=MQVrD42FtQ49nYo9BvYeLZCq4wWHSd32+aGyQoIy0V7bABY1qgbOw8tkodF73ImwU6
         ROPATLF9DyoeSeZVhfujh1l8CVIeoW0IpbCLFjc+l5otRWmZRipD4kqOs9iB8POo8xyG
         zFDGqATjAPr1w/ms8vzjrzBBh4IC1OE8sffTlquUXb17pgK8N9/Ypx4n2VsjqhNyDBvm
         WG/hG0RhCBKCbVC6zTIgZZfhVep1B+W0uWKbt5GZxM0kidcpJ1QROD7oLzZx1+cGi0yf
         aYaF+owbO13f3DWvaqFcAdFctngPj8i5gsKJFAjEq7kaoVbC/YsMqsM7pgNiSPMYKFiO
         GrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989501; x=1728594301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5dRsCWrSpVZQ5FgxVkWtchmDx38MXT+edotpWIhtuQ=;
        b=FXJDwoscBOA1K17sdKv9cy12qHX4n8c5DBl6JANVFIPIIsVvHuYuwz3uJ6RLqOZ+Jq
         X0ER15alcuw/cSXSfRW7S6A4ezKeDyjPDv8uS37Nke+N7RmqSc5PfB3gnJs0cFSxbrVK
         84q35I3pEFm7G4I3WZW7hk8t8+e7y2TAJQ6wkXTSlKUlpFXsGOTYhN0FmBqaUQWXZjZs
         v/EaCDKrhRJQGiXhZK0otBhPv17bsePK8eXWyTHn45Gfz2hVOk6AczBaBjdKxZV8TkTj
         sZnuA9sq4LCUcrtd6IupwJh09T7zzjk8TqdmFkVWrkHewl0OQxbpxZQghvqvlbx423gE
         Gblg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/wYQgdawRU3E/BFK4CnGXq+bqfH8+Grtw8A4cjcIr47CrhBk6z5NHEh+vYihKG/WUdDih5P8hWJmjoOD@vger.kernel.org, AJvYcCXJ6fwyY4+IZ+k9PUtn6Rz6v49K2PrEeI45zctmY5rPMq5GHrMi32UzGhZETvgKVRE+fgLSJR326Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVAdW9HjEF3XGbavTbfOW+o0Lpnp/2JXnZcIGUzqgNDprKCnk3
	CKCZgErV9vY/4t/9jP5z05VfAX0ZtGos0y7aVIIZBNIwl79YWWfWNLTZR8dz
X-Google-Smtp-Source: AGHT+IHLpH15NP3JHPl9pJi8UAr1waa7nyQ7l+hUUxfG+W/WM6MB+vCNXRTkhd07kk5xBriy6MJrjw==
X-Received: by 2002:a5d:6342:0:b0:37c:d1c1:8e07 with SMTP id ffacd0b85a97d-37d0e7d5258mr371267f8f.51.1727989500898;
        Thu, 03 Oct 2024 14:05:00 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:51 +0200
Subject: [PATCH 05/13] iio: adc: ti-lmp92064: add missing select REGMAP_SPI
 in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-5-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=779;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=om7nGa7e38LSyDcypOxeDmfhQmu0fTKuJNT54Q/SfS8=;
 b=rZvVfoLSeBz18dO9SDZRp7Bk2WzcWGIAIUY8Un+4cSzOTCDLxjteivXRjbaWys56lvCDGIAcS
 vF7y5DizmG9Bsnd5zaZPtQhs1brTENmV48ij9L8AcbAGoJ1hGGAwCwv
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: 627198942641 ("iio: adc: add ADC driver for the TI LMP92064 controller")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e6be1f1ec79f..1206a5487334 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1531,6 +1531,7 @@ config TI_AM335X_ADC
 config TI_LMP92064
 	tristate "Texas Instruments LMP92064 ADC driver"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for the LMP92064 Precision Current and Voltage
 	  sensor.

-- 
2.43.0


