Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3549D1BA082
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 11:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgD0J4R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbgD0J4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 05:56:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7899C0610D5;
        Mon, 27 Apr 2020 02:56:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so19811389wrx.4;
        Mon, 27 Apr 2020 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEVkzMr6z0E4N1w6xvyS7Drw+BpsL4Z8MCI9pveo6ew=;
        b=KRautktuCB9uogc76bwtrNlB+E3/1WAHuKW5gq5tvy8yndlq5u5O6H1fhgOTUvHfyC
         8tFowqZ0qr825BVXXmJi9ptktFM1Kqtk6TF+AXef6PcYccu627R6UVa6CAPBOhVx5a+c
         y91Bv8wkkiPoG7Mf3qLa0VJZU+3eLN6p/ppU9xN8xuVWheWXzXMHE7tjuPAvdW1oMvBj
         3xGdvFUHbkjxXbUJXCUhIQIACspNRuPR0ci155VK0VGWJJkEDTnjEohupmkEal76U/vC
         vkARCn+uEwb0MEf2psU5vC4y4ZEc3jIexRejMA+aVLOm0bD4jizNxbKXNwz3mbf2hPyc
         8/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEVkzMr6z0E4N1w6xvyS7Drw+BpsL4Z8MCI9pveo6ew=;
        b=o9jXIfEjyA4GBDI2qCX0g/O6xdqcodqpnbH6uvisGmVYKdmlnuxE+TOH9P03rHMmE0
         +flk8VQ7Y4WeYXQbc/9xIugeFhQ/+q06tkrCQBCvCbaQAuUdqtT5crWPXqAYCevSzz9f
         vjxHlykkjR5fXh2WaFntcpkI6N0lrAEbuVouoGdZ+deiGfmeokKothpn1x2GI+IAknn+
         F4ksletyA4oTEIqR+9VXY2WfgeFRiVtP+e7tPhX5fpX3ktKgQ944dv50uqEumJBiZi3f
         DvcIzz+dNiKtKs9/6NrbC7970DnxnjfryLUNcamicFJgSp10BeE+F4gk0VOl+M2jmtgG
         BCWA==
X-Gm-Message-State: AGi0PubDQ55DDciP6sVl+l+8N3YwOeO4RQKD2s1JJHZquqSal45dFoiC
        oqZ8gTrMI9WSSlEzxIyf6DzGt16JCKc=
X-Google-Smtp-Source: APiQypKQ27HFm73+63sn8d2HS0IWx9al1/5J9ud8pLAjnrpSEAcbHHBQKjULLKlDUUuUA3C46Zahug==
X-Received: by 2002:adf:9564:: with SMTP id 91mr27396960wrs.246.1587981372395;
        Mon, 27 Apr 2020 02:56:12 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:7069:9b5d:ebe2:85b8])
        by smtp.gmail.com with ESMTPSA id y10sm14487606wma.5.2020.04.27.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 02:56:11 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v6 4/5] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
Date:   Mon, 27 Apr 2020 11:55:58 +0200
Message-Id: <20200427095559.16131-5-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200427095559.16131-1-m.othacehe@gmail.com>
References: <20200427095559.16131-1-m.othacehe@gmail.com>
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

