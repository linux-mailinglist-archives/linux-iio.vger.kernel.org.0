Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4F5A507
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfF1TR3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 15:17:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37446 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfF1TR3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 15:17:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so3471994pfa.4
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2019 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ne5OGTEt+b44J1ebg+R1lxp7ErzK0usnYJD4hX8q19M=;
        b=Dktc8FN+sStr4EzcdIIZGVluhYjUdYIhB/9LfbkrQ2L3AK4lMXlCfXtCKEwDs9N7Eq
         cpCM6cHsrDUFBXlVm3u+IRZlYeQnqP1yzNqgOIpvERGitdjKEemPOyXk//CLvPqMrdZv
         aNe4SLH93i10mgI5lvdrTGkNf3Rxc+Z8ne33A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ne5OGTEt+b44J1ebg+R1lxp7ErzK0usnYJD4hX8q19M=;
        b=LCf7W9Gm1oATqWZOylDxzICv5fg6s1qsmPWpRo+N0ib80JBD0vMVbErit0BIFUDtTu
         /JxIFz6pywXBTj7RVzpIdWFGVzP+e58WL+LgmoxlH9zSXi/KYCxl3b6DVPGkScdX24lD
         Y3mphjvbMAdJNJWy2oGGq+ISXq5PGyFjY/1tKyYHAYxbXJ+hnvwwUUxAE5r3Y0hBlc1k
         KfuUiSG/QtNi2GxxQSUSPRTj3NuF/EQsPbdX4UbF310H+ed71liqugoH0sEH08yaSPYa
         6gDDBC3WLrZbY9t9Z/mbuMLo9Vk/1SmYp1q1n6M4s/FU8VFAlTLWXudvvvJTbiPt91xn
         Mk5A==
X-Gm-Message-State: APjAAAVhzBGwqgt9Vqu2wV5BrWG9KuwjhDLkrCFPBl+ppwbhIiQ+cU3x
        vAa9q3Gp1ycDPZ7KEAkse7Ho9Q==
X-Google-Smtp-Source: APXvYqzXWLF1Kb5aUF3GUmJENXBYZoKGjbUNrX5zlC+HSxHR1A28vTr/Z6u2vn3WOxdLLVkiBSK+0w==
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr15504578pjg.116.1561749448139;
        Fri, 28 Jun 2019 12:17:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y14sm2547782pjr.13.2019.06.28.12.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 12:17:27 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 4/4] iio: cros_ec_accel_legacy: Add support for veyron-minnie
Date:   Fri, 28 Jun 2019 12:17:11 -0700
Message-Id: <20190628191711.23584-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190628191711.23584-1-gwendal@chromium.org>
References: <20190628191711.23584-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Veyron minnie embedded controller presents 2 accelerometers using an
older interface. Add function to query the data in cros_ec_accel.

Verify accelerometers on veyron-minnie are presented and working.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 40 ++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 2399f0cbdf2b..2c6196446d90 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -5,7 +5,7 @@
  * Copyright 2017 Google, Inc
  *
  * This driver uses the memory mapper cros-ec interface to communicate
- * with the Chrome OS EC about accelerometer data.
+ * with the Chrome OS EC about accelerometer data or older commands.
  * Accelerometer access is presented through iio sysfs.
  */
 
@@ -33,6 +33,39 @@
  */
 #define ACCEL_LEGACY_NSCALE 9586168
 
+static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
+				  unsigned long scan_mask, s16 *data)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int i;
+	u8 sensor_num;
+
+	/*
+	 * Read all sensor data through a command.
+	 * Save sensor_num, it is assumed to stay.
+	 */
+	sensor_num = st->param.info.sensor_num;
+	st->param.cmd = MOTIONSENSE_CMD_DUMP;
+	st->param.dump.max_sensor_count = CROS_EC_SENSOR_LEGACY_NUM;
+	ret = cros_ec_motion_send_host_cmd(st,
+			sizeof(st->resp->dump) + CROS_EC_SENSOR_LEGACY_NUM *
+			sizeof(struct ec_response_motion_sensor_data));
+	st->param.info.sensor_num = sensor_num;
+	if (ret != 0) {
+		dev_warn(&indio_dev->dev, "Unable to read sensor data\n");
+		return ret;
+	}
+
+	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
+		*data = st->resp->dump.sensor[sensor_num].data[i] *
+			st->sign[i];
+		data++;
+	}
+
+	return 0;
+}
+
 static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     int *val, int *val2, long mask)
@@ -149,7 +182,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 	indio_dev->info = &cros_ec_accel_legacy_info;
 	state = iio_priv(indio_dev);
 
-	state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
+	if (state->ec->cmd_readmem != NULL)
+		state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
+	else
+		state->read_ec_sensors_data = cros_ec_accel_legacy_read_cmd;
 
 	indio_dev->channels = cros_ec_accel_legacy_channels;
 	indio_dev->num_channels = ARRAY_SIZE(cros_ec_accel_legacy_channels);
-- 
2.22.0.410.gd8fdbe21b5-goog

