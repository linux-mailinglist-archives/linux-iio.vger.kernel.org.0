Return-Path: <linux-iio+bounces-16001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF7A41E90
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 13:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589B2188F38C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292A24EF6C;
	Mon, 24 Feb 2025 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QI8gFbgB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD05245025
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398785; cv=none; b=LLPTO1iRvQmB8QEgyZtpNFm6yklKkfzJ9/b92c4grYEKyHVv9nb3tBE08Suko3VWw7kXnmWUM7/IID4up9pVPG3ZvH6AnakuVfjh7ORSuMmvolI0OKl6QvU4cvCb7EZ2wDrkuho2O2eQqlOFtiOPurHQyDk6l/H3QQHgDMvJApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398785; c=relaxed/simple;
	bh=/OXCCaiMIfBgjpPO5dyE52LobwDitgatoc1I5sb44Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AblUjgznsJVVgR1jvWtVWZMNOz9ceoOrfzh7447omKnRKzMhs/l6sB92OxY5b4R8rFGyuNreKpYBSKlJmnWuht7Nuh9/gCsnuiwotfc1INE+qer20EWiEjhPKptqt9SyOvPuDAuHTK37fwZKAOCdalr+PU+MdnOHeHqfB17HsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QI8gFbgB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb892fe379so686625766b.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740398780; x=1741003580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn8DuFDyF+SFBNU3jtJDhoU8b7Q3rosoyNz7MlbxIOg=;
        b=QI8gFbgBFtFuFspJ89KWBVsXxpeilFqMG83TBQWwKEeM6TXEP4kU7+/i9jSnRGVWZk
         I4fnKP1VaGfeTIUp4IzOx4iz6zKLH13XXr9rQosf3doqjKXbnF73Rn9BTtVEXKclV7/1
         BDGdRBLCKIRA56Owzz+CXJfDTlr0zYH/CmB3KLiXxECK6ahdFyIDx8Qik7nlWM7bR5PE
         ewU/F5FjfbnMAUht9tqSQ24nOGZ1XIv0yLTJW/qvDvSNabrpE++X9UrTbEqzD5O7wkjT
         Gse70GVBOhZpSEC9Ez9meMqn3tOclDbu6eaJqbG/gRhOZkKCXKWOVFPWYH7q8Kjik5O1
         b0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398780; x=1741003580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn8DuFDyF+SFBNU3jtJDhoU8b7Q3rosoyNz7MlbxIOg=;
        b=vcpLoCKIiLmLHIQuuvoMrq6y16Qm2MX8H0rElHBkMpIuQHhuMPR0qCSI8oXqdTZgte
         1vMMaGUffIL07Y4VcKPpuRpkb6pd/LxtuzJDxB59iZpdWdm/zE4P6zSaKNCHl87l7XSv
         lJLIs5/q84A5oPZIFcwOZ9BuyEHN/cRhtVlr8gJgn03PlHbJ+ApppwFZOrndZHIyrHy8
         b3Gv4lxQl94z7mSifTP9aXScgb8A+xIoD35Y3/wOw4hgp7vmBjN1TjoEDIsePYmZRR/P
         W9C5pLzsimztymw3CJDzew/RljlDUJs1CWcVOUmiuOoxqLmOInMpL/DdDclJsy5m63PL
         niTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVGHt59972K+HOsPbN9NkuV9D44AtPYMEbDhfXbshLJ7V9IDhqje+z8ltS0RoxOVqRniIAn6MLtdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76vIzGmmy6RCT5d+pTAjSvlaRvH5BA0TTXlPoed7JI2rhUflB
	eMSYz7hOwlu9TfnqyJoYBJR4fDSCD70zJnl3YqpjZvlQOR8NQTi+DVBdv+KrGrk=
X-Gm-Gg: ASbGncuSaDiuzWAC679uczxsHIRsAYrQ71VBQm4emHH21zxFXqyNZ0ZhhudPCp4Rc2k
	eclXHi47eKn0vowD5LFtqq4wR/xMnx6cAqKUvXhai0yCkWQVRpbpF4PE0lWL+VU7+F1ykT1Wdsr
	werF3wG5TmvT0gsJFR9Tqv5CUCJib+io6lyUVlqQdUtXEVzoX1fD+6MsValQo2kmIoz0v/unof+
	7HbPFgT7YLyh+rl9QkTzPTQcspPsZPK37SZwDzr8ZGbpcsdByGB+NLBS+3RN2zzI1KlaqQkpJD2
	/pQAl0tWbNhwsFs92Gn7orMLkXV0Pj/haaoI8K7EIBXn62ZgcrdTKNw=
X-Google-Smtp-Source: AGHT+IF6ufEEXBnwaT978L4U9guhAhq/s+ersstnwG6QXXp3lNvszxpsm0hovWS4qA+ZCTAtcjWuLQ==
X-Received: by 2002:a05:6402:3585:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5e0b71124e6mr34011616a12.17.1740398780418;
        Mon, 24 Feb 2025 04:06:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb978e2c9dsm1598901966b.65.2025.02.24.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:06:19 -0800 (PST)
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
Subject: [PATCH v3 2/2] iio: adc: rzg2l: Cleanup suspend/resume path
Date: Mon, 24 Feb 2025 14:06:07 +0200
Message-ID: <20250224120608.1769039-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 7db04416e1cf..5236ca0da167 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -89,7 +89,6 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
-	bool was_rpm_active;
 };
 
 /**
@@ -594,14 +593,9 @@ static int rzg2l_adc_suspend(struct device *dev)
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
@@ -610,9 +604,7 @@ static int rzg2l_adc_suspend(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active)
-		pm_runtime_force_resume(dev);
-
+	pm_runtime_force_resume(dev);
 	return ret;
 }
 
@@ -630,11 +622,9 @@ static int rzg2l_adc_resume(struct device *dev)
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
@@ -643,10 +633,7 @@ static int rzg2l_adc_resume(struct device *dev)
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


