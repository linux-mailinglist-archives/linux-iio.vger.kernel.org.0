Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF463A095D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhFIBgO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbhFIBgG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:36:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4824EC061789;
        Tue,  8 Jun 2021 18:34:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v11so3205739ply.6;
        Tue, 08 Jun 2021 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZPkQDIgQv991NEbsdFosEJ9iScwg7tVuIFv0Tif7m4=;
        b=YDX69ZJIpInHQVn+/n/MAyQdT/y+Siqt3tBAUHwAvTYky5VGbR7cTteAwlnClKmKRD
         eV1nx3oB4nFVgYKpL/UR/nLUcO8sJw83Loos9+r2HVq4/IVZeT90udQ7Dh/cHXmYyO9v
         ptMOfjltw4DL+Xw8UMlaKjtxDrbJU4ph6s/BKVKq9vPAbVjbxA3O700IWU75ADda+eRQ
         wGMof1nbHp5As/YvtRc3B0dShtrOl+DbfTaQ3Rh9UYFJ/0nuMZxP+ENgPIocmvXzL0J6
         T5zGXZ1fPgDBYfy1Igq8gEcY6CMYq0hMblxshQpldU3YgAc8CMHVfpsBuJexNW5o2+AC
         v8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZPkQDIgQv991NEbsdFosEJ9iScwg7tVuIFv0Tif7m4=;
        b=Wk4dRMspydodEznJ/ELu8tTuoULCDbF3ZQfjDVuACi+cJQCc4zYKcG76JjEAJhkE/i
         PLAMNlu3nlzQhUQGx87BlZo7v1SWd9bQ5/TBH5CHS88q2+fzp2OdWUoB34Q8hOZtj3Uk
         G5v63k9GgDYTBM4gxhVCl7HFWxsJASq4kRqMMunWWVSl3LJ7zDpQ2ksDKqegXYewobje
         p4Fv0C8TeWrXvbf7QHhbstF6d5XY0iIApohYP53joGWrOp8X2il5DYVu0rRKlM1mpmQV
         OBaHFefYcX9ByT+zypFDVw2D01k1+Cyj7NndB3+aJ5NSRrHTo9C9thhavrJVYTGZKTBn
         LgqA==
X-Gm-Message-State: AOAM531Ge+eMVVxhd8d0322eWhsmDy6KtTBjTpHCIjN9JsvzZQP3Cfxt
        HgHyqFJG16W8KGbNkWSm+U6S05ZGPs15gw==
X-Google-Smtp-Source: ABdhPJyWtrfWSIzc7uw0gYz6wGAIC5CsnIHWfugO8YgQTR3okfWiMlyLJISvLXB+0MePUpibfCPTjw==
X-Received: by 2002:a17:90a:117:: with SMTP id b23mr29368072pjb.183.1623202439926;
        Tue, 08 Jun 2021 18:33:59 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:59 -0700 (PDT)
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
Subject: [PATCH v11 25/33] counter: Move counter enums to uapi header
Date:   Wed,  9 Jun 2021 10:31:28 +0900
Message-Id: <7bd08992a96ab3e2947c309fe7ff8335d7262a93.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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
index 0acde40d682c..7e2ddf74bd7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4678,6 +4678,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
+F:	include/uapi/linux/counter.h
 
 CP2615 I2C DRIVER
 M:	Bence Csókás <bence98@sch.bme.hu>
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
2.32.0

