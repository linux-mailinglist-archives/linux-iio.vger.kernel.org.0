Return-Path: <linux-iio+bounces-18288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC81A93CD2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A54A1B63F26
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916C22332D;
	Fri, 18 Apr 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L5O7QZ+e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC0215F48
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001195; cv=none; b=ksvy89BAhRwfmYDKcWJuDJgKe84dgLwcWLRFwqgf0vs6RIKLcPvbv+X+gRybSZ5zTZG8Qh6s98zgdQb+FwK1socpNeJ3eoq+4d4OzG8Lmb7gbGAzHt/aVXq2e75SYmLEZzLysHaPjSzIKmA7pp7oS9SLbTLbGSV1pMKT0Ql/lEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001195; c=relaxed/simple;
	bh=BFNfCAXgfDy1H6nRZLQIbFDRB827dsSp/614b/HrH88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oeYSGd7BVtml3FbIGo4oKRZhHh/KTv334e3KN4F/VHIXAdp4HJ/P/LZpCFFSRxKTmzMhynILehEB5xqcnz7rW7Wbt1FXsBQWmKwLCfPamUoIRAtGbxF4OcrZqHjxYVY7+dTtxWYCf5vVGYmiTKcZ7nigwZ3rhr4d77VbomQf448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L5O7QZ+e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so24598145e9.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745001191; x=1745605991; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRZ+jgVFwgume6BxLPo2873YNqsDxYM/0lRV47dPLIo=;
        b=L5O7QZ+eyONOJo3fkO4oGPPllKpO31RSaxKnWXDX391kNnevMrmQoKPV5fdAshyEmb
         sLNtGaSV/7P8MVeFLyWex8isy2SpVpmqGE/8HN8bdAIafrWa/W1lkKDZJLXr3aSZjITz
         uSgLEfHYoIJmk18823Cq1GES5mCbkeKFh+a4cTOv8+91KSN3kWpr0pwjCgwraoOE+t7r
         W+xrfuy+Ivh+9fnzZOQcwS4IKcML9EnRBMqkeEaDlxCr/ZTl12LHTWNxrgPL9GiXLGOP
         plMonwmoCJnHsPz8gk11GjjG51KhDCGrCsMrMCLbCdJr2eWaas7awOhZbkN5Knjmcbv/
         66sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001191; x=1745605991;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRZ+jgVFwgume6BxLPo2873YNqsDxYM/0lRV47dPLIo=;
        b=WBVjpemiOct8kVtihLmTcYLvjRxR/HP0kebIJ+23ELZTH4K4avyfmmaJhfL/pqCoeH
         yIcwa+ud7mzxXClep7PIlqbnEjSBtx5AdJLFzE8dQ6AYvbyGRDZXz9jMipL39sZ67OQN
         g0R7se1z0ZOtWKftfSwypN5sqvRo08CEYo7tMhjgcDXvuRY58AbkyHtYb1KgTGPLbEhz
         847sumGmEYmuqJNIyZlG6i3l6Q/nassSHj/a/V3VIMNyPbl/JEpCm8eY/e9Rw2/538mW
         ZZUoEvUv/MJlRuEGpHEUUJTbt6+Ivcr1tkro3O1DveEtUsiCmjziiZVK6gFjRcHjfXwa
         Lu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaOEXMbMyXHt8NCZ9mvyTAeW3Df4GZimexuBkPhXDHG8WQZSbDinUVfesbVdhzWcpns0ydANUTcf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rwNBCOyxrSB7ado7Clgw56ZRMwHRr27/B8qspCjHiXTpRc98
	Pcns2yTgrWGKfXXcXAEB5fthwJOksOo1iaGVwtzA2/fQiNwtHNUTPpiQ7MOsxMg=
X-Gm-Gg: ASbGncs/Qa19zb9iGz15h8KMZ293zAWtIXrrS8BHHsbgvIg1Znyojk7nYCsLp2/CMnb
	N8J5Ks8j/oVekPEkkUK1oYRm1zSXjlj7xDQD6NgYPVgoNNNe7WotXj9C7SghRo0FnB9ZrROg6t7
	o1jrOZlrt/YFcFHMiOe90NI1wwfEQwEdazKDfVNCvIwkKTJ+W96OJ6NEac4IrTsnI8LUxRsCEGE
	3RGSinPLzWcDxqJjFPuzBlrVQSP/UdRXfImUWNnO6YHTdwYrbAlzMM8oVIiHchXW1V5oMa9RsQH
	tquRDv3x4KBtYMuWh5hsnT2M2KZjGAZbQKjPa3bpnYFmgQvuDzR8TbfDM1eXd0+UChipCpPiWGZ
	Qs8+rdCC0l7HRpgY/Iw==
X-Google-Smtp-Source: AGHT+IGj9S4WRUKZtNodHl0GH1cTBRYlYX+0W8A4QD6dvdXuglhWcvb+rdy1DdVJlqow/SR2YziSIA==
X-Received: by 2002:a05:600c:190d:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4406ab67e15mr30991265e9.7.1745001191034;
        Fri, 18 Apr 2025 11:33:11 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa433429sm3472343f8f.37.2025.04.18.11.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:33:10 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 18 Apr 2025 20:31:59 +0200
Subject: [PATCH v2] iio: adc: ad7606: fix serial register access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-wip-bl-ad7606-fix-reg-access-v2-1-8b1ade67e185@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJ6aAmgC/42NQQ6CMBBFr0Jm7Zi2IFVW3sOwKMMUJkEgrUEJ4
 e5WTuDyvfy8v0HkIByhyjYIvEiUaUxgThlQ78aOUdrEYJS5qEJbfMuMzYCutaUq0csHA3foiDh
 GtOZGRhf22moPKTEHTosj/6gT9xJfU1iPt0X/7J/hRaNGRZwX2ufkKb83bh2kCXym6Qn1vu9fV
 PkFAssAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=c/1c0SGQH8ay28jUfCcMDnmohaa6iaUAM5O7MoDjGZU=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshgmjX/c7dNWIjfl3+tj1cnh6wsft6y9Pwj7nlqdmsOz
 uh6eMtVqKOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBEuEUZ/kdczX5jdP38+7Dw
 18xCbPNl9COs2b7tXjJltbU9r0Vt+C6G/16HeHar6LxZYvIwz2PvEilzy1Wle66Hv+ldKNRit7m
 Bnw8A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix register read/write routine as per datasheet.

When reading multiple consecutive registers, only the first one is read
properly. This is due to missing chip select deassert and assert again
between first and second 16bit transferm as shown in the datasheet
AD7606C-16, rev 0, figure 110.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- improve bug description.
- Link to v1: https://lore.kernel.org/r/20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com
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


