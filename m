Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757DD13521
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfECWDJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:03:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35902 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfECWDJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:03:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id w20so3323652plq.3
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2019 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzlB6FmzRj3nZuBUkAxaNllK7w7zuAjCYEiFuMWM32A=;
        b=MI1dF1cafShlYSiiILnManvw+XVHtFj9CdiD4dHMkxtcTCjrwABytVRyOlwG04HsDX
         KWLkf4CrVskchQaapzB2g2VBAEHSZ3yDa+ipWGTBHHnr4GiM+YbWr7KYPHMPfa59c2us
         6XnENELF4pZSr4ZweyVwKvqAcSS6Zl58zpW18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzlB6FmzRj3nZuBUkAxaNllK7w7zuAjCYEiFuMWM32A=;
        b=IM4HyCx4HlUIKQaJYMMx1vdEP25Nl2884LpNMeMWu4waganDrWJaOigKdKFhw8pSld
         oAB7wpRoXXdWqwOCEIFMpnFuZ2drrUS80j9bmuWmNPDFwRvKCCr2nwmERZCydExs0KdL
         u/HsQXrJLeoQFx+NMnrxnezkkWLwN5PIkidTUJWfB1WSBPKnDOHSabCFdLJA656KZP7P
         8HRRz0XDgSPtFa0Jy4qmyrNzTSjcgCaSUuCuxdUbBnrxVcNrWViCTwQ+vDeNlavob9nm
         lzYRWKjGNzxchK9h8hRRcbkNGkgHnnbWLQtcl3lgeRK702yRFyr+BVAUvFSUrQJ5zs+H
         yxNg==
X-Gm-Message-State: APjAAAU7reimGNgLY2ADvkNS4jcSTo1cK3eJJsmbsUR/65EQ/rvjrwZW
        J6oBoFpXbbrEQJsxvDmLBRRv0A==
X-Google-Smtp-Source: APXvYqxYPtLmrXJywnSkWNQEU1MWMWtQTGHsdHNrSQ9jGjbbngEfACkbFxhTFm4lc4ibd4uHN2zFDA==
X-Received: by 2002:a17:902:aa5:: with SMTP id 34mr13881726plp.263.1556920988124;
        Fri, 03 May 2019 15:03:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h127sm3940175pgc.31.2019.05.03.15.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:03:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 15/30] mfd: cros_ec: Complete MEMS sensor API
Date:   Fri,  3 May 2019 15:02:18 -0700
Message-Id: <20190503220233.64546-16-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new command for batched mode, add support for more sensors.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 464 +++++++++++++++++++++++----
 1 file changed, 406 insertions(+), 58 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 48e753df7e2d..594db631452f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2161,7 +2161,13 @@ enum motionsense_command {
 
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
 
@@ -2192,32 +2198,76 @@ enum motionsense_command {
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
@@ -2229,6 +2279,7 @@ enum motionsensor_type {
 	MOTIONSENSE_TYPE_LIGHT = 4,
 	MOTIONSENSE_TYPE_ACTIVITY = 5,
 	MOTIONSENSE_TYPE_BARO = 6,
+	MOTIONSENSE_TYPE_SYNC = 7,
 	MOTIONSENSE_TYPE_MAX,
 };
 
@@ -2236,36 +2287,48 @@ enum motionsensor_type {
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
@@ -2282,22 +2345,138 @@ struct ec_response_motion_sensor_data {
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
@@ -2328,33 +2507,99 @@ struct ec_params_motion_sense {
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
@@ -2381,27 +2626,118 @@ struct ec_response_motion_sense {
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
 
@@ -2858,6 +3194,12 @@ union __ec_align_offset1 ec_response_get_next_data {
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
@@ -2866,6 +3208,12 @@ union __ec_align_offset1 ec_response_get_next_data {
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

