Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0C302031
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 03:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbhAYCNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 21:13:32 -0500
Received: from m12-18.163.com ([220.181.12.18]:38156 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbhAYCNE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 21:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=io0AEOw0uob5Qbn+w5
        V1NwepDBt67XvadtkYGlmb31k=; b=NF8Ahen+6vNnSm1DXJlso1KE7SwjSH24JD
        efxmUO1r4jwRuegdfzpZhDiWbOCTLv6LUFI512wHGDYSxOEaitaL5Zm9jj4qMOKW
        6zKqakzlC4sTqckel+44czjjJhNvjbOAmV8n4T51TB6fRZhz4rugJq9gGvi4r62K
        yYEipi6gs=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAAH4c6pJA5gG6WFQw--.9008S2;
        Mon, 25 Jan 2021 09:53:52 +0800 (CST)
From:   Guoqing Chi <chi962464zy@163.com>
To:     trix@redhat.com
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, huyue2@yulong.com,
        linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        chiguoqing@yulong.com, chiguoqing <chi962464zy@163.com>
Subject: [PATCH v2 resend] iio: imu: bmi160: add mutex_lock for avoiding race
Date:   Mon, 25 Jan 2021 09:53:44 +0800
Message-Id: <20210125015344.106-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowAAH4c6pJA5gG6WFQw--.9008S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWkGw47ZF4Duw1rZFykuFg_yoW5Zr4DpF
        17Cr45ArZ3XF1xCrnrZr95ZFyYg34SgF1UJ34Iga45Z3yYyF1Ykrn8ta4SvFnYkryUAr4a
        grW8Xr4ruF4qvw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRCJPiUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbBSRYjRFaD9chowAABs5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: chiguoqing <chi962464zy@163.com>

Adding mutex_lock, when read and write reg need to use this lock to
avoid race.

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2:Follow write function to fix read function.
Adding mutex init in core probe function.
Adding break in switch case at read and write function.

 drivers/iio/imu/bmi160/bmi160.h      |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 34 +++++++++++++++++++---------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 32c2ea2d7112..0c189a8b5b53 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -3,9 +3,11 @@
 #define BMI160_H_
 
 #include <linux/iio/iio.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
 
 struct bmi160_data {
+	struct mutex lock;
 	struct regmap *regmap;
 	struct iio_trigger *trig;
 	struct regulator_bulk_data supplies[2];
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 290b5ef83f77..e303378f4841 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -452,26 +452,32 @@ static int bmi160_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct bmi160_data *data = iio_priv(indio_dev);
 
+	mutex_lock(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = bmi160_get_data(data, chan->type, chan->channel2, val);
-		if (ret)
-			return ret;
-		return IIO_VAL_INT;
+		if (!ret)
+			ret = IIO_VAL_INT;
+		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		ret = bmi160_get_scale(data,
 				       bmi160_to_sensor(chan->type), val2);
-		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+		if (!ret)
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = bmi160_get_odr(data, bmi160_to_sensor(chan->type),
 				     val, val2);
-		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+		if (!ret)
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+	mutex_unlock(&data->lock);
 
-	return 0;
+	return ret;
 }
 
 static int bmi160_write_raw(struct iio_dev *indio_dev,
@@ -479,19 +485,24 @@ static int bmi160_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct bmi160_data *data = iio_priv(indio_dev);
+	int result;
 
+	mutex_lock(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		return bmi160_set_scale(data,
+		result = bmi160_set_scale(data,
 					bmi160_to_sensor(chan->type), val2);
+		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return bmi160_set_odr(data, bmi160_to_sensor(chan->type),
+		result = bmi160_set_odr(data, bmi160_to_sensor(chan->type),
 				      val, val2);
+		break;
 	default:
-		return -EINVAL;
+		result = -EINVAL;
 	}
+	mutex_unlock(&data->lock);
 
-	return 0;
+	return result;
 }
 
 static
@@ -838,6 +849,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
 
-- 
2.17.1


