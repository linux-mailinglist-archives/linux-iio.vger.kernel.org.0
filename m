Return-Path: <linux-iio+bounces-10097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD398F88A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AAB2820DF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D401D095C;
	Thu,  3 Oct 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQeQ8i8m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875C1D07A3;
	Thu,  3 Oct 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989521; cv=none; b=IK8/riRjaYfBEXZd6ya1yasw+ZujcRGzdTxKOs8QuQYBjTYIxIpFqtC24VHjBh4BsF1dCO5bQgAf/pNLGoSC7D5BT7oj/a3/5Ixq4h0kiDyCv4rYozSBhH25e4azP3ClFgC2bi/i5UDxtpuN/fGYSmqodDDYVqflYXsDmBbf1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989521; c=relaxed/simple;
	bh=o0zYywJ1ZvXSAwvX3QuGxeDPXmIyYTsa9IO5IBkzQ8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdyRi7KvubkBfmO/NqeEzEDss2vpXGwIEHl2I3TN25p6PyuS/mciGhY/lsOJTsHlLqRYdDQKX64t5CAIYfINXDF5fAGmJ6zMvpsEE2pCB/bUlqEWapP7/QI9TVVpQJDmDhCbnEg0/K7nf02tAN5DhiP3Ge9iELvaYqw+9HcklKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQeQ8i8m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb2191107so13009055e9.1;
        Thu, 03 Oct 2024 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989518; x=1728594318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOEbkDvIm8bwsGjTdm6LxDkf/cnoNWCEFrDY4G0tJHE=;
        b=KQeQ8i8mzP+lGzW6EIugILYP6pqs5YxIuK9H6mVmPmdqpEUpPpZeSzqpIowRM/7YuW
         o8Eb7BPP7xGEaSBRMWugJKAjd0TD7w0ozu1GuPOh2o8e8txysVkwCOcb1LNZpKPxahVs
         vAtoHABRoM4qrWIR6eCswPrlR35f2F3S6tZlpnGsI92oafLUmhuBsS67cckaPwtfAGW2
         lNIXaJDP2rocf9Hr8vkGsCgllZaJ3s+nqtW8YyYiNN8KOIFdDFV+s9GimXwVBBE3BEl1
         MJNtL1BlZoCzCl8zIw8NmAN0mlLPRI5KFNPO3+Ih0Jr6veA5Tfwu+NqG0e5O+jdjU3zi
         xQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989518; x=1728594318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOEbkDvIm8bwsGjTdm6LxDkf/cnoNWCEFrDY4G0tJHE=;
        b=dEzQRZ/wwtWkBri0MW6EEEfaxI1PSTQyePmaT0CHC2mM2iY+J4JUXZAOKblEVE4Ml4
         bxKuVagC8dsARZGcd6DsdWmt9u9d7fjVbV1KizGa7acYZ1mGhBNAWmg36HUM4syNsx/9
         UkEgzp7jDRM3jSUwUVhL+DlxLsjyWiqOqYqLCa0vDKnQbFIYjXQyhVnK0DqQawKQ6Wrr
         M34s5omZVjOqbe30ZhX7yNiD1rxJnxIyj/YvGGnFIZZRa34vNmrTroRX791GygDSR/Cy
         mqGVY6s8uSiyS5NXstws8i5XHtSEO8MzElJh/kL8+IpB12aBTmxsxE7mPqgooj81im/u
         oHZA==
X-Forwarded-Encrypted: i=1; AJvYcCUepuq/qfCJwSPSQ2Sm06XnTgDFKt02gFvLP7f4qKvpajk5mmbF8bz5Wm6JNiGAVg57SERrhvaJx5A=@vger.kernel.org, AJvYcCX9KLj/dgyQG0RUJfZku7olPzeNAMgl9sZenl77Qjby8lgmPpBcJI6ydyFpZeRdPtc99f2LbKqSVMRHwhqd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GwjqeM0lViwTYYlVe6TlD5CbFyoPIhEYC6Wu66c+5xywZiPd
	w9BywaII1ip6E0CXghf9Xwuc23H6N2DPMGpswq+wyKvhIRjbVMYtRUaUWXTg
X-Google-Smtp-Source: AGHT+IHW/xlRweKbY6aW6925W+CSuT+1lBDMge4LC/iCb93a8SzujJ/7Gdiz4a9kxbyyIsDfxUyxAA==
X-Received: by 2002:adf:8b9b:0:b0:37c:d53d:cb63 with SMTP id ffacd0b85a97d-37d0e736cdcmr366780f8f.28.1727989517491;
        Thu, 03 Oct 2024 14:05:17 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:59 +0200
Subject: [PATCH 13/13] iio: proximity: mb1232: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-13-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=906;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=o0zYywJ1ZvXSAwvX3QuGxeDPXmIyYTsa9IO5IBkzQ8Y=;
 b=84QZTKZhaCkZR6bzR3reUmC+iA4et+b35jkYmiJKZ6J452lzIwDdHO3ETf2NmS0lDOZNcxxql
 eZ9cYHJ6gheAr2fPCpTKlgjRfMqEaMnn3kbwxcSJt2sgymXHXGe/USx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 16b05261537e ("mb1232.c: add distance iio sensor with i2c")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/proximity/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 31c679074b25..a562a78b7d0d 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -86,6 +86,8 @@ config LIDAR_LITE_V2
 config MB1232
 	tristate "MaxSonar I2CXL family ultrasonic sensors"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y to build a driver for the ultrasonic sensors I2CXL of
 	  MaxBotix which have an i2c interface. It can be used to measure

-- 
2.43.0


