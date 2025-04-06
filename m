Return-Path: <linux-iio+bounces-17712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C72BA7D013
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 22:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9276E7A4987
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21D218ABC;
	Sun,  6 Apr 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiKIhLGy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CE1BCA0F
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969717; cv=none; b=tSLl9UtiSftgfUQEnkMYXfkOb1An4tR9lh8FRWAc6SRln8DnMvP1j5eJLh/zAy1oMwcbYFz3PsFko1IAMLKvVV9SrjiYrVOMfYOJSniDVCp31j0uxKWAoviPjCBx8CZL06e9/RljGhaNXDh9k3qK+MlHj7DYCaOSxw8ztwlli14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969717; c=relaxed/simple;
	bh=l7CRhFlZ6pn6hdkl7kstlhIYoNXxtom6dCRCabxrvMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbJAvjAe2FLa+Lm5hIx56WfSdW+zWdcjqgskBfvKnmPMSOClUSsSPtwoZpv7Ht8l4kC2TB+KbRQDwdF60fbQXX/7u250zSyIqMywZX5nKP1Hd5P20tlNRYRFXUecQiUY0rkJkiFWBM+0Xw06uU1lI7ZO49g93y6gh5KD2o861js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BiKIhLGy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39973c72e8cso400862f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Apr 2025 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743969713; x=1744574513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ux2yY1RchxKGuIqfE/2wQobUJuq5g/5pfkTf4qTXwDE=;
        b=BiKIhLGy9tI1I+L510O0dm/UGF5E5mhM3xxrtL/nZrqQbmuvckexqPbeJDZ0rnChbl
         aJsWipiuHgznhVX0+lr8BEp9XvDbSxFIybuDzkFzv0Krf/kMilZCJGgqmM6XiSXxF+GT
         E63zBNmtfmvmmgPHCgIcERL/Sl/acryadiyyEQFheia393X5GaqsSOpCO3NEaciir7/f
         +jl6P81cVR+i5+wwFneHkU6E43JXmfGdpUzVfgN9nFoWqtaJmYHTRTJEJNuyCzuV74Zh
         ozxjsPvDI5/wp9d/Gl/x8QF/ot6VUkvGNfPoXkTYAm8we2SJ+HK35GJt1CMXPep2Jl0f
         +0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743969713; x=1744574513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux2yY1RchxKGuIqfE/2wQobUJuq5g/5pfkTf4qTXwDE=;
        b=wbOsUNM2gfG7ZBTyViuk7sQCYA+EBR14u8hoY5IJpDFepoaH4qq7J6WV9vAa+So470
         qh+Dp9UNcHy5N3JwSzzjbtbkrGUobvVTMknoK4b5+hpLmOfoKW6gQXGuYXn5o6riQpYI
         2Qh1fmVeYqZKahruEuj5/rCdfgd4DlzpEp/pr+Y3+2nVOrr8NdM2sazl9zYC4vRB0KOq
         0Qw5IvUPQTnhVjTG490TO3q8FALCSpY+kSg9A/+DcwhK/Cxn+F/Mv0pL5+YQ0o/e5/FB
         ZHrFHwF7rWHQFXZB7upJwFfil5+OFcLgWe15/glvrHxLMvPYAPnsr477CR3ts3WjEQfN
         zdcg==
X-Gm-Message-State: AOJu0Yy6i3qQ4UhAO+F0OTEfjO+Bkh5BrYFXcNvLB7Ut8agLHSs9Jlz+
	BQkpaAgUhD60S3t9LVR7A+p9/C1t7oXS8UgtGMxSThr6lQ4xeWuBCnAOl8pS5OWpxMpL+18MG1q
	H
X-Gm-Gg: ASbGncviCOFdWsZQOsOq1x5oWWpnPtb+v3n0Uamcu5vC1LcWzvoJAY+6qxktT0bCuIF
	ukDz+H0GFvS+t2WQmS4P/iGag7DMVTT55/On1+UMjEkh9tV6fcb++mAIhYgJ7oW8przTrYTV3cl
	sJNzGUVushSdB0teEfFifOjIyrpPToeRkahIBS+Aa96tBg7xrwpQgyo2v0U2Cp/40qrTm11p5uk
	PKaGNBk9ROc4/Y1yPJBjqK1CAdsve7wgUSIgH7PAzILoN7or6FnBUCA8to27lqyHAWjsAJkQvLd
	cluOSdCC4Jycf9K3kC9+HAWRUsILr+yexFadaPapyQZYXwu/4DJxzw+qObP+TsTpkjgCHpxeVA=
	=
X-Google-Smtp-Source: AGHT+IEJ+Ef3Oex5pdoKvNGE2jNPnyAvjiCvNX7k53N0P6w5OL4ACrTa/WVrbC1VAnfl97pDetAO6A==
X-Received: by 2002:a5d:6d81:0:b0:38f:27d3:1b44 with SMTP id ffacd0b85a97d-39cb357b616mr2957681f8f.2.1743969713594;
        Sun, 06 Apr 2025 13:01:53 -0700 (PDT)
Received: from [192.168.1.26] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d98bsm10199924f8f.76.2025.04.06.13.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:01:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 06 Apr 2025 22:01:44 +0200
Subject: [PATCH 3/3] iio: imu: st_lsm6dsx: Fix wakeup source leaks on
 device unbind
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250406-b4-device-wakeup-leak-iio-v1-3-2d7d322a4a93@linaro.org>
References: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
In-Reply-To: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=l7CRhFlZ6pn6hdkl7kstlhIYoNXxtom6dCRCabxrvMU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn8t2qifPOWPOc85NGw1m7yDEGSug8i9ONXMKX5
 5gP53XtWDiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ/LdqgAKCRDBN2bmhouD
 1+B4D/0eXUZVxZoiPcZjMLxa3FH+U7uhxJSCqoHJdSpdEtOM4g0uDEfsauINOXiir8KF2EspHqx
 nkVH6hoL3EaHuDsWeD8bjY+PNKS3sThCakly4LNMYHyPCd9Hw6ikDYNkk3IIAMigdi0g9VUvBh8
 A1NZIeM2OwUbGz01zpelL3sXyRjgDxQY6d0BlX4iTPnAiqmdIq5pTVDmp+v7qZd5owzwKwYqvN2
 OCom9ADN+y/ham4MXhB7UFJoUKyrQcH7EKiqUCZHEGKCC7z25oZl26FaJCieR09OMf384mizQ7n
 zGGGFJ5Ik4Y9vMcQ6qMmM0GglVdV2VgYrHKob4im82KXGwWNcVIKS2a6KA+MGiv1riFAUOPDHzj
 h93xmc6Zfx594JWNbGfOHU7+n+zgbzGDO3KFe25OQLRHsWKNpUGOSgfTV1EVzL10JB8v1iWMvAR
 5E/NTLjRjTwTqfqb/2M5DMEsJ4EAZi7EugacBRC8h0CFI1dJYLPtVg6Lk1R/98F/DFqe1VZhj5p
 Lg/dHImuAp5oCNfiLULw8w7XbBvIHYPeLFABam1fdzfllND6QIUUN1VX6wrr40uhxvJANSrJfL3
 2Pc4yd55QRMjpKsKeX69vo2wtceyXiLQ5TzD53RWM1brIXiYa1zb191VmBV6xp2Glo0pnt68BgT
 ThIX3TfHGrgd1Tg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4fdcc2acc94ed0f594116b9141ce85f7c4449a58..96c6106b95eef60b43eb41fef67889d44d5836db 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2719,8 +2719,11 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	}
 
 	if (device_property_read_bool(dev, "wakeup-source") ||
-	    (pdata && pdata->wakeup_source))
-		device_init_wakeup(dev, true);
+	    (pdata && pdata->wakeup_source)) {
+		err = devm_device_init_wakeup(dev);
+		if (err)
+			return dev_err_probe(dev, err, "Failed to init wakeup\n");
+	}
 
 	return 0;
 }

-- 
2.45.2


