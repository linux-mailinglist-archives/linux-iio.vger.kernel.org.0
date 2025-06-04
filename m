Return-Path: <linux-iio+bounces-20198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F6ACD782
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 07:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A27A2006
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A72C3251;
	Wed,  4 Jun 2025 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBq9howm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7A236A8B
	for <linux-iio@vger.kernel.org>; Wed,  4 Jun 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749015549; cv=none; b=bqcuX7IWLWHbNQHiPZQ3cGpj1wdSlT79nfjcD61ZDCcE5i1fO1qhL730GNaqW2yKy6zVEvRrmXkZWi1wCIKu2NYdSAq3sEfAvjKfwWGxXmJ4lSMckmBU1HqRZreoJg/VmzEEaqrR/5KHooCrZS+VIBYB/mtp9+ONsnqUVSgqjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749015549; c=relaxed/simple;
	bh=Wtfaq38hg95A+CliJIHprQIRhSEw6OHoJm347eAQp1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUh2Xu972wazZKh28LVGSIv+Jabg+Dc4Kzu0bkdBbGzTkRdsS8mpXAneFQWD6fgq3rw2dn9dCVUgNTjBIJLiHHwr0vMY4nEIyCvGasBPYAPOUR76CQ2hBPV+0zD29maedGvC7xk29rUJ1NE1Eze0cCK+TJCgPI4iuA9bnZva21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nBq9howm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so51094845ad.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749015547; x=1749620347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFCoUkgJ2rAYAoU5LaItDMDnxARIg8iglqhJF0zJvwA=;
        b=nBq9howm3MPMASBFvYDMtmF7Ks4/2FploV4o3vgWDSvlXT70ut5fbkwlY/lrlLeeX2
         LmwCCidHMp/I0JNysALJCFJol+v6fCILy3U3QdweGW+5Tmr8muMFi2wfYvmVP+LSepvB
         1Fr9RDKhlfm7vVGEOCpo0Y7Vsq8CZfH07qSoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749015547; x=1749620347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFCoUkgJ2rAYAoU5LaItDMDnxARIg8iglqhJF0zJvwA=;
        b=xDns9D/FW0+MAOlj9yXBedseY0TE5eryFsZ+9X0vEijKTwf0RqLUJDL7cZNecraNCZ
         Cddba/1ICvx+9IK4z7D85dyme6iU/FX7eF2HlFtfYLNx9/WEYbW9SXl3RecthpF0PjgW
         e/zaQbgLZWFiyFrzNJuk0DDxILzwfI6SzcK1C0S7fTfuo0QfPCfZhc6PTIiZfdwYSlbP
         xSdeWQKzWEADhhntSzwdTHodseymyJEomaxqT3x6sf3lzuZeyEnwbAKx3Jhc4Wie+aZm
         KcWGgmqSrGucl+UaEkHHu1oRLeBOIAV5B7HXAfRUHVQ1uUfROgOicydVcap/TPuMbttA
         drIg==
X-Forwarded-Encrypted: i=1; AJvYcCWepTff4JOLW9RQUDYnSYi0MZQ7CSQ+D0wLnpHOjOhMTgRlzirneXwXx8W5nGCuP2Cb1lZH0UVnWfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3Vv3jJJEl1Y+xA8sJQnMS6v9dLbJPktON/sHNHza+y2QVbJ7
	6HYMWcRgx0hpltwOuohowb/T1uQ6v3Zc7URDfoe7MX+AIbbYCIASKTXWuNHNPT5Qtw==
X-Gm-Gg: ASbGncunAo1PWSSs3VercQf1EA7UY/BAzYqHO5Lc9N30r5v4F94bU/F8w+qdJWpXyUP
	TxkX5iBbqkCWX7eU+QdullB/nLL0PyvJCr12xuf0kw5ROyytdRo1gsmQGuF6ViofZNdKvRSg+/j
	4vp4geO8tEQaG52xqqJp0g80PutexH1IZ68Rh/ZAUmH3h7hHl0OqXDMYWfLWGx5qTsFaimTBkpE
	TeXUP/belsEgS06qJZ8ZZbpYx5gA15M//YgiuYYwjVH51/JCIQAK9CoZL24xGW5Ic/rtirv007t
	F/ZsXpXdbixg7wMaQbfvT3hUJiwKRCgrA4eVqlrOMyXU
X-Google-Smtp-Source: AGHT+IFZQU69kF4ZCwLZ50kcAw1W2dCpbdyj/nKBsokaE07IUcufHwNTuB1L4uuzY5HI53XKXHuHgw==
X-Received: by 2002:a17:90b:2548:b0:313:b78:dc14 with SMTP id 98e67ed59e1d1-3130c9b3dfamr3177129a91.0.1749015546813;
        Tue, 03 Jun 2025 22:39:06 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:4bc8:1390:d213:78bf])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506d14a9csm96145225ad.237.2025.06.03.22.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 22:39:06 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
X-Google-Original-From: Gwendal Grignou <gwendal@google.com>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@google.com>
Subject: [PATCH v5] iio: cros_ec_sensors: add cros_ec_activity driver
Date: Tue,  3 Jun 2025 22:39:03 -0700
Message-ID: <20250604053903.1376465-1-gwendal@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
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
Changes in v5:
- Use guard(mutex), simplify error path.
- Use driver name as function prefix.
- Remove cros_ec_sensors_remove function.
- Remove identation of structure field.
- Invert raw value to return 1m when far, 0m when close.

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 +
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../common/cros_ec_sensors/cros_ec_activity.c | 307 ++++++++++++++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  12 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 .../linux/platform_data/cros_ec_commands.h    |  26 +-
 6 files changed, 353 insertions(+), 3 deletions(-)
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
index 000000000000..de8890b2a454
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cros_ec_activity - Driver for activities/gesture recognition.
+ *
+ * Copyright 2025 Google, Inc
+ *
+ * This driver uses the cros-ec interface to communicate with the ChromeOS
+ * EC about activity data.
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
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
+static int cros_ec_activity_sensors_read_raw(struct iio_dev *indio_dev,
+					     struct iio_chan_spec const *chan,
+					     int *val, int *val2, long mask)
+{
+	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_PROXIMITY || mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	guard(mutex)(&st->core.cmd_lock);
+	st->core.param.cmd = MOTIONSENSE_CMD_GET_ACTIVITY;
+	st->core.param.get_activity.activity =
+		MOTIONSENSE_ACTIVITY_BODY_DETECTION;
+	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * EC actually report if a body is near (1) or far (0).
+	 * Units for proximity sensor after scale is in meter,
+	 * so invert the result to return 0m when near and 1m when far.
+	 */
+	*val = !st->core.resp->get_activity.state;
+	return IIO_VAL_INT;
+}
+
+static int cros_ec_activity_read_event_config(struct iio_dev *indio_dev,
+					      const struct iio_chan_spec *chan,
+					      enum iio_event_type type,
+					      enum iio_event_direction dir)
+{
+	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ACTIVITY && chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	guard(mutex)(&st->core.cmd_lock);
+	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
+	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+	if (ret)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return !!(st->core.resp->list_activities.enabled &
+			 (1 << MOTIONSENSE_ACTIVITY_BODY_DETECTION));
+	case IIO_ACTIVITY:
+		if (chan->channel2 == IIO_MOD_STILL) {
+			return !!(st->core.resp->list_activities.enabled &
+				 (1 << MOTIONSENSE_ACTIVITY_SIG_MOTION));
+		} else {
+			dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
+				 chan->channel2);
+			return -EINVAL;
+		}
+	default:
+		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
+			 chan->type);
+		return -EINVAL;
+	}
+}
+
+static int cros_ec_activity_write_event_config(struct iio_dev *indio_dev,
+					       const struct iio_chan_spec *chan,
+					       enum iio_event_type type,
+					       enum iio_event_direction dir,
+					       int state)
+{
+	struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->core.cmd_lock);
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
+			break;
+		}
+		dev_warn(&indio_dev->dev, "Unknown activity: %d\n",
+			 chan->channel2);
+		return -EINVAL;
+	default:
+		dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
+			 chan->type);
+		return -EINVAL;
+	}
+	st->core.param.set_activity.enable = state;
+	return cros_ec_motion_send_host_cmd(&st->core, 0);
+}
+
+static int cros_ec_activity_push_data(struct iio_dev *indio_dev,
+				      s16 *data, s64 timestamp)
+{
+	struct ec_response_activity_data *activity_data =
+			(struct ec_response_activity_data *)data;
+	enum motionsensor_activity activity = activity_data->activity;
+	u8 state = activity_data->state;
+	const struct cros_ec_sensors_state *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	enum iio_event_direction dir;
+	int index;
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
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(chan->type, index, chan->event_spec[0].type, dir),
+		       timestamp);
+	return 0;
+}
+
+static irqreturn_t cros_ec_activity_capture(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	/*
+	 * This callback would be called when a software trigger is
+	 * used. But when this virtual sensor is present, it is guaranteed
+	 * the sensor hub is advanced enough to not need a software trigger.
+	 */
+	dev_warn(&indio_dev->dev, "%s: Not Expected\n", __func__);
+	return IRQ_NONE;
+}
+
+static const struct iio_info ec_sensors_info = {
+	.read_raw = &cros_ec_activity_sensors_read_raw,
+	.read_event_config = cros_ec_activity_read_event_config,
+	.write_event_config = cros_ec_activity_write_event_config,
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
+	st->core.param.cmd = MOTIONSENSE_CMD_LIST_ACTIVITIES;
+	ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+	if (ret)
+		return ret;
+
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
+static struct platform_driver cros_ec_sensors_platform_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+	},
+	.probe		= cros_ec_sensors_probe,
+};
+module_platform_driver(cros_ec_sensors_platform_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC activity sensors driver");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 64bada1e8678..a47b0cd26bf5 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -485,10 +485,20 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 		.shared = IIO_SHARED_BY_ALL,
 		.read = cros_ec_sensors_id
 	},
-	{ },
+	{ }
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
 
+const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] = {
+	{
+		.name = "id",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_id
+	},
+	{ }
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
index ecf290a0c98f..c969d74a51c0 100644
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
@@ -2460,8 +2471,7 @@ struct ec_response_motion_sensor_data {
 			uint32_t    timestamp;
 		};
 		struct __ec_todo_unpacked {
-			uint8_t     activity; /* motionsensor_activity */
-			uint8_t     state;
+			struct ec_response_activity_data activity_data;
 			int16_t     add_info[2];
 		};
 	};
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
@@ -2716,6 +2728,12 @@ struct ec_params_motion_sense {
 			 */
 			int16_t hys_degree;
 		} tablet_mode_threshold;
+
+		/* Used for MOTIONSENSE_CMD_GET_ACTIVITY */
+		struct __ec_todo_unpacked {
+			uint8_t sensor_num;
+			uint8_t activity;  /* enum motionsensor_activity */
+		} get_activity;
 	};
 } __ec_todo_packed;
 
@@ -2833,6 +2851,10 @@ struct ec_response_motion_sense {
 			uint16_t hys_degree;
 		} tablet_mode_threshold;
 
+		/* USED for MOTIONSENSE_CMD_GET_ACTIVITY. */
+		struct __ec_todo_unpacked {
+			uint8_t     state;
+		} get_activity;
 	};
 } __ec_todo_packed;
 
-- 
2.49.0.1204.g71687c7c1d-goog


