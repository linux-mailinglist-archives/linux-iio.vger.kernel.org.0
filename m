Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA61946D
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfEIVQ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:16:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37679 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfEIVOQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so1733347pll.4
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwVaVEj7IXkfmug377A9Z+9dSGylKGF+5h+RjN0OFaU=;
        b=A/E7qhQDkeCjMU7u8vo/8V7X0hd7RW+pgz94GzLUstAg6w7yaxsyFUDxVrMLvWNZQZ
         Pas+nRZfxa+rDf65S/txv4hVSL4XrVfglmn5F7PDt7U3VE1JkiaNKp2gHc7eLUBGUM6I
         85Xp0DyL7jIGWL/6RBHnpILJVzN3k0l1yWqfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwVaVEj7IXkfmug377A9Z+9dSGylKGF+5h+RjN0OFaU=;
        b=MSMdGtfw9nKZv0lOma3V5eWzk9gOIhJjZ+0VTzqOqtTQYc9QNYQCP1snfVTBb+xkPO
         k65ZvYOsHTwzJdme2rVXsb4sz6JQITzLXFY1nkHJXia7FywVBhGBrk8e4IGvFq1uJlqK
         EIBsYElEQ42puTWIfz+NB5CzsLosekYZNGywdsDXkU1EGkDJJHbF868zUpc+ijLMuze9
         z0BiorWJ+K2/QFpCBHyWjBev9dho2q1thw0i7PFcYyj8m+WtEp4ZvFH+GTlxefwGHBjR
         x9A2TbzMvu1DT7z2pMOip7qWFw1pQmf+dW4Drv4zpwSZ5Lw3uqD9s6DuVp1oPGCukO2Q
         NNbA==
X-Gm-Message-State: APjAAAUp8vH9UwbytFxMtgTDWdFUbBStiGdi27TNuQ3ZgIfvum73lc3p
        tq093PPeaCXz1toM92/exPvvzg==
X-Google-Smtp-Source: APXvYqyAqUWCamq5W3ViI979pnhQ0eXBaJ7eHHx3S9QuPlAeQtfsDptKfJi5qvsTHDCplKEp6+9HhA==
X-Received: by 2002:a17:902:e28a:: with SMTP id cf10mr8136527plb.77.1557436455436;
        Thu, 09 May 2019 14:14:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id c14sm3573892pgl.43.2019.05.09.14.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:14 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 08/30] mfd: cros_ec: move HDMI CEC API definition
Date:   Thu,  9 May 2019 14:13:31 -0700
Message-Id: <20190509211353.213194-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move near the end of file.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
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

