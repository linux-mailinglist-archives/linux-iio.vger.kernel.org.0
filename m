Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398141B2078
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgDUHzs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 03:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgDUHzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 03:55:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035BC061A10;
        Tue, 21 Apr 2020 00:55:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so6172078wrr.0;
        Tue, 21 Apr 2020 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBWormxC0pAJBGBFZXewLI5rZIBOp3/LX/Utp/KGK9c=;
        b=Jz9NOWgk4d4cLQiifV9b/bWqbCboH6uSQtgwKRYNnfhVcHGZ0Svy34atdkhPuXhfxN
         dVAHvQETyPb/poH0zcEfBzwjK/1ThlWPbZbeUQxXswPn/ylcm/UONSV2Fhaa9K1zpviQ
         smDoUoB5a36pMPulo1rWJolOR0LSw8Iygpb0Lg5InvAfTaiXoj1WT4KrjDSndZzyflZY
         OGeVZNc5KaBJdZEOdHq21ChpqqBZdLEUasTS7niqSsMe7q8RMUVjGiEHKpfH4ipX9v/W
         evzWUmechHUjAhbhvBkyyy0dCHRYWG/iSi9KK3fPTPeWLKkMeOjNSEkXnkdnkYllKDN6
         1uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBWormxC0pAJBGBFZXewLI5rZIBOp3/LX/Utp/KGK9c=;
        b=n2QietuC495dH+qzHMsFtqF22K2FSL9sufDdy5CJQHazXzHc+XLr6wpSpQ7jijo35x
         fDN92hdTB1w4dyo/SqCjn0pnHC6fMJKIZ5q+xf19ObamVscX2nbP9MKBu6b9VX7gz54w
         ZjoeiZEIjI/iuRBehAg+3Yr8BaRNirm+AS+G1BcelCyDstj6nmq+xwJn3D3vr0MCeTnJ
         8gi86iXchprrpV0FoCBNTYLOF1eXxKNeRhNH6zhfW8Vp5YvW6NjJP86WYIRXrpi+po+D
         dXr2glKCV3xjjTcoxk/ZTTQnwYjouoQILUoNoG8JQ5fu6iWw13OAUG7528QWpPRsbkDb
         9KdQ==
X-Gm-Message-State: AGi0PuYIdrCfcln7t02DIF/DFK0QeFBCuOIY6GfOjQlqInuWfTufAHe8
        1SxOmnbHvpjJ++DE54N41sY=
X-Google-Smtp-Source: APiQypL+/6aWzwHB0OXmcLeoNeiPGSy+CVQtx2UkyIrLfzLY3ccgmsHqJpKOR/wl0KLSeXFF6GiHqA==
X-Received: by 2002:adf:afc6:: with SMTP id y6mr21949523wrd.74.1587455742413;
        Tue, 21 Apr 2020 00:55:42 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:f9a2:4:b043:a3fb])
        by smtp.gmail.com with ESMTPSA id c190sm2514510wme.10.2020.04.21.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:55:41 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v4 3/4] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
Date:   Tue, 21 Apr 2020 09:55:31 +0200
Message-Id: <20200421075532.19192-4-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200421075532.19192-1-m.othacehe@gmail.com>
References: <20200421075532.19192-1-m.othacehe@gmail.com>
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
 drivers/iio/light/vcnl4000.c | 112 ++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index db5c15541174..1e00a9666534 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -86,6 +86,19 @@
 #define VCNL4010_INT_DRDY \
 	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
 
+#define VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE  \
+	"1.95 3.90 7.81 16.62 31.25 62.5 125 250"
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
 
@@ -366,6 +379,24 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
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
 static bool vcnl4010_in_periodic_mode(struct vcnl4000_data *data)
 {
 	int ret;
@@ -459,11 +490,75 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
 
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
 
+static int vcnl4010_write_proxy_samp_freq(struct vcnl4000_data *data, int val,
+					  int val2)
+{
+	int i;
+	const int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
+
+	for (i = 0; i < len; i++) {
+		if (val <= vcnl4010_prox_sampling_frequency[i][0])
+			break;
+	}
+
+	if (i == len)
+		return -EINVAL;
+
+	return i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE, i);
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
@@ -668,23 +763,38 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
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
 
+static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
+		      VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE);
+
+static struct attribute *vcnl4010_attributes[] = {
+	&iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group vcnl4010_attribute_group = {
+	.attrs = vcnl4010_attributes,
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

