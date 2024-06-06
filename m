Return-Path: <linux-iio+bounces-5907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940548FEF7A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E911C23FD2
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AC71AB905;
	Thu,  6 Jun 2024 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="be57IxCM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F681AB536
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684026; cv=none; b=nFdIi4wCTI8AR7VvCidnEFN03fMs221UArceIUquB1+s48N9pTT+xXhXXq8sUFCmpbDQCtURcp7HwStbURyC0uE6UNeyObH+nsRyYkKoYgwV0kgoBDY5IMHIw4lPuJVQCOAXc7jPvDbryCJAoghiLUBTt0MQFZ/U3V2lm8fQaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684026; c=relaxed/simple;
	bh=YStrwMu9d0HF7v8g7UlEzFjEPSB04hbtpJeJ/x8+6Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nq/X/ulUURn9iAaiBP+9Rw7Xjj4qDItprss8j/PR0ejX4B9KrszR6LcvRLoPTlcu6NbCeAfG1vR/530+WNx74Ldf+t5eI3RJ/lkI+sEBVZL87yKLIVy4ecY8u56ufBtJV5CBUBnxo786XBGIc7gHiOUP5emL87hbIRQSIa9pbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=be57IxCM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so10993905e9.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684023; x=1718288823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/q5554CzENPlgyge011QeqaTXceaEzyntbYKINHAhg=;
        b=be57IxCMboKrqUOy5opXe7d6vt0ApjW8gU/fBV+0X4gQK76FUT/2fPTLX02HS0Jj9g
         uJJEQScCWRSkVxQ3EhBP+SSjMTA0QoGRvKGUtpKOloiQiqEvnuGTGXSRGaFeKV5zdF0l
         OFv1CcNu9QtXm8B/U8XwvtPkrzptpynWNTsWsC9vinHBinRNHA/wsEU0k4Ug0S1U+lcN
         1ETfg05fBc7B1+66QRgUdZ4XrtftsMl1JnAyigoSbsatgeXnJi5qC3mTyBfZ8hKfwfAD
         9B3dccIlksBQPqUMBTWQZH32OBuDReIiH1CCcv/h8zRmwBDEj+n9nalcEZuYnpKTTA3o
         t2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684023; x=1718288823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/q5554CzENPlgyge011QeqaTXceaEzyntbYKINHAhg=;
        b=iP2kMkRX9zXkng5xojqezImKzanQyxuBio//bZhbYhekUV238oBcqNRL+KQXYiv+qp
         MT7kDfF7qitXvRIoXBMGzJzTtWgz0zx2W9x9AKNNtvInBDoRpmmsEkow+p12wVPJgVMj
         wIzTIwrNxoob3yQwBCD5V1hXUZfdUEOZfFL8oI7PZvy/Z+TsGeILUWymLmiX33zukevF
         Sfhm2w1myKJ04NVGu6HBR46VhniQnF+m/ERAVBB5NMImkZsBPE/HwsYgjwGmQGst0Bjv
         0D+UOHWliJYwaju7lxOwCLoTl1R5ejojjX4p0q6D0J7tBhX0Y1YD4xhV+TwpAAz3aEt9
         opKw==
X-Gm-Message-State: AOJu0Ywzoh+yEy/YMkUEvBNStEjSOg6hpH5zgSKcIsViz+eDxqAWfvSC
	QhtTokVa/5QZzSXAYvS+UJ3hoUI02PVyFhUppMHDSsRj9uXZ+R5YGvNGq/Tfmqo=
X-Google-Smtp-Source: AGHT+IFDSWmGgqEQxCdbD5qa+u6jKx3d4NBDe1bhg5CQycR2vrRLxkrkirLGTvw8Xk40Nv4dJ0kHhw==
X-Received: by 2002:a05:600c:4f83:b0:41f:ed4c:b8b6 with SMTP id 5b1f17b1804b1-4215635859fmr42301955e9.38.1717684023003;
        Thu, 06 Jun 2024 07:27:03 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:27:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:46 +0200
Subject: [PATCH 4/8] iio: adc: ti-ads131e08: simplify with
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-4-320b291ee1fe@linaro.org>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
In-Reply-To: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
To: Lucas Stankus <lucas.p.stankus@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Ramona Bolboaca <ramona.bolboaca@analog.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YStrwMu9d0HF7v8g7UlEzFjEPSB04hbtpJeJ/x8+6Tg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYccrM2JPjmayiwY1qQnAIETB5ED1hb/J1fYj0
 UoY7hXocZ+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHKwAKCRDBN2bmhouD
 16mPD/4s2zen2qL8Xyl5g8T7SvW51gO4ywnLwFj9Pg2kwfy1Cms39SBppTSUHv4L6PZA+7/J6TN
 BAdPfk7NPYWU3LUZbmnV2dnlooTg1lFwUlidyOthd6o9TyukGldMo6h+uzDzQPGjCLTryhozwR6
 PFU5S8qzshkHrwEVmgHFt5pSDjvJzQZH6faicNtjfFm3Kcvb3bwxCDur+UD6CrCOvwa3RXU4kGo
 dQkBpJnk+PrbPHTdJigzvoE8bCCgAl3i7zyX3wdPWfgxfpupgHkOZl85yg5dZ4MzjJ+sw9grlvy
 7qHC8PsfR9tsdpbiZMDILl4z7glqjv3D2Mu66KaGlDHQmIVns3vILDyGUSOzw5wzkT0JpJU9kDT
 WM5DgJEV2b6O0mGdyNpY2vhHh8qPaKFf4ifNM5eG8PBr1ipoD7xTATDpfj43uCqO8hJ8H0p0+xz
 24sL6Tzsx0Wr6S0YpxOX6c+nQmolwCRcNOgWc2I20iw4D03AyhQffUguvOou8Buvzi6Yv645OPq
 p5RZoBQB6/5KRwxxsCLmAl67AmcdWfKQG23KIceWTU4FFwE+UpWFIILOk4oO/n7lKZHbWlPHOzX
 7jqfnDFcutXKxGwBHoBFdjmHUtukhoYPWKBlPB1FNejm/TobmOTflZr2KZqCTrEATNi8UB7JLRl
 JlwUyDyEIp4P9ug==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/ti-ads131e08.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index cb04a29b3dba..96dd9366f8ff 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -802,9 +802,7 @@ static int ads131e08_probe(struct spi_device *spi)
 	unsigned long adc_clk_ns;
 	int ret;
 
-	info = device_get_match_data(&spi->dev);
-	if (!info)
-		info = (void *)spi_get_device_id(spi)->driver_data;
+	info = spi_get_device_match_data(spi);
 	if (!info) {
 		dev_err(&spi->dev, "failed to get match data\n");
 		return -ENODEV;

-- 
2.43.0


