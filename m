Return-Path: <linux-iio+bounces-16301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64933A4CACD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 19:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F20D3A55FA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2122ACD3;
	Mon,  3 Mar 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGABGaEp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A82135B8;
	Mon,  3 Mar 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025132; cv=none; b=Skk8Ja93XeBC64EFAckgOzQX+h50QuLCEUc13T1PSVd3faEmrtGwoXAMUZAL3ApHqL0GydA1g+9e7fZlxL/Uezr0nr4NDnYE7ludmcqnhrixqImIu39BE5oQ1dP/SrjFRj0HcP4dpWX4FSnpOuVJgnJU3ynTYxixw2XDCFgdPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025132; c=relaxed/simple;
	bh=VAH4v5bJFlLZrKM681qO/g3XFqUam0Q1Ghkk8lgbyjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LxTJyb2ghM08nJ5/IJap/XwAyVhE3T5Hf4uUwV0222tVKZv9qRkUYb7mbITV341+sQEGrahh6H/o+acZs9zExYOXJ0mOrs3tFG8ehrsxTdeYBkVTEfRJjHlUb5XUyj+rRbLqHLEhpMUXdRplGUtnOBcngkwG6AmuhvBdTpZlSG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGABGaEp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2234bec7192so71783125ad.2;
        Mon, 03 Mar 2025 10:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741025130; x=1741629930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VkWdnxLuCrqr1vq5T7s75fh5Wv8+/qm0qNVED0OlTU=;
        b=EGABGaEp9UoqQBqsBfFch0GuyArrjpl2JdDwvb1E5SnAqy2uJO2NrgHcgKF3YwLwm0
         TwyHsDQ/YSHJUrHHmVMD6c/34/TGO94h6HvzbIKClPplvFcLaDR1p48kQYnNZltMfTis
         1RycVNVoqE+GVrdP4p+Tj0NeCYs+UCXUyxiNUl64L9u7K28jcLc1xyEGhBDMvcO1tW9F
         8VWbnlHRPpAUPvgRxNOWZbKM0Vv75STvQz2GqEhsfz7AsTW9/0Owu+PCXsMmllEe/6of
         glaJiuC6LcsFZdQfGz9rrMAhriRVP/iMHGcfgXsetztcX5CYWjphhQQ6VnZ0HEB/xFLl
         Wg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741025130; x=1741629930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VkWdnxLuCrqr1vq5T7s75fh5Wv8+/qm0qNVED0OlTU=;
        b=ww1jEwUqjH+kvALG8gx+Y6UmaSTHDE2HUULmlH3flg26zC9/B8DAWaEyaRlUu4Z9li
         0IKFxdSTtL7Wef5lkYqrSzGamcsqWQJpJQRTEIU31FTMLGKT8RijOjuCPz3V1dnPFB5Y
         PN30Ltx9YuhoZlpnrVscVOm0cL10eKwxt04+VrqKzgCtVbAajJ0/Q8u85WFRq4jUEGH6
         GIx02qIcbGZdQ+WTm9zX8a2Zr4TQJ+Jb4+wrQvzhACgCg2zJaPTNfq/e6Iwh8QcO8341
         NbswaCT8Zh3Khd4J25uW8eP7pUayyM2d1+DHZXRye0Mz3fxNg13D+3EuyCMlKdQqMeRO
         Nc0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/FTO0kDnrw9jYRXUxnkJ8HWDsqnQjyo+VeD9z4olvHsdG8SlpkqLx7ZSuIO1fzYi97VttuPSa5moAh81H@vger.kernel.org, AJvYcCX0q4WLHti8Ny1w/jEha+mgPm4EHBJAsipvkzJAUmyQCuvUr8cES4cC4upihchG+2HWyxF5Xk09wuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfI+0C3xTptTHqstrVQTjr+Z4teJULjjs3hpYs/49yskwcNBC7
	71wnEYPTBNQEP5yOmXKvAhqxCMWAlMEt7vxAPyV0apvadJmLIj2o
X-Gm-Gg: ASbGnctWd4N6JkkIvlWMmkRyUf4JJrI7BnC0XcwikAf1O9iibMUftCRCPT4yX6adYmU
	IJdqP2Vcw3LVVOPQqaAFWP3BOW0au5ScFe1/sYO7h0Vym5LSxToGFyxpIAIsJbGU9tgocm7jSEX
	fWtqYZ/YmUmIMA2o4EuiC0iDDMFoyuHn4o9m1+rUBr84gIEJ7PomzlegvNQ9i6EBJPeip3S/vIg
	ly0WHyYmX34JlO7tEzV7lp0HEsW6UfKs39r8Na3xFxxdsO8h4XOBc/fPmWsA4VzL5Z5sHDVU5Og
	z/2UitgmMPclohMk2RWvDPh/7x84vfja3PGJ2sQQuU3rafV4M6UsiiXGEgOXtkgY6PM9
X-Google-Smtp-Source: AGHT+IEW89lTZAYKBGO7spjOgM6BNdSZ6lApduXyII/5vwtNdJIM/6NiUw7JrWJ1rE0/V8JqintsxA==
X-Received: by 2002:a17:902:dac4:b0:223:6436:72bf with SMTP id d9443c01a7336-2236921ebeemr275963095ad.44.1741025129900;
        Mon, 03 Mar 2025 10:05:29 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d29cbsm81319975ad.50.2025.03.03.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:05:29 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] staging: iio: adis16203: Remove unneeded spi_set_drvdata()
Date: Mon,  3 Mar 2025 23:35:23 +0530
Message-Id: <20250303180523.15445-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Since we are making use of devm_iio_device_register(), we no longer
  need this nor do we have any spi_get_drvdata() in the driver.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c1c73308800c..3faf3c61046a 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -267,8 +267,6 @@ static int adis16203_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->channels = adis16203_channels;
-- 
2.34.1


