Return-Path: <linux-iio+bounces-7284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4439269F2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779671F26C51
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81F1940B9;
	Wed,  3 Jul 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU1UxxhV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58B195F3A;
	Wed,  3 Jul 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040724; cv=none; b=aKSNz25lm7XOaxudgM6C7Rd5Bc4rQ+IZrtlcGtaIhY8hrS7VFAQ4ERudivMIt/IuS8eU8NRJz7wPVzfs0n3/Ag52DW9rMBmOjLK1u3EaflKaLjEpvMZUIunoFBSTA6cvKOe1B0hdbGWDme0HTujpO0c9EreeHemAeuRfyt023Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040724; c=relaxed/simple;
	bh=0t8By2YYqQKqOLTidUf3/P6f28/CPTfyCx4winCDhm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUQdmMaIeUVmpciVKp5SoOONhcW6NLJqZU50pOSdWsSR5Bm27/EDvCGQwrwH23dFP/V1yEzxBBdOOibJDt5M538li+pwkGb2Vc6t3bOB5Y2McRdc+JsDrKNSQYUaA9uMT4E2hdwW3Q/dWQaXx+JpGNigEtjhpKhouNeZHe5Hqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU1UxxhV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee8911b451so9143411fa.2;
        Wed, 03 Jul 2024 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040720; x=1720645520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyX9TcRdVHyapOF9DOsH/OFvhz6zliZWtMsX1SPbtnA=;
        b=kU1UxxhV27ISmphZQh7Qm72EbrHF42bsR7gBZPomMzTASJeT9obgPoQU/I0vN701me
         89rTvKE2FlFGaNvUAj3wz1y/ljpR4KwyUvNv/Gr6VtVlNnTb0bGOQ6iBrAdiDXy1TlPw
         z0idm4zJV18VlVB6t6uInygsWlumMI9FAiAxQsK+oXjA6ef/Bgz8Ge76tZdNQjxeSgpM
         JzUHSfDSfGmjPUeeb/gsJRk/pf0gUtZQJEx9HpgkDSrWJDBdj9VcQfGVSmrI6Lxiz1Vt
         lzG9Tj7tYtzInm8YWHrnFgmrjJT6jW7J9Zrkq169LeAF1J/6A8IWYpLBJ11b3xhGMUVg
         niZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040721; x=1720645521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyX9TcRdVHyapOF9DOsH/OFvhz6zliZWtMsX1SPbtnA=;
        b=UDx7pwFqQQKCQxGmO2+dYSRfL9FU/OiONSshDMgD4Qak83tgJUiSrz+5LdKVvG6tao
         g+hcj+VIt4+zW9p9J0oELlKHGppxmEn1axIRewIITrwmck9OU4kC6yoyFtSWwtbTqKQe
         onCsn8SfMnIHXqQQ80HV8FPm5kI8Pcn2bE5pkePF1631GbYUvhV+R6kgWUfhF717rnkP
         tc9++jVP/qvp51KK6ztRT+FsvNs1lXivbgoKWrf7eNKGLUtVVLUoA6i1pUUqlCY9Um1d
         82DUhuijiO4ubwKawfXTJjVgsD2lwx8wMjH0D53RJ5BgHDWnYfWcOY1PmayfGOyZ/oSs
         tSFw==
X-Forwarded-Encrypted: i=1; AJvYcCVSxBZigNZiUG7/dlZQWk9EZYYQhoAyGBInCUiuSPNwwuxNVMnZ1pp2m+yaOGGKAxvIQc6nPHWoSrxwom/T2PpfVgc6U4eph+4nJqs6
X-Gm-Message-State: AOJu0Yynm+J6PwtvPf1hOwPSw+G6D0SWuqXoqivtfuV05cHIca+7I92H
	zMFmZXram0p8p90QwKK/JANZ+Uqr15gw78CRb7tojufi4M3d/YlQHjJ7ol2n
X-Google-Smtp-Source: AGHT+IEoqk30lfxe6QliWd1IfNiWy6Tu4s0Z9+hC/l+jtWQ+O7+zNSbtoDM9OiziDlBB3tH6rF6XwA==
X-Received: by 2002:a2e:a995:0:b0:2ee:4514:aa9a with SMTP id 38308e7fff4ca-2ee5e6cda08mr106951591fa.48.1720040720597;
        Wed, 03 Jul 2024 14:05:20 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:05:18 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:53 +0200
Subject: [PATCH 10/10] iio: pressure: bmp280: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-10-34754f355b65@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=1549;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=0t8By2YYqQKqOLTidUf3/P6f28/CPTfyCx4winCDhm0=;
 b=L2tcuONK3hdbTjhGZNf1YTSvT3IaZs7IDIygCSmdfMYeVCbwO5CM+ANFzFoBb7Pus6wBVeakL
 9CXm/bbEqpFDrFAKRU+nZl+u/wsxpJZ92qlVHv2fHbEB/Wdw9Skz6gx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`bmp280_regmap_bus` and `bmp380_regmap_bus` are conditionally assigned
to `bmp_regmap_bus`, which is only used to pass the struct as a
read-only member.

Add the const modifier to the structs and the pointer to move the data
to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/pressure/bmp280-spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 62b4e58104cf..fee266d4e055 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -64,14 +64,14 @@ static int bmp380_regmap_spi_read(void *context, const void *reg,
 	return 0;
 }
 
-static struct regmap_bus bmp280_regmap_bus = {
+static const struct regmap_bus bmp280_regmap_bus = {
 	.write = bmp280_regmap_spi_write,
 	.read = bmp280_regmap_spi_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
-static struct regmap_bus bmp380_regmap_bus = {
+static const struct regmap_bus bmp380_regmap_bus = {
 	.write = bmp280_regmap_spi_write,
 	.read = bmp380_regmap_spi_read,
 	.read_flag_mask = BIT(7),
@@ -83,7 +83,7 @@ static int bmp280_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	const struct bmp280_chip_info *chip_info;
-	struct regmap_bus *bmp_regmap_bus;
+	struct regmap_bus const *bmp_regmap_bus;
 	struct regmap *regmap;
 	int ret;
 

-- 
2.40.1


