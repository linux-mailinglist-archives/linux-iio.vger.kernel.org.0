Return-Path: <linux-iio+bounces-17856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98546A8205E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AF54C6475
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C925D550;
	Wed,  9 Apr 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eS5nRG9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0E25D215
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188052; cv=none; b=tlQpTRKrHYxb8cbrXyAChsp9S34dZU2v/oaEL/OIlfjmTuA/d6nR9aWVdL49oFsLh/FtUUt4vcCz5fiwyjV7pdr8rj1ayVMT9HtOps2suTJErjKQPB5io7mnYhx39mqp499ecvolv6zfL/bxqVjZy28EtiGNv11BHlUmVNaqw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188052; c=relaxed/simple;
	bh=V3jvDHKDO3y/NiuIZ26eS81nUWDRmeESiPo5QcZ1RiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWzgCrbXEF1om5vgUr4K34mv7axzsnHGQhnSHl7gJLf3czLjQN4ks1MSPdVxm6cjGtiBpDCSRjfDF/vQ2cvbZSKY7l5Irs/nkZdvm8aLoWNDwW9kFaVnSy7MeymeDpaiPfVcTqzh/3GzIkVq1HwPXf7cHPTRfd7VZgbg11naypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eS5nRG9p; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-399749152b4so3528677f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 01:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744188047; x=1744792847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/OUvUxbW8Jlw8m6Urroe1Z2D8oZ9CHZ/LwRr+VHvTg=;
        b=eS5nRG9poCtbwuXR8FtuwotvVUqs2/rUzMSren7RXQpObAYU2jMr02g1FnDVnB5TP+
         D3VRSZpya6PeNuJvqltECRq3De++xUjHxgSahQDS+sEBepREgDCUQubTp+TMYxld26fZ
         qnw0APtQqf2N7JX2/YSJNdF9n2Mth+2bK1OoGaGTkPv8vCxUDvjtbhfk+I5bfE0NzN2P
         mFFsRk5BfV3CW+BCulPcZTjD269Q+0uM1F5CaogWALgarvVb2Vt44AbPKdWv3aM4wZO4
         8HNPQe2d9zf3X9lXaT4WrqIM5ghQU9fke2ul13Ro1i2Gb0kkynZqlsy5BjmgsY0mN+8P
         FcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744188047; x=1744792847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/OUvUxbW8Jlw8m6Urroe1Z2D8oZ9CHZ/LwRr+VHvTg=;
        b=AP19lVimFGmsrff/S/I+5B3ENE9g47Doq+6wpS0HPdIUaIKLVZ8chsfX+fKu2L2SOa
         b70fs+olPmxoLCSDQXZ98YeFc6PTS6eA//37v+ZTZVuhRzCwnwR9rXdH60eMIEULVA4m
         +ZUbuw+DXmMjft9ANGtdSVsvcEu+UBBOHRPU50GkNABKKmmOHkHR2tAtm0klEaed8/26
         lmrUnoMgBjwNGTFjgqm2K1Viv8DKs6CpcFlQlg+yAYC7cxX2tVq0Tb2gbVCg3YnSjAgK
         t16hzXbwAq8CyU90T/rLAUfj5gGJ2puzqoNgyCJ5xBHKIBX11/C0ivAmLmUk20zJtTmo
         aehw==
X-Gm-Message-State: AOJu0YzoUtv1XsQLJNg9ic588jBouIZXcYZUui1qOiHfLhltX0Owj4eW
	ap6SHQndSqTkVTHVcV16X2LrdastCfq36fU+mO56fDAk3PufUqob/P1HQNS6nFkeYy3PrzVYfGF
	Aovo=
X-Gm-Gg: ASbGncsfTPOeMTY94Dna+zTWw9WiHhbHS3TDwpW8K1jnKyTV3UpHEtCGb2x6HcTltDk
	l6b26S36XPIloez//nSnljfMngouWsb5LgdwN75QhAuQ8I8rbWUAL+1aEVMY2OfZxTqcTF9AtSz
	ecFh6ZKCRAK5b4XHTpgy1kwMXGkK1a4EVRH/+9wQWXPUbQfVyVZg4qa8B6I7BaZNSHGwGQykfM+
	1TDeKzHJ1uPGB4BYEfYym1MCRjrV+zXMtXTkp3VcZKtyqGaLUBXOLxtnCr/aOLdk4SXdNaBV4Ce
	dqT8pozUfd9eu0e6yKfzK/pApC+YZFoGz0WavLmB4tF0
X-Google-Smtp-Source: AGHT+IEG9ARuyq2GXIvhvOJ8pTE1gyzUZZTNGic5PF8Mu+v7NqRyW2/PutGpMY9Tr6slpXPDE9nalA==
X-Received: by 2002:a05:6000:290d:b0:391:47d8:de3a with SMTP id ffacd0b85a97d-39d87ce28f7mr1673520f8f.53.1744188047124;
        Wed, 09 Apr 2025 01:40:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:7880:1c3f:3ac3:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8219sm8726235e9.21.2025.04.09.01.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 01:40:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Apr 2025 10:40:39 +0200
Subject: [PATCH v2 1/7] iio: dac: ad5592r: destroy mutexes in detach paths
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-gpiochip-set-rv-iio-v2-1-4b36428f39cb@linaro.org>
References: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
In-Reply-To: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XQBsAWxRrbgUBZdq4joassvWFO3XhqdMZQNsYhta8LM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9jKLRtz0aJoW2RZ04RgC4xM6VPHDLizPhNR4H
 tx76Mh9mx2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/YyiwAKCRARpy6gFHHX
 cmM+D/4xH/SgX9H5NeAyQEdIYlCa+AVshfPTRfEnMeMsyYe9aicwoSnTZOW10VegqLbTEEQCnfQ
 y6Rhei+Z0LDPM1OI7JSkP8reuhwyrIVxPUwa4rfi1IX0ZVgQ99NLBAs5Mr72CPoHhSk1zbcRBHT
 fnSkXF6ZGX8wMeMAX4doLZ619mUoWgM1rInLhwzQs9DWQErDGEio/bkUtHSw2pXQvdJ+WukZ0L1
 OiPC6L9lI5NnVSdVL46DGwg/RkXIahhJNwjyECF2eibGUFYti8ZclEIg/fDFcfvwgQMTfw3PLVO
 5+dNU1RQ6gItdn+4SQND3EB2iXfzoynjeM+BiUVWrUUy0vERGQD11KbNoeiTaJH0x6sJhAhka1J
 15U9wRneksQdx2jnywigrHeg+tRRqsjmDEDq9FyodOJyFDhdKAYbMKlMY0xQOb+1R3enKwqT5o1
 N/B7ijLh2zQgh4wprT40FfCJBdfF9s4MdnHQJT3ZkICoRUVu9lWpCn/RBIQPim+DGr1Kmeni6k5
 pCdN7WL2j0fljL3qjLAZJBhOWZniyodwhjGnA/lC2TgqD+zGJV1oZP8Soyt7JAhRziTdRX0pk2V
 AlZ6YvyWvI19qBvZxnw9GpPURMusxrW6FwliiqDL+8MRiXzTBVTLaxG0n4XtQ5RM7v26FX3ek7N
 YkzcKVkQ5FdVYVA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The locks used here are initialized but never released which causes
resource leaks with mutex debugging enabled. Add missing calls to
mutex_destroy() or use devres if applicable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/iio/dac/ad5592r-base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 50d19304bacb..eb85907f61ae 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -155,6 +155,8 @@ static void ad5592r_gpio_cleanup(struct ad5592r_state *st)
 {
 	if (st->gpio_map)
 		gpiochip_remove(&st->gpiochip);
+
+	mutex_destroy(&st->gpio_lock);
 }
 
 static int ad5592r_reset(struct ad5592r_state *st)
@@ -606,6 +608,10 @@ int ad5592r_probe(struct device *dev, const char *name,
 	st->num_channels = 8;
 	dev_set_drvdata(dev, iio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->reg = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(st->reg)) {
 		if ((PTR_ERR(st->reg) != -ENODEV) && dev_fwnode(dev))
@@ -622,8 +628,6 @@ int ad5592r_probe(struct device *dev, const char *name,
 	iio_dev->info = &ad5592r_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 
-	mutex_init(&st->lock);
-
 	ad5592r_init_scales(st, ad5592r_get_vref(st));
 
 	ret = ad5592r_reset(st);

-- 
2.45.2


