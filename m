Return-Path: <linux-iio+bounces-7279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E39269E8
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A373D1F26C58
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3378A194A6F;
	Wed,  3 Jul 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnA7GFcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242B194A5C;
	Wed,  3 Jul 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040710; cv=none; b=U+sduB7CuPmvnZnxUbl1YgndCwJrlyaREOqoJadjcqu+zUaswTP4xBJzE/6B+RhQpvuR4CV4pGW2ZAIoBFs+BvgJKeBnCwLikuZcCIBAtZrztAN5vZBAnEB5BBUA08wGCvX87luP79yXKrgb1SMLOr0NaQoqy0CZZ8Co91YEmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040710; c=relaxed/simple;
	bh=jcPRvWcyGFXA5sIBs2EqAKzN+shTLb0c6AvRWYEF138=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpzuuYk2po6f6EwSdAVPS/K4VrP/AqxhP1g8loj1zJWY39xw/2pPbMs5+uAHE4w5xj05ltBnuu17/5bdH0EYiawO/QvWh7bOUEqrySAaeuYCyexsUcjDBA/8nKvzg3dPYldx1V7t3yduQHEg91/KBhEb+3OcaPIwecbLq5x4Zus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnA7GFcM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42579b60af1so35062965e9.2;
        Wed, 03 Jul 2024 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040707; x=1720645507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNGxq4SL9fDISDZOzJOIeS8Yn95Fdsrda0h1D848QAQ=;
        b=fnA7GFcMB0ZWG9Yvntq7zEtbKG0hRn1PpVdaseTM/1KHUrVSAK7Ud3gRU6+lKfGCFa
         qvVVOLkiljU1eKNlKn7iLH0PboXFlaS//6GEDW1ek2z93jCVBGFNX4/CPBRExQiogC8D
         zLfj6u4C/nLl9BV6YGnEqeSEm7af68J/1HGjFJW38/7lJ/EELjkDXQyzKhhULYfHGsp3
         GobQRMqJ+cgCE0wR4phFfRWh0MeK4NfN7WKnNQJpYLlOUqUICKucSmRaEIoUlMTjsPr+
         dQ3dLW8VoseNi9rUi8phb7EtVEV7Jy3dSXI5qStaHla3jW6wWTFNe/xDB0FvedC4w3mg
         dImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040707; x=1720645507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNGxq4SL9fDISDZOzJOIeS8Yn95Fdsrda0h1D848QAQ=;
        b=WHiSuEV555hvtgMEWRcE/hKj+Oj8tNpu02V5i94TXL7lsahRvGyT5aFh/6AySbVWRS
         st5PK4QjaI2Yj/HXAnlEKDmbiNkLsVRA3khTuSEFvKulEhqiqHzbjA2jvF5XJdKP7gMi
         ogTHvKelazLxn0VJYnQvsilCunqLr+/ZYkTXrjN7pruKaW/B4Czjh4flFLfw7QMaFDCg
         TlpGgNkokW6Ltd2zewAO5AaQKO0X3DOZjqyCfRZljf/R/YY6j7kBjfC3gAS34TTViI5/
         aeFdNrmIvkJ/qsL9OvNvIZtsaEJ6KLLcmhAuBfxACSLacOirN21XY06OABMa/BvaejZN
         DWiA==
X-Forwarded-Encrypted: i=1; AJvYcCVKSzpOwAr9s04tAXwH4WihfUHL4eEDNJW1tScjSGbyrdl6KPdaTAhrmi/9ySDpZZHiLbQPttanFFygXtWUu3den14Clj1gtGUF6l2M
X-Gm-Message-State: AOJu0YyLdYCXc0TTjTk7hUAGKdWGMEmitRXWdZpTg7kzUJ3GM4O1S+Qi
	lajPDIZQYjD/hwA+7+J285oP9K/blr3QfXUQV+RKhGH+n84PDwtX
X-Google-Smtp-Source: AGHT+IEiSAbkStJve0UvTet2fv8mRYfukbpOQOODRWGMPSIMv8yRoAeKLMlTs4p4twEMWUBkIx9GFA==
X-Received: by 2002:a05:600c:4fc5:b0:424:90f4:309e with SMTP id 5b1f17b1804b1-4257a021443mr87594165e9.6.1720040706576;
        Wed, 03 Jul 2024 14:05:06 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:05:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:48 +0200
Subject: [PATCH 05/10] iio: chemical: bme680: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-5-34754f355b65@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=877;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=jcPRvWcyGFXA5sIBs2EqAKzN+shTLb0c6AvRWYEF138=;
 b=sbkFEBZzjK+NXZ+zhSd6LXuVNC9x5ZHo0bA+7OccbF67L6/yUxwa0BYqnbVN9E2AWJvOryWU2
 gWwpOkCYWeLBhYDLU0zO7B4aUsKwIb9JZ6gSFcKNkvf4s8eVI1pNyjt
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`bme680_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/chemical/bme680_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index 4404d42ae5ec..7c54bd17d4b0 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -100,7 +100,7 @@ static int bme680_regmap_spi_read(void *context, const void *reg,
 	return spi_write_then_read(spi, &addr, 1, val, val_size);
 }
 
-static struct regmap_bus bme680_regmap_bus = {
+static const struct regmap_bus bme680_regmap_bus = {
 	.write = bme680_regmap_spi_write,
 	.read = bme680_regmap_spi_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_BIG,

-- 
2.40.1


