Return-Path: <linux-iio+bounces-9716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D797E406
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFFC281297
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99013A87C;
	Sun, 22 Sep 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZRh/PaZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C684D12;
	Sun, 22 Sep 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043491; cv=none; b=L1uprLUzDFEThgyWZagNURDPcgGm4CI8yn+GBJW5Kj1y/NDivVcOapfcKKDg0sApvGdPlnrPrHfourf68DejrB+WYa/OBjdj3GygZfQ8kRXuXcorn/p4U1RNa77OZYQol5yD/dhBWlcMmO46XOoI3gLMb1xcM+GxtHQvhjzMOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043491; c=relaxed/simple;
	bh=LwEcg3PCOM1SofU6cDRNJICLyss4V52FTFGAQA+uy5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azkxkhV0j0tUcYZub61zUo/ayHGPcOs7Inbx4KsjQGJ3DQuyOw2bh6Lt/qFUQI2f/iN5xS2JQFLguTCE0hm6Bxwl94evK46tcb6x4rVOQ6RfPrQuo4cuUMmpLa/vKyUdosjevIk21l7E5HY2ZXV3XGkiSgkjRwJcngbffSzgh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZRh/PaZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so452990466b.2;
        Sun, 22 Sep 2024 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043488; x=1727648288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVD9M4uTcrIfpcx+PQ6CN0y0T3E8wYUNamVjDuflMws=;
        b=YZRh/PaZEq2AeVVPEEVqfnmLRzvJNd9z8rZ/WvgNej4AJekj7FPsiQFbV/5FhLz4dB
         SWO3GPn9givj1jBYTWxjuB9g33fTQVk3L5Gt06dtDcjXEOSMBWwRey973sgONizzd/NS
         Gt3n1/sJor/AUKnBn9iSw22J07ujZKqI7Deo1ktnH4pQHdlBxdmki7LHZKOuYNlgFuWH
         9Af1+7OMvRFy/r6UPxmtEyiM5X/SBGTHQZUqOJA5TCtI4noXU/JrFJqfKkF4FBZWKJob
         rFfIITdOLdUk/YuUTi3gDN5NmxYd2FkJzv2w9glxvqgnMDdZBmQW89MEB7Gv7SR6J8oE
         T5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043488; x=1727648288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVD9M4uTcrIfpcx+PQ6CN0y0T3E8wYUNamVjDuflMws=;
        b=ID9wobHFyxhbHe+JAf8k8qhaohpqfrx0Z2FxdNszLqLIq50kr7YsVCDBp2Bk3JLPd0
         xl0hT325FuSpNhhnj+6vOzs1ig5wI8kefdr1RlwZ46RnDi9t7L7B5UySea/C4HZUOvcs
         rhDe19+I8mXl8/JNcr0iwOvxfHs1VgYgLIHeG8f6PlPFd3zofuPcFm7OogZPEoRFZ8Wb
         qlqSJXwBgJwvGgsP5VMVl0U4fW7iKxSQT5fRnozfS9ru644g+JVD6s8nk6Ai4f0D70fb
         CRr7jYezUMcF9JTPQ42lJi2TifY0kW2IsR5XdkFf13zs4EYFRiOwaMdZDqgRuOiJmwGs
         cJJA==
X-Forwarded-Encrypted: i=1; AJvYcCUsjqR/TWB/la3RX760b1CYQFHNEg2Vrg+zotlNgRv88E0W3BItHM40SyOb5z3OmK3EUYJi7/WTN6CmYMKP@vger.kernel.org, AJvYcCXpof8yBuev6dd1l6THp5PhDtZfetfF9c7KCiTfJrjrA2E2O8hOINYG6aTUsOSz9U+K+BpabgsEEr4n@vger.kernel.org
X-Gm-Message-State: AOJu0YyfV04bnwAAFnRgQNC0N4d/7A7gK31tIL+QtNP3g/X07z8AIUdQ
	d/06HYXZmVboWXgMNm1SK6T4KzE2unbfJ9iiPvgaJTWmjLz3n1My+JOlj2uZ
X-Google-Smtp-Source: AGHT+IEa4PkXmrUSBa15Lh6mKNve0p2Fxv6QV71vbi7OfTytfZtZNe7g6y1ul7SFoKSH7X1yZdQeug==
X-Received: by 2002:a17:907:9346:b0:a8f:f799:e7d0 with SMTP id a640c23a62f3a-a90d549c3d7mr995470966b.5.1727043487505;
        Sun, 22 Sep 2024 15:18:07 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:07 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:56 +0200
Subject: [PATCH v2 08/10] iio: light: veml6030: power off device in probe
 error paths
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-8-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=1379;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LwEcg3PCOM1SofU6cDRNJICLyss4V52FTFGAQA+uy5U=;
 b=I7lzY9QRMbTyURqLSoXJ31iysm4FK0q6OsQPh7bW4NKGFQTuEkC7MmYXlQO02KYDxtmNSOpJQ
 vQNvfNPihnyC2kimPijSI55q/vCOa1d7NVZfDcvSIVbM6g0JW667rqa
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Move devm_add_action_or_reset() with a device shut down action above the
hardware initialization function to ensure that any error path after
powering on the device leads to a power off.

The power off action is carried out by setting the VEML6030_ALS_SD bit
of the VEML6030_REG_ALS_CONF, which is harmless in error paths were the
device is already off. On the other hand, making use of the registered
action in all error paths makes them more homogeneous by avoiding
special action depending on the current power state of the device.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 861bdf2edd4d..19c69bfad8cb 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -853,12 +853,12 @@ static int veml6030_probe(struct i2c_client *client)
 		indio_dev->info = &veml6030_info_no_irq;
 	}
 
-	ret = veml6030_hw_init(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev,
+				       veml6030_als_shut_down_action, data);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev,
-					veml6030_als_shut_down_action, data);
+	ret = veml6030_hw_init(indio_dev);
 	if (ret < 0)
 		return ret;
 

-- 
2.43.0


