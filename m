Return-Path: <linux-iio+bounces-25342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCCBFB851
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 13:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4385D466E16
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB1320CBC;
	Wed, 22 Oct 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0UpFBcm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DB287246
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130947; cv=none; b=HpWkXXjGphZPovHP5WYINuJmPrEFVajnD5x9j2i991jpt3AcwWf0e6ZXsnlUXQmETK3kNyubD4w3n6HaXK/oW/qNbRZdSevLg/cRuzy8iDpg62vpYuZcof3SM2QkzELs78Hf3x5PsCTHizY2OOPLc3uIBl9PrI6MEfXkhY4uQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130947; c=relaxed/simple;
	bh=U6QL/+JJidHtZRcPOVlNbuzyRSsR+FDJqN50LjHQQA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ECGU1YpN8t4v1fQtjkZJu0iYznZ4LhAoXFSR4BeJOpq4Xn6dDv5ATdU1yPhvP3c/q1S3kUQakr9qKbk7S1mApDFIW1tG5a+/FDWepbmK+lvx+bjJKGBy2d91TjTqRPAWjVkV/bxcJljpOVdEr1cUB9almDgLbEfQKZJ/Lly/HhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0UpFBcm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711b95226dso55992805e9.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761130944; x=1761735744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vr6iKNjWerf9nOZB9LbbHl2ovGZqdFL4pZFz4dDFkR4=;
        b=I0UpFBcm6UnH98+cDRl7QpFxdB76mz4rMfoUgTjFVvtPgoXeLYMGzWKw+3VYhZChR0
         DPDvBaaz4LSe0KqX5pfQnfFU+dqxi73jjsU2FwjjPcR3RIrXkxv+El5j2aZgytjK16ti
         rliI4lzjmPy40U2nMid12v47jozRuIspYA8K7iiGMALMKk9mV+Clnf5lcpqLmh67+zF2
         tmQMYcPMsGvw2nfmqwTQULA1tk6/VIG9L8XJ1MjFUHCtab3J4K1KowdQuCXegjmxG8R2
         OtWp1mdFaUAQFRNwXSBONuLhWmWxBRRy7IzIoYUpy1tIFDqsTLwAcnpoyHpLNrW88W4N
         k6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130944; x=1761735744;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr6iKNjWerf9nOZB9LbbHl2ovGZqdFL4pZFz4dDFkR4=;
        b=rkcrOWuFcQG5qVdUuSrWEoWDImkmqy0ggdOV+jCGQttJqg18CtyXIV9j3R7YxoOWu9
         EZx0AO/fg2J1TFA9hvKNGYRHl3yRg+13K/TKK7Of6VG2JnV+kVvEgKoXIuB7fClfxZAq
         Q6rwk/fuEK6VvcpkU/1IaWp+Ca0JH2NyQnZO6s5Bz0+Z+XQBreAkevG8rAQ0RcILeMun
         MX5k7F9qaxVDK5U885PTwSJhwHfzYIdnjtLl1Qr13/dI1dZQql+kRBczX7l3B/CPm/Om
         GfavQ3Y8cLc9qbablmE6BXtt8JI1WY/JKe1w/Z0pEutBUXu2glBYEtapgncIIxRglWwx
         ny4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIuvAirWdjFXBy1kmwJ7+g34ZgHbARPSl3e7hsywrPurlqKokon1GKI0WMsvnGdVNNFasc4dtxjfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhNTIbFfZcekm2/opL8JRGA20SJqCwumM91yfhEn/Nx96ICcV
	7TrAG1bGlH0cm1z44BsqN2f0r1NRfP5Bmnxdpqomx+zwfzH+xionf8q8KOx2cRlEtbs=
X-Gm-Gg: ASbGncvN18mlNeWCDFMmEfkVo5b3yAX+12aD3LMxz0Aa8sPhUdWlWtm75zQPICwKQlD
	x7Xq8WkzmGsrJCXtj3rc+sRpy+S5WLHTOcvhu0aZ2Un70u1tgAbvSZcFQSl93aDCqz7q+atQ+YO
	TtsH/PBAREXYwR0knGip8B1EATxi/LewkByT9wdtkzVFwoDTMpanunK5bG4XInMAUBVW3bg9Mv8
	QcWpQkBP6KOp4PbRUac48Sp5qcG9uvTn+WHHgF39tMyqcXqHnpIodB9iKQQ0XQAuqNMHBgCdZMz
	PjryQEZXWi8aXliKQgHsUsTa3MlPNqJ5KJ35J/YUIJ0ZL71niZyy6nT+1F0RcGysOWdtohKrJ0b
	SRWqtZv+SOPphRDxI3MdvcA4lBeuwdG6nbZK3ga52uZxXRiDEHPSbpOSz6pT2yIj/SV0TG8mM84
	5Rj9kT1g==
X-Google-Smtp-Source: AGHT+IH25nwlFz4tq4G1fC0j/+8ilfgBKiuMxxceSNPKsvkrvfcWUC6/1PbTIDPovElQDzNqkYF4Ag==
X-Received: by 2002:a05:600c:540c:b0:471:12be:743 with SMTP id 5b1f17b1804b1-471178a3f93mr153198455e9.15.1761130943947;
        Wed, 22 Oct 2025 04:02:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c427c3casm38651185e9.4.2025.10.22.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:02:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:02:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] iio: imu: inv_icm45600: Add a missing return statement
 in probe()
Message-ID: <aPi5vEp75jH0imQc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The intention here was clearly to return -ENODEV but the return statement
was missing.  It would result in an off by one read in i3c_chip_info[] on
the next line.  Add the return statement.

Fixes: 1bef24e9007e ("iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
index b5df06b97d44..9247eae9b3e2 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
@@ -57,7 +57,8 @@ static int inv_icm45600_i3c_probe(struct i3c_device *i3cdev)
 	}
 
 	if (chip == nb_chip)
-		dev_err_probe(&i3cdev->dev, -ENODEV, "Failed to match part id %d\n", whoami);
+		return dev_err_probe(&i3cdev->dev, -ENODEV,
+				     "Failed to match part id %d\n", whoami);
 
 	return inv_icm45600_core_probe(regmap, i3c_chip_info[chip], false, NULL);
 }
-- 
2.51.0


