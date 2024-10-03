Return-Path: <linux-iio+bounces-10088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09A98F876
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E2A281037
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0051C9B6B;
	Thu,  3 Oct 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuxuEmN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB251C6F43;
	Thu,  3 Oct 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989502; cv=none; b=TJqfwhCyd/g5rzRzvDB490MG1RAYR8+Gm1DyfbeuB0FhYtt4Jg0FQK1Jl1X1yydzWTCfnR+cmHZPxnUrCDGfhCut4uFXKhGPBq+vyTXg0MBt1kcOr+q6eSelDuu2QNZws4GvbgGyAQvBaYJX6ALdV3NS/EqbL+ipm3NKIdhC7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989502; c=relaxed/simple;
	bh=W40NyMLdpARWLuZYqzDsCfacLvyDNM7oFTXkUJUfR6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDTOgMY/YS1HoUwSsD1b8IF3M5iPka3JFEGKUoApk/asGXG35onJ9iBuXXr8oCzY4SM2dY9NHpGhFNfibrtKtpy6o6XAnSxbUS1EUbvB+ibewuXsw5cSw6+8PbmOl0Gsa4gc6VFYqQHjoDujOahZd6VpGp0TEQV1Q6PSFEOq62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuxuEmN/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so13368435e9.1;
        Thu, 03 Oct 2024 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989499; x=1728594299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsL9+8ZXSavJ8pwggBq282W1a2YZcLbC2g6a/0WNPa4=;
        b=TuxuEmN/h1Bc6Wb6KgCy4FO5jreFnJ/oiQUjyusGhUgL1BBbc9CBJRbVQV3wvid3DY
         N1xARCj3/avgTJucnunN5/xqUoDmw/BniNFPPNiiBjMiNx69RQBVNGXyrNPjVcPD2f0Q
         +C82Yae+hLM+d7mHwBl6un0s31VDTS8KB2ABmtEDv24Q8fy6UJK3ARItMlt/6PDA03zo
         nO2k0UVr+dwSwbAoP15uUihIserHzdrfIgJMDD/0smJBrOu+0lXN3H5Op5vLITwzMPb4
         jaHRKgYWx4PW5ns9R0kmh/3QK9Q3Q7HPQjveiTCgl2t0QlHquFnWcR3ltMe7QEhUTNKw
         SGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989499; x=1728594299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsL9+8ZXSavJ8pwggBq282W1a2YZcLbC2g6a/0WNPa4=;
        b=ganlq/GzP65qJv/uThGKAps/ZvoxsdV7RbmWWKcHiMRg8wss6zYjxBC8soww5DY1hP
         eFzCSeVN5ct2a0HeJZOR5tIk6mWyEpcmQB6c3ouzgUcTsu6bhsErhf1iC2KziOXoUJTC
         tm/CDMtlHMWGAlEQbnk7VMFVVCUFhEbCm4Bi3Jj22gKYTt457gSWaMs5afJHqwly6JDD
         PxUVvUZPaHCtEvKCL179If/J4zVYlARsm7u4IIQywjwOlBtirvhhbVgwHTU6BG3Ia52Q
         RB8xkqla4twj4c9j1edEK/9Nqldyd9DxAYeGjT6o06LQBVqvFRw63VPBp/rme6N90eNv
         cN5g==
X-Forwarded-Encrypted: i=1; AJvYcCUCkQCKnHakw0qCCQ+LPnXnWOU6pcbHD2+ukvaUULuzyiCy5iw36soqaeXPedfQsNqBSVPX/idqwyHclEPe@vger.kernel.org, AJvYcCVRWXIcREr+tndAqQJmPEX+bEDH2qsShF01xL0j9Bt/+5osl/9mGQlwUm/YzKHG1mbAnYv+3MI88T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXuut4QsLPWmwGU3eI/25n/21G48EssWXxHqE7H7FIGBT52Uh
	m8fehH1Avv5G0z+lnDpzaMT+rNTEwonOnF8SP+fyqZfVaZG4Qk19k9+6wUlY
X-Google-Smtp-Source: AGHT+IGK8u4ybFbXUQuK3KSaPo1xdHX9JcNtwYCgoq+rweKiz10BuqatqfCS3gIRIDSuLJf7F5zqkQ==
X-Received: by 2002:a05:6000:18a7:b0:37c:d183:abd6 with SMTP id ffacd0b85a97d-37d0e78e12cmr491680f8f.32.1727989498955;
        Thu, 03 Oct 2024 14:04:58 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:04:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:50 +0200
Subject: [PATCH 04/13] iio: adc: ti-ads8688: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-4-67c0385197cd@gmail.com>
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
 bh=W40NyMLdpARWLuZYqzDsCfacLvyDNM7oFTXkUJUfR6o=;
 b=vAmhEKvimr0optzfzUjulhiBy0NGXNZ/8EKJ28wXgF5wxjxc+lApEqyveBa1QqlC9q0Cj9TUj
 BGEzocyyE+eDlX0JJN4GdG9yYDK5DlHod6xvvHGU+BLwm3J8T7hheb/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Fixes: 2a86487786b5 ("iio: adc: ti-ads8688: add trigger and buffer support")
Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 45872a4e2acf..e6be1f1ec79f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1483,6 +1483,8 @@ config TI_ADS8344
 config TI_ADS8688
 	tristate "Texas Instruments ADS8688"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS8684 and
 	  and ADS8688 ADC chips

-- 
2.43.0


