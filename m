Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E273381D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFCSgN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 14:36:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37808 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfFCSea (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 14:34:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so11112773pff.4
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHQLAlUeoXGgF7wYq9wqbe9nkm08qs4rBamcBZ6vt/g=;
        b=V5zk+KOM1nhJDHUo0Y4hIGadLHDhgAYlhla6u/3WDTPdK7+/jLWSbb6f1UvLR/G9cg
         SHNdaeiQDc06uxr8kZz4WbKPfxQ5WNHVRjpDbNjA8kJfNmzrkOTCnf/fK4x5Bn/wdzik
         0FtNiVBBjcQBxReuJGfxLupjymzcRX3ZnBZ7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHQLAlUeoXGgF7wYq9wqbe9nkm08qs4rBamcBZ6vt/g=;
        b=fg98fChR9lW8ctAmM0Y2xFX5/YFqbLnsJGCYRDWSFbU++n/E6DXLsVkEdNHGoRfdKD
         fEuJ6sM9uZjgmRNPHAZ9a5PrGxepp5xzv73yYftl55L9dfa+FX2MMuk4ImAaFvMRymBA
         a56dyt8GJkTHLo1UO3N3hD4N8L7GcM8RwDT2tT6gPqzk1iOJ1Tsp5MAmh9KjZYwpsP7t
         dlulb7MEvmgatWaTp54vZLtllNil3jy/w/aZhTjTkTj+yzwExwkR4bDSZtpIOia+Mg+e
         01pL82PZHqRDPY2eL3bpyqd9U8OIYQEkYEKGdIZ3lRLsv8ObSTduwQm02sYXX97SZ7ck
         GC9A==
X-Gm-Message-State: APjAAAWGEp5OCmiTmvGkCph/ljd6icBRPAdQRCJQ7Ay+TGrzTV8ia3cf
        hcF/uzbnO/9O/l16sGjfPIq7zg==
X-Google-Smtp-Source: APXvYqwBLdVNMzhkuTiBpdS++9L/BNqHmtNJ5fyBMyKyBBPBlR1A9E/BOfBcvqjq49wwoLmJNjudzQ==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr33236846pfk.239.1559586869569;
        Mon, 03 Jun 2019 11:34:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q125sm33387154pfq.62.2019.06.03.11.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:29 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 15/30] mfd: cros_ec: Complete MEMS sensor API
Date:   Mon,  3 Jun 2019 11:33:46 -0700
Message-Id: <20190603183401.151408-16-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new command for batched mode, add support for more sensors.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 464 +++++++++++++++++++++++----
 1 file changed, 406 insertions(+), 58 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 40a8069a58e8..701b03cfa445 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2191,7 +2191,13 @@ enum motionsense_command {
 
 	/*
 	 * EC Rate command is a setter/getter command for the EC sampling rate
-	 * of all motion sensors in milliseconds.
+	 * in milliseconds.
+	 * It is per sensor, the EC run sample task  at the minimum of all
+	 * sensors EC_RATE.
+	 * For sensors without hardware FIFO, EC_RATE should be equals to 1/ODR
+	 * to collect all the sensor samples.
+	 * For sensor with hardware FIFO, EC_RATE is used as the maximal delay
+	 * to process of all motion sensors in milliseconds.
 	 */
 	MOTIONSENSE_CMD_EC_RATE = 2,
 
@@ -2222,32 +2228,76 @@ enum motionsense_command {
 	MOTIONSENSE_CMD_DATA = 6,
 
 	/*
-	 * Perform low level calibration.. On sensors that support it, ask to
-	 * do offset calibration.
+	 * Return sensor fifo info.
+	 */
+	MOTIONSENSE_CMD_FIFO_INFO = 7,
+
+	/*
+	 * Insert a flush element in the fifo and return sensor fifo info.
+	 * The host can use that element to synchronize its operation.
+	 */
+	MOTIONSENSE_CMD_FIFO_FLUSH = 8,
+
+	/*
+	 * Return a portion of the fifo.
+	 */
+	MOTIONSENSE_CMD_FIFO_READ = 9,
+
+	/*
+	 * Perform low level calibration.
+	 * On sensors that support it, ask to do offset calibration.
 	 */
 	MOTIONSENSE_CMD_PERFORM_CALIB = 10,
 
 	/*
-	 * Sensor Offset command is a setter/getter command for the offset used
-	 * for calibration. The offsets can be calculated by the host, or via
+	 * Sensor Offset command is a setter/getter command for the offset
+	 * used for calibration.
+	 * The offsets can be calculated by the host, or via
 	 * PERFORM_CALIB command.
 	 */
 	MOTIONSENSE_CMD_SENSOR_OFFSET = 11,
 
-	/* Number of motionsense sub-commands. */
-	MOTIONSENSE_NUM_CMDS
-};
+	/*
+	 * List available activities for a MOTION sensor.
+	 * Indicates if they are enabled or disabled.
+	 */
+	MOTIONSENSE_CMD_LIST_ACTIVITIES = 12,
+
+	/*
+	 * Activity management
+	 * Enable/Disable activity recognition.
+	 */
+	MOTIONSENSE_CMD_SET_ACTIVITY = 13,
+
+	/*
+	 * Lid Angle
+	 */
+	MOTIONSENSE_CMD_LID_ANGLE = 14,
+
+	/*
+	 * Allow the FIFO to trigger interrupt via MKBP events.
+	 * By default the FIFO does not send interrupt to process the FIFO
+	 * until the AP is ready or it is coming from a wakeup sensor.
+	 */
+	MOTIONSENSE_CMD_FIFO_INT_ENABLE = 15,
+
+	/*
+	 * Spoof the readings of the sensors.  The spoofed readings can be set
+	 * to arbitrary values, or will lock to the last read actual values.
+	 */
+	MOTIONSENSE_CMD_SPOOF = 16,
 
-enum motionsensor_id {
-	EC_MOTION_SENSOR_ACCEL_BASE = 0,
-	EC_MOTION_SENSOR_ACCEL_LID = 1,
-	EC_MOTION_SENSOR_GYRO = 2,
+	/* Set lid angle for tablet mode detection. */
+	MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE = 17,
 
 	/*
-	 * Note, if more sensors are added and this count changes, the padding
-	 * in ec_response_motion_sense dump command must be modified.
+	 * Sensor Scale command is a setter/getter command for the calibration
+	 * scale.
 	 */
-	EC_MOTION_SENSOR_COUNT = 3
+	MOTIONSENSE_CMD_SENSOR_SCALE = 18,
+
+	/* Number of motionsense sub-commands. */
+	MOTIONSENSE_NUM_CMDS
 };
 
 /* List of motion sensor types. */
@@ -2259,6 +2309,7 @@ enum motionsensor_type {
 	MOTIONSENSE_TYPE_LIGHT = 4,
 	MOTIONSENSE_TYPE_ACTIVITY = 5,
 	MOTIONSENSE_TYPE_BARO = 6,
+	MOTIONSENSE_TYPE_SYNC = 7,
 	MOTIONSENSE_TYPE_MAX,
 };
 
@@ -2266,36 +2317,48 @@ enum motionsensor_type {
 enum motionsensor_location {
 	MOTIONSENSE_LOC_BASE = 0,
 	MOTIONSENSE_LOC_LID = 1,
+	MOTIONSENSE_LOC_CAMERA = 2,
 	MOTIONSENSE_LOC_MAX,
 };
 
 /* List of motion sensor chips. */
 enum motionsensor_chip {
 	MOTIONSENSE_CHIP_KXCJ9 = 0,
+	MOTIONSENSE_CHIP_LSM6DS0 = 1,
+	MOTIONSENSE_CHIP_BMI160 = 2,
+	MOTIONSENSE_CHIP_SI1141 = 3,
+	MOTIONSENSE_CHIP_SI1142 = 4,
+	MOTIONSENSE_CHIP_SI1143 = 5,
+	MOTIONSENSE_CHIP_KX022 = 6,
+	MOTIONSENSE_CHIP_L3GD20H = 7,
+	MOTIONSENSE_CHIP_BMA255 = 8,
+	MOTIONSENSE_CHIP_BMP280 = 9,
+	MOTIONSENSE_CHIP_OPT3001 = 10,
+	MOTIONSENSE_CHIP_BH1730 = 11,
+	MOTIONSENSE_CHIP_GPIO = 12,
+	MOTIONSENSE_CHIP_LIS2DH = 13,
+	MOTIONSENSE_CHIP_LSM6DSM = 14,
+	MOTIONSENSE_CHIP_LIS2DE = 15,
+	MOTIONSENSE_CHIP_LIS2MDL = 16,
+	MOTIONSENSE_CHIP_LSM6DS3 = 17,
+	MOTIONSENSE_CHIP_LSM6DSO = 18,
+	MOTIONSENSE_CHIP_LNG2DM = 19,
+	MOTIONSENSE_CHIP_MAX,
 };
 
-/* Module flag masks used for the dump sub-command. */
-#define MOTIONSENSE_MODULE_FLAG_ACTIVE (1<<0)
-
-/* Sensor flag masks used for the dump sub-command. */
-#define MOTIONSENSE_SENSOR_FLAG_PRESENT (1<<0)
-
-/*
- * Send this value for the data element to only perform a read. If you
- * send any other value, the EC will interpret it as data to set and will
- * return the actual value set.
- */
-#define EC_MOTION_SENSE_NO_VALUE -1
-
-#define EC_MOTION_SENSE_INVALID_CALIB_TEMP 0x8000
-
-/* Set Calibration information */
-#define MOTION_SENSE_SET_OFFSET	1
+/* List of orientation positions */
+enum motionsensor_orientation {
+	MOTIONSENSE_ORIENTATION_LANDSCAPE = 0,
+	MOTIONSENSE_ORIENTATION_PORTRAIT = 1,
+	MOTIONSENSE_ORIENTATION_UPSIDE_DOWN_PORTRAIT = 2,
+	MOTIONSENSE_ORIENTATION_UPSIDE_DOWN_LANDSCAPE = 3,
+	MOTIONSENSE_ORIENTATION_UNKNOWN = 4,
+};
 
 struct ec_response_motion_sensor_data {
 	/* Flags for each sensor. */
 	uint8_t flags;
-	/* Sensor number the data comes from */
+	/* Sensor number the data comes from. */
 	uint8_t sensor_num;
 	/* Each sensor is up to 3-axis. */
 	union {
@@ -2312,22 +2375,138 @@ struct ec_response_motion_sensor_data {
 	};
 } __ec_todo_packed;
 
+/* Note: used in ec_response_get_next_data */
+struct ec_response_motion_sense_fifo_info {
+	/* Size of the fifo */
+	uint16_t size;
+	/* Amount of space used in the fifo */
+	uint16_t count;
+	/* Timestamp recorded in us.
+	 * aka accurate timestamp when host event was triggered.
+	 */
+	uint32_t timestamp;
+	/* Total amount of vector lost */
+	uint16_t total_lost;
+	/* Lost events since the last fifo_info, per sensors */
+	uint16_t lost[0];
+} __ec_todo_packed;
+
+struct ec_response_motion_sense_fifo_data {
+	uint32_t number_data;
+	struct ec_response_motion_sensor_data data[0];
+} __ec_todo_packed;
+
+/* List supported activity recognition */
+enum motionsensor_activity {
+	MOTIONSENSE_ACTIVITY_RESERVED = 0,
+	MOTIONSENSE_ACTIVITY_SIG_MOTION = 1,
+	MOTIONSENSE_ACTIVITY_DOUBLE_TAP = 2,
+	MOTIONSENSE_ACTIVITY_ORIENTATION = 3,
+};
+
+struct ec_motion_sense_activity {
+	uint8_t sensor_num;
+	uint8_t activity; /* one of enum motionsensor_activity */
+	uint8_t enable;   /* 1: enable, 0: disable */
+	uint8_t reserved;
+	uint16_t parameters[3]; /* activity dependent parameters */
+} __ec_todo_unpacked;
+
+/* Module flag masks used for the dump sub-command. */
+#define MOTIONSENSE_MODULE_FLAG_ACTIVE BIT(0)
+
+/* Sensor flag masks used for the dump sub-command. */
+#define MOTIONSENSE_SENSOR_FLAG_PRESENT BIT(0)
+
+/*
+ * Flush entry for synchronization.
+ * data contains time stamp
+ */
+#define MOTIONSENSE_SENSOR_FLAG_FLUSH BIT(0)
+#define MOTIONSENSE_SENSOR_FLAG_TIMESTAMP BIT(1)
+#define MOTIONSENSE_SENSOR_FLAG_WAKEUP BIT(2)
+#define MOTIONSENSE_SENSOR_FLAG_TABLET_MODE BIT(3)
+#define MOTIONSENSE_SENSOR_FLAG_ODR BIT(4)
+
+/*
+ * Send this value for the data element to only perform a read. If you
+ * send any other value, the EC will interpret it as data to set and will
+ * return the actual value set.
+ */
+#define EC_MOTION_SENSE_NO_VALUE -1
+
+#define EC_MOTION_SENSE_INVALID_CALIB_TEMP 0x8000
+
+/* MOTIONSENSE_CMD_SENSOR_OFFSET subcommand flag */
+/* Set Calibration information */
+#define MOTION_SENSE_SET_OFFSET BIT(0)
+
+/* Default Scale value, factor 1. */
+#define MOTION_SENSE_DEFAULT_SCALE BIT(15)
+
+#define LID_ANGLE_UNRELIABLE 500
+
+enum motionsense_spoof_mode {
+	/* Disable spoof mode. */
+	MOTIONSENSE_SPOOF_MODE_DISABLE = 0,
+
+	/* Enable spoof mode, but use provided component values. */
+	MOTIONSENSE_SPOOF_MODE_CUSTOM,
+
+	/* Enable spoof mode, but use the current sensor values. */
+	MOTIONSENSE_SPOOF_MODE_LOCK_CURRENT,
+
+	/* Query the current spoof mode status for the sensor. */
+	MOTIONSENSE_SPOOF_MODE_QUERY,
+};
+
 struct ec_params_motion_sense {
 	uint8_t cmd;
 	union {
 		/* Used for MOTIONSENSE_CMD_DUMP. */
 		struct __ec_todo_unpacked {
-			/* no args */
+			/*
+			 * Maximal number of sensor the host is expecting.
+			 * 0 means the host is only interested in the number
+			 * of sensors controlled by the EC.
+			 */
+			uint8_t max_sensor_count;
 		} dump;
 
 		/*
-		 * Used for MOTIONSENSE_CMD_EC_RATE and
-		 * MOTIONSENSE_CMD_KB_WAKE_ANGLE.
+		 * Used for MOTIONSENSE_CMD_KB_WAKE_ANGLE.
 		 */
 		struct __ec_todo_unpacked {
-			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read. */
+			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read.
+			 * kb_wake_angle: angle to wakup AP.
+			 */
 			int16_t data;
-		} ec_rate, kb_wake_angle;
+		} kb_wake_angle;
+
+		/*
+		 * Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
+		 * and MOTIONSENSE_CMD_PERFORM_CALIB.
+		 */
+		struct __ec_todo_unpacked {
+			uint8_t sensor_num;
+		} info, info_3, data, fifo_flush, perform_calib,
+				list_activities;
+
+		/*
+		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR
+		 * and MOTIONSENSE_CMD_SENSOR_RANGE.
+		 */
+		struct __ec_todo_unpacked {
+			uint8_t sensor_num;
+
+			/* Rounding flag, true for round-up, false for down. */
+			uint8_t roundup;
+
+			uint16_t reserved;
+
+			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read. */
+			int32_t data;
+		} ec_rate, sensor_odr, sensor_range;
 
 		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
 		struct __ec_todo_packed {
@@ -2358,33 +2537,99 @@ struct ec_params_motion_sense {
 			int16_t offset[3];
 		} sensor_offset;
 
-		/* Used for MOTIONSENSE_CMD_INFO. */
+		/* Used for MOTIONSENSE_CMD_SENSOR_SCALE */
 		struct __ec_todo_packed {
 			uint8_t sensor_num;
-		} info;
 
-		/*
-		 * Used for MOTIONSENSE_CMD_SENSOR_ODR and
-		 * MOTIONSENSE_CMD_SENSOR_RANGE.
-		 */
-		struct {
-			/* Should be element of enum motionsensor_id. */
-			uint8_t sensor_num;
+			/*
+			 * bit 0: If set (MOTION_SENSE_SET_OFFSET), set
+			 * the calibration information in the EC.
+			 * If unset, just retrieve calibration information.
+			 */
+			uint16_t flags;
 
-			/* Rounding flag, true for round-up, false for down. */
-			uint8_t roundup;
+			/*
+			 * Temperature at calibration, in units of 0.01 C
+			 * 0x8000: invalid / unknown.
+			 * 0x0: 0C
+			 * 0x7fff: +327.67C
+			 */
+			int16_t temp;
 
-			uint16_t reserved;
+			/*
+			 * Scale for calibration:
+			 * By default scale is 1, it is encoded on 16bits:
+			 * 1 = BIT(15)
+			 * ~2 = 0xFFFF
+			 * ~0 = 0.
+			 */
+			uint16_t scale[3];
+		} sensor_scale;
 
-			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read. */
-			int32_t data;
-		} sensor_odr, sensor_range;
+
+		/* Used for MOTIONSENSE_CMD_FIFO_INFO */
+		/* (no params) */
+
+		/* Used for MOTIONSENSE_CMD_FIFO_READ */
+		struct __ec_todo_unpacked {
+			/*
+			 * Number of expected vector to return.
+			 * EC may return less or 0 if none available.
+			 */
+			uint32_t max_data_vector;
+		} fifo_read;
+
+		struct ec_motion_sense_activity set_activity;
+
+		/* Used for MOTIONSENSE_CMD_LID_ANGLE */
+		/* (no params) */
+
+		/* Used for MOTIONSENSE_CMD_FIFO_INT_ENABLE */
+		struct __ec_todo_unpacked {
+			/*
+			 * 1: enable, 0 disable fifo,
+			 * EC_MOTION_SENSE_NO_VALUE return value.
+			 */
+			int8_t enable;
+		} fifo_int_enable;
+
+		/* Used for MOTIONSENSE_CMD_SPOOF */
+		struct __ec_todo_packed {
+			uint8_t sensor_id;
+
+			/* See enum motionsense_spoof_mode. */
+			uint8_t spoof_enable;
+
+			/* Ignored, used for alignment. */
+			uint8_t reserved;
+
+			/* Individual component values to spoof. */
+			int16_t components[3];
+		} spoof;
+
+		/* Used for MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE. */
+		struct __ec_todo_unpacked {
+			/*
+			 * Lid angle threshold for switching between tablet and
+			 * clamshell mode.
+			 */
+			int16_t lid_angle;
+
+			/*
+			 * Hysteresis degree to prevent fluctuations between
+			 * clamshell and tablet mode if lid angle keeps
+			 * changing around the threshold. Lid motion driver will
+			 * use lid_angle + hys_degree to trigger tablet mode and
+			 * lid_angle - hys_degree to trigger clamshell mode.
+			 */
+			int16_t hys_degree;
+		} tablet_mode_threshold;
 	};
 } __ec_todo_packed;
 
 struct ec_response_motion_sense {
 	union {
-		/* Used for MOTIONSENSE_CMD_DUMP. */
+		/* Used for MOTIONSENSE_CMD_DUMP */
 		struct __ec_todo_unpacked {
 			/* Flags representing the motion sensor module. */
 			uint8_t module_flags;
@@ -2411,27 +2656,118 @@ struct ec_response_motion_sense {
 			uint8_t chip;
 		} info;
 
+		/* Used for MOTIONSENSE_CMD_INFO version 3 */
+		struct __ec_todo_unpacked {
+			/* Should be element of enum motionsensor_type. */
+			uint8_t type;
+
+			/* Should be element of enum motionsensor_location. */
+			uint8_t location;
+
+			/* Should be element of enum motionsensor_chip. */
+			uint8_t chip;
+
+			/* Minimum sensor sampling frequency */
+			uint32_t min_frequency;
+
+			/* Maximum sensor sampling frequency */
+			uint32_t max_frequency;
+
+			/* Max number of sensor events that could be in fifo */
+			uint32_t fifo_max_event_count;
+		} info_3;
+
 		/* Used for MOTIONSENSE_CMD_DATA */
 		struct ec_response_motion_sensor_data data;
 
 		/*
 		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR,
-		 * MOTIONSENSE_CMD_SENSOR_RANGE, and
-		 * MOTIONSENSE_CMD_KB_WAKE_ANGLE.
+		 * MOTIONSENSE_CMD_SENSOR_RANGE,
+		 * MOTIONSENSE_CMD_KB_WAKE_ANGLE,
+		 * MOTIONSENSE_CMD_FIFO_INT_ENABLE and
+		 * MOTIONSENSE_CMD_SPOOF.
 		 */
 		struct __ec_todo_unpacked {
 			/* Current value of the parameter queried. */
 			int32_t ret;
-		} ec_rate, sensor_odr, sensor_range, kb_wake_angle;
+		} ec_rate, sensor_odr, sensor_range, kb_wake_angle,
+		  fifo_int_enable, spoof;
 
-		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
+		/*
+		 * Used for MOTIONSENSE_CMD_SENSOR_OFFSET,
+		 * PERFORM_CALIB.
+		 */
 		struct __ec_todo_unpacked  {
 			int16_t temp;
 			int16_t offset[3];
 		} sensor_offset, perform_calib;
+
+		/* Used for MOTIONSENSE_CMD_SENSOR_SCALE */
+		struct __ec_todo_unpacked  {
+			int16_t temp;
+			uint16_t scale[3];
+		} sensor_scale;
+
+		struct ec_response_motion_sense_fifo_info fifo_info, fifo_flush;
+
+		struct ec_response_motion_sense_fifo_data fifo_read;
+
+		struct __ec_todo_packed {
+			uint16_t reserved;
+			uint32_t enabled;
+			uint32_t disabled;
+		} list_activities;
+
+		/* No params for set activity */
+
+		/* Used for MOTIONSENSE_CMD_LID_ANGLE */
+		struct __ec_todo_unpacked {
+			/*
+			 * Angle between 0 and 360 degree if available,
+			 * LID_ANGLE_UNRELIABLE otherwise.
+			 */
+			uint16_t value;
+		} lid_angle;
+
+		/* Used for MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE. */
+		struct __ec_todo_unpacked {
+			/*
+			 * Lid angle threshold for switching between tablet and
+			 * clamshell mode.
+			 */
+			uint16_t lid_angle;
+
+			/* Hysteresis degree. */
+			uint16_t hys_degree;
+		} tablet_mode_threshold;
+
 	};
 } __ec_todo_packed;
 
+/*****************************************************************************/
+/* Force lid open command */
+
+/* Make lid event always open */
+#define EC_CMD_FORCE_LID_OPEN 0x002C
+
+struct ec_params_force_lid_open {
+	uint8_t enabled;
+} __ec_align1;
+
+/*****************************************************************************/
+/* Configure the behavior of the power button */
+#define EC_CMD_CONFIG_POWER_BUTTON 0x002D
+
+enum ec_config_power_button_flags {
+	/* Enable/Disable power button pulses for x86 devices */
+	EC_POWER_BUTTON_ENABLE_PULSE = BIT(0),
+};
+
+struct ec_params_config_power_button {
+	/* See enum ec_config_power_button_flags */
+	uint8_t flags;
+} __ec_align1;
+
 /*****************************************************************************/
 /* USB charging control commands */
 
@@ -2888,6 +3224,12 @@ union __ec_align_offset1 ec_response_get_next_data {
 	/* Unaligned */
 	uint32_t  host_event;
 
+	struct __ec_todo_unpacked {
+		/* For aligning the fifo_info */
+		uint8_t reserved[3];
+		struct ec_response_motion_sense_fifo_info info;
+	} sensor_fifo;
+
 	uint32_t   buttons;
 	uint32_t   switches;
 	uint32_t   sysrq;
@@ -2896,6 +3238,12 @@ union __ec_align_offset1 ec_response_get_next_data {
 union __ec_align_offset1 ec_response_get_next_data_v1 {
 	uint8_t key_matrix[16];
 	uint32_t host_event;
+	struct __ec_todo_unpacked {
+		/* For aligning the fifo_info */
+		uint8_t reserved[3];
+		struct ec_response_motion_sense_fifo_info info;
+	} sensor_fifo;
+
 	uint32_t buttons;
 	uint32_t switches;
 	uint32_t sysrq;
-- 
2.21.0.1020.gf2820cf01a-goog

