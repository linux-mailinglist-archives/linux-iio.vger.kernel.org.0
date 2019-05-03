Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F61351A
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfECWC5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:02:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45401 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfECWC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:02:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so3328554pgi.12
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpZvwbwPYf0W1R0nI9DxhgS6xPRoVjEGctnuxzxQJHk=;
        b=DipJLBxoHg1BLPKIRZddMWg/EqPnObfT+6lYTDOxLu21MmXIkTYwph/62KDAqyDefh
         Up+0e0LNnMggYvpeGKk1BtJQxx5gvZKDPMvjEjB5oeJ1sH3YvwNaMXAf83CEiaRnyrs2
         8dQ5vtMP6WlDZJLKwu5eU0LY6rewLcCuc9AZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpZvwbwPYf0W1R0nI9DxhgS6xPRoVjEGctnuxzxQJHk=;
        b=FAb169gL7yMsyRDbtUxpAhvgg2NJDor0mVtkynu3LOMiUQMuJ0/ksCCtz+PgBgK8KG
         MI8/guOqy1ySpKoXCmGZ7eQQnWQ5g6JfiBKUCo44/yG/uDjBIlz9RHt3G9xZUSCusSWk
         aSm6sqBRWaGTQ8zFveg4LmQROYpkSHDOETQvFnG3uAgUTnBJHe0pjN+/zuIiP+Y0qgTV
         tZajkpA9GSB8e30Oi5hnrI24lkqnoqHVLPXF/tnuHfcNFAb/1AN0N7JaLjIQIWx2CXJZ
         Ao4p2joAkMkbrZKOD465NATtWe/xh2BptJcQjWtSaDaBxDj8F2kt1HWIUo9WQFogAZw8
         2Pmg==
X-Gm-Message-State: APjAAAVKUXNnvzsrsJ2+zXSHSxDpoT/8GEAYHZC5ZyZd/5pmJoOmGFiK
        OF+aTLWbevnU9c8bkCYeK7yjbw==
X-Google-Smtp-Source: APXvYqyeAHIyL2YmcO+ypKIGK7enHbm/KXpWVRaOzEMqlfkAxyMgome5IOAVzPA+81fPABPUXt83TA==
X-Received: by 2002:a63:1e0c:: with SMTP id e12mr13199791pge.218.1556920976472;
        Fri, 03 May 2019 15:02:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l10sm9412937pfc.46.2019.05.03.15.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:02:55 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 08/30] mfd: cros_ec: move HDMI CEC API definition
Date:   Fri,  3 May 2019 15:02:11 -0700
Message-Id: <20190503220233.64546-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move near the end of file.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 148 ++++++++++++++-------------
 1 file changed, 75 insertions(+), 73 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 6538c5789c43..67e15c29e083 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3124,6 +3124,81 @@ struct ec_response_battery_vendor_param {
 } __ec_align4;
 
 /*****************************************************************************/
+/*
+ * HDMI CEC commands
+ *
+ * These commands are for sending and receiving message via HDMI CEC
+ */
+
+#define MAX_CEC_MSG_LEN 16
+
+/* CEC message from the AP to be written on the CEC bus */
+#define EC_CMD_CEC_WRITE_MSG 0x00B8
+
+/**
+ * struct ec_params_cec_write - Message to write to the CEC bus
+ * @msg: message content to write to the CEC bus
+ */
+struct ec_params_cec_write {
+	uint8_t msg[MAX_CEC_MSG_LEN];
+} __ec_align1;
+
+/* Set various CEC parameters */
+#define EC_CMD_CEC_SET 0x00BA
+
+/**
+ * struct ec_params_cec_set - CEC parameters set
+ * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ * @val: in case cmd is CEC_CMD_ENABLE, this field can be 0 to disable CEC
+ *	or 1 to enable CEC functionality, in case cmd is
+ *	CEC_CMD_LOGICAL_ADDRESS, this field encodes the requested logical
+ *	address between 0 and 15 or 0xff to unregister
+ */
+struct ec_params_cec_set {
+	uint8_t cmd; /* enum cec_command */
+	uint8_t val;
+} __ec_align1;
+
+/* Read various CEC parameters */
+#define EC_CMD_CEC_GET 0x00BB
+
+/**
+ * struct ec_params_cec_get - CEC parameters get
+ * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ */
+struct ec_params_cec_get {
+	uint8_t cmd; /* enum cec_command */
+} __ec_align1;
+
+/**
+ * struct ec_response_cec_get - CEC parameters get response
+ * @val: in case cmd was CEC_CMD_ENABLE, this field will 0 if CEC is
+ *	disabled or 1 if CEC functionality is enabled,
+ *	in case cmd was CEC_CMD_LOGICAL_ADDRESS, this will encode the
+ *	configured logical address between 0 and 15 or 0xff if unregistered
+ */
+struct ec_response_cec_get {
+	uint8_t val;
+} __ec_align1;
+
+/* CEC parameters command */
+enum cec_command {
+	/* CEC reading, writing and events enable */
+	CEC_CMD_ENABLE,
+	/* CEC logical address  */
+	CEC_CMD_LOGICAL_ADDRESS,
+};
+
+/* Events from CEC to AP */
+enum mkbp_cec_event {
+	/* Outgoing message was acknowledged by a follower */
+	EC_MKBP_CEC_SEND_OK			= BIT(0),
+	/* Outgoing message was not acknowledged */
+	EC_MKBP_CEC_SEND_FAILED			= BIT(1),
+};
+
+/*****************************************************************************/
+
 /* Commands for I2S recording on audio codec. */
 
 #define EC_CMD_CODEC_I2S 0x00BC
@@ -3252,79 +3327,6 @@ struct ec_params_reboot_ec {
  */
 #define EC_CMD_GET_PANIC_INFO 0x00D3
 
-/*****************************************************************************/
-/*
- * HDMI CEC commands
- *
- * These commands are for sending and receiving message via HDMI CEC
- */
-#define EC_MAX_CEC_MSG_LEN 16
-
-/* CEC message from the AP to be written on the CEC bus */
-#define EC_CMD_CEC_WRITE_MSG 0x00B8
-
-/**
- * struct ec_params_cec_write - Message to write to the CEC bus
- * @msg: message content to write to the CEC bus
- */
-struct ec_params_cec_write {
-	uint8_t msg[EC_MAX_CEC_MSG_LEN];
-} __ec_align1;
-
-/* Set various CEC parameters */
-#define EC_CMD_CEC_SET 0x00BA
-
-/**
- * struct ec_params_cec_set - CEC parameters set
- * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
- * @val: in case cmd is CEC_CMD_ENABLE, this field can be 0 to disable CEC
- *	or 1 to enable CEC functionality, in case cmd is CEC_CMD_LOGICAL_ADDRESS,
- *	this field encodes the requested logical address between 0 and 15
- *	or 0xff to unregister
- */
-struct ec_params_cec_set {
-	uint8_t cmd; /* enum cec_command */
-	uint8_t val;
-} __ec_align1;
-
-/* Read various CEC parameters */
-#define EC_CMD_CEC_GET 0x00BB
-
-/**
- * struct ec_params_cec_get - CEC parameters get
- * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
- */
-struct ec_params_cec_get {
-	uint8_t cmd; /* enum cec_command */
-} __ec_align1;
-
-/**
- * struct ec_response_cec_get - CEC parameters get response
- * @val: in case cmd was CEC_CMD_ENABLE, this field will 0 if CEC is
- *	disabled or 1 if CEC functionality is enabled,
- *	in case cmd was CEC_CMD_LOGICAL_ADDRESS, this will encode the
- *	configured logical address between 0 and 15 or 0xff if unregistered
- */
-struct ec_response_cec_get {
-	uint8_t val;
-} __ec_align1;
-
-/* CEC parameters command */
-enum ec_cec_command {
-	/* CEC reading, writing and events enable */
-	CEC_CMD_ENABLE,
-	/* CEC logical address  */
-	CEC_CMD_LOGICAL_ADDRESS,
-};
-
-/* Events from CEC to AP */
-enum mkbp_cec_event {
-	/* Outgoing message was acknowledged by a follower */
-	EC_MKBP_CEC_SEND_OK			= BIT(0),
-	/* Outgoing message was not acknowledged */
-	EC_MKBP_CEC_SEND_FAILED			= BIT(1),
-};
-
 /*****************************************************************************/
 /*
  * Special commands
-- 
2.21.0.1020.gf2820cf01a-goog

