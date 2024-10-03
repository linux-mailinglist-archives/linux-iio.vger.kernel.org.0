Return-Path: <linux-iio+bounces-10084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E202698F86E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ACD281EBB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752F1B85F3;
	Thu,  3 Oct 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anNKqS1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE681A7042;
	Thu,  3 Oct 2024 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989495; cv=none; b=gsit9aDtuU2IAmEfzHfRjV1uA+0a+fApyI6rEAbV3c2qOgkv0iCrJ18lXg7da0YkqMZIrD6rTKwrkbLPzyr3zF8AlHISq80FLjftqzFRiz0rwflL1Nzmqg2Yrr3Xdmcpks3T6klbemj+kcb0tG4b6zazNup5ToMnjq4YzI+VQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989495; c=relaxed/simple;
	bh=Lai3mFmCP9A8xrKP0nSXwPy12PzjycJX2F2BTQzMpH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PFRjrOpOYYDzOddO8zVf3n2cm4w7h0m/RikfzjQyfIZnM2tvrCZf4cvCBoCFsS+OVuMT/DdmMjXqzFJEitYgoTDsy6/YTGYTbfsep5lrNbOAii0tsabEtXO0dpW5kzw9yKaw1ocBCmqWy0vaoRJ74GDQ3FwlGNHgjqOBkUFys/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anNKqS1u; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so12923345e9.3;
        Thu, 03 Oct 2024 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989492; x=1728594292; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGOUCl2qINW3meXKxPFW+qXe+/8TJQouVSrPthFBRRs=;
        b=anNKqS1uaMaccX3y8GgLadcubk6t/Em3U+GNc5awCOcoloQhjLrPbVu8/HvfRPIXy2
         ahpH49+Dr0IWXbVGYrkL+1WSFyRb/JPY3UlaeEsKyqb10g/BZP6sUW0YWvK92V2+O6zy
         zY8KvCNSt/mULyeBi3wmnOmavTGaGC91Y44nT9Q1R/AtF72hfW5PztUjK4Iv/e7Vp8LH
         SvHLHPvahuSkVKBJtflHPp7cyRKq5/YIeYXVg3hVC/cIEaI6Vsq0ogUdS8M6hhaLzveV
         4/vGSQE8xaF/wbCMBSM4+9WrgVvOTRJ+bESbUhKyox1NMqtYHnMNk4opqMDa10PkDSGi
         rAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989492; x=1728594292;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGOUCl2qINW3meXKxPFW+qXe+/8TJQouVSrPthFBRRs=;
        b=HYhOFI39GcdjvpUMNwBfWypRu7OGiEaRoArtaecM+ZUEwwYWWMS1/zj9i5FrPCPpQH
         FYGKg+9Au0zVQy/8w4a/+69a5nbouvcgaY9vCdo39W6EIuCZwU+LUrpzMdiI0c6ywv6z
         LxUcP29tM41GG6LJl0HMGJTUXw9gAJTlbVA52z6jIf83V6LvXRqCxk6eo25QWB3pHxS4
         +YDFPpKj84EjWUHpxq6U9z0cXvJR9X3F3iDI5wmQ20rhjdZ+QptYV67kjSF1Zmggp97N
         YEPnCZSPRNf16SjG+ZaOLU/42xcebd5wiWkWT40vuNvtbGDCktIy1gmDUJMuF8s8z4+8
         xmjA==
X-Forwarded-Encrypted: i=1; AJvYcCUOSLZZaCjWMVFyYwlwfROp3FrVkXnD/JaDc0mrCqHzjPJ8EEqTWyn0GalzfS2zbkeMCrSs0coIxKY=@vger.kernel.org, AJvYcCVHxOzGHDXI9NWYp+U57s8m69Gi/B0ZABO/a6TtxTLxxBA7k/ryf8u07JpEZBd0ZnY7UBTwGReaJDpuNW5y@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsmj74hF/0cp37Rx0xtbylq1v3Qs2ZPtdMCGvD3X9Ako5S6zI
	mEqFLlLFQjC65izoau0VtbWBVpMaRn36U+4WHXYvBwEilDM87PI5rdE1gFw2
X-Google-Smtp-Source: AGHT+IF6LQdAh8+ulxNMu6qePc1Ab9HOM1sFMTmKjXDMBZIgG2MVt8w+8ux6qCRx/RS8geQaFaiv2g==
X-Received: by 2002:a05:600c:1c90:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-42f85aa38b9mr2223765e9.2.1727989491703;
        Thu, 03 Oct 2024 14:04:51 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:04:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 00/13] iio: add missing select REMAP_SPI, IIO_BUFFER, and
 IIO_TRIGGERED_BUFFER
Date: Thu, 03 Oct 2024 23:04:46 +0200
Message-Id: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4G/2YC/x2MQQqAIBAAvxJ7bmG1IOwr0aFsrYXQ0IhA/HvSc
 QZmMiSOwgnGJkPkR5IEX0G1Ddhj8TujbJVBk+4VUYciAROfbG/UZKpbnVEDQQ2uyE7efzbNpXy
 Boq+6XAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=2657;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Lai3mFmCP9A8xrKP0nSXwPy12PzjycJX2F2BTQzMpH0=;
 b=uPcs1JtBBVVxx9FTfO0W+4n/G0xq1HPOlm/IvYG/itoksm2K5xz5ed2iMeESSFHhQUp7LBDvr
 nnoD1YHHtbNCEwp39XI38XURKH+BYBquiiBoNX8bXxzsDygPGddlkMj
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The following drivers make use of IIO_BUFFER and IIO_TRIGGERED_BUFFER,
but they don't select the required modules in their Kconfig entries.
There is also one case where REGMAP_SPI must be selected as well.

These entries have been missing since the drivers where introduced in
most cases, but in some occasions they were not added while adding
support for triggered buffers. If anyone wants to know, please take a
look at the Fixes: tags for more information.

Usually you will not notice the missing dependencies, but tiny
config files where those drivers are include will lead to multiple
errors when compiling and linking.

I have already sent a series that fixes this issue (mainly focused on
REGMAP*) [1] in some drivers, and this one attempts to complete the job
at least for REGMAP*, IIO_BUFFER and IIO_TRIGGERED_BUFFER.

Link: https://lore.kernel.org/linux-iio/20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com/T/#t [1]
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (13):
      iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig
      iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: magnetometer: af8133j: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: pressure: bu1390: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

 drivers/iio/accel/Kconfig        | 2 ++
 drivers/iio/adc/Kconfig          | 9 +++++++++
 drivers/iio/chemical/Kconfig     | 2 ++
 drivers/iio/dac/Kconfig          | 4 ++++
 drivers/iio/light/Kconfig        | 2 ++
 drivers/iio/magnetometer/Kconfig | 2 ++
 drivers/iio/pressure/Kconfig     | 3 +++
 drivers/iio/proximity/Kconfig    | 2 ++
 8 files changed, 26 insertions(+)
---
base-commit: c02d24a5af66a9806922391493205a344749f2c4
change-id: 20241003-iio-select-209410bf9170

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


