Return-Path: <linux-iio+bounces-24903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D0BCCC1C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 13:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ED914F2068
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95482F2602;
	Fri, 10 Oct 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ptSE5Hjz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6662EF65C
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095438; cv=none; b=OC00LQnR/xqSUDsJjR/rLq/RwKxxJnfUkBaVsSbT9ers9d+e5r3bTG6wkdL5RGM1+DGIsVHuIA5Q+XsL34ocXJm/lZNE/VaONZGMoEUiPi/bPcfNr2Bm/485kv5l8cj0smYSzEbdA6Py2Hq3LAelzuBulTBWuXqS0dFVk1jYW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095438; c=relaxed/simple;
	bh=aq/4LlBtdDV9fwTGsuaPOpu5GJBcvTjlliJW466UN/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pn7tpZrnbIeBxj6v6P1XSZMJfW6i6TOy8Nd+bdw3GXdDsUtqPNYxI1SdbJyidr3U9o127r1s1oePD2aeKYQH/GO5DXIuBNccizHs+5qtYTzIzWYLhrpuiPGhrDXy/8xHjGoXPBT+YHZJ1QyrxRWZ5BfBAbBONyUyR8zpJEP1oc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ptSE5Hjz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-639e34ffa69so2959013a12.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095434; x=1760700234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbHU47lVJvPoAqNYQLf5z1X0/coxYDZLmDD+Zs19Aq0=;
        b=ptSE5Hjzhl7uTbavQpg6W3FOgMvpAYNLiJOawlMh51IedLTJ2OAYYf6N4oWs6DPoTi
         lsJa5N94AhYwvvu/JqjENZ4Vu5os6cqtcHuH+pqNos9GrNXkriYpK8+m+4ZVHxSBLwiM
         9LI3l8X08GfNwSQbd1MRPnS0heorG1q9wK45OxzahggJMig7etSJA2iAOuVjTSOyyK9g
         AyLBYZZKYo9FdesyyLeskUR0v2060gXg0meG2adAJNZ39i8ghI2Cdzbq/p3gtnjJ2nNJ
         wbqaGyM98qlLbtv6xvnGjSp7mzP2ExrG7wTfLzlCxL2hKtcTwkd8rtHb2q6WVeRhQZE3
         Af4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095434; x=1760700234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbHU47lVJvPoAqNYQLf5z1X0/coxYDZLmDD+Zs19Aq0=;
        b=QMM8yuoARXLH9Em1obsi/xwK3m2AF6c0sdjPs+bPlsU7qu4UXaY5Z6FWCPVqOoy7A7
         u2qY7zAOYKXHgrLOnZps8jSL0cOz36WeGMCxaHC15MXwKNs5ItDsnf/uWIw+6+kkmpFy
         L3Zu+iKF/tv2FGdl0eFSr/w9edQBJ3N6aV3y2tpbKVuFxjOlcbn7j9XsiHbf7AXbYYN6
         5bjd/NMhwuN6NSJsPguQRWF3vLMqzWoqNlEVBB59Lcbxq7MZW6EgewKbtxICI79DKRN0
         EUlDYoPoqYs2NssCjU7l7mIv7zUBT4k0EaQ60P5oRLWrCEWVFz0AqGlycsePLeUquLLn
         3krA==
X-Forwarded-Encrypted: i=1; AJvYcCU6yWkSbu6YRSiVzpmT2PbsQs6zS/rtf87xZQXH0PaQGJftSNVao0cM0RMCFUsa0h4RPHX60ys0SAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKGTl64tKYnoKF7t4WT867p/D3Cv8uX+elGkrYB3tNEp0aKcS
	T3MR1o8PO46vmu1Xf3rkghxWBHSHBnHBUw0TAlrjRAXB/u4nY0GKQ36j2n87xBLsi6g=
X-Gm-Gg: ASbGncuN+yJjcW+OHrGg8heBUboA/N7qRPfo6Mv8t2vc3tSEfcWGn3Af9XCM2Zgtf3o
	Ijwh0Fm2wq2m/gjn0o8nOxp0XzUl62P5K7X0WsjEtSQRinOq+bD7lg4v0tf4w9vwRy/XSyq2qa+
	2IEJhDiTGwDpSNrCV8G4ZiHzjudyeveVJBSkfaoBdek4Srb7DZTjKv4878Z+KgWVRsKcmZe3YDW
	5TOVmGQQTJ8miuga4F599ovm6D66b31f6EhIrqToX97r5Ex7noCupIQh+8sxjJagcKClpvoNqCi
	BUBL6sH9qZIAdebQPq83YxVEo8FgnKqvsJNIgjUucLZSN0AGmLgoI6xABLXEzqj03+lMKPaQV5j
	osde564QCPIK2fGWfGmaky4PAtF2wZq5NkBcbyN7AXiL5UgRCvlNEWU+DCBz6cH37LcNYsBthvL
	4tl/ytryChx92Gq8gtA+g=
X-Google-Smtp-Source: AGHT+IEGGOcXMfbfok1PgzreNouwnXwnOxKHke/yHbjyLVTMxF0ZeD3AzIE5Lo/WXZ+3jpLEgrXUlQ==
X-Received: by 2002:a17:907:7f0e:b0:b48:44bc:44f2 with SMTP id a640c23a62f3a-b50ac8e52b0mr1079525366b.43.1760095433928;
        Fri, 10 Oct 2025 04:23:53 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:53 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Oct 2025 13:22:02 +0200
Subject: [PATCH RFC 4/6] thermal/drivers/generic-adc: Allow probe without
 TZ registration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-bat-temp-adc-v1-4-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=1291;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aq/4LlBtdDV9fwTGsuaPOpu5GJBcvTjlliJW466UN/o=;
 b=g8H90MmiVQbUf34k7FO9FschEuUpZ8+riafTdgCUcqiIfMwO8Gl+ddsWuyUlJKZ5GMtv0OT0Y
 CC07fjXLbWRAMXyYnitoWqrLXpblN5+yM5fIh5ZBkqstAtSmldwJ1G7
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

If the devicetree node is not referenced in a zone under /thermal-zones,
devm_thermal_of_zone_register will fail with -ENODEV.

Since the driver is now also registering as an IIO device, allow the
probe to continue without the thermal zone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 14aef682e0fb..d31533927be6 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -183,14 +183,14 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
-		return ret;
-	}
+		if (ret == -EPROBE_DEFER)
+			return ret;
 
-	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+		dev_info(dev, "Thermal zone sensor register failed: %d\n",
+			 ret);
+	} else {
+		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+	}
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)

-- 
2.51.0


