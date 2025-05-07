Return-Path: <linux-iio+bounces-19237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6CAADFF2
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24044A4EEF
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19712820BD;
	Wed,  7 May 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/P9/eWq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56925E818
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622747; cv=none; b=becp86mnF9YeYPoT60DY8al1iWt22MYjEJ+81puejHj9tuht3jZbtiq0O7X/QcBes2bBimOavP6pTXU8MbHwBCcyMKx8a1o1QMLqHddxdFgTvpwtFR+pPvlxD4d/JD98FriuO8iNwv/VQKWnFE8jM+kqIjeL3uBFAJVoUh8roA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622747; c=relaxed/simple;
	bh=MVqxawyNb96iRVnkoxL8y3RC6hJHYCWJTgkVT9g5/ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gOWAWaxS27g+BCAiZ3/FhHwxeSMOk2WCfreLrxqam3R59bgwm2Xg+U5CNvTrBCZZGMAl4uwddFrno7Harmulcpc8dLNMIma8nxtvPjkDrl0TOZ1/F9ci/5yG6dRETERtuHb3EGcn496vvZnkg3vKgmF/qRtbXBIeGuZPSa/SvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F/P9/eWq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so8012025f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746622744; x=1747227544; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RRD/vFTkmGzJVJl187rnmFHQjXKt5IA4r05/FngQfU=;
        b=F/P9/eWqDprlJgJbYRtNzW5nJFIzW1YVr47IENsJpa+JTqm+VmOvfEZu0q65nbrVZF
         IaeRhfljXIUCH5ytd6qkK1ng8BkFIiFF/YmX8Y7nVsn2dPfyIKDi7/kWl/sFxEDUgeja
         OrmwPkdvug+MPNo58Gd9oAY4ew+rPDbB1z7kamk+Jw8SOEzr9tv//6hYNOG/lKrvDJ02
         qzxfUMP8e4pd+MaNHhlNr03gtAm6o42bPx/fA9dKtmknbQd3I1aTmRDkNQI6fBgTqiUS
         MNYz44dVOOVKF/TIICUMOR2dEFRZCxl8huWBnNSZuwPB1uFyUmAzrMYUIYehLLfDMt2+
         bILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622744; x=1747227544;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RRD/vFTkmGzJVJl187rnmFHQjXKt5IA4r05/FngQfU=;
        b=MWdJ1wZcXNL69rnSZ3WmoyEjRC/ys2fA+fMIq7B+7sbQGOmkAk8ETpW6omoCuWd41k
         7OgbLK94d0hPyJ4tGpMR0XK3OW5QYV1PYuJwz9++cSKOJLL3UNYe4SeCL2iEoJi5K5pe
         bIzOeQf+oDjVms0/oiW509eX1ekArv4AWJHSdLqRBZ0UQtWFcJ3TVDCzMovt4OUwiLKb
         Pg2+WNgzJfVqum1brtmyX7XkFCX5Ve7rOV+mRdrGdiYJ3bZe9AnYqGMV6mNqTxHx3xwh
         yABIoJ4nTgB5xX5Szja864yB0dgMmPyXdFZ2aKOJk+qsEUg2UOBu7lmo0aTeSd/T+u1M
         pdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBdE6BtQM42fzPAU35I5PCXBTtDrs3B1LOL2J7Odev3REQIHNyzgntzjegypZODF45qF8EYJLfTss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicijXU1zgFk09zjdSr2VJK6yKLN0xJPbzwPvfdg+1grrEqi9h
	IH1Xm7vwBnM+mNAmdu5hyFb0lyexJ1nY5N+QZcicYvjknAOeYQ+RKRnCGewgyHI=
X-Gm-Gg: ASbGncsMWrTOFSbGAk26qXsqph/Z3SC/bK24HDDWhmjnLPrdWCvj8vx0b2mutvQmMSy
	b/pdT4TbDRQ1W/pSg1vWEChfzfVN7jpe57peegOnEJRTcUYiYmTLqXbfrAtFcLW/8RTj4bEnwv8
	YwCS+fPZImaEptpMEtIErTUlUtKaxZ2EfIcWKkAIuzCWG1LqniYUKvqf5T8jroCq5km7cD8rb5D
	VPN/IocxQBUruuC1NVF+TY81TjwNIE9IP5PE1jNRu7ZnQCAwZ4UfkmEaGiNv4io02elEa7bOB4G
	YKxApxGJqiuPJJ9vHuye7rP0i36rI7Pb8cpIvxGNeUhp8w==
X-Google-Smtp-Source: AGHT+IGsSMuTAgYqI4wtcBoKdXPHDvWaWYH8enx/xlGJpO0gLwyPuArBF8AKXQOe6SYKQMsl8Q0xsA==
X-Received: by 2002:a5d:5988:0:b0:39c:13f5:dba0 with SMTP id ffacd0b85a97d-3a0b49a7f45mr2596695f8f.13.1746622744205;
        Wed, 07 May 2025 05:59:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a0b501a197sm2545233f8f.76.2025.05.07.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:59:03 -0700 (PDT)
Date: Wed, 7 May 2025 15:59:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] iio: chemical: mhz19b: Fix error code in probe()
Message-ID: <aBtZFLFlr0slcYSi@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM if devm_iio_device_alloc() fails.  Don't return success.

Fixes: b43278d66e99 ("iio: chemical: Add support for Winsen MHZ19B CO2 sensor")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/chemical/mhz19b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index c0052ba3ac6c..3c64154918b1 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -276,7 +276,7 @@ static int mhz19b_probe(struct serdev_device *serdev)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
-		return ret;
+		return -ENOMEM;
 	serdev_device_set_drvdata(serdev, indio_dev);
 
 	st = iio_priv(indio_dev);
-- 
2.47.2


