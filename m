Return-Path: <linux-iio+bounces-7277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBC9269E4
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0C282CDA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932F191F85;
	Wed,  3 Jul 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUPoib6j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4311946AA;
	Wed,  3 Jul 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040705; cv=none; b=OFuogVsggxDQjDeYlIq7pdMqnvBx7KG7pW+IoSMvTPptsO0aAgtb5CA+m7w+DweiHL9GeIBrtl52UxIa4PH+9nK0BP0u0y2orZ9E9BYDzBXW+Ls5gdtZIuZCjqQXcuclt3vpjsOpF0R74RQ4p71DESqqyDPnqQwLw5fCa7ddIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040705; c=relaxed/simple;
	bh=rvdhCNryhfDf2owRvr2xHkuHtgHUnmjPYXCumT1JvbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYxXWhi3TCyiCi9Iy8X5i6dLgUe6tc3uusrSJ9QOqajS1a+LIS6A7hXzcfpRZw1+elIMV4z3JMjpT7x+qb9MFgiN8yiTSa2Vu5OuEEBGE/m+/IVQMHPr2Pru0N3SK8l+ozbRWfT7HElQKpDIw9WoWT/PPlTG7528DYnRkc5uxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUPoib6j; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e98087e32so1354653e87.2;
        Wed, 03 Jul 2024 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040702; x=1720645502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSLyPNLzqq9nsRo5xfNlIqB27L3bP1qyzKP6evyy9ns=;
        b=GUPoib6jTcYlIwLXr5wsA5nVbI+6DRzhKcl298DEvxomQaCola1tIt/maw6CLCEMSx
         0NDQvNP1nQ5vR33eQyF7OmfYgksanTdMr/8B5SQ8XWOvJTxSFTs6ALk8dzs+H3ma01ow
         uwMoTblMit6Y1Ba5pSGtIhUdI6hnt9mKxiyS1UEc0YsKd1NLQmanEmgeB67U+1ezlhLq
         AlPEHOz2Tv5+t1ToZsFOQIlJJIOp7Ru3/87XJ6uYrA0RPXzpTCS2dPC99D7HH94/CMFS
         bZysJCf/MZd/nlmnQi3g155yz/hUEbg/n9VaIziIyLpxAd1SZH/TjMVCz6kGyNDJOijl
         W6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040702; x=1720645502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSLyPNLzqq9nsRo5xfNlIqB27L3bP1qyzKP6evyy9ns=;
        b=LG5DLjJcXK8Wbf351Zvf1uDzPXvCMDsgVP54NpwAxyL60vQHWkRlM6eJyWrbFFmqMq
         PvRziQW+fVgBeV9Ws51h7qDC7k89qfIqj/mssKG+k1j6xLLR7OVqosP7CxlJ38T2Htax
         xwn3ohH2xiPkAwzyksoat6ZxqUediO1d5zjqv9ky7ZhTuo2ZIlKwh63jNAptTn5pGNWu
         pTetNuQDzy4nic5QoX9DS01grals+Gof6sSyJET8dEXySiM8AMWGacmH1OMYJ+AOfQif
         9J6nDUW1lIl2v3+WNB34/4V9t9JGQPMF4mSLEVir501P8HH4XImx7BY1AhIe7tzMqA2a
         t01g==
X-Forwarded-Encrypted: i=1; AJvYcCXJbUE8qch0K2snJ+I91IMmGTbr5v8abA/DTwOXU8pT4KtoIuRmYzRgciJkVjm0zZ24dHMchpuP+m01KX9UklZqsT7Bpt6sXR9Y+Fhz
X-Gm-Message-State: AOJu0YwxKTJPkHScXzOKYMNxQAcvEfLW8Q8iSmwTuuQjJ2bu1v1DGYqB
	KDebE0El/WdsRj6iYRarqfVXnPjn/6P+U6uo9JBlpNHIYYmVEWNO6nxdEcwj
X-Google-Smtp-Source: AGHT+IHa9y/O2eBBwLkLlSspuZ6aKwiFeC0Tl7cNavVLNtZxxxggOcCkDTVO4CPwi2OWiN2XrUFkcA==
X-Received: by 2002:a05:6512:1151:b0:52c:df4d:bb9e with SMTP id 2adb3069b0e04-52e826932fbmr9556258e87.41.1720040699777;
        Wed, 03 Jul 2024 14:04:59 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:04:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:46 +0200
Subject: [PATCH 03/10] iio: accel: bmi088: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-3-34754f355b65@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=854;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rvdhCNryhfDf2owRvr2xHkuHtgHUnmjPYXCumT1JvbM=;
 b=XgA5ulxG0Qnmk/hbuTYV/MGsqI9SQZ7AW6S6/BTps993rdBse/sszD6FXWlpz0HCjudsjXYk/
 pySZVTC24ouB/S2DKX8ZFBy3KG0canAFIwX0Fv91ijPyhb9IUsyDz+w
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`bmi088_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/accel/bmi088-accel-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index 7b419a7b2478..df1adc059aa9 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -36,7 +36,7 @@ static int bmi088_regmap_spi_read(void *context, const void *reg,
 	return spi_write_then_read(spi, addr, sizeof(addr), val, val_size);
 }
 
-static struct regmap_bus bmi088_regmap_bus = {
+static const struct regmap_bus bmi088_regmap_bus = {
 	.write = bmi088_regmap_spi_write,
 	.read = bmi088_regmap_spi_read,
 };

-- 
2.40.1


