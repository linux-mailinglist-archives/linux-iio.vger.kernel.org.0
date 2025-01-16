Return-Path: <linux-iio+bounces-14406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57811A14481
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 23:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87407188CF33
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C81DAC8D;
	Thu, 16 Jan 2025 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VvntlObW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5F1A8F95
	for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067027; cv=none; b=NF70EjB+5IrBzBDFHw3GmLacChQcaPhIzVtcFepe4ZmzEnVR3cp8tlDhDGNKikrcxk/JuZga8P1GZa4tHmZx+vX/favB8a6JPJksij0MlRXj7KctIbXXjZNqXivbJSZ8+SCuYwq3noPMU4iD98BEwzJj5XFGe6UvKyNCTbrTXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067027; c=relaxed/simple;
	bh=3ayTkP34D3D7R9mwnj6ooDEflroKDjjoUt1AvKuzIqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPD1kjFZQnmo6zunK9QxSxTwngaUV8JaHACKiV7kUWAKZX4xoI8c6uZW46Fy6j55n6dV79gc7RdaWVzAVFTRKirAnUkNY2SzYFOsfmk5RekazVor9T7jEk9mzYaISX7/kgiP7AnFLS2cn5D17S20N3V6Od/UEEchfURCCsFcgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VvntlObW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f44353649aso2118811a91.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737067025; x=1737671825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kHQHLF4WjiJVT9bX0MCHJSIo/L0684L7+TFbxInaWs=;
        b=VvntlObWbau4u2GUPErdmsw4jmkEFG+8jWpgwRlcKuA9ltaqv9B8uIeIn6qUr82f6F
         E7XgEZfRpY7UFwJMW/MLrLw3NAmOsqZE0mggwcfGNax3a64wSGBjrZ31bJmFlpgErmHi
         qGEl0XRxTHeFC388JGQLYNqa2fc2Lo6wtSqn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737067025; x=1737671825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kHQHLF4WjiJVT9bX0MCHJSIo/L0684L7+TFbxInaWs=;
        b=Eq47Mpyfg23fIVuzzXNuoxJl8ZOaXM1UDgI8BFL/n1UJscqWEziUFJEiW4457XoWM4
         46Apw6ZXzrgFxe4f2AQclGTRoaJepO4dBnaRdhCggwn3xkmZvShT9dx9Z5tJ5Bc/bDXT
         cpTi3goNVdy+DcIcmqKY03JxSadA8+5jKG7QGU6EuVz5QXnv6zBpi6S1Jt85WaqiB/ao
         pV7rZo5A42LU8CR8mA8S/+ix3ZFeghzSUtC+lgpFTKRde1a7ZBfKXKyUxH+39ASjAO+B
         /U5PRyZUkSPbvH49xkOF3JZhca9+goDVEBzg3J4eVAY6kwD4Ll4/Fg+gvzGHZbZFflYy
         gmdA==
X-Forwarded-Encrypted: i=1; AJvYcCVXuosO/p6YHElr0YNJy18R65t8e4awJu8lD/y45Oz+RayhME22Mo1hO12fxwcHrLzXGvEw9Xg86q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNpOPIoeas/YlFOSGyqQ4quO8Jqp7E71TlJJKmZJ5OyM5zMA5
	h2Y/v6mg33peZ/DtIVlXVcS6uAVmyH1T/9yOzEkCbO+tHo1Ai1jTka1pxOHflw==
X-Gm-Gg: ASbGnctyZxpiHSL5CUt6FKuRoNq9wtbEugmVhkOOIPZ0ODGVYIy2vK5RxAx8LZBclqB
	WP64+teFs+1WzEC83jNkGYNgcEhR3vjRrXuiJrlqEXIWxqGcts+r54mknZO6Ry0wBHyomsSU3ol
	AdANBgH1KZORpQvOS6R8UxdDPzUSIgd9YxgZbwkKJ+Bh/UBcF/WXMG2gWGezcqsXfQLFopQZSz9
	nwbunSTz1FW9Gg67eRnV/XlYp0I+YB1ddlZLVjjmMz9dQagRw==
X-Google-Smtp-Source: AGHT+IFkW1w7rX7rwb83Edc8SiwW7N1vI1nxzfLN9KMslhd8Sh/fGFMW8j7drhn2zXE9Xhf5pSS4OA==
X-Received: by 2002:a17:90a:c883:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-2f782d35addmr410146a91.28.1737067024633;
        Thu, 16 Jan 2025 14:37:04 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:df50:ca7a:4ac2:d31c])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f72c17f949sm4175678a91.17.2025.01.16.14.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 14:37:03 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec: Trace EC sensors command
Date: Thu, 16 Jan 2025 14:36:59 -0800
Message-ID: <20250116223659.555051-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tracing for EC_CMD_MOTION_SENSE_CMD command:
- decode the name of the subcommand
- provide internal information for the most common sub-commands:
  setting range, frequency, EC probing frequency, ...
- display return status.

When enabled, the tracing output is similar to:
/sys/kernel/debug/tracing # echo 1 > events/cros_ec/enable ; echo 1 > tracing_on ; cat trace_pipe | grep MOTIONSENSE_CMD_SENSOR_ODR
 SensorDeviceImp-814     [003] .....   686.176782: cros_ec_motion_host_cmd: MOTIONSENSE_CMD_SENSOR_ODR, id: 1, data: 200000, result: 4, return: 12500

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/Makefile   |  3 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  5 +-
 .../cros_ec_sensors/cros_ec_sensors_trace.c   | 32 +++++++++++
 .../cros_ec_sensors/cros_ec_sensors_trace.h   | 56 +++++++++++++++++++
 4 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h

diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index f62733014606e..7471882b44955 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -4,7 +4,8 @@
 #
 
 obj-$(CONFIG_IIO_CROS_EC_ACTIVITY) += cros_ec_activity.o
-obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
+cros-ec-sensors-core-objs += cros_ec_sensors_core.o cros_ec_sensors_trace.o
+obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros-ec-sensors-core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_SYNC) += cros_ec_sensors_sync.o
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index bf45bda20608b..8138aa61ab495 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -23,6 +23,8 @@
 #include <linux/platform_data/cros_ec_sensorhub.h>
 #include <linux/platform_device.h>
 
+#include "cros_ec_sensors_trace.h"
+
 /*
  * Hard coded to the first device to support sensor fifo.  The EC has a 2048
  * byte fifo and will trigger an interrupt when fifo is 2/3 full.
@@ -208,7 +210,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
 static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
 
 static const struct iio_dev_attr *cros_ec_sensor_fifo_attributes[] = {
-	&iio_dev_attr_hwfifo_flush,	
+	&iio_dev_attr_hwfifo_flush,
 	&iio_dev_attr_hwfifo_timeout,
 	&iio_dev_attr_hwfifo_watermark_max,
 	NULL,
@@ -461,6 +463,7 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 	memcpy(state->msg->data, &state->param, sizeof(state->param));
 
 	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
+	trace_cros_ec_motion_host_cmd(&state->param, (void *)state->msg->data, ret);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
new file mode 100644
index 0000000000000..c4db949fa7750
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+// Trace events for the ChromeOS Embedded Controller
+//
+// Copyright 2025 Google LLC.
+
+#define TRACE_SYMBOL(a) {a, #a}
+
+// Generate the list using the following script:
+// sed -n 's/^.*\(MOTIONSENSE_CMD.*\) = .*,$/\tTRACE_SYMBOL(\1), \\/p' include/linux/platform_data/cros_ec_commands.h
+#define MOTIONSENSE_CMDS \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_DUMP), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_INFO), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_EC_RATE), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_ODR), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_RANGE), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_KB_WAKE_ANGLE), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_DATA), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_INFO), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_FLUSH), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_READ), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_PERFORM_CALIB), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_OFFSET), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_LIST_ACTIVITIES), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_SET_ACTIVITY), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_LID_ANGLE), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_INT_ENABLE), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_SPOOF), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE), \
+	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_SCALE)
+
+#define CREATE_TRACE_POINTS
+#include "cros_ec_sensors_trace.h"
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h
new file mode 100644
index 0000000000000..61853e410e96c
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Trace events for the ChromeOS Embedded Controller
+ *
+ * Copyright 2025 Google LLC.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cros_ec
+
+#if !defined(_CROS_EC_SENSORS_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _CROS_EC_SENSORS_TRACE_H_
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(cros_ec_motion_host_cmd,
+	    TP_PROTO(struct ec_params_motion_sense *param,
+		     struct ec_response_motion_sense *resp,
+		     int retval),
+	    TP_ARGS(param, resp, retval),
+	    TP_STRUCT__entry(__field(uint8_t, cmd)
+			     __field(uint8_t, sensor_id)
+			     __field(uint32_t, data)
+			     __field(int, retval)
+			     __field(int32_t, ret)
+	    ),
+	    TP_fast_assign(__entry->cmd = param->cmd;
+			   __entry->sensor_id = param->sensor_odr.sensor_num;
+			   __entry->data = param->sensor_odr.data;
+			   __entry->retval = retval;
+			   __entry->ret = retval > 0 ? resp->sensor_odr.ret : -1;
+	    ),
+	    TP_printk("%s, id: %d, data: %u, result: %u, return: %d",
+		      __print_symbolic(__entry->cmd, MOTIONSENSE_CMDS),
+		      __entry->sensor_id,
+		      __entry->data,
+		      __entry->retval,
+		      __entry->ret)
+);
+
+#endif /* _CROS_EC_SENSORS_TRACE_H_ */
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cros_ec_sensors_trace
+
+#include <trace/define_trace.h>
-- 
2.48.0.rc2.279.g1de40edade-goog


