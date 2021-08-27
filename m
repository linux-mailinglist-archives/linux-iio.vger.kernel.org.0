Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51A3F9334
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbhH0Dtf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbhH0Dte (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:49:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B231C061757;
        Thu, 26 Aug 2021 20:48:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w7so3743828pgk.13;
        Thu, 26 Aug 2021 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ypwnfKh0p+YFQpf1Js7n+ZaGNOVRvB9bmOSgk4sJGWY=;
        b=SJxOgiATG7NKPZcA23xJLrSo89lu4FSZxkHgLSHxNYHNg3y7ZpJ1voCYdWE3Ke2LzL
         b0tVWamrmvM71pOAkmSwZqlvkT2TmxGoCCmwObwLnfEm6jfPk7t6GIxNKlLqCJ0DBOG7
         RsJjI/aw2gXKUMKUvdCpwcGc4k6avNEmfkLLYtUjAB8sCwabWs9vjDtP6yPxqkde8jxf
         Q2sWOMfnMDIcG+7jGH75aDq1rC9Fh8+Ks+P5uTxAsf1WzfswWY/pqTDE+h6hVQ5CPEKZ
         CxOcOls4gvH3TGIVsw5fUqxTCF65ZMhOcqsoYnK3bQZ9dnT8Y/WUNPjaUp7Y8YLMjHmE
         1uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypwnfKh0p+YFQpf1Js7n+ZaGNOVRvB9bmOSgk4sJGWY=;
        b=QJ4cDgu/pGxCQhY8wOdwLikPipsZXQDa3R+WVCZnrXZ2c/oWgQO4mkNKIY2w7ZRehO
         abBLO/+t58KBsR9F+c4P1bPDhtaQeMvGM/J62US4ku9/eHQy2uUBueGLyAUAfTS8BRY/
         RIqlIE8XrtRYfu4YxM+dEFwDyuW8sZUqs1QizlxQvp/sePsV8E41G/5YYShg3ge70FQb
         YN3BNDiLJnXAZWn4ejVDYFJ/wRYu/7EfuSUep+bZRG3YPm8de6s88XamWfhB3yHsWIop
         lKkwQDqhpLqvbjyaOoSdAW+3y3aW11PzKiMhi3N172iBPpDeRRhce6Pr1NMezpYwGhv3
         aL/Q==
X-Gm-Message-State: AOAM530JwhejNrG7KrhZ7afJHn1MpA9YFpkfQWn9OsYAHU99eQUFF6nQ
        MMBKjJW4ef9mRWyxmeKxO08=
X-Google-Smtp-Source: ABdhPJyvpmqipez6ESDNkQTpuTJnFgkMXnq4/afmP7C+uJuGKS+paISS7tqJEUvRNelWWK9oIZ6NlQ==
X-Received: by 2002:aa7:90c8:0:b029:32c:935f:de5f with SMTP id k8-20020aa790c80000b029032c935fde5fmr6992382pfk.79.1630036125667;
        Thu, 26 Aug 2021 20:48:45 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:48:45 -0700 (PDT)
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
Subject: [PATCH v16 06/14] counter: Move counter enums to uapi header
Date:   Fri, 27 Aug 2021 12:47:50 +0900
Message-Id: <2d854e54adf08f72b3ff6312882e7735dc597349.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
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
index b0cdb9aaca85..f2fdd2202605 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4781,6 +4781,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter
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
2.32.0

