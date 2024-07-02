Return-Path: <linux-iio+bounces-7178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411B9924674
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732D31C20947
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0DE1CCCB8;
	Tue,  2 Jul 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f04+9I1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF91C230C
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941654; cv=none; b=bx/gAv4LmnRr3p+n+oBq1B3q6Q0JP77pMmqdcu0Zybk3zAxZGI9paC5Q4QQKnoFKQAABWwUPVrhXwXOigyN7gUtSeYNczPt5PQ1uAKltIFjZUqgv+EYPWfwHzxYlQ9T2kUNUbNByqEyhd8M+/e+uOdU1MAUjgbQCMzlahA8qtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941654; c=relaxed/simple;
	bh=TIZIXKMsUIcBcBNX8jkDzeY8VA7Mhb/sJ7N5yvRpSuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLAscuVGrzEvxKMQX4/LU+QjybiD75MYC86BFlWOIkmmUxIr0bgUm97IOeK8zNsSX2f1bkUwhJcJREMeZ9RmFI4E5v4m9e43vWQNyM3G2jCuxYh5WX1dGZV8knFSJUXia+qBplVX6Yg9CFAX5kNEJJH5L4H41UddyL2HfhLFJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f04+9I1Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424adaa6ceeso27607665e9.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719941650; x=1720546450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0syamWwYKEIgGFfBRP6mPS2Iu9QxWFGeekc+8eB0dRA=;
        b=f04+9I1Zp3cuLVlh/iAyzqvyLqR/68uCE60iStM+7uiaA+NyLfEIhUU/fBEOK5ahv9
         W5+qEKQMAGz/8TAzWesVAKfHURcOsU7/4EI79CGAKDVsLbK4sFiuQ4dofCfXafxeFlul
         V8uTBRmqvkYu2dqTJLQvF1K7REeYy0oFREGAzcwdrf7EgM29goqFrq5pr1WyPTwkdcD6
         n7ijdi3EdUM+RDW2MaQ4QQqt0Ne5eD1XrPOTBcnHD/8ysSZenDYfb7WlBnVkj8qJ7uBm
         r5kODm7INJp8Tep99c2QJzme64wh1O+bsN33Izg3hdakNMh5AgcvfVblmgqQ+C+/M6gb
         U5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941650; x=1720546450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0syamWwYKEIgGFfBRP6mPS2Iu9QxWFGeekc+8eB0dRA=;
        b=qmSYY2Hcn9L7JvYY6Ob0NEU7Roo5M5BTmvT0yQ17Ol38XWDJUjWA1kThgi52IbwoLc
         L4fKfBPsxyxaUS1SSXccQ53p+23cumKJZrOJIgBuqHtd0KaNnVLmp1quYAwzngp4ZPV0
         9TWXjozJCFvK203Jr0wdFM+jiZeQza96Fk2SAUCtbZNo90yFL7zdEsa8/+yuldvs6uvQ
         bK2rGHQGwMQxLPvISGrbKFQmg7bWMgFUPKHBi2v+sCsERSce0NnBeBCoEPxbG45TmWyC
         pOofSrRgNGlP/c+I1mrsjute789HaH0Ifidwv2U2/yU0idHxFYAbleO6hDjps807/qA4
         RaiQ==
X-Gm-Message-State: AOJu0YzYwr4bDlppONIdmZBpPWVmR+pTtrEfWWma/t5cbDJlNWIBblzz
	WDTDLJ3R0OSr6U3hTdNeMyyuwJoUasxEbHhyBAIxWXwabB3n729AFj9C3Pj/BSped9E2nA7W//N
	j
X-Google-Smtp-Source: AGHT+IGN3I1TDjEjBKz0vG4KMqWMRnm2beW749dxNHUbKBT8wXNy3HGwouwwrskcWlVXirnWgcSw2w==
X-Received: by 2002:a05:600c:1c8a:b0:424:aa64:e9a9 with SMTP id 5b1f17b1804b1-4257a04fe59mr72838155e9.26.1719941650328;
        Tue, 02 Jul 2024 10:34:10 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm207594485e9.11.2024.07.02.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:34:10 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 02 Jul 2024 17:34:11 +0000
Subject: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to match
 the documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-cleanup-ad7606-v3-7-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
In-Reply-To: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

The binding's documentation specifies that "As the line is active low, it
should be marked GPIO_ACTIVE_LOW". However, in the driver, it was handled
the opposite way. This commit sets the driver's behaviour in sync with the
documentation

Fixes: 722407a4e8c0 ("staging:iio:ad7606: Use GPIO descriptor API")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 8cce1fad9763..50ccc245e314 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -443,7 +443,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return PTR_ERR(st->gpio_range);
 
 	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_standby))
 		return PTR_ERR(st->gpio_standby);
 
@@ -686,7 +686,7 @@ static int ad7606_suspend(struct device *dev)
 
 	if (st->gpio_standby) {
 		gpiod_set_value(st->gpio_range, 1);
-		gpiod_set_value(st->gpio_standby, 0);
+		gpiod_set_value(st->gpio_standby, 1);
 	}
 
 	return 0;

-- 
2.34.1


