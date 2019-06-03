Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED733815
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFCSeg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:34:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36596 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFCSeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so1372942pgb.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLzzR/wQVjWPVjGHZlhQqQ91jRds2ArCqriw28T7tRo=;
        b=CB8R4ZXjOcl3mCOdBT03xS5/z6WlBD8IXMnMDH1uwLjV5Oh33JMfOfOj4zx4KkUPZ+
         LG/qUYSU6ROSXsyN7QeapuA8Tr1ak69V4lfmdufXG0KnVBoP2bMTHqSiS8UN4BHkQ/E7
         PJXVeneU0IMg/BcnCZk3BxEkzcxvUk9/kck2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLzzR/wQVjWPVjGHZlhQqQ91jRds2ArCqriw28T7tRo=;
        b=sftbG7cYWCyM6eZmE2o1L7/YNl3zu0Hwd8oWLAQEtcZ24BYvHHXO8vsKdd3HZjcygV
         VmxsMD9xZFoT2TjXvCb6xvMqDHJAcL5QNnILf5WL48k6FYepBTorZxfGaRsE02xicM0w
         wSBR2XEDM/hQoc3kM1GpqaMLx3wcyvl+aigndD62hdK4W4kddXwslektDuP0OPhU/0Ls
         dj7uprrJN4qFHLUGWdWsnp+C/g5N4MTFagbPRaueYzE2BOyXmdM217AMimNGa0wvGtHN
         4ixjBcp54s+ZlvTc7gIa/1dKDA76XZTbJlZ0uB06l9B4sAkkkSvzfS9c/5oxmyFmNjn8
         bRrw==
X-Gm-Message-State: APjAAAXyc5Y15tABriHd8FNNfXWoY1vkZpxHYthF6pozQSjspPCJpFaZ
        XuLp5XG3vw6sBMwTjGHpiRPiSwTnDCpWeQ==
X-Google-Smtp-Source: APXvYqy/CZi019B16u5Tp99pXAoR7z7UhVMlHzP1xEZ7FCuBZMtjxZpKt6som8c6ZgLQsAF0JjCYZQ==
X-Received: by 2002:a62:b50c:: with SMTP id y12mr27029382pfe.171.1559586875477;
        Mon, 03 Jun 2019 11:34:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m3sm9993917pfh.23.2019.06.03.11.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:34 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 19/30] mfd: cros_ec: Complete Power and USB PD API
Date:   Mon,  3 Jun 2019 11:33:50 -0700
Message-Id: <20190603183401.151408-20-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Improve API for USB Powe delivery and power management.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 236 ++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 9a84aad7475a..e05cdcb12481 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2796,7 +2796,8 @@ struct ec_params_config_power_button {
 
 struct ec_params_usb_charge_set_mode {
 	uint8_t usb_port_id;
-	uint8_t mode;
+	uint8_t mode:7;
+	uint8_t inhibit_charge:1;
 } __ec_align1;
 
 /*****************************************************************************/
@@ -3933,6 +3934,11 @@ enum charge_state_params {
 	CS_PARAM_CHG_INPUT_CURRENT,   /* charger input current limit */
 	CS_PARAM_CHG_STATUS,	      /* charger-specific status */
 	CS_PARAM_CHG_OPTION,	      /* charger-specific options */
+	CS_PARAM_LIMIT_POWER,	      /*
+				       * Check if power is limited due to
+				       * low battery and / or a weak external
+				       * charger. READ ONLY.
+				       */
 	/* How many so far? */
 	CS_NUM_BASE_PARAMS,
 
@@ -3940,6 +3946,17 @@ enum charge_state_params {
 	CS_PARAM_CUSTOM_PROFILE_MIN = 0x10000,
 	CS_PARAM_CUSTOM_PROFILE_MAX = 0x1ffff,
 
+	/* Range for CONFIG_CHARGE_STATE_DEBUG params */
+	CS_PARAM_DEBUG_MIN = 0x20000,
+	CS_PARAM_DEBUG_CTL_MODE = 0x20000,
+	CS_PARAM_DEBUG_MANUAL_MODE,
+	CS_PARAM_DEBUG_SEEMS_DEAD,
+	CS_PARAM_DEBUG_SEEMS_DISCONNECTED,
+	CS_PARAM_DEBUG_BATT_REMOVED,
+	CS_PARAM_DEBUG_MANUAL_CURRENT,
+	CS_PARAM_DEBUG_MANUAL_VOLTAGE,
+	CS_PARAM_DEBUG_MAX = 0x2ffff,
+
 	/* Other custom param ranges go here... */
 };
 
@@ -4000,6 +4017,16 @@ struct ec_params_external_power_limit_v1 {
 
 #define EC_POWER_LIMIT_NONE 0xffff
 
+/*
+ * Set maximum voltage & current of a dedicated charge port
+ */
+#define EC_CMD_OVERRIDE_DEDICATED_CHARGER_LIMIT 0x00A3
+
+struct ec_params_dedicated_charger_limit {
+	uint16_t current_lim; /* in mA */
+	uint16_t voltage_lim; /* in mV */
+} __ec_align2;
+
 /* Inform the EC when entering a sleep state */
 #define EC_CMD_HOST_SLEEP_EVENT 0x00A9
 
@@ -4385,18 +4412,53 @@ struct ec_params_reboot_ec {
 
 /* EC to PD MCU exchange status command */
 #define EC_CMD_PD_EXCHANGE_STATUS 0x0100
+#define EC_VER_PD_EXCHANGE_STATUS 2
+
+enum pd_charge_state {
+	PD_CHARGE_NO_CHANGE = 0, /* Don't change charge state */
+	PD_CHARGE_NONE,          /* No charging allowed */
+	PD_CHARGE_5V,            /* 5V charging only */
+	PD_CHARGE_MAX            /* Charge at max voltage */
+};
 
 /* Status of EC being sent to PD */
+#define EC_STATUS_HIBERNATING	BIT(0)
+
 struct ec_params_pd_status {
-	int8_t batt_soc; /* battery state of charge */
+	uint8_t status;       /* EC status */
+	int8_t batt_soc;      /* battery state of charge */
+	uint8_t charge_state; /* charging state (from enum pd_charge_state) */
 } __ec_align1;
 
 /* Status of PD being sent back to EC */
+#define PD_STATUS_HOST_EVENT      BIT(0) /* Forward host event to AP */
+#define PD_STATUS_IN_RW           BIT(1) /* Running RW image */
+#define PD_STATUS_JUMPED_TO_IMAGE BIT(2) /* Current image was jumped to */
+#define PD_STATUS_TCPC_ALERT_0    BIT(3) /* Alert active in port 0 TCPC */
+#define PD_STATUS_TCPC_ALERT_1    BIT(4) /* Alert active in port 1 TCPC */
+#define PD_STATUS_TCPC_ALERT_2    BIT(5) /* Alert active in port 2 TCPC */
+#define PD_STATUS_TCPC_ALERT_3    BIT(6) /* Alert active in port 3 TCPC */
+#define PD_STATUS_EC_INT_ACTIVE  (PD_STATUS_TCPC_ALERT_0 | \
+				      PD_STATUS_TCPC_ALERT_1 | \
+				      PD_STATUS_HOST_EVENT)
 struct ec_response_pd_status {
-	int8_t status;        /* PD MCU status */
-	uint32_t curr_lim_ma; /* input current limit */
+	uint32_t curr_lim_ma;       /* input current limit */
+	uint16_t status;            /* PD MCU status */
+	int8_t active_charge_port;  /* active charging port */
 } __ec_align_size1;
 
+/* AP to PD MCU host event status command, cleared on read */
+#define EC_CMD_PD_HOST_EVENT_STATUS 0x0104
+
+/* PD MCU host event status bits */
+#define PD_EVENT_UPDATE_DEVICE     BIT(0)
+#define PD_EVENT_POWER_CHANGE      BIT(1)
+#define PD_EVENT_IDENTITY_RECEIVED BIT(2)
+#define PD_EVENT_DATA_SWAP         BIT(3)
+struct ec_response_host_event_status {
+	uint32_t status;      /* PD MCU host event status */
+} __ec_align4;
+
 /* Set USB type-C port role and muxes */
 #define EC_CMD_USB_PD_CONTROL 0x0101
 
@@ -4406,6 +4468,8 @@ enum usb_pd_control_role {
 	USB_PD_CTRL_ROLE_TOGGLE_OFF = 2,
 	USB_PD_CTRL_ROLE_FORCE_SINK = 3,
 	USB_PD_CTRL_ROLE_FORCE_SOURCE = 4,
+	USB_PD_CTRL_ROLE_FREEZE = 5,
+	USB_PD_CTRL_ROLE_COUNT
 };
 
 enum usb_pd_control_mux {
@@ -4415,6 +4479,7 @@ enum usb_pd_control_mux {
 	USB_PD_CTRL_MUX_DP = 3,
 	USB_PD_CTRL_MUX_DOCK = 4,
 	USB_PD_CTRL_MUX_AUTO = 5,
+	USB_PD_CTRL_MUX_COUNT
 };
 
 enum usb_pd_control_swap {
@@ -4444,6 +4509,13 @@ struct ec_params_usb_pd_control {
 #define PD_CTRL_RESP_ROLE_USB_COMM      BIT(5) /* Partner USB comm capable */
 #define PD_CTRL_RESP_ROLE_EXT_POWERED   BIT(6) /* Partner externally powerd */
 
+struct ec_response_usb_pd_control {
+	uint8_t enabled;
+	uint8_t role;
+	uint8_t polarity;
+	uint8_t state;
+} __ec_align1;
+
 struct ec_response_usb_pd_control_v1 {
 	uint8_t enabled;
 	uint8_t role;
@@ -4451,6 +4523,25 @@ struct ec_response_usb_pd_control_v1 {
 	char state[32];
 } __ec_align1;
 
+/* Values representing usbc PD CC state */
+#define USBC_PD_CC_NONE		0 /* No accessory connected */
+#define USBC_PD_CC_NO_UFP	1 /* No UFP accessory connected */
+#define USBC_PD_CC_AUDIO_ACC	2 /* Audio accessory connected */
+#define USBC_PD_CC_DEBUG_ACC	3 /* Debug accessory connected */
+#define USBC_PD_CC_UFP_ATTACHED	4 /* UFP attached to usbc */
+#define USBC_PD_CC_DFP_ATTACHED	5 /* DPF attached to usbc */
+
+struct ec_response_usb_pd_control_v2 {
+	uint8_t enabled;
+	uint8_t role;
+	uint8_t polarity;
+	char state[32];
+	uint8_t cc_state; /* USBC_PD_CC_*Encoded cc state */
+	uint8_t dp_mode;  /* Current DP pin mode (MODE_DP_PIN_[A-E]) */
+	/* CL:1500994 Current cable type */
+	uint8_t reserved_cable_type;
+} __ec_align1;
+
 #define EC_CMD_USB_PD_PORTS 0x0102
 
 /* Maximum number of PD ports on a device, num_ports will be <= this */
@@ -4478,6 +4569,7 @@ enum usb_chg_type {
 	USB_CHG_TYPE_OTHER,
 	USB_CHG_TYPE_VBUS,
 	USB_CHG_TYPE_UNKNOWN,
+	USB_CHG_TYPE_DEDICATED,
 };
 enum usb_power_roles {
 	USB_PD_PORT_POWER_DISCONNECTED,
@@ -4502,9 +4594,6 @@ struct ec_response_usb_pd_power_info {
 	uint32_t max_power;
 } __ec_align4;
 
-struct ec_params_usb_pd_info_request {
-	uint8_t port;
-} __ec_align1;
 
 /*
  * This command will return the number of USB PD charge port + the number
@@ -4516,6 +4605,46 @@ struct ec_response_charge_port_count {
 	uint8_t port_count;
 } __ec_align1;
 
+/* Write USB-PD device FW */
+#define EC_CMD_USB_PD_FW_UPDATE 0x0110
+
+enum usb_pd_fw_update_cmds {
+	USB_PD_FW_REBOOT,
+	USB_PD_FW_FLASH_ERASE,
+	USB_PD_FW_FLASH_WRITE,
+	USB_PD_FW_ERASE_SIG,
+};
+
+struct ec_params_usb_pd_fw_update {
+	uint16_t dev_id;
+	uint8_t cmd;
+	uint8_t port;
+	uint32_t size;     /* Size to write in bytes */
+	/* Followed by data to write */
+} __ec_align4;
+
+/* Write USB-PD Accessory RW_HASH table entry */
+#define EC_CMD_USB_PD_RW_HASH_ENTRY 0x0111
+/* RW hash is first 20 bytes of SHA-256 of RW section */
+#define PD_RW_HASH_SIZE 20
+struct ec_params_usb_pd_rw_hash_entry {
+	uint16_t dev_id;
+	uint8_t dev_rw_hash[PD_RW_HASH_SIZE];
+	uint8_t reserved;        /*
+				  * For alignment of current_image
+				  * TODO(rspangler) but it's not aligned!
+				  * Should have been reserved[2].
+				  */
+	uint32_t current_image;  /* One of ec_current_image */
+} __ec_align1;
+
+/* Read USB-PD Accessory info */
+#define EC_CMD_USB_PD_DEV_INFO 0x0112
+
+struct ec_params_usb_pd_info_request {
+	uint8_t port;
+} __ec_align1;
+
 /* Read USB-PD Device discovery info */
 #define EC_CMD_USB_PD_DISCOVERY 0x0113
 struct ec_params_usb_pd_discovery_entry {
@@ -4538,7 +4667,11 @@ struct ec_params_charge_port_override {
 	int16_t override_port; /* Override port# */
 } __ec_align2;
 
-/* Read (and delete) one entry of PD event log */
+/*
+ * Read (and delete) one entry of PD event log.
+ * TODO(crbug.com/751742): Make this host command more generic to accommodate
+ * future non-PD logs that use the same internal EC event_log.
+ */
 #define EC_CMD_PD_GET_LOG_ENTRY 0x0115
 
 struct ec_response_pd_log {
@@ -4626,6 +4759,60 @@ struct mcdp_info {
 #define MCDP_CHIPID(chipid) ((chipid[0] << 8) | chipid[1])
 #define MCDP_FAMILY(family) ((family[0] << 8) | family[1])
 
+/* Get/Set USB-PD Alternate mode info */
+#define EC_CMD_USB_PD_GET_AMODE 0x0116
+struct ec_params_usb_pd_get_mode_request {
+	uint16_t svid_idx; /* SVID index to get */
+	uint8_t port;      /* port */
+} __ec_align_size1;
+
+struct ec_params_usb_pd_get_mode_response {
+	uint16_t svid;   /* SVID */
+	uint16_t opos;    /* Object Position */
+	uint32_t vdo[6]; /* Mode VDOs */
+} __ec_align4;
+
+#define EC_CMD_USB_PD_SET_AMODE 0x0117
+
+enum pd_mode_cmd {
+	PD_EXIT_MODE = 0,
+	PD_ENTER_MODE = 1,
+	/* Not a command.  Do NOT remove. */
+	PD_MODE_CMD_COUNT,
+};
+
+struct ec_params_usb_pd_set_mode_request {
+	uint32_t cmd;  /* enum pd_mode_cmd */
+	uint16_t svid; /* SVID to set */
+	uint8_t opos;  /* Object Position */
+	uint8_t port;  /* port */
+} __ec_align4;
+
+/* Ask the PD MCU to record a log of a requested type */
+#define EC_CMD_PD_WRITE_LOG_ENTRY 0x0118
+
+struct ec_params_pd_write_log_entry {
+	uint8_t type; /* event type : see PD_EVENT_xx above */
+	uint8_t port; /* port#, or 0 for events unrelated to a given port */
+} __ec_align1;
+
+
+/* Control USB-PD chip */
+#define EC_CMD_PD_CONTROL 0x0119
+
+enum ec_pd_control_cmd {
+	PD_SUSPEND = 0,      /* Suspend the PD chip (EC: stop talking to PD) */
+	PD_RESUME,           /* Resume the PD chip (EC: start talking to PD) */
+	PD_RESET,            /* Force reset the PD chip */
+	PD_CONTROL_DISABLE,  /* Disable further calls to this command */
+	PD_CHIP_ON,          /* Power on the PD chip */
+};
+
+struct ec_params_pd_control {
+	uint8_t chip;         /* chip id */
+	uint8_t subcmd;
+} __ec_align1;
+
 /* Get info about USB-C SS muxes */
 #define EC_CMD_USB_PD_MUX_INFO 0x011A
 
@@ -4638,10 +4825,43 @@ struct ec_params_usb_pd_mux_info {
 #define USB_PD_MUX_DP_ENABLED        BIT(1) /* DP connected */
 #define USB_PD_MUX_POLARITY_INVERTED BIT(2) /* CC line Polarity inverted */
 #define USB_PD_MUX_HPD_IRQ           BIT(3) /* HPD IRQ is asserted */
+#define USB_PD_MUX_HPD_LVL           BIT(4) /* HPD level is asserted */
 
 struct ec_response_usb_pd_mux_info {
 	uint8_t flags; /* USB_PD_MUX_*-encoded USB mux state */
 } __ec_align1;
+
+#define EC_CMD_PD_CHIP_INFO		0x011B
+
+struct ec_params_pd_chip_info {
+	uint8_t port;	/* USB-C port number */
+	uint8_t renew;	/* Force renewal */
+} __ec_align1;
+
+struct ec_response_pd_chip_info {
+	uint16_t vendor_id;
+	uint16_t product_id;
+	uint16_t device_id;
+	union {
+		uint8_t fw_version_string[8];
+		uint64_t fw_version_number;
+	};
+} __ec_align2;
+
+struct ec_response_pd_chip_info_v1 {
+	uint16_t vendor_id;
+	uint16_t product_id;
+	uint16_t device_id;
+	union {
+		uint8_t fw_version_string[8];
+		uint64_t fw_version_number;
+	};
+	union {
+		uint8_t min_req_fw_version_string[8];
+		uint64_t min_req_fw_version_number;
+	};
+} __ec_align2;
+
 /*****************************************************************************/
 /*
  * Reserve a range of host commands for board-specific, experimental, or
-- 
2.21.0.1020.gf2820cf01a-goog

