Return-Path: <linux-iio+bounces-10055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4498F483
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF36B22296
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37F1AB528;
	Thu,  3 Oct 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIzFJbnA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F81AAE2D;
	Thu,  3 Oct 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974194; cv=none; b=mGh8CCmvsb3Dg0jijr9h1oIeVQMCW9R+/CsUMaVhQbCL7vvft9X0blQF6XhdQiPjPR49qkK21W8cvNM8ja34ZQmzH4/r8oEl83a4/9V8pbySs9bjkCrXhVmIHMcpZJY373TcsTZeMfdDgul2MkJ6wQDbcZdPLojZzyq5BPRoGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974194; c=relaxed/simple;
	bh=KuL6Jty3ju/PC+dXz4cubL3zBAGbYza+AeRd234TR5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s743O5L+j3oWwpv5V1OeNyBYbw8VivnGgjrJltEWEcM0VaoF/YLq4Cuwz+Y2fMwedKlK2kIe/8yBeC0GcwX9ESYuNYFCgioF5APjpHKhuYFqsiuc7V3v/ySN2tLsbZI+5A/Zz+4Nx3e0CGxoPLwIddPa0Hsbfg+dqf7xPMpR1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIzFJbnA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb2191107so11076925e9.1;
        Thu, 03 Oct 2024 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974191; x=1728578991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuKB7/zCVii/Yli2qSxo/OaK7dAcH60+osKBnu98JtU=;
        b=dIzFJbnAPLtm1sJ8X6M+wmxTS73bcutKM2zEriFzfniDKjBFkMP1o+3Vl1v7pEiuWh
         yAXOEyHwrhLJPHJMrQVkyfTyBjZ8JSwMgJg1ohGibfADL0bqF8QE+UaPhazS3gHt2uP3
         SCCAjirAcwhb9Ny1Tty9eWDRNu1xIfFH9D9X2xAX0cWzurqtokjst57UOYfLxqBqLFkQ
         ucDwQzJ7sC25tLYi0TJ45FaM1mMhNXcpKn2W/KjS/o4SQQcZ00loFAwszled2/aF84Vp
         QQu8JI0027G7ezfgzNVflhvzr8wuDUAu3XL8YoYhUoc/BPeFU/uYzjYNEzeXtbwjrESS
         q9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974191; x=1728578991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuKB7/zCVii/Yli2qSxo/OaK7dAcH60+osKBnu98JtU=;
        b=jOcOjK6nr2WddrLEb/IiL4MtcxKTvrJrcbKqFbF/T8PnJz4YztgBkwpPVXjh6FpCez
         0CQbA2USy/B6d4GaelbjhSiaUY9QC8GrNfz0D1hJPGt7tD+0j3d9QM8MGPjxR9Tpi2An
         q0nyjO81SkemN2GdNNazyz5fZO0NccIsmACZTOPDFtYZkG+Grp85Ihu/ngM4h5NVvpql
         1NSh1IjlayqxaCrf7ZjaYKVROhk/R0FaH54sQ9kD0PDUU0hvD6UDZlZGOD6Ilb7+WNGB
         4u/XTfUIHcLeD1IxKb+C64DaU30NKh4bPdSeKziYmwP4mlu5gY/YR3mHUT5hRmKujE9S
         54Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUTMjM88e+g1eqnSEqKtTUM5xIElTN0/bbSptREuYXgvade/WT8B06vjvrJxqwglispbupIPxtOa+1xxZWl@vger.kernel.org, AJvYcCXTWuzCG09vG8JSgTSIiYYyr/fsQgSEhLxffCNVhyHigYDUyULKmnJY5ImsMib8ZwPUF2ms0PSuhJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaumeAyMBqRvVueqVBFldHUHZ0qphBmpoI5ik4qIsefBp/S1p
	ETckANf2RmYLn8J3tj27aS03RKfr4XOXxe0KVm06bYUQFrdk5mshqVMqv2ze
X-Google-Smtp-Source: AGHT+IEsTE7a0h81XsYL3NLJoJwPWh5TMp9+8UACbufC9Knzu48LBFMDCuHCWDMmiFt6Zx+79U8tsQ==
X-Received: by 2002:a05:600c:3542:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-42f777b00a2mr56102795e9.7.1727974190570;
        Thu, 03 Oct 2024 09:49:50 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:36 +0200
Subject: [PATCH 4/8] iio: frequency: admv4420: add missing select REMAP_SPI
 in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-4-4019453f8c33@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=1441;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=KuL6Jty3ju/PC+dXz4cubL3zBAGbYza+AeRd234TR5o=;
 b=KfRYTSvnAXaax6bv2NEo+G48CqhLg17u8FrocDXKHMZQ+DxuEry9a8gRutzyB4X664V4kwY7s
 Q7838q9xP2zCK2FWt6InKtJx+NGRtn5nyCfazqA2VDvbmH1cSCkHpQd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: b59c04155901 ("iio: frequency: admv4420.c: Add support for ADMV4420")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/frequency/Kconfig | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 89ae09db5ca5..b90e1ac4b342 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -92,14 +92,15 @@ config ADMV1014
 	  module will be called admv1014.
 
 config ADMV4420
-       tristate "Analog Devices ADMV4420 K Band Downconverter"
-       depends on SPI
-       help
-         Say yes here to build support for Analog Devices K Band
-         Downconverter with integrated Fractional-N PLL and VCO.
-
-         To compile this driver as a module, choose M here: the
-         module will be called admv4420.
+	tristate "Analog Devices ADMV4420 K Band Downconverter"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices K Band
+	  Downconverter with integrated Fractional-N PLL and VCO.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admv4420.
 
 config ADRF6780
         tristate "Analog Devices ADRF6780 Microwave Upconverter"

-- 
2.43.0


