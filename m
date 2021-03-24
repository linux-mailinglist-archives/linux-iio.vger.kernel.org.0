Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A498134790E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 13:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhCXM4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhCXM4O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 08:56:14 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF1C0613E7
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:11 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e7so27428766edu.10
        for <linux-iio@vger.kernel.org>; Wed, 24 Mar 2021 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0AOixSVQaYDeSh4VAk4nqi8IzY0YDC7YSX2q7F9wac=;
        b=p9eNAslDD0sBoEN0CD3Yw/zgILE+kMoGorL0VgdHYiQdT0rhKS7z0mnChro/Q65BKR
         NkS+yM2dzXDwfu4cOc0CPT0U1y8uvWyr8ByPMvt1oqsuaOOrJQEd4nDolh0XGFqVhBDA
         yBpb2ID4TQAmaDwla+ifXgdHfEs+VISkqxpvMhqAL/YN2OKehtffFRFiQFU/cigw2xDV
         dQA+lqyD+8Bj1DjgDe8uHGksSE2VX7/0KNsg6tXjBoj53mvSqZlZtaa1UDfa4hK3/PWF
         MQwCO5fKiNW1VuopEa9RmH3upnQ0smbXMGoaHlie2wAl4KBM4G9VSNXs7CuUxHxAWc7q
         /Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0AOixSVQaYDeSh4VAk4nqi8IzY0YDC7YSX2q7F9wac=;
        b=QNxMi84avUIDlnxjm8Dz4wNMpMcOIVk7UdiTGD340LisgQ9GqQm3+p2P9wOttms6e2
         BtssZe9+fxLi2/xiunh+gLlv0exsaxCCgskYRtDkEkfS+Q8SbVTLjxGyscwO5WRRkSGu
         Vw1sx1bpwGVxc1P62A6k2bYapujCUsoOyFHrJpN5jJFj6qxm6s0MxBHaIkOQkCWqC2XS
         ELWCNRbMUF4CFzwBgGtCU56ft/iFtWhkG98C6dEqj9xF3sbh7zHoXmwyugw7qwcrmoLD
         2Zjy/OnygBKOiaHhYI4NonlpeLsRHzO+JL4h09AqN/dLspJ9nc7SK1iBH2sHQrPPlePg
         nw2A==
X-Gm-Message-State: AOAM531rR00Ss8UVpm3whWaoEVog3PDDilcv3ulGAoBYJ4+1V3Z44sdi
        1L+qOWqvxuBVWtYFHdWG0cfL0g==
X-Google-Smtp-Source: ABdhPJzcWnvJEq/xcup+eZznQQjcwhSGHwksnhZO04Sbq0tuTKJTYhTUo/ehIeYEdYC6gE8DgEOhxQ==
X-Received: by 2002:aa7:d9c8:: with SMTP id v8mr3212277eds.9.1616590570503;
        Wed, 24 Mar 2021 05:56:10 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:10 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 10/10] platform/x86: toshiba_acpi: bind proc entries creation to parent
Date:   Wed, 24 Mar 2021 14:55:48 +0200
Message-Id: <20210324125548.45983-11-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change binds the creation of the proc entries to the parent object,
via the devm_add_action_or_reset() call.
This way when the parent object's refcount goes to zero, the proc entries
are removed in the reverse other in which they were created.

This is the last bit of the toshiba_acpi_remove() function, so in this
change this function is removed.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 45 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 8e8917979047..56ee5cd1e90c 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1671,7 +1671,23 @@ static int __maybe_unused version_proc_show(struct seq_file *m, void *v)
 
 #define PROC_TOSHIBA		"toshiba"
 
-static void create_toshiba_proc_entries(struct toshiba_acpi_dev *dev)
+static void remove_toshiba_proc_entries(void *data)
+{
+	struct toshiba_acpi_dev *dev = data;
+
+	if (dev->backlight_dev)
+		remove_proc_entry("lcd", toshiba_proc_dir);
+	if (dev->video_supported)
+		remove_proc_entry("video", toshiba_proc_dir);
+	if (dev->fan_supported)
+		remove_proc_entry("fan", toshiba_proc_dir);
+	if (dev->hotkey_dev)
+		remove_proc_entry("keys", toshiba_proc_dir);
+	remove_proc_entry("version", toshiba_proc_dir);
+}
+
+static int create_toshiba_proc_entries(struct device *parent,
+				       struct toshiba_acpi_dev *dev)
 {
 	if (dev->backlight_dev)
 		proc_create_data("lcd", S_IRUGO | S_IWUSR, toshiba_proc_dir,
@@ -1687,19 +1703,8 @@ static void create_toshiba_proc_entries(struct toshiba_acpi_dev *dev)
 				 &keys_proc_ops, dev);
 	proc_create_single_data("version", S_IRUGO, toshiba_proc_dir,
 			version_proc_show, dev);
-}
 
-static void remove_toshiba_proc_entries(struct toshiba_acpi_dev *dev)
-{
-	if (dev->backlight_dev)
-		remove_proc_entry("lcd", toshiba_proc_dir);
-	if (dev->video_supported)
-		remove_proc_entry("video", toshiba_proc_dir);
-	if (dev->fan_supported)
-		remove_proc_entry("fan", toshiba_proc_dir);
-	if (dev->hotkey_dev)
-		remove_proc_entry("keys", toshiba_proc_dir);
-	remove_proc_entry("version", toshiba_proc_dir);
+	return devm_add_action_or_reset(parent, remove_toshiba_proc_entries, dev);
 }
 
 static const struct backlight_ops toshiba_backlight_data = {
@@ -3012,15 +3017,6 @@ static void print_supported_features(struct toshiba_acpi_dev *dev)
 	pr_cont("\n");
 }
 
-static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
-{
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
-
-	remove_toshiba_proc_entries(dev);
-
-	return 0;
-}
-
 static const char *find_hci_method(acpi_handle handle)
 {
 	if (acpi_has_method(handle, "GHCI"))
@@ -3230,7 +3226,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	if (ret)
 		return ret;
 
-	create_toshiba_proc_entries(dev);
+	ret = create_toshiba_proc_entries(parent, dev);
+	if (ret)
+		return ret;
 
 	toshiba_acpi = dev;
 
@@ -3340,7 +3338,6 @@ static struct acpi_driver toshiba_acpi_driver = {
 	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops	= {
 		.add		= toshiba_acpi_add,
-		.remove		= toshiba_acpi_remove,
 		.notify		= toshiba_acpi_notify,
 	},
 	.drv.pm	= &toshiba_acpi_pm,
-- 
2.30.2

