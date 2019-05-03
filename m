Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F31C1352E
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfECWD3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41269 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfECWD3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so3533567pfd.8
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KFNP7GDxDVEn9/0waadn8XQgo26+DaIg8QC4SSrhCE=;
        b=ZK/hzflXSHwQRNZeB46eyN2GXgSBKKeiaOpn5NHjSmqIYS9P9eFF3ToPrx1GTh79p2
         WwZNTz9Yek/pFQYTn5TE7LHgN9CjYGtxFaiBZhHrKL8mcriCNUMzixDU10G5nFOCYF+c
         3/IiRWIx0oqqukDwrGHdT+zMeBVH/we05f8XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KFNP7GDxDVEn9/0waadn8XQgo26+DaIg8QC4SSrhCE=;
        b=Q6mJyyc/aMCRAqNzrJDEoc3KqNB1EoYKmdE62YTOGSn8a/NvznWyLxLpV97dGWdfl0
         Hj7Rl7dlER4YwWItwhYn369yDr0ASLNhA80Dtu24XqF71x1cCZ0Kr6sCFUovoaodf3H/
         UDCc+1/xp7lvwJKemjd30rFashhaB860saVTCLDSnOdqqU5d7JhHUyGRqsvPC02Ck+JF
         IwUdttpu2Q/55McW6+85h3XFWayG5u7tYQ0VdB4DwOy89xKIwVZGyThKDeTI562DPj14
         HAC7lwnj29Hq6FzPuDARFBpI1MRue2D+Vb3YwY2lS78i4b4l29gjg3+t/pyLSGR7737E
         vPsA==
X-Gm-Message-State: APjAAAWEB+qvvpLi2QGb253oSRj11lEV5Xe+BRbrSAMIzy5rziIMJoky
        85h6Ac1KyzIYjTYxK8KON1WPTQ==
X-Google-Smtp-Source: APXvYqx5VrA3v5VfP99PPmGv2TIOUjM51+ZlFhs4G5gk2qqiWd7NEl4qs6v558WRJ3QSesV2tF1dOw==
X-Received: by 2002:a63:31d7:: with SMTP id x206mr13546801pgx.74.1556921008643;
        Fri, 03 May 2019 15:03:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id g63sm6073757pfc.127.2019.05.03.15.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:27 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 28/30] mfd: cros_ec: Add SKU ID and Secure storage API
Date:   Fri,  3 May 2019 15:02:31 -0700
Message-Id: <20190503220233.64546-29-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add API to store SKU, Cros board information in EC flash memory.
Add API to store security data in EC.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 107 +++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 3d3a37b11002..860a76274334 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1292,6 +1292,17 @@ struct ec_response_get_features {
 	uint32_t flags[2];
 } __ec_align4;
 
+/*****************************************************************************/
+/* Get the board's SKU ID from EC */
+#define EC_CMD_GET_SKU_ID 0x000E
+
+/* Set SKU ID from AP */
+#define EC_CMD_SET_SKU_ID 0x000F
+
+struct ec_sku_id_info {
+	uint32_t sku_id;
+} __ec_align4;
+
 /*****************************************************************************/
 /* Flash commands */
 
@@ -2902,6 +2913,49 @@ struct ec_response_port80_last_boot {
 	uint16_t code;
 } __ec_align2;
 
+/*****************************************************************************/
+/* Temporary secure storage for host verified boot use */
+
+/* Number of bytes in a vstore slot */
+#define EC_VSTORE_SLOT_SIZE 64
+
+/* Maximum number of vstore slots */
+#define EC_VSTORE_SLOT_MAX 32
+
+/* Get persistent storage info */
+#define EC_CMD_VSTORE_INFO 0x0049
+struct ec_response_vstore_info {
+	/* Indicates which slots are locked */
+	uint32_t slot_locked;
+	/* Total number of slots available */
+	uint8_t slot_count;
+} __ec_align_size1;
+
+/*
+ * Read temporary secure storage
+ *
+ * Response is EC_VSTORE_SLOT_SIZE bytes of data.
+ */
+#define EC_CMD_VSTORE_READ 0x004A
+
+struct ec_params_vstore_read {
+	uint8_t slot; /* Slot to read from */
+} __ec_align1;
+
+struct ec_response_vstore_read {
+	uint8_t data[EC_VSTORE_SLOT_SIZE];
+} __ec_align1;
+
+/*
+ * Write temporary secure storage and lock it.
+ */
+#define EC_CMD_VSTORE_WRITE 0x004B
+
+struct ec_params_vstore_write {
+	uint8_t slot; /* Slot to write to */
+	uint8_t data[EC_VSTORE_SLOT_SIZE];
+} __ec_align1;
+
 /*****************************************************************************/
 /* Thermal engine commands. Note that there are two implementations. We'll
  * reuse the command number, but the data and behavior is incompatible.
@@ -5069,6 +5123,59 @@ struct ec_params_efs_verify {
 	uint8_t region;		/* enum ec_flash_region */
 } __ec_align1;
 
+/*
+ * Retrieve info from Cros Board Info store. Response is based on the data
+ * type. Integers return a uint32. Strings return a string, using the response
+ * size to determine how big it is.
+ */
+#define EC_CMD_GET_CROS_BOARD_INFO	0x011F
+/*
+ * Write info into Cros Board Info on EEPROM. Write fails if the board has
+ * hardware write-protect enabled.
+ */
+#define EC_CMD_SET_CROS_BOARD_INFO	0x0120
+
+enum cbi_data_tag {
+	CBI_TAG_BOARD_VERSION = 0, /* uint32_t or smaller */
+	CBI_TAG_OEM_ID = 1,        /* uint32_t or smaller */
+	CBI_TAG_SKU_ID = 2,        /* uint32_t or smaller */
+	CBI_TAG_DRAM_PART_NUM = 3, /* variable length ascii, nul terminated. */
+	CBI_TAG_OEM_NAME = 4,      /* variable length ascii, nul terminated. */
+	CBI_TAG_MODEL_ID = 5,      /* uint32_t or smaller */
+	CBI_TAG_COUNT,
+};
+
+/*
+ * Flags to control read operation
+ *
+ * RELOAD:  Invalidate cache and read data from EEPROM. Useful to verify
+ *          write was successful without reboot.
+ */
+#define CBI_GET_RELOAD		BIT(0)
+
+struct ec_params_get_cbi {
+	uint32_t tag;		/* enum cbi_data_tag */
+	uint32_t flag;		/* CBI_GET_* */
+} __ec_align4;
+
+/*
+ * Flags to control write behavior.
+ *
+ * NO_SYNC: Makes EC update data in RAM but skip writing to EEPROM. It's
+ *          useful when writing multiple fields in a row.
+ * INIT:    Need to be set when creating a new CBI from scratch. All fields
+ *          will be initialized to zero first.
+ */
+#define CBI_SET_NO_SYNC		BIT(0)
+#define CBI_SET_INIT		BIT(1)
+
+struct ec_params_set_cbi {
+	uint32_t tag;		/* enum cbi_data_tag */
+	uint32_t flag;		/* CBI_SET_* */
+	uint32_t size;		/* Data size */
+	uint8_t data[];		/* For string and raw data */
+} __ec_align1;
+
 /*****************************************************************************/
 /* Fingerprint MCU commands: range 0x0400-0x040x */
 
-- 
2.21.0.1020.gf2820cf01a-goog

