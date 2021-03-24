Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9963478FB
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhCXM4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhCXM4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:56:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC773C0613DE
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hq27so32679891ejc.9
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yt30BylsVFl1b+dQoUipKgO72wces4+1J22+XTIwK04=;
        b=V8+VKpPq1U3Ka+KRlgK1LrfG0FXSzQm1cNKLBQ6O2nxnxVzkanqDoJuBIVMpFNTI/k
         CrUDsK6kgCZsvJCSO2qZhIbVvYynh64zRpkGOd7XjRj9bBMa/BU+XPghLVESFNnrkMx8
         LXRT30o//+Lcnlh2q460VIEFZGMIRTWCBREme/3lfnKXtdLTXFklnjXHaitlMqwdUkk9
         bMDPrzfjaoI141OP2Yd9QDjb9erYtStOxFtOhWuZL1+xgDfJFWDpF0kP3SRcjPS1UD8L
         fPxR2E4mQqREpdJsiSII//4O14+f7YIWtLv6bAihhtHKKt65mDTw988HWetaPFF9BYBJ
         u0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yt30BylsVFl1b+dQoUipKgO72wces4+1J22+XTIwK04=;
        b=TRLHiwgfwyFyG0P6jU756tb5kcFv2DCJAP7aJjqG5j52Ue7Zh3fw8LJ3VZ14+AxH7P
         G9TLgfxvAIoHIj+V0S+PHEDoukvkcN9MYEipKBDIr2gYd1oab31f1UPlNYNnYI3FstyV
         Ku94od5hnnD9GdTB4r9E1EFqywFUKcJaD4dT3yIcQP2TULjtYq5E1QQqVIK/F+0wRpd0
         ysg9m0p86j4N7Ocb0Ylk+ff6Q1rCX+0saeZFQppc2OLjETeYm0nmzCmLTnsc1Y3WGUI2
         wfkMXOBA7gtbjZ+pAKARjN5S+jW2wBALDwbKHWWOGgemQNlORpUqHNAeFfVBhQYaAWa4
         6jsw==
X-Gm-Message-State: AOAM532bzK8g6wLGVOa1fMNl71hCi6OcSClGt2qtGT7ih+iYRZa+J96z
        VFvo+b1gcLk8JJj2DDa7ZBVA7Q==
X-Google-Smtp-Source: ABdhPJxreCAgoVxptS2To6BlyigUOXCdyHhdVvCZ3X35rkt7s2d0JLzqBu7v5QsTP1W7Eu45RVnMEQ==
X-Received: by 2002:a17:906:b316:: with SMTP id n22mr3404360ejz.249.1616590561345;
        Wed, 24 Mar 2021 05:56:01 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:01 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 01/10] platform/x86: toshiba_acpi: bind life-time of toshiba_acpi_dev to parent
Date:   Wed, 24 Mar 2021 14:55:39 +0200
Message-Id: <20210324125548.45983-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 'toshiba_acpi_dev' object is allocated first and free'd last. We can
bind it's life-time to the parent ACPI device object. This is a first step
in using more device-managed allocated functions for this.

The main intent is to try to convert the IIO framework to export only
device-managed functions (i.e. devm_iio_device_alloc() and
devm_iio_device_register()). It's still not 100% sure that this is
possible, but for now, this is the process of taking it slowly in that
direction.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index fa7232ad8c39..6d298810b7bf 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2998,8 +2998,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 	if (toshiba_acpi)
 		toshiba_acpi = NULL;
 
-	kfree(dev);
-
 	return 0;
 }
 
@@ -3016,6 +3014,7 @@ static const char *find_hci_method(acpi_handle handle)
 
 static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 {
+	struct device *parent = &acpi_dev->dev;
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
@@ -3033,7 +3032,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		return -ENODEV;
 	}
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	dev = devm_kzalloc(parent, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	dev->acpi_dev = acpi_dev;
@@ -3045,7 +3044,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	ret = misc_register(&dev->miscdev);
 	if (ret) {
 		pr_err("Failed to register miscdevice\n");
-		kfree(dev);
 		return ret;
 	}
 
-- 
2.30.2

