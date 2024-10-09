Return-Path: <linux-iio+bounces-10352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21859995F56
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 08:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3191F246A4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE91547D7;
	Wed,  9 Oct 2024 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kk1Ic1nS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B44A3F
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453701; cv=none; b=XhhdHxNux5BZhwRgk4xJtevi13N+m4kPr3dskDkyBbY2DFmRcAjsGrVjn8ee8b9UOacxkGvGymh3XkWTKk7M9jbRbE0QLS8zFVHI0CIJn6aEaSiPE3F7iyUIiMnwVJ7ucFCajGMek5EvsSaT2Z0wjSTgDDWV2K2SzV0O6cZ0tCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453701; c=relaxed/simple;
	bh=6mk6O3igkfsrU5QVeJnrB2V+eznoxn1JPEn25RwkmHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H08s1DG8Co8idn6AxNxJ52t/ZA53k8h2R+dGgv1ANOKjl+Q2knHe9Dr8ytY6Jf67W+H+maNehn+MJTxK0ktMcrVHJpHw2QUqKpOUu/ukIoy22PR0ZVRTXf2kBBkNaxlIcCJ/fag32ah1idsvsbZBEU3nTmem8msxIGV+JU64HEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kk1Ic1nS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a843bef98so852095666b.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2024 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728453695; x=1729058495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fex4ZeTIqjRcvGHtpPyRiVgWrZLRqGRPMncxWSpfg5o=;
        b=Kk1Ic1nSw49gGm69FGyAdXJKjyZrwFGNETAEsFwaPis9In8HlYdGIFFksqRg+JXcFa
         jqkJ22XO5Lhg6VdD5WA0i4SZye4S4R7Zu9Ifw4RJGyPy5mQsALjtW9MLo9GgUhGylcEa
         FefhhTNTkRF+TF7cXm1BIUSH3ilDhd4s/+5HLQtqkmgVPm9OCXqo4jgWFuOvOg2k323C
         desYikXmAonKTIU82PLqviN2HtpOnFAmiXxyt00izLISc8QkgMy98wO8Ae0ol7MYzyBC
         fryhwT9BBsA6hISoD0b/vvLCiZBObL7oolboemQcD3srjqi7vL95ixqSRCaMCTWG26TL
         /bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728453695; x=1729058495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fex4ZeTIqjRcvGHtpPyRiVgWrZLRqGRPMncxWSpfg5o=;
        b=qq3KVsT6U/H0TmcS79KIHVATo9UjPxOebHAUGbzO04sLy7o0OtITSbBGQZ6Ks1klcD
         TBdHZdQfoI0JF22hEgnrRRlleMrWd++JNPh6axHkbEfe4m/cllfi6XlRTqEHlYmzadQC
         VCmdv7Jx+1QUgCNZinVyO5/vb2JawPPAR77mYTZKEREky37q9DGw2w1j3eglEUtDeZeM
         JJkLMYkA0H5UwHqvm5OHOPrzmrZ0qyhkWHbqRDRAeMCQnWfaLYnvvR26d0DGTp56gUkl
         uzQtiY0piTPev2MnsngJ2SSn4itMR8Dct5Gz0LioC9Mg3UYiyRs9Q3moqXoKeGjUkM08
         qM3w==
X-Forwarded-Encrypted: i=1; AJvYcCUJpblCX+PmcM5RectnBncZ5qR2mEHk0s5HmyX5KVVkzWzXDU/SBJhvidWHmD91zbPghyY7D6Iow/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2Ik/XXGfxRx1cKn+iGkCSyvinVNYILR8wsOPC+6Pp1KN2+a4
	b3gmHguD6uRRfbJLhaVFjOupwBGD0scSi5B7CuFgLNu8BGcYZ03femlh/ZIbntzjOW3B9sC40U0
	H
X-Google-Smtp-Source: AGHT+IHE6r1tGkDhu2EWjbbIfGtXB1A4culngx2Zl+craYtnOC9q+B3m0DT/OFQmnZ0MLEVEmAyeGw==
X-Received: by 2002:a17:907:94c5:b0:a99:7925:77db with SMTP id a640c23a62f3a-a998cf3b073mr127547566b.0.1728453694569;
        Tue, 08 Oct 2024 23:01:34 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:237:4916:fbc:5673])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994a1464a1sm458784566b.106.2024.10.08.23.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 23:01:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: Switch back to struct platform_driver::remove()
Date: Wed,  9 Oct 2024 08:00:57 +0200
Message-ID: <20241009060056.502059-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=28760; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=6mk6O3igkfsrU5QVeJnrB2V+eznoxn1JPEn25RwkmHM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnBhwZxHngB30rFC976UQWrYoj8BXvYmPBwq6Sr 2UFsSi1vnaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZwYcGQAKCRCPgPtYfRL+ TnDHCACKI4AZj9enz4zn/qwsYFgkW/GGGGq8jAoGTft65AldRGup5vBvShK4f0QmWpmez0UlFqK oCvFsk1LFe6BpKROY2ryZjvIVH2Kg46zxvJgnCDbgBmIn1k8zlq1n942Yo0fIxhkdUWA0gCGv1o pzzOyOQS0WYlgIhWondPNFoOl7NFzxrmZ6WAJ9u2+JWbkzzRm7sK+bf8DOS2ppGfS2qMx+5Qrb3 eQT02aFJtH1DCXjAVEsdNq0xl++0r48D5ih+UjMgq5kroTrJd+JLjCUk6SooLjmqkP1c4+jqxK7 bGHfJCsWTqO2Rcyt+KOvasF/gEJ+hBwQN2n//ctqCemoOF0E
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/iio/ to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

While touching these files, make indention of the struct initializer
consistent in several files.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on yesterdays's next, feel free to drop changes that result
in a conflict when you come around to apply this. I'll care for the
fallout at a later time then. (Having said that, if you use b4 am -3 and
git am -3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/iio/accel/hid-sensor-accel-3d.c              | 2 +-
 drivers/iio/adc/ab8500-gpadc.c                       | 2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                   | 2 +-
 drivers/iio/adc/at91_adc.c                           | 2 +-
 drivers/iio/adc/axp20x_adc.c                         | 2 +-
 drivers/iio/adc/bcm_iproc_adc.c                      | 8 ++++----
 drivers/iio/adc/dln2-adc.c                           | 2 +-
 drivers/iio/adc/ep93xx_adc.c                         | 2 +-
 drivers/iio/adc/exynos_adc.c                         | 2 +-
 drivers/iio/adc/imx8qxp-adc.c                        | 2 +-
 drivers/iio/adc/imx93_adc.c                          | 2 +-
 drivers/iio/adc/meson_saradc.c                       | 2 +-
 drivers/iio/adc/mp2629_adc.c                         | 2 +-
 drivers/iio/adc/mxs-lradc-adc.c                      | 6 +++---
 drivers/iio/adc/npcm_adc.c                           | 2 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                  | 2 +-
 drivers/iio/adc/rcar-gyroadc.c                       | 2 +-
 drivers/iio/adc/stm32-adc-core.c                     | 2 +-
 drivers/iio/adc/stm32-adc.c                          | 2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                    | 2 +-
 drivers/iio/adc/stm32-dfsdm-core.c                   | 2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                    | 2 +-
 drivers/iio/adc/ti_am335x_adc.c                      | 8 ++++----
 drivers/iio/adc/twl4030-madc.c                       | 2 +-
 drivers/iio/adc/twl6030-gpadc.c                      | 2 +-
 drivers/iio/adc/vf610_adc.c                          | 2 +-
 drivers/iio/dac/dpot-dac.c                           | 2 +-
 drivers/iio/dac/lpc18xx_dac.c                        | 6 +++---
 drivers/iio/dac/stm32-dac-core.c                     | 2 +-
 drivers/iio/dac/stm32-dac.c                          | 2 +-
 drivers/iio/dac/vf610_dac.c                          | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
 drivers/iio/humidity/hid-sensor-humidity.c           | 2 +-
 drivers/iio/light/cm3605.c                           | 2 +-
 drivers/iio/light/hid-sensor-als.c                   | 2 +-
 drivers/iio/light/hid-sensor-prox.c                  | 2 +-
 drivers/iio/light/lm3533-als.c                       | 2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 2 +-
 drivers/iio/orientation/hid-sensor-rotation.c        | 2 +-
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 drivers/iio/pressure/hid-sensor-press.c              | 2 +-
 drivers/iio/proximity/cros_ec_mkbp_proximity.c       | 2 +-
 drivers/iio/proximity/srf04.c                        | 2 +-
 drivers/iio/temperature/hid-sensor-temperature.c     | 2 +-
 drivers/iio/trigger/iio-trig-interrupt.c             | 2 +-
 drivers/iio/trigger/stm32-timer-trigger.c            | 2 +-
 47 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2d5fa3a5d3be..26b1033799fe 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -451,7 +451,7 @@ static struct platform_driver hid_accel_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_accel_3d_probe,
-	.remove_new	= hid_accel_3d_remove,
+	.remove		= hid_accel_3d_remove,
 };
 module_platform_driver(hid_accel_3d_platform_driver);
 
diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 59f66e9cb0e8..f3b057f92310 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1194,7 +1194,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_pm_ops,
 
 static struct platform_driver ab8500_gpadc_driver = {
 	.probe = ab8500_gpadc_probe,
-	.remove_new = ab8500_gpadc_remove,
+	.remove = ab8500_gpadc_remove,
 	.driver = {
 		.name = "ab8500-gpadc",
 		.pm = pm_ptr(&ab8500_gpadc_pm_ops),
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index d7fd21e7c6e2..8e5aaf15a921 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2625,7 +2625,7 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_match);
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-	.remove_new = at91_adc_remove,
+	.remove = at91_adc_remove,
 	.driver = {
 		.name = "at91-sama5d2_adc",
 		.of_match_table = at91_adc_dt_match,
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9c39acff17e6..a3f0a2321666 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1341,7 +1341,7 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-	.remove_new = at91_adc_remove,
+	.remove = at91_adc_remove,
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 7f052af56afa..9fd7027623d0 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -1182,7 +1182,7 @@ static struct platform_driver axp20x_adc_driver = {
 	},
 	.id_table = axp20x_adc_id_match,
 	.probe = axp20x_probe,
-	.remove_new = axp20x_remove,
+	.remove = axp20x_remove,
 };
 
 module_platform_driver(axp20x_adc_driver);
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index cdfe304eaa20..f258668b0dc7 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -611,10 +611,10 @@ static const struct of_device_id iproc_adc_of_match[] = {
 MODULE_DEVICE_TABLE(of, iproc_adc_of_match);
 
 static struct platform_driver iproc_adc_driver = {
-	.probe  = iproc_adc_probe,
-	.remove_new = iproc_adc_remove,
-	.driver	= {
-		.name	= "iproc-static-adc",
+	.probe = iproc_adc_probe,
+	.remove = iproc_adc_remove,
+	.driver = {
+		.name = "iproc-static-adc",
 		.of_match_table = iproc_adc_of_match,
 	},
 };
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index de7252a10047..30328626d9be 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -700,7 +700,7 @@ static void dln2_adc_remove(struct platform_device *pdev)
 static struct platform_driver dln2_adc_driver = {
 	.driver.name	= DLN2_ADC_MOD_NAME,
 	.probe		= dln2_adc_probe,
-	.remove_new	= dln2_adc_remove,
+	.remove		= dln2_adc_remove,
 };
 
 module_platform_driver(dln2_adc_driver);
diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index cc38d5e0608e..a3e9c697e2cb 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -238,7 +238,7 @@ static struct platform_driver ep93xx_adc_driver = {
 		.of_match_table = ep93xx_adc_of_ids,
 	},
 	.probe = ep93xx_adc_probe,
-	.remove_new = ep93xx_adc_remove,
+	.remove = ep93xx_adc_remove,
 };
 module_platform_driver(ep93xx_adc_driver);
 
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 4d00ee8dd14d..4614cf848535 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -1008,7 +1008,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops, exynos_adc_suspend,
 
 static struct platform_driver exynos_adc_driver = {
 	.probe		= exynos_adc_probe,
-	.remove_new	= exynos_adc_remove,
+	.remove		= exynos_adc_remove,
 	.driver		= {
 		.name	= "exynos-adc",
 		.of_match_table = exynos_adc_match,
diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index fe82198170d5..3d19d7d744aa 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -487,7 +487,7 @@ MODULE_DEVICE_TABLE(of, imx8qxp_adc_match);
 
 static struct platform_driver imx8qxp_adc_driver = {
 	.probe		= imx8qxp_adc_probe,
-	.remove_new	= imx8qxp_adc_remove,
+	.remove		= imx8qxp_adc_remove,
 	.driver		= {
 		.name	= ADC_DRIVER_NAME,
 		.of_match_table = imx8qxp_adc_match,
diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 4ccf4819f1f1..002eb19587d6 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -470,7 +470,7 @@ MODULE_DEVICE_TABLE(of, imx93_adc_match);
 
 static struct platform_driver imx93_adc_driver = {
 	.probe		= imx93_adc_probe,
-	.remove_new	= imx93_adc_remove,
+	.remove		= imx93_adc_remove,
 	.driver		= {
 		.name	= IMX93_ADC_DRIVER_NAME,
 		.of_match_table = imx93_adc_match,
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index e16b0e28974e..2d475b43e717 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1483,7 +1483,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(meson_sar_adc_pm_ops,
 
 static struct platform_driver meson_sar_adc_driver = {
 	.probe		= meson_sar_adc_probe,
-	.remove_new	= meson_sar_adc_remove,
+	.remove		= meson_sar_adc_remove,
 	.driver		= {
 		.name	= "meson-saradc",
 		.of_match_table = meson_sar_adc_of_match,
diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 921d3e193752..1cb043b17437 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -195,7 +195,7 @@ static struct platform_driver mp2629_adc_driver = {
 		.of_match_table = mp2629_adc_of_match,
 	},
 	.probe		= mp2629_adc_probe,
-	.remove_new	= mp2629_adc_remove,
+	.remove		= mp2629_adc_remove,
 };
 module_platform_driver(mp2629_adc_driver);
 
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 8c7b64e78dbb..152cbe265e1a 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -819,10 +819,10 @@ static void mxs_lradc_adc_remove(struct platform_device *pdev)
 
 static struct platform_driver mxs_lradc_adc_driver = {
 	.driver = {
-		.name	= "mxs-lradc-adc",
+		.name = "mxs-lradc-adc",
 	},
-	.probe	= mxs_lradc_adc_probe,
-	.remove_new = mxs_lradc_adc_remove,
+	.probe = mxs_lradc_adc_probe,
+	.remove = mxs_lradc_adc_remove,
 };
 module_platform_driver(mxs_lradc_adc_driver);
 
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 3a55465951e7..7c1511ee3a4b 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -337,7 +337,7 @@ static void npcm_adc_remove(struct platform_device *pdev)
 
 static struct platform_driver npcm_adc_driver = {
 	.probe		= npcm_adc_probe,
-	.remove_new	= npcm_adc_remove,
+	.remove		= npcm_adc_remove,
 	.driver		= {
 		.name	= "npcm_adc",
 		.of_match_table = npcm_adc_match,
diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 9e1112f5acc6..debf742baf07 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -1016,7 +1016,7 @@ static struct platform_driver pm8xxx_xoadc_driver = {
 		.of_match_table = pm8xxx_xoadc_id_table,
 	},
 	.probe		= pm8xxx_xoadc_probe,
-	.remove_new	= pm8xxx_xoadc_remove,
+	.remove		= pm8xxx_xoadc_remove,
 };
 module_platform_driver(pm8xxx_xoadc_driver);
 
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 15a21d2860e7..11170b5852d1 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -592,7 +592,7 @@ static const struct dev_pm_ops rcar_gyroadc_pm_ops = {
 
 static struct platform_driver rcar_gyroadc_driver = {
 	.probe          = rcar_gyroadc_probe,
-	.remove_new     = rcar_gyroadc_remove,
+	.remove         = rcar_gyroadc_remove,
 	.driver         = {
 		.name		= DRIVER_NAME,
 		.of_match_table	= rcar_gyroadc_match,
diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 616dd729666a..2201ee9987ae 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -906,7 +906,7 @@ MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
 
 static struct platform_driver stm32_adc_driver = {
 	.probe = stm32_adc_probe,
-	.remove_new = stm32_adc_remove,
+	.remove = stm32_adc_remove,
 	.driver = {
 		.name = "stm32-adc-core",
 		.of_match_table = stm32_adc_of_match,
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 32ca26ed59f7..9d3b23efcc06 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2644,7 +2644,7 @@ MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
 
 static struct platform_driver stm32_adc_driver = {
 	.probe = stm32_adc_probe,
-	.remove_new = stm32_adc_remove,
+	.remove = stm32_adc_remove,
 	.driver = {
 		.name = "stm32-adc",
 		.of_match_table = stm32_adc_of_match,
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 2037f73426d4..c2d4f5339cd4 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1890,7 +1890,7 @@ static struct platform_driver stm32_dfsdm_adc_driver = {
 		.pm = pm_sleep_ptr(&stm32_dfsdm_adc_pm_ops),
 	},
 	.probe = stm32_dfsdm_adc_probe,
-	.remove_new = stm32_dfsdm_adc_remove,
+	.remove = stm32_dfsdm_adc_remove,
 };
 module_platform_driver(stm32_dfsdm_adc_driver);
 
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index bef59fcc0d80..041dc9ebc048 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -506,7 +506,7 @@ static const struct dev_pm_ops stm32_dfsdm_core_pm_ops = {
 
 static struct platform_driver stm32_dfsdm_driver = {
 	.probe = stm32_dfsdm_probe,
-	.remove_new = stm32_dfsdm_core_remove,
+	.remove = stm32_dfsdm_core_remove,
 	.driver = {
 		.name = "stm32-dfsdm",
 		.of_match_table = stm32_dfsdm_of_match,
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 00a3a4db0fe0..8b27458dcd66 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -697,7 +697,7 @@ static struct platform_driver sun4i_gpadc_driver = {
 	},
 	.id_table = sun4i_gpadc_id,
 	.probe = sun4i_gpadc_probe,
-	.remove_new = sun4i_gpadc_remove,
+	.remove = sun4i_gpadc_remove,
 };
 MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_id);
 
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 426e3c9f88a1..95036efb8320 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -740,12 +740,12 @@ MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
 
 static struct platform_driver tiadc_driver = {
 	.driver = {
-		.name   = "TI-am335x-adc",
-		.pm	= pm_sleep_ptr(&tiadc_pm_ops),
+		.name = "TI-am335x-adc",
+		.pm = pm_sleep_ptr(&tiadc_pm_ops),
 		.of_match_table = ti_adc_dt_ids,
 	},
-	.probe	= tiadc_probe,
-	.remove_new = tiadc_remove,
+	.probe = tiadc_probe,
+	.remove = tiadc_remove,
 };
 module_platform_driver(tiadc_driver);
 
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 0253064fadec..072e12b29776 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -914,7 +914,7 @@ MODULE_DEVICE_TABLE(of, twl_madc_of_match);
 
 static struct platform_driver twl4030_madc_driver = {
 	.probe = twl4030_madc_probe,
-	.remove_new = twl4030_madc_remove,
+	.remove = twl4030_madc_remove,
 	.driver = {
 		   .name = "twl4030_madc",
 		   .of_match_table = twl_madc_of_match,
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 6a3db2bce460..ef7430e6877d 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -1003,7 +1003,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
 
 static struct platform_driver twl6030_gpadc_driver = {
 	.probe		= twl6030_gpadc_probe,
-	.remove_new	= twl6030_gpadc_remove,
+	.remove		= twl6030_gpadc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= pm_sleep_ptr(&twl6030_gpadc_pm_ops),
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 5afd2feb8c3d..4d83c12975c5 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -972,7 +972,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-	.remove_new     = vf610_adc_remove,
+	.remove         = vf610_adc_remove,
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 7332064d0852..f36f10bfb6be 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -243,7 +243,7 @@ MODULE_DEVICE_TABLE(of, dpot_dac_match);
 
 static struct platform_driver dpot_dac_driver = {
 	.probe = dpot_dac_probe,
-	.remove_new = dpot_dac_remove,
+	.remove = dpot_dac_remove,
 	.driver = {
 		.name = "iio-dpot-dac",
 		.of_match_table = dpot_dac_match,
diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index b3aa4443a6a4..2332b0c22691 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -184,9 +184,9 @@ static const struct of_device_id lpc18xx_dac_match[] = {
 MODULE_DEVICE_TABLE(of, lpc18xx_dac_match);
 
 static struct platform_driver lpc18xx_dac_driver = {
-	.probe	= lpc18xx_dac_probe,
-	.remove_new = lpc18xx_dac_remove,
-	.driver	= {
+	.probe = lpc18xx_dac_probe,
+	.remove = lpc18xx_dac_remove,
+	.driver = {
 		.name = "lpc18xx-dac",
 		.of_match_table = lpc18xx_dac_match,
 	},
diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 2d567073996b..95ed5197d16f 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -245,7 +245,7 @@ MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
 
 static struct platform_driver stm32_dac_driver = {
 	.probe = stm32_dac_probe,
-	.remove_new = stm32_dac_remove,
+	.remove = stm32_dac_remove,
 	.driver = {
 		.name = "stm32-dac-core",
 		.of_match_table = stm32_dac_of_match,
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 5a722f307e7e..3bfb368b3a23 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -398,7 +398,7 @@ MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
 
 static struct platform_driver stm32_dac_driver = {
 	.probe = stm32_dac_probe,
-	.remove_new = stm32_dac_remove,
+	.remove = stm32_dac_remove,
 	.driver = {
 		.name = "stm32-dac",
 		.of_match_table = stm32_dac_of_match,
diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index de73bc5a1c93..82a078fa98ad 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -272,7 +272,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf610_dac_suspend,
 
 static struct platform_driver vf610_dac_driver = {
 	.probe          = vf610_dac_probe,
-	.remove_new     = vf610_dac_remove,
+	.remove         = vf610_dac_remove,
 	.driver         = {
 		.name   = "vf610-dac",
 		.of_match_table = vf610_dac_match,
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index f9c6b2e732b7..0598f1d3fbb3 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -386,7 +386,7 @@ static struct platform_driver hid_gyro_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_gyro_3d_probe,
-	.remove_new	= hid_gyro_3d_remove,
+	.remove		= hid_gyro_3d_remove,
 };
 module_platform_driver(hid_gyro_3d_platform_driver);
 
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index eb1c022f73c8..f2fa0e1631ff 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -287,7 +287,7 @@ static struct platform_driver hid_humidity_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_humidity_probe,
-	.remove_new	= hid_humidity_remove,
+	.remove		= hid_humidity_remove,
 };
 module_platform_driver(hid_humidity_platform_driver);
 
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 22a63a89f289..675c0fd44db4 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -318,7 +318,7 @@ static struct platform_driver cm3605_driver = {
 		.pm = pm_sleep_ptr(&cm3605_dev_pm_ops),
 	},
 	.probe = cm3605_probe,
-	.remove_new = cm3605_remove,
+	.remove = cm3605_remove,
 };
 module_platform_driver(cm3605_driver);
 
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 30332bf96d28..4eb692322432 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -467,7 +467,7 @@ static struct platform_driver hid_als_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_als_probe,
-	.remove_new	= hid_als_remove,
+	.remove		= hid_als_remove,
 };
 module_platform_driver(hid_als_platform_driver);
 
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 5343ebd404bf..8fe50f897169 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -344,7 +344,7 @@ static struct platform_driver hid_prox_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_prox_probe,
-	.remove_new	= hid_prox_remove,
+	.remove		= hid_prox_remove,
 };
 module_platform_driver(hid_prox_platform_driver);
 
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 6429d951ce7f..99f0b903018c 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -912,7 +912,7 @@ static struct platform_driver lm3533_als_driver = {
 		.name	= "lm3533-als",
 	},
 	.probe		= lm3533_als_probe,
-	.remove_new	= lm3533_als_remove,
+	.remove		= lm3533_als_remove,
 };
 module_platform_driver(lm3533_als_driver);
 
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index ae10db87d1e1..1d6fcbbae1c5 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -574,7 +574,7 @@ static struct platform_driver hid_magn_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_magn_3d_probe,
-	.remove_new	= hid_magn_3d_remove,
+	.remove		= hid_magn_3d_remove,
 };
 module_platform_driver(hid_magn_3d_platform_driver);
 
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 5a0d990018aa..c74b92d53d4d 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -410,7 +410,7 @@ static struct platform_driver hid_incl_3d_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_incl_3d_probe,
-	.remove_new	= hid_incl_3d_remove,
+	.remove		= hid_incl_3d_remove,
 };
 module_platform_driver(hid_incl_3d_platform_driver);
 
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 414d840afb42..343be43163e4 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -362,7 +362,7 @@ static struct platform_driver hid_dev_rot_platform_driver = {
 		.pm     = &hid_sensor_pm_ops,
 	},
 	.probe		= hid_dev_rot_probe,
-	.remove_new	= hid_dev_rot_remove,
+	.remove		= hid_dev_rot_remove,
 };
 module_platform_driver(hid_dev_rot_platform_driver);
 
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 033a82781fdb..3a6c7e50cc70 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -369,7 +369,7 @@ static struct platform_driver hid_hinge_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_hinge_probe,
-	.remove_new	= hid_hinge_remove,
+	.remove		= hid_hinge_remove,
 };
 module_platform_driver(hid_hinge_platform_driver);
 
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index a906da4f9546..dfc36430c467 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -350,7 +350,7 @@ static struct platform_driver hid_press_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_press_probe,
-	.remove_new	= hid_press_remove,
+	.remove		= hid_press_remove,
 };
 module_platform_driver(hid_press_platform_driver);
 
diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index c25472b14d4b..b1a4a923e788 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -261,7 +261,7 @@ static struct platform_driver cros_ec_mkbp_proximity_driver = {
 		.pm = pm_sleep_ptr(&cros_ec_mkbp_proximity_pm_ops),
 	},
 	.probe = cros_ec_mkbp_proximity_probe,
-	.remove_new = cros_ec_mkbp_proximity_remove,
+	.remove = cros_ec_mkbp_proximity_remove,
 };
 module_platform_driver(cros_ec_mkbp_proximity_driver);
 
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 86c57672fc7e..71ad29e441b2 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -389,7 +389,7 @@ static const struct dev_pm_ops srf04_pm_ops = {
 
 static struct platform_driver srf04_driver = {
 	.probe		= srf04_probe,
-	.remove_new	= srf04_remove,
+	.remove		= srf04_remove,
 	.driver		= {
 		.name		= "srf04-gpio",
 		.of_match_table	= of_srf04_match,
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index d2209cd5b98c..0e21217472ab 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -283,7 +283,7 @@ static struct platform_driver hid_temperature_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_temperature_probe,
-	.remove_new	= hid_temperature_remove,
+	.remove		= hid_temperature_remove,
 };
 module_platform_driver(hid_temperature_platform_driver);
 
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index dec256bfbd73..21c6b6292a72 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -96,7 +96,7 @@ static void iio_interrupt_trigger_remove(struct platform_device *pdev)
 
 static struct platform_driver iio_interrupt_trigger_driver = {
 	.probe = iio_interrupt_trigger_probe,
-	.remove_new = iio_interrupt_trigger_remove,
+	.remove = iio_interrupt_trigger_remove,
 	.driver = {
 		.name = "iio_interrupt_trigger",
 	},
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 0684329956d9..bb60b2d7b2ec 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -900,7 +900,7 @@ MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
 
 static struct platform_driver stm32_timer_trigger_driver = {
 	.probe = stm32_timer_trigger_probe,
-	.remove_new = stm32_timer_trigger_remove,
+	.remove = stm32_timer_trigger_remove,
 	.driver = {
 		.name = "stm32-timer-trigger",
 		.of_match_table = stm32_trig_of_match,

base-commit: 33ce24234fca4c083e6685a18b460a18ebb5d5c1
-- 
2.45.2


