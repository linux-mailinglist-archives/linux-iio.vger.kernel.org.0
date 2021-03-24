Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF299347905
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhCXM4j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbhCXM4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:56:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95332C0613DF
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq27so32680320ejc.9
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xslj2HthXDrqOB8fzPzGxoP+4g8oF5kFhH9tLbOpuwk=;
        b=EA/iiRLzhPyouBzEGqEEvNayjzGltHlqtlmPvlamFkf9kwv39A8FvLmv37bHb4Ce4P
         BmDt+qmivDvxZEKbSlPitksLF3DqE4iX4QXgkJtMo14lpGJBiVzlWMDiZlfS62p6922P
         4J7CbykQTUMs2xQnVspOJTy5D2sX6PymEpgCVL/RGIf9ONuHHmPBaglU5kmmINmKgfMi
         FrVfMouBnq1rDRaUCBRbzgG4lCW+k2KEqXWmOqmo0Sepc+xKR/V+sdEe+OtFGkKu0xgT
         UBeySBlvXwSoa7meSHqZrtZ6f1mTAyGtTK4krut44NH4dUWZMG3lWhqiAlD+lrHH0BXs
         3vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xslj2HthXDrqOB8fzPzGxoP+4g8oF5kFhH9tLbOpuwk=;
        b=ATGBwVo9I1AG9UlluNFDxOSKPSF7JYn17x8P1MoRYhRqpjJgoywXmjEpgsp2a+4h/C
         4cVXOyhv4t0fgtTTGlK6gwZl7QkpKiEI0mUMd4FcijAU0YAeuxJ68IO6vX3G2uKEcsMy
         oUzsZMbmrpFutC0nCOb/oxyJB7XF1N+aqkNNcsfn3uQZl1NJIayEtsHrAdCHXYaIotme
         4X+stJ4lDFAZv6g+zuhsacYMZAV9augjd67GO285aIpmGQxQtJeRrZ8aEHBPjInUbDg5
         erbcARzeL2C0mHY5wOlYlaihUCEOXdLCKv4dVSiMKfOpqzdHsW9t+gxa+fmY8mYOddVr
         X2wQ==
X-Gm-Message-State: AOAM531G2eofwPzefB0bHTnQmbi+LbXggj7bxzG9nLheNdaVni68gsqQ
        rwJKPXdKjQq9hn7Uq8ys/q1cIg==
X-Google-Smtp-Source: ABdhPJx2EOP9+eIwQbX5mIZcz9HFnp6uZundPHwJXDNQuVzbLvxvvM5eF6ZIv3J5LAFVfjhQ9AR/ZA==
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr3556682eje.104.1616590566405;
        Wed, 24 Mar 2021 05:56:06 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:06 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 06/10] platform/x86: toshiba_acpi: use devm_led_classdev_register() for LEDs
Date:   Wed, 24 Mar 2021 14:55:44 +0200
Message-Id: <20210324125548.45983-7-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With this change the deregistration of the LED objects is made symmetrical
(and in reverse) with the registration. We also can get rid of the calls
to led_classdev_unregister(), because the LED objects will be cleaned up
when the reference to the parent device object goes to zero.

This change also unifies the reference to the parent object from
'&acpi_dev->dev' and '&dev->acpi_dev->dev' to 'parent', since it's the same
reference, and makes the code-lines a bit shorter.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index ada2a2d8c913..e787c140eec2 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3001,10 +3001,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
 				   &toshiba_attr_group);
 
-	led_classdev_unregister(&dev->led_dev);
-	led_classdev_unregister(&dev->kbd_led);
-	led_classdev_unregister(&dev->eco_led);
-
 	if (dev->wwan_rfk) {
 		rfkill_unregister(dev->wwan_rfk);
 		rfkill_destroy(dev->wwan_rfk);
@@ -3114,7 +3110,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->led_dev.max_brightness = 1;
 		dev->led_dev.brightness_set = toshiba_illumination_set;
 		dev->led_dev.brightness_get = toshiba_illumination_get;
-		led_classdev_register(&acpi_dev->dev, &dev->led_dev);
+		ret = devm_led_classdev_register(parent, &dev->led_dev);
+		if (ret)
+			return ret;
 	}
 
 	toshiba_eco_mode_available(dev);
@@ -3123,7 +3121,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->eco_led.max_brightness = 1;
 		dev->eco_led.brightness_set = toshiba_eco_mode_set_status;
 		dev->eco_led.brightness_get = toshiba_eco_mode_get_status;
-		led_classdev_register(&dev->acpi_dev->dev, &dev->eco_led);
+		ret = devm_led_classdev_register(parent, &dev->eco_led);
+		if (ret)
+			return ret;
 	}
 
 	toshiba_kbd_illum_available(dev);
@@ -3139,7 +3139,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->kbd_led.max_brightness = 1;
 		dev->kbd_led.brightness_set = toshiba_kbd_backlight_set;
 		dev->kbd_led.brightness_get = toshiba_kbd_backlight_get;
-		led_classdev_register(&dev->acpi_dev->dev, &dev->kbd_led);
+		ret = devm_led_classdev_register(parent, &dev->kbd_led);
+		if (ret)
+			return ret;
 	}
 
 	ret = toshiba_touchpad_get(dev, &dummy);
-- 
2.30.2

