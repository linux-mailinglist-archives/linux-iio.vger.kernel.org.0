Return-Path: <linux-iio+bounces-10058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0E98F489
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9DA1C20B11
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A21AC427;
	Thu,  3 Oct 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcrrFfVr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8B1A707E;
	Thu,  3 Oct 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974199; cv=none; b=V4VdkZDqt0FPIVbMCy88oCwrNk1TL8bNxYaZAXmVnAtZfUh8zLp3I8YLAn8qKlwobM/F7urw8I4ig2AylAF+AQlrnDvF5dwl/UMoq/XAm083lY7K4rAmFfJAKYimdlTCj1pAsr53XUGJccVe8Ck2d8iaWsRYHioR/bLeksifzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974199; c=relaxed/simple;
	bh=BBOiYyG846PZfy1vjYqIRCTmMXGkQS9IkdPgQcqfOOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHSwXc0wsMGWGKoevLI1LYtRpeeEmPN1gNRPqkR0r11pMwLgb3f41/qVtJOgRRrhWbZLLsBaHXdRPogwGVM3m/ZbcIvBnx2TogAmFX5Sle9LiUJAp2o2HVDbfL2A+Q5ypZLND/0wN6f1tcjROr/Uv4oh/PI1Qxl5ODeNBdMU998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcrrFfVr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so11175405e9.0;
        Thu, 03 Oct 2024 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974196; x=1728578996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeMLgap/sYuFhHx34dDTHROBJtr85UuEx3v3CO2czsA=;
        b=LcrrFfVrtKgLuEWfgbotT6tX9gdHhuRbQyJp5QBljBSRvhry8cuoOnNb9tbl3AmBsw
         LcSfpZmEGqDBL5Pto3ddiabruzdQzQlLnS4iOfEeG3ZeQaw/yHWuqVVfPB+VR22wg58a
         9vNkdXdleNxDdobS6L+dtf3PixnN3aMVVfhSU4xF9LnDw22SIvPQmMnG4bcClrfB7abB
         lOGk0vAhq6+ip2gMRFu5nJdGPIQcn5s3xW0cGSAMflixtrT42SH/Fv6zSCXosChe59Wq
         v8XHccaqgbDz/y/AVoRPnbl32UleJtprrj/DUzk63tMsypkmjmaSEUcAHYPx6L15ZJyL
         N4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974196; x=1728578996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeMLgap/sYuFhHx34dDTHROBJtr85UuEx3v3CO2czsA=;
        b=BS7VHYd8iI56ZPb4Y9EBnK2cFSzSdaIvKjJtLHDLOym6eTtCDP/hTrRQqXv9UVODWM
         IBEjHCePb9UxyLWPFiFA2eS5esxsCMXlMugwL+fkxKaFF0KWafCaqAK/edpXeDnjmM/b
         i+FPimkIXQYSusVbdkg7lfs81yz/6RGHVnM9DGGBUWdSEEDmjMWB0iMsOaCbKu07Kuxg
         /PgpuAfQG6z/CzrIT4ZYBFBe6JTAfrhjCNFYjMpCvZtzj0Xbx8Hpuyx2SeY9dgQL90cK
         0TVyaONb12UCgq1nsKJVtMDv9ogd6qehlR6mfncZEGgW9cfMYnmxqqoLVYBk7d4lv9HB
         TNpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLG6GQKt66apXKcdOotmlgJTs9Ue7SBM8gqLiBdIiDIBV2hYp6Bg5oCCrj84ROmvH3xXA/u82Wds2a/Zv@vger.kernel.org, AJvYcCWJyyeEWyE8ai5N3va4mMpH2c9YpZo0W4CWlH7i3dkf3ZzCS132JRkzn8K0kSICsc0ZgbmuiRGmtac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpS9h0xoYHO7RJ00p1+GcBZR+tuCCMJMQgVLRKnIkREfMvv7j
	zEw56n2URYGdQubrB+SWWXd7MppANIYMGFVVcWeMiB/OdSDT3oGmoZySNYsW
X-Google-Smtp-Source: AGHT+IFmGb4w0A0HceHPEJuT45bZSB7rqUmneMmI1OKCrqlowBfyCr/68dRdIduPpAWqCmrR5rSDoA==
X-Received: by 2002:a05:600c:4ed0:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42f778f12b8mr59258735e9.31.1727974195523;
        Thu, 03 Oct 2024 09:49:55 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:39 +0200
Subject: [PATCH 7/8] iio: dac: ltc1660: add missing select REGMAP_SPI in
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-7-4019453f8c33@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
In-Reply-To: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Cristian Pop <cristian.pop@analog.com>, 
 Mircea Caprioru <mircea.caprioru@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=777;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BBOiYyG846PZfy1vjYqIRCTmMXGkQS9IkdPgQcqfOOc=;
 b=nBFm3Gc91JdpQDCbhgU/q20hldeYQyhgzM8lnumf1wrJtGWs/DIlM4evwDhj0aVl3S6E4rjcW
 Zk4eEK2TZspAOmW06SPAymmGU75PVQ92KoGOXSqrua4pVj4cDDdTy7q
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: 8316cebd1e59 ("iio: dac: add support for ltc1660")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 3160b10f2752..f13daf0fd9f7 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -354,6 +354,7 @@ config LPC18XX_DAC
 config LTC1660
 	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Linear Technology
 	  LTC1660 and LTC1665 Digital to Analog Converters.

-- 
2.43.0


