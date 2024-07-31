Return-Path: <linux-iio+bounces-8094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B9942EB4
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B0E28CEEA
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34071AE87A;
	Wed, 31 Jul 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOfXo+6X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A614193072;
	Wed, 31 Jul 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429450; cv=none; b=nsHLmv5Ems+RXylwmSXehlbYA56OFiIuK59BWu5sxp5vL8t7V4b025Ke6vbgxUtx68HRlaklvSIypn6zOUgKEKV3uUNNMJLVmGYAzlcqg1j9mlg+t9eNLlQv58MN1MXsQ/q9h2Q8vybpC3v1savC5ALLJ6Y8OVtixqsTipSdYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429450; c=relaxed/simple;
	bh=dzSe2MfEfC34c+4Ae65St3/EyAcbDWKOFlWG9ZEcJrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HWum5RRtimb2N8+6cbkX4Gq4uXR4Qp7CBFmsfkAp8PqrhLR1acjj9SzBZ5F6r9rYinjULw+7vt/Du+HfAR0MLv3gcj6yS2BxczoaQhYCUPOa7W51Bnn9y4FRUPhZnY4TX2K/85NT5CP0m9CYGxAhHD2rZAnqSSX+Gd0q/FAF+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOfXo+6X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281abc65daso29849835e9.2;
        Wed, 31 Jul 2024 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722429447; x=1723034247; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln4DNV38+EobFIMTju0Yg2SSs+l0VxUp6Zi2Xe/dcqw=;
        b=hOfXo+6XUwXWVKqZ5SZ7K0FynGWaQtrfGwb1YCqG5MsBYZtZ3lrmhUH2HhUatBvYLr
         cDBp0QRmvBKxcFkNfl9ZgLTKj/oqGK8KuaEY+Y9TkjCA+L4vDLdND/Ms96ynN3rN5qJd
         F76/dSezb2OB/Jw6I7fPvNGMhQmMk18WDWcWc1J+Qt6noxQcfJZcPibMmlc13euVJGZS
         kjj1m5GfBbGUdoon3NL9vYNyAqDkX9ZLTRL/8xal4xLHobnOxAhVy1oMiqfWjlXa8I/4
         TKWwTdoPBMM+asOlKPRLAD1pGNyRPDRtlkcmNoA0Z0iWRgf5sKG/5PhGGNhZys6nT1rj
         tP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429447; x=1723034247;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln4DNV38+EobFIMTju0Yg2SSs+l0VxUp6Zi2Xe/dcqw=;
        b=NujTI655HfxieAkgXEh35wvEPfa+tcPKahNW03i8TRbOTZaUDfusg/hLkKqjRPKmGH
         PpeeamtblJl6U3HcVTYjD3UB56g4fVcQb6QOh1eChwFNxEXteH7zo+2WZpWtv3H5iiML
         pIwsdM2zWClcE8bbotJturA55pzNy40aVxsKWBF30WMopajCyDiArWoIAUfMXdPRi8K5
         FHFPLZ6ktm9m60faAhEr2qFmBp4CwW7+bj1fNGJ9RjVdCeMIlrgY4oz7HydcFK9y0TdN
         aMRYuQenYBZ7nP9ruS66qYQI9m647Z0rZD3PHNCCxYZi3Z3xIzqHJsg1eFzX/T/V8stU
         qxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC6+yj5hKlTFCXeylDNiayI3woItNIHtk1PPCp7rhKaJXx0S1EFyX6yoKjsPMCy2RFdVP2T+vmIDdlKrP9Ieu6Wu32kozlTnRrZKgionXJvCGJZl2WbKHoUr8U/rRlw4Ehg+oYpVG9
X-Gm-Message-State: AOJu0Yz0dqxxiIIOUrJAnK6JH0kQo+Q1UlFC8rlbY14h5V5dN9VFHVJY
	qG3rtoY34WbokI58YZqpX0dqoMe+hmgAynkxNywIyXIOsMQjpIq8
X-Google-Smtp-Source: AGHT+IHVjYD52SvrfU3XRkigv/pabgZlH5vxxV8RcEdEyZOxMYHxQy04RFrhSOG0fkd92olRajbB4w==
X-Received: by 2002:a05:600c:a03:b0:427:9db3:46ad with SMTP id 5b1f17b1804b1-42811dd1a29mr87444335e9.23.1722429446942;
        Wed, 31 Jul 2024 05:37:26 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64755sm20600465e9.36.2024.07.31.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:37:26 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: [PATCH 0/4] ad7124 fixes and improvements
Date: Wed, 31 Jul 2024 15:37:21 +0300
Message-Id: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEwqmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc2ND3cQUc0MjE920zApdY/PE1GTztFSDJLMkJaCGgqJUoDDYsOjY2lo
 AUKAxxFwAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Stefan Popa <stefan.popa@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722429445; l=1307;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=dzSe2MfEfC34c+4Ae65St3/EyAcbDWKOFlWG9ZEcJrY=;
 b=tAwACJv4nJa3PC2cBpixYO1Nh5oSp59pzwRsyg9VupLJof5NjU9v25gjAxWJvVIV7cHUH47s6
 7uDmxr7g00FAbaWYCPhUQ7h25HG9EXOA9LAKznCk8iK2dvYqyCoX/AT
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

This patch series adds fixes and improvements in the ad7124 driver.

Fixes:
- properly compare config values
- add a delay after reset to allow chip initialization

Improvements:
- reduce the number of SPI transfers
- ensure that after probe the ADC is in idle mode
  and not continuos conversion mode

Another thing that could be considered is improving the config pop
behavior as kfifo_get() will return the least recently added config
instead of the least recently *used* one.

This could be an issue when multiple channels are using the same "old"
config and the LRU considers that one as the least recently used.

If this is considered a valid issue, I can add another patch for it.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
Dumitru Ceclan (4):
      iio: adc: ad7124: fix chip ID mismatch
      iio: adc: ad7124: fix config comparison
      iio: adc: ad7124: reduce the number of SPI transfers
      iio: adc: ad7124: set initial ADC mode to idle

 drivers/iio/adc/ad7124.c | 61 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)
---
base-commit: 380afccc2a55e8015adae4266e8beff96ab620be
change-id: 20240731-ad7124-fix-37aec7fe0b6b

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>


