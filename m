Return-Path: <linux-iio+bounces-14439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46442A159C3
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 00:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6810B1682D1
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E71D8DFE;
	Fri, 17 Jan 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RI9lbNmI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEB1BE87B
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154902; cv=none; b=pNrTe0lzktQaW4ywqAc+Bvoo3Y+AeJGqofpZXPZ8bznMRB5LOHS3p8meEcxCNUcVUwDcmVl1oZFnvg7b6M2QZGn8zJH9eFczSsbkztRdoZpIztD+59ft78Cwscxoh2TLj1juhHkXWq5c/qmyX4mRjXSW3abyWCeNOZ29/Q46pNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154902; c=relaxed/simple;
	bh=FGjn73QrJvL0b1BuH+LgIaJLPj8GU/SOOCFGkP7kM9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/Sb7MnCEiIKu2/Q6B7iG8AJeFYD9nVniTnZ10r+/Sf5W0+AArlcv9Q0zaeNR9jMUeHONoTaAqV/h8kwI9mFV48G1lRAdTGPpX0K4qhH0LexT2tXoUl5dvlCbcHty4/hNgdiVAPKslgq7YjRheWOQsgtz0+HuviZ+axbIBJVRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RI9lbNmI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso3848130a91.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 15:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737154900; x=1737759700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+SSlZh/8HbbWAdFopf4WfamCtabmCJfU5y+DZmi+ug=;
        b=RI9lbNmI4GMk3zcRXngnRIHlhQGXhPu4jzH7OQvkhUir0EAuykpDEaIQhZjVg+fx1S
         7hHGA4P9qfNDA+SKXlgbPBqsBrr7lB1Q4O+og/GSHZeyw3n+LmzwSuD6yVfyaXuhUk3J
         JTBf0m+wwlcOeyoFqL/4khBOwBhBn9SkuwjVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737154900; x=1737759700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+SSlZh/8HbbWAdFopf4WfamCtabmCJfU5y+DZmi+ug=;
        b=ikHEwyxYoEZsafLqXKBtDrmZ+P6/jpmbX3T6tEDCKSHBioVblKyN46tgiN3wFgyNWy
         lhnYbbCZZb4lOJMxx2capus/DcYiSj2gLShYCAG3H/tm6uOw4JACJ36mh/F5gxwiRnuG
         lb8Hg4/fNBPXRJBoPZynQnj3gqg8PGuLp+lHboMKakdjFOW3ahOyLQ1Hn/5KG4hBCk6e
         Hmh3mlKznG3gUWpzPgncp3ShygFJRSHcWj6zymmwjqG7/tOtZmYPeIGyscc95TsmIp6f
         XzJf9KdtuMDVo5e8gJAw9tePzWN1Ww7uwAHP3Y/yP0T6PCVeF0fYKF8WboIPVFaSgXaO
         1drw==
X-Forwarded-Encrypted: i=1; AJvYcCWdKE80WLUHWiZXT7nWpFm0WIOHpXJSHX2t1ezpucM854ZUz2pmPszf8BQKFm7IPtUHuiETXTzdVEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKphsYKh1AZl3Lf2VXyvLMTXpkb4owCo/Zd3g1TVeNFDnmV82
	qArOOyLoNtMXXBbcNPelOPr36CfbxDsQFr8ooKp/uMiTRPu2SOrkaTY8hAnwW7OJbyrU34wLXSQ
	=
X-Gm-Gg: ASbGnctyLgZMGG9bdJc2j9JuEAfp/YtXta2rf1wnXUu9u4Aq4m69EybIIkQOAl4tgU/
	DdeW08glZ5hcs0C6MzYVdcv3ZjfBP/EQWpuAe81hng70vZg0mk9LcIYVRfQyZ1gIlze0/22JeSp
	FuN0jJJTKIm5dMUNwwC6uhRflaoe7EAHpzVL+mvORzANpUup1/1mnHDm7Nc2PpQXzuLvsRNHMWF
	bgvGNVYJMbrwtot6eFINWkdVyF9anATG0HaV8cHk/xrGWvU/w==
X-Google-Smtp-Source: AGHT+IGN/mU50gpZC1GZvR+UQWm9v4NN3YpRdZTJvnQeROAqbDDpBhI7wcElCwpsUN1Vzz0MhwamgQ==
X-Received: by 2002:a17:90b:53c7:b0:2ee:c4f2:a77d with SMTP id 98e67ed59e1d1-2f782c9d45fmr5612297a91.21.1737154900308;
        Fri, 17 Jan 2025 15:01:40 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:4ccc:4bc2:7161:207c])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f77611aae8sm2681018a91.9.2025.01.17.15.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 15:01:39 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] iio: cros_ec: Trace EC sensors command
Date: Fri, 17 Jan 2025 15:01:36 -0800
Message-ID: <20250117230136.2237346-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
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
index 9fc71a73caa12..7751d6f69b124 100644
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


