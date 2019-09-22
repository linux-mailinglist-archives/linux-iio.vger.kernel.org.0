Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B67BA379
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfIVRvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 13:51:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43686 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbfIVRvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Sep 2019 13:51:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so7553496pfo.10
        for <linux-iio@vger.kernel.org>; Sun, 22 Sep 2019 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWkMB79F5gxYhVuZy1fySIk4+D13DYEhvRykZ9MAPRk=;
        b=egQwmuCa0n+Y4eXnujzdaOgwvCswViurjVCFMtuhrS5rdzx3vVs18hivyMiNV6Xy6d
         OHZew2ZnLlPlvRCf8HgYmIXrM1plmnYJC07JXUslxvtq50WcNs23HcQ7LH2rhQ2i5pwW
         cGG98mi7tE95AUOKbjQ9lxJKGYReSMwRG9CdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWkMB79F5gxYhVuZy1fySIk4+D13DYEhvRykZ9MAPRk=;
        b=PP28NzQ/1X3kv9Bbtr1pVL1hZnVKSD+89ax/arCPWSvq56GvfkgV2Hiaf/+cqLwiWy
         LZ5qAiYyHe8Z6V6ki6jDZMulWL5+gi3y+Lrq0Tct2ICTOpJ2wkt1PfW8irg8hnaD661f
         j1tMZzUPd1pemjjfEo7wtEKHgdz122T1RHFypDKgC7+pPXbZXosHPeerVn+ggimxJenz
         niunbzCeim+mDcBgyTkCOj9WWis+hMRvjiPgDBySo5WBmOJ8/SLcoFt/rf2agE7YFx+Q
         hhQ2Lrhi1mbhgnDLvBjSLKJEFpsJi0hBQuA9ptcPw5MOToxaj6iesKKykDnYgORjTJd8
         omcQ==
X-Gm-Message-State: APjAAAXUGodo60DAH+TRRMCcgQzry4kkrn0ZA+9mL4zI/uVtS3qMBJTY
        9DVkyBntmqPFYi2eRZq0qOiEyg==
X-Google-Smtp-Source: APXvYqwSNndOMatt0WR9KPPcmc/CQywtbdpqTS6ly79fmgr0m3Z8E12KaLvZzzUchtcVcw3CpsZxyA==
X-Received: by 2002:a17:90a:ad48:: with SMTP id w8mr16874085pjv.43.1569174680094;
        Sun, 22 Sep 2019 10:51:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id a18sm7740989pgm.25.2019.09.22.10.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 10:51:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 13/13] iio: cros_ec: Use Hertz as unit for sampling frequency
Date:   Sun, 22 Sep 2019 10:50:21 -0700
Message-Id: <20190922175021.53449-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190922175021.53449-1-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
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
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 32 +++++++++++--------
 .../linux/iio/common/cros_ec_sensors_core.h   |  6 ++--
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index a32260c9bc09..f7e6827bd4cb 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -227,6 +227,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	struct iio_buffer *buffer;
 	u32 ver_mask;
+	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
 	int ret, i;
 
 	platform_set_drvdata(pdev, indio_dev);
@@ -275,20 +276,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
 
 		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
 			buffer = devm_iio_kfifo_allocate(dev);
@@ -653,7 +656,7 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
 {
-	int ret;
+	int ret, frequency;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -665,8 +668,10 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
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
@@ -690,7 +695,7 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*length = ARRAY_SIZE(state->frequencies);
 		*vals = (const int *)&state->frequencies;
-		*type = IIO_VAL_INT;
+		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	}
 
@@ -702,12 +707,13 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
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
index 2c6acbde0d02..46d5110b2fe4 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -56,6 +56,8 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  * @read_ec_sensors_data:	function used for accessing sensors values
  * @curr_sampl_freq:		current sampling period
  * @fifo_max_event_count:	Size of the EC sensor FIFO
+ * @frequencies:		Table of known available frequencies:
+ *				0, Min and Max in mHz.
  */
 struct cros_ec_sensors_core_state {
 	struct cros_ec_device *ec;
@@ -80,9 +82,7 @@ struct cros_ec_sensors_core_state {
 
 	int curr_sampl_freq;
 	u32 fifo_max_event_count;
-
-	/* Table of known available frequencies : 0, Min and Max in mHz */
-	int frequencies[3];
+	int frequencies[6];
 };
 
 /**
-- 
2.23.0.351.gc4317032e6-goog

