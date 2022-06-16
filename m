Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B713D54DE8A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiFPKAk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiFPKAi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 06:00:38 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6E5C872
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 03:00:36 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 758521BF205;
        Thu, 16 Jun 2022 10:00:33 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Date:   Thu, 16 Jun 2022 12:00:06 +0200
Message-Id: <20220616100006.22045-3-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jacopo Mondi <jacopo@jmondi.org>

Add support for CEVA BNO08x Sensor Hub.

The BNO08X family (BNO080/85/86) is a System in Package (SiP) that
integrates a triaxial accelerometer, triaxial gyroscope, magnetometer
and a 32-bit ARM Cortex-M0+ microcontroller running CEVA's SH-2
firmware.

Datasheet:
https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 MAINTAINERS                             |   7 +
 drivers/staging/iio/Kconfig             |   1 +
 drivers/staging/iio/Makefile            |   1 +
 drivers/staging/iio/imu/bno08x/Kconfig  |  11 +
 drivers/staging/iio/imu/bno08x/Makefile |   3 +
 drivers/staging/iio/imu/bno08x/bno08x.c | 618 ++++++++++++++++++++++++
 6 files changed, 641 insertions(+)
 create mode 100644 drivers/staging/iio/imu/bno08x/Kconfig
 create mode 100644 drivers/staging/iio/imu/bno08x/Makefile
 create mode 100644 drivers/staging/iio/imu/bno08x/bno08x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b8c3560117..4b709599c82b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4314,6 +4314,13 @@ F:	certs/
 F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
 
+CEVA BNO08x SENSOR HUB
+ML	Jacopo Mondi <jacopo@jmondi.org>
+L:	linux-iio@vger.kernel.org
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/staging/iio/imu/ceva,bno08x.yaml
+F	drivers/staging/iio/imu/bno08x/
+
 CFAG12864B LCD DRIVER
 M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index a8e970db179d..bcecace954a5 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -11,6 +11,7 @@ source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
+source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
 
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index b15904b99581..eafcc25b64f9 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -9,5 +9,6 @@ obj-y += addac/
 obj-y += cdc/
 obj-y += frequency/
 obj-y += impedance-analyzer/
+obj-y += imu/
 obj-y += meter/
 obj-y += resolver/
diff --git a/drivers/staging/iio/imu/bno08x/Kconfig b/drivers/staging/iio/imu/bno08x/Kconfig
new file mode 100644
index 000000000000..109ac11ed4f9
--- /dev/null
+++ b/drivers/staging/iio/imu/bno08x/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CEVA_BNO08x_IMU
+	tristate "CEVA BNO08x IMU driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for CEVA BNO08x IMU.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called bno08x.
diff --git a/drivers/staging/iio/imu/bno08x/Makefile b/drivers/staging/iio/imu/bno08x/Makefile
new file mode 100644
index 000000000000..48bbbf12a366
--- /dev/null
+++ b/drivers/staging/iio/imu/bno08x/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CEVA_BNO08x_IMU) += bno08x.o
diff --git a/drivers/staging/iio/imu/bno08x/bno08x.c b/drivers/staging/iio/imu/bno08x/bno08x.c
new file mode 100644
index 000000000000..e07735a85b34
--- /dev/null
+++ b/drivers/staging/iio/imu/bno08x/bno08x.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CEVA BNO08x IMU driver.
+ *
+ * Copyright (c) 2021 Jacopo Mondi <jacopo@jmondi.org>
+ */
+
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+
+#define DRIVER_NAME "bno08x"
+
+#define BNO08x_SHTP_HDR_SIZE		0x4
+#define BNO08x_SHTP_HDR_LEN_LSB		0x0
+#define BNO08x_SHTP_HDR_LEN_MSB		0x1
+#define BNO08x_SHTP_HDR_CHAN		0x2
+#define BNO08x_SHTP_HDR_SEQ		0x3
+
+#define BNO08x_SHTP_MAX_SIZE		128
+#define BNO08x_SHTP_ADV_MAX_SIZE	512
+
+#define BNO08x_SHTP_SOFT_RESET		0x01
+#define BNO08x_SHTP_PROD_ID		0xf8
+#define BNO08x_SHTP_PROD_ID_REQ		0xf9
+
+#define BNO08x_SHTP_GET_FEATURE_RESP	0xfc
+#define BNO08x_SHTP_SET_FEATURE_CMD	0xfd
+#define BNO08x_SHTP_GET_FEATURE_REQ	0xfe
+
+#define BNO08x_ROT_SCAN_INDEX		0x01
+#define BNO08x_REPORTID_ROTATION_VEC	0x05
+#define BNO08x_REPORTID_TIMESTAMP_BASE	0xfb
+
+enum bno08x_shtp_channels {
+	BNO08x_SHTP_COMMAND_CHAN,
+	BNO08x_SHTP_EXECTUABLE_CHAN,
+	BNO08x_SHTP_CONTROL_CHAN,
+	BNO08x_SHTP_REPORTS_CHAN,
+	BNO08x_SHTP_WAKE_REPORTS_CHAN,
+	BNO08x_SHTP_GYRO_CHAN,
+	BNO08x_NUM_CHANNELS,
+};
+
+struct bno08x_dev {
+	struct i2c_client *client;
+
+	struct iio_trigger *trig;
+
+	/* Completions for cargo transfer. */
+	struct completion cargo_ready;
+	struct completion waiters_done;
+
+	/* cargo sequence number per channel. */
+	u32 seq_num[BNO08x_NUM_CHANNELS];
+
+	/* Mask of the enabled report ids. */
+	u64 enabled_reports_mask;
+
+#define BNO08x_CARGO_BUFFER_SIZE	1024lu
+	struct {
+		u8 buffer[BNO08x_CARGO_BUFFER_SIZE];
+		size_t len;
+		atomic_t waiters;
+
+		/* Protects access to the cargo buffer content. */
+		struct mutex mutex;
+	} cargo;
+};
+
+static irqreturn_t bno08x_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *iio_dev = dev_id;
+
+	if (iio_dev->trig)
+		iio_trigger_poll((void *)iio_dev->trig);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t bno08x_dump_cargo(int irq, void *dev_id)
+{
+	struct iio_dev *iio_dev = dev_id;
+	struct bno08x_dev *bno08x = iio_priv(iio_dev);
+	struct i2c_client *client = bno08x->client;
+	u8 *cargo = bno08x->cargo.buffer;
+	size_t to_read;
+	size_t len;
+	int ret;
+
+	mutex_lock(&bno08x->cargo.mutex);
+
+	/* Read only the header first to know how many bytes we expect to receive. */
+	ret = i2c_master_recv(client, bno08x->cargo.buffer, BNO08x_SHTP_HDR_SIZE);
+	if (ret != BNO08x_SHTP_HDR_SIZE)
+		goto out_unlock;
+
+	/*
+	 * Clear the top bit: it means a cargo is a continuation of the last one.
+	 * Ignore it for now.
+	 */
+	len = (cargo[BNO08x_SHTP_HDR_LEN_MSB] << 8 |
+	       cargo[BNO08x_SHTP_HDR_LEN_LSB]) & ~BIT(15);
+
+	if (len == 0)
+		goto out_complete;
+
+	if (len > BNO08x_CARGO_BUFFER_SIZE)
+		dev_warn(&client->dev,
+			 "Cargo size exceeds buffer: content will be unusable\n");
+
+	/*
+	 * Read the full cargo now that we know its length.
+	 *
+	 * If the reported length exceeds the max transfer size, read the cargo
+	 * in chunks. Its content will be unusable though.
+	 */
+	to_read = len;
+	len = min(len, BNO08x_CARGO_BUFFER_SIZE);
+	while (to_read) {
+		memset(bno08x->cargo.buffer, 0, len);
+
+		ret = i2c_master_recv(client, bno08x->cargo.buffer, len);
+		if (ret != len) {
+			dev_err(&client->dev,
+				"Failed to read cargo of size %lu: %d\n",
+				len, ret);
+			goto out_complete;
+		}
+
+		to_read -= len;
+	}
+
+	bno08x->cargo.len = len;
+
+out_complete:
+	if (atomic_read(&bno08x->cargo.waiters) == 0)
+		goto out_unlock;
+
+	/*
+	 * Wake up all waiters and let them read the cargo buffer.
+	 *
+	 * Unlock the cargo mutex only after all waiters are done, to avoid
+	 * this interrupt handler re-writing the buffer content with the next
+	 * cargo before waiters have read it.
+	 */
+	complete_all(&bno08x->cargo_ready);
+
+	wait_for_completion(&bno08x->waiters_done);
+	reinit_completion(&bno08x->waiters_done);
+
+out_unlock:
+	mutex_unlock(&bno08x->cargo.mutex);
+
+	return IRQ_HANDLED;
+}
+
+static int bno08x_write_cargo(struct bno08x_dev *bno08x,
+			      enum bno08x_shtp_channels channel,
+			      u8 *cargo, u16 length)
+{
+	u16 cargo_length = length + BNO08x_SHTP_HDR_SIZE;
+	struct i2c_client *client = bno08x->client;
+	int ret;
+
+	/* Assemble header */
+	cargo[BNO08x_SHTP_HDR_LEN_LSB] = cargo_length & 0xff;
+	cargo[BNO08x_SHTP_HDR_LEN_MSB] = cargo_length >> 8;
+	cargo[BNO08x_SHTP_HDR_CHAN] = channel;
+	cargo[BNO08x_SHTP_HDR_SEQ] = bno08x->seq_num[channel]++;
+
+	ret = i2c_master_send(client, cargo, cargo_length);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to write cargo to channel %u: %d\n",
+			channel, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bno08x_wait_for_cargo_timeout(struct bno08x_dev *bno08x, u8 *cargo,
+					 size_t len)
+{
+	static const unsigned long complete_timeout = 500; /* msecs */
+	struct i2c_client *client = bno08x->client;
+	int ret = 0;
+
+	atomic_inc(&bno08x->cargo.waiters);
+
+	if (!wait_for_completion_timeout(&bno08x->cargo_ready,
+					 msecs_to_jiffies(complete_timeout))) {
+		dev_dbg(&client->dev, "Wait for chip interrupt timeout.\n");
+		ret = -EIO;
+		goto out_unlock;
+	}
+
+	/* The caller is not interested in the data. */
+	if (!len)
+		goto out_unlock;
+
+	/*
+	 * Multiple readers might want to inspect the cargo content in response
+	 * to the complete_all(cargo_ready) signal.
+	 *
+	 * Copy data into the caller buffer to allow multiple threads to
+	 * access the cargo content independently.
+	 */
+	ret = min(len, bno08x->cargo.len);
+	memcpy(cargo, bno08x->cargo.buffer, ret);
+
+out_unlock:
+	/* The last waiter unlocks the cargo read routine. */
+	if (atomic_dec_return(&bno08x->cargo.waiters) == 0) {
+		reinit_completion(&bno08x->cargo_ready);
+		complete(&bno08x->waiters_done);
+	}
+
+	return ret;
+}
+
+static const struct iio_chan_spec bno08x_iio_channels[] = {
+	{
+		.type = IIO_ROT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = BNO08x_ROT_SCAN_INDEX,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.shift = 0,
+			.endianness = IIO_LE,
+		},
+	},
+};
+
+static int bno08x_enable_feature_report(struct bno08x_dev *bno08x, u8 report_id)
+{
+	struct i2c_client *client = bno08x->client;
+	/* Reporting interval hardcoded to 5 msec. */
+	unsigned int report_interval_usec = 5000;
+	u8 cargo[BNO08x_SHTP_MAX_SIZE] = {};
+	u8 *data = cargo + BNO08x_SHTP_HDR_SIZE;
+	unsigned int max_attempts = 50;
+	int ret;
+
+	if (bno08x->enabled_reports_mask & BIT(report_id))
+		return 0;
+
+	/*
+	 * Enable reporting the requested feature. The full "feature set
+	 * request" package size is 17 bytes.
+	 */
+	data[0] = BNO08x_SHTP_SET_FEATURE_CMD;
+	data[1] = report_id;
+
+	data[5] = (report_interval_usec >> 0);
+	data[6] = (report_interval_usec >> 8);
+	data[7] = (report_interval_usec >> 16);
+	data[8] = (report_interval_usec >> 24);
+
+	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_CONTROL_CHAN, cargo, 17);
+	if (ret)
+		return ret;
+
+	/*
+	 * Verify the requested feature is enabled inspecting the
+	 * 'feature request status" response cargo.
+	 */
+	memset(cargo, 0, BNO08x_SHTP_MAX_SIZE);
+	data[0] = BNO08x_SHTP_GET_FEATURE_REQ;
+	data[1] = report_id;
+
+	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_CONTROL_CHAN, cargo, 2);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for a "get feature response". The datasheet says it will "arrive
+	 * some time in the future". Read up to 10 packets then give up.
+	 */
+	while (--max_attempts) {
+		memset(cargo, 0, 5);
+		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 5);
+		if (ret < 0)
+			continue;
+
+		if (ret < 5)
+			continue;
+
+		if (data[0] == BNO08x_SHTP_GET_FEATURE_RESP ||
+		    data[1] == report_id)
+			break;
+	}
+	if (!max_attempts) {
+		dev_err(&client->dev,
+			"Failed to parse GET_FEATURE_RESPONSE: bad header\n");
+		return -EINVAL;
+	}
+
+	bno08x->enabled_reports_mask |= BIT(report_id);
+	dev_dbg(&client->dev, "Reporting of feature %x enabled!\n", report_id);
+
+	return 0;
+}
+
+static int bno08x_read_raw_rotation(struct bno08x_dev *bno08x, int *vals,
+				    int *val_len, int max_len)
+{
+	struct i2c_client *client = bno08x->client;
+	unsigned int max_attempts = 50;
+	u8 cargo[24];
+	int ret;
+
+	if (max_len < 3)
+		return -EINVAL;
+
+	ret = bno08x_enable_feature_report(bno08x, BNO08x_REPORTID_ROTATION_VEC);
+	if (ret)
+		return ret;
+
+	/*
+	 * Read the rotation vector in I, J and K quaternions.
+	 *
+	 * We're going to receive several other cargos before an actual rotation
+	 * vector input report, so we parse the cargo fields and only proceed
+	 * with a cargo that refers to the rotation vector report id.
+	 *
+	 * Use a sentinel to avoid looping forever, unfortunately we can't
+	 * really know how many cargos we have to discard before receiving the
+	 * 'right' one.
+	 */
+	while (--max_attempts) {
+		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 24);
+		if (ret < 0)
+			continue;
+
+		if (ret != 24)
+			continue;
+
+		/*
+		 * Parse the cargo content to make sure it's a well-formed input
+		 * report containing rotation vector information.
+		 *
+		 * The layout of an input report cargo is reported by Figure 5.2
+		 * of "BNO080/85/86 Datasheet 1000-3927 v.1.11".
+		 *
+		 * The rotation vector input report is 24 bytes long.
+		 */
+		if (cargo[2] == BNO08x_SHTP_REPORTS_CHAN &&
+		    cargo[4] == BNO08x_REPORTID_TIMESTAMP_BASE &&
+		    cargo[9] == BNO08x_REPORTID_ROTATION_VEC)
+			break;
+	}
+	if (!max_attempts) {
+		dev_err(&client->dev, "Failed to receive the correct input report\n");
+		return -EINVAL;
+	}
+
+	/* Read the I, J, K quaternions. */
+	vals[0] = cargo[13] | (cargo[14] << 8);
+	vals[1] = cargo[15] | (cargo[16] << 8);
+	vals[2] = cargo[17] | (cargo[18] << 8);
+	*val_len = 3;
+
+	return IIO_VAL_INT_MULTIPLE;
+}
+
+static int bno08x_read_raw_multi(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, int max_len,
+				 int *vals, int *val_len, long mask)
+{
+	struct bno08x_dev *bno08x = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return bno08x_read_raw_rotation(bno08x, vals, val_len, max_len);
+
+	case IIO_CHAN_INFO_SCALE:
+		vals[0] = 0;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct iio_info bno08x_iio_info = {
+	.read_raw_multi = bno08x_read_raw_multi,
+};
+
+static int bno08x_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool enable)
+{
+	struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
+	struct bno08x_dev *bno08x = iio_priv(iio_dev);
+	int ret;
+
+	if (!enable)
+		return 0;
+
+	ret = bno08x_enable_feature_report(bno08x, BNO08x_REPORTID_ROTATION_VEC);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops bno08x_trigger_ops = {
+	.set_trigger_state = &bno08x_data_rdy_trigger_set_state,
+};
+
+static irqreturn_t bno08x_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio_dev = pf->indio_dev;
+	struct bno08x_dev *bno08x = iio_priv(iio_dev);
+	u8 cargo[BNO08x_CARGO_BUFFER_SIZE];
+	int ret;
+
+	ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, BNO08x_CARGO_BUFFER_SIZE);
+	if (ret < 0)
+		goto done;
+
+	if (ret < 24)
+		goto done;
+
+	/* Make sure the cargo matches the active scan channel. */
+	if (*iio_dev->active_scan_mask & BIT(BNO08x_ROT_SCAN_INDEX) &&
+	    cargo[2] == BNO08x_SHTP_REPORTS_CHAN &&
+	    cargo[4] == BNO08x_REPORTID_TIMESTAMP_BASE &&
+	    cargo[9] == BNO08x_REPORTID_ROTATION_VEC) {
+		u16 data;
+
+		/* Unit quaternion I component. */
+		data = le16_to_cpu(cargo[13]);
+		iio_push_to_buffers_with_timestamp(iio_dev, &data, pf->timestamp);
+
+		/* Unit quaternion J component. */
+		data = le16_to_cpu(cargo[15]);
+		iio_push_to_buffers_with_timestamp(iio_dev, &data, pf->timestamp);
+
+		/* Unit quaternion K component. */
+		data = le16_to_cpu(cargo[17]);
+		iio_push_to_buffers_with_timestamp(iio_dev, &data, pf->timestamp);
+	}
+
+done:
+	iio_trigger_notify_done(iio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int bno08x_check_prod_id(struct bno08x_dev *bno08x)
+{
+	struct i2c_client *client = bno08x->client;
+	u8 cargo[BNO08x_SHTP_MAX_SIZE] = {};
+	u8 *data = cargo + BNO08x_SHTP_HDR_SIZE;
+	int ret;
+
+	data[0] = BNO08x_SHTP_PROD_ID_REQ;
+	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_CONTROL_CHAN, cargo, 2);
+	if (ret)
+		return ret;
+
+	while (true) {
+		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 20);
+		if (ret < 0) {
+			dev_dbg(&client->dev, "Failed to read PROD_ID: %d\n", ret);
+			return ret;
+		}
+
+		if (ret >= 20 && data[0] == BNO08x_SHTP_PROD_ID)
+			break;
+	}
+
+	dev_dbg(&client->dev, "FW version: 0x%x.%x\n", data[2], data[3]);
+
+	return 0;
+}
+
+static int bno08x_soft_reset(struct bno08x_dev *bno08x)
+{
+	struct i2c_client *client = bno08x->client;
+	u8 cargo[20] = {};
+	int ret;
+
+	/* Soft reset the device: write 0x01 to EXECUTABLE channel. */
+	cargo[BNO08x_SHTP_HDR_SIZE] = BNO08x_SHTP_SOFT_RESET;
+	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_EXECTUABLE_CHAN, cargo, 1);
+	if (ret) {
+		dev_err(&client->dev, "Failed to soft-reset BNO08x\n");
+		return ret;
+	}
+
+	/*
+	 * Now read the all the channel advertisments packets.
+	 * We don't care about the content.
+	 */
+	do {
+		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 0);
+		if (ret < 0) {
+			dev_dbg(&client->dev,
+				"Failed to read channel advertisments: %d\n", ret);
+			return ret;
+		}
+	} while (ret != 0);
+
+	/*
+	 * Give the chip some time to stabilize. There's no mention of any
+	 * delay required after startup in the manual, but this makes operation
+	 * stable through module load/unload.
+	 */
+	usleep_range(15000, 20000);
+
+	return 0;
+}
+
+static int bno08x_probe(struct i2c_client *client)
+{
+	struct bno08x_dev *bno08x;
+	struct iio_dev *iio_dev;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bno08x));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(&client->dev, iio_dev);
+
+	bno08x = iio_priv(iio_dev);
+	bno08x->client = client;
+
+	mutex_init(&bno08x->cargo.mutex);
+	init_completion(&bno08x->cargo_ready);
+	init_completion(&bno08x->waiters_done);
+
+	iio_dev->info = &bno08x_iio_info;
+	iio_dev->name = DRIVER_NAME;
+	iio_dev->channels = bno08x_iio_channels;
+	iio_dev->num_channels = ARRAY_SIZE(bno08x_iio_channels);
+	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, iio_dev,
+					      iio_pollfunc_store_time,
+					      bno08x_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	bno08x->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+					      DRIVER_NAME,
+					      iio_device_id(iio_dev));
+	if (!bno08x->trig)
+		return -ENOMEM;
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						bno08x_interrupt,
+						bno08x_dump_cargo,
+						IRQF_TRIGGER_FALLING,
+						iio_dev->name, iio_dev);
+		if (ret)
+			return ret;
+	}
+
+	bno08x->trig->dev.parent = &client->dev;
+	bno08x->trig->ops = &bno08x_trigger_ops;
+	iio_trigger_set_drvdata(bno08x->trig, iio_dev);
+
+	ret = devm_iio_trigger_register(&client->dev, bno08x->trig);
+	if (ret)
+		return ret;
+
+	iio_dev->trig = iio_trigger_get(bno08x->trig);
+
+	ret = bno08x_soft_reset(bno08x);
+	if (ret)
+		return ret;
+
+	bno08x_check_prod_id(bno08x);
+
+	return devm_iio_device_register(&client->dev, iio_dev);
+}
+
+static const struct of_device_id bno08x_of_match[] = {
+	{ .compatible = "ceva,bno08x" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bno08x_of_match);
+
+static struct i2c_driver bno08x_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(bno08x_of_match),
+	},
+	.probe_new = bno08x_probe,
+};
+module_i2c_driver(bno08x_driver);
+
+MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
+MODULE_DESCRIPTION("CEVA BNO08x IMU driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

