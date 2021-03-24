Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D189F347900
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhCXM4f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhCXM4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:56:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCDCC0613E1
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so32672490ejc.10
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frWPEUlqs06JkDdBYmeAt9wV6HnzyvV5zsDKfCcKu+M=;
        b=GmpYQYHQItWYbKynRGeuKnH14x7wgEAUOeru1GAukTiYyBVZyNuC62e9vPztxuB3b+
         o9qG1cfC4xJt5eKWXvGYooq4t61JA5rELbrYnZC5EImztn7SNINNZaLjhtNqYTZPU1lG
         7HDtCpP+MNoS8NfsghQJc1E42HJqvPOPjK1ajPTu6/XtqpQfNdX/CeS3ANPpsNm/o9ED
         xDwA7eSuWn46kA6P5NmMwaateIOfXhnoptqZyvF9gYKJhhCg+kP0Prb/bLGnSsfNc52a
         i/ddBMFrew2LvfV46CLC6Wa9q+r3n1hZeM5EfvzjgzxZzvQ0xEdou4zZQsUFhFSTfULD
         oSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frWPEUlqs06JkDdBYmeAt9wV6HnzyvV5zsDKfCcKu+M=;
        b=fy+53mZA3dtw1ATk18/Ak9IkqOlYntumDstp8lneXLiMn3JvwYr43k3ld4M5V0uXRi
         TBl3cZAvYXraz/yx67L+Kqqea2Qfpztfr+53VshCTh2TH07Spm5Atr9DXFV91Z290haj
         KCISLTKx/Gkyh3IqlrzzhcRDhhJCgaUNANIucI6iHB8rAm8QFcm8U96R++/WWji2BUfk
         +FKNFwf/R41zimL3JsFhePx0DlxX/Wrxf3AWvgwtj0tNJKmyCTQeLn2oRndgsfu8fMfi
         K8ZJJRo/k1WugxZwFHHCn80kdM8uaQ18ThqZgZHEkCX1E7rGv2VCwlCqA7Y9Aar9djdk
         jgcg==
X-Gm-Message-State: AOAM532ZFCC0YjQRAsSCColS2gNIreryR9q0iEyR4sqB1dhCGiGCPLmy
        9SazmoCheiMbEzq80lmQmzCeRg==
X-Google-Smtp-Source: ABdhPJzpxStqf4689RHXTCYW0kDpZhBA8gf9Qrkx0RVSK+qnEqvmhL4BwM1bxJkrz6O7EHd8bIM0+g==
X-Received: by 2002:a17:907:a042:: with SMTP id gz2mr3506188ejc.174.1616590563362;
        Wed, 24 Mar 2021 05:56:03 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:03 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 03/10] platform/x86: toshiba_acpi: bind registration of miscdev object to parent
Date:   Wed, 24 Mar 2021 14:55:41 +0200
Message-Id: <20210324125548.45983-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change moves the registration of the Toshiba ACPI miscdev to be
handled by the devm_add_action_or_reset() hook. This way, the miscdev will
be unregistered when the reference count of the parent device object goes
to zero.

This also changes the order of cleanup in toshiba_acpi_remove(), where the
miscdev was deregistered first. Now it will be deregistered right before
the toshiba_acpi_dev object is free'd.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index c5284601bc2a..53ef565378ef 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2963,8 +2963,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 {
 	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
 
-	misc_deregister(&dev->miscdev);
-
 	remove_toshiba_proc_entries(dev);
 
 	if (dev->accelerometer_supported && dev->indio_dev) {
@@ -3014,6 +3012,13 @@ static void toshiba_acpi_singleton_clear(void *data)
 	toshiba_acpi = NULL;
 }
 
+static void toshiba_acpi_misc_deregister(void *data)
+{
+	struct miscdevice *miscdev = data;
+
+	misc_deregister(miscdev);
+}
+
 static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 {
 	struct device *parent = &acpi_dev->dev;
@@ -3056,6 +3061,11 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(parent, toshiba_acpi_misc_deregister,
+				       &dev->miscdev);
+	if (ret)
+		return ret;
+
 	acpi_dev->driver_data = dev;
 	dev_set_drvdata(&acpi_dev->dev, dev);
 
-- 
2.30.2

