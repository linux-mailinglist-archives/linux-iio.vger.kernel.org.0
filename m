Return-Path: <linux-iio+bounces-10095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6498F887
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AAC1C20D24
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F8D1D040B;
	Thu,  3 Oct 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRfJbXen"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88F1CFEDA;
	Thu,  3 Oct 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989517; cv=none; b=dxYczColY6xoksNXZiCrh29addsqcMnuv4ayW6uYQZ9sGZ8ZHn128CtuzzeTgH+3miHUkjZkim1181BI5/jjFqw+il2Rt6eRDahvBK+b0YOWNcJ5PC7Wdacp8d+Ni4ZOEsmjxnFyHRguVrKRQH05SuMTp28jboyEUtOryd4pxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989517; c=relaxed/simple;
	bh=fK5pU5P/nNKxxjfclKfHupd3FpLZ7c525uH6tbZS7UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGMydhsQgJ9uoUZRopCnM4T5v/1WvBBYGN093qD7O0g8Zx4p8hvi7Gf2IT2cCX7MY23JSrfoDKMc5+EK63xcoWky8msALO3ooeYt7QUzkpYZtemilZI6DqjsTwnT0Snl8xYS+3p5jHZA10SI0ht82bXtCV84gwZhrlnLyZPxPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRfJbXen; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so1271375f8f.1;
        Thu, 03 Oct 2024 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989514; x=1728594314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpvQb1mq4DGPaez0kb0p5c+CTR3OdsMiTzXt8cqpGLI=;
        b=PRfJbXen1x/QKJ6IosMaYH5/O1yMJg1D8Gy6vzA+ZWlPVyle0isI2WpMbZjBcAmun8
         wMP6MIgVtV5rIJf3pV1hfLKHgv435Cr6YwRCOsy1n6PgEyu7vzt0I4X5AskmzJJvZmhL
         K7g8A4BC4eYzg58XHKpz/ojCQwyoQBFLyLtBZ7OUgGe5VNNgB6suMYWTi/Bok0NquIhl
         YjwrekfUmaluCk8xPgSI16UPFvM1D2dgNUlQvfcj9WVkgHxAWtQXjwmjd/vzAUO0GtWi
         vn/AcCRjBL3cqZh8isPHAQdBEGHTLsjmz1WcmL/sjgvWfP6UNTNey9dQlnSchYhf+0Z4
         Njxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989514; x=1728594314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpvQb1mq4DGPaez0kb0p5c+CTR3OdsMiTzXt8cqpGLI=;
        b=T5Z6+lsLZU/kxUfREEWi0nRPgbjLqW49r48UsGJl4aPHv2iW6I8MSMhwvCcUSIUogd
         nPtB/h33yXN+3+yHfsNSAvB4f8AfCOJJyiBT1YFuNI57D39nzfl97gB2tUaANKkPmFDS
         rjw4I7ef8uAJCSA7wyLQqHWV3eCpuFxCx1RUEyQbmhakx2kG+i4DG8qVF+vRfNt0s6N5
         HJUvN38U1xitvNJ9a80nCGoouhi7SieNc+aSu+BJgplo1fYJZS+YMfOrMTr3AVDUiCWI
         44zNO5oBrkTg8t2LDjMB2IdodqYTbF4M5KknWInLd46Vfxf6yyYdMMlq+VVaTtvzg097
         +j9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVceoBMyTgG2kCPJsvJ4jOZ1MMOZ7RkdtY6/nOxIzrFHnaO/5oNoMy/eu1xicrvB/B3o9tzG1xUdPc=@vger.kernel.org, AJvYcCXoxO0zD9oXmuR2vUETBb8/jS7O+6SLKKpgDMHzZOAdVziXPy6upcMH33NlpEV+4Rd7SynWhhkUkU1Igrkr@vger.kernel.org
X-Gm-Message-State: AOJu0YxNliLpunwkxbzJckR50ix+33MsLCABe87Hkw45rm0RSrluShFt
	YclYul6vldZegxQbvtYULPujaoJJXqeB3ngS8JcqnFZHnYz77wCmCInG+EHh
X-Google-Smtp-Source: AGHT+IHjTwSyCIACIazB9FY3st/vrrmcOq9YFfD/Uq4zfVFGQ3bO8fevudvMtW7mimiGpDcZZGLy8w==
X-Received: by 2002:a5d:5f46:0:b0:374:c6af:1658 with SMTP id ffacd0b85a97d-37d0e6eb8afmr731554f8f.1.1727989513807;
        Thu, 03 Oct 2024 14:05:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:57 +0200
Subject: [PATCH 11/13] iio: magnetometer: af8133j: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-11-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=872;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=fK5pU5P/nNKxxjfclKfHupd3FpLZ7c525uH6tbZS7UE=;
 b=S4rv36vKtTBY74hb8xJ3m5HlOQsKlTJaYKlH+EZHpYGFuCCsB/8UOGqLtAlQBFjWyxNWRTv7l
 4T9plBSqZFZDiYcu063VcuQbAGi1rFDEN09s92QUwTupFIDdET4PcGL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 1d8f4b04621f ("iio: magnetometer: add a driver for Voltafield AF8133J magnetometer")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/magnetometer/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 8eb718f5e50f..f69ac75500f9 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -11,6 +11,8 @@ config AF8133J
 	depends on I2C
 	depends on OF
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Voltafield AF8133J I2C-based
 	  3-axis magnetometer chip.

-- 
2.43.0


