Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15B3C6DF8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhGMJ5r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhGMJ5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:57:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2764EC0613EE;
        Tue, 13 Jul 2021 02:54:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y4so18645316pgl.10;
        Tue, 13 Jul 2021 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aujji+42NnuAmjXYd1m2CztTTlNY+0bpT1pWUi5S9DQ=;
        b=uu9HHbhkRlS5nGljRfGQQjz+OWc4W8dE1C4xI10hcWWcP9w7AYA3s5Ja5VNfBaJffx
         HAU057dCB/yqzdHXC2FaesY0GnDacK7JQVDClHe2RpQmIThi95dx5mFynAGw33lcGm+N
         5FabpGsm9Jodd6O29IUcqeYie0/nu8zvvR2UFt3NHKyM4Lzm0ixo4rGopUNFcn21LiGl
         nvNg2PpwGZ19FQDHsTL8YrVIHwtzbKUNvplYthoJyRs6N1Eyjv6eG1muUJnbL9Yupmug
         SaQdjsaPsI5l4BZyXeRa5+LpA/ttnOyK0Foip0Cip5+nOXBlO8TwCYk0v1oKqsmHKM4t
         bDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aujji+42NnuAmjXYd1m2CztTTlNY+0bpT1pWUi5S9DQ=;
        b=XrGn/eK7kjG+YhUocjAjnHlUaI8Y4T6iDHQKlYcynS0sWwET6gdYMD6Bdur762fY1h
         +M/jUHO6FPXK0Mbf799EsvRIidtctL0lt5kSk18TV9OG8sjzYNvjCHlkFevNa0/UOjdt
         MQpaxVGTAM7Znr+N+Em6w+iee3e1or9TEjZlt5ClGiogjk6vZfUEDtIukRbKc/6G0+7h
         WDI+sYEIRaw+wWrtHGWeD9Xxe+dArVtzgGvlK80rEUhs+QyuR3Cn+Rxq4tM1soYYRIsF
         KlWxysicBKpxaJ7vNVrtIkIrDX50/TbHXtDU4HdgtTspulCUOSf9vb9Pk1kgm+feZe4M
         uuFw==
X-Gm-Message-State: AOAM533b2paPzpX0+31LwGzi7KWU8qX4b8tPc4ks+/KeUepf2ktfimwU
        4qtdL7Zm5QjzIAKXDKPgUDY=
X-Google-Smtp-Source: ABdhPJybpvYrEOEy75sxOGZHsp9JmvmKEM7F/xpGU3JaxjGPpF+nmMkmb42oE4q5shNbTmjrzYOA4Q==
X-Received: by 2002:a65:5648:: with SMTP id m8mr3560022pgs.93.1626170096729;
        Tue, 13 Jul 2021 02:54:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:54:55 -0700 (PDT)
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
Subject: [PATCH v13 14/17] counter: Implement *_component_id sysfs attributes
Date:   Tue, 13 Jul 2021 18:53:18 +0900
Message-Id: <b018da44e8454bd4abffa6c214f20984e5311c1d.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
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

