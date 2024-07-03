Return-Path: <linux-iio+bounces-7280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2419269EA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5631C23604
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A843194AE4;
	Wed,  3 Jul 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0sE1KhS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BE194AC6;
	Wed,  3 Jul 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040712; cv=none; b=uSOanD+45Oz/r8cWSlowEIgGklujo712qZIAGSe/Op1WYMoqoR2vrWj71RteFMgawsEmsFf+DbztNk36Vl6q+MkXc9vDu+EqjaOPD/iVoVrsxpkfAn/cpdelKHAxmrTQfvy0UBmM8h93uDmz+9pWuJuO7gULo6efPDDnDCQ/JpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040712; c=relaxed/simple;
	bh=qu8qNBj8vUF/2atfCKt/6vXczKBXVcg6fwJ3ZC0IdQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LK5JYl+3XA/AnQaTBpavjC1F9uIYgNp24g2jrgHPUoIZoH50e/11sONv1bU9e8SddZAGbRYsHif3+IRQNLsAONh5wSaXNgJITLyWjDQhSbxjBrLwGGVXEnxNWmsbtQoUk4/ufCttcfx2AyqYvvlIHE/7iyL8bCw+3kWJlE2TwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0sE1KhS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424aa70fbc4so41380485e9.1;
        Wed, 03 Jul 2024 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040710; x=1720645510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0e1FJBvXxubVN6bes3XpD4DFtWFT5eJx4DEDA+3BuE=;
        b=C0sE1KhS/txHBFGv5p0FxdsMyXHovdDue7nTUVZn6kUo/zjDmkikUGnkOeWVuMoaL6
         Te3B9QoW5dxrEez99SqINUzfIvEBx/7WRr/gJKPPmaGu6x/gQOHtfsgiRRIjhx20Kkwr
         Zxm0dpV2gJJump6zO5mPUOTlxXuSLaT6wj7XQEzl8p7ERHF4ujJWZmgyiTPdj4oPBS4S
         sGODZ3RJcZZoZgig7UIDuJNFmPmp+nEYLuSaDc9/Bbi5RjXQb2p2QlFwDZDZm7LSLmWY
         J0JUkUjjOqvFR8L1FIaqxl32xnbHnB2L2Olm7tA8iks9qhagb07rfUfFNEwpM7obmh9s
         H1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040710; x=1720645510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0e1FJBvXxubVN6bes3XpD4DFtWFT5eJx4DEDA+3BuE=;
        b=kspcjOy2jasJP5V8Q+2qpjhObVd/r5uVBuWWDdxrCrjm+01DGvsOGNRXgAvHJjYHKv
         6VRRqvwkWT1Yk3n/FeUIna9kYVPyFNENp9gT4xRmQ0gwz+o5ryV67QRSwkFZXwtzFzZT
         sPNPdlwr9J0axr6AYPjk3rpIY5i61bLpBXh+wCrq9di2wcFASyRtw7QV577ZvL18zn0f
         gfMG7Y5+ytYyYCaYC7HDVQX49Y37RXFq9pficsRb7Lkan4TVvrx9Kt/avZKpKS9Gt3cm
         PXWGoHVUe3lh2iuYnuaRIUlJQ4KY9OsyS5iSBpL/oRDr7FknWNaYiOa3MRNchFT0aGtn
         KYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWsYcPpUeC+imXzqbn1j86fgHwERy2B3X/jHoeZmCuhQxGRRAIBPcgS8KcDXMXL3MIv50tQVXjdi5MwHrbpPPUT9n47wSY7Td1d4hIX
X-Gm-Message-State: AOJu0YzQbZyf/khcBG//RXTN8ocdbBReI8dTvmtgodSmt92ruy0jX7ah
	Gg85vsuS3TTz8OLw/GHX4Z/lE5xQjFRELuPazBds9DJEJ3gna57J
X-Google-Smtp-Source: AGHT+IEiVTxHuSav+0wtLn3l553XLb9kMn9Fg5PoJzpC7hxJ6sr4XBYfD0Nxn2E6ja2ZdQkw0Cf3CA==
X-Received: by 2002:a05:600c:6a86:b0:425:7796:8e2c with SMTP id 5b1f17b1804b1-4257a034ec7mr95728575e9.12.1720040709857;
        Wed, 03 Jul 2024 14:05:09 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:05:07 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:49 +0200
Subject: [PATCH 06/10] iio: dac: ltc2688: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-6-34754f355b65@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=783;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qu8qNBj8vUF/2atfCKt/6vXczKBXVcg6fwJ3ZC0IdQ0=;
 b=+Q/wsic0AlzaW01/l2PKZ/55Bkw8ZvFdhS0XYBAoC3hj1zRW60RbmBa8UPfob0tv7UVEGn1yY
 Q7bh32TVTA3D4QXNsoWmikA2svvzNmgSKd7yTSLhEUJrO/OswhQNeVr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`ltc2688_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dac/ltc2688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index af50d2a95898..376dca163c91 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -918,7 +918,7 @@ static bool ltc2688_reg_writable(struct device *dev, unsigned int reg)
 	return false;
 }
 
-static struct regmap_bus ltc2688_regmap_bus = {
+static const struct regmap_bus ltc2688_regmap_bus = {
 	.read = ltc2688_spi_read,
 	.write = ltc2688_spi_write,
 	.read_flag_mask = LTC2688_READ_OPERATION,

-- 
2.40.1


