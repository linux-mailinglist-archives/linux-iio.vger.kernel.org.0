Return-Path: <linux-iio+bounces-10093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B198F882
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13B32826CD
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71E1CF290;
	Thu,  3 Oct 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al/APesM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCD1CDFD2;
	Thu,  3 Oct 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989512; cv=none; b=l5lzk9Pg4BFn/mXkPGBL4A4AV86eOUmsF4YupihwIzm95KdEMp+ESLdUYy9RWKnaE1ZxCei0p/3hSUGTaIcf0DrzxNpPZB844BJHHmqDdz82TdawwUb0pHAjkuetrhYjzh+SwEw2J+0qWozWOHX0IfRJAOh+KddP7wVa7P9mVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989512; c=relaxed/simple;
	bh=rkCt0h/rgrKa3TuWQg1MveSKjDSn8yXdazkeq+B2pt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNSRE2Yru8e/2ySj1lcJ72cfsrDEAm+esrKt49Y3iPQWi9CX0R8r++HNnZdFFxhII2qq4WWILhwkjfdIL4EcZtOoy3KK7aNieB19cSzEiICE7I7n4uKvJUplOaqitSt4RhJAg2U4UxgMkAb2MH6WAelID+pPbeyZvc683dZGEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al/APesM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so14298515e9.0;
        Thu, 03 Oct 2024 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989508; x=1728594308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0HtA3pbNoZbNjd9QJfjsBq2ixNTEWWW5nHq38RWaQs=;
        b=Al/APesMvvvML3s4E3+YQubWaw2aEs9lZu85qXgeBsy1GE2socbVSS4Y2Zk8qqfd7C
         JCQw1T4BTC+E9yIsvBZzxG+uPbFktij0ZRJF8KkYg2CHMaCO9wYK4YAtroRVTCB1ta6E
         WyGDPZHnMduemzrYarrITQ77Nfhyh7OaBrRzI4xKYXx8TJkuKsEfzaChmCM5e6DYNRUj
         bKEdjG8Ss4k5b1f13DBaqc53UzPtqO9mIrqxOPGP7sfNuSyM/V780SNfGu9HCZGAR91/
         NGxR9OvbA19/SUSHCd1uodA1sqsijWlOWWiUUP1SpI0zAK5yHD3jblCzbmaQ7shqla8I
         c/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989508; x=1728594308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0HtA3pbNoZbNjd9QJfjsBq2ixNTEWWW5nHq38RWaQs=;
        b=ROOMrmmfEV0h+XundhwaKNLk/n2tvq7BO1YIZDYfCx/fPg0BffleX+F7p4gsIOgkkJ
         wQsJTHgvbYLkfTgE9GNtL+F2RGHe00nExP7dgmVeM5bdhqeWcL7PIcsrqY+JMfpuL5G7
         SsyiNak0i4rMCXIo51j5wlaEDjjgPavTHPsml0M7eSpCahdmDq3CyfpoE+GTCWAsttw4
         SB7XXOcoXZsmCp/4yNVElMifJTDHERc5Ie+GM0ca5j+CsznOVNPmJrmq2xVftGFUueU8
         3gHOILcQlVKP2pnIKdPCuusnaJEnuDNCyHzsQi/lXQMfG4DYL+QULohwY+BRKv95o3Xr
         h3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWVRJmZ3HFneuW17fPc3xF2hq990X45naKGiByNW18imxVcmMADTt1B6Mj6v19rMmC95HND4fEhpd8=@vger.kernel.org, AJvYcCX8W+Lfs5dz0B0YnU9sDDQY74aO58PlpMjMkDqCiLuydLpkEpGX8ZqQTc32ghO0G+vUAgT4akox35BOUr5E@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOZS476y9c52feeWNMRZ23E9jj80nBfgoBV0zoelEd5lpVwQr
	qa6RJOLMXdBy+T32e7yEHSbbkaWpIJPsZ+WRz/BbtgxqsqkKawQPWrDuVE/h
X-Google-Smtp-Source: AGHT+IE9tDDQu6boouxZvYrqleFQ8fhVude6hK8RDshw4icnW+K871HTb2xSTPWErl/nZQeYQxaGdg==
X-Received: by 2002:adf:f54f:0:b0:37c:cd64:939c with SMTP id ffacd0b85a97d-37d0e8de830mr425955f8f.44.1727989508293;
        Thu, 03 Oct 2024 14:05:08 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:07 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:55 +0200
Subject: [PATCH 09/13] iio: chemical: ens160: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-9-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=825;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rkCt0h/rgrKa3TuWQg1MveSKjDSn8yXdazkeq+B2pt8=;
 b=YFiypOPPXXhsdVsLmy65Irp4zhXByyYLAwZY6ruEqxMrWszg8f8SaxRf4NtEj1tOBedH/zyS7
 8HO/URrlJ26CLBH6Fj6a35RRSjClBiPHUU/tkIz6msFWpo40oikp59A
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 0fc26596b4b3 ("iio: chemical: ens160: add triggered buffer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/chemical/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 678a6adb9a75..6c87223f58d9 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -80,6 +80,8 @@ config ENS160
 	tristate "ScioSense ENS160 sensor driver"
 	depends on (I2C || SPI)
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select ENS160_I2C if I2C
 	select ENS160_SPI if SPI
 	help

-- 
2.43.0


