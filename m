Return-Path: <linux-iio+bounces-19154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BBAA9C73
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19F41899661
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34952701BD;
	Mon,  5 May 2025 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R1loUKwS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101F1C2335
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472945; cv=none; b=NaKZjs8bWeKdD1CjR/UteU41lKcdc6PVXVKM1kLv9JEaKuttKMbiaYCk5P9dZgrIXtvWskTDbcimMMA2HILuWc6kzWVm5zoJZl7hn/TVM887JeLnmWjcnGXKVECjh7t0nE5nrMF4qHf+Rd6ERVDHfWvFq4/KqRRKA7WMDlJ71Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472945; c=relaxed/simple;
	bh=b8jVCzrBHkCzVojeYYOfvuhVvRyjA4MpaGtmQH3nfjg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T/nXYlX3GhnTX4VkhYvUtqc5F2Guzmkp0QL9ZkCeuWOygI2yrm20sWxczGK0SMi4Dlw2/eZOCdqWgw4Y7ppTftpWLh0sPN1/lO9IJzIIk1SwuXwc0MtseCzppZT3/zoAgP6ezx8nS9y2Ob9ogchUo8gXJYxA1fQ9wd+wrFPCMn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R1loUKwS; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7302a769534so3118052a34.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472942; x=1747077742; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IC9I1ouZQXcrpOJepWtu/8yi6lKafLld926arzzYaWM=;
        b=R1loUKwS8ZF7b8i0YbCUUYz2G7+NTj0pR7ILjLmW9iEGDhtYt/Puqio6poLdYqzNkd
         rkj4mkYcfIk/5q332J6FVeIFgXH2F81E0g5Kn2xlXjAfqjDsOdIOTUt+mc+qH5x/tpJA
         QJmfDknLE7pu4Jfblkoyvn27BHxy9VHPzVZEXhF9JAeViv/RiGYSjNPhkhLkRTIM5PAF
         zj9XstC0AKZd7PthL7oxGX/+LeSL8gsZOfV2lmZPFWMhmhOwAF/A0QrUJ6lq3ySZ99BL
         rH5MYlXWJjWLgg4ETOTOdsoKMIOaYnVcrburqA7RA2I21uzONvR806Lhd+9iAIVttuE1
         9frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472942; x=1747077742;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IC9I1ouZQXcrpOJepWtu/8yi6lKafLld926arzzYaWM=;
        b=aY/uU4amfpuL6hAeqNmfCTrXJeGwoBVocpNl6Ros+3EhraBFcY99FZ23eWEzNvLEqT
         TO6mrNKHg0PyEbkMVhHhQjLDBFcyusqYYfYHOjodqOEIL+6fIXNmeW9eRbWKJJaTWnuE
         gkYUX3k/F/q4q6q/r8QPlfBcH28F0JgqVi5LUWkUiDLgne5SaRlHQhhy4ccSWgFGVE9t
         4tw7rsys+wKAyXjZTmU5rm4/PLKClIuSe/JQX5keGaP44jTzpT/GMDtEe3FPsT9GzLiW
         lWPJC8esVfr5FB1nv+BO2h8dvsHWkzTUp9lnyBTFrDMO2/cOexaRDIJSjcvBxu8npUDx
         pmxw==
X-Gm-Message-State: AOJu0Yx4wZZsfx5e3BfaNCg2TXns6bUt2jQn/cqzkq4zUBhOmGPAjssG
	i3ITgalMqMpqImcbiNh1QsoGPwyqEZuXrcj/BPUUkFK4UzwHWAWc2azOFzkUtUE=
X-Gm-Gg: ASbGncvCSa+5Pw1+dYFNADck+g1o3QnPXBosmKuuQmny3AiiSqtLm25x8MoFn/Bhy35
	acRviP9b8URoIZVZOEQ6tryDeXfzF+EGvsiaXJL0AJUUDppLJQI92t0v7AGHT+hWstSzo2Cj3Cg
	WEg3m71kRbZVhtsmfkvokhJd92fCmFrJK0hGO1th6rbitF3sU+wtfHf2StWxQksMp0T4pE8gFts
	Kr00S8mNLYZQfccu/c3dlnVqmW4+ML9HTgkKre76pS7CjK0pZfiU1KH9w3hks5FmQsk9nH6eStg
	G0fDeBLhE/oYHcWb0hqgIxYrA6zkpfvPvdAEM969F8CfyYv/lH1MCgEq
X-Google-Smtp-Source: AGHT+IEDACcIG4kMolmuo7eJItLJ080yCTif6KzqfNDd5tGS86L8dtRAmCZ67nxms6AE/Y34wftSUg==
X-Received: by 2002:a05:6830:6e9a:b0:72b:7a29:d680 with SMTP id 46e09a7af769-73206dc1988mr119032a34.10.1746472942527;
        Mon, 05 May 2025 12:22:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/14] iio: remove bits_per_word = 8 assignments
Date: Mon, 05 May 2025 14:20:27 -0500
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsPGWgC/x3MQQ5AMBBA0avIrE3SiiKuIiKqg1lQmQqSxt018
 ldv8yMEEqYAbRZB6OLAfk/QeQbTOu4LIbtkKFRhVAqZPQpt/iK0fIbhIBluLw4bdLZRlSmtnnQ
 NaXAIzfz8865/3w8RHjO4bAAAAA==
X-Change-ID: 20250505-iio-remove-bits_per_word-8-db80654b1c17
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=b8jVCzrBHkCzVojeYYOfvuhVvRyjA4MpaGtmQH3nfjg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ+FYeJc4gmHpAO6+kBoSZ+9tobYym9XF39X1
 tV8sK4WJVOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkPhQAKCRDCzCAB/wGP
 wEEBB/9f6KGByVzSppJ7Fe5DC9SAuEtOUKAJfFRVknBa/bWywXbE+K1MHCzQrB7Uo43vX5jupno
 MN8P58q3Iz66ZsgSjzdDNipQd0C39JtJvjdGyHaJhKUM/FeQL6ry5+wl1LU0cBHGoe/xRKW7xpA
 7eaE6KQJUWEtZOffOffaDdMnsiKZcayn0ztrMxzbTe3V7iTcQdBw5Fhutekv9+QirgmpOMAP/r2
 eZcmRTXTHFqHMxgH8W3W3GS2C/3qHOvIYFqihIDcuxsdCZKhgn/o32bxf2O1jik+BnC0B1xsefU
 oUyQvXNpN4TIIjD+z+CjEIhvhq3qLp6UPOIGCtUl7PQHFziZ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

While grepping the IIO subsystem for drivers that set bits_per_word to
unusual values to check for potential bugs, I found it to be a bit of a
nuisance that 2/3s of the matches were setting it to the default value
of 8. So here is a series removing the unnecessary assignments.

---
David Lechner (14):
      iio: adc: ad4030: remove bits_per_word = 8
      iio: adc: ti-tsc2046: remove bits_per_word = 8
      iio: chemical: bme680_spi: remove bits_per_word = 8
      iio: dac: ad5761: remove bits_per_word = 8
      iio: dac: ad5766: remove bits_per_word = 8
      iio: dac: ad5791: remove bits_per_word = 8
      iio: dac: ltc2688: remove bits_per_word = 8
      iio: gyro: adxrs450: remove bits_per_word = 8
      iio: imu: adis: remove bits_per_word = 8
      iio: magnetometer: hmc5843_spi: remove bits_per_word = 8
      iio: magnetometer: rm3100-spi: remove bits_per_word = 8
      iio: pressure: bmp280-spi: remove bits_per_word = 8
      iio: pressure: ms5611_spi: remove bits_per_word = 8
      iio: pressure: zpa2326_spi: remove bits_per_word = 8

 drivers/iio/adc/ad4030.c               | 4 ----
 drivers/iio/adc/ti-tsc2046.c           | 1 -
 drivers/iio/chemical/bme680_spi.c      | 8 --------
 drivers/iio/dac/ad5761.c               | 2 --
 drivers/iio/dac/ad5766.c               | 2 --
 drivers/iio/dac/ad5791.c               | 2 --
 drivers/iio/dac/ltc2688.c              | 2 --
 drivers/iio/gyro/adxrs450.c            | 5 -----
 drivers/iio/imu/adis.c                 | 9 ---------
 drivers/iio/imu/adis_buffer.c          | 3 ---
 drivers/iio/magnetometer/hmc5843_spi.c | 1 -
 drivers/iio/magnetometer/rm3100-spi.c  | 1 -
 drivers/iio/pressure/bmp280-spi.c      | 8 --------
 drivers/iio/pressure/ms5611_spi.c      | 1 -
 drivers/iio/pressure/zpa2326_spi.c     | 1 -
 15 files changed, 50 deletions(-)
---
base-commit: 7e9a82ab5b861d3c33c99a22c1245a5b262ee502
change-id: 20250505-iio-remove-bits_per_word-8-db80654b1c17

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


