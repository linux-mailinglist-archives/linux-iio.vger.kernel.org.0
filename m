Return-Path: <linux-iio+bounces-7275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2229269E0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE61D1C23308
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70418191F90;
	Wed,  3 Jul 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAi3y67M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7F191F6D;
	Wed,  3 Jul 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040699; cv=none; b=KSqamr6UXkDyYwnx2HjYkHmA7Z+oA32Zui2uIJ8uXvoVg7e8KUa/+TDxg+UzOcPpdVBkFJY79LmrO5ErM2cIZrCKtfH4KyIjvhNqVnmBhsaYTRqNZTGF85K0ClfB+3yBiJACe9+j7AckrEfa1vcrgeXd2Nay7dls4xprwj2yplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040699; c=relaxed/simple;
	bh=7wvHtbHmc5wAgF1wouiOVrC+WLrbIqHZ6Xtu8IrKa4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmlXUPBZrZOohfnnbOLn9UGSqjebZOUnh/NX4zzuGxtk1PE4u6G924f52Fj+ukvPplvWyI+itaeW+uAbGg4uU1iaEIsYscMPftiPvp1yBzP+v2YXTaulZuTeMaNDtGMHhL4murt0kWasdHXmJqa6t8uVvbE2nZIfJ6iaS9pmxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAi3y67M; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee8911b451so9138121fa.2;
        Wed, 03 Jul 2024 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040695; x=1720645495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHX/hgYF5gJhAAN/zpUDUEGsEcOIXszZOQeRDy9mJH8=;
        b=LAi3y67MGbRImnZTUVsUDdt6bvvnpNEMueWHEPARo0Xpc4XOaw3DbMQPXnbGqAIKuT
         S1UmsgETGhE/9KlzC10OJzTQUhLRruqbLWt2QUF6FKLLwgY0d5KGrUZw3X4OrV6Uuelt
         sZA+u8/2Q8TAmlNRy5EMi9mLjd6MIQ3tbvNQ+CGlKqv1oPROOrw4d66riU7FcawlzWSq
         qcQBsZ27WThAPKPO6/HchFyUgNq+z/O0E23WOm7YRWwdF2K5Qvkdo19u8umhCNGrR3+M
         56VhRITj7LDAvgWd9Xg7s180Lh6O52dAg3X+9AM25D0WLjOFnorpNKAR6ZRlNENV34+x
         0lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040695; x=1720645495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHX/hgYF5gJhAAN/zpUDUEGsEcOIXszZOQeRDy9mJH8=;
        b=VDRpRdKVPqx0q8hn9T51vIHZ2VZyz7LqPUS4o8twfxBW9sNrEio8qe0YwpJdZoLp5w
         tB6hZ9YwOP+g0dozq8YmYorRkHONrjMXO3GP16TkcKqFhIrFun6xr7FoXDjXPoY2gQnm
         4+AftCVfNrD9DoKxRSE2+4sXFPxny7xogXtw3iDig7p57PmBOuQMV4Y7wOWqZo37ttWR
         m+Y0ZqtcTU4xKTnqx/37rhAx2jK3po/jbJ0zRHzbFKYY/lkxDxtpNgz8uKf7u7PSdtne
         o1d2INrhGqlnE7hdrh8laRtAsqYlK6MEMsEAcJr/F/WoEesuXtV9QyA8Bfmws5faURWQ
         uUrA==
X-Forwarded-Encrypted: i=1; AJvYcCUmNpjI3z0ccJiL1yzbvoIpxxe+w2PK2xWj1mXYFGp3ePnfF9e6cMcD0JiVHonHq7U9JFcg9r8fYDMMFvx/WbQLZQ1o+DpBzUGY7ARZ
X-Gm-Message-State: AOJu0YyzOpPLtoMRzDWGW+YatV5kAtTAFskXycESRq5Dnzp7pCaZCjCQ
	Lp9JjjBk/5/fM1beG/7rwIZsznQGmapK0c3AYY8LD0cS0mrK7dTv
X-Google-Smtp-Source: AGHT+IFsVt3vxO9rZ0j3asOfe0J9N8/lgrV4TpMyJZBq3EKIIjouBXkZZwL8Mf1CAGru+ByIRY7P2Q==
X-Received: by 2002:a2e:a417:0:b0:2ee:849b:576d with SMTP id 38308e7fff4ca-2ee849b57abmr17980431fa.43.1720040695279;
        Wed, 03 Jul 2024 14:04:55 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:04:54 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:44 +0200
Subject: [PATCH 01/10] iio: accel: adxl367: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-1-34754f355b65@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=814;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7wvHtbHmc5wAgF1wouiOVrC+WLrbIqHZ6Xtu8IrKa4k=;
 b=2TNHoK556c0E3P9lOwSfH6kralYWB38FBA+cu8Zjk/d1EFjAXY+CPVyoMGSIwns+7GcR1Ebi5
 Ym3OXDZzrF2AqU1bY2U8lID6foPQidlKVmrTWgNipzlhaAZlc4qGkJy
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`adxl367_spi_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/accel/adxl367_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
index 118c894015a5..b70117265791 100644
--- a/drivers/iio/accel/adxl367_spi.c
+++ b/drivers/iio/accel/adxl367_spi.c
@@ -72,7 +72,7 @@ static int adxl367_write(void *context, const void *val_buf, size_t val_size)
 	return spi_sync(st->spi, &st->reg_write_msg);
 }
 
-static struct regmap_bus adxl367_spi_regmap_bus = {
+static const struct regmap_bus adxl367_spi_regmap_bus = {
 	.read = adxl367_read,
 	.write = adxl367_write,
 };

-- 
2.40.1


