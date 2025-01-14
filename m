Return-Path: <linux-iio+bounces-14366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F64AA10DD3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAD9188546B
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6E1B78E7;
	Tue, 14 Jan 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bx+scrku"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0B3C3C
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875921; cv=none; b=YkoxxeUyjzjQs1koeW7ZvXMjaqbaxXkn1B0nvdIkhWX/EhGNa2jG28ZTMTe/InKCkTfY4yEiYcB0P//F6r8YXjbLlNQq3mbkbpC4wHVHG9tGjdGcdNO/sXxqd8zCHKyrfbzI2Sjc2xfy5OWoLFJT+GK+nrRL0r+dK3c6UJNUNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875921; c=relaxed/simple;
	bh=Y2PXh50uoLzaPsUadh35f8jl7VJOvny/p+6IkYlNhXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T9+h2rSh3l1aUEBM6jVdUaRNVjk/adwVmXBa1gRsHcb5KCUiCvhgJXD4Zm6PyojveFMzvwFJLWNwyAwZNyTSEM+avfEoVfmr+49mPjWIqWjbrevw6bKI9KJJKMLnpgwOx+HM+saA0hsa7nZdxHQ4ufjsVENyzsNTAVwyO5F1m+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bx+scrku; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6ea711805so723078285a.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736875918; x=1737480718; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awRRB0AzaMITBgH8YpsZraFGiUDm+QrRoaxWwHUHmhQ=;
        b=Bx+scrkuQjGXl2rw3D68rqA3QkznVT937ugiBqgrDfFTKsdhccHR/YPwArafOf/i0X
         snSqpMl1StapX+97baEI04H3yYbWgcxldwLPu59qVhHj+7RliM9WeK7+givPDIFOmT+8
         eg0rbXzKzTAF5I30U5wS28HSm2nrTsJQxtmqW3iIEsAZ0OOsH5JX7yhnrLyhT7Nn253s
         it7rtbKTK77fRtsvhwxLlUTqUaW83mbDUWMpl0HoWBnDtFw3Q4Un2vaFy7ioZZC6X0FV
         GxIGaDAZsgbLIBKLrj2I/hvP4XJmnU0d1T4nvgpVGOVG+4YO6kGbRDWcwueHQgCgfmF4
         3Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736875918; x=1737480718;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awRRB0AzaMITBgH8YpsZraFGiUDm+QrRoaxWwHUHmhQ=;
        b=akvxa9aAfCCaTG43s0hIh0n37VehnFsK3si7k5/E79JpJyxuGf3kqA7yj+oaS2WGiD
         M5gRVABaFvjf/6YLyq1nwZxlLvFD1kOYOU5vUEoXfwy/wEDFEtrPnT5H07pcNxqfiLsr
         l0/OvCOTegO9IAaPeIg8RYkROmyIrEdU5RA0jU6J7IbLRbOaJhj2476ikqtJiHBI5orB
         9F5y0f2WRdlaAKqat/OFBEahDInleXjPD1LzSGLj7LHijHX8BvzLCslfRRdutOzcsMq6
         cQkpQtrjC6H8TW5Z5D8c68kdnndkhFiYrbGAZucbQyUJd49VtiyGRNuYBGF8Vlrd2bNz
         SCbg==
X-Gm-Message-State: AOJu0YzWTzDvi6VxBhLLlkMZy5yKhim9NvOAH2MEr9hiQRhKOQrq4v0i
	8uyivcd5sv6s+PPDo0sUcEnubeyvqEk28jR7I3YCunNaKO6BJ7A/k/Ztf0jSqUQ=
X-Gm-Gg: ASbGncsVXeNwodmC7SqPN68y8C+288Y3/nO6EJyION2eCvf0LYJ/HrxSxVh3Kvc38zy
	Wx6JY68JVDAUIPOROcmenSlx329B7E4R7YnLSJhe9bKtbCV87V4OaEV7YbKSq7QCvvMkCHZ1WYH
	80vLAjhdd5qPWMEryDHSriqYcZF1zUf+k7wSavrKzhn+8J40Z/eWYJdG+d1j3Ihr7gCZ7lJTvcX
	G/VnUx2uhDqWcaXjDLO1LMWqpWjV/wG1vDdugTSVnStemN9a1f4Pa3X28uiQdGn/WUoCKAzp4j3
	ZrIxrKBbQuRrQAd4
X-Google-Smtp-Source: AGHT+IH7WG++yEZwUNgOhxsO/NsbmNcfiwzvGSMQ7nve9RVh9ZKSJmkA+eaPsQ2ys62MGb90adpv8g==
X-Received: by 2002:a05:620a:24c9:b0:7b6:753b:9b5d with SMTP id af79cd13be357-7bcd9783de1mr4712577385a.36.1736875917786;
        Tue, 14 Jan 2025 09:31:57 -0800 (PST)
Received: from localhost (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516193sm622645085a.117.2025.01.14.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:31:57 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Tue, 14 Jan 2025 12:31:55 -0500
Subject: [PATCH] iio: adc: ad7625: drop BSD license tag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-ad7625_license-v1-1-6555b7be05ab@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAIqfhmcC/x3MQQqAIBBA0avErBPStKirRMSoUw2EhUIE4d2Tl
 m/x/wuJIlOCsXoh0s2Jz1Ag6wrcjmEjwb4YVKNMI6UW6PtOmeVgRyGRsM4iYmtXrQco0RVp5ec
 fTnPOH9eSIR9gAAAA
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

The ad7625 driver was submitted under a dual BSD/GPL license, but this
isn't a requirement for the code, and adds extra complexity. To make it
consistent with similar drivers, drop the BSD tag and leave it as
GPL-2.0-only.

Suggested-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad7625.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index aefe3bf75c91..8b020f22c5a8 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only)
 /*
  * Analog Devices Inc. AD7625 ADC driver
  *
@@ -680,5 +680,5 @@ module_platform_driver(ad7625_driver);
 
 MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
-MODULE_LICENSE("Dual BSD/GPL");
+MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_BACKEND");

---
base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
change-id: 20250114-ad7625_license-bcbaaa3bf449

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


