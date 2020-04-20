Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805081B04AC
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDTInJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgDTInI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 04:43:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E6C061A10;
        Mon, 20 Apr 2020 01:43:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so5618225wrt.1;
        Mon, 20 Apr 2020 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwLYhnxuEUwzswmGvsXUtpaJ8gW4VuGHtSP6F0cg9cg=;
        b=DtnSVD2nB2U20U5mkMq0z0FcS2GeX1p4jNhK3ELnEMfN1ZesuypzDfcjMx0Brx622l
         WfXCI+bnLeJqQhyqq1EayGo0ylnGQH/VXQqwfar27Mh32qbkTVjEZgyOy7gydQC57Kvx
         t9tcIC/kKV9AYS2JPGhDyvdsOqbHKYacRmYbh0IrjKQj8e/66QUh5v+ETfszE3XQ1JxM
         OGyWzuXurYKL39ZoLq36gXAekOQbF9eM9e6QZdGBk3UNU+MjcL/Z4os0uZL7ct7k1r+s
         CktrCjWOkrUaTBS/28IDamXIe/HNbZobDHc8tTv3wz8WMrGTPLPrSzDQ4HPaEOjLDTeX
         rHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwLYhnxuEUwzswmGvsXUtpaJ8gW4VuGHtSP6F0cg9cg=;
        b=b3ZoYTDOHpbK+NQ/ziQPXESZQhUOC1TDZj22TIb0Dx2C9ooiJMa3MVr7nMrhzwDBhT
         fgN1j6BC47BO+ngf6Yl+1jWZuvRUy+vf3EqqxYHi6CbyL0WRurhJQXWxnnzWre/5Rc84
         fY1zAo8vRZ58wLnPxl3m9dQNniyNufMiyJ515mrRUdS4YxxnRmJkgN+ld/FowT5yXZCf
         TWGjaMb7idRayBVqArdyqDeky6u1jDtcQrKFeX27NfUDHeZ2fHOU0DKhPV616ePXyzva
         5JftLNzHW4V/oDy2hURctZHSsg+U56zY2zrvdZXOq+t2xQXNio7PGzigVODT+Z9C5EQh
         o0uw==
X-Gm-Message-State: AGi0PuYQ2C3oDjJ7m5oj9TLqxCVPt4DnGSNLV5TGaexwh5HpYrPI4bwv
        dwJ0FpjmH1uIshx8H5ZJXxfKQfMWof8=
X-Google-Smtp-Source: APiQypKHk2cpFzAnIOi/nXBXiyWiNdzRpjiVCQWeGDJDdwD1mXZcVaxFOqKZScf6RyUyIXm2ixUEEQ==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr19099617wrq.204.1587372186547;
        Mon, 20 Apr 2020 01:43:06 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:c546:5ea:178b:4074])
        by smtp.gmail.com with ESMTPSA id g74sm403183wme.44.2020.04.20.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:43:05 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 3/4] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
Date:   Mon, 20 Apr 2020 10:42:09 +0200
Message-Id: <20200420084210.14245-4-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420084210.14245-1-m.othacehe@gmail.com>
References: <20200420084210.14245-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add sampling frequency support for ambient light and proximity data on
VCNL4010 and VCNL4020 chips.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 191 ++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 73a3627d12b8..3f9d63858b51 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -88,6 +88,24 @@
 #define VCNL4010_INT_DRDY \
 	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
 
+#define VCNL4010_ALS_SAMPLING_FREQUENCY_AVAILABLE \
+	"1 2 3 4 5 6 8 10"
+#define VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE  \
+	"1.95 3.90 7.81 16.62 31.25 62.5 125 250"
+
+static const int vcnl4010_als_sampling_frequency[] = {
+	1, 2, 3, 4, 5, 6, 8, 10};
+
+static const int vcnl4010_prox_sampling_frequency[][2] = {
+	{1, 950000},
+	{3, 906250},
+	{7, 812500},
+	{16, 625000},
+	{31, 250000},
+	{62, 500000},
+	{125, 0},
+	{250, 0}
+};
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
@@ -393,6 +411,50 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
 	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
 }
 
+static int vcnl4010_read_proxy_samp_freq(struct vcnl4000_data *data, int *val,
+					 int *val2)
+{
+	int ret;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_PROX_RATE);
+	if (ret < 0)
+		goto end;
+
+	if (ret >= ARRAY_SIZE(vcnl4010_prox_sampling_frequency))
+		return -EINVAL;
+
+	*val = vcnl4010_prox_sampling_frequency[ret][0];
+	*val2 = vcnl4010_prox_sampling_frequency[ret][1];
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
+static int vcnl4010_read_als_samp_freq(struct vcnl4000_data *data, int *val)
+{
+	int ret;
+	int index, mask = 0x70;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ALS_PARAM);
+	if (ret < 0)
+		goto end;
+
+	index = (ret & mask) >> 4;
+	if (index < 0 || index >= ARRAY_SIZE(vcnl4010_als_sampling_frequency))
+		return -EINVAL;
+
+	*val = vcnl4010_als_sampling_frequency[index];
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
 static int vcnl4010_in_periodic_mode(struct vcnl4000_data *data)
 {
 	int ret;
@@ -493,11 +555,119 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
 
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = vcnl4010_read_proxy_samp_freq(data, val, val2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_LIGHT:
+			ret = vcnl4010_read_als_samp_freq(data, val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
 }
 
+static int vcnl4010_write_proxy_samp_freq(struct vcnl4000_data *data, int val,
+					  int val2)
+{
+	int ret;
+	int i;
+	int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
+
+	for (i = 0; i < len; i++) {
+		if (val <= vcnl4010_prox_sampling_frequency[i][0])
+			break;
+	}
+
+	if (i == len)
+		return -EINVAL;
+
+	mutex_lock(&data->vcnl4000_lock);
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE, i);
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
+static int vcnl4010_write_als_samp_freq(struct vcnl4000_data *data, int val)
+{
+	int ret;
+	int i;
+	int param;
+	int mask = 0x70;
+	int len = ARRAY_SIZE(vcnl4010_als_sampling_frequency);
+
+	for (i = 0; i < len; i++) {
+		if (val <= vcnl4010_als_sampling_frequency[i])
+			break;
+	}
+
+	if (i == len)
+		return -EINVAL;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ALS_PARAM);
+	if (ret < 0)
+		goto end;
+
+	param = (ret & ~mask) | (i << 4);
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ALS_PARAM,
+					param);
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
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
+	if (vcnl4010_in_periodic_mode(data)) {
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
+		case IIO_LIGHT:
+			ret = vcnl4010_write_als_samp_freq(data, val);
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
@@ -710,27 +880,46 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
 		.type = IIO_LIGHT,
 		.scan_index = -1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			BIT(IIO_CHAN_INFO_SCALE),
 	}, {
 		.type = IIO_PROXIMITY,
 		.scan_index = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.event_spec = vcnl4000_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
 		.ext_info = vcnl4000_ext_info,
 	},
 };
 
+static IIO_CONST_ATTR(in_illuminance_sampling_frequency_available,
+		      VCNL4010_ALS_SAMPLING_FREQUENCY_AVAILABLE);
+static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
+		      VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE);
+
+static struct attribute *vcnl4010_attributes[] = {
+	&iio_const_attr_in_illuminance_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group vcnl4010_attribute_group = {
+	.attrs = vcnl4010_attributes
+};
+
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
 };
 
 static const struct iio_info vcnl4010_info = {
 	.read_raw = vcnl4010_read_raw,
+	.write_raw = vcnl4010_write_raw,
 	.read_event_value = vcnl4010_read_event,
 	.write_event_value = vcnl4010_write_event,
 	.read_event_config = vcnl4010_read_event_config,
 	.write_event_config = vcnl4010_write_event_config,
+	.attrs    = &vcnl4010_attribute_group,
 };
 
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
-- 
2.26.0

