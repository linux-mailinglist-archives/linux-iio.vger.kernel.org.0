Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD41C2AEE
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgECJc1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728042AbgECJcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 05:32:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB956C061A0F;
        Sun,  3 May 2020 02:32:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so17215445wrb.8;
        Sun, 03 May 2020 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEVkzMr6z0E4N1w6xvyS7Drw+BpsL4Z8MCI9pveo6ew=;
        b=JTfbZzsRD5FEAtKAv7LjZSV23RJroAhBbat2MmM4sStt0BIPlU7p5q7xGsCFzNOm4W
         jhbw3qSabgjBkHF8BM4ynXZiqk9kcbLfmmjAYiQLaUr+vW+kZbaOxGnwrOL6ud7dFqry
         cG0zpUIYzMom4gzuIlSCHmwFGb2jrRfUkoL87IDhUe9OuPx8vp9EomsdYMZ+Nz1P7TXY
         8flr6sIfPO5NFW5gwFx+4Y/JdwZ7YE9j6WTioct0OJrw2CXiz/HC+pMiED2m8+oh5cL5
         7UXJVNyCuttxrorh4Hd6NLjQ6WECO51xM/NBHWjTkdFS3p1Tvt1usNuHC2uplORUKXd5
         1eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEVkzMr6z0E4N1w6xvyS7Drw+BpsL4Z8MCI9pveo6ew=;
        b=T03syJk431ctQNy58JiLx8ckqozU2JlAMm/RRMgNT/LAt4/l2XEDiXgibWzNT+/Gwr
         EosGSGmH629pRKDO6FMM18FIB5/XML1CKq4rB8jC/37MwjuIY1RDUbI03wL40cme1//S
         BJILV3b0eMI51xx/bKOF0G1TSYAIqUvsMOmho4K2yS8CWS5lvK+Uc9/d38BLOKuDge0s
         DuvRbDPPQowLyGMMS7O1hKs4kLZtEogTzQqOxJGwwVDGZF/3XwH2nDhpDt4MirEBT2XH
         neXpXotAsIQHiG9ll/khrnvhRa7kMLtlkhYUBGbizgKBrrt65zQerLwsqmxhYRtCh+aM
         0kdQ==
X-Gm-Message-State: AGi0Pub3CppIh6C3Tb5h0toNVOAnSSzqkhC4OuvNTOnw348Rw6eUWAIc
        57uoljmcJCkbxKIw7/v2i3o=
X-Google-Smtp-Source: APiQypL6QCwBdkDNBUXEnhQgAkcCiTBp2R+0CK23GEb4hH5lCYbEcE0uvjVINI4FJq2opQQCmFqd+Q==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr12857856wrr.305.1588498343569;
        Sun, 03 May 2020 02:32:23 -0700 (PDT)
Received: from meru.home ([2a01:cb18:832e:5f00:1cf0:acc0:9003:83d6])
        by smtp.gmail.com with ESMTPSA id e17sm10086963wrr.32.2020.05.03.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:32:23 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v7 4/5] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
Date:   Sun,  3 May 2020 11:29:58 +0200
Message-Id: <20200503092959.8806-5-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200503092959.8806-1-m.othacehe@gmail.com>
References: <20200503092959.8806-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add sampling frequency support for proximity data on VCNL4010 and VCNL4020
chips.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 118 ++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e7653037fa5d..65c0cf2b5037 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -86,6 +86,16 @@
 #define VCNL4010_INT_DRDY \
 	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
 
+static const int vcnl4010_prox_sampling_frequency[][2] = {
+	{1, 950000},
+	{3, 906250},
+	{7, 812500},
+	{16, 625000},
+	{31, 250000},
+	{62, 500000},
+	{125, 0},
+	{250, 0},
+};
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
@@ -363,6 +373,24 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
 	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
 }
 
+static int vcnl4010_read_proxy_samp_freq(struct vcnl4000_data *data, int *val,
+					 int *val2)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_PROX_RATE);
+	if (ret < 0)
+		return ret;
+
+	if (ret >= ARRAY_SIZE(vcnl4010_prox_sampling_frequency))
+		return -EINVAL;
+
+	*val = vcnl4010_prox_sampling_frequency[ret][0];
+	*val2 = vcnl4010_prox_sampling_frequency[ret][1];
+
+	return 0;
+}
+
 static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
 {
 	int ret;
@@ -456,11 +484,95 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
 
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = vcnl4010_read_proxy_samp_freq(data, val, val2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
 }
 
+static int vcnl4010_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)vcnl4010_prox_sampling_frequency;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = 2 * ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4010_write_proxy_samp_freq(struct vcnl4000_data *data, int val,
+					  int val2)
+{
+	unsigned int i;
+	int index = -1;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4010_prox_sampling_frequency); i++) {
+		if (val == vcnl4010_prox_sampling_frequency[i][0] &&
+		    val2 == vcnl4010_prox_sampling_frequency[i][1]) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0)
+		return -EINVAL;
+
+	return i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE,
+					 index);
+}
+
+static int vcnl4010_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	int ret;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Protect against event capture. */
+	if (vcnl4010_is_in_periodic_mode(data)) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = vcnl4010_write_proxy_samp_freq(data, val, val2);
+			goto end;
+		default:
+			ret = -EINVAL;
+			goto end;
+		}
+	default:
+		ret = -EINVAL;
+		goto end;
+	}
+
+end:
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
+}
+
 static int vcnl4010_read_event(struct iio_dev *indio_dev,
 			       const struct iio_chan_spec *chan,
 			       enum iio_event_type type,
@@ -663,7 +775,9 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
 			BIT(IIO_CHAN_INFO_SCALE),
 	}, {
 		.type = IIO_PROXIMITY,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.event_spec = vcnl4000_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
 		.ext_info = vcnl4000_ext_info,
@@ -676,6 +790,8 @@ static const struct iio_info vcnl4000_info = {
 
 static const struct iio_info vcnl4010_info = {
 	.read_raw = vcnl4010_read_raw,
+	.read_avail = vcnl4010_read_avail,
+	.write_raw = vcnl4010_write_raw,
 	.read_event_value = vcnl4010_read_event,
 	.write_event_value = vcnl4010_write_event,
 	.read_event_config = vcnl4010_read_event_config,
-- 
2.26.0

