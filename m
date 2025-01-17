Return-Path: <linux-iio+bounces-14407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF5A148D7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 05:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75A216B388
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 04:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F4F1F63E8;
	Fri, 17 Jan 2025 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbC3V2pW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426D8C11
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737087668; cv=none; b=tI5rXUzuMttHN8oTe5VFUqw3vCnk1TC320Ey+KogJqLb0ewRzM788GpYKXCzOUADjxKSXLrFBwX86jkYFyvHHQC0AjSDp/kAKe8Y9E5U3Rb1ZWbD55pop+IlDSqrdnkd12kF3Zh1PCj0U3cUFhAFj9cnUprR6h1cuij2kHHRdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737087668; c=relaxed/simple;
	bh=9pCAwJhQj0U5Ra7wX3UDkc9Z6oqkUQVopI76ZvSEvRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxScgiMxQNQAxKoPibwSsiBilCxKCvVKnQmKG8WPzP9ILdtXTdZVyv3rvBhulsKf+2hFVgo1ZMtTLjHBIU4ZW0krwwhm+r4HWF/Kl04MHwbwqiqbyEjtbRmfytQW0+ZMrI7PJ12EVw9OgY/tCxgxeg/IOIoViHuc+htBrsyOBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RbC3V2pW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2162c0f6a39so54208635ad.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 20:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737087664; x=1737692464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxwOy31LDFzGoC4ZmJ98AYc/8WB0Danggi82zdhIrPw=;
        b=RbC3V2pWHVLpX+1fJVw/Sre+mIRpoqGfpI78hnqBfvF1D0HaAx3vfWzid5NeFhH9Pq
         twJBxxhSR39G75C2PzH5q9f76mTHnMHnBeVhIqnYt7+9lwv2bb293VROmt5xFq8JBFTZ
         PxY8iyhGVGB2CB6McLHn4dYl4A/Z8qk8E0fqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737087664; x=1737692464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxwOy31LDFzGoC4ZmJ98AYc/8WB0Danggi82zdhIrPw=;
        b=DPNxHWpDY3Q9s9+6QFBSYkvIS91vlWji6lA0lqygXs59tbUymwotqEyC25y+n/0AQU
         PherknNhCkqc+1AkAXiswMUs2N15hhpS3SPiIOEAt4XTRJpNNQv11mWvpvKnpGRy8k3L
         ORS3BzITl2OdylDuaHdN9GHffYIRV3gO2CFtgyntbWxsWkb6pf3haJfCIt04XLjvQzQv
         Ed5DytsNk9YhaiKJZXaUlkl1zMezBKXdvxMla+fzK6/i5CSW60OBnVc+V+3RaxQSOcsL
         mFXMr7j1hRRnA4RbjFKQB0sVYHe/ijXT5WIcYuBH1EebY1c2uDOkht1Emn318puUTnto
         cDyA==
X-Forwarded-Encrypted: i=1; AJvYcCUrrkq0CE641Xrt2yF9NTlmYC5N6q2SvSReL1xSDegBA4gyGCXMxG3UzVStnd2Q5foOxLM90XM4/50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxctJcDALGFzx7xubZzasz4B20epeWRIc60fRxf0hF2lrXZ8nK
	DH0e7mmDLzgBf1o3zwg/Khf+ZgfSpZLJdl61oycrKgkvNsS4JtM2O4QbipeFmHH36yT9HDVD1v0
	=
X-Gm-Gg: ASbGnctOVnur4OqpIfqq/VGvEZgpHuICcdFT2GurXjcZ3AD4NCgUkPkUrv5FdVyXZAP
	FiWEYEsODydcUfmmoMyOlhjzI3EMNQxgC56VQGrzthNjC3O4geEMfdfcWTX3C1XAKrFzVkONCT5
	SkGkAYq/NFiIDWArGI2jBsPUFDDhiIAYB09A7vRHvwkyd14rtklrHTb7QzxENzDS0lewbu2LtWY
	d6/+0EtEHlp02FAxg3Tt1cRMSEJK9Vt9LF9cnaPE9drU4eYhQ==
X-Google-Smtp-Source: AGHT+IFudkJ6+DRbcTOt+Hy7vDEREhQFHCA1wq1hBYFNVrEh4o0U0FyvisZjLLJH5yJKVqdtxOu2aw==
X-Received: by 2002:a05:6a20:4389:b0:1e6:50a0:f982 with SMTP id adf61e73a8af0-1eb025edd0fmr15234994637.20.1737087663911;
        Thu, 16 Jan 2025 20:21:03 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:df50:ca7a:4ac2:d31c])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a9bdf57de17sm828928a12.77.2025.01.16.20.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 20:21:03 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros_ec: Trace EC sensors command
Date: Thu, 16 Jan 2025 20:20:59 -0800
Message-ID: <20250117042059.778637-1-gwendal@chromium.org>
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
Changes from v1 (https://patchwork.kernel.org/patch/13942368/):
- fix merging issue with iio.git/togreg.

 drivers/iio/common/cros_ec_sensors/Makefile   |  3 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  3 +
 .../cros_ec_sensors/cros_ec_sensors_trace.c   | 32 +++++++++++
 .../cros_ec_sensors/cros_ec_sensors_trace.h   | 56 +++++++++++++++++++
 4 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h

diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index e0a33ab66d21a..c358fa0328abd 100644
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
index 9fc71a73caa12..075196ca804a1 100644
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
@@ -423,6 +425,7 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
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


