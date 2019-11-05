Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64ACF094E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfKEW1D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 17:27:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42426 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbfKEW1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 17:27:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so8841268pfh.9
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2019 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gAP9AMqmADYvvLXc6jdiBEOOH/w3O/0Q+AiPO4PqlFE=;
        b=lmpljo0WQEzwT+ESBfV6jyovoPEMLVv4yu5oWc9HiivJUM8fxvzv5faca5qQRMshUq
         6gSxYneXPaYmemMRCdi7r7Q1N4i5BDWKM/0pC3QB+WBu2sto0YqDnb887KbC96NatLS2
         ufLHPL9QhyjlQQttiE4jS2zo3iRNMfcgBziJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gAP9AMqmADYvvLXc6jdiBEOOH/w3O/0Q+AiPO4PqlFE=;
        b=gSqkBSrxvL2U9SxhG//6gYydSikgN90fIpdQzNyHvRJJN0DGRH71/U8NidfhM9Kt1V
         /zRCQ33hj8OXwkCUS0bWLQg8Pag5u6B39n2K5OnfHY+3Qykfd/AeomI1JFff8XpxQmjd
         aaPaSrtymjuDx8Fn+xcJEs6MzpiVWFQVWyiHYuw0M7UjOEBgLi6HBG9VuwmisWinTZe2
         IbDzi9jb/7zAI7V/GufmtAYkNmJagNsKKBtc3TBJ6cTpfTENu6Anx6RiYECvW8SSyn3E
         QHli5qWFX1Ca5BBcezZWKTB4k8mkj3B33ef0sppL60KhQmbrTgfgWhgsmeAzOEwBazEb
         wnkw==
X-Gm-Message-State: APjAAAU+0jBGzPRYFjzTNGffvimeYJGht0Yodz4gk8yfP6e5bBpekby2
        kJbqHXCr3H8r5Kz4izgJy5voKQ==
X-Google-Smtp-Source: APXvYqyaGOe7Rig/lSdNEWwX9phvve2jx7YntRHZGwiXVfBHwTT6LHFQUb5coc2a/tS+Ghzq2j3LHg==
X-Received: by 2002:a62:3786:: with SMTP id e128mr41517670pfa.11.1572992820584;
        Tue, 05 Nov 2019 14:27:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id z2sm11700297pgg.41.2019.11.05.14.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:00 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 01/17] mfd: cros_ec: Add sensor_count and make check_features public
Date:   Tue,  5 Nov 2019 14:26:36 -0800
Message-Id: <20191105222652.70226-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new function to return the number of MEMS sensors available in a
ChromeOS Embedded Controller.
It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
registers to find out.

Also, make check_features public as it can be useful for other drivers
to know what the Embedded Controller supports.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
  Check patch with --strict option
    Use sizeof(*obj) instead of sizeof(struct ...obj)
    Alignement
    Remove useless ().
Changes in v3:
  Fix doxygen comments.
Changes in v2:
  Fix spelling in commit message.
  Cleanup the case where DUMP command is not supported.
  Move code from mfd to platform/chrome/

 drivers/mfd/cros_ec_dev.c                   |  32 ------
 drivers/platform/chrome/cros_ec_proto.c     | 117 ++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |   5 +
 3 files changed, 122 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6e6dfd6c1871..a35104e35cb4 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -112,38 +112,6 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
 	{ .name = "cros-ec-vbc", }
 };
 
-static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
-{
-	struct cros_ec_command *msg;
-	int ret;
-
-	if (ec->features[0] == -1U && ec->features[1] == -1U) {
-		/* features bitmap not read yet */
-		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
-		if (!msg)
-			return -ENOMEM;
-
-		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
-		msg->insize = sizeof(ec->features);
-
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-		if (ret < 0) {
-			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
-				 ret, msg->result);
-			memset(ec->features, 0, sizeof(ec->features));
-		} else {
-			memcpy(ec->features, msg->data, sizeof(ec->features));
-		}
-
-		dev_dbg(ec->dev, "EC features %08x %08x\n",
-			ec->features[0], ec->features[1]);
-
-		kfree(msg);
-	}
-
-	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
-}
-
 static void cros_ec_class_release(struct device *dev)
 {
 	kfree(to_cros_ec_dev(dev));
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 7db58771ec77..b502933e911b 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -717,3 +717,120 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 	return host_event;
 }
 EXPORT_SYMBOL(cros_ec_get_host_event);
+
+/**
+ * cros_ec_check_features - Test for the presence of EC features
+ *
+ * @ec: EC device, does not have to be connected directly to the AP,
+ *      can be daisy chained through another device.
+ * @feature: One of ec_feature_code bit.
+ *
+ * Call this function to test whether the ChromeOS EC supports a feature.
+ *
+ * Return: 1 if supported, 0 if not
+ */
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	if (ec->features[0] == -1U && ec->features[1] == -1U) {
+		/* features bitmap not read yet */
+		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
+		msg->insize = sizeof(ec->features);
+
+		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		if (ret < 0) {
+			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
+				 ret, msg->result);
+			memset(ec->features, 0, sizeof(ec->features));
+		} else {
+			memcpy(ec->features, msg->data, sizeof(ec->features));
+		}
+
+		dev_dbg(ec->dev, "EC features %08x %08x\n",
+			ec->features[0], ec->features[1]);
+
+		kfree(msg);
+	}
+
+	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
+}
+EXPORT_SYMBOL_GPL(cros_ec_check_features);
+
+/**
+ * cros_ec_get_sensor_count - Return the number of MEMS sensors supported.
+ *
+ * @ec: EC device, does not have to be connected directly to the AP,
+ *      can be daisy chained through another device.
+ * Return: < 0 in case of error.
+ */
+int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
+{
+	/*
+	 * Issue a command to get the number of sensor reported.
+	 * If not supported, check for legacy mode.
+	 */
+	int ret, sensor_count;
+	struct ec_params_motion_sense *params;
+	struct ec_response_motion_sense *resp;
+	struct cros_ec_command *msg;
+	struct cros_ec_device *ec_dev = ec->ec_dev;
+	u8 status;
+
+	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
+		      GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = 1;
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+	msg->outsize = sizeof(*params);
+	msg->insize = sizeof(*resp);
+
+	params = (struct ec_params_motion_sense *)msg->data;
+	params->cmd = MOTIONSENSE_CMD_DUMP;
+
+	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	if (ret < 0) {
+		sensor_count = ret;
+	} else if (msg->result != EC_RES_SUCCESS) {
+		sensor_count = -EPROTO;
+	} else {
+		resp = (struct ec_response_motion_sense *)msg->data;
+		sensor_count = resp->dump.sensor_count;
+	}
+	kfree(msg);
+
+	/*
+	 * Check legacy mode: Let's find out if sensors are accessible
+	 * via LPC interface.
+	 */
+	if (sensor_count == -EPROTO &&
+	    ec->cmd_offset == 0 &&
+	    ec_dev->cmd_readmem) {
+		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
+				1, &status);
+		if (ret >= 0 &&
+		    (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
+			/*
+			 * We have 2 sensors, one in the lid, one in the base.
+			 */
+			sensor_count = 2;
+		} else {
+			/*
+			 * EC uses LPC interface and no sensors are presented.
+			 */
+			sensor_count = 0;
+		}
+	} else if (sensor_count == -EPROTO) {
+		/* EC responded, but does not understand DUMP command. */
+		sensor_count = 0;
+	}
+	return sensor_count;
+}
+EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 0d4e4aaed37a..f3de0662135d 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
+#include <linux/mfd/cros_ec.h>
 #include <linux/platform_data/cros_ec_commands.h>
 
 #define CROS_EC_DEV_NAME	"cros_ec"
@@ -213,4 +214,8 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
 
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
+
+int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
+
 #endif /* __LINUX_CROS_EC_PROTO_H */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

