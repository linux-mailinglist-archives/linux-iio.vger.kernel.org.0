Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1841331C33
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCIBSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCIBRf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:17:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DC1C06174A;
        Mon,  8 Mar 2021 17:17:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w9so17493558edt.13;
        Mon, 08 Mar 2021 17:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bcOe8hF5rfwVVpWsN1gRakyUvaEIKe2M+Aedia8Gndg=;
        b=fVPT/L5/UeobqzSgQKZm9kjhc7HN8gg2vfE6TAqXjA6ZgKCQXnr10IpC1LTCj3WJYv
         WXDV0bOnXAVZ1/EvcFTh261A7qXSmPHefeJgRGH4bnycKwyyrqUTNglXL0/devDUB4fg
         cMDPRRs/6BJAxqZe+CZCtkFQVsEjYEOhX9ac27VPU6fcmVqo34buMv58iVH+TWi83VTF
         aOFbJJpjPSrleFQXyfVoJxtG4EINUOoYJWu4BYm0kT9CmAVxy/hOmtRuSn9BvBMKXfLf
         5jwXrRjYdR5aD+3sJha96Ve9ccI+9sRmLlkAgTynv6gje9WUDk281MvwCIZjKffKxoR6
         PfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bcOe8hF5rfwVVpWsN1gRakyUvaEIKe2M+Aedia8Gndg=;
        b=p4ZZe/Y5suUgyFfQ35yAGZWk2B1jkpTd3t9GxFlPZ37nRG2t0c0oatYK8vLIYJK3nW
         b2glN1FRfUEVwuG0RFdvyMgZBLTIRniqTDCqIv0NJ5958j/00VTWECF0afEdGPTibUNo
         7s1qWiaWHdmMy+re9t2nZFoTks2T46Jh3IN3wBMkY5eRWsXol2/Z4XP9DvnHL2oUMGV9
         WJ51tK0mQs7FjNWOboynUNKvMYh5X7/J7u6usmKXOOM3BdPIh8ZczgJ3cz/6EvWrUsJO
         a/vw2jD1RMfZqlhKzLyzl17x44ziGLzMQEmu8qQSSIvxEwpA1rJR7t2rDs3ucmz6i3iU
         aI9w==
X-Gm-Message-State: AOAM5300WyE2sAnCqPneWo+IpfH+gjffz2gULbKXS9ZsO3ZQCE1aJW7P
        TAxxLyZBIaECq0I6OOYoL7U=
X-Google-Smtp-Source: ABdhPJzJLGqhe2FyMrIDBk637oVau3A+oTcHEK8u3M4YQnE8E85a48Wt8kA2FU0CSgoZ+D5BA3zVDQ==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr1294633edd.134.1615252642201;
        Mon, 08 Mar 2021 17:17:22 -0800 (PST)
Received: from pop-os.localdomain (cpc97922-walt21-2-0-cust248.13-2.cable.virginm.net. [82.16.251.249])
        by smtp.gmail.com with ESMTPSA id qo25sm60552ejb.93.2021.03.08.17.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 17:17:21 -0800 (PST)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     jic23@kernel.org
Cc:     Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v5] Added AMS tsl2591 driver implementation
Date:   Tue,  9 Mar 2021 01:17:15 +0000
Message-Id: <20210309011715.23245-1-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Driver implementation for AMS/TAOS tsl2591 ambient light sensor.

This driver supports configuration via device tree and sysfs.
Supported channels for raw infrared light intensity,
raw combined light intensity and illuminance in lux.
The driver additionally supports iio events on lower and
upper thresholds.

This is a very-high sensitivity light-to-digital converter that
transforms light intensity into a digital signal.

Datasheet: https://ams.com/tsl25911#tab/documents

Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
---

Changes in v5:
- Added counterpart macro for integration time in ms to field value
- Tidied up some of the GENMASK usage
- Removed defines for ALS persist cycle literals, placed inline instead
- Removed unnecessary array size check & break in tsl2591_als_time_to_fval()
- Removed unnecessary casting and replaced with get_unaligned_le16() in
  tsl2591_read_channel_data()
- Cleaned up some return code checks on i2c calls
- Explicit return codes rather than relying on default value at before
  entering switch statements.
- Combine exit paths on error labels - following proper kernel idiom
- Cleaned up managed exit path for pm runtime
- Using reverse xmas tree convention for local vars in functions
- Corrected datasheet tag

Acknowledgements:
- Thanks to Jonathan and Andy for the constructive feedback!

NOTE:
Rob has reviewed the binding document and no changes required it
seems. Not sure what the best practice/convention is here; is [PATCH v5]
sufficient or do I still need to include the series number despite
there being no updates to the binding? please advise. Thank you!

 drivers/iio/light/Kconfig   |   11 +
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/tsl2591.c | 1193 +++++++++++++++++++++++++++++++++++
 3 files changed, 1205 insertions(+)
 create mode 100644 drivers/iio/light/tsl2591.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 33ad4dd0b5c7..6a69a9a3577a 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -501,6 +501,17 @@ config TSL2583
 	  Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
 	  Access ALS data via iio, sysfs.
 
+config TSL2591
+        tristate "TAOS TSL2591 ambient light sensor"
+        depends on I2C
+        help
+          Select Y here for support of the AMS/TAOS TSL2591 ambient light sensor,
+          featuring channels for combined visible + IR intensity and lux illuminance.
+          Access data via iio and sysfs. Supports iio_events.
+
+          To compile this driver as a module, select M: the
+          module will be called tsl2591.
+
 config TSL2772
 	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index ea376deaca54..d10912faf964 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
 obj-$(CONFIG_TCS3414)		+= tcs3414.o
 obj-$(CONFIG_TCS3472)		+= tcs3472.o
 obj-$(CONFIG_TSL2583)		+= tsl2583.o
+obj-$(CONFIG_TSL2591)		+= tsl2591.o
 obj-$(CONFIG_TSL2772)		+= tsl2772.o
 obj-$(CONFIG_TSL4531)		+= tsl4531.o
 obj-$(CONFIG_US5182D)		+= us5182d.o
diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
new file mode 100644
index 000000000000..ddecb32e206d
--- /dev/null
+++ b/drivers/iio/light/tsl2591.c
@@ -0,0 +1,1193 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Joe Sandom <joe.g.sandom@gmail.com>
+ *
+ * Datasheet: https://ams.com/tsl25911#tab/documents
+ *
+ * Device driver for the TAOS TSL2591. This is a very-high sensitivity
+ * light-to-digital converter that transforms light intensity into a digital
+ * signal.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* ADC integration time, field value to time in ms*/
+#define TSL2591_FVAL_TO_ATIME(x) (((x) + 1) * 100)
+/* ADC integration time, time in ms to field value */
+#define TSL2591_ATIME_TO_FVAL(x) (((x) / 100) - 1)
+
+/* TSL2591 register set */
+#define TSL2591_ENABLE      0x00
+#define TSL2591_CONTROL     0x01
+#define TSL2591_AILTL       0x04
+#define TSL2591_AILTH       0x05
+#define TSL2591_AIHTL       0x06
+#define TSL2591_AIHTH       0x07
+#define TSL2591_NP_AILTL    0x08
+#define TSL2591_NP_AILTH    0x09
+#define TSL2591_NP_AIHTL    0x0A
+#define TSL2591_NP_AIHTH    0x0B
+#define TSL2591_PERSIST     0x0C
+#define TSL2591_PACKAGE_ID  0x11
+#define TSL2591_DEVICE_ID   0x12
+#define TSL2591_STATUS      0x13
+#define TSL2591_C0_DATAL    0x14
+#define TSL2591_C0_DATAH    0x15
+#define TSL2591_C1_DATAL    0x16
+#define TSL2591_C1_DATAH    0x17
+
+/* TSL2591 command register definitions */
+#define TSL2591_CMD_NOP             (BIT(5) | BIT(7))
+#define TSL2591_CMD_SF              GENMASK(7, 5)
+#define TSL2591_CMD_SF_INTSET       (BIT(2) | TSL2591_CMD_SF)
+#define TSL2591_CMD_SF_CALS_I       (BIT(0) | BIT(2) | TSL2591_CMD_SF)
+#define TSL2591_CMD_SF_CALS_NPI     (GENMASK(2, 0) | TSL2591_CMD_SF)
+#define TSL2591_CMD_SF_CNP_ALSI     (BIT(1) | BIT(3) | TSL2591_CMD_SF)
+
+/* TSL2591 enable register definitions */
+#define TSL2591_PWR_ON              BIT(0)
+#define TSL2591_PWR_OFF             (0 << 0)
+#define TSL2591_ENABLE_ALS          BIT(1)
+#define TSL2591_ENABLE_ALS_INT      BIT(4)
+#define TSL2591_ENABLE_SLEEP_INT    BIT(6)
+#define TSL2591_ENABLE_NP_INT       BIT(7)
+
+/* TSL2591 control register definitions */
+#define TSL2591_CTRL_ALS_INTEGRATION_100MS  (0 << 0)
+#define TSL2591_CTRL_ALS_INTEGRATION_200MS  BIT(0)
+#define TSL2591_CTRL_ALS_INTEGRATION_300MS  BIT(1)
+#define TSL2591_CTRL_ALS_INTEGRATION_400MS  GENMASK(1, 0)
+#define TSL2591_CTRL_ALS_INTEGRATION_500MS  BIT(2)
+#define TSL2591_CTRL_ALS_INTEGRATION_600MS  (BIT(0) | BIT(2))
+#define TSL2591_CTRL_ALS_LOW_GAIN           (0 << 0)
+#define TSL2591_CTRL_ALS_MED_GAIN           BIT(4)
+#define TSL2591_CTRL_ALS_HIGH_GAIN          BIT(5)
+#define TSL2591_CTRL_ALS_MAX_GAIN           GENMASK(5, 4)
+#define TSL2591_CTRL_SYS_RESET              BIT(7)
+
+/* TSL2591 persist register definitions */
+#define TSL2591_PRST_ALS_INT_CYCLE_0        (0 << 0)
+#define TSL2591_PRST_ALS_INT_CYCLE_ANY      BIT(0)
+#define TSL2591_PRST_ALS_INT_CYCLE_2        BIT(1)
+#define TSL2591_PRST_ALS_INT_CYCLE_3        GENMASK(1, 0)
+#define TSL2591_PRST_ALS_INT_CYCLE_5        BIT(2)
+#define TSL2591_PRST_ALS_INT_CYCLE_10       (BIT(0) | BIT(2))
+#define TSL2591_PRST_ALS_INT_CYCLE_15       GENMASK(2, 1)
+#define TSL2591_PRST_ALS_INT_CYCLE_20       GENMASK(2, 0)
+#define TSL2591_PRST_ALS_INT_CYCLE_25       BIT(3)
+#define TSL2591_PRST_ALS_INT_CYCLE_30       (BIT(0) | BIT(3))
+#define TSL2591_PRST_ALS_INT_CYCLE_35       (BIT(1) | BIT(3))
+#define TSL2591_PRST_ALS_INT_CYCLE_40       (GENMASK(1, 0) | BIT(3))
+#define TSL2591_PRST_ALS_INT_CYCLE_45       GENMASK(3, 2)
+#define TSL2591_PRST_ALS_INT_CYCLE_50       (BIT(0) | GENMASK(3, 2))
+#define TSL2591_PRST_ALS_INT_CYCLE_55       GENMASK(3, 1)
+#define TSL2591_PRST_ALS_INT_CYCLE_60       GENMASK(3, 0)
+#define TSL2591_PRST_ALS_INT_CYCLE_MAX      TSL2591_PRST_ALS_INT_CYCLE_60
+
+/* TSL2591 PID register mask */
+#define TSL2591_PACKAGE_ID_MASK    GENMASK(5, 4)
+
+/* TSL2591 ID register mask */
+#define TSL2591_DEVICE_ID_MASK     GENMASK(7, 0)
+
+/* TSL2591 status register masks */
+#define TSL2591_STS_ALS_VALID_MASK   BIT(0)
+#define TSL2591_STS_ALS_INT_MASK     BIT(4)
+#define TSL2591_STS_NPERS_INT_MASK   BIT(5)
+#define TSL2591_STS_VAL_HIGH_MASK    BIT(0)
+
+/* TSL2591 constant values */
+#define TSL2591_PACKAGE_ID_VAL  0x00
+#define TSL2591_DEVICE_ID_VAL   0x50
+
+/* Power off suspend delay time MS */
+#define TSL2591_POWER_OFF_DELAY_MS   2000
+
+/* TSL2591 default values */
+#define TSL2591_DEFAULT_ALS_INT_TIME          TSL2591_CTRL_ALS_INTEGRATION_300MS
+#define TSL2591_DEFAULT_ALS_GAIN              TSL2591_CTRL_ALS_MED_GAIN
+#define TSL2591_DEFAULT_ALS_PERSIST           TSL2591_PRST_ALS_INT_CYCLE_ANY
+#define TSL2591_DEFAULT_ALS_LOWER_THRESH      100
+#define TSL2591_DEFAULT_ALS_UPPER_THRESH      1500
+
+/* TSL2591 number of data registers */
+#define TSL2591_NUM_DATA_REGISTERS     4
+
+/* TSL2591 number of valid status reads on ADC complete */
+#define TSL2591_ALS_STS_VALID_COUNT    10
+
+/* TSL2591 maximum values */
+#define TSL2591_MAX_ALS_INT_TIME_MS    600
+#define TSL2591_ALS_MAX_VALUE	       (BIT(16) - 1)
+
+/*
+ * LUX calculations;
+ * AGAIN values from Adafruits TSL2591 Arduino library
+ * https://github.com/adafruit/Adafruit_TSL2591_Library
+ */
+#define TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER   1
+#define TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER   25
+#define TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER  428
+#define TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER   9876
+#define TSL2591_LUX_COEFFICIENT                408
+
+struct tsl2591_als_settings {
+	u16 als_lower_thresh;
+	u16 als_upper_thresh;
+	u8 als_int_time;
+	u8 als_persist;
+	u8 als_gain;
+};
+
+struct tsl2591_chip {
+	struct tsl2591_als_settings als_settings;
+	struct i2c_client *client;
+	/*
+	 * Keep als_settings in sync with hardware state
+	 * and ensure multiple readers are serialized.
+	 */
+	struct mutex als_mutex;
+	bool events_enabled;
+};
+
+/*
+ * Period table is ALS persist cycle x integration time setting
+ * Integration times: 100ms, 200ms, 300ms, 400ms, 500ms, 600ms
+ * ALS cycles: 1, 2, 3, 5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60
+ */
+static const char * const tsl2591_als_period_list[] = {
+	"0.1 0.2 0.3 0.5 1.0 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0",
+	"0.2 0.4 0.6 1.0 2.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0",
+	"0.3 0.6 0.9 1.5 3.0 6.0 7.5 9.0 10.5 12.0 13.5 15.0 16.5 18.0",
+	"0.4 0.8 1.2 2.0 4.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0 22.0 24.0",
+	"0.5 1.0 1.5 2.5 5.0 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0",
+	"0.6 1.2 1.8 3.0 6.0 12.0 15.0 18.0 21.0 24.0 27.0 30.0 33.0 36.0",
+};
+
+static const int tsl2591_int_time_available[] = {
+	100, 200, 300, 400, 500, 600,
+};
+
+static const int tsl2591_calibscale_available[] = {
+	1, 25, 428, 9876,
+};
+
+static int tsl2591_gain_to_multiplier(const u8 als_gain)
+{
+	switch (als_gain) {
+	case TSL2591_CTRL_ALS_LOW_GAIN:
+		return TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER;
+	case TSL2591_CTRL_ALS_MED_GAIN:
+		return TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER;
+	case TSL2591_CTRL_ALS_HIGH_GAIN:
+		return TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER;
+	case TSL2591_CTRL_ALS_MAX_GAIN:
+		return TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER;
+	default:
+		return -EINVAL;
+	}
+}
+
+static u8 tsl2591_multiplier_to_gain(const u32 multiplier)
+{
+	switch (multiplier) {
+	case TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER:
+		return TSL2591_CTRL_ALS_LOW_GAIN;
+	case TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER:
+		return TSL2591_CTRL_ALS_MED_GAIN;
+	case TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER:
+		return TSL2591_CTRL_ALS_HIGH_GAIN;
+	case TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER:
+		return TSL2591_CTRL_ALS_MAX_GAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
+{
+	switch (als_persist) {
+	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
+		return 1;
+	case TSL2591_PRST_ALS_INT_CYCLE_2:
+		return 2;
+	case TSL2591_PRST_ALS_INT_CYCLE_3:
+		return 3;
+	case TSL2591_PRST_ALS_INT_CYCLE_5:
+		return 5;
+	case TSL2591_PRST_ALS_INT_CYCLE_10:
+		return 10;
+	case TSL2591_PRST_ALS_INT_CYCLE_15:
+		return 15;
+	case TSL2591_PRST_ALS_INT_CYCLE_20:
+		return 20;
+	case TSL2591_PRST_ALS_INT_CYCLE_25:
+		return 25;
+	case TSL2591_PRST_ALS_INT_CYCLE_30:
+		return 30;
+	case TSL2591_PRST_ALS_INT_CYCLE_35:
+		return 35;
+	case TSL2591_PRST_ALS_INT_CYCLE_40:
+		return 40;
+	case TSL2591_PRST_ALS_INT_CYCLE_45:
+		return 45;
+	case TSL2591_PRST_ALS_INT_CYCLE_50:
+		return 50;
+	case TSL2591_PRST_ALS_INT_CYCLE_55:
+		return 55;
+	case TSL2591_PRST_ALS_INT_CYCLE_60:
+		return 60;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
+{
+	switch (als_persist) {
+	case 1:
+		return TSL2591_PRST_ALS_INT_CYCLE_ANY;
+	case 2:
+		return TSL2591_PRST_ALS_INT_CYCLE_2;
+	case 3:
+		return TSL2591_PRST_ALS_INT_CYCLE_3;
+	case 5:
+		return TSL2591_PRST_ALS_INT_CYCLE_5;
+	case 10:
+		return TSL2591_PRST_ALS_INT_CYCLE_10;
+	case 15:
+		return TSL2591_PRST_ALS_INT_CYCLE_15;
+	case 20:
+		return TSL2591_PRST_ALS_INT_CYCLE_20;
+	case 25:
+		return TSL2591_PRST_ALS_INT_CYCLE_25;
+	case 30:
+		return TSL2591_PRST_ALS_INT_CYCLE_30;
+	case 35:
+		return TSL2591_PRST_ALS_INT_CYCLE_35;
+	case 40:
+		return TSL2591_PRST_ALS_INT_CYCLE_40;
+	case 45:
+		return TSL2591_PRST_ALS_INT_CYCLE_45;
+	case 50:
+		return TSL2591_PRST_ALS_INT_CYCLE_50;
+	case 55:
+		return TSL2591_PRST_ALS_INT_CYCLE_55;
+	case 60:
+		return TSL2591_PRST_ALS_INT_CYCLE_60;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,
+				       const u32 als_integration_time)
+{
+	switch (als_integration_time) {
+	case TSL2591_CTRL_ALS_INTEGRATION_100MS:
+	case TSL2591_CTRL_ALS_INTEGRATION_200MS:
+	case TSL2591_CTRL_ALS_INTEGRATION_300MS:
+	case TSL2591_CTRL_ALS_INTEGRATION_400MS:
+	case TSL2591_CTRL_ALS_INTEGRATION_500MS:
+	case TSL2591_CTRL_ALS_INTEGRATION_600MS:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl2591_als_time_to_fval(const u32 als_integration_time)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tsl2591_int_time_available); ++i) {
+		if (als_integration_time == tsl2591_int_time_available[i])
+			return TSL2591_ATIME_TO_FVAL(als_integration_time);
+	}
+
+	return -EINVAL;
+}
+
+static int tsl2591_compatible_gain(struct tsl2591_chip *chip, const u8 als_gain)
+{
+	switch (als_gain) {
+	case TSL2591_CTRL_ALS_LOW_GAIN:
+	case TSL2591_CTRL_ALS_MED_GAIN:
+	case TSL2591_CTRL_ALS_HIGH_GAIN:
+	case TSL2591_CTRL_ALS_MAX_GAIN:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl2591_compatible_als_persist_cycle(struct tsl2591_chip *chip,
+						const u32 als_persist)
+{
+	switch (als_persist) {
+	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
+	case TSL2591_PRST_ALS_INT_CYCLE_2:
+	case TSL2591_PRST_ALS_INT_CYCLE_3:
+	case TSL2591_PRST_ALS_INT_CYCLE_5:
+	case TSL2591_PRST_ALS_INT_CYCLE_10:
+	case TSL2591_PRST_ALS_INT_CYCLE_15:
+	case TSL2591_PRST_ALS_INT_CYCLE_20:
+	case TSL2591_PRST_ALS_INT_CYCLE_25:
+	case TSL2591_PRST_ALS_INT_CYCLE_30:
+	case TSL2591_PRST_ALS_INT_CYCLE_35:
+	case TSL2591_PRST_ALS_INT_CYCLE_40:
+	case TSL2591_PRST_ALS_INT_CYCLE_45:
+	case TSL2591_PRST_ALS_INT_CYCLE_50:
+	case TSL2591_PRST_ALS_INT_CYCLE_55:
+	case TSL2591_PRST_ALS_INT_CYCLE_60:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
+{
+	struct tsl2591_als_settings settings = chip->als_settings;
+	struct i2c_client *client = chip->client;
+	int delay;
+	int ret;
+	int i;
+
+	delay = TSL2591_FVAL_TO_ATIME(settings.als_int_time);
+	if (!delay)
+		return -EINVAL;
+
+	/*
+	 * Sleep for ALS integration time to allow enough time
+	 * for an ADC read cycle to complete. Check status after
+	 * delay for ALS valid.
+	 */
+	msleep(delay);
+
+	/* Check for status ALS valid flag for up to 100ms */
+	for (i = 0; i < TSL2591_ALS_STS_VALID_COUNT; ++i) {
+		ret = i2c_smbus_read_byte_data(client,
+					       TSL2591_CMD_NOP | TSL2591_STATUS);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to read register\n");
+			return -EINVAL;
+		}
+		ret = FIELD_GET(TSL2591_STS_ALS_VALID_MASK, ret);
+		if (ret == TSL2591_STS_VAL_HIGH_MASK)
+			break;
+
+		if (i == TSL2591_ALS_STS_VALID_COUNT - 1)
+			return -ENODATA;
+
+		usleep_range(9000, 10000);
+	}
+
+	return 0;
+}
+
+/*
+ * tsl2591_read_channel_data - Reads raw channel data and calculates lux
+ *
+ * Formula for lux calculation;
+ * Derived from Adafruit's TSL2591 library
+ * Link: https://github.com/adafruit/Adafruit_TSL2591_Library
+ * Counts Per Lux (CPL) = (ATIME_ms * AGAIN) / LUX DF
+ * lux = ((C0DATA - C1DATA) * (1 - (C1DATA / C0DATA))) / CPL
+ *
+ * Scale values to get more representative value of lux i.e.
+ * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
+ *
+ * Channel 0 = IR + Visible
+ * Channel 1 = IR only
+ */
+static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     int *val, int *val2)
+{
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	struct tsl2591_als_settings *settings = &chip->als_settings;
+	struct i2c_client *client = chip->client;
+
+	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
+	int counts_per_lux, int_time_fval, gain_multi, lux;
+	u16 als_ch0, als_ch1;
+	int ret;
+
+	ret = tsl2591_wait_adc_complete(chip);
+	if (ret < 0) {
+		dev_err(&client->dev, "No data available. Err: %d\n", ret);
+		return ret;
+	}
+
+	ret = i2c_smbus_read_i2c_block_data(client,
+					    TSL2591_CMD_NOP | TSL2591_C0_DATAL,
+					    sizeof(als_data), als_data);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read data bytes");
+			return ret;
+	}
+
+	als_ch0 = get_unaligned_le16(&als_data[0]);
+	als_ch1 = get_unaligned_le16(&als_data[2]);
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		if (chan->channel2 == IIO_MOD_LIGHT_BOTH)
+			*val = als_ch0;
+		else if (chan->channel2 == IIO_MOD_LIGHT_IR)
+			*val = als_ch1;
+		else
+			return -EINVAL;
+		break;
+	case IIO_LIGHT:
+		gain_multi = tsl2591_gain_to_multiplier(settings->als_gain);
+		if (gain_multi < 0) {
+			dev_err(&client->dev, "Invalid multiplier");
+			return gain_multi;
+		}
+
+		int_time_fval = TSL2591_FVAL_TO_ATIME(settings->als_int_time);
+		/* Calculate counts per lux value */
+		counts_per_lux = (int_time_fval * gain_multi) / TSL2591_LUX_COEFFICIENT;
+
+		dev_dbg(&client->dev, "Counts Per Lux: %d\n", counts_per_lux);
+
+		/* Calculate lux value */
+		lux = ((als_ch0 - als_ch1) *
+		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;
+
+		dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
+
+		/* Divide by 1000 to get real lux value before scaling */
+		*val = lux / 1000;
+
+		/* Get the decimal part of lux reading */
+		*val2 = ((lux - (*val * 1000)) * 1000);
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tsl2591_set_als_gain_int_time(struct tsl2591_chip *chip)
+{
+	struct tsl2591_als_settings als_settings = chip->als_settings;
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					TSL2591_CMD_NOP | TSL2591_CONTROL,
+					als_settings.als_int_time | als_settings.als_gain);
+	if (ret)
+		dev_err(&client->dev, "Failed to set als gain & int time\n");
+
+	return ret;
+}
+
+static int tsl2591_set_als_thresholds(struct tsl2591_chip *chip)
+{
+	struct tsl2591_als_settings als_settings = chip->als_settings;
+	struct i2c_client *client = chip->client;
+
+	u8 als_lower_l, als_lower_h, als_upper_l, als_upper_h;
+	int ret;
+
+	if (als_settings.als_lower_thresh >= als_settings.als_upper_thresh)
+		return -EINVAL;
+
+	if (als_settings.als_upper_thresh > TSL2591_ALS_MAX_VALUE)
+		return -EINVAL;
+
+	if (als_settings.als_upper_thresh < als_settings.als_lower_thresh)
+		return -EINVAL;
+
+	als_lower_l = (als_settings.als_lower_thresh & 0xFF);
+	als_lower_h = ((als_settings.als_lower_thresh >> 8) & 0xFF);
+	als_upper_l = (als_settings.als_upper_thresh & 0xFF);
+	als_upper_h = ((als_settings.als_upper_thresh >> 8) & 0xFF);
+
+	ret = i2c_smbus_write_byte_data(client,
+					TSL2591_CMD_NOP | TSL2591_AILTL,
+					als_lower_l);
+	if (ret) {
+		dev_err(&client->dev, "Failed to set als lower threshold\n");
+		return ret;
+	}
+
+	ret = i2c_smbus_write_byte_data(client,
+					TSL2591_CMD_NOP | TSL2591_AILTH,
+					als_lower_h);
+	if (ret) {
+		dev_err(&client->dev, "Failed to set als lower threshold\n");
+		return ret;
+	}
+
+	ret = i2c_smbus_write_byte_data(client,
+					TSL2591_CMD_NOP | TSL2591_AIHTL,
+					als_upper_l);
+	if (ret) {
+		dev_err(&client->dev, "Failed to set als upper threshold\n");
+		return ret;
+	}
+
+	ret = i2c_smbus_write_byte_data(client,
+					TSL2591_CMD_NOP | TSL2591_AIHTH,
+					als_upper_h);
+	if (ret) {
+		dev_err(&client->dev, "Failed to set als upper threshold\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tsl2591_set_als_persist_cycle(struct tsl2591_chip *chip)
+{
+	struct tsl2591_als_settings als_settings = chip->als_settings;
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					TSL2591_CMD_NOP | TSL2591_PERSIST,
+					als_settings.als_persist);
+	if (ret)
+		dev_err(&client->dev, "Failed to set als persist cycle\n");
+
+	return ret;
+}
+
+static int tsl2591_set_power_state(struct tsl2591_chip *chip, u8 state)
+{
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					TSL2591_CMD_NOP | TSL2591_ENABLE,
+					state);
+	if (ret)
+		dev_err(&client->dev,
+			"Failed to set the power state to %#04x\n", state);
+
+	return ret;
+}
+
+static ssize_t tsl2591_in_illuminance_period_available_show(struct device *dev,
+							    struct device_attribute *attr,
+							    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+		       tsl2591_als_period_list[chip->als_settings.als_int_time]);
+}
+
+static IIO_DEVICE_ATTR_RO(tsl2591_in_illuminance_period_available, 0);
+
+static struct attribute *tsl2591_event_attrs_ctrl[] = {
+	&iio_dev_attr_tsl2591_in_illuminance_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group tsl2591_event_attribute_group = {
+	.attrs = tsl2591_event_attrs_ctrl,
+};
+
+static const struct iio_event_spec tsl2591_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
+				BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec tsl2591_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_CALIBSCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_CALIBSCALE)
+	},
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.event_spec = tsl2591_events,
+		.num_event_specs = ARRAY_SIZE(tsl2591_events),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_CALIBSCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_CALIBSCALE)
+	},
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_CALIBSCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_CALIBSCALE)
+	},
+};
+
+static int tsl2591_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	pm_runtime_get_sync(&client->dev);
+
+	mutex_lock(&chip->als_mutex);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_INTENSITY) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = tsl2591_read_channel_data(indio_dev, chan, val, val2);
+		if (ret < 0)
+			break;
+
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		if (chan->type != IIO_LIGHT) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = tsl2591_read_channel_data(indio_dev, chan, val, val2);
+		if (ret < 0)
+			break;
+
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type != IIO_INTENSITY) {
+			ret = -EINVAL;
+			break;
+		}
+
+		*val = TSL2591_FVAL_TO_ATIME(chip->als_settings.als_int_time);
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (chan->type != IIO_INTENSITY) {
+			ret = -EINVAL;
+			break;
+		}
+
+		*val = tsl2591_gain_to_multiplier(chip->als_settings.als_gain);
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&chip->als_mutex);
+
+	pm_runtime_mark_last_busy(&client->dev);
+	pm_runtime_put_autosuspend(&client->dev);
+
+	return ret;
+}
+
+static int tsl2591_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+
+	u32 int_time;
+	u8 gain;
+	int ret;
+
+	mutex_lock(&chip->als_mutex);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		int_time = tsl2591_als_time_to_fval(val);
+		if (int_time < 0) {
+			ret = int_time;
+			goto err;
+		}
+		ret = tsl2591_compatible_int_time(chip, int_time);
+		if (ret < 0)
+			goto err;
+
+		chip->als_settings.als_int_time = int_time;
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		gain = tsl2591_multiplier_to_gain(val);
+		if (gain < 0) {
+			ret = gain;
+			goto err;
+		}
+		ret = tsl2591_compatible_gain(chip, gain);
+		if (ret < 0)
+			goto err;
+
+		chip->als_settings.als_gain = gain;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = tsl2591_set_als_gain_int_time(chip);
+	if (ret < 0)
+		goto err;
+
+err:
+	mutex_unlock(&chip->als_mutex);
+	return ret;
+}
+
+static int tsl2591_read_available(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(tsl2591_int_time_available);
+		*vals = tsl2591_int_time_available;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*length = ARRAY_SIZE(tsl2591_calibscale_available);
+		*vals = tsl2591_calibscale_available;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl2591_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val,
+				    int *val2)
+{
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	struct i2c_client *client = chip->client;
+	int als_persist, int_time, period;
+	int ret;
+
+	mutex_lock(&chip->als_mutex);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = chip->als_settings.als_upper_thresh;
+			break;
+		case IIO_EV_DIR_FALLING:
+			*val = chip->als_settings.als_lower_thresh;
+			break;
+		default:
+			ret = -EINVAL;
+			goto err;
+		}
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_EV_INFO_PERIOD:
+		ret = i2c_smbus_read_byte_data(client,
+					       TSL2591_CMD_NOP | TSL2591_PERSIST);
+		if (ret <= 0 || ret > TSL2591_PRST_ALS_INT_CYCLE_MAX)
+			goto err;
+
+		als_persist = tsl2591_persist_cycle_to_lit(ret);
+		int_time = TSL2591_FVAL_TO_ATIME(chip->als_settings.als_int_time);
+		period = als_persist * (int_time * MSEC_PER_SEC);
+
+		*val = period / USEC_PER_SEC;
+		*val2 = period % USEC_PER_SEC;
+
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+
+err:
+	mutex_unlock(&chip->als_mutex);
+	return ret;
+}
+
+static int tsl2591_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int val,
+				     int val2)
+{
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	int period, int_time, als_persist;
+	int ret;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	mutex_lock(&chip->als_mutex);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val > TSL2591_ALS_MAX_VALUE) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		/*
+		 * Lower threshold should not be greater than upper. If this
+		 * is the case, then assert upper threshold to new lower
+		 * threshold + 1 to avoid ordering issues when setting
+		 * thresholds.
+		 */
+		if (dir == IIO_EV_DIR_FALLING)
+			if (val > chip->als_settings.als_upper_thresh)
+				chip->als_settings.als_upper_thresh = val + 1;
+
+		/*
+		 * Upper threshold should not be less than lower. If this
+		 * is the case, then assert lower threshold to new upper
+		 * threshold - 1 to avoid ordering issues when setting
+		 * thresholds.
+		 */
+		if (dir == IIO_EV_DIR_RISING)
+			if (val < chip->als_settings.als_lower_thresh)
+				chip->als_settings.als_lower_thresh = val - 1;
+
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			chip->als_settings.als_upper_thresh = val;
+			ret = tsl2591_set_als_thresholds(chip);
+			if (ret < 0)
+				goto err;
+			break;
+		case IIO_EV_DIR_FALLING:
+			chip->als_settings.als_lower_thresh = val;
+			ret = tsl2591_set_als_thresholds(chip);
+			if (ret < 0)
+				goto err;
+			break;
+		default:
+			ret = -EINVAL;
+			goto err;
+		}
+		break;
+	case IIO_EV_INFO_PERIOD:
+		int_time = TSL2591_FVAL_TO_ATIME(chip->als_settings.als_int_time);
+
+		period = ((val * MSEC_PER_SEC) +
+			 (val2 / MSEC_PER_SEC)) / int_time;
+
+		als_persist = tsl2591_persist_lit_to_cycle(period);
+		if (als_persist < 0) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = tsl2591_compatible_als_persist_cycle(chip, als_persist);
+		if (ret < 0)
+			goto err;
+		chip->als_settings.als_persist = als_persist;
+		ret = tsl2591_set_als_persist_cycle(chip);
+		if (ret < 0)
+			goto err;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+
+err:
+	mutex_unlock(&chip->als_mutex);
+	return ret;
+}
+
+static int tsl2591_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+
+	return chip->events_enabled;
+}
+
+static int tsl2591_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	struct i2c_client *client = chip->client;
+
+	if (state && !chip->events_enabled) {
+		chip->events_enabled = true;
+		pm_runtime_get_sync(&client->dev);
+	} else if (!state && chip->events_enabled) {
+		chip->events_enabled = false;
+		pm_runtime_mark_last_busy(&client->dev);
+		pm_runtime_put_autosuspend(&client->dev);
+	}
+
+	return 0;
+}
+
+static const struct iio_info tsl2591_info = {
+	.event_attrs = &tsl2591_event_attribute_group,
+	.read_raw = tsl2591_read_raw,
+	.write_raw = tsl2591_write_raw,
+	.read_avail = tsl2591_read_available,
+	.read_event_value = tsl2591_read_event_value,
+	.write_event_value = tsl2591_write_event_value,
+	.read_event_config = tsl2591_read_event_config,
+	.write_event_config = tsl2591_write_event_config,
+};
+
+static int __maybe_unused tsl2591_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&chip->als_mutex);
+	ret = tsl2591_set_power_state(chip, TSL2591_PWR_OFF);
+	mutex_unlock(&chip->als_mutex);
+
+	return ret;
+}
+
+static int __maybe_unused tsl2591_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	int power_state;
+	int ret;
+
+	if (chip->events_enabled)
+		power_state = TSL2591_PWR_ON |
+			      TSL2591_ENABLE_ALS_INT |
+			      TSL2591_ENABLE_ALS;
+	else
+		power_state = TSL2591_PWR_ON | TSL2591_ENABLE_ALS;
+
+	mutex_lock(&chip->als_mutex);
+	ret = tsl2591_set_power_state(chip, power_state);
+	mutex_unlock(&chip->als_mutex);
+
+	return ret;
+}
+
+static const struct dev_pm_ops tsl2591_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(tsl2591_suspend, tsl2591_resume, NULL)
+};
+
+static irqreturn_t tsl2591_event_handler(int irq, void *private)
+{
+	struct iio_dev *dev_info = private;
+	struct tsl2591_chip *chip = iio_priv(dev_info);
+	struct i2c_client *client = chip->client;
+
+	if (!chip->events_enabled)
+		return IRQ_HANDLED;
+
+	iio_push_event(dev_info,
+		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+					    iio_get_time_ns(dev_info));
+
+	/* Clear ALS irq */
+	i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
+
+	return IRQ_HANDLED;
+}
+
+static int tsl2591_load_defaults(struct tsl2591_chip *chip)
+{
+	int ret;
+
+	chip->als_settings.als_int_time = TSL2591_DEFAULT_ALS_INT_TIME;
+	chip->als_settings.als_gain = TSL2591_DEFAULT_ALS_GAIN;
+	chip->als_settings.als_persist = TSL2591_DEFAULT_ALS_PERSIST;
+	chip->als_settings.als_lower_thresh = TSL2591_DEFAULT_ALS_LOWER_THRESH;
+	chip->als_settings.als_upper_thresh = TSL2591_DEFAULT_ALS_UPPER_THRESH;
+
+	ret = tsl2591_set_als_gain_int_time(chip);
+	if (ret < 0)
+		return ret;
+
+	ret = tsl2591_set_als_persist_cycle(chip);
+	if (ret < 0)
+		return ret;
+
+	ret = tsl2591_set_als_thresholds(chip);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void tsl2591_chip_off(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct tsl2591_chip *chip = iio_priv(indio_dev);
+	struct i2c_client *client = chip->client;
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
+	tsl2591_set_power_state(chip, TSL2591_PWR_OFF);
+}
+
+static int tsl2591_probe(struct i2c_client *client)
+{
+	struct tsl2591_chip *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(&client->dev,
+			"I2C smbus byte data functionality is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+	chip->client = client;
+	i2c_set_clientdata(client, indio_dev);
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, tsl2591_event_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"tsl2591_irq", indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "IRQ request error %d\n", -ret);
+			return -EINVAL;
+		}
+	}
+
+	mutex_init(&chip->als_mutex);
+
+	ret = i2c_smbus_read_byte_data(client,
+				       TSL2591_CMD_NOP | TSL2591_DEVICE_ID);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to read the device ID register\n");
+		return ret;
+	}
+	ret = FIELD_GET(TSL2591_DEVICE_ID_MASK, ret);
+	if (ret != TSL2591_DEVICE_ID_VAL) {
+		dev_err(&client->dev, "Device ID: %#04x unknown\n", ret);
+		return -EINVAL;
+	}
+
+	indio_dev->info = &tsl2591_info;
+	indio_dev->channels = tsl2591_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tsl2591_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = chip->client->name;
+	chip->events_enabled = false;
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev,
+					 TSL2591_POWER_OFF_DELAY_MS);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	/*
+	 * Add chip off to automatically managed path and disable runtime
+	 * power management. This ensures that the chip power management
+	 * is handled correctly on driver remove. tsl2591_chip_off must be
+	 * added to the managed path after pm runtime is enabled and before
+	 * any error exit paths are met to ensure we're not left in a state
+	 * of pm runtime not being disabled properly.
+	 */
+	ret = devm_add_action_or_reset(&client->dev, tsl2591_chip_off,
+				       indio_dev);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = tsl2591_load_defaults(chip);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to load sensor defaults\n");
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to clear als irq\n");
+		return -EINVAL;
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id tsl2591_of_match[] = {
+	{ .compatible = "amstaos,tsl2591"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, tsl2591_of_match);
+
+static struct i2c_driver tsl2591_driver = {
+	.driver = {
+		.name = "tsl2591",
+		.pm = &tsl2591_pm_ops,
+		.of_match_table = tsl2591_of_match,
+	},
+	.probe_new = tsl2591_probe
+};
+module_i2c_driver(tsl2591_driver);
+
+MODULE_AUTHOR("Joe Sandom <joe.g.sandom@gmail.com>");
+MODULE_DESCRIPTION("TAOS tsl2591 ambient light sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

