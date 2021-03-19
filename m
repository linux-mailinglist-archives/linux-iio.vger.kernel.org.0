Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CEC341AFB
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCSLD4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCSLDg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:03:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D351C06174A;
        Fri, 19 Mar 2021 04:03:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so8303520pjb.1;
        Fri, 19 Mar 2021 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2ypzjt3l7Y0nIjnP32LrmztjmBKkmNybVvXBUFclWg=;
        b=Ct5N0zQwwau/wFdCMsBwcHx1SW2FTrRIOW9OPaAmlHY5nydVmUDy08Y3Ml5h2iOfit
         oSu2GBts/Ri6XmgryW8IM2g+OetTNE9VCy71AvC/ub8lupKGxUepkRm7skL448rzW6MF
         73XkXJUGuidut0R0t0bt8sql5E/PGhkoGYgVyVbUOQSev7bSWXL+5kduKRGquWMRQ0B1
         lbC749z6pnw7yszCynIE+0ql+qt0h8x3XfAdoBv1ercGzmPePUnkgesWKsp8EeVwwQEo
         zqBPvhT5Bg8ahCQfZyueyx2cim8zre+oTyMUEwVY3Tzqd4G59i6JXEaRVjPyxxV/87tc
         ZySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2ypzjt3l7Y0nIjnP32LrmztjmBKkmNybVvXBUFclWg=;
        b=Yqwn4s0iTgNSGAyNUGP332BvAd6hBKVpJuHCJK1vhb1fsG1HLBWc13AhbMmAUTTsDe
         6IVTT9Qzqwp/GuemgjaTb9k1bwmoXDdrkW/n5P39XOSee7vicmBY4pPWBYQhZjAYyhJe
         qteIyfesDvTdo/lPg+HXqxMec9rOLqknDL7XdL9nB2JBjSTG6X8KWYfm4RyvLjBV/7LA
         pBdAvtwM3XUX6qPtqQU/DfCjzEZeqtIe2f2H+NbdHIZf/xADDn1BkyJdSVXgBVGj3RTA
         H2VfUOp8iXNbyzpS9iAgAgQyYo2iNIOBp+gEW6Wr77bEfzTzIVwp72FgG3cA9V3Z91Nu
         vJsA==
X-Gm-Message-State: AOAM533AEGn9hlbk5pAYpwIqTsUaisliSLcYbhYNDWwcZkQ9EBqg9Fz+
        tZ+y5r+4ITWBE6rHU8H3M3Q=
X-Google-Smtp-Source: ABdhPJwiIe+r6Tkd9+7/IUbMKDsG3DSeVMkRjTdmJFeGvVrhXtld2ODT29zmT+P84/yQzi4GOJOLqQ==
X-Received: by 2002:a17:902:8bcb:b029:e6:a4a1:9d7e with SMTP id r11-20020a1709028bcbb02900e6a4a19d7emr13796290plo.25.1616151815779;
        Fri, 19 Mar 2021 04:03:35 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:03:35 -0700 (PDT)
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
Subject: [PATCH v10 30/33] counter: Implement *_component_id sysfs attributes
Date:   Fri, 19 Mar 2021 20:00:49 +0900
Message-Id: <fc1424b1cc73420b2d5bb4961c0e5e1aa491a315.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Generic Counter chrdev interface expects users to supply component
IDs in order to select extensions for requests. In order for users to
know what component ID belongs to which extension this information must
be exposed. The *_component_id attribute provides a way for users to
discover what component ID belongs to which respective extension.

Cc: David Lechner <david@lechnology.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++-
 drivers/counter/counter-sysfs.c             | 30 ++++++++++++++++-----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index bee9289aecd1..57b051ba53a9 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -203,12 +203,26 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
+What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
+What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
+What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
+What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
+What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
+What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
+What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
+What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
 KernelVersion:	5.13
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Read-only attribute that indicates the component ID of the
-		respective Synapse of Count Y for Signal Z.
+		respective extension or Synapse.
 
 What:		/sys/bus/counter/devices/counterX/name
 KernelVersion:	5.2
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index bb49a10f160b..eb1505bfbd89 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -587,6 +587,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -602,8 +603,13 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 
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
+		err = counter_comp_id_attr_create(dev, group, ext->name, i);
 		if (err < 0)
 			return err;
 	}
@@ -694,6 +700,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -718,8 +725,13 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 
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
+		err = counter_comp_id_attr_create(dev, group, ext->name, i);
 		if (err < 0)
 			return err;
 	}
@@ -783,6 +795,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, group);
@@ -815,8 +828,13 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 
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
+		err = counter_comp_id_attr_create(dev, group, ext->name, i);
 		if (err < 0)
 			return err;
 	}
-- 
2.30.2

