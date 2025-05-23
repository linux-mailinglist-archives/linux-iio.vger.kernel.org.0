Return-Path: <linux-iio+bounces-19816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08622AC1A5E
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 05:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244283A5F9F
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 03:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3B204C2E;
	Fri, 23 May 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vtbqe0Lr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732122DCBE7
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970336; cv=none; b=TyM3QryiRs5Ux8ra7W+f7XuGEFKnqbiosyYU3bGuiekB+f/jquFrlYSYRNX+d1jIgVmAgDb1jCrHAHsd9sDfP92RFRR8JjpiUi+3mzETQzvE1zK2uDT7LHT6y9gktmp8e02ZQWVlkFMOr4tfp9wajRBuK5nlBIljX/SaaSPxR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970336; c=relaxed/simple;
	bh=n7iHH6kLegeKEwVg4kGIs6f0z3kf295vF7GG7C3ECTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxmCQU+aVaSdHUVtR02O5PLJIe7rwXrC+3BC1NE3xPI8vrYKMCjDOUb3uwxxTuAfo286ZNOfsxuB0nDKTfFUieycDrbCNCRFTj6b2incOdZj557k+TS3ZeCcqEoapCDpMKaXxJZVMxF6F7NMuG0fcvNCekGhWpY3jK36J81BMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vtbqe0Lr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74267c68c11so7501525b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747970334; x=1748575134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmfj5iX/wnDWoTqfobQbsj/fkX5ilaaGEhvWEthbsDE=;
        b=Vtbqe0LrQEwMM6E3qT5VvkcVrr2MbZki+ZJE6wrSMX+izBmjr/AKXQ1aF+nGbrQrms
         6dgSVorui6hb1OTd55iEMh4cy1HK14DvsPngZWTQX14Aaf3O1xtUbwxqHWRkcACiQQPi
         nEIS52/T9dYFbI16msPA/bJkMuPXE99EHmGZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747970334; x=1748575134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmfj5iX/wnDWoTqfobQbsj/fkX5ilaaGEhvWEthbsDE=;
        b=O0sTdpv3A6imCa7MGB6NVlQ6sZ1PIiHrzjeDfZ20aLWPVL0+Jz2ElJArpPwV17qfFY
         11xsJtCHrJ5wiBwh7q5u+gp6qBx0/VJz+0j0+8nlozJz3EB9Zv4hIs0Yjblv+ZqF+hct
         v2VxBsPux/YkXFUTlU45sM15YqXtgmczWaJSbZSkc2aeJx2mMW8Zvtiz2AkZ6o30kLhW
         j/xb5VCKsfwkb1SzWvEtAekMpXEaZSiAOZj0OI1Y/2xNmyao2RifYaf4DYrobmTJVcTR
         4FmOesbEQgndYzVzUqG7+sv6fZqjoUz1zytiow7X9sj7TAFuhnEGOGeMe2tKapn27Ucj
         MAWg==
X-Forwarded-Encrypted: i=1; AJvYcCUHp1n3GivuvAAuF8Y6sbOi2yndQSjVZTllHge4VClwkvH/KP4iD9YyqdD2JspnWEKS2uKrR1lLhdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoV/kA5h9k/LbV1KTVvezuNeX79D5jls9o0hcYN5EFl3U/CtVl
	OY88AYpH47C2qPthihDqSDMcHFtkqnv/GuGr9+3FpkvF/kBUAxSd8qg+4gUEGZkmRw==
X-Gm-Gg: ASbGnctr6fkQogPGKMX2RPzwBhHRaU1QokI/igm69NzKUU/QIIVfR5dKaeKvWd00UK2
	o4J11+iAbZlioqFNx5SE50X6g+TV4fNdM6CT0ywSpvW/Q8lergaieX6f2dhmvHxlej7mIrPA8d8
	Cvap/SdsheuiyrplE77KEuXa8tyf4G7HmldhiX3NWCQT1XXLxWjNn4jQJt/c+y/mZKjcCGZKOdP
	EBbpMJmiMZgf0ICRYsI3OO6NgRmC2Ckm0pojcURt+o7Vvi3fSNYYKMwY9b8Nm+SXE0mCSexFEnE
	H+FGb1s2jJuajfwG4WuAr4l/4ue2kRXRBl3VTO239rBK
X-Google-Smtp-Source: AGHT+IGeov2K5H+PlulUj6C5SHP6TTB84TE5LNKZ7n3F630VqXwbuNgVpMjCmm7ozRPF2BHnSt0HuQ==
X-Received: by 2002:a05:6a20:1591:b0:1f3:41d5:65f6 with SMTP id adf61e73a8af0-2170cdf19d6mr48275435637.32.1747970333576;
        Thu, 22 May 2025 20:18:53 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c821:1bd0:93cd:80d7])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a982b88fsm12351783b3a.103.2025.05.22.20.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 20:18:52 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
X-Google-Original-From: Gwendal Grignou <gwendal@google.com>
To: jic23@kernel.org,
	tzungbi@kernel.org
Cc: chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@google.com>
Subject: [PATCH v3] iio: cros_ec_sensors: add cros_ec_activity driver
Date: Thu, 22 May 2025 20:18:49 -0700
Message-ID: <20250523031849.1479851-1-gwendal@google.com>
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
---
Changes in v2:
- fix usage of cros_ec_motion_send_host_cmd
- use dev instead of &pdev->dev
- fix documentation errors.
Changes in v3:
- fix index increment at probe correctly
- prevent sending command on invalid inputs in
  cros_ec_write_event_config

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 +
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../common/cros_ec_sensors/cros_ec_activity.c | 321 ++++++++++++++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  10 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 .../linux/platform_data/cros_ec_commands.h    |  36 +-
 6 files changed, 372 insertions(+), 6 deletions(-)
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
index 000000000000..d253fca42d8c
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
@@ -0,0 +1,321 @@
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
+	st->core.param.set_activity.enable = state;
+	if (ret == 0)
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
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


