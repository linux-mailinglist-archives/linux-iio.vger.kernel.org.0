Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6731258A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBGPuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhBGPuK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A10464E43;
        Sun,  7 Feb 2021 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712939;
        bh=8yGo+9mnx7F2gVtRoGJV2aljS8VDxMrMfT2/TfOUKe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOUhFRUW2mugBW3EF0xaNjPRwvSQJ3eEBl9ii1pK7viHhZ/EWD+7+Kb/BhK0xjfqE
         QD/oEybxRwR0askl5TNroicsfh4B5NSuDIpCQ3xjfgwH36M1dzio78hoZxsD14+kYU
         We9GH03L6Pu44UtoQnhtqKksyfsoydtMnhHuqESemYZt8A2ML5351+wML+VHPfzooF
         ZsHu6LN3psuxz0BG51PhuZMNwiu9vXLBAJC/pWCAxtUCJ0Aaq8MNfM6m8oG28o9Wv5
         BAOroY2f+fTLaB67RBGxjM/m9Zo+ylrRHx1zk50+yS/rAIl8DxjHr7VFXT4qThUUBH
         LYoOKCSh3JKAw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/24] staging:iio:cdc:ad7150: Change timeout units to seconds and use core support
Date:   Sun,  7 Feb 2021 15:46:10 +0000
Message-Id: <20210207154623.433442-12-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Now we have core support for timeouts related to adaptive events, let us
use it.  Note the units of that attribute are seconds, so we also need
to scale the cycles value by the period of each sample.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 159 ++++++++++---------------------
 1 file changed, 52 insertions(+), 107 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 54f31aadc92a..f8183c540d5c 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -294,13 +294,22 @@ static int ad7150_read_event_value(struct iio_dev *indio_dev,
 	int rising = (dir == IIO_EV_DIR_RISING);
 
 	/* Complex register sharing going on here */
-	switch (type) {
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		*val = chip->thresh_sensitivity[rising][chan->channel];
-		return IIO_VAL_INT;
-	case IIO_EV_TYPE_THRESH:
-		*val = chip->threshold[rising][chan->channel];
-		return IIO_VAL_INT;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH_ADAPTIVE:
+			*val = chip->thresh_sensitivity[rising][chan->channel];
+			return IIO_VAL_INT;
+		case IIO_EV_TYPE_THRESH:
+			*val = chip->threshold[rising][chan->channel];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_TIMEOUT:
+		*val = 0;
+		*val2 = chip->thresh_timeout[rising][chan->channel] * 10000;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -318,13 +327,36 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
 	int rising = (dir == IIO_EV_DIR_RISING);
 
 	mutex_lock(&chip->state_lock);
-	switch (type) {
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		chip->thresh_sensitivity[rising][chan->channel] = val;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (type) {
+		case IIO_EV_TYPE_THRESH_ADAPTIVE:
+			chip->thresh_sensitivity[rising][chan->channel] = val;
+			break;
+		case IIO_EV_TYPE_THRESH:
+			chip->threshold[rising][chan->channel] = val;
+			break;
+		default:
+			ret = -EINVAL;
+			goto error_ret;
+		}
 		break;
-	case IIO_EV_TYPE_THRESH:
-		chip->threshold[rising][chan->channel] = val;
+	case IIO_EV_INFO_TIMEOUT: {
+		/*
+		 * Raw timeout is in cycles of 10 msecs as long as both
+		 * channels are enabled.
+		 * In terms of INT_PLUS_MICRO, that is in units of 10,000
+		 */
+		int timeout = val2 / 10000;
+
+		if (val != 0 || timeout < 0 || timeout > 15 || val2 % 10000) {
+			ret = -EINVAL;
+			goto error_ret;
+		}
+
+		chip->thresh_timeout[rising][chan->channel] = timeout;
 		break;
+	}
 	default:
 		ret = -EINVAL;
 		goto error_ret;
@@ -338,91 +370,6 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static ssize_t ad7150_show_timeout(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 value;
-
-	/* use the event code for consistency reasons */
-	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(this_attr->address);
-	int rising = (IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
-		      == IIO_EV_DIR_RISING) ? 1 : 0;
-
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		value = chip->thresh_timeout[rising][chan];
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t ad7150_store_timeout(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(this_attr->address);
-	enum iio_event_direction dir;
-	enum iio_event_type type;
-	int rising;
-	u8 data;
-	int ret;
-
-	type = IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address);
-	dir = IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address);
-	rising = (dir == IIO_EV_DIR_RISING);
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
-
-	if (data > GENMASK(3, 0))
-		return -EINVAL;
-
-	mutex_lock(&chip->state_lock);
-	switch (type) {
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		chip->thresh_timeout[rising][chan] = data;
-		break;
-	default:
-		ret = -EINVAL;
-		goto error_ret;
-	}
-
-	ret = ad7150_write_event_params(indio_dev, chan, type, dir);
-error_ret:
-	mutex_unlock(&chip->state_lock);
-
-	if (ret < 0)
-		return ret;
-
-	return len;
-}
-
-#define AD7150_TIMEOUT(chan, type, dir, ev_type, ev_dir)		\
-	IIO_DEVICE_ATTR(in_capacitance##chan##_##type##_##dir##_timeout, \
-		0644,							\
-		&ad7150_show_timeout,					\
-		&ad7150_store_timeout,					\
-		IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,			\
-				     chan,				\
-				     IIO_EV_TYPE_##ev_type,		\
-				     IIO_EV_DIR_##ev_dir))
-static AD7150_TIMEOUT(0, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(0, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
-static AD7150_TIMEOUT(1, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(1, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
-
 static const struct iio_event_spec ad7150_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -438,12 +385,14 @@ static const struct iio_event_spec ad7150_events[] = {
 		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_TIMEOUT),
 	}, {
 		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_TIMEOUT),
 	},
 };
 
@@ -538,15 +487,11 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-/* Timeouts not currently handled by core */
+static IIO_CONST_ATTR(in_capacitance_thresh_adaptive_timeout_available,
+		      "[0 0.01 0.15]");
+
 static struct attribute *ad7150_event_attributes[] = {
-	&iio_dev_attr_in_capacitance0_thresh_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_thresh_adaptive_falling_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_thresh_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_thresh_adaptive_falling_timeout
+	&iio_const_attr_in_capacitance_thresh_adaptive_timeout_available
 	.dev_attr.attr,
 	NULL,
 };
-- 
2.30.0

