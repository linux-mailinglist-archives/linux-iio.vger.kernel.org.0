Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CC43DED90
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhHCMIS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbhHCMIN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:08:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867D2C0613D5;
        Tue,  3 Aug 2021 05:08:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so3567412pjs.0;
        Tue, 03 Aug 2021 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aujji+42NnuAmjXYd1m2CztTTlNY+0bpT1pWUi5S9DQ=;
        b=vLlEpy0KqSmxb+X7h98graHE7sh28rpq5DgAYRwJcPZ2lBgutfOwxARrcKGD7PYXsl
         IpWoXJ6CWSqerdjWVzDSHaiHfl/kLOJIrBf4LEuNjXorhhWS26h0UNbhp7QlaF64Rfvo
         VDuxLHifxjJpBSgg/PriWQ7NOJ/St/LBvz966uSX2Q9wF56Ee/baXR7MIIRW9fHTpFuG
         8WRT+7ikTHp5RxgQQBKY7LRqQQh9hMA/1bby7zeN0qqaSgVvS/9/UIXv6Q6BFhtSwbaq
         U/CU/g9nipENoBaX3TPZiHEwGFAP7emP0EglqBF6me+Ar4HFwB9I24rErDpS5DfaqqH7
         yHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aujji+42NnuAmjXYd1m2CztTTlNY+0bpT1pWUi5S9DQ=;
        b=F5dONRHBjRlMlfse5z5YneldEJKA/xKDpXPrpHk/YFyMydxU6WC4m76OsLPLNN12dP
         t+17jQx07ppw0FwE2RLMXySUCWZx8U3C2CwxeZuimYaVGpM3MNJerU4iHXk0HGvi+hpV
         H6cSbbCYMCfqJv4276WsBumrAlg0dy4xq9jg0p+4Ol+H7dGUSFtsVN084AIRNL08qeiN
         7c25jlFeaz/GbXGNbO3SxgKiuZkdfYs1dGZDd569JpytjbcIKOxncIFSsxD0So0nfw01
         t9qXaQtyI6Bka7KqJMH7mtjVq3k+Ks0+I0+znYgos0gQt5ZuWA1ar9KZLM63D61aou7V
         /cfw==
X-Gm-Message-State: AOAM5309f7ladbtO0hKd3J1x+slUGjPHxj86ZbVHPDnqx0hgFwE3qhgV
        I7FeauUeIiFus+iZ0Q8QUZE=
X-Google-Smtp-Source: ABdhPJwrzSqliMUsNLHZe1oHty0EWtIecxH6Iq94A/WgND5jNViLQpzVF0/JDfNzh6m3J6QU15cXOw==
X-Received: by 2002:a05:6a00:1a49:b029:3c4:3184:bfda with SMTP id h9-20020a056a001a49b02903c43184bfdamr1646988pfv.16.1627992482158;
        Tue, 03 Aug 2021 05:08:02 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n35sm7197502pfv.152.2021.08.03.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:08:01 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v14 14/17] counter: Implement *_component_id sysfs attributes
Date:   Tue,  3 Aug 2021 21:06:24 +0900
Message-Id: <8c0a574f52b6b42961c7c0aed6bca9a35339a0f4.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-counter | 16 +++++++++-
 drivers/counter/counter-sysfs.c             | 33 +++++++++++++++++----
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 9809d8a47431..e0e99adb0ecc 100644
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
 KernelVersion:	5.15
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Read-only attribute that indicates the component ID of the
-		respective Synapse of Count Y for Signal Z.
+		respective extension or Synapse.
 
 What:		/sys/bus/counter/devices/counterX/countY/spike_filter_ns
 KernelVersion:	5.14
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 11bef9f8190f..df1d75e0d7b8 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -588,6 +588,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -603,8 +604,14 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < signal->num_ext; i++) {
-		err = counter_attr_create(dev, cattr_group, signal->ext + i,
-					  scope, signal);
+		ext = &signal->ext[i];
+
+		err = counter_attr_create(dev, cattr_group, ext, scope, signal);
+		if (err < 0)
+			return err;
+
+		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
+						  i);
 		if (err < 0)
 			return err;
 	}
@@ -695,6 +702,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -719,8 +727,14 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < count->num_ext; i++) {
-		err = counter_attr_create(dev, cattr_group, count->ext + i,
-					  scope, count);
+		ext = &count->ext[i];
+
+		err = counter_attr_create(dev, cattr_group, ext, scope, count);
+		if (err < 0)
+			return err;
+
+		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
+						  i);
 		if (err < 0)
 			return err;
 	}
@@ -784,6 +798,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, cattr_group);
@@ -816,8 +831,14 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < counter->num_ext; i++) {
-		err = counter_attr_create(dev, cattr_group, counter->ext + i,
-					  scope, NULL);
+		ext = &counter->ext[i];
+
+		err = counter_attr_create(dev, cattr_group, ext, scope, NULL);
+		if (err < 0)
+			return err;
+
+		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
+						  i);
 		if (err < 0)
 			return err;
 	}
-- 
2.32.0

