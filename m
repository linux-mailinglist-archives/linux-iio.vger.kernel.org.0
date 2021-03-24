Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3EA347902
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhCXM4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhCXM4G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:56:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94496C0613DE
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k10so32711710ejg.0
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFsO3CjdzjvSKalFHfalsmH1Z1YFNl8tTKEel8RPQ5w=;
        b=TQDfwW+RWxoC195Fzua0pk1St/0sgu8PKZyJu7DVkyw9hXK8uBUvhbeugCJaGDeBa1
         XOjgEjOI0P71D0gflcRsicksf5UFqjY0oDU6w6+pgeDt9g8NvAV2n4mJ3aX37y0QNCH/
         9LIPsAzWyRzNHSYMERj840gXWk7xrth+EsdW2C5+1VlyTkG4PE1IkJ5buDdwwCQn7TN9
         rGAhoe9Q49HZCC7RFbF29ucVwlDeZPZkNbpsoJZcAon8HijLMGTxBvSuiVdXAPc67zXL
         UjSPLB5QbMbIsZrZoA+MPtjMoomX4ZhbJWwlaQiFyLYgqEghv7r3fto2tprog9M2aEHr
         CoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFsO3CjdzjvSKalFHfalsmH1Z1YFNl8tTKEel8RPQ5w=;
        b=h1EGFGBI366LEQfPEZ4vxK6pu+Z5541TKEtTCsGPocdKriPOwn9dCDthoBezAfynKM
         4psCQE7DFXce+Ohd3ZfFfTbgOmc03/VWGrJu9/ZBXNFLCcFv5qIn4Ry53ouiF8FWGhr7
         wG0MuHQm7q0+S+TrZE9ZNQ2zyu6SHWXx677sY59llc2spZccegX+1qk9rE6uuLHlTVSR
         h5ZORExHyhqRHuUW9fZU+TpjvQZiperZsGiVBeEoAFHRTT4nmbmyEi74NWKMo3YC/E2f
         bA0foqyeYHfNE96GefiHAGTCdQ8S8wttgkfIYiHVL/A609V2wJcuSR5Uspf3MRsU8zpo
         FKlg==
X-Gm-Message-State: AOAM530nHM/3ISQ9eSMXxbCR1n/zNPfH6SCwjokCdjNzYncy0+J6mCzW
        OCnPW94ZVZEx0C/Y5eiUl7L1EA==
X-Google-Smtp-Source: ABdhPJwJyL58sUWBrXWfLdOooX4vIKkqXRt2tWpnGi0EvOn86rz78Pp4fgk7jt1d1LArIR2ZJgoeog==
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr3435189ejr.525.1616590564364;
        Wed, 24 Mar 2021 05:56:04 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:04 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 04/10] platform/x86: toshiba_acpi: use device-managed functions for input device
Date:   Wed, 24 Mar 2021 14:55:42 +0200
Message-Id: <20210324125548.45983-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change uses device managed functions to handle the deregistration of
the keyboard resources when the refcount of the parent device goes to zero.

For the input device devm_input_allocate_device() must be used, and after
that it will be bound also for auto-deregistration when
input_device_register() is called.

The work object is registered for uninit with devm_add_action(), which will
be called on device unregister only.

The i8042 filter is registered with devm_add_action() as well, but it is
done last in the toshiba_acpi_setup_keyboard() function. This is a little
quirky, because this relies on the fact that there can a single
toshiba_acpi_dev object.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 55 +++++++++++++++++++----------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 53ef565378ef..556f2cc99bad 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -186,7 +186,6 @@ struct toshiba_acpi_dev {
 	unsigned int video_supported:1;
 	unsigned int fan_supported:1;
 	unsigned int system_event_supported:1;
-	unsigned int ntfy_supported:1;
 	unsigned int info_supported:1;
 	unsigned int tr_backlight_supported:1;
 	unsigned int kbd_illum_supported:1;
@@ -2756,9 +2755,23 @@ static void toshiba_acpi_process_hotkeys(struct toshiba_acpi_dev *dev)
 	}
 }
 
-static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
+static void toshiba_acpi_cancel_hotkey_work(void *data)
+{
+	struct work_struct *hotkey_work = data;
+
+	cancel_work_sync(hotkey_work);
+}
+
+static void toshiba_acpi_i8042_remove_filter(void *data)
+{
+	i8042_remove_filter(toshiba_acpi_i8042_filter);
+}
+
+static int toshiba_acpi_setup_keyboard(struct device *parent,
+				       struct toshiba_acpi_dev *dev)
 {
 	const struct key_entry *keymap = toshiba_acpi_keymap;
+	bool ntfy_supported = false;
 	acpi_handle ec_handle;
 	int error;
 
@@ -2779,7 +2792,7 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
 	if (toshiba_hotkey_event_type_get(dev, &dev->hotkey_event_type))
 		pr_notice("Unable to query Hotkey Event Type\n");
 
-	dev->hotkey_dev = input_allocate_device();
+	dev->hotkey_dev = devm_input_allocate_device(parent);
 	if (!dev->hotkey_dev)
 		return -ENOMEM;
 
@@ -2798,7 +2811,7 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
 			dev->hotkey_event_type);
 	error = sparse_keymap_setup(dev->hotkey_dev, keymap, NULL);
 	if (error)
-		goto err_free_dev;
+		goto err_null_dev;
 
 	/*
 	 * For some machines the SCI responsible for providing hotkey
@@ -2811,13 +2824,19 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
 	if (ec_handle && acpi_has_method(ec_handle, "NTFY")) {
 		INIT_WORK(&dev->hotkey_work, toshiba_acpi_hotkey_work);
 
+		error = devm_add_action(parent,
+					toshiba_acpi_cancel_hotkey_work,
+					&dev->hotkey_work);
+		if (error)
+			return error;
+
 		error = i8042_install_filter(toshiba_acpi_i8042_filter);
 		if (error) {
 			pr_err("Error installing key filter\n");
-			goto err_free_dev;
+			return error;
 		}
 
-		dev->ntfy_supported = 1;
+		ntfy_supported = true;
 	}
 
 	/*
@@ -2840,13 +2859,19 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
 		goto err_remove_filter;
 	}
 
+	if (ntfy_supported) {
+		error = devm_add_action(parent,
+					toshiba_acpi_i8042_remove_filter,
+					NULL);
+		goto err_remove_filter;
+	}
+
 	return 0;
 
- err_remove_filter:
-	if (dev->ntfy_supported)
+err_remove_filter:
+	if (ntfy_supported)
 		i8042_remove_filter(toshiba_acpi_i8042_filter);
- err_free_dev:
-	input_free_device(dev->hotkey_dev);
+err_null_dev:
 	dev->hotkey_dev = NULL;
 	return error;
 }
@@ -2974,14 +2999,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
 				   &toshiba_attr_group);
 
-	if (dev->ntfy_supported) {
-		i8042_remove_filter(toshiba_acpi_i8042_filter);
-		cancel_work_sync(&dev->hotkey_work);
-	}
-
-	if (dev->hotkey_dev)
-		input_unregister_device(dev->hotkey_dev);
-
 	backlight_device_unregister(dev->backlight_dev);
 
 	led_classdev_unregister(&dev->led_dev);
@@ -3080,7 +3097,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	dev->kbd_function_keys_supported = !ret;
 
 	dev->hotkey_event_type = 0;
-	if (toshiba_acpi_setup_keyboard(dev))
+	if (toshiba_acpi_setup_keyboard(parent, dev))
 		pr_info("Unable to activate hotkeys\n");
 
 	/* Determine whether or not BIOS supports transflective backlight */
-- 
2.30.2

