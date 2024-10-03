Return-Path: <linux-iio+bounces-10054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D998F481
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0591C2122E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816C1AAE39;
	Thu,  3 Oct 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ZkoN0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F11AAE00;
	Thu,  3 Oct 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974193; cv=none; b=qwOTKap9oo2pWJ0ZKYVDINmOy/Wj2hr8gFIiWu9YrG02YEni7/ZbNeWgwRVl9+I587TInP0AZpv3lbSUckhWOEwt1QiKwu/3a6ZhwZbgaJMx9pMleaqZCefPbeSyZSU2gvccsR2i8EybZLDqkxIypU9wF5QwX2A0rAJQWivbLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974193; c=relaxed/simple;
	bh=YQb9Fktn4nABlRgqWlNH0XgDekpswG1wbkcGgES/2EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sO6OrdiubLjRkxRBsEypcrgpOIWLv6p1CMMBKKiN75kTrm6noq2XhhtQEQosZ2TaVmfInM1jbSuPKLKc4cQWiZCJTx0OOv0BXPoVB5uU1S6pZcI6rk5uUR0ot7d4l1qk+1wi0Krnm9blIXopONF8DydFxPpA7vwbNQbis6NCBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ZkoN0q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so1329002f8f.0;
        Thu, 03 Oct 2024 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974189; x=1728578989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BpFiq3PUhKJPop2qVkOxCK8tbrFzlmwfaBoGSgHstc=;
        b=N6ZkoN0qtixekZfwLtznZ6/R4aMZT5tP+ZGNIHTlaOpcAlCQqs5p565dh4yd4YAY0v
         lbNaAnfYW/5bwrboQ2oeu2DCAAxb5wIIzdLiJ44ooRc5gTwTKS3Rk+e6pR0lzt9hHRtr
         QuWMUfv4LaZCuHmQa2N+deXHAGfzQqUiGmmul8/9qZVfU12Svp2iu5RNSTYTjYXPhUYC
         7Hq3VRmjHm3mlrBjOyVfqTdPWWr+DWTO3lKCYZkhfo8lRQwaZghi82TLG32Khy/yxCnU
         cbPghcjioWTqVoMdmoAg0VGxuD6347+mdaWiYF4auhZce9zNnTeS4DOMW3PKQsQQLt94
         /76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974189; x=1728578989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BpFiq3PUhKJPop2qVkOxCK8tbrFzlmwfaBoGSgHstc=;
        b=C1qSuMazztJRi9fS5gkz1omXV3yvzHgw//FRI/55wX4TxAwcFZTpPkR5eBOJ4OmAtC
         Ew8kjlvMF0i+zJIxN3AI55tdn4VcWJFMqWpNggMANbdGkNRZEFlnS8F1jt79yEytCcye
         MWWGSbLZm7OxovZhqCECpYPrUOWyRhLwcGD6VcFFFUnv1vijrlUXTLXVqUFL1dE5ZzqT
         /3oyH2GIE1farJ5+YEXfqQqth3EvbUQZZ699ZrjXb9haJ14EC5mgSYNHsfVd9SqgWcum
         RYV3f0jwOEBqVHZhmq9iKGh1H4aBV2rTxhjZkuX/5imuO+BeU7G+9AyuwGwK6LuWraoU
         ky7A==
X-Forwarded-Encrypted: i=1; AJvYcCWEsgp16ro/myBDBykESzYIs3d4oVFOpee8Cu66xxuCygScBMo9LokiG/TJ0p6qEuksn1SybodtDyU=@vger.kernel.org, AJvYcCWNf9qEH5E2ZsThKiy1l5a0LwJHvNPPm+o7d7/4boCamCcgcvqSHJK+RdmsEWAxebS/20+Jp1UP7JjjOssv@vger.kernel.org
X-Gm-Message-State: AOJu0YwLo0fGqVcyiDV4I6SrBF71AltDmKjQ0o08SGwQuYU8EEDKy6Zg
	+Ju8IhYZZu/SncKfDOOx3ODNwPPKRrvUC9Rp32HOXMxgQk0gLmHbQU0PjBOK
X-Google-Smtp-Source: AGHT+IG/lGQSO6ohug5AS+k+1KKHvZm1Uy+crD5rEGJYqeh5XJy1kJm7GIzlAR/+diZ+HkaAw/UUYg==
X-Received: by 2002:a5d:4a45:0:b0:376:e2f4:5414 with SMTP id ffacd0b85a97d-37d049b7539mr2515348f8f.5.1727974189148;
        Thu, 03 Oct 2024 09:49:49 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:35 +0200
Subject: [PATCH 3/8] iio: frequency: adf4377: add missing select REMAP_SPI
 in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-3-4019453f8c33@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=822;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=YQb9Fktn4nABlRgqWlNH0XgDekpswG1wbkcGgES/2EE=;
 b=PVmuWEaZoGIi9HLU1yXIO36qtFVPt87rUm+8OPwY0sGLNyx55EkGwR7uWy3LXGViZt7tYmb/+
 YhxdNn/Kic1BPZSnu4UpXGg2CIuPdX6jrYcBUnUCtEgG9zWB0/LNZNQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: eda549e2e524 ("iio: frequency: adf4377: add support for ADF4377")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/frequency/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index c455be7d4a1c..89ae09db5ca5 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -53,6 +53,7 @@ config ADF4371
 config ADF4377
 	tristate "Analog Devices ADF4377 Microwave Wideband Synthesizer"
 	depends on SPI && COMMON_CLK
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices ADF4377 Microwave
 	  Wideband Synthesizer.

-- 
2.43.0


