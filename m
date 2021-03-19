Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2707E341AEB
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCSLD3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhCSLDK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:03:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6BC06174A;
        Fri, 19 Mar 2021 04:03:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ha17so4486720pjb.2;
        Fri, 19 Mar 2021 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpFvI7Hr2xnxZZJp2f4SLiB8ePysZG2/PXUscKLYdTM=;
        b=gTvA3Rk2UCYebE1TVVgbqZDlJZMGTNotD3E0b/waW/Ra43vwNvnBt/klOyNt0kSzts
         09F4yWVqE7EcxuuGpuUZo4pj/f9U9LikUcKqLKUX0Ie5J91GtdPzD7W7MQNY8qChwl3o
         0KrwsHAg5R5F0nOoyQ6LcAbS5UOy3mLA+27GrWScs8JnHMmGUf362wrxDjOPusXVOwJg
         it8pfXrUCMXKTuW3uYWe/bwqiyOJAZplC/doRHwshOCi0E1dKh2nEI2P+hbicDZzjiSf
         MKKJJVjpTuRfjiDkqk3azGwNdg7Ys2kSFXt+L+/gKcGMO6B1BQTKajEnwV7yWO719EF+
         X2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpFvI7Hr2xnxZZJp2f4SLiB8ePysZG2/PXUscKLYdTM=;
        b=s59FwR85WWdf1xUQ2fMtksrWJwKI0tWa6jDmgrnXoMHGDADHAfKxYyd+f69YEy/PxN
         22KDblnIE8ZpPZcS2+TorgSLlkHt06f2CN+LXzWbRbIwfpvg6KkDFVF6Y6Ar1XP28xiv
         7NfFd6N1jJRn0kbMNpee+wJTfxNt3IiSMfDKtaDwcuecwHP2fXZEhosJK1/WdcWzoVny
         /MtLjbMXixfmCH0wSbFByLeMkfQHslOg/oZzCJnlUmycHgzsI5c2XLWeDriS8MEKHlqj
         pjLnSqMU5i2IDWZjbrP9+j2mp1Nx52xmgYyaO3XHRmvn8u+OdrUo0chQLh/d3qN7yofN
         nEng==
X-Gm-Message-State: AOAM531hWwad/te2UnSnP2gOl/agxHca1p00vbTbb7b8hY+rML4QYxrt
        rh6obse5J4uqOcRy517I9LU=
X-Google-Smtp-Source: ABdhPJzkOB8WSdT8am3pdoAQWkCp1OmHCwNZK6vBKQVREzmBLXf4IJ0tqJOZvJOQcfJVOIvrGW1/2g==
X-Received: by 2002:a17:90b:e01:: with SMTP id ge1mr9498567pjb.117.1616151790035;
        Fri, 19 Mar 2021 04:03:10 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:03:09 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 25/33] counter: Move counter enums to uapi header
Date:   Fri, 19 Mar 2021 20:00:44 +0900
Message-Id: <06e8a19be3e71b1da55c1e2813b669fcfd6bbd34.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is in preparation for a subsequent patch implementing a character
device interface for the Counter subsystem.

Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                  |  1 +
 include/linux/counter.h      | 42 +--------------------------
 include/uapi/linux/counter.h | 56 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 41 deletions(-)
 create mode 100644 include/uapi/linux/counter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1508db256784..93233a07f5aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4581,6 +4581,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
+F:	include/uapi/linux/counter.h
 
 CPMAC ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
diff --git a/include/linux/counter.h b/include/linux/counter.h
index e7fd6d81a929..eee85db8e332 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <uapi/linux/counter.h>
 
 struct counter_device;
 struct counter_count;
@@ -27,47 +28,6 @@ enum counter_comp_type {
 	COUNTER_COMP_COUNT_MODE,
 };
 
-enum counter_scope {
-	COUNTER_SCOPE_DEVICE,
-	COUNTER_SCOPE_SIGNAL,
-	COUNTER_SCOPE_COUNT,
-};
-
-enum counter_count_direction {
-	COUNTER_COUNT_DIRECTION_FORWARD,
-	COUNTER_COUNT_DIRECTION_BACKWARD,
-};
-
-enum counter_count_mode {
-	COUNTER_COUNT_MODE_NORMAL,
-	COUNTER_COUNT_MODE_RANGE_LIMIT,
-	COUNTER_COUNT_MODE_NON_RECYCLE,
-	COUNTER_COUNT_MODE_MODULO_N,
-};
-
-enum counter_function {
-	COUNTER_FUNCTION_INCREASE,
-	COUNTER_FUNCTION_DECREASE,
-	COUNTER_FUNCTION_PULSE_DIRECTION,
-	COUNTER_FUNCTION_QUADRATURE_X1_A,
-	COUNTER_FUNCTION_QUADRATURE_X1_B,
-	COUNTER_FUNCTION_QUADRATURE_X2_A,
-	COUNTER_FUNCTION_QUADRATURE_X2_B,
-	COUNTER_FUNCTION_QUADRATURE_X4,
-};
-
-enum counter_signal_level {
-	COUNTER_SIGNAL_LEVEL_LOW,
-	COUNTER_SIGNAL_LEVEL_HIGH,
-};
-
-enum counter_synapse_action {
-	COUNTER_SYNAPSE_ACTION_NONE,
-	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
-	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
-};
-
 /**
  * struct counter_comp - Counter component node
  * @type:		Counter component data type
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
new file mode 100644
index 000000000000..6113938a6044
--- /dev/null
+++ b/include/uapi/linux/counter.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace ABI for Counter character devices
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _UAPI_COUNTER_H_
+#define _UAPI_COUNTER_H_
+
+/* Component scope definitions */
+enum counter_scope {
+	COUNTER_SCOPE_DEVICE,
+	COUNTER_SCOPE_SIGNAL,
+	COUNTER_SCOPE_COUNT,
+};
+
+/* Count direction values */
+enum counter_count_direction {
+	COUNTER_COUNT_DIRECTION_FORWARD,
+	COUNTER_COUNT_DIRECTION_BACKWARD,
+};
+
+/* Count mode values */
+enum counter_count_mode {
+	COUNTER_COUNT_MODE_NORMAL,
+	COUNTER_COUNT_MODE_RANGE_LIMIT,
+	COUNTER_COUNT_MODE_NON_RECYCLE,
+	COUNTER_COUNT_MODE_MODULO_N,
+};
+
+/* Count function values */
+enum counter_function {
+	COUNTER_FUNCTION_INCREASE,
+	COUNTER_FUNCTION_DECREASE,
+	COUNTER_FUNCTION_PULSE_DIRECTION,
+	COUNTER_FUNCTION_QUADRATURE_X1_A,
+	COUNTER_FUNCTION_QUADRATURE_X1_B,
+	COUNTER_FUNCTION_QUADRATURE_X2_A,
+	COUNTER_FUNCTION_QUADRATURE_X2_B,
+	COUNTER_FUNCTION_QUADRATURE_X4,
+};
+
+/* Signal values */
+enum counter_signal_level {
+	COUNTER_SIGNAL_LEVEL_LOW,
+	COUNTER_SIGNAL_LEVEL_HIGH,
+};
+
+/* Action mode values */
+enum counter_synapse_action {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+};
+
+#endif /* _UAPI_COUNTER_H_ */
-- 
2.30.2

