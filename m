Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B93337EE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFCSeR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34765 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfFCSeR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so5529780pgg.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukgxjUVacW1jHs3CdZtBXUAQpC+KY/oy4Y6vaU2txQg=;
        b=QbBj31DPtDEEKAfXFArKVV1cOEVdNz2dpGirqcGe0dw0aLD+a9wa9a/KUmjSqXhRjC
         t/bfdERdVDmd2xLQMnFUpymFWmfJtv9Oi4y5P3h102aHGRqX20vdu6C3QQjp5OkmqtnE
         f7VMeYxRz0L0bi5Xe4HTkYnZ6eyKbdAQYkAQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukgxjUVacW1jHs3CdZtBXUAQpC+KY/oy4Y6vaU2txQg=;
        b=AMMYpUrtoWDplSbIQk4JRD9bBd2S7INnUne1p7ThhX2GODIQi6o6y/7TUt2juBFLSA
         hAvJ7J+H8vt5wgPO8JTWK9yq+OzM7kC0lZ1AocBY/mQP3qCMkDj4DWnsFHAa2+DQNToM
         s51XbtYcrbYhMQIYq8q72SSKb59XzvpAEXAgLp/73lcZcUqD9nu0BXsjPWoAUEjvCN/B
         M639YeFlfccTP9t3MboB6+Mrb6rsPbSdY4whh3ZBSo+InWE0LbWTdaW5DhUUwkdBiRLF
         wrM/iBIbkB+olsasxWTY2LNcx+B66Tiy3dsf4huJd5erufXykuOvMM4YhqHnI/6NDQna
         0ytA==
X-Gm-Message-State: APjAAAW0HkwgInRWR4ETg8zGjmGc3ZphY/WPTxC38UOEh3/QFWYHGTkV
        oyPqZNN+AuUANqJxh5hiLxWoDA==
X-Google-Smtp-Source: APXvYqxwvcrQUfi/we8ZcGH1RECU4k1nFDPv75vRdd1kx0HH0AsSHQeGlRFESZbUw//QuDBCYKoWQA==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr17538211pjo.111.1559586856221;
        Mon, 03 Jun 2019 11:34:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id bx5sm12775839pjb.25.2019.06.03.11.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:15 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 06/30] mfd: cros_ec: use BIT macro
Date:   Mon,  3 Jun 2019 11:33:37 -0700
Message-Id: <20190603183401.151408-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace (1 << ...) with BIT().

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 110 +++++++++++++--------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 8ad77d8a9141..e97e9e976bd0 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -28,7 +28,7 @@
 #define EC_PROTO_VERSION          0x00000002
 
 /* Command version mask */
-#define EC_VER_MASK(version) (1UL << (version))
+#define EC_VER_MASK(version) BIT(version)
 
 /* I/O addresses for ACPI commands */
 #define EC_LPC_ADDR_ACPI_DATA  0x62
@@ -57,13 +57,13 @@
 #define EC_HOST_CMD_REGION_SIZE 0x80
 
 /* EC command register bit functions */
-#define EC_LPC_CMDR_DATA	(1 << 0)  /* Data ready for host to read */
-#define EC_LPC_CMDR_PENDING	(1 << 1)  /* Write pending to EC */
-#define EC_LPC_CMDR_BUSY	(1 << 2)  /* EC is busy processing a command */
-#define EC_LPC_CMDR_CMD		(1 << 3)  /* Last host write was a command */
-#define EC_LPC_CMDR_ACPI_BRST	(1 << 4)  /* Burst mode (not used) */
-#define EC_LPC_CMDR_SCI		(1 << 5)  /* SCI event is pending */
-#define EC_LPC_CMDR_SMI		(1 << 6)  /* SMI event is pending */
+#define EC_LPC_CMDR_DATA	BIT(0)  /* Data ready for host to read */
+#define EC_LPC_CMDR_PENDING	BIT(1)  /* Write pending to EC */
+#define EC_LPC_CMDR_BUSY	BIT(2)  /* EC is busy processing a command */
+#define EC_LPC_CMDR_CMD		BIT(3)  /* Last host write was a command */
+#define EC_LPC_CMDR_ACPI_BRST	BIT(4)  /* Burst mode (not used) */
+#define EC_LPC_CMDR_SCI		BIT(5)  /* SCI event is pending */
+#define EC_LPC_CMDR_SMI		BIT(6)  /* SMI event is pending */
 
 #define EC_LPC_ADDR_MEMMAP       0x900
 #define EC_MEMMAP_SIZE         255 /* ACPI IO buffer max is 255 bytes */
@@ -110,8 +110,8 @@
 
 /* Define the format of the accelerometer mapped memory status byte. */
 #define EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK  0x0f
-#define EC_MEMMAP_ACC_STATUS_BUSY_BIT        (1 << 4)
-#define EC_MEMMAP_ACC_STATUS_PRESENCE_BIT    (1 << 7)
+#define EC_MEMMAP_ACC_STATUS_BUSY_BIT        BIT(4)
+#define EC_MEMMAP_ACC_STATUS_PRESENCE_BIT    BIT(7)
 
 /* Number of temp sensors at EC_MEMMAP_TEMP_SENSOR */
 #define EC_TEMP_SENSOR_ENTRIES     16
@@ -336,7 +336,7 @@ enum host_event_code {
 	EC_HOST_EVENT_INVALID = 32
 };
 /* Host event mask */
-#define EC_HOST_EVENT_MASK(event_code) (1UL << ((event_code) - 1))
+#define EC_HOST_EVENT_MASK(event_code) BIT_ULL((event_code) - 1)
 
 /**
  * struct ec_lpc_host_args - Arguments at EC_LPC_ADDR_HOST_ARGS
@@ -734,7 +734,7 @@ struct ec_response_get_cmd_versions {
 
 /* Avoid using ec_status which is for return values */
 enum ec_comms_status {
-	EC_COMMS_STATUS_PROCESSING	= 1 << 0,	/* Processing cmd */
+	EC_COMMS_STATUS_PROCESSING	= BIT(0),	/* Processing cmd */
 };
 
 /**
@@ -766,7 +766,7 @@ struct ec_response_test_protocol {
 
 /* Flags for ec_response_get_protocol_info.flags */
 /* EC_RES_IN_PROGRESS may be returned if a command is slow */
-#define EC_PROTOCOL_INFO_IN_PROGRESS_SUPPORTED (1 << 0)
+#define EC_PROTOCOL_INFO_IN_PROGRESS_SUPPORTED BIT(0)
 
 /**
  * struct ec_response_get_protocol_info - Response to the get protocol info.
@@ -925,8 +925,8 @@ enum ec_feature_code {
 	EC_FEATURE_ISH = 40,
 };
 
-#define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-#define EC_FEATURE_MASK_1(event_code) (1UL << (event_code - 32))
+#define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
+#define EC_FEATURE_MASK_1(event_code) BIT(event_code - 32)
 
 struct ec_response_get_features {
 	uint32_t flags[2];
@@ -961,7 +961,7 @@ struct ec_response_flash_info {
  * Flags for version 1+ flash info command
  * EC flash erases bits to 0 instead of 1.
  */
-#define EC_FLASH_INFO_ERASE_TO_0 (1 << 0)
+#define EC_FLASH_INFO_ERASE_TO_0 BIT(0)
 
 /**
  * struct ec_response_flash_info_1 - Response to the flash info v1 command.
@@ -1061,26 +1061,26 @@ struct ec_params_flash_erase {
 
 /* Flags for flash protection */
 /* RO flash code protected when the EC boots */
-#define EC_FLASH_PROTECT_RO_AT_BOOT         (1 << 0)
+#define EC_FLASH_PROTECT_RO_AT_BOOT         BIT(0)
 /*
  * RO flash code protected now.  If this bit is set, at-boot status cannot
  * be changed.
  */
-#define EC_FLASH_PROTECT_RO_NOW             (1 << 1)
+#define EC_FLASH_PROTECT_RO_NOW             BIT(1)
 /* Entire flash code protected now, until reboot. */
-#define EC_FLASH_PROTECT_ALL_NOW            (1 << 2)
+#define EC_FLASH_PROTECT_ALL_NOW            BIT(2)
 /* Flash write protect GPIO is asserted now */
-#define EC_FLASH_PROTECT_GPIO_ASSERTED      (1 << 3)
+#define EC_FLASH_PROTECT_GPIO_ASSERTED      BIT(3)
 /* Error - at least one bank of flash is stuck locked, and cannot be unlocked */
-#define EC_FLASH_PROTECT_ERROR_STUCK        (1 << 4)
+#define EC_FLASH_PROTECT_ERROR_STUCK        BIT(4)
 /*
  * Error - flash protection is in inconsistent state.  At least one bank of
  * flash which should be protected is not protected.  Usually fixed by
  * re-requesting the desired flags, or by a hard reset if that fails.
  */
-#define EC_FLASH_PROTECT_ERROR_INCONSISTENT (1 << 5)
+#define EC_FLASH_PROTECT_ERROR_INCONSISTENT BIT(5)
 /* Entire flash code protected when the EC boots */
-#define EC_FLASH_PROTECT_ALL_AT_BOOT        (1 << 6)
+#define EC_FLASH_PROTECT_ALL_AT_BOOT        BIT(6)
 
 /**
  * struct ec_params_flash_protect - Parameters for the flash protect command.
@@ -1451,8 +1451,8 @@ enum ec_led_id {
 };
 
 /* LED control flags */
-#define EC_LED_FLAGS_QUERY (1 << 0) /* Query LED capability only */
-#define EC_LED_FLAGS_AUTO  (1 << 1) /* Switch LED back to automatic control */
+#define EC_LED_FLAGS_QUERY BIT(0) /* Query LED capability only */
+#define EC_LED_FLAGS_AUTO  BIT(1) /* Switch LED back to automatic control */
 
 enum ec_led_colors {
 	EC_LED_COLOR_RED = 0,
@@ -2116,13 +2116,13 @@ enum mkbp_config_flags {
 };
 
 enum mkbp_config_valid {
-	EC_MKBP_VALID_SCAN_PERIOD		= 1 << 0,
-	EC_MKBP_VALID_POLL_TIMEOUT		= 1 << 1,
-	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= 1 << 3,
-	EC_MKBP_VALID_OUTPUT_SETTLE		= 1 << 4,
-	EC_MKBP_VALID_DEBOUNCE_DOWN		= 1 << 5,
-	EC_MKBP_VALID_DEBOUNCE_UP		= 1 << 6,
-	EC_MKBP_VALID_FIFO_MAX_DEPTH		= 1 << 7,
+	EC_MKBP_VALID_SCAN_PERIOD		= BIT(0),
+	EC_MKBP_VALID_POLL_TIMEOUT		= BIT(1),
+	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= BIT(3),
+	EC_MKBP_VALID_OUTPUT_SETTLE		= BIT(4),
+	EC_MKBP_VALID_DEBOUNCE_DOWN		= BIT(5),
+	EC_MKBP_VALID_DEBOUNCE_UP		= BIT(6),
+	EC_MKBP_VALID_FIFO_MAX_DEPTH		= BIT(7),
 };
 
 /*
@@ -2176,7 +2176,7 @@ enum ec_collect_flags {
 	 * Indicates this scan was processed by the EC. Due to timing, some
 	 * scans may be skipped.
 	 */
-	EC_KEYSCAN_SEQ_FLAG_DONE	= 1 << 0,
+	EC_KEYSCAN_SEQ_FLAG_DONE	= BIT(0),
 };
 
 struct ec_collect_item {
@@ -2543,7 +2543,7 @@ struct ec_params_console_read_v1 {
  */
 #define EC_CMD_BATTERY_CUT_OFF 0x0099
 
-#define EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN	(1 << 0)
+#define EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN	BIT(0)
 
 struct ec_params_battery_cutoff {
 	uint8_t flags;
@@ -2614,13 +2614,13 @@ struct ec_response_power_info {
 #define EC_CMD_I2C_PASSTHRU 0x009E
 
 /* Read data; if not present, message is a write */
-#define EC_I2C_FLAG_READ	(1 << 15)
+#define EC_I2C_FLAG_READ	BIT(15)
 
 /* Mask for address */
 #define EC_I2C_ADDR_MASK	0x3ff
 
-#define EC_I2C_STATUS_NAK	(1 << 0) /* Transfer was not acknowledged */
-#define EC_I2C_STATUS_TIMEOUT	(1 << 1) /* Timeout during transfer */
+#define EC_I2C_STATUS_NAK	BIT(0) /* Transfer was not acknowledged */
+#define EC_I2C_STATUS_TIMEOUT	BIT(1) /* Timeout during transfer */
 
 /* Any error */
 #define EC_I2C_STATUS_ERROR	(EC_I2C_STATUS_NAK | EC_I2C_STATUS_TIMEOUT)
@@ -2650,27 +2650,27 @@ struct ec_response_i2c_passthru {
 
 /* Reasons to start hang detection timer */
 /* Power button pressed */
-#define EC_HANG_START_ON_POWER_PRESS  (1 << 0)
+#define EC_HANG_START_ON_POWER_PRESS  BIT(0)
 
 /* Lid closed */
-#define EC_HANG_START_ON_LID_CLOSE    (1 << 1)
+#define EC_HANG_START_ON_LID_CLOSE    BIT(1)
 
  /* Lid opened */
-#define EC_HANG_START_ON_LID_OPEN     (1 << 2)
+#define EC_HANG_START_ON_LID_OPEN     BIT(2)
 
 /* Start of AP S3->S0 transition (booting or resuming from suspend) */
-#define EC_HANG_START_ON_RESUME       (1 << 3)
+#define EC_HANG_START_ON_RESUME       BIT(3)
 
 /* Reasons to cancel hang detection */
 
 /* Power button released */
-#define EC_HANG_STOP_ON_POWER_RELEASE (1 << 8)
+#define EC_HANG_STOP_ON_POWER_RELEASE BIT(8)
 
 /* Any host command from AP received */
-#define EC_HANG_STOP_ON_HOST_COMMAND  (1 << 9)
+#define EC_HANG_STOP_ON_HOST_COMMAND  BIT(9)
 
 /* Stop on end of AP S0->S3 transition (suspending or shutting down) */
-#define EC_HANG_STOP_ON_SUSPEND       (1 << 10)
+#define EC_HANG_STOP_ON_SUSPEND       BIT(10)
 
 /*
  * If this flag is set, all the other fields are ignored, and the hang detect
@@ -2678,14 +2678,14 @@ struct ec_response_i2c_passthru {
  * without reconfiguring any of the other hang detect settings.  Note that
  * you must previously have configured the timeouts.
  */
-#define EC_HANG_START_NOW             (1 << 30)
+#define EC_HANG_START_NOW             BIT(30)
 
 /*
  * If this flag is set, all the other fields are ignored (including
  * EC_HANG_START_NOW).  This provides the AP a way to stop the hang timer
  * without reconfiguring any of the other hang detect settings.
  */
-#define EC_HANG_STOP_NOW              (1 << 31)
+#define EC_HANG_STOP_NOW              BIT(31)
 
 struct ec_params_hang_detect {
 	/* Flags; see EC_HANG_* */
@@ -3040,8 +3040,8 @@ enum ec_reboot_cmd {
 };
 
 /* Flags for ec_params_reboot_ec.reboot_flags */
-#define EC_REBOOT_FLAG_RESERVED0      (1 << 0)  /* Was recovery request */
-#define EC_REBOOT_FLAG_ON_AP_SHUTDOWN (1 << 1)  /* Reboot after AP shutdown */
+#define EC_REBOOT_FLAG_RESERVED0      BIT(0)  /* Was recovery request */
+#define EC_REBOOT_FLAG_ON_AP_SHUTDOWN BIT(1)  /* Reboot after AP shutdown */
 
 struct ec_params_reboot_ec {
 	uint8_t cmd;           /* enum ec_reboot_cmd */
@@ -3343,9 +3343,9 @@ struct ec_params_usb_pd_control {
 	uint8_t swap;
 } __ec_align1;
 
-#define PD_CTRL_RESP_ENABLED_COMMS      (1 << 0) /* Communication enabled */
-#define PD_CTRL_RESP_ENABLED_CONNECTED  (1 << 1) /* Device connected */
-#define PD_CTRL_RESP_ENABLED_PD_CAPABLE (1 << 2) /* Partner is PD capable */
+#define PD_CTRL_RESP_ENABLED_COMMS      BIT(0) /* Communication enabled */
+#define PD_CTRL_RESP_ENABLED_CONNECTED  BIT(1) /* Device connected */
+#define PD_CTRL_RESP_ENABLED_PD_CAPABLE BIT(2) /* Partner is PD capable */
 
 #define PD_CTRL_RESP_ROLE_POWER         BIT(0) /* 0=SNK/1=SRC */
 #define PD_CTRL_RESP_ROLE_DATA          BIT(1) /* 0=UFP/1=DFP */
@@ -3545,10 +3545,10 @@ struct ec_params_usb_pd_mux_info {
 } __ec_align1;
 
 /* Flags representing mux state */
-#define USB_PD_MUX_USB_ENABLED       (1 << 0)
-#define USB_PD_MUX_DP_ENABLED        (1 << 1)
-#define USB_PD_MUX_POLARITY_INVERTED (1 << 2)
-#define USB_PD_MUX_HPD_IRQ           (1 << 3)
+#define USB_PD_MUX_USB_ENABLED       BIT(0) /* USB connected */
+#define USB_PD_MUX_DP_ENABLED        BIT(1) /* DP connected */
+#define USB_PD_MUX_POLARITY_INVERTED BIT(2) /* CC line Polarity inverted */
+#define USB_PD_MUX_HPD_IRQ           BIT(3) /* HPD IRQ is asserted */
 
 struct ec_response_usb_pd_mux_info {
 	uint8_t flags; /* USB_PD_MUX_*-encoded USB mux state */
-- 
2.21.0.1020.gf2820cf01a-goog

