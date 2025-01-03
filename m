Return-Path: <linux-iio+bounces-13882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E7A00A31
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ABF1884D70
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3337E1BBBFE;
	Fri,  3 Jan 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I+pq1zuu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0A1FAC3B
	for <linux-iio@vger.kernel.org>; Fri,  3 Jan 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912865; cv=none; b=aOvIoV5N6YJGZVyGs7FIVqo36ukwNfN/sMuGS7iCmL4JqnPuUZM1UACWHhqHanx5fkMWvpiXXSQ4kkctIhMkp3upMGWfnq+G9LRONd9i0+1V+mOuckApnpdh/WfDNBDtgZh8EeCiJ4C7LLC4Gw/IaPxA2ffujDeguq+3L1wu/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912865; c=relaxed/simple;
	bh=Fmy27Bnmn3Uj8FkD7cvCCt580n5f2IKg/FvXHV0a6+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM/5z4wD2iHd6y68i92NqZTn4R4pHugKjnnT9lFYyhHjyI0Wuh6/yzctXG/Jxpl0SKjq6tCUt6ierNBMMxLbxCWDdqQBW+DTHu6uvfNcSU/8dIVlguD10I7RAzpWVUuZkv/fio16ohovyHEgr2wnGf3x+ad2L0Vw6hoZ1Ug8gHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=I+pq1zuu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso21538062a12.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jan 2025 06:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735912859; x=1736517659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qluG0ViCE8ATiodOgOOl8Lv8eXopMgs1l45mWqKjsY=;
        b=I+pq1zuuau9nyQ6nQUz8NVH2lctcF/cobeGYcUVXMH5KZ2LPxvOj5WsZLbuX6dTkfr
         ErKG3RQ8whc/OuOusIJrRX3f6IzlBAo6zXAfGQK07foxC1G4VzeGunXjDEFNH1WtMAyu
         3LuhoEaOWbbkOLJVxHj27UBtFAqj7z0RsuH11S2UNqWiivYXkqUYdqrUFoBTQUKarSVR
         BB9pppsbgj8FGYQhpkjSSOtZyMRWwhxHA2bgVdv5IPCDFUqckN6jsNvvmU7PB8883krO
         fODycMsFCBwwzbyE4KmC9jk8cQaiJKWb4LhrMKzrF8OcipEULCjXF0JEsE0j3Uap88ee
         XQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912859; x=1736517659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qluG0ViCE8ATiodOgOOl8Lv8eXopMgs1l45mWqKjsY=;
        b=kTAoDUl9RuY1APg+TNkQOnnlW8x95Xxetqw5xmg6ipmyA6IW/s37LBVuGd3EJWMIOv
         nFX7VbwCyLng2xIb8hGTU7saz1Yv7DmALsky0C4rVKA4m1VqokqZ92QkCm0coziWRlAx
         UvHHQfUojKwjmcdXRmuC8H2MjOqTXRRl9RLsVM2tMQnjIDIZTjyYkq3M2PuJp59H9J3f
         GkOIrSSlxYooC0/za3hSgNyQROs97R8KcR9maxszHZYxI/Yumns6twgiGQ2mfXeVwwxO
         fn85t0gP9oiIAN+7shAEZPQvkPxz5btoAk2DRFy+dlj1DTQ7XqNtlmaZ5haR83gaJdFe
         slsw==
X-Gm-Message-State: AOJu0YwwtaB7PVZ2iY5qVGm7goboa4QwDN/iJNtizchqpzma5HLP2c1S
	1JdVuDMm1zcmBEzzfm2ORUu/8WgwPKbKJ+XbELzctTfebTA/FeYTbI6TswUHf0gRUvab3pBnBB/
	5
X-Gm-Gg: ASbGnctanoeQxyowAxlYKjtOp4FyMy9AyR/qzGnVfjghzxKp7i5duljSPv80AfPMAuk
	RDDIXH1yJYP02XSwgi3dmifqQvZ8adU1qLJCfxixZV4E6QN4rjcPP+crCl8HV0E+IcTGctRQ8uk
	T2uuC8Z7zpmyUpuzt+fFUJUU+B9UAcyOueq0EnCUgVELATrqWI5YoghiWd3AsIuagj7sp0OB7+y
	BLtjg3X19felWpKOFy5V+vJCtAjcUvXqF8FwJfjSN+vimbS/hGb8111mBQqdo5QL8u4ZQGMTJmy
	KPJRwjMD2+s=
X-Google-Smtp-Source: AGHT+IG1Xlx6lYKDq/Jh3aaztieX8SW5bSS3JbGGOUo0jKzSzCn1vGsHxn6qMMerERmHlKGSZGu+PA==
X-Received: by 2002:a05:6402:2346:b0:5d8:17da:dcf0 with SMTP id 4fb4d7f45d1cf-5d81e523027mr36220171a12.4.1735912859111;
        Fri, 03 Jan 2025 06:00:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f0e4sm19502384a12.42.2025.01.03.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 06:00:57 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	ulf.hansson@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/2] iio: adc: rzg2l: Cleanup suspend/resume path
Date: Fri,  3 Jan 2025 16:00:42 +0200
Message-ID: <20250103140042.1619703-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index f12f3daf08cc..8289b872b165 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -88,7 +88,6 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
-	bool was_rpm_active;
 };
 
 /**
@@ -563,14 +562,9 @@ static int rzg2l_adc_suspend(struct device *dev)
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
@@ -579,9 +573,7 @@ static int rzg2l_adc_suspend(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active)
-		pm_runtime_force_resume(dev);
-
+	pm_runtime_force_resume(dev);
 	return ret;
 }
 
@@ -599,11 +591,9 @@ static int rzg2l_adc_resume(struct device *dev)
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
@@ -612,10 +602,7 @@ static int rzg2l_adc_resume(struct device *dev)
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


