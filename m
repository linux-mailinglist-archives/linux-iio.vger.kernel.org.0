Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3954C2195DF
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGICF7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jul 2020 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGICF6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jul 2020 22:05:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C19C061A0B
        for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2020 19:05:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so396562pjb.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2020 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xOTQgtslM9/dGOeGjGQiHn1B4GiCgQgPOhTBiyUOc0=;
        b=NpXGeRjpYfCZei8PcllPVOVhlw0EOHXOYDt7kzX2mluhc2IIR6u7Y41dhaOAGZCMXl
         YjAD9IgM5h7+d1ddbx2PRFGRZ8ZRNcqDBZz6Ut7b6InjEhPdV+9213fyGgS4THduHLQh
         bUwPouAHg+JSfyD3E2ubaSaEQEICpaPO76DkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xOTQgtslM9/dGOeGjGQiHn1B4GiCgQgPOhTBiyUOc0=;
        b=lEGxQWe4rVpZ6dqYlOuN4727u9IrC7HHXZPAYVBItDmkbXzUw0PkGmU+1HZiF7qKI3
         Ihhkf3ssQGTQGpvQ6/qMGKPOIyIJm52GwqzD799RiDMmqKyidVBoUHRBlKmJoEwPzWNQ
         S6rxDLxwaMLnoFMvhyws/tt7gpv613egQcaJ29ueAebE+3Pq6Z33RmCLU56yqwRGKB3O
         HzW0QIiWn4oCcnnj+EoIQZrbDVNXW5lVH9yHq3HK2NfVyCiQzyMG5QgiRMVKMsa756sR
         8rMmdYt9S/3Oek9sisbjsdXRS6LRE2K4xslxy8deqywI1pJrXhJJzQV0PoWR9Ig7QQUR
         7yoA==
X-Gm-Message-State: AOAM533dzY8YBPczYYa6oAzpnihWuSihymgoYaC2kYx7RTtOosaDN2MA
        9TeMg920LJDR1J6tI6IGVWSGsA==
X-Google-Smtp-Source: ABdhPJwFNn+AgXCFjfkOifv6wEdteWWzbwayhwqMD5SaWxUQufnbPLOtfK+Xp8A5zttj545I88DIXA==
X-Received: by 2002:a17:902:8c93:: with SMTP id t19mr2839563plo.196.1594260358126;
        Wed, 08 Jul 2020 19:05:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id f207sm863977pfa.107.2020.07.08.19.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 19:05:57 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org, enric.balletbo@collabora.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros_ec_accel_legacy: Add Read Only frequency entries
Date:   Wed,  8 Jul 2020 19:05:44 -0700
Message-Id: <20200709020544.1938754-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
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
 drivers/iio/accel/cros_ec_accel_legacy.c | 48 +++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 2532b9ad33842..30c694c18726e 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -33,6 +33,11 @@
  */
 #define ACCEL_LEGACY_NSCALE 9586168
 
+/*
+ * Sensor frequency is hard-coded to 10Hz.
+ */
+static const int cros_ec_legacy_sample_freq[] = { 10, 0 };
+
 static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
 				  unsigned long scan_mask, s16 *data)
 {
@@ -96,6 +101,11 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
 		*val = 0;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = cros_ec_legacy_sample_freq[0];
+		*val2 = cros_ec_legacy_sample_freq[1];
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
+ * Return:	an error code or IIO_AVAIL_LIST
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
+		*length = ARRAY_SIZE(cros_ec_legacy_sample_freq);
+		*vals = cros_ec_legacy_sample_freq;
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
-- 
2.27.0.383.g050319c2ae-goog

