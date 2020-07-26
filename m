Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B0622DF9B
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgGZOK1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZOK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jul 2020 10:10:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71CC0619D2;
        Sun, 26 Jul 2020 07:10:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so6784034plr.2;
        Sun, 26 Jul 2020 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9n0vaL4s5Jm/L5a6Q8djKSafOWEG3poIZN1trz1Qfw=;
        b=sMDG2s1BlkBZEiAJXznDFqFW4w77ZXm5LUqdYeTkSFCfGJWc9elDyW4MhVR1djzoli
         egB+PR46drSr8fMhmb6BiAyuvAfw3KDUlo3NYRz7MxFxhB7Qq78RMcCO64OBirz9q/xB
         htsX34O9bIR5SCSzLDnQNiMaS7SKAJ6viEVLDjRqzqHl0OrPQdlx9ivk54K2LvQguJ2X
         4M/z1UHqY3z//4FKsX7loLDMfZkn2x5KfyJ1ayiOLsKixIJ9EyWkoFbbrmnjGQlOyXmD
         pIrrwUFXScvqjQN2mk0ojjQkBn/YvAXjZSjjxSxP05HYTdQPdp6TjhEyuKklI4vql3PE
         t+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9n0vaL4s5Jm/L5a6Q8djKSafOWEG3poIZN1trz1Qfw=;
        b=rxq7eOP4/FmgX2rtpeVcZMhxRToa5P7CPl4koseSiwG15xCg3RUNAZu+Qpt1J8a3Ur
         sakGxpmgYECiL4bZJB/c7cQuMDBzLRSLJ8KTkgfn3GfGDu+YSrGOS7beZkKAd23S8jWh
         ezSloxxqkFtea4FgsSyRMG2q0vSB/we50znWm2R4tK4ZZq2SCLbqOcDflqOunL9rxhWf
         +1tIWts8s5O4V9Jj19QoRrZtYPazwBix4pS9TG3c/n1i7N3OWNV3lvAbukHxudZfp/nY
         WKn1gztiPeLHArP0p47+bTtzzSTtjEW/Yqu+lGhEWQC4iTn6Mb5LSmco7oeu+nAk/UG6
         NFYg==
X-Gm-Message-State: AOAM531V55lXuxhydAYMNJ+9KioyYqF/DVGZ23hHbhWtshfuBq6qYg+H
        q1zgu2bIFrO4ZSRlrEObBOU=
X-Google-Smtp-Source: ABdhPJyq3XdahDdEGR4a8K/5s8LPe7j6OVqNPAq4mRV2MwN6XqC2EZffeC4/Fk2g1uMmELlTSj5EBA==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr13106294pjb.63.1595772626291;
        Sun, 26 Jul 2020 07:10:26 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6d98:886d:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id z9sm2237979pfn.59.2020.07.26.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:10:25 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [v4 1/2] iio: gyro: Add driver support for ADXRS290
Date:   Sun, 26 Jul 2020 19:40:16 +0530
Message-Id: <20200726141017.2835-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADXRS290 is a high performance MEMS pitch and roll (dual-axis in-plane)
angular rate sensor (gyroscope) designed for use in stabilization
applications. It also features an internal temperature sensor and
programmable high-pass and low-pass filters.

Add support for ADXRS290 in direct-access mode for now.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v4:
  - reorder header includes lexicographically
  - add prefix 'ADXRS290_MODE_' to enum 'adxrs290_mode' elements
  - drop unnecessary type promotions/demotions wherever required by
    modifying function signatures
  - avoid the usage of local variables and write directly to *val during a
    read_raw()
  - remove spi_set_drvdata() as corresponding spi_get_drvdata() is never
    used

Changes in v3:
  - drop "Link" tag & extra line in commit message
  - rename cut-off frequencies tables to
    'adxrs290_{lpf, hpf}_3db_freq_hz_table' to be more descriptive
  - fix unsigned type errors
  - add comments on how to scale raw angular velocity and temperature
    values to appropriate units mentioned in the ABI
  - re-order declarations in reversed spruce tree order
  - remove 'indio_dev->dev.parent = &spi->dev' as the iio core handles it
    during iio_device_alloc()
  - use plain msleep() instead of the interruptible variant
  - remove extra terminal comma

Changes in v2:
  - append copyright tag with author's info
  - remove asm/unaligned.h header
  - remove unnecessary comments about the registers' description
  - rephrase comment on the usage of mutex_lock
  - discard the usage of local tx, rx buffers; use DMA-safe buffers
    provided by the SPI core instead
  - utilize spi_w8r16 provided by the SPI core instead of writing a
    wrapper over spi_sync_transfer which semantically does the same
  - equip spi_write_then_read instead of plain spi_write since the
    latter requires a DMA-safe buffer
  - implement exact matching of filter 3db frequencies instead of
    finding the "closest" match; rounding complexity is left to the
    userspace
  - include 'info_mask_shared_by_type_available' when initialising
    iio_chan_spec instead of explicitly exposing attributes
    signifying available filter 3db frequencies; with this we can
    utilize read_avail core callback
---
 MAINTAINERS                 |   6 +
 drivers/iio/gyro/Kconfig    |  10 +
 drivers/iio/gyro/Makefile   |   1 +
 drivers/iio/gyro/adxrs290.c | 444 ++++++++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/iio/gyro/adxrs290.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9077411c9890..71ae9b184179 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1098,6 +1098,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/adv7842*
 
+ANALOG DEVICES INC ADXRS290 DRIVER
+M:	Nishant Malpani <nish.malpani25@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/gyro/adxrs290.c
+
 ANALOG DEVICES INC ASOC CODEC DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Nuno Sá <nuno.sa@analog.com>
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 6daeddf37f60..024a34139875 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -41,6 +41,16 @@ config ADIS16260
 	  This driver can also be built as a module.  If so, the module
 	  will be called adis16260.
 
+config ADXRS290
+	tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADXRS290 programmable
+	  digital output gyroscope.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called adxrs290.
+
 config ADXRS450
 	tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI driver"
 	depends on SPI
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 45cbd5dc644e..0319b397dc3f 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ADIS16080) += adis16080.o
 obj-$(CONFIG_ADIS16130) += adis16130.o
 obj-$(CONFIG_ADIS16136) += adis16136.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
+obj-$(CONFIG_ADXRS290) += adxrs290.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
 obj-$(CONFIG_BMG160) += bmg160_core.o
 obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
new file mode 100644
index 000000000000..38bab4e3eee9
--- /dev/null
+++ b/drivers/iio/gyro/adxrs290.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADXRS290 SPI Gyroscope Driver
+ *
+ * Copyright (C) 2020 Nishant Malpani <nish.malpani25@gmail.com>
+ * Copyright (C) 2020 Analog Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define ADXRS290_ADI_ID		0xAD
+#define ADXRS290_MEMS_ID	0x1D
+#define ADXRS290_DEV_ID		0x92
+
+#define ADXRS290_REG_ADI_ID	0x00
+#define ADXRS290_REG_MEMS_ID	0x01
+#define ADXRS290_REG_DEV_ID	0x02
+#define ADXRS290_REG_REV_ID	0x03
+#define ADXRS290_REG_SN0	0x04 /* Serial Number Registers, 4 bytes */
+#define ADXRS290_REG_DATAX0	0x08 /* Roll Rate o/p Data Regs, 2 bytes */
+#define ADXRS290_REG_DATAY0	0x0A /* Pitch Rate o/p Data Regs, 2 bytes */
+#define ADXRS290_REG_TEMP0	0x0C
+#define ADXRS290_REG_POWER_CTL	0x10
+#define ADXRS290_REG_FILTER	0x11
+#define ADXRS290_REG_DATA_RDY	0x12
+
+#define ADXRS290_READ		BIT(7)
+#define ADXRS290_TSM		BIT(0)
+#define ADXRS290_MEASUREMENT	BIT(1)
+#define ADXRS290_SYNC		GENMASK(1, 0)
+#define ADXRS290_LPF_MASK	GENMASK(2, 0)
+#define ADXRS290_LPF(x)		FIELD_PREP(ADXRS290_LPF_MASK, x)
+#define ADXRS290_HPF_MASK	GENMASK(7, 4)
+#define ADXRS290_HPF(x)		FIELD_PREP(ADXRS290_HPF_MASK, x)
+
+#define ADXRS290_READ_REG(reg)	(ADXRS290_READ | (reg))
+
+#define ADXRS290_MAX_TRANSITION_TIME_MS 100
+
+enum adxrs290_mode {
+	ADXRS290_MODE_STANDBY,
+	ADXRS290_MODE_MEASUREMENT,
+};
+
+struct adxrs290_state {
+	struct spi_device	*spi;
+	/* Serialize reads and their subsequent processing */
+	struct mutex		lock;
+	enum adxrs290_mode	mode;
+	unsigned int		lpf_3db_freq_idx;
+	unsigned int		hpf_3db_freq_idx;
+};
+
+/*
+ * Available cut-off frequencies of the low pass filter in Hz.
+ * The integer part and fractional part are represented separately.
+ */
+static const int adxrs290_lpf_3db_freq_hz_table[][2] = {
+	[0] = {480, 0},
+	[1] = {320, 0},
+	[2] = {160, 0},
+	[3] = {80, 0},
+	[4] = {56, 600000},
+	[5] = {40, 0},
+	[6] = {28, 300000},
+	[7] = {20, 0},
+};
+
+/*
+ * Available cut-off frequencies of the high pass filter in Hz.
+ * The integer part and fractional part are represented separately.
+ */
+static const int adxrs290_hpf_3db_freq_hz_table[][2] = {
+	[0] = {0, 0},
+	[1] = {0, 11000},
+	[2] = {0, 22000},
+	[3] = {0, 44000},
+	[4] = {0, 87000},
+	[5] = {0, 175000},
+	[6] = {0, 350000},
+	[7] = {0, 700000},
+	[8] = {1, 400000},
+	[9] = {2, 800000},
+	[10] = {11, 300000},
+};
+
+static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *val)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret = 0;
+	int temp;
+
+	mutex_lock(&st->lock);
+	temp = spi_w8r16(st->spi, cmd);
+	if (temp < 0) {
+		ret = temp;
+		goto err_unlock;
+	}
+
+	*val = temp;
+
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int adxrs290_get_temp_data(struct iio_dev *indio_dev, int *val)
+{
+	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret = 0;
+	int temp;
+
+	mutex_lock(&st->lock);
+	temp = spi_w8r16(st->spi, cmd);
+	if (temp < 0) {
+		ret = temp;
+		goto err_unlock;
+	}
+
+	/* extract lower 12 bits temperature reading */
+	*val = temp & 0x0FFF;
+
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u8 *val2)
+{
+	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_FILTER);
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret = 0;
+	short temp;
+
+	mutex_lock(&st->lock);
+	temp = spi_w8r8(st->spi, cmd);
+	if (temp < 0) {
+		ret = temp;
+		goto err_unlock;
+	}
+
+	*val = FIELD_GET(ADXRS290_LPF_MASK, temp);
+	*val2 = FIELD_GET(ADXRS290_HPF_MASK, temp);
+
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
+				  const u8 val)
+{
+	u8 buf[2];
+
+	buf[0] = reg;
+	buf[1] = val;
+
+	return spi_write_then_read(spi, buf, ARRAY_SIZE(buf), NULL, 0);
+}
+
+static int adxrs290_find_match(const int (*freq_tbl)[2], const int n,
+			       const int val, const int val2)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (freq_tbl[i][0] == val && freq_tbl[i][1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
+				    const unsigned int lpf_idx,
+				    const unsigned int hpf_idx)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	u8 val;
+
+	val = ADXRS290_HPF(hpf_idx) | ADXRS290_LPF(lpf_idx);
+
+	return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
+}
+
+static int adxrs290_initial_setup(struct iio_dev *indio_dev)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+
+	st->mode = ADXRS290_MODE_MEASUREMENT;
+
+	return adxrs290_spi_write_reg(st->spi,
+				      ADXRS290_REG_POWER_CTL,
+				      ADXRS290_MEASUREMENT | ADXRS290_TSM);
+}
+
+static int adxrs290_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val,
+			     int *val2,
+			     long mask)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	unsigned int t;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			ret = adxrs290_get_rate_data(indio_dev,
+						     ADXRS290_READ_REG(chan->address),
+						     val);
+			if (ret < 0)
+				return ret;
+
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			ret = adxrs290_get_temp_data(indio_dev, val);
+			if (ret < 0)
+				return ret;
+
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			/* 1 LSB = 0.005 degrees/sec */
+			*val = 0;
+			*val2 = 87266;
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			/* 1 LSB = 0.1 degrees Celsius */
+			*val = 100;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			t = st->lpf_3db_freq_idx;
+			*val = adxrs290_lpf_3db_freq_hz_table[t][0];
+			*val2 = adxrs290_lpf_3db_freq_hz_table[t][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			t = st->hpf_3db_freq_idx;
+			*val = adxrs290_hpf_3db_freq_hz_table[t][0];
+			*val2 = adxrs290_hpf_3db_freq_hz_table[t][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int adxrs290_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val,
+			      int val2,
+			      long mask)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int lpf_idx, hpf_idx;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		lpf_idx = adxrs290_find_match(adxrs290_lpf_3db_freq_hz_table,
+					      ARRAY_SIZE(adxrs290_lpf_3db_freq_hz_table),
+					      val, val2);
+		if (lpf_idx < 0)
+			return -EINVAL;
+		/* caching the updated state of the low-pass filter */
+		st->lpf_3db_freq_idx = lpf_idx;
+		/* retrieving the current state of the high-pass filter */
+		hpf_idx = st->hpf_3db_freq_idx;
+		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		hpf_idx = adxrs290_find_match(adxrs290_hpf_3db_freq_hz_table,
+					      ARRAY_SIZE(adxrs290_hpf_3db_freq_hz_table),
+					      val, val2);
+		if (hpf_idx < 0)
+			return -EINVAL;
+		/* caching the updated state of the high-pass filter */
+		st->hpf_3db_freq_idx = hpf_idx;
+		/* retrieving the current state of the low-pass filter */
+		lpf_idx = st->lpf_3db_freq_idx;
+		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+	}
+
+	return -EINVAL;
+}
+
+static int adxrs290_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (const int *)adxrs290_lpf_3db_freq_hz_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = ARRAY_SIZE(adxrs290_lpf_3db_freq_hz_table) * 2;
+
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (const int *)adxrs290_hpf_3db_freq_hz_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = ARRAY_SIZE(adxrs290_hpf_3db_freq_hz_table) * 2;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+#define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {				\
+	.type = IIO_ANGL_VEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |		\
+	BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),		\
+	.info_mask_shared_by_type_available =				\
+	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |		\
+	BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),		\
+}
+
+static const struct iio_chan_spec adxrs290_channels[] = {
+	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAX0, X),
+	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAY0, Y),
+	{
+		.type = IIO_TEMP,
+		.address = ADXRS290_REG_TEMP0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static const struct iio_info adxrs290_info = {
+	.read_raw = &adxrs290_read_raw,
+	.write_raw = &adxrs290_write_raw,
+	.read_avail = &adxrs290_read_avail,
+};
+
+static int adxrs290_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adxrs290_state *st;
+	u8 val, val2;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	indio_dev->name = "adxrs290";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adxrs290_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
+	indio_dev->info = &adxrs290_info;
+
+	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
+	if (val != ADXRS290_ADI_ID) {
+		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
+		return -ENODEV;
+	}
+
+	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
+	if (val != ADXRS290_MEMS_ID) {
+		dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", val);
+		return -ENODEV;
+	}
+
+	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
+	if (val != ADXRS290_DEV_ID) {
+		dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", val);
+		return -ENODEV;
+	}
+
+	/* default mode the gyroscope starts in */
+	st->mode = ADXRS290_MODE_STANDBY;
+
+	/* switch to measurement mode and switch on the temperature sensor */
+	ret = adxrs290_initial_setup(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	/* max transition time to measurement mode */
+	msleep(ADXRS290_MAX_TRANSITION_TIME_MS);
+
+	ret = adxrs290_get_3db_freq(indio_dev, &val, &val2);
+	if (ret < 0)
+		return ret;
+
+	st->lpf_3db_freq_idx = val;
+	st->hpf_3db_freq_idx = val2;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id adxrs290_of_match[] = {
+	{ .compatible = "adi,adxrs290" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adxrs290_of_match);
+
+static struct spi_driver adxrs290_driver = {
+	.driver = {
+		.name = "adxrs290",
+		.of_match_table = adxrs290_of_match,
+	},
+	.probe = adxrs290_probe,
+};
+module_spi_driver(adxrs290_driver);
+
+MODULE_AUTHOR("Nishant Malpani <nish.malpani25@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADXRS290 Gyroscope SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

