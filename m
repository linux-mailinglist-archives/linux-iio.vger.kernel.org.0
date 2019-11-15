Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB492FD9CF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfKOJux (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:50:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46525 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfKOJur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id r18so5701886pgu.13
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfYyZMNX6ADttl6jBRWvuvz4aSC4mN0xi0O4hDolIb4=;
        b=ag9FnF+5W2oGUc8oWMrSGFemJp1wdf+wPfN6o+CDcrNmxFvoyqFz27JIBnpaGYkwIw
         qdGio4rN2PkHXsTqh/TJUl4XtYiodFlKnRx2eeehd0yS8QMd3E/3SeUzsXzvsgAWlEWf
         5lRM6COdwPOx7ssey8yeHVfiIJNTCxw65ZFr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfYyZMNX6ADttl6jBRWvuvz4aSC4mN0xi0O4hDolIb4=;
        b=W3shXyLjR8kneUj5juoV6Y06PV87DYnU7+1itJgK4j2ib540qLUM7cU5qnLFqfyu96
         vMuwub+Yq977gu/g4SZJEsXdahCfnAh4+ttqlAarhdgcsysmXW1HI8UK67BaFpDxArsX
         c7TpYk/q1g0sTTc/X/XuVVjFTQVDF/t5vCS5CPufKHrwgTbbffAN18V59EaS7+jiETQz
         vmroE38bUWzxEkW3FTssAzVQmupWqeKM2LFqDo0TTMG2coWp5dd8LV445zrZlSVvV+vp
         UjjB3/l/O9eFUqjunkDq+CZqdZpn0ZNo0fTYFDoiKZFrxgD0R/H6zOVSFRiKKOXsE7s7
         MqeQ==
X-Gm-Message-State: APjAAAVUZMD9t9xp9fF39IhPsW8jRx+VmIA4BDJLok9l2O5DmlUIxbn2
        iNTg6cg7HoRVEeBXm8ebO6nGqw==
X-Google-Smtp-Source: APXvYqzQwKMf0xfzK/YlQa4LOzDUqkSNH56i6e5alnFPoZAmVsjgjoTC23MtEj+J7FS3YhmrBnwNtw==
X-Received: by 2002:a62:140d:: with SMTP id 13mr15652813pfu.79.1573811445092;
        Fri, 15 Nov 2019 01:50:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id o129sm12543636pfg.75.2019.11.15.01.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:44 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 17/18] iio: cros_ec: Report hwfifo_watermark_max
Date:   Fri, 15 Nov 2019 01:34:11 -0800
Message-Id: <20191115093412.144922-18-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Report the maximum amount of sample the EC can hold.
This is not tunable, but can be useful for application to find out the
maximum amount of time it can sleep when hwfifo_timeout is set to a
large number.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes in v5:
  Added ack.
Changes in v4:
- Check patch with --strict option
    Alignement
No changes in v3.
Changes in v2:
- Remove double lines, add line before return for visibility.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 33 +++++++++++++++++--
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 ++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index eca39ff9381a..cd095426fc11 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -23,6 +23,12 @@
 #include <linux/platform_data/cros_ec_sensorhub.h>
 #include <linux/platform_device.h>
 
+/*
+ * Hard coded to the first device to support sensor fifo.  The EC has a 2048
+ * byte fifo and will trigger an interrupt when fifo is 2/3 full.
+ */
+#define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
+
 static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_BASE] = "base",
 	[MOTIONSENSE_LOC_LID] = "lid",
@@ -56,8 +62,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 
 static void get_default_min_max_freq(enum motionsensor_type type,
 				     u32 *min_freq,
-				     u32 *max_freq)
+				     u32 *max_freq,
+				     u32 *max_fifo_events)
 {
+	/*
+	 * We don't know fifo size, set to size previously used by older
+	 * hardware.
+	 */
+	*max_fifo_events = CROS_EC_FIFO_SIZE;
+
 	switch (type) {
 	case MOTIONSENSE_TYPE_ACCEL:
 	case MOTIONSENSE_TYPE_GYRO:
@@ -150,8 +163,21 @@ static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
 		       cros_ec_sensor_get_report_latency,
 		       cros_ec_sensor_set_report_latency, 0);
 
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->fifo_max_event_count);
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+
 const struct attribute *cros_ec_sensor_fifo_attributes[] = {
 	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	NULL,
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
@@ -282,12 +308,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		if (state->msg->version < 3) {
 			get_default_min_max_freq(state->resp->info.type,
 						 &state->frequencies[1],
-						 &state->frequencies[2]);
+						 &state->frequencies[2],
+						 &state->fifo_max_event_count);
 		} else {
 			state->frequencies[1] =
 			    state->resp->info_3.min_frequency;
 			state->frequencies[2] =
 			    state->resp->info_3.max_frequency;
+			state->fifo_max_event_count =
+			    state->resp->info_3.fifo_max_event_count;
 		}
 
 		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 5b0acc14c891..bc26ae2e3272 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -50,6 +50,7 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  *				the timestamp. The timestamp is always last and
  *				is always 8-byte aligned.
  * @read_ec_sensors_data:	function used for accessing sensors values
+ * @fifo_max_event_count:	Size of the EC sensor FIFO
  */
 struct cros_ec_sensors_core_state {
 	struct cros_ec_device *ec;
@@ -72,6 +73,8 @@ struct cros_ec_sensors_core_state {
 	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
 				    unsigned long scan_mask, s16 *data);
 
+	u32 fifo_max_event_count;
+
 	/* Table of known available frequencies : 0, Min and Max in mHz */
 	int frequencies[3];
 };
-- 
2.24.0.432.g9d3f5f5b63-goog

