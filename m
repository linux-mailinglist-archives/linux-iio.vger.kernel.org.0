Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C135F41BD2E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 05:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhI2DSP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 23:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbhI2DSO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 23:18:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0478C061745;
        Tue, 28 Sep 2021 20:16:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so769753pjb.4;
        Tue, 28 Sep 2021 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZCX6l6rPkwSUwDGpanKFUA22NwjyP3olTKYpKgLOP0=;
        b=UBYDsbSmiAdeqzoK0lYePg387mljjtNkfOL5zjqunA1iTil8qkxyOh7m1yNojsPMeB
         ZQ30GEqz9lBqEVPxHRELpm1pB2RXwyvFDILe1/ljlImQFgYVYzld33Iwa1xycfy4qnFZ
         zwklNYSJ9EX39cb0w0QchKs5RB6G9FGkhdwO5R1eP5+3Y8rt9IaZ1cRaqjchbh+AXPtV
         uAXdOym7WBduGCQrUWJOM36WA+sRoFX5oacGACMo7MrElbmliu27g5BeDscAFcuh0A7a
         cChfJYYlSzGWORde4BgXfjId7W00M2KdGVpFWIqeGoCyTBIeBsdJLWZlW5yKI/eVahlZ
         H8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZCX6l6rPkwSUwDGpanKFUA22NwjyP3olTKYpKgLOP0=;
        b=ww6M1iD/kuz+vLFbL0CCq6Xu4qi868C+05xEiF9Pp/oOb548/UKf/w4hh92ZgEfljp
         pEw85hiPDpBuMDNExVka9p6rBhuR9f/Iov9ah2PljUgNNxF3ybMiFqLWRUnETerElFus
         H+aK69NZcqqVQvM2rKLwV0ujoNbcwDQMSpgKT2wzDcX/CA8mK18GVEDo87SFrrxXlS7k
         IvlxJGr+ghCoIAQnyRkZW+//QzOVqG4U5vuwaou1iDzxJi7Ex1ZJRU1vEjafN34QjKzm
         Kw16RooZ/sHIz3cFqS4QhUJspjR7+HonLaIs2PT/JsKgLJ7nWSHF8soD6QUIhHlZap8n
         cIjA==
X-Gm-Message-State: AOAM530CbtxOCAS/Yovahkw6lw72haoDTDhdujgP8rZMdsKQqolC4VCG
        iEwr9Tk1oypMIOC5lSzyDyA=
X-Google-Smtp-Source: ABdhPJw+pGXvad4GoCAkpWu5pR5c2sAi96CsuR8Ivvu1vBMAjxtRXb/rcDloD/HioA+ptVoLRixeew==
X-Received: by 2002:a17:90a:9509:: with SMTP id t9mr2582652pjo.149.1632885393205;
        Tue, 28 Sep 2021 20:16:33 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 65sm464203pfv.210.2021.09.28.20.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:16:32 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v17 1/9] counter: Move counter enums to uapi header
Date:   Wed, 29 Sep 2021 12:15:58 +0900
Message-Id: <962a5f2027fafcf4f77c10e1baf520463960d1ee.1632884256.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1632884256.git.vilhelm.gray@gmail.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8d1ea0299004..3c95ada1b830 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4820,6 +4820,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
+F:	include/uapi/linux/counter.h
 
 CP2615 I2C DRIVER
 M:	Bence Csókás <bence98@sch.bme.hu>
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 445f22d8bfe2..7c9f7e23953a 100644
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
2.33.0

