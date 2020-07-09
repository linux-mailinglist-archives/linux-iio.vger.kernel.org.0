Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C621A6A0
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGISJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgGISJc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 14:09:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C44BC08C5CE
        for <linux-iio@vger.kernel.org>; Thu,  9 Jul 2020 11:09:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i14so1333460pfu.13
        for <linux-iio@vger.kernel.org>; Thu, 09 Jul 2020 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUBCpr6jOXn/pJWG0ZIN+tsY1rIJVuAAWEWLB0U+P0s=;
        b=an3z1Hpr/UmTd2hwOqMWCXJHRkAzc6xY+bmlJW1hto3gvivmRY/KN2+JxLfyiRbqPN
         IUOZ9n5hOScK6PY5wOMBgGTbgaOiXTGnR4IiV1jrwtraQ24IakYHJdbbVJnHuS0rLRdj
         jjXcX6JXDkrcWlQpz/kuoIlOuxjWDSY25CP/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUBCpr6jOXn/pJWG0ZIN+tsY1rIJVuAAWEWLB0U+P0s=;
        b=f8neReIn3Yt9xJ9fsro/NLE/QVAyx2EWyySpeyWEtmRVDne37vFGEEUp+E5wOFA33N
         cS+eBeSTY0X53H86yPWa66UXplUZWAnhZUk4hjnVTZLTVoWHXPSc2fjZps643hwCYwMC
         QlWIjVngq8Av3TE3Rm0DVtgsgeWHWLZzp2+3ysWG+X9BiFQz+10HZG//YrL/169dG/Pz
         e2gXSzMqq631PLWaF097C4zj9JmnSC2LOu4WdbjnwCjzjEsoCJ7qSqOvot6iju68hbST
         9xBijH2Lb3Z8iq74kyCQifZ6o1Rb7i0bK5Q1U6akgdYoiwW7YOamNC2I7BI15+CEvXNA
         uDPg==
X-Gm-Message-State: AOAM532D5twBr6KcPsvHnO4FZpxZ9iiE3VHS0ok/l6DmGVXAt0YDb8Vf
        ktj0CVUJOFFNG0YoFehMe0Hl9Q==
X-Google-Smtp-Source: ABdhPJxjmG23dUqa018/ZG8h4ifi0BCWnrdO8qVlBbTAtrb1SqpniNi3QlC+54VUGufk3ecIjoZe1Q==
X-Received: by 2002:a63:a84d:: with SMTP id i13mr53097690pgp.342.1594318171636;
        Thu, 09 Jul 2020 11:09:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id 2sm3512635pfa.110.2020.07.09.11.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:09:31 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org, enric.balletbo@collabora.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] iio: cros_ec_accel_legacy: Add Read Only frequency entries
Date:   Thu,  9 Jul 2020 11:09:24 -0700
Message-Id: <20200709180924.2437466-1-gwendal@chromium.org>
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
Changes since v2:
- fix compilation warning
Changes since v1:
- Use a static array to store the single frequency allowed.

 drivers/iio/accel/cros_ec_accel_legacy.c | 46 +++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 2532b9ad33842..b6f3471b62dcf 100644
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
@@ -120,9 +130,39 @@ static int cros_ec_accel_legacy_write(struct iio_dev *indio_dev,
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
@@ -142,7 +182,11 @@ static const struct iio_info cros_ec_accel_legacy_info = {
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

