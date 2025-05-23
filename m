Return-Path: <linux-iio+bounces-19835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE3AAC2896
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F350B1BC283F
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6822A1CD;
	Fri, 23 May 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RL1Poex/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FF18C011
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021253; cv=none; b=g/DQrXwDV+dKVIHtCU4Dp+ixXJzGhfgyb5V3FlBwi5FQypi3R25DN6iDQ6dbs915AhNJvAvrLB+pl4bSFBbt4FElzAl5ilGaKN0jHPSkfKZah/zqLEUz9rkfIQheoU7GJVGwcLJU5HrbK2S/qlqSXyWQnOCmTTDtugEabrPbkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021253; c=relaxed/simple;
	bh=3PBtf5593esZj6mcSieMvlvIkBBZNkF9S2SDJqEhcWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sg6ZRNEb2j1/Ss3xbyuobpbQKHRe477Q1tZy5ufcnHtbJVSHRjjMnTvaZDNxyYDC6mgKAfahTRVbXBzj7kw56b0FxltZygshoYwOHwikLs5G89qYoCAqSffTjBJM+mOqy6M9plhTr1R+YlKDF53YEcBM5kjyBHGqT3QIohK8duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RL1Poex/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso247884b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748021251; x=1748626051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnTXQkQ/IwiFsHg1bgS1cTl8yz6IZ2jeydS+8JNTTxQ=;
        b=RL1Poex/C1NVzql2x3aso3Gq1TFSgAfd+VTtNO1U7BT6ceOGNOMbKYoC46sysxsfGT
         bZP46LwWSNIMXZnEQ8FLBcWpGSJBscLV7xMWmjsC+jYk03QG3cdE0vgQ0JJglUqdTVFR
         dn75bi/ELC6fZI4LOqz17vnZXXpc1pnsUuhIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748021251; x=1748626051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnTXQkQ/IwiFsHg1bgS1cTl8yz6IZ2jeydS+8JNTTxQ=;
        b=B9TCcAhInHEbp5bHtC6mLATGar0RUDYxyurYiYHOCcD++QsE644gBnFnw3lU7cMotU
         jpQVkDTUnGyA0mOjsVhpGplarjZXwr8O13VtpGAZ74BVQc64gYO33RFixGHNY7i6pcbX
         fDJF83zrHfXY2L62ir7twRqltyv0jpxGfjfu+KgWtPhOboG6itSaX6AKgAmqxUlPuKY2
         GgsduN5nfgA7zpK1EZXN2FCubTYOZHmaRKO9xpKo7XDvzjTdwlzPord39e1eNlpXShWa
         yoMZ7MkBesyhvQKEmzwLU84h2KnNxG/pgx68dB29zqRq4hfqCvSZjMbNIjVMOJ3U7VkW
         z3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqTxuV+r60oHC5zcnY0FZ3otOGz8ica3kfU6nqkHuzwU2QRXFMOQ2hscL4fVmgDod4kAz89RH00PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9DkZ2+CxQo/xS9sY0F5OdtNouGnYC+4qhpTGeALZQr2661UN
	UXCEi5hjVwSzWndkssiAXt1jlttE1cNhZeyJyYKxtdc/Uj/tnP9wAIQHMEy/mpuz4w==
X-Gm-Gg: ASbGncu+CaCeLElEbrnctYyCT4zb1SM8kZbSDqxHNQAaQcBPcE0gALajwX2GRvCn5eO
	jRetU86AoCclE97ak9fVjA7aL9CXt9+FOQsNhSnKIaC+7ArDw0DK/bIgxZGieY5Mw3V1dDwYS6Y
	o1LKK8D4VHW6SennpAPxGy4CSZ8qF4310QwVi+jD2h8LYbzPW47zAKCXjCbAiMEvchd4sr5Jm/W
	dL8C1xAIsHNqzDAR/YOuxRnAjzD1CTh+G9e6A3iJpDxY3kXv4JV+0mrBgPJJq1BMLbg7D2yrS3e
	he1PAsREeLpH4Wivs83Mci6Op7uXXU5Nz7v1mlxkPriq
X-Google-Smtp-Source: AGHT+IGrKji0Y4UatKZfhv7psyZEfvu8CHQogPPmuzRqO2Q85g4qbRpT3YG8+IR5tDQyxkh8oU9JnQ==
X-Received: by 2002:a05:6a21:4592:b0:1f5:8e54:9f10 with SMTP id adf61e73a8af0-2188c374058mr163026637.34.1748021251087;
        Fri, 23 May 2025 10:27:31 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c821:1bd0:93cd:80d7])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a9829ba8sm13088341b3a.110.2025.05.23.10.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:27:30 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
X-Google-Original-From: Gwendal Grignou <gwendal@google.com>
To: jic23@kernel.org,
	tzungbi@kernel.org
Cc: chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@google.com>
Subject: [PATCH v4] iio: cros_ec_sensors: add cros_ec_activity driver
Date: Fri, 23 May 2025 10:27:27 -0700
Message-ID: <20250523172727.2654957-1-gwendal@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ChromeOS EC can report activity information derived from the
accelerometer:
- Reports on-body/off-body as a proximity event.
- Reports significant motion as an activity event.

This new sensor is a virtual sensor, included only when the EC firmware
is compiled with the appropriate module.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes in v2:
- fix usage of cros_ec_motion_send_host_cmd
- use dev instead of &pdev->dev
- fix documentation errors.
Changes in v3:
- fix index increment at probe correctly
- prevent sending command on invalid inputs in
  cros_ec_write_event_config
Changes in v4:
- no need to continue setting command structure on error.

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 +
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../common/cros_ec_sensors/cros_ec_activity.c | 322 ++++++++++++++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  10 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 .../linux/platform_data/cros_ec_commands.h    |  36 +-
 6 files changed, 373 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index fefad9572790..394e319c9c97 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -30,3 +30,12 @@ config IIO_CROS_EC_SENSORS_LID_ANGLE
 	  convertible devices.
 	  This module is loaded when the EC can calculate the angle between the base
 	  and the lid.
+
+config IIO_CROS_EC_ACTIVITY
+	tristate "ChromeOS EC Activity Sensors"
+	depends on IIO_CROS_EC_SENSORS_CORE
+	help
+	  Module to handle activity events presented by the ChromeOS EC sensor hub.
+	  Activities can be a proximity detector (on body/off body detection)
+	  or a significant motion detector.
+	  Creates an IIO device to manage all activities.
diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index e0a33ab66d21..a7849c52f3c8 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -3,6 +3,7 @@
 # Makefile for sensors seen through the ChromeOS EC sensor hub.
 #
 
+obj-$(CONFIG_IIO_CROS_EC_ACTIVITY) += cros_ec_activity.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
new file mode 100644
index 000000000000..620203f7aa63
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cros_ec_activity - Driver for activities/gesture recognition.
+ *
+ * Copyright 2025 Google, Inc
+ *
+ * This driver uses the cros-ec interface to communicate with the ChromeOS
+ * EC about activity data. Accelerometer access is presented through iio sysfs.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+
+#include <linux/iio/common/cros_ec_sensors_core.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define DRV_NAME "cros-ec-activity"
+
+/* state data for ec_sensors iio driver. */
+struct cros_ec_sensors_state {
+	/* Shared by all sensors */
+	struct cros_ec_sensors_core_state core;
+
+	struct iio_chan_spec *channels;
+
+	int body_detection_channel_index;
+	int sig_motion_channel_index;
+};
+
+static const struct iio_event_spec cros_ec_activity_single_shot[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		/* significant motion trigger when we get out of still. */
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_event_spec cros_ec_body_detect_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static int ec_sensors_read(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->core.cmd_lock);
+	if (chan->type == IIO_PROXIMITY && mask == IIO_CHAN_INFO_RAW) {
+		st->core.param.cmd = MOTIONSENSE_CMD_GET_ACTIVITY;
+		st->core.param.get_activity.activity =
+			MOTIONSENSE_ACTIVITY_BODY_DETECTION;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret == 0) {
+			*val = st->core.resp->get_activity.state;
+			ret = IIO_VAL_INT;
+		}
+	} else {
+		ret = -EINVAL;
+	}
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static int cros_ec_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ACTIVITY && chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	mutex_lock(&st->core.cmd_lock);
+	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
+	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+	if (ret)
+		goto done;
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		ret = !!(st->core.resp->list_activities.enabled &
+			 (1 << MOTIONSENSE_ACTIVITY_BODY_DETECTION));
+		break;
+	case IIO_ACTIVITY:
+		if (chan->channel2 == IIO_MOD_STILL) {
+			ret = !!(st->core.resp->list_activities.enabled &
+				 (1 << MOTIONSENSE_ACTIVITY_SIG_MOTION));
+		} else {
+			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
+				 chan->channel2);
+			ret = -EINVAL;
+		}
+		break;
+	default:
+		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
+			 chan->type);
+		ret = -EINVAL;
+	}
+done:
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static int cros_ec_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&st->core.cmd_lock);
+	st->core.param.cmd = MOTIONSENSE_CMD_SET_ACTIVITY;
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		st->core.param.set_activity.activity =
+			MOTIONSENSE_ACTIVITY_BODY_DETECTION;
+		break;
+	case IIO_ACTIVITY:
+		if (chan->channel2 == IIO_MOD_STILL) {
+			st->core.param.set_activity.activity =
+				MOTIONSENSE_ACTIVITY_SIG_MOTION;
+		} else {
+			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
+				 chan->channel2);
+			ret = -EINVAL;
+		}
+		break;
+	default:
+		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
+			 chan->type);
+		ret = -EINVAL;
+	}
+	if (ret == 0) {
+		st->core.param.set_activity.enable = state;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+	}
+
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static int cros_ec_activity_push_data(struct iio_dev *indio_dev,
+				      s16 *data,
+				      s64 timestamp)
+{
+	struct ec_response_activity_data *activity_data =
+			(struct ec_response_activity_data *)data;
+	enum motionsensor_activity activity = activity_data->activity;
+	u8 state = activity_data->state;
+	const struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	const struct iio_event_spec *event;
+	enum iio_event_direction dir;
+	int index;
+	u64 ev;
+
+	switch (activity) {
+	case MOTIONSENSE_ACTIVITY_BODY_DETECTION:
+		index = st->body_detection_channel_index;
+		dir = state ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+		break;
+	case MOTIONSENSE_ACTIVITY_SIG_MOTION:
+		index = st->sig_motion_channel_index;
+		dir = IIO_EV_DIR_FALLING;
+		break;
+	default:
+		dev_warn(&indio_dev->dev, "Unknown activity: %d\n", activity);
+		return 0;
+	}
+	chan = &st->channels[index];
+	event = &chan->event_spec[0];
+
+	ev = IIO_UNMOD_EVENT_CODE(chan->type, index, event->type, dir);
+	iio_push_event(indio_dev, ev, timestamp);
+	return 0;
+}
+
+static irqreturn_t cros_ec_activity_capture(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	dev_warn(&indio_dev->dev, "%s: Not Expected\n", __func__);
+	return IRQ_NONE;
+}
+
+static const struct iio_info ec_sensors_info = {
+	.read_raw = &ec_sensors_read,
+	.read_event_config = cros_ec_read_event_config,
+	.write_event_config = cros_ec_write_event_config,
+};
+
+static int cros_ec_sensors_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_device *ec_device = dev_get_drvdata(dev->parent);
+	struct iio_dev *indio_dev;
+	struct cros_ec_sensors_state *st;
+	struct iio_chan_spec *channel;
+	unsigned long activities;
+	int i, index, ret, nb_activities;
+
+	if (!ec_device) {
+		dev_warn(dev, "No CROS EC device found.\n");
+		return -EINVAL;
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_activity_capture);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &ec_sensors_info;
+	st = iio_priv(indio_dev);
+	st->core.type = st->core.resp->info.type;
+	st->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
+
+	/*
+	 * List all available activities
+	 */
+	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
+	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+	if (ret)
+		return ret;
+	activities = st->core.resp->list_activities.enabled |
+		     st->core.resp->list_activities.disabled;
+	if (!activities)
+		return -ENODEV;
+
+	/* Allocate a channel per activity and one for timestamp */
+	nb_activities = hweight_long(activities) + 1;
+	st->channels = devm_kcalloc(dev, nb_activities,
+				    sizeof(*st->channels), GFP_KERNEL);
+	if (!st->channels)
+		return -ENOMEM;
+
+	channel = &st->channels[0];
+	index = 0;
+	for_each_set_bit(i, &activities, BITS_PER_LONG) {
+		/* List all available triggers */
+		if (i == MOTIONSENSE_ACTIVITY_BODY_DETECTION) {
+			channel->type = IIO_PROXIMITY;
+			channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+			channel->modified = 0;
+			channel->event_spec = cros_ec_body_detect_events;
+			channel->num_event_specs =
+				ARRAY_SIZE(cros_ec_body_detect_events);
+			st->body_detection_channel_index = index;
+		} else {
+			channel->type = IIO_ACTIVITY;
+			channel->modified = 1;
+			channel->event_spec = cros_ec_activity_single_shot;
+			channel->num_event_specs =
+				ARRAY_SIZE(cros_ec_activity_single_shot);
+			if (i == MOTIONSENSE_ACTIVITY_SIG_MOTION) {
+				channel->channel2 = IIO_MOD_STILL;
+				st->sig_motion_channel_index = index;
+			} else {
+				dev_warn(dev, "Unknown activity: %d\n", i);
+				continue;
+			}
+		}
+		channel->ext_info = cros_ec_sensors_limited_info;
+		channel->scan_index = index++;
+		channel++;
+	}
+
+	/* Timestamp */
+	channel->scan_index = index;
+	channel->type = IIO_TIMESTAMP;
+	channel->channel = -1;
+	channel->scan_type.sign = 's';
+	channel->scan_type.realbits = 64;
+	channel->scan_type.storagebits = 64;
+
+	indio_dev->channels = st->channels;
+	indio_dev->num_channels = index + 1;
+
+	return cros_ec_sensors_core_register(dev, indio_dev,
+					     cros_ec_activity_push_data);
+}
+
+static void cros_ec_sensors_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+
+	iio_device_unregister(indio_dev);
+}
+
+static struct platform_driver cros_ec_sensors_platform_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+	},
+	.probe		= cros_ec_sensors_probe,
+	.remove		= cros_ec_sensors_remove,
+};
+module_platform_driver(cros_ec_sensors_platform_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC activity sensors driver");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 64bada1e8678..1bd07ca3abfe 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -489,6 +489,16 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
 
+const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] = {
+	{
+		.name = "id",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_id
+	},
+	{ },
+};
+EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
+
 /**
  * cros_ec_sensors_idx_to_reg - convert index into offset in shared memory
  * @st:		pointer to state information for device
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index e72167b96d27..bb966abcde53 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -126,5 +126,6 @@ extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
 
 /* List of extended channel specification for all sensors. */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
+extern const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[];
 
 #endif  /* __CROS_EC_SENSORS_CORE_H */
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ecf290a0c98f..0f6d53e7cb97 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -2388,6 +2388,12 @@ enum motionsense_command {
 	 */
 	MOTIONSENSE_CMD_SENSOR_SCALE = 18,
 
+	/*
+	 * Activity management
+	 * Retrieve current status of given activity.
+	 */
+	MOTIONSENSE_CMD_GET_ACTIVITY = 20,
+
 	/* Number of motionsense sub-commands. */
 	MOTIONSENSE_NUM_CMDS
 };
@@ -2447,6 +2453,11 @@ enum motionsensor_orientation {
 	MOTIONSENSE_ORIENTATION_UNKNOWN = 4,
 };
 
+struct ec_response_activity_data {
+	uint8_t activity; /* motionsensor_activity */
+	uint8_t state;
+} __ec_todo_packed;
+
 struct ec_response_motion_sensor_data {
 	/* Flags for each sensor. */
 	uint8_t flags;
@@ -2454,15 +2465,14 @@ struct ec_response_motion_sensor_data {
 	uint8_t sensor_num;
 	/* Each sensor is up to 3-axis. */
 	union {
-		int16_t             data[3];
+		int16_t                                  data[3];
 		struct __ec_todo_packed {
-			uint16_t    reserved;
-			uint32_t    timestamp;
+			uint16_t                         reserved;
+			uint32_t                         timestamp;
 		};
 		struct __ec_todo_unpacked {
-			uint8_t     activity; /* motionsensor_activity */
-			uint8_t     state;
-			int16_t     add_info[2];
+			struct ec_response_activity_data activity_data;
+			int16_t                          add_info[2];
 		};
 	};
 } __ec_todo_packed;
@@ -2494,6 +2504,7 @@ enum motionsensor_activity {
 	MOTIONSENSE_ACTIVITY_SIG_MOTION = 1,
 	MOTIONSENSE_ACTIVITY_DOUBLE_TAP = 2,
 	MOTIONSENSE_ACTIVITY_ORIENTATION = 3,
+	MOTIONSENSE_ACTIVITY_BODY_DETECTION = 4,
 };
 
 struct ec_motion_sense_activity {
@@ -2671,6 +2682,7 @@ struct ec_params_motion_sense {
 			uint32_t max_data_vector;
 		} fifo_read;
 
+		/* Used for MOTIONSENSE_CMD_SET_ACTIVITY */
 		struct ec_motion_sense_activity set_activity;
 
 		/* Used for MOTIONSENSE_CMD_LID_ANGLE */
@@ -2716,6 +2728,14 @@ struct ec_params_motion_sense {
 			 */
 			int16_t hys_degree;
 		} tablet_mode_threshold;
+
+		/*
+		 * Used for MOTIONSENSE_CMD_GET_ACTIVITY.
+		 */
+		struct __ec_todo_unpacked {
+			uint8_t sensor_num;
+			uint8_t activity;  /* enum motionsensor_activity */
+		} get_activity;
 	};
 } __ec_todo_packed;
 
@@ -2833,6 +2853,10 @@ struct ec_response_motion_sense {
 			uint16_t hys_degree;
 		} tablet_mode_threshold;
 
+		/* USED for MOTIONSENSE_CMD_GET_ACTIVITY. */
+		struct __ec_todo_unpacked {
+			uint8_t     state;
+		} get_activity;
 	};
 } __ec_todo_packed;
 
-- 
2.49.0.1151.ga128411c76-goog


