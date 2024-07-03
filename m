Return-Path: <linux-iio+bounces-7282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE09269EE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8683D1C23A24
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AB194C6A;
	Wed,  3 Jul 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iecUX5xc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBD194C85;
	Wed,  3 Jul 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040717; cv=none; b=Vrzu2Yk3/oPqvUlZmz4MLDhgK1VjQ3aJWySLtKK+egVdSDt32tlt7Gjt9WvprxT+lbv6gd2Rk10D1/LN4qmP2Rte2pAy6R3CKYcAPO+j4iqFAD/jAj34NOsYm/5XMFym+rf+0bF4b9FAAX4ZRMpQWta6Vl9otd1ma6yePd7NVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040717; c=relaxed/simple;
	bh=qD7vYgNjKvCPG8RA54s53vsMIszSn013olEo9C5PosI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qsj8NKNnLZZSnGuJqT8SLxCOxtVfOsZSE5RYEgn+SWl88sOHRA47ykWAGqq7I9BA8z46U4X4hxjRpX25eJJ3i5hqrauHI51/w9u3j1ijePyuhaLwH710QpdTBvsjCwGn+dUxqSDP5UHqhnUr9xOMzSG16eVdHuR3q/BaS2zwU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iecUX5xc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so41023095e9.1;
        Wed, 03 Jul 2024 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040715; x=1720645515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHA5emEYqvrX/CJBhwACUJiUJvM3hLVzvUbVKbSsgG4=;
        b=iecUX5xcozUa9LOltvJrKH1JQHx9SZYfXG/F3dnTfFrZ+XNG242Fng0zOhwO5WJ8Sh
         1W15vlcbhjQPtd8KhsXNkqLqFgMX+vKbNmZbzyoVHujf1BDT9901Ar/CVsmKLlMiQ3PI
         UCiRSNreImNEFnThLkeNiid8mSTet1OEiR4Aq324+vPJkv9ZS3eD3+R86VwivMlWSuLl
         gl2tFNEvhU2Ok9Uv/cl4/fQONv6bCSH6r3Qev98hQMKQKY5d7+UNRuTtGbqmfnVCr/j2
         ZPT4FLS9H3rzFMllBg2r7xlqE0emogys+G8Cuy1PhlAtY3zpAlW5Zdr837UM7N5GlpD8
         oMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040715; x=1720645515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHA5emEYqvrX/CJBhwACUJiUJvM3hLVzvUbVKbSsgG4=;
        b=da+VaaMC3l3a6eDqAywtziinYTVF1NARIUEFDbcXCHluvDRub406ayKo99mloJdBOB
         vKcWd79BKVKL+r1NrDUvN+JQYjx0+zO3w85StAVVWkaOXXPJhRa+7DPtbJRqj97B6JUM
         zm4dInBLPmqU1vQ26JW3LdHrnUWuyUJ9m5dSdvBg9Trip8sExaBmFKPxvUqUCIbz5pjw
         8QWLnWA6ntaxdzNVQUo+v4wMEDZQYBzFIWmHP1z4222UOjssaZuLYhhCUMuEBgdJ3+DG
         vCL1/eDRtJqd5896o4H/mUpxr9b4NWJEZXykD/wxj3cKhhYMAWPEYE1dPuvypOdMuYGF
         GRTw==
X-Forwarded-Encrypted: i=1; AJvYcCWF08SG12wdeu/n6KtTJgWtpjRMLKONS5pehIA9SjmmjChQNL2sbxUV2IrgZSkFUo7/wuwWxtpenrBh22kPYKVKa8/OBsG76k0PIrGf
X-Gm-Message-State: AOJu0Yyl08TCdjhArv9C1GNdCa6JfYgWzK9e3E26fe9vbttNhL3y8bC5
	QKSvkxoURxjlFk8Xma1gwhqVQo2wLgF+66dNjCaaVE8ljynLpfJrUeFh87WW
X-Google-Smtp-Source: AGHT+IG1cKnE+J3TVR6xWjsufid1OmvuteA+gOkBVkH1xaDrfhTm1EqfietmBjUQzIfsHXxj9qdEfQ==
X-Received: by 2002:a7b:c3d9:0:b0:424:acd2:40af with SMTP id 5b1f17b1804b1-4257a011a44mr89725135e9.24.1720040714880;
        Wed, 03 Jul 2024 14:05:14 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:05:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:51 +0200
Subject: [PATCH 08/10] iio: imu: bno055: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-8-34754f355b65@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=857;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qD7vYgNjKvCPG8RA54s53vsMIszSn013olEo9C5PosI=;
 b=fSiNUb2Xf4JabmdPthdo9+qtDPOXq4jZbNz1HzxA/NDjaJELyEw7QUL3jpv8zm7d2MrVjD4Kg
 pPE+h+G8O2CBRePfXMK6QSHwvTYSsaFUBi5yBPhDxqKAz4BaupqRxC5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`bno055_ser_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/imu/bno055/bno055_ser_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu/bno055/bno055_ser_core.c
index 694ff14a3aa2..da7873bfd348 100644
--- a/drivers/iio/imu/bno055/bno055_ser_core.c
+++ b/drivers/iio/imu/bno055/bno055_ser_core.c
@@ -492,7 +492,7 @@ static const struct serdev_device_ops bno055_ser_serdev_ops = {
 	.write_wakeup = serdev_device_write_wakeup,
 };
 
-static struct regmap_bus bno055_ser_regmap_bus = {
+static const struct regmap_bus bno055_ser_regmap_bus = {
 	.write = bno055_ser_write_reg,
 	.read = bno055_ser_read_reg,
 };

-- 
2.40.1


