Return-Path: <linux-iio+bounces-23180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE8B32FE6
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 14:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C783E481F1A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14C2D8766;
	Sun, 24 Aug 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiZK+9Ad"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7332D8390;
	Sun, 24 Aug 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756037177; cv=none; b=hkMvrO3J8ydgKtiPFs0PEZ14W/lSQoanYI6SQNoJ2zOB/yQUPclAeoZwmLZ4ROZ+YZe5RQhbZMB5zl8qjPDFwsvYhiu6lHA93qjaOVRb8swxGgyMBg0ybQULlEGBUgdYshQZ/BUm5f2ocJCCEKVSFvbdGK2CvzRZOohoI05G3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756037177; c=relaxed/simple;
	bh=EcHW3M+l9wWP/+s19RojCchMa1zyI0TeeTdSpWzpdmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WQz91kqMXN9ENhfVb2YYP4k3205jzMi3qs/BPXymziPo5eXMjOGrUlL3htvBeJgCXehIoUhMmv76eFi8qqG/15zQn99vvkE922RbLvkrwATjqefx2ps5Dl6fEeME4AQkkc08ao7/SLG8cQtjwKPpv8AguPPek05TztnhdzH0cgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiZK+9Ad; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b577eb4dbso9199905e9.2;
        Sun, 24 Aug 2025 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756037172; x=1756641972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H794ow8CiURLDevruDq3Q55f0TUZvs+3H/i8Gq6nUw4=;
        b=TiZK+9AdNoAAwnHXQ2oukFLs3VYydnz2AAisakWeHRdsvGkeuW7RXhb5euBkgWhFmm
         L8gw/8J51OdBp1K3gBEOJJH+QPJkbZGbsYFu+m13FwRllcE7Xm+cCXxUMDI+EAWApuLJ
         7vOEo++Jo+QGBVD2Wk1cd2/2YlIISpHar4sTvoP+84jHMktI9ZFjo5/Bz4ZePMJV4+sB
         YLLkSkAyTEzTRf+LOhbmOxcUbe3bB1KY434V+nvYSCZJ+tJCsmZlF3HAt8JymuEoIu9U
         299QBPrzgzjrVZVG7nP7YEX9J8CUuvrOAzqxJSWk/WtAw9LLqnWrG1cGbqzhuNm3gFu2
         YlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756037172; x=1756641972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H794ow8CiURLDevruDq3Q55f0TUZvs+3H/i8Gq6nUw4=;
        b=dlFTR6B+a8uveFvYQf+XhXKB5jcUCRhei6knvRic9fJ1ihW4tITapxp/iqkdzD/dH/
         46dfQB2uUv6gggbDilDFJW/T3RWhnks7UK6t8jewGFMZchWxBYL0J+poSK3uKS5mLgaD
         EegKjERp2JCazqsmFIrsSkbwIGq4CFNveqW0Bn41D7AcR1qmzM9HkzZBlN+QRKFbpd52
         TEOwdOESWrnnXvxKyZC1njzTv33m8zM/HICcfcm2tU67rAksli/NH33OKpyAGy3c02pG
         OhXPDSc+YnxZzMY3XBnSmIyjbR7j3QHn7SvZtgUjFObcK74zN7RsJi50rBR2M2jBCd08
         kVBg==
X-Forwarded-Encrypted: i=1; AJvYcCVGSv/pJzb4qub9CWEAGaErUGktEKy8kZJ7tLbwnmnoroyIiS8NW/8XRsk2UKd1eWWJvzsZtk6ykh4=@vger.kernel.org, AJvYcCVlwDa/CMc4dRIRLZKTuTcdZ2t/oeQIJPgyalgwO/eI23DWYqy49M7fyhT54Vu1xYxf92cOYgK2pgLKJOD/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EudeXJah0B0NxkfII0RFLpfOQA/QdVExk3zO2nE9a+kpAcJb
	raREMk0MZ+QJXjDb45Ho3c24JpTglPKcYiA9ZxFrE+vhHOUD+hzwysg/
X-Gm-Gg: ASbGncsbDdJGURfGsioATN26QXw/prlfGOrCFO89ZmSWNQ+9QWgcYFuKWDHuP6A5J/r
	0QO0Os5pJ05JM1qzyzlhbV604eQHTazUxlyTdT0d757shL4GylkU34FAV7ILSjrpnAMs6uVa+ZS
	v57CQvLoSd0kHBneSHrbqT/ZnH2iITc11gsZNOc0zzVJFU7gs/h3snYHs+9v5rbmUzPSN14HSHA
	CQlMNllAQXpruEJ4pRKQcs+6D4bTmu9e/ISWsyA8bFHiyPql4dgaeqe71d6vq80e2rAF2cMJz4T
	4FBxwE5UfuJnkVzb7aDJAFCqoHT7lnFWw0aPSlQmQkDzFxe0Ro1uNZXDuH2QCQuutpoKKr3URCF
	7T7Pu2Ju/r95OM60s7l1GTpIV
X-Google-Smtp-Source: AGHT+IG3OsG0N6RxtoIwpToIvF22LbUY1HZ574UdL4CI+iIN9zz0ZXYKkIAp2gwg7y5bu1eWt45YtQ==
X-Received: by 2002:a05:6000:430b:b0:3c6:9e21:f61b with SMTP id ffacd0b85a97d-3c69e21f717mr5411389f8f.3.1756037172319;
        Sun, 24 Aug 2025 05:06:12 -0700 (PDT)
Received: from pc ([196.235.198.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70eb7eed5sm7096110f8f.18.2025.08.24.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 05:06:11 -0700 (PDT)
Date: Sun, 24 Aug 2025 13:06:09 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v5 3/3] iio: pressure: bmp280: Use gpiod_set_value_cansleep()
Message-ID: <aKsAMRkmGX160gHl@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace `gpiod_set_value()` with `gpiod_set_value_cansleep()`, which is
required when the GPIO controller is connected via a slow bus such as
I2C. This is also safe to use in sleepable contexts like the driver
probe function.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v5:
  - Clarify commit message in patch 3/3 to better explain why
    gpiod_set_value_cansleep() is needed, as suggested by Andy
    Shevchenko.

Changes in v4:
  - Split patch 2/2 into two separate patches, as suggested by Markus
    Elfring.

Changes in v3:
  - Split into two separate patches, as suggested by Andy Shevchenko.
  - Improve the error message to "failed to get reset GPIO", as
    suggested by David Lechner.
  - Add Fixes and Cc tags where appropriate, as suggested by Markus
    Elfring.

Changes in v2:
  - Use IS_ERR() instead of IS_ERR_OR_NULL()
  - Drop dev_info()
  - Use gpiod_set_value_cansleep()
  - Improve commit title and message
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 1f0852fc3414..656f6189c84c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3217,7 +3217,7 @@ int bmp280_common_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
 
 	/* Deassert the signal */
-	gpiod_set_value(gpiod, 0);
+	gpiod_set_value_cansleep(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.43.0


