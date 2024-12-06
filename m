Return-Path: <linux-iio+bounces-13173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21029E775D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D0116B78B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2E1FFC78;
	Fri,  6 Dec 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xhVMNA6C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D551FFC67
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506163; cv=none; b=fV3RVD0HOoq3iGB/SEEyvmkGXCB2f7qNtTVhiFNaja2TsCtsem1Llr/KtSEg/+jt+V9+ErIPvl6lj4NcY0u8BCYA1Cw7crWkyC5+sVqJNpVoFNMxuwNToNQyuFVA0LGO+itwCl9AUd9tEnwBZyDIcFtuWOzAKuIXVhxmwP/P5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506163; c=relaxed/simple;
	bh=nUb+NMAcRYvbgIjmhL5rgEmD59DRRpbiNVeKclS6rw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/4RDu8+qVaj1ueEqQNNkm6m3Wlf/YZXxxrHubp7X1ICs6H9CIKFYvSi8PxnzVCy0gZn9vKXa8KPDPUY1Ftl/q3T9nO3lKs1HKFiWzVnXXIf1SHP6IlSt7JndwRThdOGedzeYdo8Odvi29WNT1sEs/UZT6F15wgFqZAcrvQxyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xhVMNA6C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434ab114753so15913275e9.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506160; x=1734110960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anOCQWfac/gSq63hP6/HMeM4pMNlObJBcvXDBpnhemU=;
        b=xhVMNA6C7FL1DSFP+DlK4dSk9KVOXrZLK56VpS1M9q6w0HDoFsSlRehvCJKBow8ifd
         hv6io21YpFbU62kE57yWQz4lvtOOBcwLcIFp0hRPlNj5nQK1A7BvHVGMAeMotftVr1tk
         QW09Pp17UWA4+IphH+82kOttTWdrC2i192NIneYVy5zgzoA9E1hcR9mjMrmxC1r/kuBK
         Qp7BeOgKUjVh0WW/uKAkBmPItQPOuw2mouuQowqfWdX5h1h93R1+f0H09oAPcy+5lTnV
         HqlFVf0LeQXgQd76L4yFk/sksoLBTLVk+OM0rxgYbcaOogEe++nsbcbrj2BnAEpTWa77
         r9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506160; x=1734110960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anOCQWfac/gSq63hP6/HMeM4pMNlObJBcvXDBpnhemU=;
        b=DFip1ZXDX3pKNK2kHLXvRCMwnaxT3Vaq5NhaU8eTycbEPkEwzHmV8BJ0a+jWvMStS6
         aYqdjZyZEIwDaMGBx03pSg6V8ifu8r/xWgq3hIPnbyXhVyNvNuGdCNBU6TTgAQ086ObO
         qs34yxXBs2HbgocNgzTAbVcApfSm6LKjEHeGf1Hk7EXnH1t4JgPHTp8ySSCuWyEvbYGf
         MlWMtN/alkh77Lr1tIF0LWgArWmaJoZTxcjsbZ73zNuio3E8sjFW5Zz6pDoGEjSrUiTA
         3dAHLJFCLk3B5BNan4x9pu/FH2Fk0t3+AcCIFe12TuTZs/+u5txehnNoNY+MizTACBr9
         N9mA==
X-Forwarded-Encrypted: i=1; AJvYcCVgzLnwICtg9/1g1w8mOsFWdJkGsqW0TCy/02AQLXswssrO9Igug6+1jh8gP6i0hzeNi7YV89cRC3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiCPfwXSWdAnErzHvry/5O0zotye/0yr8RQzDJRA4EDD4d33u
	9Nl3ZmK+eemQzrTwcwcUoH+TQY8M3UlDsmqsqXRQclMuTW4eJyPvE0seoC7Xh/I=
X-Gm-Gg: ASbGncuz0eno6HwIIIiXBndKcSFTJAuTL4WK6lT10LIXOGvL1vsjzhofmCx9KwRRJp6
	ZT4rKb8AkcqETP5p8o18qMsFlRfEwmSWHE0WaJhI7ThDPeOZqilEJckNqC8v6T6Qd0saF19YYPG
	DBo1yccGNkij8NhXJm9VFJUlhJA2A8XC0fpI+k/T8iafDPCT4HthRb/o4PJ4nHRfyJw+5LSjH/n
	Pip0sP5P1HESAnZI3K0TmbdI8yW9hGkioBo/xcLcThFaE73S2w3ZddZ17TNXz3FnJx3BD2LpUp3
	19qX
X-Google-Smtp-Source: AGHT+IE+qZ8FptrRGeU65/E7NfNjJzlA2x789lQ/iQdAlFIC1bKdAO/UHgV5i3VtLGDpgymcQDrMzg==
X-Received: by 2002:a05:600c:350a:b0:434:a1d3:a331 with SMTP id 5b1f17b1804b1-434ddecfec7mr31128385e9.22.1733506159796;
        Fri, 06 Dec 2024 09:29:19 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113508sm63235655e9.35.2024.12.06.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:19 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 05/10] iio: adc: ad_sigma_delta: Handle CS assertion as intended in ad_sd_read_reg_raw()
Date: Fri,  6 Dec 2024 18:28:37 +0100
Message-ID:  <8d76b4ea4a4363b269886c71193b840821c724ea.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=nUb+NMAcRYvbgIjmhL5rgEmD59DRRpbiNVeKclS6rw0=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGdTNE+ifln/JZWJ6HhWXIMo3Y5BJedD1LWvgMUo9LKAv6vJQ okBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJnUzRPAAoJEI+A+1h9Ev5OLQ8IAJuX /Lcpu7GhiJY0WpXRnNMiuzXqDO9TUCBQrTrsa/oz6m4gfsCTOpGCDCzz4UzrkWkLUrnLvr5GYRx +MPp427nxNU46s34F2TBVJLMNUiB1Un2rvx5LHiLLEvli554fwUTL3xUerl50jlENTLjIFJV9+S /DhYbvarG57FryO4UEDLiAzuruMC+yfWp4INm3h6bdt0ubc4AOFLU5VoJ4mwl0FFdyjw/NcSRM2 AOPzvdeloK4IF9fZmnsgWC9AdYUPtynQpeiWXCN1hRbzB+u4keTlGWJ1ajYEqkOqvaT2sT0ECcY PQSkryx/tjtI5QY8f6w2470yRb4eX2STETW7t0k=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When struct ad_sigma_delta::keep_cs_asserted was introduced only
register writing was adapted to honor this new flag. Also respect it
when reading a register.

Fixes: df1d80aee963 ("iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion")
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index f25850f4965a..ff20fa61c293 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -109,7 +109,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 		}, {
 			.rx_buf = val,
 			.len = size,
-			.cs_change = sigma_delta->bus_locked,
+			.cs_change = sigma_delta->keep_cs_asserted,
 		},
 	};
 	struct spi_message m;
-- 
2.45.2


