Return-Path: <linux-iio+bounces-18800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C93EA9FF41
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 03:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A314F1A87F21
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10420C470;
	Tue, 29 Apr 2025 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fth0/9QN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616020C015
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745891757; cv=none; b=QSLAxD0p5FnEVZSoaYdG6wS8N2XYplibEkrDxjHhMnYUnVsEyd3dtgPCrGx9b3Y7rCQ1cn5bIa5hFPVvPmk/TujgAb2TfxidASJ3sCcHES4/oFsxmTUstwjD1GkTkavi8BY1vGp7u7y+YPcgxLaDhTF/2BGv2yicYOLjfPUqUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745891757; c=relaxed/simple;
	bh=mT2HO0OOEj3A8IYsb8tFiNpG4Sqs84xk79LBTwoP8aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZOjzDmTZMGZHGSUzP7OQwmrlYwRVjKhXG+AfqlOTwB810QP8HSqP3Ijyk+5DV5cqJyRr/gGpV3AHfJk/+A44GdEIuKcc3mMZkpXi3reEy9LKLxtj3bPwkahkgzAqN7VNC4y2bTb6h2LLSEU++QcUF13ne9dbXWBGf1Zgu3wNQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fth0/9QN; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c7e5f7f0e3so1360342fac.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745891754; x=1746496554; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSiEFoWAXctjsz9CWQEbSI2+ZdktKKEBscejuwswLxk=;
        b=fth0/9QNnMqZsWisekOwokupOwFxbFi9zhMcJRsgj3dlcr7TyVolw9R57AeoWhl4HL
         slTOAoEn1pL+HeMuQl2IBk+yCGFPYGJYPDP/lRtWaKF4i9coWKR5+G+3Q8zcKwmP5buC
         wFGYQ4tn4E6OK4XB/XF/QEa2FnIfdLMszGOaLPwsWLQfKFs+CWkGgaS1pBF704DVg0l3
         YlMyjUMRTkN1ILRSZOgJIPnX3E0Zp498V8840UjFzXGREi+AbUVh8FqypVpyooMiwGBU
         yiO5S1vMN7owHGJRUPYJ93/9jqcClVb7zTsdOmkwG0TaHPFxK0+qd5o4l6H9VRIUaI0g
         qtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745891754; x=1746496554;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSiEFoWAXctjsz9CWQEbSI2+ZdktKKEBscejuwswLxk=;
        b=kxDn3IRZjkAycRjL8h5Do9lL3M1/Djq3yJAsEmffbL2SRXaZcyFNwwEUCrpAJAANoS
         TpPZ0g7EKhkTLq8GAh8NIhNjxosaghWVdD6TFitp2qMWJ82mIj7hKFlTyEJF73hqqVp9
         GyjlCvQd4MNVFtVHbvQdp6H+BYcnt+2ZIcUJe79/ewuqicV/AOXKJzxDktUx40fz2tyj
         izRx+rlrLNJJlmirJrSZ3Fz0ZN5v9yD+tFKtscQ9uwb3GCBq/okKPnM3q7vPwK2VhslG
         2V6OWINfpygDSCzfVVJzv0HZsX4hDRVYc0oq71Q5pwxIxBc3qsJLFe/7vcSnp5qOWnDq
         1WEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqceISgmjH0/jea2hSUVwxgGdBOinxWuuHmtuXFLmhNECBOb7WZAYuBn4kQ5Y1l43lVNPidxPYtmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOqg5GWaIvD0I1QmRx7se36I7vrPMZJ3fRhxA87+lbny/xrds
	SlJAilrTsbQXzl4dG/9DMG/LyC2bh/Oj635aBS7tjIkRPpGQFsHj3KdAzlXiXEspoZU1Qc1UFdj
	p
X-Gm-Gg: ASbGncsOyBf+PCtv1a+aY1zAcXRIafu7Vr3d42bVJsxdLvoe+3ze0l4d0/7ZKmTEVMc
	9aE2CIX305zYhA70bvxJywt7OghycosPTIspZ85ex6ZHTNE93Mb3eTCWamhuWSqScQgzC/C//Ah
	BVZsLHVKys1pkIW1QKpBVXWEMWeUlUqg3YWBWDWhYNZWKCQ4XjwOEF4tm9uukSDibIoKuTLGrza
	bYMjxPCMGPeO8q/8fH72XyA2UV+MoMMyrXfBJDcom4CP7KFO3y36Vlr2FNKvzWFcPgJvd9qJ4Kd
	Zk1OwHnotaaO2+infyrdbqNmd6HYdaSzcQalrUGV7sNcvsK5rN8ICy0h3w==
X-Google-Smtp-Source: AGHT+IFv5VEbevaLhyAwe+YkilWgw/qAmMqzG8wF2aYvolG95zZl1RWwBE8uv/yrQXv7pG9Q4SuN5A==
X-Received: by 2002:a05:6870:3295:b0:29e:766d:e969 with SMTP id 586e51a60fabf-2d9be53e725mr5815680fac.10.1745891753975;
        Mon, 28 Apr 2025 18:55:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d973644508sm2582574fac.4.2025.04.28.18.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 18:55:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 20:55:34 -0500
Subject: [PATCH] iio: adc: ad7606_spi: fix reg write value mask
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-iio-adc-ad7606_spi-fix-write-value-mask-v1-1-a2d5e85a809f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJUxEGgC/x2NQQrCQAxFr1KyNjCGOiNeRURCJmpQ2zLRKpTe3
 eDiLR48/l/AtZk6HLoFms7mNg4h200HcuPhqmg1HCjRLvW0R7MRuUpQcspnnwwv9sVPs5fizI+
 34pP9joWlinCfiQrE2tQ0uv/T8bSuP2R74KN5AAAA
X-Change-ID: 20250428-iio-adc-ad7606_spi-fix-write-value-mask-7acdcca46227
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=mT2HO0OOEj3A8IYsb8tFiNpG4Sqs84xk79LBTwoP8aM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoEDGg+0d8QYZ3LlxKQqEiGM3V3iU3sx9hqsQ3d
 pgXIw/SzFSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBAxoAAKCRDCzCAB/wGP
 wPo5CACDMNOL3sJupmUOtQJALaeHaVADg2IHkXkpxWPeW5xKYOlHtf1TSv9ImGtwyTl7Q3Kg94q
 bU1egL1KqTdUbOsdWxNOZqjXGJ/DldiWseTNbaViK7zR761aNCBSxaF9vuQsAJX0Hc+NIgwjzVc
 +jsVI3A2XFFK6TNx9MjHIuL+HbDmEKbu/E9oXSyqm68mfI/QKtIpuasd72o1AvDSESx+6GbVZzJ
 Oi7rfOMJ8i+vsZTeTS0nYPxl1IztyJ9AbRH6tIB9x6jPFA3fkfXLF66ECUmXVH/G2pgSQNg32It
 122uJiu34YzBhe8z7OOkpxGR0rAAUFg4hpjs5o7oulKZIliC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix incorrect value mask for register write. Register values are 8-bit,
not 9. If this function was called with a value > 0xFF and an even addr,
it would cause writing to the next register.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index bd05357a542cf7234d5bb6b718829d6b720262cd..6c1228c7b1b11058cb5186513f032f7c8c8aa8f4 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -127,7 +127,7 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	struct spi_device *spi = to_spi_device(st->dev);
 
 	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
-				  (val & 0x1FF));
+				  (val & 0xFF));
 
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }

---
base-commit: aa1bd0b0ad048855d9efbee4ee8b9a6eee536256
change-id: 20250428-iio-adc-ad7606_spi-fix-write-value-mask-7acdcca46227

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


