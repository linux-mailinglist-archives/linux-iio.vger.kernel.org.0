Return-Path: <linux-iio+bounces-8490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6946952E01
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48008B24069
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1D198E78;
	Thu, 15 Aug 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZEmvrITb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1F17BEAA
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723932; cv=none; b=skh5p1IQZoENiXu5NYI4ln1yF9ljXZ+pouVGVFCCfirD0PCcyUGTY0J7D803j+wwioIBYAYpWm4uYCZt1j9ROozHLGJFahPl4O5202WnhJdhdonoEviRUGQC5Y5SB9+xCLsv+5wJmchAbhqp6V24S99tG4rbMP8Rk2Hl/mBl+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723932; c=relaxed/simple;
	bh=B299RubzcyeAZYqSINS1JMw78PJqVT8lqVWbm+KhLHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjSCLHn3vpLr/yT8LeeVYYEkHOXwl7n6GOEpB2/TaTPe6ntyIdwbCedn9askS+3M4bvBJOFiJjqYAxvN/NNtritWEBQJ9iGC/lnLHYthMVrOI0U8E5I0PX4wnX3MbCf1NJ3mWsWuqKrjeU1EumTNt92yiS+2kZZPMCiOIygr4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZEmvrITb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso4232425e9.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723927; x=1724328727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIfifid+gNmxqdjRD2+a9HhTRK2zF1nl/3in+BtGhPo=;
        b=ZEmvrITbVbmkcj5jQFb/DuAQwP1GSlJcJyhT1Fo9l4OWrmQsUIA0CmstuSK+C4nn4e
         +maA6XI7ioCWHKIng9ypRFOTs3scA6NFtiQEyI0EVF/cRoVxaRzgbBgVrcw7DaDS4jN9
         WakjrUmtwTS8NC/it8wu2LI5mD6OYwLVtNNV9mevmY9sbrKhxARZU1EjahEuGFluMbKP
         t6xqHFCqUiReiLzDXOvfTLOAgXmoXEw7VRRKggIhGkJQ0M7UJi2vTLSwXXcIgjy9H1Dl
         yvxRVv7Qex+W37iTWCuWu/PAxmZ4FdoU3dM5U1nGsNAkckTVLbK/UAMsFRPzqvdsRB1+
         Zz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723927; x=1724328727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIfifid+gNmxqdjRD2+a9HhTRK2zF1nl/3in+BtGhPo=;
        b=P1fWmmOadT8u+85Kt/+suDLRZ49NiN9F2KpJQ65cZC9GQ0zsWanEW99WET6Eazjs63
         uGTWZtEFKnennoxtdo5qYVFwyjwSOd2cIggrymeeg4pRJB75TBV44RFe8v9osDZdj6OS
         dHwRF25QxfqvnsAwLGEimIejCXHFLJnFzSFNTnmm43L/GYJD/5h69CvexkJqtgIAc3Xm
         GiRGiDt0oe13QtzOuGXqHFqq14N1KHLj2gy8FzP1PEIQUdKPbo5zWTWyp2yG+nv9HUVI
         2DZzKMtvSGk+yvgveAbBSFEL4xCatdeBaVrdqunQfbYydkkO9RpnJT2YdylwkiXJYnhI
         htbA==
X-Forwarded-Encrypted: i=1; AJvYcCUWhSvr1HYyHGZVHuBMurP6haNx0dvgRf5lIVNiDGF+8pWMferfYd2afbYNNk+/wN1crKOnz20XNpc2aFhTwWxXdaGMyoP41iNG
X-Gm-Message-State: AOJu0YwMU9Bk4YSoPfVgXyEu0+Jb9oyRYUcdGlap7a9fuZeCEAHMvPWO
	rNPdFndpZBFxdO4NLzc+A7zJO89wguHcMS6urFbCBwHD0LZP/j9q4dBIehFbiWtMieh3worii8r
	X
X-Google-Smtp-Source: AGHT+IEuybZDakhKeQ5LH52V3RpeDuVw/uxz9FrF2X2Ngvg5W3lc4Fx9NnyZt1280p66tj9dqkB9jg==
X-Received: by 2002:a05:600c:348b:b0:424:8be4:f2c with SMTP id 5b1f17b1804b1-429e231f76dmr18552725e9.2.1723723927027;
        Thu, 15 Aug 2024 05:12:07 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:06 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 15 Aug 2024 12:11:58 +0000
Subject: [PATCH 4/8] pwm: Export pwm_get_state_hw
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-4-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=1631;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=B299RubzcyeAZYqSINS1JMw78PJqVT8lqVWbm+KhLHQ=;
 b=R0SYVR5ABChT/agrkOGtqE560UOP8iseJdjHPPNT794iaKR5TkwlROnIsf6vbGNXL+qEbca08
 3vR+WhJM5zGB++xcBB8es5v4vgNmrPQDw8zW1fS8VOXM6g+CfvJksiB
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This function can be used in some other drivers, for instance when we
want to retrieve the real frequency vs the one that was asked.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/pwm/core.c  | 3 ++-
 include/linux/pwm.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 21fca27bb8a3..82e05ed88310 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -651,7 +651,7 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 }
 EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
-static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
+int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 {
 	struct pwm_chip *chip = pwm->chip;
 	const struct pwm_ops *ops = chip->ops;
@@ -685,6 +685,7 @@ static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pwm_get_state_hw);
 
 /**
  * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index fd100c27f109..d48ea3051e28 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -369,6 +369,7 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
+int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state);
 /**
  * pwm_config() - change a PWM device configuration
  * @pwm: PWM device

-- 
2.34.1


