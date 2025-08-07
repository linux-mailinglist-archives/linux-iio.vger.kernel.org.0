Return-Path: <linux-iio+bounces-22362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA88B1CFE4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 02:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC092627B25
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 00:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AB82899;
	Thu,  7 Aug 2025 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF21Us2L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944212E36E6;
	Thu,  7 Aug 2025 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527977; cv=none; b=ERzm/pcxB0YGdMRvQrBTj7+5VkzIa9Px/2orFrJSl19el0qCU3IKFgWMRtuKXSXk0Q7rvZeO4n2TrhcoR8Fp6TIJxbEJJ8Ew+u8YmX822a5z/7fYCqLBw6ivwkHcIvxaWypZCQzFaL3aofRx7I5Jue/638tC1kQpOBrunPktHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527977; c=relaxed/simple;
	bh=004Q6mjb/Pxd9tmkl7MKhwG6xE+VxOmdyluW1emBuBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m46Sw6BnKWI1gK4ooM9zqwc1qsO2sk2Htt7yZ7ru2vzXcUNw9S5PyYtTqrP59hXwPEgoS3B+j5uBE5TDnIhX3c4xlnsn836X/YM+fsSZ5YOgzGqWhXsIbfbK02D7xQaZ8CJbsDns5GnFJ7dkfIJ3xCOvnRuCBfDbzaMaj+ixHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF21Us2L; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b79bddd604so207769f8f.0;
        Wed, 06 Aug 2025 17:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754527974; x=1755132774; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHycraAHZoDHIpEDMjdkuGlgk2vS/xbQyyeGIO56y0c=;
        b=aF21Us2LnmYbFcvll99XhPKHimgnSOBgaYPrbiR5eJCskNypmnDtOQt7B89crgn7r9
         +PXCZAZccmFGMSOgN+dZ75FI7AEFCHF7a6PYUfB+cExbAl+eCS8MpnJNmDUONW7vJAeU
         mP0z5e2NVx7NYrSz/L9Sw8K5pvfHmt4GnLfRPrpmlUrU4MXksoag5YD1eOrBLWcScCkq
         bg39MI4qywJwFxxQxXGi1yVYU1udE+yk6mCI1LYUVONNNyVJiNFse7vCggEYxPyC7aAl
         YbJhfqWjqSsNgjJgJ+QnaF4BRUKtvwM6RIORMV7SUZAlb9VpnaX8CL+7A95GskMtaf+T
         Mcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754527974; x=1755132774;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHycraAHZoDHIpEDMjdkuGlgk2vS/xbQyyeGIO56y0c=;
        b=Z/Nj9SJQnjBDYm6mcSlFuHNGgtsyXpWIVkZa39wnppwgvu+Mq6jQuRdZ/A0yOk5bYI
         x4iLbT9/B1lHAMmziLK/anVgnkoEcAfDKRMiPot2YHcZx54EOs8ZML0qcIcUWBHKykdo
         G1RwXsUgtaSmCf835Z5Eb+VFvH0mSuyEvHI/BuQoOc6TlVPbA/3mfkWe19hrPASaw0Nc
         8XQFfzy6ZzEfDfIQNzqLeRj2zbqQDcaweyRkrYy9jDwg2Wl0EWHXKWrvyq72taIxzW66
         VCtQLXegY22I4Kw5plrjohavftf4wgras7mMLqbkkZ2QGfudChbhJCxkeZs7RYxZvYcB
         G0eA==
X-Forwarded-Encrypted: i=1; AJvYcCUccGGwenM/a01mEIYfsS40I0j7UrMUzROLQdPJiTOUJLQKcrXMgfJM3Gu56ZtGvGcf457egw2IZyrE2qSr@vger.kernel.org, AJvYcCVL1pmdTBIhc7ltsySDIL1U63LMSHTbei5MK9I7asGhc8os5ag0rbTJ3s8xOiKB8uQJ99GDNvjoyNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtYKE1QG7egIh/CQ9XfrnwzGQoJnKqHEQWPx6zZOWX9llxSJ6Q
	2SFKr/xENhmnUEbW9q9J2dgrdp49KUJCJYrW9LiE1/7kEuV3eCgijUfC
X-Gm-Gg: ASbGncvOBwp8GgB5Kz3+ZVsBp6PyhX0oqtfNHUOGkSPa2d1ydw1U1Xh/rBk7YGQo7ce
	6it1WJyO37en59H4UelYxzZ9Hp5MyZNwfFnVz7U2Tnp09xcwZe7N8ZFlOflDd1T+I58SwzlZCfl
	q/Sjmt1KHl0sLq3/YWQ2VApL9N4mLAMdgPzlV+i8pS+ZbX5wjxpV8wmWITrokg+JvzN5dLce1CJ
	7MwulgCvggAvtuGOGG7cCzLWViJya0bLi/IBgamnqym9DAV86+IWfWrJAgc0eklISkq4Luh+YfR
	ZbV9ACoxUQVrm+Mlxq7S51uhwrjFfcXYD1AGfDRxogFs/msYMDiyFtA4X954tcvaIciQIB/c2I8
	9EsKhLfnXkmvCog==
X-Google-Smtp-Source: AGHT+IGXZ+zIP8ZNJr/H+cZ1Qs2iCdegRPOdNZSrh6kn8eKFWXm3HwCaC47C8yN7gI8PgiVCpZTr0A==
X-Received: by 2002:a05:6000:40dc:b0:3b6:176c:2a13 with SMTP id ffacd0b85a97d-3b8f4197b7emr4751668f8f.15.1754527973628;
        Wed, 06 Aug 2025 17:52:53 -0700 (PDT)
Received: from pc ([196.235.182.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8fc28a830sm64876f8f.16.2025.08.06.17.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:52:53 -0700 (PDT)
Date: Thu, 7 Aug 2025 01:52:50 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] iio: pressure: bmp280: Use IS_ERR_OR_NULL() in
 bmp280_common_probe()
Message-ID: <aJP44mH0AXQGCFFR@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
Check its return value using `IS_ERR_OR_NULL()` and propagate the error if
necessary.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..2ac0188d2857 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3213,11 +3213,13 @@ int bmp280_common_probe(struct device *dev,
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+
+	if (IS_ERR_OR_NULL(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	dev_info(dev, "release reset\n");
+	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.43.0


