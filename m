Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880E61B45ED
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDVNJS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgDVNJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 09:09:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF276C03C1A9;
        Wed, 22 Apr 2020 06:09:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so2242783wmk.5;
        Wed, 22 Apr 2020 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1Mf0H3vRylE7+DAuIcmMCayD/UtsuUnHkFYxcx4ItY=;
        b=ljzXhu97nV79eOcApdhTW2dXgKc9nPsgh/Ut3w2IhkJPSQUx+jQunUsZhgkf8y18FF
         UWRGkm98D/o66DmfwlcOZkLuSUt3oGvE6F1O6FzAv/uEpnRYOzY6azaMssTytBHbx+ZR
         TXcHPpP33vYi8hNRaEPelq5Hjaa89d7WpnqpaTLV7SryQxlHsaM42IGMLt3mh20DaUbh
         HXRyoRG+hkPGPbiIYk/Vh+f2CzEgXYnb0NLJxGoDcMaKBGlF4phw8LjMBfONGuQYw9Su
         w7bFpEKg5rZdcbUym/1ny2urJ1WxS0bv1Hns8kvExR4342GsS2pJKRCx2wrqdvmvGU+2
         LaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1Mf0H3vRylE7+DAuIcmMCayD/UtsuUnHkFYxcx4ItY=;
        b=MfUX2WzhnAZ2SB9LjwAejMw57fbM3hdm6xJKoby19NmEghp8Rpv0uVGqNMQ20PdQJ6
         53ZK+aZk+N7Qil+8RYLnuIZLaJ3S0PXPCZspC0e0L/2fGgb4rKvCoYTUa+zMhwN3TlkK
         Fvzepo4YoYnKH5pD1gzVVf2CFTJpFVuD0kFKYAEpJ44bLhfYgQ2dKChMpJ8wgFubqs3L
         cIlKPX7zjslandfOzYoVkWwgty7kdWMmP88yLE/edbK6l3aEYRK123VH2dq33htzQuVw
         npVUeHu/Si4DuKTvWAbRARri5G3QDLg4KdULFt7+uHHBpfAkJe7zYr2Xb/MsCoJ0vi7k
         xZkg==
X-Gm-Message-State: AGi0PuYj5xqcO5nnEQEXh6+TZq8HS2ykYjHbBpLb+BxI1Ct9TdU2NcUc
        KHV41MzoQKwd51aHkFavo+4=
X-Google-Smtp-Source: APiQypJ2P1nWHujxrhLUN5VbmHA9PJNi8YQPRYfaszcxKSb8l/J2T0YhZL3Ytij/igoR9vdHTVgVHQ==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr10810816wmm.48.1587560949669;
        Wed, 22 Apr 2020 06:09:09 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:8872:7e71:5cf6:8a5b])
        by smtp.gmail.com with ESMTPSA id o3sm2064820wru.68.2020.04.22.06.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 06:09:09 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v5 3/4] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
Date:   Wed, 22 Apr 2020 15:08:55 +0200
Message-Id: <20200422130856.1722-4-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422130856.1722-1-m.othacehe@gmail.com>
References: <20200422130856.1722-1-m.othacehe@gmail.com>
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
index 4041608910d0..aefb549953ad 100644
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
+	{250, 0},
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
 static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
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
+	const unsigned int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
+	unsigned int i = len;
+
+	do {
+		if (val > vcnl4010_prox_sampling_frequency[i][0])
+			break;
+	} while (--i);
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

