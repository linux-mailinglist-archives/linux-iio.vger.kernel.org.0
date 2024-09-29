Return-Path: <linux-iio+bounces-9899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DADE989758
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE98280E8C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188D817F4F2;
	Sun, 29 Sep 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WueAZlfI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D017CA17;
	Sun, 29 Sep 2024 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642338; cv=none; b=U7fEcd6eQdIboe711rzVFj4cUdcivmsiY3NlygwxdCaEZYXfs1Sl2xD3Mz4IXedGYieTuNIhpoY0010tK4VyxpGY2uHF8Ql99GLzGwtOJOe7DP4lheFdQ+K87DAEtavW57xuKpua9CX0qmOLBMmoF3n3Oi+Tz9cfa+FH9uhXR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642338; c=relaxed/simple;
	bh=xf9Ckb52b6K2cFHLA69xB+QNNC6/b5yI9CCbBoPMqn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUj1+cB9a7feVSe/wU5OdLxWIIxlCzlAQ8svR7amRng2Jj1DmL+Wb4+E2oZawABIgEAzMkRXCzJfKuHQV+UD1GUQl40WNbA/Nh1bMOJrngjbPzrAnBdhR7q3kE8AR6TXfAn35dHBCL3he3Hspfxt0QPSIOknCLEmy6CfVKQj6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WueAZlfI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c88b5c375fso1867774a12.3;
        Sun, 29 Sep 2024 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642335; x=1728247135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JYGK3JMqfTPdWjEdWDCZFqtYoOKBeT8G6aSVaHOunY=;
        b=WueAZlfICC6xHtfd+OS2ExXEanq3F3VOH/GPtDddoqqufr9Y2sT8JRBpxTnNHWtd9/
         jX12/DeEdltIPXE0vo5LRzl5KExdtUP4YTiwY79g6OlqvboT8QZswdQbbo7hEw/XMkD0
         8IDtFp64wtVBAdC699vQz1rIkfsr0FkBcmDPtDI9uYFSaFYUAaUKM4I3L+mXBvDZJX4Z
         LL/HYrpwgVvHFY+YZcfWVAMgPyCPKbHGwMDwr0AGTY/MKX1YmYgUqHqv7ZLxM2IWRO7J
         Z8s4we4oiVfjamv2zNNxrt6RXms7ST/NzJC6pciIQvcyb1uUd8vWhmH/GQMhnHekgN/w
         AVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642335; x=1728247135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JYGK3JMqfTPdWjEdWDCZFqtYoOKBeT8G6aSVaHOunY=;
        b=fpHBmmsVcWoKYwmCDE1dc5xXjJqBGWbk6774zB3ABY1mxqj0YMmeZvdJwT4k8kSE48
         lfgaJJZ9DwopiRlHlIhOStzlZ7ph7LQiXdmMp1uVTlIfnKCvdsOx45eKlLT1KHFpN4PE
         stSxZQQHczyPxGoBtzC+05DKcDccsnqkvlEhh/UMVEkJsBns5LlkzB8We+a+WeguUh2I
         iiEFNVHSQ+XBCP4cNswjTzZKpiw3+yK0fs1JY/I4AIjkFYRGTruIcKcjGK0Wu99iyZZp
         Owcga/v6736bkwUiwDrfcnhLy4OTBwWKRCyUkeq5P/t/KrQ65H/AB6Saqd23ISD7jhJm
         z6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCULbeDHqjFdOKAqK+A2G85B5nHljK5jWWukbxJbKrE2WryTOj3MVBn/FPxm94MNaI8flEwm4NHrH/LHrg7Z@vger.kernel.org, AJvYcCV2vspE2lZGgieAO2ROMOCYQkVH2V3HKLDNzr10E4wh9WLFWioPdvQmn4WGayenga/qWGMAWRoQv36t@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9WqtGwTAqHiYg8Wj0mPLWwT/w9Pt3Whfo6nh74XtxEiLZ2ap
	DvYHYUDFw2cVc8I0moV7o+asKfWcolju7JnyN1opLgZ3zrRLVQoz
X-Google-Smtp-Source: AGHT+IEhzqMMHaiaG0NLtL0Y2+VDkzF834cXcGjhJEamrAkNlgYdKPmVce0ZKlegu3N5ED7iW4Npmg==
X-Received: by 2002:a05:6402:27d2:b0:5c8:9406:535b with SMTP id 4fb4d7f45d1cf-5c89406540cmr2986927a12.18.1727642335477;
        Sun, 29 Sep 2024 13:38:55 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:38:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 29 Sep 2024 22:38:48 +0200
Subject: [PATCH 3/7] iio: light: veml6070: use device managed
 iio_device_register
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-veml6070-cleanup-v1-3-a9350341a646@gmail.com>
References: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
In-Reply-To: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=1211;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xf9Ckb52b6K2cFHLA69xB+QNNC6/b5yI9CCbBoPMqn4=;
 b=6nCj+b7TpNO6MD517iTpiGnn30cxhTKIpqGAIGKziZxaWtvLAcRoWuqIBe2Aun2wGW4w+r4gm
 MlXUKqR5hD9DFyoUm2DAoduRK7djqk46x1KtVPAKgAGspA18S81bZcL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Simplify the code by using devm_iio_device_register(), which removes the
need for a 'remove' function, as there are no more actions to take.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 945ef58beead..d15caebdc959 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -179,15 +179,7 @@ static int veml6070_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	return iio_device_register(indio_dev);
-}
-
-static void veml6070_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct veml6070_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id veml6070_id[] = {
@@ -201,7 +193,6 @@ static struct i2c_driver veml6070_driver = {
 		.name   = VEML6070_DRV_NAME,
 	},
 	.probe = veml6070_probe,
-	.remove  = veml6070_remove,
 	.id_table = veml6070_id,
 };
 

-- 
2.43.0


