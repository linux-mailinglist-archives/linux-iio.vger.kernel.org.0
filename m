Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253832115A2
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jul 2020 00:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGAWLH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGAWLG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jul 2020 18:11:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825DDC08C5C1
        for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2020 15:11:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so11226982pje.4
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2020 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D//aYfxxF6coDmDUnCWHJX89wXH3vcynrUNGagkZrME=;
        b=GiiRljr0fmbQQLiOHJ2o1IomfnBikZRx3vzv0Ywo8k4Nz2znjTJex+RYiBG38mmfn/
         u9UC/CNGyXSw3bUAXMBxYwgYQdnxZwDEfvlcIdKq/lHRuZhjZJnoMZgjwl8q5cSy5i4l
         mKgpDQd1ex08fM709bQgxhZ9GoYlGVVQD+eNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D//aYfxxF6coDmDUnCWHJX89wXH3vcynrUNGagkZrME=;
        b=nrLG4qfX3k0velhqVtGwbTwfSv2AXiGwh2pNCjfevGJ5IWc/iHEmhDkTl5rdM0YqaQ
         wEqkXY9S/CGiM1OlQvvoqGphXycUvneaRkl4gajBMU7E2BULO1fbWHxCukLw5zAGpFAP
         cgzZUWw1L9xgV062eytK+ZV8P5+6GzX0zj2hewtwmzUD+nSYcaGKqMuD0115G9Bp3wlm
         1kGvtPxj+HO23oriNCEH/dNuzgR99ZwNJa5bg30w6gGK+fPTDBxDW2EQuNVJPHwTm9bP
         YWGiXBBehW+rX5c8pfHjnL9V9UXiZxUI15XuF4uPZztEhJoiu1hG0MHza0nA9n1e6t4X
         5WOw==
X-Gm-Message-State: AOAM530QNWsbpF5RGRfFmsynoCmLrhcV5pkGlP4qnqgUXrpSgDKt3RUj
        P7LwUrHwq2yXXaelaeiCJgUQrg==
X-Google-Smtp-Source: ABdhPJzKZJM/Pn3YezlI8X8CLdlnOoIJ66+Bfg6RCBv0pQVykZq0+4OueX7h3z6TBgOuX4e6YsVF3A==
X-Received: by 2002:a17:902:fe85:: with SMTP id x5mr16070939plm.282.1593641466005;
        Wed, 01 Jul 2020 15:11:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id b11sm7154749pfr.179.2020.07.01.15.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 15:11:05 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org, enric.balletbo@collabora.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec_accel_legacy: Add Read Only frequency entries
Date:   Wed,  1 Jul 2020 15:10:55 -0700
Message-Id: <20200701221055.116514-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Report to user space that 10Hz is the sampling frequency of
the accelerometers in legacy mode, and it can not be changed.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 52 +++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 2532b9ad33842..e924183089368 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -33,6 +33,11 @@
  */
 #define ACCEL_LEGACY_NSCALE 9586168
 
+/*
+ * Sensor frequency is hard-coded to 10Hz.
+ */
+#define ACCEL_LEGACY_FREQ 10
+
 static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
 				  unsigned long scan_mask, s16 *data)
 {
@@ -96,6 +101,11 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
 		*val = 0;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ACCEL_LEGACY_FREQ;
+		*val2 = 0;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	default:
 		ret = cros_ec_sensors_core_read(st, chan, val, val2,
 				mask);
@@ -120,9 +130,41 @@ static int cros_ec_accel_legacy_write(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+/**
+ * cros_ec_accel_legacy_read_avail() - get available values
+ * @indio_dev:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @vals:	list of available values
+ * @type:	type of data returned
+ * @length:	number of data returned in the array
+ * @mask:	specifies which values to be requested
+ *
+ * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
+ */
+static int cros_ec_accel_legacy_read_avail(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int **vals,
+					   int *type,
+					   int *length,
+					   long mask)
+{
+	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = 2;
+		*vals = (const int *)&state->frequencies;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
 static const struct iio_info cros_ec_accel_legacy_info = {
 	.read_raw = &cros_ec_accel_legacy_read,
 	.write_raw = &cros_ec_accel_legacy_write,
+	.read_avail = &cros_ec_accel_legacy_read_avail,
 };
 
 /*
@@ -142,7 +184,11 @@ static const struct iio_info cros_ec_accel_legacy_info = {
 		.info_mask_separate =					\
 			BIT(IIO_CHAN_INFO_RAW) |			\
 			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
+		.info_mask_shared_by_all =				\
+			BIT(IIO_CHAN_INFO_SCALE) |			\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.info_mask_shared_by_all_available =			\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 		.ext_info = cros_ec_sensors_ext_info,			\
 		.scan_type = {						\
 			.sign = 's',					\
@@ -191,6 +237,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 		state->sign[CROS_EC_SENSOR_Z] = -1;
 	}
 
+	/* Frequency can not be changed on glimmer and is set to 10Hz. */
+	state->frequencies[0] = ACCEL_LEGACY_FREQ;
+	state->frequencies[1] = 0;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.27.0.212.ge8ba1cc988-goog

