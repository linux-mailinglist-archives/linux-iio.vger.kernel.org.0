Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26508319E31
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBLMSJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhBLMQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:16:34 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1C0C06178C;
        Fri, 12 Feb 2021 04:15:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 81so68974qkf.4;
        Fri, 12 Feb 2021 04:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3jMWpIksexOzC2e/n2CYq5o73g38v2lIFng2GSKkL8=;
        b=M4QuDCf1zSWWbbxgKhDCP7LbNboL5qEi8R0PtIcuVcTtlctrI4/S3d4nB2fxdkh8cp
         bXkUzy5aYqjAeZtnYZrvpgBz2DUWeJkkczcSuc1lDZArqb91WN3nUQUrbYA8TeTJnouB
         IwB6nFOQcMf1Z+1gqjQzAjGw+kTxJ2VDmEknjKLTBOs93noEmAlhQpBIxQVS+FeH+8cV
         3BMLZeEoh6CRbQ0zTmGeeQAfrff7KwH87dxvxViiv7aD7YrjbTKNNDdv9IQ17pyva12j
         lIbh+xFPIFULkvOWeyv/Tf3Kna5hQ6KN8vGXWnZOoFy4lmRxqDScrMK2V2TkYPpcZ/G1
         C5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3jMWpIksexOzC2e/n2CYq5o73g38v2lIFng2GSKkL8=;
        b=L+VXZfegn2nrSALV6SLv5pmhY/Zd6iDti4VctlfxR4zTVCO8nvbb2mgQHKc8tUr34D
         IqVQiwu4uzLwHS+39XXPEYAd6tPFob47cycKIJmzfNVsdXo6sP4Hx1BVHQkO/tt63D12
         TRG2Jb2oWh1DM2fXnt45ztHPxYOGtpA3IoE3D+Laniov62LdJbGlzHNQozj2N1Dstcb5
         0MyCl1kZj2m3H41E/uGVPHULpy0BBamRHidml6iNt2VoGDUlKwXJwvFUwztORVSTYOD8
         Pi9WvhwB+ZNfo+PqKV4ZOgXNVRtVckCoFVBu48tcI2VyHvBxa/yinH7EtLbZqclDSCrS
         beYg==
X-Gm-Message-State: AOAM533hGA63LIY8q0SIp9+niSol18UehQkNUACiMYsCCpUgGeCqYTIo
        0H7uu9UKYtz3HyFSKl1ZxzQ=
X-Google-Smtp-Source: ABdhPJx0rNFkvn3C8K4UCQ4+F7gss/noC2kgTc3so5YfeW2gc4NMM1PKsHAU2LpjIjSYQLRKYXfqxg==
X-Received: by 2002:a37:992:: with SMTP id 140mr2325191qkj.349.1613132153131;
        Fri, 12 Feb 2021 04:15:53 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:15:52 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v8 19/22] counter: Implement extension*_name sysfs attributes
Date:   Fri, 12 Feb 2021 21:13:43 +0900
Message-Id: <c9b55d1cff6acac692a7853b0a25777ecf017b12.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Generic Counter chrdev interface expects users to supply extension
IDs in order to select extensions for requests. In order for users to
know what extension ID belongs to which extension this information must
be exposed. The extension*_name attribute provides a way for users to
discover what extension ID belongs to which extension by reading the
respective extension name for an extension ID.

Cc: David Lechner <david@lechnology.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter |  9 ++++
 drivers/counter/counter-sysfs.c             | 51 +++++++++++++++++----
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 6353f0a2f8f8..847e96f19d19 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -100,6 +100,15 @@ Description:
 		Read-only attribute that indicates whether excessive noise is
 		present at the channel Y counter inputs.
 
+What:		/sys/bus/counter/devices/counterX/countY/extensionZ_name
+What:		/sys/bus/counter/devices/counterX/extensionZ_name
+What:		/sys/bus/counter/devices/counterX/signalY/extensionZ_name
+KernelVersion:	5.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the component name of
+		Extension Z.
+
 What:		/sys/bus/counter/devices/counterX/countY/function
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 52513a213cc5..0cb3dba950bc 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -494,6 +494,7 @@ static ssize_t counter_comp_name_show(struct device *dev,
 
 static int counter_name_attr_create(struct device *const dev,
 				    struct counter_attribute_group *const group,
+				    const char *const attr_name,
 				    const char *const name)
 {
 	struct counter_attribute *counter_attr;
@@ -508,7 +509,7 @@ static int counter_name_attr_create(struct device *const dev,
 
 	/* Configure device attribute */
 	sysfs_attr_init(&counter_attr->dev_attr.attr);
-	counter_attr->dev_attr.attr.name = "name";
+	counter_attr->dev_attr.attr.name = attr_name;
 	counter_attr->dev_attr.attr.mode = 0444;
 	counter_attr->dev_attr.show = counter_comp_name_show;
 
@@ -519,6 +520,18 @@ static int counter_name_attr_create(struct device *const dev,
 	return 0;
 }
 
+static int counter_ext_name_attr_create(struct device *const dev,
+	struct counter_attribute_group *const group, const size_t i,
+	const char *const name)
+{
+	const char *attr_name;
+
+	attr_name = devm_kasprintf(dev, GFP_KERNEL, "extension%zu_name", i);
+	if (!attr_name)
+		return -ENOMEM;
+
+	return counter_name_attr_create(dev, group, attr_name, name);
+}
 
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
@@ -534,6 +547,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -543,14 +557,19 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 		return err;
 
 	/* Create Signal name attribute */
-	err = counter_name_attr_create(dev, group, signal->name);
+	err = counter_name_attr_create(dev, group, "name", signal->name);
 	if (err < 0)
 		return err;
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < signal->num_ext; i++) {
-		err = counter_attr_create(dev, group, signal->ext + i, scope,
-					  signal);
+		ext = signal->ext + i;
+
+		err = counter_attr_create(dev, group, ext, scope, signal);
+		if (err < 0)
+			return err;
+
+		err = counter_ext_name_attr_create(dev, group, i, ext->name);
 		if (err < 0)
 			return err;
 	}
@@ -636,6 +655,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -646,7 +666,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 		return err;
 
 	/* Create Count name attribute */
-	err = counter_name_attr_create(dev, group, count->name);
+	err = counter_name_attr_create(dev, group, "name", count->name);
 	if (err < 0)
 		return err;
 
@@ -660,8 +680,13 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < count->num_ext; i++) {
-		err = counter_attr_create(dev, group, count->ext + i, scope,
-					  count);
+		ext = count->ext + i;
+
+		err = counter_attr_create(dev, group, ext, scope, count);
+		if (err < 0)
+			return err;
+
+		err = counter_ext_name_attr_create(dev, group, i, ext->name);
 		if (err < 0)
 			return err;
 	}
@@ -725,6 +750,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, group);
@@ -739,7 +765,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	group += counter->num_counts;
 
 	/* Create name attribute */
-	err = counter_name_attr_create(dev, group, counter->name);
+	err = counter_name_attr_create(dev, group, "name", counter->name);
 	if (err < 0)
 		return err;
 
@@ -757,8 +783,13 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < counter->num_ext; i++) {
-		err = counter_attr_create(dev, group, counter->ext + i, scope,
-					  NULL);
+		ext = counter->ext + i;
+
+		err = counter_attr_create(dev, group, ext, scope, NULL);
+		if (err < 0)
+			return err;
+
+		err = counter_ext_name_attr_create(dev, group, i, ext->name);
 		if (err < 0)
 			return err;
 	}
-- 
2.30.0

