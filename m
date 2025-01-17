Return-Path: <linux-iio+bounces-14412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1DA14EAE
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 12:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E5B3A2FB6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82611FECD4;
	Fri, 17 Jan 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JaR/M2YS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70B1FDE14
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114357; cv=none; b=TgzgMUxzNFpEF1S7T3LtHf0iIS9gP7IemkWYR1vREyxph3rGbhWjhUwNxznxLm+meaSONGTOZkHv1OQifEgkcWVGcvNY6CB8etJ6JM3KJw5kywfDlWGfCsUpJxFD3m7e8+A7Iv1ccJXmQBVGZOgWWcBIpYNgDF5mXKfW5lImwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114357; c=relaxed/simple;
	bh=Ic0dUSRBbSPcwd8A1dpe05r/cEGAMekPsiRX2TPIQhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckjYDLnQkavFf9dCCn/G59nfOGHqSZrsw1IpHylGLt1fe+YBq2mqSHGd27IeZT2CWsANDfrHPky/90EI2L8eIXQar6GenmZY8Kxbrcu79OCJO3KGAT/Ipk8pCuv8x5frzPXHKHQFHpmNzW0fEmiIokuIo8F08oO1snkSbA4h7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JaR/M2YS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1042717f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 03:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737114353; x=1737719153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TZRktyyBG60hFO6UMKwaUx5vSkkWfjes2WCMQi2PJU=;
        b=JaR/M2YScD/mbjyMV/6qv+SVyyRek3pCsHiQ6Q/U1g6U62l5ykqkCYOubUyD7pDQDX
         iT/AwWjP9INYHi1zerf80LdCvNaZdZXgieYPxY8RFRJtJ1IJjW28N8iL9pEBNS1IBIx0
         scp38sPbaVaEUGnJoGqa8p4qwdm4VcagFjGQb+NLBNn9HlGKHfd4s4qVMt6D576LITGB
         eOZPypulGqBoZuXqQAptSW4ueOntDizr4FeuOhgW1UoAg7wQTd1fmsB2FGK2brEACrGf
         hRsHLtRGhLWP9o99egY+KzKlwIhyLz03tuTdcenyMycMEgt/TiIgeIBR+I5LZsXjwkDS
         o5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737114353; x=1737719153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TZRktyyBG60hFO6UMKwaUx5vSkkWfjes2WCMQi2PJU=;
        b=t1o/0RRm2jXwOtB3t7hXi4bQn9kLIbZ/Id6B2J5lnZUWkF5gHKtONCVg8WqUOYVK7y
         Zgg/rnKXAi7X5tsdAL4KVozyx5/oCUCvrEigzuM9D4fBPoncomjdZ2CMm6Ojs6jKdJKr
         oOHOK1fkDoj27Y/YWapICSPoJ2x6lSXqs1jyVA4TpkvCfPHft2TJgx7HTnKzfWdqSoaU
         l+2h4KD8aFak+Z9CSWs+WO6/KFBnrC3zdz5MV2ToM8dJNaeeyNyeonvMWmoWph94cEwo
         HpAn+1ITGXEu5qRHnHTlF+7Z0fwgFglhTGtIcylqjH4b+a7uuIlZYgw1988i0EzRD0Kb
         0vfg==
X-Forwarded-Encrypted: i=1; AJvYcCVrqcUKcaNkAMRECpuVeXQD1AIATZc44YhzzDo0wLWWO0CYbHMVl/Ntp7ClmXbyz5kCfu8+6fr5CRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7BjdB0aAy+vLpKgzVhodpzyhUJp7aIFt0ePV3OH6rNmEcr0p
	64XuKhWfa7u66zC2iRJlq8zgRcCNc4xSceYYlTvv9eznO4vPkGRJ8HbhL/d7TNI=
X-Gm-Gg: ASbGncuH2GuGNyErJ9IY8uOcLMOjhZ0ots3EF9rjIV3n3ZOS8X3R02VSrkITeBqkmeJ
	IE71tEQOUw9y8wHuNJzQzpJYGeGEV1fDQVVbzCIPRL9Gc0jMNK4aHUgHF476usc8P7IeftQmIf8
	1NicUO8Ep1nm4KWH8+rq4C1nGsgXRLSlQUJdUX60thhBQTF/KOB9oYsyy0Pw9nRu/5CqXASbG1W
	V+ZAyY5mbUi2lli+fOueEyaa7abdhlDmBeFs13gyntgfkUBpG4cKesnjbCq73Z33JanJIS+fmtB
	XcNsPjRGHKE=
X-Google-Smtp-Source: AGHT+IGVMbNBWKyEsgqUoHAN8pJLCCoglPmI1Y5TRMuv0rz7Lsw40J1JRHBIdaOY0OSqyYHQYiJtMw==
X-Received: by 2002:a05:6000:186f:b0:38a:8647:3dac with SMTP id ffacd0b85a97d-38bf57a68aemr2062457f8f.34.1737114353444;
        Fri, 17 Jan 2025 03:45:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322aab8sm2348496f8f.57.2025.01.17.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:45:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 2/2] iio: adc: rzg2l: Cleanup suspend/resume path
Date: Fri, 17 Jan 2025 13:45:40 +0200
Message-ID: <20250117114540.289248-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There is no need to manually track the runtime PM status in the driver.
The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
already call pm_runtime_status_suspended() to check the runtime PM state.

Additionally, avoid calling pm_runtime_put_autosuspend() during the
suspend/resume path, as this would decrease the usage counter of a
potential user that had the ADC open before the suspend/resume cycle.

Fixes: cb164d7c1526 ("iio: adc: rzg2l_adc: Add suspend/resume support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 4742a727a80c..99cb73347b18 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -89,7 +89,6 @@ struct rzg2l_adc {
 	struct mutex lock;
 	int irq;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
-	bool was_rpm_active;
 };
 
 /**
@@ -580,14 +579,9 @@ static int rzg2l_adc_suspend(struct device *dev)
 	};
 	int ret;
 
-	if (pm_runtime_suspended(dev)) {
-		adc->was_rpm_active = false;
-	} else {
-		ret = pm_runtime_force_suspend(dev);
-		if (ret)
-			return ret;
-		adc->was_rpm_active = true;
-	}
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
 
 	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
@@ -596,9 +590,7 @@ static int rzg2l_adc_suspend(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active)
-		pm_runtime_force_resume(dev);
-
+	pm_runtime_force_resume(dev);
 	return ret;
 }
 
@@ -616,11 +608,9 @@ static int rzg2l_adc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (adc->was_rpm_active) {
-		ret = pm_runtime_force_resume(dev);
-		if (ret)
-			goto resets_restore;
-	}
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		goto resets_restore;
 
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
@@ -629,10 +619,7 @@ static int rzg2l_adc_resume(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active) {
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
-	}
+	pm_runtime_force_suspend(dev);
 resets_restore:
 	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
-- 
2.43.0


