Return-Path: <linux-iio+bounces-21623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3FB031F6
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9910717A8F1
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDE285072;
	Sun, 13 Jul 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAeBjYg+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8C28000A
	for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422408; cv=none; b=LnzXc6FEO37/nvn+X8eIU6NGaU6pcV5DD+reEeyWjxQ2knRwN4jPaJeHIobMqhxUYU5QXkE7HPflbegRXwgRHH15mYn2fRMbBYdjLJbDYfGHrGDaqFlAaZgxpIxMFWumoypy8WHoawJa4ssDKmjDUHZjftbwIr6EsDZXYITnCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422408; c=relaxed/simple;
	bh=SHev/ImNeBA/loCRFEJTkazdBRpzjMRUZjJsWg8BVd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3Ydc5aWasimVVq1zGf1aiv0CUM71RbAjOaHwDdr4c4SjGB1QM+dM7HDfB7q0BBqyEnBwBVg4/PVRnPd4uvSEK+grysyzLFeoG0m1yJAaV+74HF+hE+vhKz0uJEocfuF+8g5fQPbXC848qYbnI+69n+zqVyXtp5NOl2o0YPA2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vAeBjYg+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455f7cc9362so899415e9.2
        for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752422405; x=1753027205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJgzqT73epF7ksehX0w+zVrJsJH4FpAExGbdg1NewuQ=;
        b=vAeBjYg++EjXhnJW/RsEnY40j6/0XzvKFoefXAGVYIRFL06RMs9EhhCFhWfdPIXb2H
         WH/zKjkX1Ce8/lUtTglTVVwcABH0aN2mM3oT3hEwZhKPykMhOhY5DnEWECZoE/b2fs7T
         8A+dpZXYP4i6eihZhBAIVfq8pTbBPWCpplpWIAXXf6m/r36f1H+0RDHpI+BhZyI+GQVT
         YffmbBAzZiOiDd5mQSzN4zP55SriV0ZUidP/7OKMLgYTf2Hu7BSlTY2zDT1OmkTWOvvv
         Sz51QXzt5GMgpWWr0zTdykgrvhPkFbblJ/4MgMxEYLr0dynfEelJ+CpdNFoJq1H41lWp
         eyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422405; x=1753027205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJgzqT73epF7ksehX0w+zVrJsJH4FpAExGbdg1NewuQ=;
        b=gB9a3aypXKLs4IMCQHGi1lJzoV5Y4RhweynRSlL/tJuPWszDHyVwWJRHmi0xAkJh7F
         9BlFKm7CjvTmOVNc6nxqCiICN0l7zz32rXbj3A3zKOXV63gMUdOHvo/8W2WKUgt714bq
         0Ct/sVmkXAGtQcod9fWRVLUIXhPyRGjFt6ScVWgV0QY6GNCiqYc9tg4C/RsTSGzpTpo2
         SyaE69bF3BGVyh+6akw9vYrYZ/jIJy3XBWZebfCe9JmiC7C43CxdFDjx+SXog97TlvdT
         O/tJWevQvyh9icqW+XT9GfMv4469ZT3DkBexlPKOrTintq4WyyqtUebGNuscfLtMwLUA
         LEpw==
X-Gm-Message-State: AOJu0YxO5CeYrILJTbRz8qc9IKE5DgzH1+GNMlBG/BsMvlc92YVFOaHQ
	3dcxEKOC8ArWkLRnY12s4ahSe8D6fvLHPwNlwLCxmPAvBMVlOZzBM91l3GEG8wv/LrM=
X-Gm-Gg: ASbGncsVfSVC7rNr+dG5usdjwZJRsNlfe4Hg1rmiZk7zDV1Wk1D11sYkZIOe6LgsQe3
	caqt3rAJTQH1iiJTibhC/KTAckDUbztXqSBoWg8K4Wi18n8whmkZMqUgOXUSj+Yso0qzrj+tHfE
	KI/62BEGOI4fEQe4QvvNt9qWxVUWsIA5XDfV/DLfhLmz82rZYTIlO2k2sZlnpAciAcmvNQFdAhM
	NfUlzWYJwWKP0iNlWDfNOTfrXiOMY/d5Jj5xnx5U0qkSofSFQ0KwQl23YKfn0Uylz/VKyeknvWV
	utsa6NgPPKrCB/su2llTncpMnshGxGdhHKs3qx58D4Dy675dFa70ExQGZP9KiKFPZelyEYH2J9h
	EowRUWed3hC90KIT6QgUUEvVnfo4Ils5/VktO
X-Google-Smtp-Source: AGHT+IGrxVetpFcscPrfDCEb/sZGzCDBUpU2bgTJS+xEax3mNVhYOUwZnoWloL69+fkJDm18DXkqhA==
X-Received: by 2002:a05:600c:c48f:b0:453:c08:a1fa with SMTP id 5b1f17b1804b1-454e7c56045mr36087115e9.0.1752422405118;
        Sun, 13 Jul 2025 09:00:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm10244123f8f.37.2025.07.13.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:00:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 13 Jul 2025 17:59:57 +0200
Subject: [PATCH 3/4] iio: adc: vf610: Simplify with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-iio-clk-get-enabled-v1-3-70abc1f9ce6c@linaro.org>
References: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
In-Reply-To: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SHev/ImNeBA/loCRFEJTkazdBRpzjMRUZjJsWg8BVd4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc9f+ZEn0EWTpz0czMzP1Om/MW+U4hrxrI8Rke
 PaNYyyjpkuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHPX/gAKCRDBN2bmhouD
 13l/D/9ZrCI4Ckxc0kLzKRTn0nPaAE/zKm4VwYo6npoxXflxN2RdptNVEO3ucMr4TS+5wXBRhtI
 3qyBwb0kcpsXlpXAK6LKjENCNonIFF1Zh+XPkABUy/e3qN7Lbyers95Vf9XPYfjlE4dsbAX8iT5
 mYLHDjCinC4mhxCuwXhzPLGHL98U3+SDr5j1LGBgKDZEeee+cUH/TRp0zubFfsBApXJYnPpeU42
 FOeIelLl0TKKotWpTaFmpm6w1p/WIqlsM4nA743arCk3KU8VhH1b8NF/Ee3fImrJnZYTJZC6MKQ
 AlVH8NFWRGeJ9IXIbAx4OmCnydfEuc0chKxM+hC/O8eZolWfEGaZCed72Ujo4INJm0L7+Pn0tia
 wBuIWdlebSMgQEisToWQ9XOwGSd1jT9zVY+bh3/GBf40ckh/NXO9/27RANHF0FU1mXAf18WumTx
 /PEbHBNie0h1X5s6ArIp1jLqmzH/uuFXKDSHRTSRm2Y9BDBoIk0+6xBww4URyE7XCP1xEjqv+y3
 yjovQMME+5FIcs6vpSCFINJECRiyTSJIDkWaVPF6YZDFm29ThS3VHi2gNkH+gYG912ROeh5OosN
 6Tx86/hQPG9caFH3EXj8vV4HY5UFR+9mwgRlxOAlVJAbpq6ibfAARQcMsipG2aH3E0nxG0uuIFr
 EZATrtTzaKfBJ1w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/dac/vf610_dac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index b7ee16ab4edd596564580e7fc9cfb556b2a0ba1d..ddf90ae65a2c2458ccd4fa855f3dc56b923aaaa6 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -189,11 +189,9 @@ static int vf610_dac_probe(struct platform_device *pdev)
 		return PTR_ERR(info->regs);
 
 	info->clk = devm_clk_get(&pdev->dev, "dac");
-	if (IS_ERR(info->clk)) {
-		dev_err(&pdev->dev, "Failed getting clock, err = %ld\n",
-			PTR_ERR(info->clk));
-		return PTR_ERR(info->clk);
-	}
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
+				     "Failed getting clock\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 

-- 
2.43.0


