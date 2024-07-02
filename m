Return-Path: <linux-iio+bounces-7128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8F923D02
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 13:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A1CB21BF9
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1F15B54B;
	Tue,  2 Jul 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVtIfD4q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D515B153;
	Tue,  2 Jul 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921480; cv=none; b=ZmjqPKxmWvvZZijbiNsBjf0nF9FRxZlFgJjFw+SwTGFznAOAL5aTWQlhiCoFz0nrCOYqkbZUNoIw4kIzQu/PpjbCvyxetr1Uecx7m0VGIJlPh8zBizTgYz3RqP8fTktQw3Qlp2WQdX0r3s69eQzbP3wShp7TStRfy7DyzgVUWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921480; c=relaxed/simple;
	bh=8tBn7d9egtTfk6RcgKGNq8THWiD8xgGZ5iRUzbFRRY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIvI8gCtV0ja1TB3s7Clg+8kEHs/Ali75MYdQTHckp+VoErshshVsCuqTMKplQV3GCIxDuOZ8DmrQGLlXysFIRWI3MCho6dvLeT09PPrxAccUgRZlvf8wImvPcBfPG111HeqtJH4yl8x5l5VqXOX+Cd7bkjtmeZDzEV4ufNvm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVtIfD4q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso2924888a91.2;
        Tue, 02 Jul 2024 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719921477; x=1720526277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MW+eKYzT1rkuJCvQPjaZc5Cbl0mGwx+TZKnAq/vbJZ8=;
        b=BVtIfD4qt86Wq1SnOar8DFbMKGsk9Q9sdeXSTzMCqPvmXJ+nS0RITbBFDIP1CITqXF
         jJL/9PYZULxc98t+e8QKWQjT1e6vvbBpnSVO0AgU7sSIVnZOnGAB/Me12qtgagJEhu40
         I4Ejg7KUfMxs4pEfqOPLkJWaLj+jDQ3Z6f/DgaW56KAE8CA1eslLJ3NpqR9TQKHABZgY
         1FpxqVc3Ssm+zBzn5nhe45wf+h4Au1t1QAorvLkheWJE1+m+RgHSHN//KOINicnqlELW
         WHjAfvZbxaEcA7VMXbhmlVsDExAytX6aD5vEA56xc2ksU4ICEQVHoeg3aq2PEM1MnVL+
         GEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719921477; x=1720526277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MW+eKYzT1rkuJCvQPjaZc5Cbl0mGwx+TZKnAq/vbJZ8=;
        b=WfeeWzb9pNhmJLrnEl2naeYWdC4fBYVeLyyYWUmkghXrwZztxwq0YjOSvxR6gLbIh5
         ob0kMmlhI1x0PGov1UXsANnGvq6Ft7ox+cZMPw32WbQyjpYRVnTtXiPbqg2q1Tcl/tug
         xod8pTOoBcFrrO9dsYcRuLzv2Ae+2nIohv8Trp8xBki6/KxGt8ZRbn/EFqfVbZnF3e6q
         ICF4FCbavTOhmI/aMkkifgHoPuDwzzf4DkxVjc7ZHMJJ7A62pUTzheBspBRkFaDzKQ1N
         w/w/A45O8Ai29ke9FhdiQOb009QAelJLK33TnBGyK+ZMHneWXCy3FPRegUA+pnnT6nMF
         km6w==
X-Forwarded-Encrypted: i=1; AJvYcCU0v97CS85Oa9ae1UMqfXzKm7saOYCefra9+fwzn5QLCu5JlBW4tSkhYW5DA8hiLhGtcRINMuY/6HtLbn58U520Ue/2pte2+6AFEkOs
X-Gm-Message-State: AOJu0Yx3hEJttBJNOch6I0zzfdQiudYRvT1Z0lqauRt2L/tq4hIOJkd4
	04qP0YdS3A7Mimw2Jw5RMdjfCCzRDY/THpM09hlcrtGwmEgbgymcVykxLgxLYnZxag==
X-Google-Smtp-Source: AGHT+IGI2ZGzFpcZQXzyWS3DNBvkJNfTL+NsUb/2LpOZVg8xlBhPosJO0huzUD6m+N2nFUYfPLmlew==
X-Received: by 2002:a17:90b:3a8e:b0:2c9:321:1bf1 with SMTP id 98e67ed59e1d1-2c93d775a7amr6994418a91.39.1719921477141;
        Tue, 02 Jul 2024 04:57:57 -0700 (PDT)
Received: from localhost.localdomain ([182.66.218.119])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91ce71017sm8621186a91.29.2024.07.02.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:57:56 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] iio: light: apds9960: Add proximity and gesture offset calibration
Date: Tue,  2 Jul 2024 17:26:48 +0530
Message-ID: <20240702115648.160511-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proximity and gesture offset registers perform offset correction to improve
cross-talk performance. Add support for reading from and writing to
proximity and gesture offset registers. Create sysfs attributes for
them via iio to expose them to userspace.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/apds9960.c | 245 +++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 1065a340b..bccf9a8c7 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -101,6 +101,10 @@
 #define APDS9960_MAX_ALS_THRES_VAL	0xffff
 #define APDS9960_MAX_INT_TIME_IN_US	1000000
 
+/* MIN and MAX offset from pg: 26 of the datasheet */
+#define MIN_OFFSET -127
+#define MAX_OFFSET 127
+
 enum apds9960_als_channel_idx {
 	IDX_ALS_CLEAR, IDX_ALS_RED, IDX_ALS_GREEN, IDX_ALS_BLUE,
 };
@@ -316,6 +320,234 @@ static const struct iio_chan_spec apds9960_channels[] = {
 	APDS9960_INTENSITY_CHANNEL(BLUE),
 };
 
+static ssize_t apds9960_proximity_offset_ur_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	if (kstrtoint(buf, 10, &offset))
+		return -EINVAL;
+
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9960_REG_POFFSET_UR, offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "proximity offset reg write failed\n");
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t apds9960_proximity_offset_dl_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	if (kstrtoint(buf, 10, &offset))
+		return -EINVAL;
+
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9960_REG_POFFSET_DL, offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "proximity offset reg write failed\n");
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t apds9960_proximity_offset_ur_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	ret = regmap_read(data->regmap, APDS9960_REG_POFFSET_UR, &offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "proximity offset reg read failed\n");
+		return ret;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", offset);
+}
+
+static ssize_t apds9960_proximity_offset_dl_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	ret = regmap_read(data->regmap, APDS9960_REG_POFFSET_DL, &offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "proximity offset reg read failed\n");
+		return ret;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", offset);
+}
+
+static ssize_t apds9960_gesture_offset_u_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	if (kstrtoint(buf, 10, &offset))
+		return -EINVAL;
+
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9960_REG_GOFFSET_U, offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg write failed\n");
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t apds9960_gesture_offset_d_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	if (kstrtoint(buf, 10, &offset))
+		return -EINVAL;
+
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9960_REG_GOFFSET_D, offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg write failed\n");
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t apds9960_gesture_offset_l_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	if (kstrtoint(buf, 10, &offset))
+		return -EINVAL;
+
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9960_REG_GOFFSET_L, offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg write failed\n");
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t apds9960_gesture_offset_r_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	if (kstrtoint(buf, 10, &offset))
+		return -EINVAL;
+
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9960_REG_GOFFSET_R, offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg write failed\n");
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t apds9960_gesture_offset_u_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	ret = regmap_read(data->regmap, APDS9960_REG_GOFFSET_U, &offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg read failed\n");
+		return ret;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", offset);
+}
+
+static ssize_t apds9960_gesture_offset_d_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	ret = regmap_read(data->regmap, APDS9960_REG_GOFFSET_D, &offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg read failed\n");
+		return ret;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", offset);
+}
+
+static ssize_t apds9960_gesture_offset_l_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	ret = regmap_read(data->regmap, APDS9960_REG_GOFFSET_L, &offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg read failed\n");
+		return ret;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", offset);
+}
+
+static ssize_t apds9960_gesture_offset_r_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9960_data *data = iio_priv(indio_dev);
+	int offset;
+	int ret;
+
+	ret = regmap_read(data->regmap, APDS9960_REG_GOFFSET_R, &offset);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "gesture offset reg read failed\n");
+		return ret;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", offset);
+}
+
 /* integration time in us */
 static const int apds9960_int_time[][2] = {
 	{ 28000, 246},
@@ -332,10 +564,23 @@ static IIO_CONST_ATTR(proximity_scale_available, "1 2 4 8");
 static IIO_CONST_ATTR(intensity_scale_available, "1 4 16 64");
 static IIO_CONST_ATTR_INT_TIME_AVAIL("0.028 0.1 0.2 0.7");
 
+static IIO_DEVICE_ATTR(proximity_offset_ur, S_IRUGO | S_IWUSR, apds9960_proximity_offset_ur_show, apds9960_proximity_offset_ur_store, 0);
+static IIO_DEVICE_ATTR(proximity_offset_dl, S_IRUGO | S_IWUSR, apds9960_proximity_offset_dl_show, apds9960_proximity_offset_dl_store, 0);
+static IIO_DEVICE_ATTR(gesture_offset_u, S_IRUGO | S_IWUSR, apds9960_gesture_offset_u_show, apds9960_gesture_offset_u_store, 0);
+static IIO_DEVICE_ATTR(gesture_offset_d, S_IRUGO | S_IWUSR, apds9960_gesture_offset_d_show, apds9960_gesture_offset_d_store, 0);
+static IIO_DEVICE_ATTR(gesture_offset_l, S_IRUGO | S_IWUSR, apds9960_gesture_offset_l_show, apds9960_gesture_offset_l_store, 0);
+static IIO_DEVICE_ATTR(gesture_offset_r, S_IRUGO | S_IWUSR, apds9960_gesture_offset_r_show, apds9960_gesture_offset_r_store, 0);
+
 static struct attribute *apds9960_attributes[] = {
 	&iio_const_attr_proximity_scale_available.dev_attr.attr,
 	&iio_const_attr_intensity_scale_available.dev_attr.attr,
 	&iio_const_attr_integration_time_available.dev_attr.attr,
+	&iio_dev_attr_proximity_offset_ur.dev_attr.attr,
+	&iio_dev_attr_proximity_offset_dl.dev_attr.attr,
+	&iio_dev_attr_gesture_offset_u.dev_attr.attr,
+	&iio_dev_attr_gesture_offset_d.dev_attr.attr,
+	&iio_dev_attr_gesture_offset_l.dev_attr.attr,
+	&iio_dev_attr_gesture_offset_r.dev_attr.attr,
 	NULL,
 };
 
-- 
2.43.0


