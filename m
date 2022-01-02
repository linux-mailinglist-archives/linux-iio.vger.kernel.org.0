Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16044829BE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 06:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiABFxi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 00:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiABFxi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 00:53:38 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF938C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 21:53:37 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v25so27585581pge.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 21:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcG4pcs/y08XaSYOnwPqOTOIDyOEIUT8EofOSygCWQs=;
        b=XjmN+JS/0HxO6V2gThDkyFR4geKicFxyVTKUkkGzUv1PoT0Aqbic9o57D3Mgsmr4ad
         3x7tMYYT5ozgx1PmbMJNULZcuGOdqFXd78UsLT98s78ylrwEtMF2jrvp4u+d1FftCTUK
         fy3UFvL/AERTwyrMj4G393x/KiqvGJsPwEHss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcG4pcs/y08XaSYOnwPqOTOIDyOEIUT8EofOSygCWQs=;
        b=W/XGk8MUUXcvjw7ALYYiHXXv9LfU0K1wSAKx7cvw5kVfLeMmF+8Geruz2pYzw+ZJbf
         Efpj/5drHgT/4hKyG4dxEUdILK4Dj8OvK8W+zk5obAyQudkTXt/1Cy7MsVr6+kYOb6Ax
         DIHNtwQZeMps8NIFHhUVphvy+7qNtY6IoMifqaQD6wcheG6aF55gBTAXXX1tT4SFbS3e
         ddGnulqZhSgVNUYo/BtOe7t/tUwrZvNWV3DQJ/k7PpzKnc4yHrVqyHkIJHilKNXurqG8
         lnPf9WDt0Qinh80T1o2VSoNxDA2byYQXf8GlRMQnNCXRUQxQvh95GNfm16XKipQnz0yC
         iyLg==
X-Gm-Message-State: AOAM5305681gZ2vDhqiK187X+f4TPPSCNCD6QVbrR7E5NX3dqi+f91+E
        RXR8zbdF2wWPECq4qTAeydP5+w==
X-Google-Smtp-Source: ABdhPJz1vsO3EAkIuY3sx0XHgJaGT0d49gnUkts1pqQoTHLThQBf4AuIRNksf3lubLoP/Q9Zy5gIVA==
X-Received: by 2002:a63:7144:: with SMTP id b4mr14005008pgn.217.1641102817456;
        Sat, 01 Jan 2022 21:53:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:df49:1d3f:ae08:999])
        by smtp.gmail.com with UTF8SMTPSA id q17sm12267751pjp.2.2022.01.01.21.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 21:53:37 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] drivers/iio: Use SIMPLE_DEV_PM_OPS when possible
Date:   Sat,  1 Jan 2022 21:53:33 -0800
Message-Id: <20220102055333.338456-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use SIMPLE_DEV_PM_OPS macro instead of "const struct dev_pm_ops...".
Use spatch and sed to fix the drivers. A simple .cocci file is used:
@Replacement@
identifier operation;
expression suspend, resume;
@@
- const struct dev_pm_ops operation = { SYSTEM_SLEEP_PM_OPS(suspend, resume) };
+ gg_fc operation = gg_arg(suspend, resume);

spatch -sp_file simple.cocci -dir drivers/iio | patch -p 1 -drivers/iio/
sed -i 's/gg_fc \(.*\) = gg_arg(/SIMPLE_DEV_PM_OPS(\1, /' \
$(git diff --name-only)

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/adc/palmas_gpadc.c               | 5 +----
 drivers/iio/common/ssp_sensors/ssp_dev.c     | 4 +---
 drivers/iio/dac/stm32-dac.c                  | 5 ++---
 drivers/iio/humidity/hts221_core.c           | 4 +---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +---
 drivers/iio/light/cm3232.c                   | 3 +--
 drivers/iio/light/cm3605.c                   | 5 +----
 drivers/iio/light/st_uvis25_core.c           | 4 +---
 drivers/iio/magnetometer/mmc35240.c          | 4 +---
 drivers/iio/proximity/sx9310.c               | 4 +---
 drivers/iio/proximity/sx9500.c               | 4 +---
 11 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f9c8385c72d3d9..558861bd342279 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -824,10 +824,7 @@ static int palmas_gpadc_resume(struct device *dev)
 };
 #endif
 
-static const struct dev_pm_ops palmas_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(palmas_gpadc_suspend,
-				palmas_gpadc_resume)
-};
+static SIMPLE_DEV_PM_OPS(palmas_pm_ops, palmas_gpadc_suspend, palmas_gpadc_resume);
 
 static const struct of_device_id of_palmas_gpadc_match_tbl[] = {
 	{ .compatible = "ti,palmas-gpadc", },
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1aee8710003817..4ce08283ca9f1a 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -663,9 +663,7 @@ static int ssp_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops ssp_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
-};
+static SIMPLE_DEV_PM_OPS(ssp_pm_ops, ssp_suspend, ssp_resume);
 
 static struct spi_driver ssp_driver = {
 	.probe = ssp_probe,
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index cd71cc4553a730..c94208a9a6cad6 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -386,9 +386,8 @@ static int __maybe_unused stm32_dac_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static const struct dev_pm_ops stm32_dac_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_dac_suspend, pm_runtime_force_resume)
-};
+static SIMPLE_DEV_PM_OPS(stm32_dac_pm_ops, stm32_dac_suspend,
+				       pm_runtime_force_resume);
 
 static const struct of_device_id stm32_dac_of_match[] = {
 	{ .compatible = "st,stm32-dac", },
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 6a39615b696114..ccba2f253a5b8a 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -694,9 +694,7 @@ static int __maybe_unused hts221_resume(struct device *dev)
 	return err;
 }
 
-const struct dev_pm_ops hts221_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(hts221_suspend, hts221_resume)
-};
+SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume);
 EXPORT_SYMBOL(hts221_pm_ops);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 727b4b6ac69663..10a84b3c7b6889 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2358,9 +2358,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 	return err;
 }
 
-const struct dev_pm_ops st_lsm6dsx_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(st_lsm6dsx_suspend, st_lsm6dsx_resume)
-};
+SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend, st_lsm6dsx_resume);
 EXPORT_SYMBOL(st_lsm6dsx_pm_ops);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 18a410340dc563..7e6aaefe382674 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -403,8 +403,7 @@ static int cm3232_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops cm3232_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};
+static SIMPLE_DEV_PM_OPS(cm3232_pm_ops, cm3232_suspend, cm3232_resume);
 #endif
 
 MODULE_DEVICE_TABLE(i2c, cm3232_id);
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 50d34a98839c0e..7b1d27286ba3b0 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -303,10 +303,7 @@ static int __maybe_unused cm3605_pm_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops cm3605_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cm3605_pm_suspend,
-				cm3605_pm_resume)
-};
+static SIMPLE_DEV_PM_OPS(cm3605_dev_pm_ops, cm3605_pm_suspend, cm3605_pm_resume);
 
 static const struct of_device_id cm3605_of_match[] = {
 	{.compatible = "capella,cm3605"},
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 41a2ce5a2d5388..997432a0b2dca0 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -346,9 +346,7 @@ static int __maybe_unused st_uvis25_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops st_uvis25_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(st_uvis25_suspend, st_uvis25_resume)
-};
+SIMPLE_DEV_PM_OPS(st_uvis25_pm_ops, st_uvis25_suspend, st_uvis25_resume);
 EXPORT_SYMBOL(st_uvis25_pm_ops);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 65f3d1ed0d597f..0a1ada247bfbfd 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -550,9 +550,7 @@ static int mmc35240_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops mmc35240_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
-};
+static SIMPLE_DEV_PM_OPS(mmc35240_pm_ops, mmc35240_suspend, mmc35240_resume);
 
 static const struct of_device_id mmc35240_of_match[] = {
 	{ .compatible = "memsic,mmc35240", },
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a3fdb59b06d220..13b340de40b76b 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1529,9 +1529,7 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops sx9310_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sx9310_suspend, sx9310_resume)
-};
+static SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
 
 static const struct acpi_device_id sx9310_acpi_match[] = {
 	{ "STH9310", SX9310_WHOAMI_VALUE },
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3e4ddb2e8c2bd8..39a32fc5c096d5 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1032,9 +1032,7 @@ static int sx9500_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops sx9500_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sx9500_suspend, sx9500_resume)
-};
+static SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
 
 static const struct acpi_device_id sx9500_acpi_match[] = {
 	{"SSX9500", 0},
-- 
2.34.1.448.ga2b2bfdf31-goog

