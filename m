Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997E019464
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 23:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfEIVOQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 17:14:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36835 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfEIVOP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 17:14:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so1837981pgb.3
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RXpe9ZfgLnSbkrmXTOVzM3+Hg9ElJqMCMVASaeCMIWY=;
        b=TlKk1t3dszhVzVykLagIOyO/vHRsmrmJ5tnpUt+k33wqGw3ifMXkrcDOmOQ95Wqipd
         LPHO72+Xaf6tKHyoqTmKAst34/JcnTkYffpcNG/UYczCIigdSqer6vu+lws7RNApoQcc
         Yha6QF6G36Yso8VVyczjtC3ct6AeTNRceT72s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RXpe9ZfgLnSbkrmXTOVzM3+Hg9ElJqMCMVASaeCMIWY=;
        b=pxx7t2DgwXlYxwAydc2iLL2yK6D9JQ9ZQXwxbJ1I5fyrE4cYeSwmO/Gy9KuXc5w7sO
         5N1Wx1uLw4hNhhT03vGJTNsTfwE+uX9Dq0DOyCtvV+NhRfGudqp9vIRU+yLpoO4o3hKk
         5/+N820NXr1atmayMpBCTBMvBeb3K5YBEU6Di/RT+7q1pwvIKkQdScvNNYJcus8cg04i
         7kKu7qUbQ6paQc+QLWpWdxpEL2b2f6B16yvnVhEo4otL5MpRhItQyTR16v2OMhNG8eRO
         YbwyntN/6TsdE1EFrP5QE3LjfXdO+3/iZmY23kiyVD3XGSWszQRVRmgFYL1APjlpv7hT
         FsdA==
X-Gm-Message-State: APjAAAVqg+r6fn+UViI3T+sm6pUGxdSv1Mo8HV3pMnPwVMvO/BQQ1V8e
        C9mK95zYXP0R/06yr7YDOgIufw==
X-Google-Smtp-Source: APXvYqylbbPzUrfzQH8HP6dGsq3vpPJwCGuJFQeBJvLe9QQdKR0/LlZUiogV5Be/7XFMRVcgm+Z0Gw==
X-Received: by 2002:a62:1b8a:: with SMTP id b132mr8463070pfb.19.1557436454060;
        Thu, 09 May 2019 14:14:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id s85sm4466891pfa.23.2019.05.09.14.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:13 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 07/30] mfd: cros_ec: Update ACPI interface definition
Date:   Thu,  9 May 2019 14:13:30 -0700
Message-Id: <20190509211353.213194-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add more fields and improve API when EC presents data through ACPI
memory space.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 419 +++++++++++++++++++--------
 1 file changed, 293 insertions(+), 126 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index e97e9e976bd0..575066b90bab 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -83,13 +83,15 @@
 /* Unused 0x28 - 0x2f */
 #define EC_MEMMAP_SWITCHES         0x30	/* 8 bits */
 /* Unused 0x31 - 0x33 */
-#define EC_MEMMAP_HOST_EVENTS      0x34 /* 32 bits */
-/* Reserve 0x38 - 0x3f for additional host event-related stuff */
-/* Battery values are all 32 bits */
+#define EC_MEMMAP_HOST_EVENTS      0x34 /* 64 bits */
+/* Battery values are all 32 bits, unless otherwise noted. */
 #define EC_MEMMAP_BATT_VOLT        0x40 /* Battery Present Voltage */
 #define EC_MEMMAP_BATT_RATE        0x44 /* Battery Present Rate */
 #define EC_MEMMAP_BATT_CAP         0x48 /* Battery Remaining Capacity */
-#define EC_MEMMAP_BATT_FLAG        0x4c /* Battery State, defined below */
+#define EC_MEMMAP_BATT_FLAG        0x4c /* Battery State, see below (8-bit) */
+#define EC_MEMMAP_BATT_COUNT       0x4d /* Battery Count (8-bit) */
+#define EC_MEMMAP_BATT_INDEX       0x4e /* Current Battery Data Index (8-bit) */
+/* Unused 0x4f */
 #define EC_MEMMAP_BATT_DCAP        0x50 /* Battery Design Capacity */
 #define EC_MEMMAP_BATT_DVLT        0x54 /* Battery Design Voltage */
 #define EC_MEMMAP_BATT_LFCC        0x58 /* Battery Last Full Charge Capacity */
@@ -103,10 +105,19 @@
 /* Unused 0x84 - 0x8f */
 #define EC_MEMMAP_ACC_STATUS       0x90 /* Accelerometer status (8 bits )*/
 /* Unused 0x91 */
-#define EC_MEMMAP_ACC_DATA         0x92 /* Accelerometer data 0x92 - 0x9f */
+#define EC_MEMMAP_ACC_DATA         0x92 /* Accelerometers data 0x92 - 0x9f */
+/* 0x92: Lid Angle if available, LID_ANGLE_UNRELIABLE otherwise */
+/* 0x94 - 0x99: 1st Accelerometer */
+/* 0x9a - 0x9f: 2nd Accelerometer */
 #define EC_MEMMAP_GYRO_DATA        0xa0 /* Gyroscope data 0xa0 - 0xa5 */
-/* Unused 0xa6 - 0xfe (remember, 0xff is NOT part of the memmap region) */
+/* Unused 0xa6 - 0xdf */
 
+/*
+ * ACPI is unable to access memory mapped data at or above this offset due to
+ * limitations of the ACPI protocol. Do not place data in the range 0xe0 - 0xfe
+ * which might be needed by ACPI.
+ */
+#define EC_MEMMAP_NO_ACPI 0xe0
 
 /* Define the format of the accelerometer mapped memory status byte. */
 #define EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK  0x0f
@@ -155,6 +166,8 @@
 #define EC_BATT_FLAG_DISCHARGING  0x04
 #define EC_BATT_FLAG_CHARGING     0x08
 #define EC_BATT_FLAG_LEVEL_CRITICAL 0x10
+/* Set if some of the static/dynamic data is invalid (or outdated). */
+#define EC_BATT_FLAG_INVALID_DATA 0x20
 
 /* Switch flags at EC_MEMMAP_SWITCHES */
 #define EC_SWITCH_LID_OPEN               0x01
@@ -180,12 +193,200 @@
 #define EC_WIRELESS_SWITCH_WWAN       0x04  /* WWAN power */
 #define EC_WIRELESS_SWITCH_WLAN_POWER 0x08  /* WLAN power */
 
+/*****************************************************************************/
+/*
+ * ACPI commands
+ *
+ * These are valid ONLY on the ACPI command/data port.
+ */
+
+/*
+ * ACPI Read Embedded Controller
+ *
+ * This reads from ACPI memory space on the EC (EC_ACPI_MEM_*).
+ *
+ * Use the following sequence:
+ *
+ *    - Write EC_CMD_ACPI_READ to EC_LPC_ADDR_ACPI_CMD
+ *    - Wait for EC_LPC_CMDR_PENDING bit to clear
+ *    - Write address to EC_LPC_ADDR_ACPI_DATA
+ *    - Wait for EC_LPC_CMDR_DATA bit to set
+ *    - Read value from EC_LPC_ADDR_ACPI_DATA
+ */
+#define EC_CMD_ACPI_READ 0x0080
+
+/*
+ * ACPI Write Embedded Controller
+ *
+ * This reads from ACPI memory space on the EC (EC_ACPI_MEM_*).
+ *
+ * Use the following sequence:
+ *
+ *    - Write EC_CMD_ACPI_WRITE to EC_LPC_ADDR_ACPI_CMD
+ *    - Wait for EC_LPC_CMDR_PENDING bit to clear
+ *    - Write address to EC_LPC_ADDR_ACPI_DATA
+ *    - Wait for EC_LPC_CMDR_PENDING bit to clear
+ *    - Write value to EC_LPC_ADDR_ACPI_DATA
+ */
+#define EC_CMD_ACPI_WRITE 0x0081
+
+/*
+ * ACPI Burst Enable Embedded Controller
+ *
+ * This enables burst mode on the EC to allow the host to issue several
+ * commands back-to-back. While in this mode, writes to mapped multi-byte
+ * data are locked out to ensure data consistency.
+ */
+#define EC_CMD_ACPI_BURST_ENABLE 0x0082
+
+/*
+ * ACPI Burst Disable Embedded Controller
+ *
+ * This disables burst mode on the EC and stops preventing EC writes to mapped
+ * multi-byte data.
+ */
+#define EC_CMD_ACPI_BURST_DISABLE 0x0083
+
+/*
+ * ACPI Query Embedded Controller
+ *
+ * This clears the lowest-order bit in the currently pending host events, and
+ * sets the result code to the 1-based index of the bit (event 0x00000001 = 1,
+ * event 0x80000000 = 32), or 0 if no event was pending.
+ */
+#define EC_CMD_ACPI_QUERY_EVENT 0x0084
+
+/* Valid addresses in ACPI memory space, for read/write commands */
+
+/* Memory space version; set to EC_ACPI_MEM_VERSION_CURRENT */
+#define EC_ACPI_MEM_VERSION            0x00
+/*
+ * Test location; writing value here updates test compliment byte to (0xff -
+ * value).
+ */
+#define EC_ACPI_MEM_TEST               0x01
+/* Test compliment; writes here are ignored. */
+#define EC_ACPI_MEM_TEST_COMPLIMENT    0x02
+
+/* Keyboard backlight brightness percent (0 - 100) */
+#define EC_ACPI_MEM_KEYBOARD_BACKLIGHT 0x03
+/* DPTF Target Fan Duty (0-100, 0xff for auto/none) */
+#define EC_ACPI_MEM_FAN_DUTY           0x04
+
+/*
+ * DPTF temp thresholds. Any of the EC's temp sensors can have up to two
+ * independent thresholds attached to them. The current value of the ID
+ * register determines which sensor is affected by the THRESHOLD and COMMIT
+ * registers. The THRESHOLD register uses the same EC_TEMP_SENSOR_OFFSET scheme
+ * as the memory-mapped sensors. The COMMIT register applies those settings.
+ *
+ * The spec does not mandate any way to read back the threshold settings
+ * themselves, but when a threshold is crossed the AP needs a way to determine
+ * which sensor(s) are responsible. Each reading of the ID register clears and
+ * returns one sensor ID that has crossed one of its threshold (in either
+ * direction) since the last read. A value of 0xFF means "no new thresholds
+ * have tripped". Setting or enabling the thresholds for a sensor will clear
+ * the unread event count for that sensor.
+ */
+#define EC_ACPI_MEM_TEMP_ID            0x05
+#define EC_ACPI_MEM_TEMP_THRESHOLD     0x06
+#define EC_ACPI_MEM_TEMP_COMMIT        0x07
+/*
+ * Here are the bits for the COMMIT register:
+ *   bit 0 selects the threshold index for the chosen sensor (0/1)
+ *   bit 1 enables/disables the selected threshold (0 = off, 1 = on)
+ * Each write to the commit register affects one threshold.
+ */
+#define EC_ACPI_MEM_TEMP_COMMIT_SELECT_MASK BIT(0)
+#define EC_ACPI_MEM_TEMP_COMMIT_ENABLE_MASK BIT(1)
+/*
+ * Example:
+ *
+ * Set the thresholds for sensor 2 to 50 C and 60 C:
+ *   write 2 to [0x05]      --  select temp sensor 2
+ *   write 0x7b to [0x06]   --  C_TO_K(50) - EC_TEMP_SENSOR_OFFSET
+ *   write 0x2 to [0x07]    --  enable threshold 0 with this value
+ *   write 0x85 to [0x06]   --  C_TO_K(60) - EC_TEMP_SENSOR_OFFSET
+ *   write 0x3 to [0x07]    --  enable threshold 1 with this value
+ *
+ * Disable the 60 C threshold, leaving the 50 C threshold unchanged:
+ *   write 2 to [0x05]      --  select temp sensor 2
+ *   write 0x1 to [0x07]    --  disable threshold 1
+ */
+
+/* DPTF battery charging current limit */
+#define EC_ACPI_MEM_CHARGING_LIMIT     0x08
+
+/* Charging limit is specified in 64 mA steps */
+#define EC_ACPI_MEM_CHARGING_LIMIT_STEP_MA   64
+/* Value to disable DPTF battery charging limit */
+#define EC_ACPI_MEM_CHARGING_LIMIT_DISABLED  0xff
+
+/*
+ * Report device orientation
+ *  Bits       Definition
+ *  3:1        Device DPTF Profile Number (DDPN)
+ *               0   = Reserved for backward compatibility (indicates no valid
+ *                     profile number. Host should fall back to using TBMD).
+ *              1..7 = DPTF Profile number to indicate to host which table needs
+ *                     to be loaded.
+ *   0         Tablet Mode Device Indicator (TBMD)
+ */
+#define EC_ACPI_MEM_DEVICE_ORIENTATION 0x09
+#define EC_ACPI_MEM_TBMD_SHIFT         0
+#define EC_ACPI_MEM_TBMD_MASK          0x1
+#define EC_ACPI_MEM_DDPN_SHIFT         1
+#define EC_ACPI_MEM_DDPN_MASK          0x7
+
+/*
+ * Report device features. Uses the same format as the host command, except:
+ *
+ * bit 0 (EC_FEATURE_LIMITED) changes meaning from "EC code has a limited set
+ * of features", which is of limited interest when the system is already
+ * interpreting ACPI bytecode, to "EC_FEATURES[0-7] is not supported". Since
+ * these are supported, it defaults to 0.
+ * This allows detecting the presence of this field since older versions of
+ * the EC codebase would simply return 0xff to that unknown address. Check
+ * FEATURES0 != 0xff (or FEATURES0[0] == 0) to make sure that the other bits
+ * are valid.
+ */
+#define EC_ACPI_MEM_DEVICE_FEATURES0 0x0a
+#define EC_ACPI_MEM_DEVICE_FEATURES1 0x0b
+#define EC_ACPI_MEM_DEVICE_FEATURES2 0x0c
+#define EC_ACPI_MEM_DEVICE_FEATURES3 0x0d
+#define EC_ACPI_MEM_DEVICE_FEATURES4 0x0e
+#define EC_ACPI_MEM_DEVICE_FEATURES5 0x0f
+#define EC_ACPI_MEM_DEVICE_FEATURES6 0x10
+#define EC_ACPI_MEM_DEVICE_FEATURES7 0x11
+
+#define EC_ACPI_MEM_BATTERY_INDEX    0x12
+
+/*
+ * USB Port Power. Each bit indicates whether the corresponding USB ports' power
+ * is enabled (1) or disabled (0).
+ *   bit 0 USB port ID 0
+ *   ...
+ *   bit 7 USB port ID 7
+ */
+#define EC_ACPI_MEM_USB_PORT_POWER 0x13
+
+/*
+ * ACPI addresses 0x20 - 0xff map to EC_MEMMAP offset 0x00 - 0xdf.  This data
+ * is read-only from the AP.  Added in EC_ACPI_MEM_VERSION 2.
+ */
+#define EC_ACPI_MEM_MAPPED_BEGIN   0x20
+#define EC_ACPI_MEM_MAPPED_SIZE    0xe0
+
+/* Current version of ACPI memory address space */
+#define EC_ACPI_MEM_VERSION_CURRENT 2
+
+
 /*
  * This header file is used in coreboot both in C and ACPI code.  The ACPI code
  * is pre-processed to handle constants but the ASL compiler is unable to
  * handle actual C code so keep it separate.
  */
-#ifndef __ACPI__
+
 
 /*
  * Attributes for EC request and response packets.  Just defining __packed
@@ -238,7 +439,7 @@
 #define EC_LPC_STATUS_PROCESSING  0x04
 /* Last write to EC was a command, not data */
 #define EC_LPC_STATUS_LAST_CMD    0x08
-/* EC is in burst mode.  Unsupported by Chrome EC, so this bit is never set */
+/* EC is in burst mode */
 #define EC_LPC_STATUS_BURST_MODE  0x10
 /* SCI event is pending (requesting SCI query) */
 #define EC_LPC_STATUS_SCI_PENDING 0x20
@@ -2323,6 +2524,8 @@ struct ec_response_temp_sensor_get_info {
 /*****************************************************************************/
 /* Host event commands */
 
+
+/* Obsolete. New implementation should use EC_CMD_HOST_EVENT instead */
 /*
  * Host event mask params and response structures, shared by all of the host
  * event commands below.
@@ -2348,6 +2551,86 @@ struct ec_response_host_event_mask {
 #define EC_CMD_HOST_EVENT_SET_WAKE_MASK 0x008E
 #define EC_CMD_HOST_EVENT_CLEAR_B       0x008F
 
+/*
+ * Unified host event programming interface - Should be used by newer versions
+ * of BIOS/OS to program host events and masks
+ */
+
+struct ec_params_host_event {
+
+	/* Action requested by host - one of enum ec_host_event_action. */
+	uint8_t action;
+
+	/*
+	 * Mask type that the host requested the action on - one of
+	 * enum ec_host_event_mask_type.
+	 */
+	uint8_t mask_type;
+
+	/* Set to 0, ignore on read */
+	uint16_t reserved;
+
+	/* Value to be used in case of set operations. */
+	uint64_t value;
+} __ec_align4;
+
+/*
+ * Response structure returned by EC_CMD_HOST_EVENT.
+ * Update the value on a GET request. Set to 0 on GET/CLEAR
+ */
+
+struct ec_response_host_event {
+
+	/* Mask value in case of get operation */
+	uint64_t value;
+} __ec_align4;
+
+enum ec_host_event_action {
+	/*
+	 * params.value is ignored. Value of mask_type populated
+	 * in response.value
+	 */
+	EC_HOST_EVENT_GET,
+
+	/* Bits in params.value are set */
+	EC_HOST_EVENT_SET,
+
+	/* Bits in params.value are cleared */
+	EC_HOST_EVENT_CLEAR,
+};
+
+enum ec_host_event_mask_type {
+
+	/* Main host event copy */
+	EC_HOST_EVENT_MAIN,
+
+	/* Copy B of host events */
+	EC_HOST_EVENT_B,
+
+	/* SCI Mask */
+	EC_HOST_EVENT_SCI_MASK,
+
+	/* SMI Mask */
+	EC_HOST_EVENT_SMI_MASK,
+
+	/* Mask of events that should be always reported in hostevents */
+	EC_HOST_EVENT_ALWAYS_REPORT_MASK,
+
+	/* Active wake mask */
+	EC_HOST_EVENT_ACTIVE_WAKE_MASK,
+
+	/* Lazy wake mask for S0ix */
+	EC_HOST_EVENT_LAZY_WAKE_MASK_S0IX,
+
+	/* Lazy wake mask for S3 */
+	EC_HOST_EVENT_LAZY_WAKE_MASK_S3,
+
+	/* Lazy wake mask for S5 */
+	EC_HOST_EVENT_LAZY_WAKE_MASK_S5,
+};
+
+#define EC_CMD_HOST_EVENT       0x00A4
+
 /*****************************************************************************/
 /* Switch commands */
 
@@ -3056,122 +3339,6 @@ struct ec_params_reboot_ec {
  */
 #define EC_CMD_GET_PANIC_INFO 0x00D3
 
-/*****************************************************************************/
-/*
- * ACPI commands
- *
- * These are valid ONLY on the ACPI command/data port.
- */
-
-/*
- * ACPI Read Embedded Controller
- *
- * This reads from ACPI memory space on the EC (EC_ACPI_MEM_*).
- *
- * Use the following sequence:
- *
- *    - Write EC_CMD_ACPI_READ to EC_LPC_ADDR_ACPI_CMD
- *    - Wait for EC_LPC_CMDR_PENDING bit to clear
- *    - Write address to EC_LPC_ADDR_ACPI_DATA
- *    - Wait for EC_LPC_CMDR_DATA bit to set
- *    - Read value from EC_LPC_ADDR_ACPI_DATA
- */
-#define EC_CMD_ACPI_READ 0x80
-
-/*
- * ACPI Write Embedded Controller
- *
- * This reads from ACPI memory space on the EC (EC_ACPI_MEM_*).
- *
- * Use the following sequence:
- *
- *    - Write EC_CMD_ACPI_WRITE to EC_LPC_ADDR_ACPI_CMD
- *    - Wait for EC_LPC_CMDR_PENDING bit to clear
- *    - Write address to EC_LPC_ADDR_ACPI_DATA
- *    - Wait for EC_LPC_CMDR_PENDING bit to clear
- *    - Write value to EC_LPC_ADDR_ACPI_DATA
- */
-#define EC_CMD_ACPI_WRITE 0x81
-
-/*
- * ACPI Query Embedded Controller
- *
- * This clears the lowest-order bit in the currently pending host events, and
- * sets the result code to the 1-based index of the bit (event 0x00000001 = 1,
- * event 0x80000000 = 32), or 0 if no event was pending.
- */
-#define EC_CMD_ACPI_QUERY_EVENT 0x84
-
-/* Valid addresses in ACPI memory space, for read/write commands */
-
-/* Memory space version; set to EC_ACPI_MEM_VERSION_CURRENT */
-#define EC_ACPI_MEM_VERSION            0x00
-/*
- * Test location; writing value here updates test compliment byte to (0xff -
- * value).
- */
-#define EC_ACPI_MEM_TEST               0x01
-/* Test compliment; writes here are ignored. */
-#define EC_ACPI_MEM_TEST_COMPLIMENT    0x02
-
-/* Keyboard backlight brightness percent (0 - 100) */
-#define EC_ACPI_MEM_KEYBOARD_BACKLIGHT 0x03
-/* DPTF Target Fan Duty (0-100, 0xff for auto/none) */
-#define EC_ACPI_MEM_FAN_DUTY           0x04
-
-/*
- * DPTF temp thresholds. Any of the EC's temp sensors can have up to two
- * independent thresholds attached to them. The current value of the ID
- * register determines which sensor is affected by the THRESHOLD and COMMIT
- * registers. The THRESHOLD register uses the same EC_TEMP_SENSOR_OFFSET scheme
- * as the memory-mapped sensors. The COMMIT register applies those settings.
- *
- * The spec does not mandate any way to read back the threshold settings
- * themselves, but when a threshold is crossed the AP needs a way to determine
- * which sensor(s) are responsible. Each reading of the ID register clears and
- * returns one sensor ID that has crossed one of its threshold (in either
- * direction) since the last read. A value of 0xFF means "no new thresholds
- * have tripped". Setting or enabling the thresholds for a sensor will clear
- * the unread event count for that sensor.
- */
-#define EC_ACPI_MEM_TEMP_ID            0x05
-#define EC_ACPI_MEM_TEMP_THRESHOLD     0x06
-#define EC_ACPI_MEM_TEMP_COMMIT        0x07
-/*
- * Here are the bits for the COMMIT register:
- *   bit 0 selects the threshold index for the chosen sensor (0/1)
- *   bit 1 enables/disables the selected threshold (0 = off, 1 = on)
- * Each write to the commit register affects one threshold.
- */
-#define EC_ACPI_MEM_TEMP_COMMIT_SELECT_MASK (1 << 0)
-#define EC_ACPI_MEM_TEMP_COMMIT_ENABLE_MASK (1 << 1)
-/*
- * Example:
- *
- * Set the thresholds for sensor 2 to 50 C and 60 C:
- *   write 2 to [0x05]      --  select temp sensor 2
- *   write 0x7b to [0x06]   --  C_TO_K(50) - EC_TEMP_SENSOR_OFFSET
- *   write 0x2 to [0x07]    --  enable threshold 0 with this value
- *   write 0x85 to [0x06]   --  C_TO_K(60) - EC_TEMP_SENSOR_OFFSET
- *   write 0x3 to [0x07]    --  enable threshold 1 with this value
- *
- * Disable the 60 C threshold, leaving the 50 C threshold unchanged:
- *   write 2 to [0x05]      --  select temp sensor 2
- *   write 0x1 to [0x07]    --  disable threshold 1
- */
-
-/* DPTF battery charging current limit */
-#define EC_ACPI_MEM_CHARGING_LIMIT     0x08
-
-/* Charging limit is specified in 64 mA steps */
-#define EC_ACPI_MEM_CHARGING_LIMIT_STEP_MA   64
-/* Value to disable DPTF battery charging limit */
-#define EC_ACPI_MEM_CHARGING_LIMIT_DISABLED  0xff
-
-/* Current version of ACPI memory address space */
-#define EC_ACPI_MEM_VERSION_CURRENT 1
-
-
 /*****************************************************************************/
 /*
  * HDMI CEC commands
@@ -3285,8 +3452,6 @@ enum mkbp_cec_event {
  */
 #define EC_CMD_VERSION0 0x00DC
 
-#endif  /* !__ACPI__ */
-
 /*****************************************************************************/
 /*
  * PD commands
@@ -3627,4 +3792,6 @@ struct ec_response_usb_pd_mux_info {
 #define EC_LPC_ADDR_OLD_PARAM   EC_HOST_CMD_REGION1
 #define EC_OLD_PARAM_SIZE       EC_HOST_CMD_REGION_SIZE
 
+
+
 #endif  /* __CROS_EC_COMMANDS_H */
-- 
2.21.0.1020.gf2820cf01a-goog

