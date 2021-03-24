Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB78347909
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhCXM4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhCXM4K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:56:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5EAC0613E3
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h10so27455377edt.13
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5b4aQ508Io3+0QcWegMSXE+w4jq/XwA5f3VwTDm7+CM=;
        b=kPAESwGyeqxafo+DnvdLNonf1MxYA0W8rt++k4+tTM0QMkoVWACB1as0tIafLR7YPL
         V62xqME1LmZj7DnK1VArZ1fIBbN+Zs7KuM2iqdeosqtcHe4WHBmgGsYKZ6KTKmS312Af
         nSXgDeCOdOR5xeBYbjOlhLgYiTlmP9/Zy2c82nEOofFDlKFFkn6ke8npsr0RmQuFpA3v
         bL7e0zT3YHEPn/4PHCPJAMOPevARu3dHvBI3VFGzIL1847v1av+P+LlY+czh4F72yx9/
         dRK69U3EPe5f6fX9RCi2PYl7eWfAyL/sx105I5bXKAbGyKwLD8p2XVPKuqSBeYI+KbF7
         op4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5b4aQ508Io3+0QcWegMSXE+w4jq/XwA5f3VwTDm7+CM=;
        b=geqaBMQJV/Og93tzGiu0nytTSBbvFe8YNnwR1fUx4KzX9ZjI95JDrfvdGJoMxL507U
         JE3TODTEXB7pi5YDJ2sjLNuceXwdIojXQBC6EVa95YBBYAGGv36vQpWLKTywIeD5BFzV
         3ZNVeTen97COauAKhfjcMKGMROIAD5TXDyd4DdXC7fY3NETk4MBeRt4V7/j+PHLdvhwM
         ytTLgKgUhvaPKRthHWHroIJ+NMFtjAvvqJ0mWv6qrf5odQ7JLNXxr8jTWM2XpK9y5/Nk
         8qbWr2cUZKdCav5Lff1BHAjir867ZAuWdcsi1d69oCvAam+XMysGttgPr9anEKh993Fj
         2ZCw==
X-Gm-Message-State: AOAM532zkpGypEACDEpezsNDaSFXsEjYA5+Pgp5eMZE3ZymG7Bt4JrtJ
        49jxjrPHezLdabdu8FTaEw8SHBE6oZEApKJD
X-Google-Smtp-Source: ABdhPJxsSAiGJmL649dJDQw4Ag16alHr4nvmdoimmmdE27PdMGxU9yPAzPpZEvqfxGs5TmtWmDSLZQ==
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr3346589edr.264.1616590568409;
        Wed, 24 Mar 2021 05:56:08 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:08 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 08/10] platform/x86: toshiba_acpi: use device-managed for wwan_rfkill management
Date:   Wed, 24 Mar 2021 14:55:46 +0200
Message-Id: <20210324125548.45983-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the wwan_rfkill object to be free'd automatically when
the parent refcount goes to zero.
There are 2 cleanup operations required: rfkill_unregister() and
rfkill_destroy(). Since they don't have any devm_ variants, they are hooked
via devm_add_action_or_reset().

The main reason to do this is to enforce ordering on cleanup, when the
Toshiba ACPI device is cleaned up.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 40 ++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 12860ef60e4d..a1249f6dde9a 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2591,7 +2591,22 @@ static const struct rfkill_ops wwan_rfk_ops = {
 	.poll = toshiba_acpi_wwan_poll,
 };
 
-static int toshiba_acpi_setup_wwan_rfkill(struct toshiba_acpi_dev *dev)
+static void toshiba_acpi_rfkill_destroy(void *data)
+{
+	struct rfkill *wwan_rfk = data;
+
+	rfkill_destroy(wwan_rfk);
+}
+
+static void toshiba_acpi_rfkill_unreg(void *data)
+{
+	struct rfkill *wwan_rfk = data;
+
+	rfkill_unregister(wwan_rfk);
+}
+
+static int toshiba_acpi_setup_wwan_rfkill(struct device *parent,
+					  struct toshiba_acpi_dev *dev)
 {
 	int ret = toshiba_wireless_status(dev);
 
@@ -2608,15 +2623,27 @@ static int toshiba_acpi_setup_wwan_rfkill(struct toshiba_acpi_dev *dev)
 		return -ENOMEM;
 	}
 
+	ret = devm_add_action_or_reset(parent, toshiba_acpi_rfkill_destroy,
+				       dev->wwan_rfk);
+	if (ret)
+		return ret;
+
 	rfkill_set_hw_state(dev->wwan_rfk, !dev->killswitch);
 
 	ret = rfkill_register(dev->wwan_rfk);
 	if (ret) {
 		pr_err("Unable to register WWAN rfkill device\n");
-		rfkill_destroy(dev->wwan_rfk);
+		return ret;
 	}
 
-	return ret;
+	ret = devm_add_action_or_reset(parent, toshiba_acpi_rfkill_unreg,
+				       dev->wwan_rfk);
+	if (ret) {
+		dev->wwan_rfk = NULL;
+		return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -2996,11 +3023,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
 				   &toshiba_attr_group);
 
-	if (dev->wwan_rfk) {
-		rfkill_unregister(dev->wwan_rfk);
-		rfkill_destroy(dev->wwan_rfk);
-	}
-
 	return 0;
 }
 
@@ -3189,7 +3211,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 
 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
-		toshiba_acpi_setup_wwan_rfkill(dev);
+		toshiba_acpi_setup_wwan_rfkill(parent, dev);
 
 	toshiba_cooling_method_available(dev);
 
-- 
2.30.2

