Return-Path: <linux-iio+bounces-17246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02557A6DA17
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 13:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AC216EA30
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED825EF9B;
	Mon, 24 Mar 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OTVh+lHc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCC25E82A
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819205; cv=none; b=QF0XJWcDj2Z7+wGeen4qgY2aAe3TpH2RpnLyPVhe0XZ3yK1Fz7MOK3nd1044O9IQMS//48a0I/0408e7bBFQzvj5N0arPo6t+sYLk64WY3f3R3XlI5Z5DXRTNyhKDAi6j/l3KdDLPfSnSENNoC1UTDaQLHrXU2OPEPbRbT/cTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819205; c=relaxed/simple;
	bh=7H04Zj9dfcpDfaqboI+ReMx9thHZjBGdzhXtznFfaIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4EhQUDNXu6QXT/6UopLBiMHxlUAgQsJaKVz0E+saSGiR2Tj5yFMA/DexSjTY7pzDc6iIHBfpJ8wl8prppbXZ56ACvA7TUKT/At8vpN7qBwucUwMmlJPQR69L+w3VLDdfgYqBBqzqqf0L45qq5UhK3Ms7KXGKP8sQX8XLCvJp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OTVh+lHc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso31634715e9.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742819202; x=1743424002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tinDb82Hg/cL/rLLrkoOUK4oALU+HSZjNBXFVyGDLBE=;
        b=OTVh+lHcQATxUxUI5ISBqTaZPqB7EgrG82ShJMyClLMjRCBbrxxIyNZiN0YeD1cpoo
         QgpwtvtSTO/HYDzle12auuRsE67tBHXYegO2m955cYsKc3RR12IdkShy4RlkIZsLe9Vh
         r/7MsrCioOYWFaeHbPAqMLUDnZb/DRPTmxcX1UoRWuM7O+Qd2+cfETTEe2fAcX/4l24t
         ydiEotGd1TnciKnOe/++cW2oTp14kMpe2/121g39x5DVfIxiRK3mFT+ZC1/00UR7j9PO
         8Flzx/8gxTjY9zBIv72v6vcxai+McvdW0rENc5/DUtXM+3xELQSal8OlUZdyCIizoO66
         e9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819202; x=1743424002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tinDb82Hg/cL/rLLrkoOUK4oALU+HSZjNBXFVyGDLBE=;
        b=GJ6qRRJV+GSTS+tVD2S+ErrWUfuoD9nyCI/+JMbAwzHREfJmO1YcWryfnw0wsCZQZU
         PKCe4aFQBvyZn0/mjv7h/Uowr1d9tRtmRheYB6LaNO78ow5/epr10cCGy9onYxfM1r5C
         VHivIbELOhSupG6znrZGNwIMCUYyfJu2hTimbb6efIjRudmaf5cpp8IndSofcBwRxFqC
         0s/0N1+15gD0E79gqDbrOHhNdJbD8EWmyJWpoDkCczp3ApSEgEomgk+HKEaQ+jG9G0XK
         GHa7xzJst51RVTt7vFFVtoSwWhj3YCU4dlAE6nIwtXb80Znq8NUPcb0Ko0ipT8FCfuDq
         8WBA==
X-Forwarded-Encrypted: i=1; AJvYcCWXrsFjeP1umTKequBl4oy8vPiHD5d3GuGk8vkumk48CK2yPW4rI7mby0TGcQGiILWVCCc0YuNkyrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxunzNCdeBQjbvz9yV8w85sjArgHvz4XhRNJHDopT0ta96Pvhdr
	NNfEAzuxMNC1HvToMqU6CXTR8pMZTxFw2oFS9xtqlXpuMfsI1j+Z8Gd0rd38778=
X-Gm-Gg: ASbGncuJ/YJr0KzgwuY5uzyL1sTzr1rchRcz5NeMbvbizLA5hW34MoAM8dUxIy3Q7Bg
	VLk7NJ+M941luyUQZkX26yebxkxWzFxQ4oWD4H8+uXKGLLMhdxdnf8LZz+XXyiA7LLyi/UVRfvH
	L3YBDDd40p2rOEGMcpSa0wBS9HkcYSG6T/PrX/5pYb5kKrgAHLzbpcCj9arbE0uXYwXPbOEVtY7
	hPdPDKY9TiMbu5F1DX6bnfKu8x4nQ7dsSPhpmgwCVr1nW9IdLWCwEEoT8B1tJwdL8yd2DU98Xo9
	2NYjAYcdgyOgpbQK7k0AwAk0dBsrTQJdXPmMxL9Id7npmT3U5J674c7U4Uzq3yLyPRwSnGnAo+s
	RV9B9VTiz
X-Google-Smtp-Source: AGHT+IHcSv65sB0v7RWUQm1j0qlh5lCjs9w6YcBrjLtA5IMtXqerZCXxE7wpguWt/oUrGng/6ctEjA==
X-Received: by 2002:a05:600c:8719:b0:43d:53c:1ad6 with SMTP id 5b1f17b1804b1-43d50a4ae7dmr91654135e9.26.1742819202163;
        Mon, 24 Mar 2025 05:26:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm10729080f8f.86.2025.03.24.05.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:26:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 2/2] iio: adc: rzg2l: Cleanup suspend/resume path
Date: Mon, 24 Mar 2025 14:26:27 +0200
Message-ID: <20250324122627.32336-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- collected tags

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 761ba19b83a7..3c96684fff68 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -89,7 +89,6 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
-	bool was_rpm_active;
 };
 
 /**
@@ -584,14 +583,9 @@ static int rzg2l_adc_suspend(struct device *dev)
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
@@ -600,9 +594,7 @@ static int rzg2l_adc_suspend(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active)
-		pm_runtime_force_resume(dev);
-
+	pm_runtime_force_resume(dev);
 	return ret;
 }
 
@@ -620,11 +612,9 @@ static int rzg2l_adc_resume(struct device *dev)
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
@@ -633,10 +623,7 @@ static int rzg2l_adc_resume(struct device *dev)
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


