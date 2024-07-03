Return-Path: <linux-iio+bounces-7281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EFE9269EC
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50290281353
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89473194C6D;
	Wed,  3 Jul 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOny26lQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0B191F91;
	Wed,  3 Jul 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040715; cv=none; b=IX6YJKIC5aWfK1S6HPDaHwIl65NEtrxdad0+3hSLRp23NPzDHJevaeuEWndDcQKU/jxRxaK/RNbp0eFCquK2vHwojajgETLG+1CouaE8Hu6VcGnrQo1w95tG9jdRaCCGWF2UcBcVK1zD6UGUm+xim1yi837ntnquqYBPBD+57Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040715; c=relaxed/simple;
	bh=Gd4uxuPPYsfdfu06QZD+9Z7R5hRbOe8O2n7T0URcmi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOvBrT00D056PrBikgnIVhkPNUMgYG0HCrhZne1zPgKRwa094Gb7W7a5uGvataf4WqkDomlFr0Yi7SOzbBoJYk+4bNMdZrZeVugGxiJdqYU9CcoOzVhgX/AYNSotQbgcZjFMzka28pKeUSduYCrMPZcn4ATovuEGMHW2CMdRUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOny26lQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so35774775e9.2;
        Wed, 03 Jul 2024 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040712; x=1720645512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yY4dJKKorNRftBei97QZy0Z09pdM2kTyOUgMKAY8OUs=;
        b=AOny26lQOQ4bLzy3efFftBQouCykGHP8OiSrX1xuQycLvwI9IgcVEI+GNFaaR1reFx
         JL5V1aK7EyBrmMKAD7bRJtOHuZbssg+xkcFwJs1iv/PxU9eI5twSFwqN9t0ggdV/mD5u
         k8tbS9bVsQ6tBNiADdLmQAKfhkKwEXzowpgO8SnnlA/gtq5GeWNdnAXdJNEdfxz1w4iH
         PinaR83Bp8UqJUaUvKfPQPL8dGX6CLLm7WNgaJ03uoATzA/fiXeYjA1iY9dF5meJao5X
         jMYWPExDJ9dyfijiI3u9uuCTT7PLRTC0rpBTxLVL33ZUlgbCGbhbqELneqiFBMo/AFx7
         qURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040712; x=1720645512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yY4dJKKorNRftBei97QZy0Z09pdM2kTyOUgMKAY8OUs=;
        b=Vfk3+85HNqXPkju2ZPmxrdrpkSn3aiucUX3B0fFKZRVtM4qVsmie5Oa1CoQJvPACf2
         WagrVJHuCR0hb812xI246zYwWPhBG/ss54AcAsTuN/Z08lojzTGXl4GoD/VQGKwPC3FN
         onvWZL5x2OiWKyONZD5P8uNxe/5L4u3zae/53qM4h2RXHr2hvM6ZurzKNPb2T3ZijIY5
         SxrVG3da8jHn+vCKWUQ/nIc1evqNQwUTCVrUf2cCRelt1bmlJHqG8qZq0IHy4RLqyTIe
         F+i6a5q8uuo9lX7/sQYRXuE+7MhyuMXOgkfFv3cig+p9yEVhv1d4qjpQwg3Jmgpc8AH0
         5t5g==
X-Forwarded-Encrypted: i=1; AJvYcCVTkwUKWfv08VMZWpqdDKSRXSchkduFKp4XYH1VYv2Q2GXGbdoopDqJmus/rlnaRTntH8cp4rAWLtcBE9R6fBA4z3r9NTPHjo/FyLWS
X-Gm-Message-State: AOJu0Yyp+1aseTYQARp5ZRTQpb635fVEerXczGsY7fEh2wIDMDka65OO
	jfrogGgT7OW/aO+QK9At4Sndt7Xhrwqka81ePGJnx7E9btjabYNk
X-Google-Smtp-Source: AGHT+IFovch6rWmvTP5Umm4B1MYvc/hvlRUq/o9zTaYDSUUpv+DdlZlz8KsS0Drk8i67FYXonSPnUg==
X-Received: by 2002:a05:600c:458e:b0:425:88cb:1741 with SMTP id 5b1f17b1804b1-42588cb1985mr63832015e9.36.1720040712010;
        Wed, 03 Jul 2024 14:05:12 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:05:10 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:50 +0200
Subject: [PATCH 07/10] iio: imu: bmi323: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-7-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=1403;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Gd4uxuPPYsfdfu06QZD+9Z7R5hRbOe8O2n7T0URcmi4=;
 b=5jln+iPbxWpqNDr3oyR9YQJpa3aJs3KxrhhHXeA9t23H0UMh9rHpqcAzXVlU1yokmjj86cSZ6
 NqhT8RtvpTdAeVgYxTjy23DWIsbAFG4/gCfbnMAgzTV4LRls5an0/aa
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`bmi323_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_i2c.c | 2 +-
 drivers/iio/imu/bmi323/bmi323_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 52140bf05765..3298e027c97e 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -61,7 +61,7 @@ static int bmi323_regmap_i2c_write(void *context, const void *data,
 					      data + sizeof(u8));
 }
 
-static struct regmap_bus bmi323_regmap_bus = {
+static const struct regmap_bus bmi323_regmap_bus = {
 	.read = bmi323_regmap_i2c_read,
 	.write = bmi323_regmap_i2c_write,
 };
diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
index 7b1e8127d0dd..571e1cd7ce72 100644
--- a/drivers/iio/imu/bmi323/bmi323_spi.c
+++ b/drivers/iio/imu/bmi323/bmi323_spi.c
@@ -36,7 +36,7 @@ static int bmi323_regmap_spi_write(void *context, const void *data,
 	return spi_write(spi, data_buff + 1, count - 1);
 }
 
-static struct regmap_bus bmi323_regmap_bus = {
+static const struct regmap_bus bmi323_regmap_bus = {
 	.read = bmi323_regmap_spi_read,
 	.write = bmi323_regmap_spi_write,
 };

-- 
2.40.1


