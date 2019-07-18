Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29586D6CE
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfGRWWs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 18:22:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37413 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfGRWWr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 18:22:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so13242887pfa.4
        for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2019 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwyiau4V8w99W5xHu9SsJUhCjY9V9LV/JZ3qo3BCV2s=;
        b=jbz+vvjamYf8AAfftjmdkObsPUqCeraOxsaqU0R50jWm/21+J0RuMp8IcJPoGn/7w4
         pzrdl6iqD6Ysi+fXwdIYnJfhXXiebqEFVt8cCjm5mXyPilkTbNonmA2vhPYLvwgE/tPs
         E1PLm0zdULVLdHraTs4n3WBnsBtag49TYliws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwyiau4V8w99W5xHu9SsJUhCjY9V9LV/JZ3qo3BCV2s=;
        b=Ev55bEqa6Hqu6K94bSPZgXaBkDriwsErZDBFYXSg8iVfTF5Wocmh1WjBrVM/k+YkrA
         3TxIIrFJ4UVXoMbhY+2GBeTuvGrxxhQ/5zRCDTTottvaj7A3ACo0LIImBKRk7U1029wZ
         agpKZpYaDAXPtMFWOATeVGh3P7yLpMl2Gobain4gkAWmTfuG0wZuJi+fZ+U33skKyR9P
         UlwN5LENaFR5TxCmE+ucECUrEK+wf1Z/X/ih7zhxEDuQx4KlhBfs87v/e1wRA5WEwJ6I
         mAYb/r7cLYTbvuPCfnz5MjjnipB2r1TzUTw63kTwVQdzFR4qRT5m/s7xdKN9cyUkQaCY
         CXag==
X-Gm-Message-State: APjAAAUggsc/XHhc6oyUZoIZ8KC5aSsX9/E/csSrJbDAxJDv5x+qGSt+
        yPoq8o2Jxq5Ld6iY8lDWCBzUxA==
X-Google-Smtp-Source: APXvYqyGC0oKQeeAJ0L1tVN3ikYjCRMk/d2YMrkI8QapYlGo6KSYjRFsq5ML2ZBGCw38qpA0kW2KNQ==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr54227398pjc.63.1563488566691;
        Thu, 18 Jul 2019 15:22:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id t29sm35515797pfq.156.2019.07.18.15.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 15:22:45 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: cros_ec: Remove replacing error code with -EIO
Date:   Thu, 18 Jul 2019 15:22:37 -0700
Message-Id: <20190718222238.60087-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Due to an API misread, error code can be different for -EIO when reading
a sysfs entry. Return the error reported by the cros_ec stack.

Check the proper error message (protocol error, not supported) is
reported when there is an error returned by the EC stack.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 44 +++++++++++--------
 drivers/iio/light/cros_ec_light_prox.c        | 36 +++++++--------
 drivers/iio/pressure/cros_ec_baro.c           | 17 ++++---
 3 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 130362ca421b..ed29ac22dff8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -33,6 +33,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
+	int ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -60,9 +61,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 
 		state->param.cmd = MOTIONSENSE_CMD_INFO;
 		state->param.info.sensor_num = sensor_platform->sensor_num;
-		if (cros_ec_motion_send_host_cmd(state, 0)) {
+		ret = cros_ec_motion_send_host_cmd(state, 0);
+		if (ret) {
 			dev_warn(dev, "Can not access sensor info\n");
-			return -EIO;
+			return ret;
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
@@ -86,7 +88,7 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 
 	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
 	if (ret < 0)
-		return -EIO;
+		return ret;
 
 	if (ret &&
 	    state->resp != (struct ec_response_motion_sense *)state->msg->data)
@@ -396,7 +398,7 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
 {
-	int ret = IIO_VAL_INT;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -404,22 +406,27 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 		st->param.ec_rate.data =
 			EC_MOTION_SENSE_NO_VALUE;
 
-		if (cros_ec_motion_send_host_cmd(st, 0))
-			ret = -EIO;
-		else
-			*val = st->resp->ec_rate.ret;
+		ret = cros_ec_motion_send_host_cmd(st, 0);
+		if (ret)
+			break;
+
+		*val = st->resp->ec_rate.ret;
+		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_FREQUENCY:
 		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
 		st->param.sensor_odr.data =
 			EC_MOTION_SENSE_NO_VALUE;
 
-		if (cros_ec_motion_send_host_cmd(st, 0))
-			ret = -EIO;
-		else
-			*val = st->resp->sensor_odr.ret;
+		ret = cros_ec_motion_send_host_cmd(st, 0);
+		if (ret)
+			break;
+
+		*val = st->resp->sensor_odr.ret;
+		ret = IIO_VAL_INT;
 		break;
 	default:
+		ret = -EINVAL;
 		break;
 	}
 
@@ -431,7 +438,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask)
 {
-	int ret = 0;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_FREQUENCY:
@@ -441,17 +448,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 		/* Always roundup, so caller gets at least what it asks for. */
 		st->param.sensor_odr.roundup = 1;
 
-		if (cros_ec_motion_send_host_cmd(st, 0))
-			ret = -EIO;
+		ret = cros_ec_motion_send_host_cmd(st, 0);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
 		st->param.ec_rate.data = val;
 
-		if (cros_ec_motion_send_host_cmd(st, 0))
-			ret = -EIO;
-		else
-			st->curr_sampl_freq = val;
+		ret = cros_ec_motion_send_host_cmd(st, 0);
+		if (ret)
+			break;
+		st->curr_sampl_freq = val;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 308ee6ff2e22..943fa305af91 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -42,7 +42,7 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
 	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
 	u16 data = 0;
 	s64 val64;
-	int ret = IIO_VAL_INT;
+	int ret;
 	int idx = chan->scan_index;
 
 	mutex_lock(&st->core.cmd_lock);
@@ -50,23 +50,22 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type == IIO_PROXIMITY) {
-			if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
-						     (s16 *)&data) < 0) {
-				ret = -EIO;
+			ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
+						     (s16 *)&data);
+			if (ret)
 				break;
-			}
 			*val = data;
+			ret = IIO_VAL_INT;
 		} else {
 			ret = -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->type == IIO_LIGHT) {
-			if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
-						     (s16 *)&data) < 0) {
-				ret = -EIO;
+			ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
+						     (s16 *)&data);
+			if (ret)
 				break;
-			}
 			/*
 			 * The data coming from the light sensor is
 			 * pre-processed and represents the ambient light
@@ -82,15 +81,15 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
 		st->core.param.sensor_offset.flags = 0;
 
-		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
-			ret = -EIO;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret)
 			break;
-		}
 
 		/* Save values */
 		st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
 
 		*val = st->core.calib[idx];
+		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		/*
@@ -101,10 +100,9 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
 		st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
 
-		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
-			ret = -EIO;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret)
 			break;
-		}
 
 		val64 = st->core.resp->sensor_range.ret;
 		*val = val64 >> 16;
@@ -127,7 +125,7 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
 			       int val, int val2, long mask)
 {
 	struct cros_ec_light_prox_state *st = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 	int idx = chan->scan_index;
 
 	mutex_lock(&st->core.cmd_lock);
@@ -141,14 +139,12 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
 		st->core.param.sensor_offset.offset[0] = st->core.calib[0];
 		st->core.param.sensor_offset.temp =
 					EC_MOTION_SENSE_INVALID_CALIB_TEMP;
-		if (cros_ec_motion_send_host_cmd(&st->core, 0))
-			ret = -EIO;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
 		st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
-		if (cros_ec_motion_send_host_cmd(&st->core, 0))
-			ret = -EIO;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
 		break;
 	default:
 		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 034ce98d6e97..a648582b14a7 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -39,26 +39,29 @@ static int cros_ec_baro_read(struct iio_dev *indio_dev,
 {
 	struct cros_ec_baro_state *st = iio_priv(indio_dev);
 	u16 data = 0;
-	int ret = IIO_VAL_INT;
+	int ret;
 	int idx = chan->scan_index;
 
 	mutex_lock(&st->core.cmd_lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
-					     (s16 *)&data) < 0)
-			ret = -EIO;
+		ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
+					     (s16 *)&data);
+		if (ret)
+			break;
+
 		*val = data;
+		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
 		st->core.param.sensor_range.data = EC_MOTION_SENSE_NO_VALUE;
 
-		if (cros_ec_motion_send_host_cmd(&st->core, 0)) {
-			ret = -EIO;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret)
 			break;
-		}
+
 		*val = st->core.resp->sensor_range.ret;
 
 		/* scale * in_pressure_raw --> kPa */
-- 
2.22.0.657.g960e92d24f-goog

