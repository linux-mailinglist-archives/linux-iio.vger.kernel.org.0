Return-Path: <linux-iio+bounces-14523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDAA18843
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 00:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B63A5704
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 23:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC71F76A7;
	Tue, 21 Jan 2025 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EJwmZneV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44BC1AA791
	for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501616; cv=none; b=JSlncTT4FfiYQh5QpKpQd6xDbC8cLtgfreTUMwb05O5uoHmsDNFaWowBWTd7kj+IiD7i89c7dAftziFL6BsdT0AZ3gt+TAqKvYwWkG2nnc4T1VJ6LRRCAVlbVsSvJmYvuj/0I/3XPsllfuUxo/4gQxGUdLK+ikhUGJ+YgHqYyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501616; c=relaxed/simple;
	bh=B201eLPZkT2oMJ2uSMIsQdhztppZVwE4sVtAqrz+xQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AG6mS7L2l0wuojowB+GJDL++ApAys90WJna8XUW+I38oWsUdc1l48UUzKEKLv1+wYu8Idkw3x1RuwPKZAsx43g6JQ0/tr06v0FXVw0UIuGkeLlJ3mezCGLgg1YgaEGarVCTqJQpFuJITjHVFSKvOo0rQNb72g7RzEu0gWzTkJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EJwmZneV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so8260468a91.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 15:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737501614; x=1738106414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oA2x6lnJzcpRtUOkOjHLHblxENU4F2c7jAaA1eggszc=;
        b=EJwmZneVL3PiU0HdwjT6O5O078ihNLU+XYmtWTFKiex3fNxDEialwCGNCzgCfg69sZ
         EosZmbvDudftFCwzHwopQcY6RmdxneryOJUW2mXtxcG1bWCZCgcxD3nu3Kmij6O3EkLY
         Ax/VwsUQ4h7paFFiGdiz4cwARbnQIReQxm8Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737501614; x=1738106414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oA2x6lnJzcpRtUOkOjHLHblxENU4F2c7jAaA1eggszc=;
        b=FXa6vt9NHB7X+w4YzbutfYl66R5Mw+Hgdz0j9qKLp6Rc1tEZesEgVSKkVvUfsM0F5u
         M3MuhacXMY9E+jmVuTMSSzKh+pXw/Q8v+bwruiRGx/yOSBQmi+wlhUzw0rED6UoaLrFz
         aWTn7qdpJSPc6k5IW5wr/SPiXjT5QsxyDtwuxRw3h1iPFpz63Wh4OPwXt1LNLgxFzb8l
         FGcW+NAhRw5srSjfgY6IDKnecBLCmz0Qj3Q2ok+hyti9A8EEahhA6GnDegFI7NB/Df+u
         ktPtKa18hFR422Sk2iNEOL/vg3pMVWMMtk1Z+/tsIHu7mD2MDCzm7JVa9LlpVy2k+b7T
         Fy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWv7EK3TvblXPK+TMo4PQJEvq5bSbR7X5DxRtHuf0gis++D3ETUqgcbXQz4VlSRm6XgsSZpgrEj3R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaaz1Uvfd6GPOhkRG4TKFDUACS5IlyI3V7to3AcNjayxxeFaG+
	E+gEIeADY85h8Y44GgPTXDvH7K5S6bBhsnK8nTqVJWNdERx+0TdqckV/8pCqtA==
X-Gm-Gg: ASbGncuEzMQfFhmCKQb/pWz517A/HN2eQ0K/sSSu1hvyHakVCtcHSM9POPSbf1hVyDB
	LdZ5wKi8VXipEsDLjIB4nrABekMNGFWSnvvkRs+ASubeUjHU753zXdaxrzHTKi6/0RJEFWUISyO
	rN8n+oVy/u75TNin87qS1+FDQhHs6TPu0wMAjJ66nBJcTBtLTt81JkEoYHuoIfF9zmh0+E/Uk+N
	gyYOGqCvjdXQjxWOh0jAKFH4Rxrws6yZGImxMcE0ZLyoWlkaBxbcVdI3xOO
X-Google-Smtp-Source: AGHT+IEP4wwPN4KB6qhIl3851K9UfBccKX4fxMInIUXZMJ9nzXFf9ipgVi4T8Ya1YKL+IQ7DpMSWag==
X-Received: by 2002:a17:90b:53c6:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-2f782cb4d32mr28847491a91.15.1737501614097;
        Tue, 21 Jan 2025 15:20:14 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:a0e:de32:8ec:623b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f7e6b73239sm56992a91.32.2025.01.21.15.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 15:20:13 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4] iio: cros_ec: Trace EC sensors command
Date: Tue, 21 Jan 2025 15:20:07 -0800
Message-ID: <20250121232007.1020666-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, add tracing for EC_CMD_MOTION_SENSE_CMD command:
- decode the name of the subcommand
- provide internal information for the most common sub-commands:
  setting range, frequency, EC probing frequency, ...
- display return status.

When enabled, the tracing output is similar to:
/sys/kernel/debug/tracing # echo 1 > events/cros_ec/enable ; echo 1 > tracing_on ; cat trace_pipe | grep MOTIONSENSE_CMD_SENSOR_ODR
 SensorDeviceImp-814     [003] .....   686.176782: cros_ec_motion_host_cmd: MOTIONSENSE_CMD_SENSOR_ODR, id: 1, data: 200000, result: 4, return: 12500

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes from v2 (https://patchwork.kernel.org/patch/13944028/):
- Fix include error, based on commit a98c75fcd0e ("drm/tegra: trace: Fix path to include")
Changes from v2 (https://patchwork.kernel.org/patch/13942819/):
- Improve casting
- Add intent of the patch in commit message.
Changes from v1 (https://patchwork.kernel.org/patch/13942368/):
- fix merging issue with iio.git/togreg.

 drivers/iio/common/cros_ec_sensors/Makefile   |  3 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  9 ++-
 .../cros_ec_sensors/cros_ec_sensors_trace.c   | 32 +++++++++++
 .../cros_ec_sensors/cros_ec_sensors_trace.h   | 56 +++++++++++++++++++
 4 files changed, 96 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h

diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index e0a33ab66d21..c358fa0328ab 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -3,6 +3,7 @@
 # Makefile for sensors seen through the ChromeOS EC sensor hub.
 #
 
-obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
+cros-ec-sensors-core-objs += cros_ec_sensors_core.o cros_ec_sensors_trace.o
+obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros-ec-sensors-core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 9fc71a73caa1..7751d6f69b12 100644
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
@@ -413,6 +415,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_register);
 int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 				 u16 opt_length)
 {
+	struct ec_response_motion_sense *resp = (struct ec_response_motion_sense *)state->msg->data;
 	int ret;
 
 	if (opt_length)
@@ -423,12 +426,12 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 	memcpy(state->msg->data, &state->param, sizeof(state->param));
 
 	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
+	trace_cros_ec_motion_host_cmd(&state->param, resp, ret);
 	if (ret < 0)
 		return ret;
 
-	if (ret &&
-	    state->resp != (struct ec_response_motion_sense *)state->msg->data)
-		memcpy(state->resp, state->msg->data, ret);
+	if (ret && state->resp != resp)
+		memcpy(state->resp, resp, ret);
 
 	return 0;
 }
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
new file mode 100644
index 000000000000..c4db949fa775
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
index 000000000000..8956f2e8ad08
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
+#define TRACE_INCLUDE_PATH ../../drivers/iio/common/cros_ec_sensors
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cros_ec_sensors_trace
+
+#include <trace/define_trace.h>
-- 
2.48.1.262.g85cc9f2d1e-goog


