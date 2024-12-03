Return-Path: <linux-iio+bounces-13009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55C9E1A83
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DEA166817
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD11E47DC;
	Tue,  3 Dec 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OjDrWbkg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B91E3DF8
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224420; cv=none; b=PyF1n5GoDFwZiIZ1TXUXXQaA9dEIkJB8IMUQj94c3wg7NScs2nFD7m2kWdS4UUBzKyXGJzysLAhhPnXj6jVmmQ/7inCw3jtQJ5hhlZk3/+YKEF2xA67qvEZGlQ1Lw+Pcg+J1U5zrOzcTNe39wUIdXhz9v++zDBAKJ1O5glBmU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224420; c=relaxed/simple;
	bh=kBpmpcLbsXFGXe3UmBXplOGwMMgg51mcXkZvmc6/gLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Az7K6OODAvlfU8YHa9x7/2iyAC4hhcXpQaQE606gxTYU6yU7vgxvg8qaGCMR3/zVgqvodQfSIOhu9lv0Gy9kAMR1zKOW55I/hhkSJSBDwIQM+zSNDj0dWLMTrWzV4W3EP2ejDh9hvo97Eiw11oLxPKRdexvRofAq82Dtcg9Euyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OjDrWbkg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ed7f6605so1361958f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224417; x=1733829217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCdRwZ15asQpEWGBGdVbcDEbuZKZAPYkAztgT8carm4=;
        b=OjDrWbkglJnlbnbDvew4aYjatMVBQCQrNalegnLg0iETy9KquqwrMI51GKzNnhSKv8
         mUuiGAvKTKk3EOTqJHZuqLiToZS1UfOxV2R0aKjDbpFZWofsgkttjMOQ9D5K3YmOPFGE
         FNpalWHCJv2UctmBvkwCcv+C4hkBk0ifd3mAmMu0HvM8xX1CK4H07wdGkcCiIj8tL2lI
         5FCKJGddkxJPvLhU3AJ5w3M1oPDfnLNOx2itaKvkgcKfbNN6hJSquu8mAaJtv9tXS+xG
         2U4poCmjcE0lsGm6VuYqjjmtr/J6D360b/ulSnn/ISl+JuY+SdJfNLcVfYDF2myExygx
         0ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224417; x=1733829217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCdRwZ15asQpEWGBGdVbcDEbuZKZAPYkAztgT8carm4=;
        b=tVeBeWyUYpazzZPOEHsLahaAdWiCcAkLAq0+JcUBGzxOO4iwfcFzu2xrE9IsKePLat
         lkWsZWOTQq6UEsCOaKGjUd+dCCihAeduMkzZdAu1KZ2iVkrT3lOlQFbPQH/sYowFXFmn
         zhl+IgqiwVOV2M59CisEQRF48kQ+6MMv3gOULfVnhhTquwmAI5ODiDWe3MOCYldLIMV1
         OE49AbGbXwrVAy1zIjFhBCPV6iV90qa8OJjs+7DlE68K6gLtzCAFvQxc/KSYsK/yNScW
         5iyB7DiEw7tOZSmUX8gOdyfoooe281Ni40hCRRky+60+zSHoL99fcc0Qft9Wn6Vn/aqS
         SOcA==
X-Forwarded-Encrypted: i=1; AJvYcCVky6daW3lCDiBM5EpwPRb5oKNj5fJOaBPSLuX+7sqSppXPOOpypqCACFA+wMACYN9AyxVtJ3+9gk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7GKJPRLJXCNC6tI/let2BawMqhHglgdQCPCfsNIMQqWCGPSy
	PQVX97/lNA4OQzZLpvDbcQEQolieWvInvW5Y5SVL27T67pvLoEtlVww4O0hEhiQ=
X-Gm-Gg: ASbGncty0znYg/HiHeVFsOl4PowTzYO7o2+BFQRCE6mroU7+db2ulBZVPHXMDpWje4w
	eh87XvgjpCO91ejWJrGadDMjs58XFbCXMeD8LeTk+t6lsDlfTCZhwX7N0YXsS39KVsfyoF3Vx5e
	EzCgv4WcUPxmNt+LJav8gz+uFKlg0WDLDw4r9kyM7MDltlLkmfk4fBje55fTwSYg+BAYCvmSGPh
	qrmupeJh7DO/x7xksMOYQNmXHAS2/pICpicJPst4RqqDc/WZyVABsjjLVJXLERLko7GbCwUsOAo
	Oe9f
X-Google-Smtp-Source: AGHT+IEJrW8VqyFtyApubzrpsWUPJ9RNDeZrlqESW1F89PjKceyNMo6DqT1d4/sGwkbfkKpWXv02Sw==
X-Received: by 2002:a5d:588f:0:b0:385:ef2f:9282 with SMTP id ffacd0b85a97d-385fd3ce082mr1856119f8f.5.1733224417034;
        Tue, 03 Dec 2024 03:13:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 04/14] iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
Date: Tue,  3 Dec 2024 13:13:04 +0200
Message-Id: <20241203111314.2420473-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The use of SET_RUNTIME_PM_OPS() is now deprecated and requires
__maybe_unused annotations to avoid warnings about unused functions.
Switching to RUNTIME_PM_OPS() and pm_ptr() eliminates the need for such
annotations because the compiler can directly reference the runtime PM
functions, thereby suppressing the warnings. As a result, the
__maybe_unused markings can be removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index a17690ecbdc3..5437b21c4e70 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -462,7 +462,7 @@ static const struct of_device_id rzg2l_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
 
-static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
+static int rzg2l_adc_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -472,7 +472,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
+static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -483,9 +483,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
-			   rzg2l_adc_pm_runtime_resume,
-			   NULL)
+	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime_resume, NULL)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
@@ -493,7 +491,7 @@ static struct platform_driver rzg2l_adc_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-		.pm		= &rzg2l_adc_pm_ops,
+		.pm		= pm_ptr(&rzg2l_adc_pm_ops),
 	},
 };
 
-- 
2.39.2


