Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B71B33829
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFCSgn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:36:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41820 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfFCSeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so1946681pgg.8
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfQnQUkcbymUnYq9zMb0kJv+NTlXje9QmmEnTJUZIB0=;
        b=BIdX7caKuRHVMYefqeW4Twu9W3C7pdvU7/l9jT+rtdRgi8QPqsdOfOuHq06uPiZ8Ra
         tpCQ47p0IKqIoWYKRDbzqjQta3XzKa7FChluEiAjI2s4JNBFO9FBiz0OUn5DdaB96jyu
         PBDFYdPiaopQcMT2jcN4MM4L6r4pHhYZ4+zFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfQnQUkcbymUnYq9zMb0kJv+NTlXje9QmmEnTJUZIB0=;
        b=cqJlpLeSHVY25V5xtXRDYRG1KACkts5yEKBtXAQudZGS5rio4z5vlKzMMQmPfmO/a0
         WCaqERMs5FJu5NFfmEBvke9jFvttRPb+e8lJE55QywMp1v81dJpSHVlXBXVM/1Q+JgU3
         +hRdGGBfCNqeR/fpgAlEgujiX/E2f3ZFWFqNyZZn/HA7yxoIB9M7HdmTqNplqV5t9/Ny
         T8t5yZUGxm+QJIsRPC62Ep5Enr7QEw/vv/zDINUJnDfYBVEzVENIspGMd+I4d7iz8UuL
         oWFCzCcZer+cq3tXGAfNZwd/Ae+5cM//x1wtylcV76VHzDmSKxhEppdXmXA5A813UGW+
         jAKg==
X-Gm-Message-State: APjAAAUPXDAf02ouZtubDOT4L3iaGPuVNDqAeMo/EuEvjnzjwK2iz7oX
        kML1Uc9GCxQUqy2ZYSL/3oaRWA==
X-Google-Smtp-Source: APXvYqycEfu4adteuR2rtA04+PLSm/3GnJfoSVrfZM6+95yFEXR5g5XJhtISRN5WCjz37zxYrpGTxQ==
X-Received: by 2002:a62:87ca:: with SMTP id i193mr6591140pfe.42.1559586859015;
        Mon, 03 Jun 2019 11:34:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j5sm15628563pfa.15.2019.06.03.11.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:18 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 08/30] mfd: cros_ec: move HDMI CEC API definition
Date:   Mon,  3 Jun 2019 11:33:39 -0700
Message-Id: <20190603183401.151408-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move near the end of file.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 148 ++++++++++++++-------------
 1 file changed, 75 insertions(+), 73 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 575066b90bab..d8bde2b5e9ce 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -3211,6 +3211,81 @@ struct ec_response_battery_vendor_param {
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
@@ -3339,79 +3414,6 @@ struct ec_params_reboot_ec {
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

