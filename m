Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E584819467
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfEIVQL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:16:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37113 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfEIVOU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so1960337pfi.4
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaJsxtRSz7Gp1mSEkwxRyQYxA/E3JN7w4ZIeh5Z/k6I=;
        b=BlfEwnw9XbH0TMZbXU9nMxzyTq5pNGfIKBEigTowQChP6kIb2ivlJzwFuT0bFd0fJE
         +SqlsVcgFOyBivX9sslqKOKHm3Ps6Eloaib/EFyRFXI8F7H6jzVqZXNLAKHQXKWZKjup
         DuiPm0AlKPJOi6448tAbtk/RTQ1A6lU9mCtNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaJsxtRSz7Gp1mSEkwxRyQYxA/E3JN7w4ZIeh5Z/k6I=;
        b=jAye3lErRQKt1hRZq4ZkfbmkaLntGZSH4zubvptsXkmWHQQyffRHpxkD94GOBr9ZPd
         V0paDkRlw3uW8t7R1BM/JoHWMGnCoJhiZUeuNPhk4JHz3tBwfyVoIig5OMl0zcc3w6Ma
         n7sFkTu91oNkw26iMe3TiH7TnhVoRXWus87s++9xYtGgVBoOSzUQoMqDAuSTDstQlqwz
         nP0ACeIQbloRWS41e9qcayCNzaNVmfmeHa4SO58Wls12nXovR8NqynDKANF7VkIAdHtH
         hRnjJqHbsqYRkNcHCJ4a3D8OoL/bGM1tCxokcNfeq6ZTZ61Cmusm+iIAmFy8JzJGCOV3
         nt7Q==
X-Gm-Message-State: APjAAAVbNxLOOp0A2MQDMp1iSyA2gOFteHxOgQ7JaD9o4iuLJAXAVUup
        FlCfXGu7tiW8YmgFOoYeyhvBJQ==
X-Google-Smtp-Source: APXvYqzmR6UP7QFDsPP7XFJh5ZWSFAjHq9Q5qqMTlAp4c2cu8CjtuaZdJq/AjE7hrRFln1J8MfwVVA==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr8424340pfp.152.1557436458458;
        Thu, 09 May 2019 14:14:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 4sm3990290pfd.55.2019.05.09.14.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:17 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 10/30] mfd: cros_ec: Add Flash V2 commands API
Date:   Thu,  9 May 2019 14:13:33 -0700
Message-Id: <20190509211353.213194-11-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added for supporting larger embedded controller flash.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 150 ++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 3 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fabf341af97f..3d1d26f62bd3 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1138,6 +1138,7 @@ struct ec_response_get_features {
 
 /* Get flash info */
 #define EC_CMD_FLASH_INFO 0x0010
+#define EC_VER_FLASH_INFO 2
 
 /**
  * struct ec_response_flash_info - Response to the flash info command.
@@ -1164,6 +1165,15 @@ struct ec_response_flash_info {
  */
 #define EC_FLASH_INFO_ERASE_TO_0 BIT(0)
 
+/*
+ * Flash must be selected for read/write/erase operations to succeed.  This may
+ * be necessary on a chip where write/erase can be corrupted by other board
+ * activity, or where the chip needs to enable some sort of programming voltage,
+ * or where the read/write/erase operations require cleanly suspending other
+ * chip functionality.
+ */
+#define EC_FLASH_INFO_SELECT_REQUIRED BIT(1)
+
 /**
  * struct ec_response_flash_info_1 - Response to the flash info v1 command.
  * @flash_size: Usable flash size in bytes.
@@ -1186,6 +1196,12 @@ struct ec_response_flash_info {
  * gcc anonymous structs don't seem to get along with the __packed directive;
  * if they did we'd define the version 0 structure as a sub-structure of this
  * one.
+ *
+ * Version 2 supports flash banks of different sizes:
+ * The caller specified the number of banks it has preallocated
+ * (num_banks_desc)
+ * The EC returns the number of banks describing the flash memory.
+ * It adds banks descriptions up to num_banks_desc.
  */
 struct ec_response_flash_info_1 {
 	/* Version 0 fields; see above for description */
@@ -1199,6 +1215,42 @@ struct ec_response_flash_info_1 {
 	uint32_t flags;
 } __ec_align4;
 
+struct ec_params_flash_info_2 {
+	/* Number of banks to describe */
+	uint16_t num_banks_desc;
+	/* Reserved; set 0; ignore on read */
+	uint8_t reserved[2];
+} __ec_align4;
+
+struct ec_flash_bank {
+	/* Number of sector is in this bank. */
+	uint16_t count;
+	/* Size in power of 2 of each sector (8 --> 256 bytes) */
+	uint8_t size_exp;
+	/* Minimal write size for the sectors in this bank */
+	uint8_t write_size_exp;
+	/* Erase size for the sectors in this bank */
+	uint8_t erase_size_exp;
+	/* Size for write protection, usually identical to erase size. */
+	uint8_t protect_size_exp;
+	/* Reserved; set 0; ignore on read */
+	uint8_t reserved[2];
+};
+
+struct ec_response_flash_info_2 {
+	/* Total flash in the EC. */
+	uint32_t flash_size;
+	/* Flags; see EC_FLASH_INFO_* */
+	uint32_t flags;
+	/* Maximum size to use to send data to write to the EC. */
+	uint32_t write_ideal_size;
+	/* Number of banks present in the EC. */
+	uint16_t num_banks_total;
+	/* Number of banks described in banks array. */
+	uint16_t num_banks_desc;
+	struct ec_flash_bank banks[0];
+} __ec_align4;
+
 /*
  * Read flash
  *
@@ -1238,7 +1290,7 @@ struct ec_params_flash_write {
 #define EC_CMD_FLASH_ERASE 0x0013
 
 /**
- * struct ec_params_flash_erase - Parameters for the flash erase command.
+ * struct ec_params_flash_erase - Parameters for the flash erase command, v0.
  * @offset: Byte offset to erase.
  * @size: Size to erase in bytes.
  */
@@ -1247,6 +1299,43 @@ struct ec_params_flash_erase {
 	uint32_t size;
 } __ec_align4;
 
+/*
+ * v1 add async erase:
+ * subcommands can returns:
+ * EC_RES_SUCCESS : erased (see ERASE_SECTOR_ASYNC case below).
+ * EC_RES_INVALID_PARAM : offset/size are not aligned on a erase boundary.
+ * EC_RES_ERROR : other errors.
+ * EC_RES_BUSY : an existing erase operation is in progress.
+ * EC_RES_ACCESS_DENIED: Trying to erase running image.
+ *
+ * When ERASE_SECTOR_ASYNC returns EC_RES_SUCCESS, the operation is just
+ * properly queued. The user must call ERASE_GET_RESULT subcommand to get
+ * the proper result.
+ * When ERASE_GET_RESULT returns EC_RES_BUSY, the caller must wait and send
+ * ERASE_GET_RESULT again to get the result of ERASE_SECTOR_ASYNC.
+ * ERASE_GET_RESULT command may timeout on EC where flash access is not
+ * permitted while erasing. (For instance, STM32F4).
+ */
+enum ec_flash_erase_cmd {
+	FLASH_ERASE_SECTOR,     /* Erase and wait for result */
+	FLASH_ERASE_SECTOR_ASYNC,  /* Erase and return immediately. */
+	FLASH_ERASE_GET_RESULT,  /* Ask for last erase result */
+};
+
+/**
+ * struct ec_params_flash_erase_v1 - Parameters for the flash erase command, v1.
+ * @cmd: One of ec_flash_erase_cmd.
+ * @reserved: Pad byte; currently always contains 0.
+ * @flag: No flags defined yet; set to 0.
+ * @params: Same as v0 parameters.
+ */
+struct ec_params_flash_erase_v1 {
+	uint8_t  cmd;
+	uint8_t  reserved;
+	uint16_t flag;
+	struct ec_params_flash_erase params;
+} __ec_align4;
+
 /*
  * Get/set flash protection.
  *
@@ -1282,6 +1371,15 @@ struct ec_params_flash_erase {
 #define EC_FLASH_PROTECT_ERROR_INCONSISTENT BIT(5)
 /* Entire flash code protected when the EC boots */
 #define EC_FLASH_PROTECT_ALL_AT_BOOT        BIT(6)
+/* RW flash code protected when the EC boots */
+#define EC_FLASH_PROTECT_RW_AT_BOOT         BIT(7)
+/* RW flash code protected now. */
+#define EC_FLASH_PROTECT_RW_NOW             BIT(8)
+/* Rollback information flash region protected when the EC boots */
+#define EC_FLASH_PROTECT_ROLLBACK_AT_BOOT   BIT(9)
+/* Rollback information flash region protected now */
+#define EC_FLASH_PROTECT_ROLLBACK_NOW       BIT(10)
+
 
 /**
  * struct ec_params_flash_protect - Parameters for the flash protect command.
@@ -1320,16 +1418,31 @@ struct ec_response_flash_protect {
 enum ec_flash_region {
 	/* Region which holds read-only EC image */
 	EC_FLASH_REGION_RO = 0,
-	/* Region which holds rewritable EC image */
-	EC_FLASH_REGION_RW,
+	/*
+	 * Region which holds active RW image. 'Active' is different from
+	 * 'running'. Active means 'scheduled-to-run'. Since RO image always
+	 * scheduled to run, active/non-active applies only to RW images (for
+	 * the same reason 'update' applies only to RW images. It's a state of
+	 * an image on a flash. Running image can be RO, RW_A, RW_B but active
+	 * image can only be RW_A or RW_B. In recovery mode, an active RW image
+	 * doesn't enter 'running' state but it's still active on a flash.
+	 */
+	EC_FLASH_REGION_ACTIVE,
 	/*
 	 * Region which should be write-protected in the factory (a superset of
 	 * EC_FLASH_REGION_RO)
 	 */
 	EC_FLASH_REGION_WP_RO,
+	/* Region which holds updatable (non-active) RW image */
+	EC_FLASH_REGION_UPDATE,
 	/* Number of regions */
 	EC_FLASH_REGION_COUNT,
 };
+/*
+ * 'RW' is vague if there are multiple RW images; we mean the active one,
+ * so the old constant is deprecated.
+ */
+#define EC_FLASH_REGION_RW EC_FLASH_REGION_ACTIVE
 
 /**
  * struct ec_params_flash_region_info - Parameters for the flash region info
@@ -1364,6 +1477,37 @@ struct ec_response_vbnvcontext {
 	uint8_t block[EC_VBNV_BLOCK_SIZE];
 } __ec_align4;
 
+
+/* Get SPI flash information */
+#define EC_CMD_FLASH_SPI_INFO 0x0018
+
+struct ec_response_flash_spi_info {
+	/* JEDEC info from command 0x9F (manufacturer, memory type, size) */
+	uint8_t jedec[3];
+
+	/* Pad byte; currently always contains 0 */
+	uint8_t reserved0;
+
+	/* Manufacturer / device ID from command 0x90 */
+	uint8_t mfr_dev_id[2];
+
+	/* Status registers from command 0x05 and 0x35 */
+	uint8_t sr1, sr2;
+} __ec_align1;
+
+
+/* Select flash during flash operations */
+#define EC_CMD_FLASH_SELECT 0x0019
+
+/**
+ * struct ec_params_flash_select - Parameters for the flash select command.
+ * @select: 1 to select flash, 0 to deselect flash
+ */
+struct ec_params_flash_select {
+	uint8_t select;
+} __ec_align4;
+
+
 /*****************************************************************************/
 /* PWM commands */
 
-- 
2.21.0.1020.gf2820cf01a-goog

