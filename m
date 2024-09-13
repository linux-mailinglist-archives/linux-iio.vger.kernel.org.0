Return-Path: <linux-iio+bounces-9502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D29780F7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816BBB253D7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F91C1DC066;
	Fri, 13 Sep 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMXC7P5/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626171DB950;
	Fri, 13 Sep 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233564; cv=none; b=QJ54+ghxvXTSZ/I3hordMRtd7EP5vRZyjeq+G64SXXeFORGNeJmUDB+aRdCx2qHCZYTfottvmFNNwK/OCEOrRgOXFMm6RuS9FglyHwbnVNDRm3iM1y6RGqe+I2Kv3apuNYWH+EJ+RxD/4poRrBmt9AwPS8WXCq2nRAXzw5g3pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233564; c=relaxed/simple;
	bh=hQa3NqtaF4hSnoJYvqyk19IgtdrMWznpl4mBDkybv/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfRLUuFxfoqZ74P3vFJbBsM+Az2CP8Nol8gdngiMmhogDoQ8aB/mgsf8BeVm5Bi+oH8/IQ6EycCJyIwY7NdcbcFpWY+kPZBEP+v6QKjWlXPBfNrIEOIcwyWzY++1TnQYpUmjXq1q6TwwQfe3jxCXDH1001jCh9w+8MfboXr9MuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMXC7P5/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a90349aa7e5so217914166b.0;
        Fri, 13 Sep 2024 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233561; x=1726838361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46WuIa6Wg4WuPmTf2aI2/nmOazVyUrvPtKQX6LQo0+Q=;
        b=VMXC7P5/950oUNs9rIkk9pjyb5FhiauRAa/yHs1qkg+k/FsHJ5VXnWeBYHDNWF11np
         VNVEQ2d0OvwAc819CrnXZKGJpdImuDCcuBw6eAYnWxeIlgx5Mc5N55uTQjy1itXnCJ8e
         YJjFClwqDdg74oZNcdmQvMnZI6XhZch08aauUIPsM0zaVtJ196Rc22Jc4bJXm4yTfyss
         fyvSB1efPrZXOlwyZ7v2u0OgWouK1e2HbFtgmg9bIj6oFB3QM1W9W9lyiV2j8LPTrdd2
         a7ILlJ6pvVGZLkwKAYzWhKigLYZUV8HfsUdtkONVUG2PB8M0lz+1Fj+YEAZZZNZnUyOM
         Icpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233561; x=1726838361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46WuIa6Wg4WuPmTf2aI2/nmOazVyUrvPtKQX6LQo0+Q=;
        b=LH5klbNmte4pf4EfZkfpV506YETHPoIFO2Vbr57EVDDnBEWkK8gfNo46YNOFX/OUqh
         DXgGofqjvcLBWzEa+rlGyiO1VkJm8mAzEjEhm9RgkOtFMqjQEopY/GJqfawjjQJp7g/e
         ucOtxbXI7TEXN5AYk/HZ1SD90gP3Ehbco3WiqFM/W7AH1eyaw8iUxkS2E/A5qrcrnm8V
         ke2ZSnvzzf8YHDnMePMya2A70RSaDKMDgPU0PICJWS+XlhOoKWB72YFWRNr+etFTVLbe
         NkWfF3rhTw1xy/YQKhX7PNTrkbGE89rwHbrpoIX9ucimirF1lmQTrYnNSSdhRUgDsm5M
         zsaw==
X-Forwarded-Encrypted: i=1; AJvYcCWpdCl8ob7D2T+1fE8/4WhG8LpcbK8rvEBmoTN+54HnrS0WuwdhdZL/ml14lQbTbwgEpmXSNH0mvA9WC/u4@vger.kernel.org, AJvYcCX/hhEClrnbRW+JysZdOr6Iu7sBxxP4JCym4HvZtTrGPI48sIg9UAAQtHQk1piz1vN4tYFT5AbpBdn3@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAveuQ2Dk8ZERqaaWdyJobzQXuHthoOUd2dJaM+hxB+2/540Q
	ct0m6K4urxLSaEpLSVb6380rShqujOxA+Lmx179UNfBisyUOsQsf
X-Google-Smtp-Source: AGHT+IEY20oVwxvOlLsWhyJwtNYaUv5yoOmPqv8cwwggD0e16zrCrRahKkf9ii4oomxWng2SAXSdLw==
X-Received: by 2002:a17:907:e6a5:b0:a8a:5bfb:7d1a with SMTP id a640c23a62f3a-a90294adcf2mr526534866b.35.1726233560500;
        Fri, 13 Sep 2024 06:19:20 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 13 Sep 2024 15:18:59 +0200
Subject: [PATCH 4/7] iio: light: veml6030: make use of regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-veml6035-v1-4-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
In-Reply-To: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=846;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hQa3NqtaF4hSnoJYvqyk19IgtdrMWznpl4mBDkybv/g=;
 b=u62XfMUfN0ZB9Jd1+cnH/5PqbJX07x9nPtSKv5fN2e0VLykLA0yTmFajgmTC2PsuU2nEGJyI2
 5yyVkTYrUYpAtjmUfF12lSToXFh9oqzD3ZKvmsUQzSF0tRH0tAkvpMQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Instead of using regmap_update_bits() and passing val = 1, use
regmap_set_bits().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index df2ba3078b91..5d4c2e35b987 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -149,8 +149,8 @@ static int veml6030_als_pwr_on(struct veml6030_data *data)
 
 static int veml6030_als_shut_down(struct veml6030_data *data)
 {
-	return regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-				 VEML6030_ALS_SD, 1);
+	return regmap_set_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				 VEML6030_ALS_SD);
 }
 
 static void veml6030_als_shut_down_action(void *data)

-- 
2.43.0


