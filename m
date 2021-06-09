Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398973A0978
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhFIBhd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:37:33 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:39626 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhFIBhd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:37:33 -0400
Received: by mail-pj1-f46.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so427496pjp.4;
        Tue, 08 Jun 2021 18:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCuW7jGka7YaAB6OGVNNNB5YUCrDqMyCoehChrk05rk=;
        b=k0Y0w7o62/ZUCq0H5IBEX46jp7+f9zMlJGF1kfDlbV1wvSK9tLDck1jyKMPeUZINBZ
         lpMg5+9xbYsxXtIFzDQEEyBCYHdVkAjuwFOrda5Fa04YpMIT+vsNL2KDFH8EiAMx0xAg
         xzXXgJ8gQLdO7tPuQ9NpUhHEaqdn/sVOmYO5FyMXXkdqLkootWWjXyGvxg3umNZ5f2aG
         7ipNHdgsIB5cJzw2Eq58OLXepLrl+g5zZxmATOFUgEUqwYy4WtjI4e5//5stDAQaF4ql
         zZFSjnV8XO/35PsGCVu6GYuaeccdI+Dsxiq+G7e5rARLsLX+xuOmuX0YMN/W9QGoIW22
         I4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCuW7jGka7YaAB6OGVNNNB5YUCrDqMyCoehChrk05rk=;
        b=BLFodSQ8WnS6jJssda1Rzfzr7y6Cj2JnPPcE2ca/B4UTxgSgaU4lgQhxz774ph3+2a
         PusdppdnTrstenqZJayz/40XHSPkC5QqOlYEjU26Asla+Z/1l8FcgENJYiOKXXadFWgg
         dxxl5AYURJHBf4Kjf83o9LPaiNuPQEd2pyD7TvQo3hhc0af0ZaDnH5QRLCCQAq7KUIQ5
         20Jbw709qvcGX6W639no1gRm/4fF/ob3YbtFxjfOmaj2lzKiQzPPAS3b7uj7rVhdH3ks
         fi8KAAk/DW/dm5J/30bRN3Hjtdc4bBTSYGuNUbHRP0lzp5eLRZ2iERusKgKfJbGGtR70
         t3RQ==
X-Gm-Message-State: AOAM53378KfLgwxGAnL+XfcAuxDldPUrZVOu+q299CiBkqno2FrTrk59
        h6rcyZZ1zAGPvkF7/zDclcI=
X-Google-Smtp-Source: ABdhPJy0Jz0zcJpFxcB9q8GW6N1TO3vkvKovbpx1oBff4zzGWOND+EWIQmi0PPwoVLu6xWHvwkOq9Q==
X-Received: by 2002:a17:90b:d95:: with SMTP id bg21mr16917682pjb.115.1623202466237;
        Tue, 08 Jun 2021 18:34:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:34:25 -0700 (PDT)
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
Subject: [PATCH v11 30/33] counter: Implement *_component_id sysfs attributes
Date:   Wed,  9 Jun 2021 10:31:33 +0900
Message-Id: <2032cf9e7bcac003306f4e43bb7552b68c8d24a9.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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
2.32.0

