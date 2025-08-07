Return-Path: <linux-iio+bounces-22381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D32AB1D3F9
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 10:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C7B726372
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2637323F405;
	Thu,  7 Aug 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiZ8UEUL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A714A02;
	Thu,  7 Aug 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553942; cv=none; b=W53yVqgkVZ7KM+v+9H5Q2rVaD8Ux/mYaWkFtKw0KM82RvZqkGlVLpzqW1IFJ83TPTU/c14r60/k3bkdRZgNKnyO2beQ4etLqf+vu7mvFsKk1/lw3Wv6+khoXbCCpUsdm19qSzZCM9W6wGGK34ZhfruHoGX9RFQGV0l8RRFTiwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553942; c=relaxed/simple;
	bh=ip6K3fdTKfokHW17Y6B1Ps0/90JQcfs+OErW4kS5DuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IKuO30Kzv5ez50y+vDmFHSaNDBaXh5lnq/diqnvAiVW8mOIWEYm88G/ifmEjnXmhLHpKhrKH6xh7QRj3CRSwj5+ecPjpCCUt1mbYqjKX0NFZbYlWgp3S1G8SqdL3Bg2I2PimcOSbqBhfJKztj4TAA3eXbngr+TjQDTrpZiK0tLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiZ8UEUL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-454f428038eso5921755e9.2;
        Thu, 07 Aug 2025 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553938; x=1755158738; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTA2hXl02Bzi5wRFrDEw+E3Nz6ei7Gh7Y9iWwvyZTt8=;
        b=QiZ8UEUL0k3yhE8IqCLV/e9JsJu0aicI9M/v/6ivd00SePvAqV7CXfGO310mI3hyut
         XvqAywqU4JYTk72rMadJw6NseKJBPJZ/kE2LX8ex0hQxcEyjFg6bMVJQ2qfMDkoZwY/P
         CtKm4UAEA/dH42HN8nzptpE5FWBPQuTplADWvRoKu8JP6c9gF/zfAIIevMi3mfR4Ofmf
         f+n/wPRGf1IHsYfgjY852GzpJy+iMXIYGAr5IIurHcCBYkYsIRB4Yu7ZlWGeEI7e/0XH
         SK6HzTexiWhbPauQPy5Y7oDL5TPkBR+A5NBCwyzCHaYa/AORCqsecwvoNIhlPPDlCLj8
         nTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553938; x=1755158738;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTA2hXl02Bzi5wRFrDEw+E3Nz6ei7Gh7Y9iWwvyZTt8=;
        b=CiVjgw5sk3Fxsbb0nQZl9FxrqEElvBRzSUjVYXhxEeKTR1w8/USspXsuBK+KXwCzMw
         YCPhyFzVZFQzJk0rOWnVYDGZa6ULn0suXIJqUb72aGJ+XcOw+bq7qwMyQl6iA9I0jfqZ
         tm1E0n9fTIZL9w9Ra2vfp+f02SxZqujlxdSK/3OcCLuzfGIORzi69bBsL1Orfmgzr9M6
         RMCH3wGrqPrCDB5rJwBH+nhXUCU4+/ZUo6daufVwRG+DKLmxHLlJhWUBZ4V38dPpCCG/
         G1C+DDWnGbLWTpfY6hMvFAlTaowN7hjVHNPuaTEhp903REUitDwl8NqeGA0Xjhu6lcSL
         zMNA==
X-Forwarded-Encrypted: i=1; AJvYcCUGvUep2d+0rkRWthMOsWeE1V2Lq6HSUyasBRYhG2vO9KoVDFJOZZi7pwryZvZFdN6F5CL5kS775yE=@vger.kernel.org, AJvYcCX4nWjD6MrVPzqBp2G/ycswNil16MnWkCBw+DnXq2ZrH39GKjUNDgx2gCSJ/BsENIZnZc33+6Un+d2lbiLL@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/66/IC5+NQ+KD/sfMmA2TUh9S3/Xlk0AFg9qu7l4zrX6ZVTP
	/HkHWLpqGURiMfo28KDDoDgOETnMGpmPA8Nhye0nOXdpSpaMLw4gnsEP
X-Gm-Gg: ASbGncsYyINy+eFwsjn+9hp1oqoBQk9DCwyIlevXE0mb+hA3rWFXK1mERmgwO2oQFoJ
	N4A1MHkCwnKyMI0c7PCGJM46Pkg3tVYDkZnRLLan2s+NoA3FQk98lRTFUpExHKKnN3oglR6Pgxf
	lFdHKwNqM+ZKKcuet2Xo+6I9UoszF8Wznj3Z1Px4Mpshfa5MtGQUGnjfSnmOjueqMAGbPmoJOFL
	MYwwCCm6U5vj6kz6wnbN4t6KsS8FChdI9OWYJhazBBUCGBrTI/YOsqP1OpcLunlKZyQRQA9yTGI
	xXu8441UmXbsC+SrroGSgYIze0kFY+tIisO8iX19QbUx/zINAdhpgIQvT7JVKALhu7brcxDCaVA
	jZSaAsPgjysvAIg==
X-Google-Smtp-Source: AGHT+IFqNRrMjMZ2LEIDWMHV9hg2RmoPj3QYwvILfyKFp0XwBTZwz1kdN5a9ezudOIdvz11DNt0BYA==
X-Received: by 2002:a05:600c:3103:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-459e708e76emr61697195e9.14.1754553938150;
        Thu, 07 Aug 2025 01:05:38 -0700 (PDT)
Received: from pc ([196.235.182.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459eec47306sm20058095e9.28.2025.08.07.01.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 01:05:37 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:05:34 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
Message-ID: <aJReTh-t5D45aZNV@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use `ERR_PTR(ret)` with `%pe` in `ad4170_read_sample()` to properly display
symbolic error codes (e.g. `-ENOMEM`) instead of raw integers (e.g. `-12`),
improving readability and debug clarity.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
   - Improve commit title

 drivers/iio/adc/ad4170-4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 6cd84d6fb08b..6296b5dc930b 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -1253,11 +1253,11 @@ static int ad4170_read_sample(struct iio_dev *indio_dev,
 
 	ret = __ad4170_read_sample(indio_dev, chan, val);
 	if (ret) {
-		dev_err(dev, "failed to read sample: %d\n", ret);
+		dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(ret));
 
 		ret2 = ad4170_set_channel_enable(st, chan->address, false);
 		if (ret2)
-			dev_err(dev, "failed to disable channel: %d\n", ret2);
+			dev_err(dev, "failed to disable channel: %pe\n", ERR_PTR(ret2));
 
 		return ret;
 	}
-- 
2.43.0


