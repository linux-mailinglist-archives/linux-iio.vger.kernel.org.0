Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B840A41BD3E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 05:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbhI2DSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 23:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbhI2DSr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 23:18:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825EC061745;
        Tue, 28 Sep 2021 20:17:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q23so744270pfs.9;
        Tue, 28 Sep 2021 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1ZJzVM7lwJIUvFTpSkZIOwRXzMuWD16wO01xh/53mc=;
        b=Eap6CAx4EhjI17O4riTzd8BatbHAQKJB3td5qsGjzQ1P2WBoaf53W+uLGS/2vlqd9p
         /JMv9dQ1rp79u970Xn8+sCOSa+G1vJWRN5vEghw5kefCO9Y4w4nd48EIg2FcgUpsiUxx
         GSXJv/NCbwtq6rFSjWyvL9EM23hMYaQzTerE2EtIKp5ArkT28UQKh9hsp2itYlLWVaue
         uTWufBMICftRLLNBabw1FQ8frXvVugTWj6XDNRHf87TjOy/va0Y7uFF5IA03qWSTLFUM
         OCqs+CYcA6U6v5cGFwEbWb5hzTUK4UGPcq0bGZIEFKtbVT+sgH7Wr20eOmj42juBeMOM
         H0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1ZJzVM7lwJIUvFTpSkZIOwRXzMuWD16wO01xh/53mc=;
        b=L9CjGCirjZoJ45NdhqVrf4As/B4A+/okSuNx+VjYSpSVi+ld7ijk8GcV28/6y5ItMx
         OcK+oXJljJqriqAeEJoWojj4KxF+VGFsdvPB78doPGvuDv7eOmVlUWDE/WlZJC5G4XC9
         HBnAvLX+mZYNFq3xzjACr96puriKXIPyFpAw9zKq2oaJjt7oRMGq5Pyzh2P9mD8NFvEm
         DQ3YyrgRl+yeeJ7mGB5h9Iy5R6uauEl5zLAeQ1HEZ4cmyzxM5Nzqg7KI7a59nG2eEPox
         qL6upZmS56Y7wZztoJVvxG5cJPt9CgHfQINYRwYhQujER/CBUxbvlcTLGgqlzanMB7+E
         OxtA==
X-Gm-Message-State: AOAM530MRO3QBNzgL0QRveMECUei1UlUwqq+SOLQdM1dD746A23brndu
        zj9XcP/A+S/Ebc8sIt24Cr4=
X-Google-Smtp-Source: ABdhPJzPOon/US/vY5mpbcPMrdaNb7yZ3ehfzoCcxEbVYLiWOpSPKQNhzQrPBmsjbjU/cfDaTG3/PQ==
X-Received: by 2002:a63:8c4d:: with SMTP id q13mr7544469pgn.92.1632885427237;
        Tue, 28 Sep 2021 20:17:07 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 65sm464203pfv.210.2021.09.28.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:17:06 -0700 (PDT)
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
Subject: [PATCH v17 6/9] counter: Implement *_component_id sysfs attributes
Date:   Wed, 29 Sep 2021 12:16:03 +0900
Message-Id: <8961a11edbb882fc689e468194f5be75f572443e.1632884256.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1632884256.git.vilhelm.gray@gmail.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
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
index aa2cd3c10d74..0ce16669157e 100644
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
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Read-only attribute that indicates the component ID of the
-		respective Synapse of Count Y for Signal Z.
+		respective extension or Synapse.
 
 What:		/sys/bus/counter/devices/counterX/countY/spike_filter_ns
 KernelVersion:	5.14
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index ee7ff1cde454..97d8d7c2a2b6 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -586,6 +586,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -601,8 +602,14 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 
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
@@ -693,6 +700,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -717,8 +725,14 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 
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
@@ -782,6 +796,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, cattr_group);
@@ -814,8 +829,14 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 
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
2.33.0

