Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CEEDE41F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 07:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfJUFyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 01:54:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42218 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfJUFyk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 01:54:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so7689530pff.9
        for <linux-iio@vger.kernel.org>; Sun, 20 Oct 2019 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qM0INxFAaQNiMRb7wUF5tXn3Vp3+wTj0LnbR6ZyE/Y=;
        b=JWw77FZCCgw9YMLZ962GN2ViHYWlECdUlu/nHHxYn24wfZa/tGvxW4dT1MhU+eq1YK
         PEDnU8MbXqNlsiw2HqjnuRl6po5hzMkxNDVO1Q2XTWuk0ZM1QlWKgTh/YlsUnE0EtGiO
         GGKdWR19zADEohM382sAw/snKb2AATugWB9js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qM0INxFAaQNiMRb7wUF5tXn3Vp3+wTj0LnbR6ZyE/Y=;
        b=M9QcdYLv7jTUWhmsmTQgLiYji4DJYMPXW3OyUgOm8D+YwzQuvULcZ+YrvxnJVq94Ak
         vgltgYihWtAd/KsALUqMC8zkVTbpjdfzCgd82IgukhzGgibGSFLXoUL6L1D3/LKgNaLW
         cQp4LKd+0pDdsneza26vKT1C34GFTrkpl8VjS5VGXf0XiedpvWEIf7k9zXL1QdvsMQwM
         NQg8+MP7gyWykO0Yx8f7ptOsWDCIbsWXYlXR1YkKGRgdAGPLRt0cy/5IqYU8SXTP+s2S
         s+DiLg3wmwz7XwY70qQxpOECSNw6m3xj+Zyew6ILjv/Vw3QzHq7366ngypMW7dbNb690
         /82A==
X-Gm-Message-State: APjAAAXIM0uZfqNQ5VsfNbiHA9md8U7sZYQFMx89ZeczvcrVNNctuBht
        lxVq1ZSDN4q4Ul12n2K/gQod+w==
X-Google-Smtp-Source: APXvYqyG3qpMge7NE3llGhFUegOMLLRrvzpwhlN0fGWuEykOP9u2aFiWJvMLJuUBAfhtz8q/dXLFLA==
X-Received: by 2002:a63:2f47:: with SMTP id v68mr19033909pgv.318.1571637279955;
        Sun, 20 Oct 2019 22:54:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id r24sm14718031pfh.69.2019.10.20.22.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:39 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 18/18] iio: cros_ec: Use Hertz as unit for sampling frequency
Date:   Sun, 20 Oct 2019 22:54:03 -0700
Message-Id: <20191021055403.67849-19-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To be compliant with other sensors, set and get sensor sampling
frequency in Hz, not mHz.

Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose
cros_ec_sensors frequency range via iio sysfs")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v2.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 32 +++++++++++--------
 .../linux/iio/common/cros_ec_sensors_core.h   |  6 ++--
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index f50e239f9a1e9..76dc8cad1b4b5 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -256,6 +256,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_dev *ec = sensor_hub->ec;
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	u32 ver_mask;
+	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
 	int ret, i;
 
 	platform_set_drvdata(pdev, indio_dev);
@@ -304,20 +305,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
 
 		/* 0 is a correct value used to stop the device */
-		state->frequencies[0] = 0;
 		if (state->msg->version < 3) {
 			get_default_min_max_freq(state->resp->info.type,
-						 &state->frequencies[1],
-						 &state->frequencies[2],
+						 &frequencies[1],
+						 &frequencies[2],
 						 &state->fifo_max_event_count);
 		} else {
-			state->frequencies[1] =
-			    state->resp->info_3.min_frequency;
-			state->frequencies[2] =
-			    state->resp->info_3.max_frequency;
+			frequencies[1] = state->resp->info_3.min_frequency;
+			frequencies[2] = state->resp->info_3.max_frequency;
 			state->fifo_max_event_count =
 			    state->resp->info_3.fifo_max_event_count;
 		}
+		for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
+			state->frequencies[2 * i] = frequencies[i] / 1000;
+			state->frequencies[2 * i + 1] =
+				(frequencies[i] % 1000) * 1000;
+		}
 
 		ret = devm_iio_triggered_buffer_setup(
 				dev, indio_dev, NULL,
@@ -707,7 +710,7 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
 {
-	int ret;
+	int ret, frequency;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -719,8 +722,10 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 		if (ret)
 			break;
 
-		*val = st->resp->sensor_odr.ret;
-		ret = IIO_VAL_INT;
+		frequency = st->resp->sensor_odr.ret;
+		*val = frequency / 1000;
+		*val2 = (frequency % 1000) * 1000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	default:
 		ret = -EINVAL;
@@ -755,7 +760,7 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*length = ARRAY_SIZE(state->frequencies);
 		*vals = (const int *)&state->frequencies;
-		*type = IIO_VAL_INT;
+		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	}
 
@@ -777,12 +782,13 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask)
 {
-	int ret;
+	int ret, frequency;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		frequency = val * 1000 + val2 / 1000;
 		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
-		st->param.sensor_odr.data = val;
+		st->param.sensor_odr.data = frequency;
 
 		/* Always roundup, so caller gets at least what it asks for. */
 		st->param.sensor_odr.roundup = 1;
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 4df3abd151fbf..256447b136296 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -52,6 +52,8 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  *				is always 8-byte aligned.
  * @read_ec_sensors_data:	function used for accessing sensors values
  * @fifo_max_event_count:	Size of the EC sensor FIFO
+ * @frequencies:		Table of known available frequencies:
+ *				0, Min and Max in mHz.
  */
 struct cros_ec_sensors_core_state {
 	struct cros_ec_device *ec;
@@ -75,9 +77,7 @@ struct cros_ec_sensors_core_state {
 				    unsigned long scan_mask, s16 *data);
 
 	u32 fifo_max_event_count;
-
-	/* Table of known available frequencies : 0, Min and Max in mHz */
-	int frequencies[3];
+	int frequencies[6];
 };
 
 int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,
-- 
2.23.0.866.gb869b98d4c-goog

