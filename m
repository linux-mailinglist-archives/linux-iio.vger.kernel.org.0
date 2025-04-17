Return-Path: <linux-iio+bounces-18234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34753A92CD0
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7061B6435C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 21:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC6208970;
	Thu, 17 Apr 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e/P01wFr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2041DB958
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926267; cv=none; b=X5u9Y8hzoWO1ZCAGCrxBpS0Pt4k1YzomyPctX3PipcpXizIz7TJ1tdosyEW78jumSRUYqj1Ec/PnVKRJdRvvxNXyPWWpTsURRZAJLWRceMnMagdM1CNHrUxz+qRUqkhL8xqqr490I2SU70JxGshLzpB9+JEGrVgaTn5u1RHROoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926267; c=relaxed/simple;
	bh=Z8H0UeKV6n4GNYqtcRBzd5m/l0uFXnW7YgjPaymZP0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SaFpwIXb0Axf6WVT0ZFpbuB2Rhs89o41oiEegORKrfBpmmi/6RGFpuky6xC71kVQ20rmtLZKmsWQ07C1gTrT7a+2ImoJ9CETFUF4eh/OXWWf00BwVfRyo2pHhaG+2Pb3cX+QyN2HEhQ75Z+M07cYEuaNVLynY3JKgGyiebmKOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e/P01wFr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c266c1389so940349f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744926264; x=1745531064; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBFmVEPSVrHwnGq833HFyEFbm1Am5W1x46GKoIrb/uQ=;
        b=e/P01wFrfoBO+x0OXHV3KMVKiizt5wD70nDAS6nNgTtJ8a1Kj61ppm2vc3EmiqXIGE
         /yuYutL/+stn0/dMQLT5ZuPIcavE0C9jbg2hFY/juDV2xbs7+JUWYbJZYGFvYJdsZQYp
         7gX52ddhfOx612NBffYFPdCVtxv7MzDs6kLRbCy75CJ6OD94SGYPsTNd4usUW5+H8pkD
         n/VY1iUkXmT0SO2RlvQlDHk0JBXuazXroillKvyA36XVE8qHh0mfHfNedk9mWPT3rhr6
         hoY3VxVcZyQl2uocpovU8aYtFMvhKNLDbrRZ/XbR5L8OpupBNmjdKcTQtwPDmedWOjQO
         C9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744926264; x=1745531064;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBFmVEPSVrHwnGq833HFyEFbm1Am5W1x46GKoIrb/uQ=;
        b=nfI46yRGg/Vbz6QZCig2jI9nKuU3LcTFAhGzr1+4zpD7LtR0a6skCRUgZVSovAz+i5
         WVQl/X9+9jZHkkJuNTWgMEJ3HPlEqBb3U0l2iZ1DpBIwt6wSCv02MpQIxi6kvq5jH6bu
         pQFOmPCvmskSsp7usfwb9I/9NViFHaL9X50k/kSSvliT5bCNlrqfzdzgBoTVfOJJz7//
         hFNuBK3nczbLdChWQl8xRajloNOHW6FNG5WcDzVIRCL25KQMkPP3MoHF3AZj0K1gkWRS
         dGiCX7gV2+kczkD3WjGg2b4m3MGaRcNnvQGioRPVfaseOtZJ00n57kEk3S211WpNiTTS
         xhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsZzMb6H0V5D9PkaZEphGvLzcH+e7UINDd5IgPUXWq7Pnhxe8l5bYYYwuwTpRaGUxY49XrVFeqkSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLbB1lBnOFziPD2FEpFvKoHl4Rclze+pUIJlKu4XWL3mtGnjE
	QlUr3rDiJN+STQYpznALCO7wSISKh0jHZKf0fd4/sgK1mfKJHxxxM+0ER5LQ9C8=
X-Gm-Gg: ASbGncs1f0zShm9GIuhcxIvLv+35Dpls8Lv6h/4dP08yZouFaN+OZMdXTVy+3zqW6L0
	q//9ZMN+BShpZQd+RTv22aOdE1JR3eB6rel+e1niUFVhTRN1GPTkYdQmU9t4sihlfSv4Lf5ew2S
	b7VlgZs5a3eEEYcH+uXvQzZaf4O/eSCeNcXHDRKtWXIwGH7v3xbjzck+sqplEdPwzU1exdXOPbH
	juvSCzzy9chs2Js7nHTF4x8JFS27nMmxWuH3RvAAUMY8zYra+qqDWscDs//M6M1azT2ZTIEWCnE
	nTSGnu5vul7Y0eu6yhwSsgRjuBRtXyfMkZsAAO62vyE6jbgoBRkn9s1xWjY7ZTE+BatsWqGt5vx
	lBBc5G2xxgGVV5VHdQk4VHkH0rQG7
X-Google-Smtp-Source: AGHT+IHTF5EMJwHhbB9yGSoZvy8o4ivHEImtkv1Z3X5htHr/S3sX8LVDdG42TvQEzNml/ZWrzgECLQ==
X-Received: by 2002:a05:6000:4a11:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39efba3d0d6mr312407f8f.20.1744926263900;
        Thu, 17 Apr 2025 14:44:23 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406acc31fbsm4203375e9.32.2025.04.17.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:44:23 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 17 Apr 2025 23:42:51 +0200
Subject: [PATCH] iio: adc: ad7606: fix serial register access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANp1AWgC/x3MQQqAIBBA0avErBtQsayuEi1MpxqICgcqiO6et
 Hzw+Q8IJSaBrngg0cnC+5ahywLC4reZkGM2GGUqZbXDiw8cV/TR1arGiW9MNKMPgUTQmTYYbV0
 T9QR5cSTKxb/vh/f9AI8SdiNuAAAA
X-Change-ID: 20250417-wip-bl-ad7606-fix-reg-access-729c21478d1f
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=hXaDn6noe6picTrePR7Qia5Jgk/9c/68JzwbdzSufT0=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshgLL2zTOLQK545X1dMWbPtgMDzOFO7C7XSFycYvLOf0
 VTUwfy5oKOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBEnpxh+Cvx/9TmK7un6JZ9
 ydn09M3XP6tkIrVnnFz/Mv2Jn6Cm+fJaRoZVK65nKxqyJHSHtW11YogpWnPqUI6flZIS64H5tzs
 5m3gA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix register read/write routine as per datasheet.

When reading multiple consecutive registers, only the first one is read
properly. This is due to missing chip select between first and second
16bit transfer.

Add chip select between the two 16bit transfers as per datasheet
AD7606C-16, rev 0, figure 110.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 997be483ebb93293481b922e13ece4edb47e940a..bd05357a542cf7234d5bb6b718829d6b720262cd 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -103,7 +103,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 		{
 			.tx_buf = &st->d16[0],
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
 		}, {
 			.rx_buf = &st->d16[1],
 			.len = 2,

---
base-commit: 8dc6b228d746b1a900bed28568defb2266fa4c43
change-id: 20250417-wip-bl-ad7606-fix-reg-access-729c21478d1f

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


