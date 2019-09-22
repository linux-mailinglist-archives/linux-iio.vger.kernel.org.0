Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8194FBA388
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbfIVRwE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 13:52:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35506 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbfIVRvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Sep 2019 13:51:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id a24so6571505pgj.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Sep 2019 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zgK+hVPirfN9H5KHkDj/S/4KoA7AmqlWywx7NCv8Zo=;
        b=Www/SClDmYml8y5bs9EsBchYqqF7LmSenvTIkZpgjVkmujSdj1t0TeJmM+5YIKU87P
         IdjD+DvCfFj3BXBLHSX7jRJ7nECeV/JtWOowXo0wp1xjV2Uxlh7aCn7hlmHcUdFmmCqR
         tqpws8H+SiP2Oa+a/SM6f5FMb//50sDAdXQSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zgK+hVPirfN9H5KHkDj/S/4KoA7AmqlWywx7NCv8Zo=;
        b=Zwy9vWqAXV/4y+PfHx6aXyGkBUGJLEWwUaKxa/0FYs2gkj2Y9frsbXIQotUdNAHf8c
         UdV8QaHoaKzoBJK3dUEEBgpLxoRxaeB68WJZtNHfMdMjkuUZBfF3c07tC8g1LQpqHHjG
         XNpnptSz5hGlRncAARgrx8hvRUZSDdDkOlNlH9JFc4iULMvzjk1+NypNzBfLjSbiMC7u
         c+xnBF1zERawvOAH5PvU6cN+8jzwXxNMC2SPKc3vrk+3ZBfuedK3Zi93whxMcQYEN10/
         lNbqAqQF/Oztr/Ijv0hDQ6HQ7D6vxHzYZNpUxsZz/QLHHiKLh1SM6ncytDHsVqz2bvaM
         JNJA==
X-Gm-Message-State: APjAAAWUU1PXnNDcEePScbmCcGGhyg4Xoq++YZqWV5USa48Sk89t5I6h
        OTVdAiLGfliIKrcsjmd6d/XYCw==
X-Google-Smtp-Source: APXvYqxTclIzIUQ/7AGXk60EER0+9A2qrTaESxBwMR5TDKhSAjMeEEuIWavtHQj9C5Vcr08VFtbtnw==
X-Received: by 2002:a63:285:: with SMTP id 127mr25625535pgc.56.1569174662880;
        Sun, 22 Sep 2019 10:51:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y4sm7557255pjn.19.2019.09.22.10.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 01/13] mfd: cros_ec: Add sensor_count and make check_features public
Date:   Sun, 22 Sep 2019 10:50:09 -0700
Message-Id: <20190922175021.53449-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
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
to know whant the Embedded Controller supports.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mfd/cros_ec_dev.c   | 61 ++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/cros_ec.h | 17 +++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6e6dfd6c1871..3be80183ccaa 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -112,7 +112,7 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
 	{ .name = "cros-ec-vbc", }
 };
 
-static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
 	int ret;
@@ -143,12 +143,71 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 
 	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
 }
+EXPORT_SYMBOL_GPL(cros_ec_check_features);
 
 static void cros_ec_class_release(struct device *dev)
 {
 	kfree(to_cros_ec_dev(dev));
 }
 
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
+	msg = kzalloc(sizeof(struct cros_ec_command) +
+			max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
+	if (msg == NULL)
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
+		if ((ret >= 0) &&
+		    (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
+			/*
+			 * We have 2 sensors, one in the lid, one in the base.
+			 */
+			sensor_count = 2;
+		}
+	}
+	return sensor_count;
+}
+EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
+
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 61c2875c2a40..578e0bbcafdc 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -32,4 +32,21 @@ struct cros_ec_dev {
 
 #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
 
+/**
+ * cros_ec_check_features - Test for the presence of EC features
+ *
+ * Call this function to test whether the ChromeOS EC supports a feature.
+ *
+ * @ec_dev: EC device
+ * @msg: One of ec_feature_code values
+ * @return: 1 if supported, 0 if not
+ */
+int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
+
+/*
+ * Return the number of MEMS sensors supported.
+ * Return < 0 in case of error.
+ */
+int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
+
 #endif /* __LINUX_MFD_CROS_EC_H */
-- 
2.23.0.351.gc4317032e6-goog

