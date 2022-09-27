Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77FC5ED079
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiI0WyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiI0WyN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:13 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ABECF4B3
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:12 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13175b79807so5137470fac.9
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IevjLYZWe9tsLyOFzg37+cXAWlF3HP2aFWQuERAyz5A=;
        b=ukKxclW1ytzXKj6woU7axpA+gQGFnvT9sR5jqbzXuoZu+viXO/KuEZkNzr1GboxOdT
         nqf+v33qNwiPCWPVUw0abYQTEJQCghbVjOFW/TTXon42d/fjIYg5KRfBVCV097KSxXnc
         VRRGx7w/qQKoqOMNQ82yXAQipXutuq2b7HF/hEjaatCqOx8HKCdJunYQ6FchggLyFtz2
         62t0GpFsm0sRFxp+KRYITO3yrxhIVzpPB0iaKoucEOFIH/Hhzq27yYyDBsGNgH3PvwVJ
         sWFDJPr1tQI0Xtgf57jqK2Yimt9X2bhonG5reF5DV+vN3Yx1mCVdw6diA2T0P45C32Ul
         u7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IevjLYZWe9tsLyOFzg37+cXAWlF3HP2aFWQuERAyz5A=;
        b=KsyZN0fZ3UiH0cBlEKFA7ImJuYVYWEScCPBnQa3zE4v0rxpvn4nrl0MZvae7B0vIjd
         +TjaimAkRWG/NWbhmzQKgpDAQCqxrPKwzxapgAbECYCbgWglumsgKnUHDtMemnPkKx27
         5xhkYpXzcPqSKNHOHWyvHINi69OiMrfNd81cu4lK9yyowtt3K6KH6pXGNQbv2NH1HzaG
         WWOkGaqpuNiNy1PhnwqIZdZjacs2HVKznwUVBkleZH+Wmyp7CQ9i2Y9ipRplXWy0yFoi
         CYwA/Orp2JYOofjx8OvnEQzr9rH2HZCXYbxCrioH/iycta0hYG1ZHuBHvnrmYQSmVHpg
         ci5Q==
X-Gm-Message-State: ACrzQf056VzeEjwa798vNQ6IfJ1JFXrscg0jhnNsWOp8Qp1IMnfUYbOe
        wAkznI7T2gwPNs3Qtgaxiy4WyC07bxgUNw==
X-Google-Smtp-Source: AMsMyM7ZjxyL1+Odk/m/s7QJiHTB2eq7uXA4LusDYdvP8wVs9gBSKf5tFJ+TWY+A8n9EamMnce5KZA==
X-Received: by 2002:a05:6871:7a1:b0:131:946a:7b30 with SMTP id o33-20020a05687107a100b00131946a7b30mr1825083oap.67.1664319251636;
        Tue, 27 Sep 2022 15:54:11 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:11 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 07/12] counter: Consolidate Counter extension sysfs attribute creation
Date:   Tue, 27 Sep 2022 18:53:41 -0400
Message-Id: <0469c3ae3fbccbca908993c78d94f221761a6a3a.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Counter extensions are handled for the Device, Counts, and Signals. The
code loops through each Counter extension and creates the expected sysfs
attributes. This patch consolidates that code into functions to reduce
redundancy and make the intention of the code clearer.

Link: https://lore.kernel.org/r/6f2121cf52073028c119dbf981a8b72f3eb625d2.1664204990.git.william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/counter-sysfs.c | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index e5dd36e1a45f..b393da402e0b 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -592,6 +592,46 @@ static int counter_comp_id_attr_create(struct device *const dev,
 	return 0;
 }
 
+static int counter_ext_attrs_create(struct device *const dev,
+				    struct counter_attribute_group *const group,
+				    const struct counter_comp *const ext,
+				    const enum counter_scope scope,
+				    void *const parent, const size_t id)
+{
+	int err;
+
+	/* Create main extension attribute */
+	err = counter_attr_create(dev, group, ext, scope, parent);
+	if (err < 0)
+		return err;
+
+	/* Create extension id attribute */
+	return counter_comp_id_attr_create(dev, group, ext->name, id);
+}
+
+static int counter_sysfs_exts_add(struct device *const dev,
+				  struct counter_attribute_group *const group,
+				  const struct counter_comp *const exts,
+				  const size_t num_ext,
+				  const enum counter_scope scope,
+				  void *const parent)
+{
+	size_t i;
+	const struct counter_comp *ext;
+	int err;
+
+	/* Create attributes for each extension */
+	for (i = 0; i < num_ext; i++) {
+		ext = &exts[i];
+		err = counter_ext_attrs_create(dev, group, ext, scope, parent,
+					       i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
 	.name = "signal",
@@ -605,8 +645,6 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -620,21 +658,9 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < signal->num_ext; i++) {
-		ext = &signal->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, signal);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Signal extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, signal->ext,
+				      signal->num_ext, scope, signal);
 }
 
 static int counter_sysfs_signals_add(struct counter_device *const counter,
@@ -719,8 +745,6 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -743,21 +767,9 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < count->num_ext; i++) {
-		ext = &count->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, count);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Count extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, count->ext,
+				      count->num_ext, scope, count);
 }
 
 static int counter_sysfs_counts_add(struct counter_device *const counter,
@@ -850,8 +862,6 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	const enum counter_scope scope = COUNTER_SCOPE_DEVICE;
 	struct device *const dev = &counter->dev;
 	int err;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, cattr_group);
@@ -888,19 +898,9 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < counter->num_ext; i++) {
-		ext = &counter->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, NULL);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
+	/* Add device extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, counter->ext,
+				      counter->num_ext, scope, NULL);
 
 	return 0;
 }
-- 
2.37.3

