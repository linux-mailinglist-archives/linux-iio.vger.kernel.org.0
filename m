Return-Path: <linux-iio+bounces-5908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09658FEF86
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815E0B2B00B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5751AB91E;
	Thu,  6 Jun 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufORBg7h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42A1AB8F9
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684027; cv=none; b=ouuJhOJcd3u17Q/8Lp4kouWaULhLS1Km0M2gm4tDTbiHQgboO4gXUOcefyLipDzdTb3zu954qWO83DpOFwKAzjQNfzvQahjrkw5pNSiNHQQ2FChu8aAeXyFbA3WXimOARoCnQ6p/ePbeRM984WdSKXU5Mrieo3aYRcKn8GaQ1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684027; c=relaxed/simple;
	bh=FBc8qGFzWnElA/PFQ9TDs3wAx45tlZ1u89JH2VfgkwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8dORr1d2TtXTJOpnvMd5SOD87LRGqD10UTwjjFNruVkKrcUfwOagmGuaqPG/+nPOl/XZzYDVWaQWCBwhCvLq413bAY7dC0jToFKhLEfYADn+ctZKTlpEqMACmVa3uv3Xd2+6Orb970L3IFHe6RhorBUiMIfBkZ4wUMdfZCTixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ufORBg7h; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42155143bb6so10836855e9.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684024; x=1718288824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npuZ6pimIot2dk7Ox3pzVTiM/tsReKLWyZCaqFTENgE=;
        b=ufORBg7htAJkM1k26WybudmrclbVeO531Rgq6A1uFKviNtubozpnncBt/6G0ng1SBh
         /fHow0uJdLWxZ24rd/kLNEh3NPm1BeQbhv9KAMx65vt6RY31F4tJgr3RRpA5gAYpEQ7E
         OBZK8lWCWdYY/lmweT1HL5HbPh2MqxjD7nGu4YarVlhdOIC8MDLsIOEbpRrZYFYPfver
         oTyuPoXeeAjtfsrZiUoNG0pAolVWMk4989HveLuO722s7sEKrewk//a/vgOEMkMkV6to
         lLnaustJ1NfFVQEMQo5YcLrarrSUPTYeaPdm7Iipo8YjSHz8fxdCqTrrm5YQwpoexnX6
         lteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684024; x=1718288824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npuZ6pimIot2dk7Ox3pzVTiM/tsReKLWyZCaqFTENgE=;
        b=p+AfI02W7autVUE60janIcwdmavI7qm5XzweZFFcA0jw4PH9ZElmkn8lpVcNxdIrJ0
         DVE45FjLtFRm9AUd53zal/1WvqFBXXNkKyKKBGQNMiqVeJ6vS4BF5XrBjnGtJTAshARg
         g+hgQ9WPqufboyDzLLHsayvBLByrJRWiKdGFtHTkq65//2qhfJv4blRV1ZhcgmoxK/IO
         I2nPfRqK8YRPVriQ9ViOWfLHR+ZVK/bq5fBCYb8atHnSVrTvdg4SIjPifk1sPgLtOSbP
         lOi15/IYhSJdzCasuvnaABSTuTJrtfkodjyK2fXLSqyfuhHktlFkUJuBnF654iVOQecQ
         5txg==
X-Gm-Message-State: AOJu0YyLYumvhrT4L4uc0DK5oRl9Gpwtc9cw/B/5kO6jmzg5nlPR9b2N
	3U26MmzowstslgrEV2fHpixQHJhvo3hkKfLZ0+nWeZ7cuXUhhH8aNOdHGgFZUdsPXq4OMVCeknq
	WV/Q/gg==
X-Google-Smtp-Source: AGHT+IH+OTxoo+vdqW8dWyBXEDyfH+yFNF/9AQ2PBeLJ6inJmCGFBR/bf01BEa9NMRz1IJNMYOk4ZA==
X-Received: by 2002:a05:600c:4fc7:b0:416:88f9:f5ea with SMTP id 5b1f17b1804b1-42156f4b8c6mr49522825e9.34.1717684024331;
        Thu, 06 Jun 2024 07:27:04 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:27:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:47 +0200
Subject: [PATCH 5/8] iio: adc: ti-tsc2046: simplify with
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-5-320b291ee1fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=808;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=FBc8qGFzWnElA/PFQ9TDs3wAx45tlZ1u89JH2VfgkwE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYccs927/di3mcm7oyt9XXcT2cHYL/pmf+UHsV
 ohH0QMR3wSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHLAAKCRDBN2bmhouD
 19/3D/45osNDrzMrpzw50q9ybIhCEj6nXNeo5muXsRcYCgoMnOGCjKOEWPWsmImgoaOVaw0m7A/
 S4hRRgVngbsMeEsNd1UpR5Z3os+dUOuVFFc4W3zKF4q9nyo+tiobJEwU0xNFGS1N7To8wLGmvmW
 v2hvCW8bvCGDUHAIJ/b2zyy4Z3p6gCbDNzID4apmKEci7FwmxzszE0hBkKuG7f9bBjr67cyxvTz
 8SyGXBd9CvFPH+hm1zzZ/8l8H+KpudEcIKkCaH1Y0CRaIwssQP+lVbrVcT878svS6ZQ0gnBNLu1
 595nde/uwPBjsAet+kfReYD8h9/jNF9zKFgojakZ0ItWE6TTMzmVWRv+oHdkxS6wHCIjf036qjP
 i0TfuYUqDnAjTGrJaEyylJA/ReeXPFkRvAtZBqByg92YeJ6/t0q95e0f1HDi3IMWKJkWW5LpVy5
 B8UeFeEe7qOyZfPhxAhEFRiaz6ON4hCx1AN6ikH8roBlgxA3MDU3j2b4akqrziZlW3R+oWcNpEG
 ifIZmKqRdHo5OH5uw1l5pv165p1D5zJrUT4SL4jJ+9iKa7Y8bBBZV71jVO1p6lGk0ww2AQv09vF
 ZeUuNbE5uq8Iqd2niFKCiNou4a/LaFqD6qchnLHP6xTfisjqGTs1Cp3BAelAPevojKWne/qGaG0
 hBE2y089c5l0IVg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/ti-tsc2046.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 1bbb51a6683c..edcef8f11522 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -804,12 +804,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	dcfg = device_get_match_data(dev);
-	if (!dcfg) {
-		const struct spi_device_id *id = spi_get_device_id(spi);
-
-		dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;
-	}
+	dcfg = spi_get_device_match_data(spi);
 	if (!dcfg)
 		return -EINVAL;
 

-- 
2.43.0


