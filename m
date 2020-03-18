Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88552189D24
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCRNhp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 09:37:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50360 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgCRNhn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 09:37:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id z13so3435277wml.0;
        Wed, 18 Mar 2020 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fg/oIfqQ+gNzoy16Mzvfp1csyxYIH4NAu3GYVv8LK7I=;
        b=H/NFPN/dCIxSzoA06xzEGbBztKMI6c7klOVBM2TwwQX5tvz6oXVo58KNcKKcetKzxk
         kcaFOz+pc+FNObg2yVLZAfZKNNVDrU1oQLKAw4kVh4Ptz8ZLMtYZp4HSYUu8O3mo+7BT
         VWbXQ+1l/SyUyJgN/7r/BitJ+hw+m5KcrCWG7jVBibf1QhOq2RFAtugZUaEFpAwFlza7
         O1MYkZseZ++mNQ0y2syyyJlxUisIUzI8ruO/ohBM0OdFqmg2N9tQfncQprIMyGvz3JgM
         7uuHFMKs1Nmo/KU8RC6fQftnUsnbNDt6yIYGfEwPx/2Ewl5lESCgSkini8Y+a/+4nvjb
         qMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fg/oIfqQ+gNzoy16Mzvfp1csyxYIH4NAu3GYVv8LK7I=;
        b=QHiV5rBjdYgRh5uq50szk9wmQRfYABSQbuKDRLP5Ie/neq1xfpzmXsbTYTC7GzrYLJ
         2PtSXurdoYlItU3JMaVe46WIIJjt7ntL1dUFj9XOjeVZbfZtTeb4jzhUPTQ420b1QBv9
         GzkWg6M9cO0T1qhYXvk6FVJm+Zqc2oxcUF6p+Oo8nVq7qiNVLlxilBmLogojc+vfrIla
         vG9WlUr6zhfPbvMlUihNIZwnvkIi0vBsZ0lOrY1UiWylTQG6kSA9hBcoml8tJO5LEMQu
         Zs+kvrZkzsIJvbDbbfx3UPQ9ojltTIngTtLYzoz1YP0jYbs+G2sdfLLA6JxMRKHwqXpi
         Jp+g==
X-Gm-Message-State: ANhLgQ3j1QpVDDyP8SnimQeWD6aQ6DY0FVfl4wm48OS0WGeQYvjzOgdg
        i/dQOcU3BL4ibxsbonN37RjaSe+F
X-Google-Smtp-Source: ADFU+vv2KwYF7ZeaI/+26c45LVnAOy7SEdmxLjXvha2ssMjE4DCXtmR+j9VM6vHIPe/PAZxiCcXN6w==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr5313681wml.116.1584538659794;
        Wed, 18 Mar 2020 06:37:39 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id f15sm9444002wru.83.2020.03.18.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:37:39 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, mircea.caprioru@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 5/5] iio: adc: ad7793: use read_avail iio hook for scale available
Date:   Wed, 18 Mar 2020 15:40:42 +0200
Message-Id: <20200318134042.30133-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318134042.30133-1-alexandru.ardelean@analog.com>
References: <20200318134042.30133-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change uses the read_avail and '.info_mask_shared_by_type_available'
modifier to set the available scale.
Essentially, nothing changes to the driver's ABI.

The main idea for this patch is to remove the AD7793 driver from
checkpatch's radar. There have been about ~3 attempts to fix/break the
'in_voltage-voltage_scale_available' attribute, because checkpatch assumed
it to be an arithmetic operation and people were trying to change that.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7793.c | 53 +++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5592ae573e6b..fad98f1801db 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -354,29 +354,28 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 static IIO_CONST_ATTR_NAMED(sampling_frequency_available_ad7797,
 	sampling_frequency_available, "123 62 50 33 17 16 12 10 8 6 4");
 
-static ssize_t ad7793_show_scale_available(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static int ad7793_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7793_state *st = iio_priv(indio_dev);
-	int i, len = 0;
 
-	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
-			       st->scale_avail[i][1]);
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		/* Values are stored in a 2D matrix  */
+		*length = ARRAY_SIZE(st->scale_avail) * 2;
 
-	len += sprintf(buf + len, "\n");
+		return IIO_AVAIL_LIST;
+	}
 
-	return len;
+	return -EINVAL;
 }
 
-static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
-		in_voltage-voltage_scale_available, S_IRUGO,
-		ad7793_show_scale_available, NULL, 0);
-
 static struct attribute *ad7793_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
 	NULL
 };
 
@@ -534,6 +533,7 @@ static const struct iio_info ad7793_info = {
 	.read_raw = &ad7793_read_raw,
 	.write_raw = &ad7793_write_raw,
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
+	.read_avail = ad7793_read_avail,
 	.attrs = &ad7793_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 };
@@ -547,7 +547,7 @@ static const struct iio_info ad7797_info = {
 };
 
 #define __AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift, _extend_name, _type, _mask_all) \
+	_storagebits, _shift, _extend_name, _type, _mask_type_av, _mask_all) \
 	{ \
 		.type = (_type), \
 		.differential = (_channel2 == -1 ? 0 : 1), \
@@ -559,6 +559,7 @@ static const struct iio_info ad7797_info = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 			BIT(IIO_CHAN_INFO_OFFSET), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_type_available = (_mask_type_av), \
 		.info_mask_shared_by_all = _mask_all, \
 		.scan_index = (_si), \
 		.scan_type = { \
@@ -574,23 +575,41 @@ static const struct iio_info ad7797_info = {
 	_storagebits, _shift) \
 	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SCALE), \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define AD7793_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
 	_storagebits, _shift) \
 	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
 		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SCALE), \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define AD7793_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
 	__AD7793_CHANNEL(_si, 0, -1, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_TEMP, \
+		0, \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define AD7793_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
 	_shift) \
 	__AD7793_CHANNEL(_si, _channel, -1, _address, _bits, \
 		_storagebits, _shift, "supply", IIO_VOLTAGE, \
+		0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7797_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7797_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
+		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		0, \
 		BIT(IIO_CHAN_INFO_SAMP_FREQ))
 
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
@@ -620,8 +639,8 @@ const struct iio_chan_spec _name##_channels[] = { \
 
 #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD7793_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7797_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7797_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
 	AD7793_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
 	AD7793_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
-- 
2.20.1

