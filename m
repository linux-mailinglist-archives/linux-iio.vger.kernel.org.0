Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E6312580
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGPt3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhBGPt0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:49:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5389A64E49;
        Sun,  7 Feb 2021 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712925;
        bh=MlcWmmgF9DfgD1RFY/e7DIdyr51yJmbFH38eYtW5hrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBbT2awqvsS28bis8+3JFbSFP3dxE3KVIwW0iWTCSbUKU3llXXfaF/t+SvbwGGZ3k
         aEDXcl8S+C48PhQq38wP6255X3508ONrZ55LCvbUsqP8j/ItvV6SKtGENoWC5ZSn0T
         YwLZWGzo4HnNm0VqBpLAYoXcZnhfRfrcZd6XINkYGY5/gvJE05TmDo1vlLn0iaDOVW
         XW1KWxrQFXdXOqlBY7Ic+IzfSPYwqsY1FhPFNUpYllrRhTl1LxXbJEF54tOz015fG6
         g07lJ+79+Y8bde+6fIzwv/Y7B1/+SnS6rNoKHnvoxya5HLBrOreoNGeN942Et9JBEX
         ra77HF3wNRc0Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/24] staging:iio:cdc:ad7150: Remove magnitude adaptive events
Date:   Sun,  7 Feb 2021 15:46:01 +0000
Message-Id: <20210207154623.433442-3-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The devices support window detection, but that corresponds to
being outside of a range defined by a lower an uppper bound rather
than being related to magnitude as such.   Hence drop this interface
in the interests of making the driver ABI compliant.

We may bring back support for the window mode at somepoint in the future
but it will be in an ABI compliant fashion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 56 --------------------------------
 1 file changed, 56 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index c3ed88c5e0a5..4dac4aaec0cf 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -57,14 +57,9 @@
  * @threshold: thresholds for simple capacitance value events
  * @thresh_sensitivity: threshold for simple capacitance offset
  *	from 'average' value.
- * @mag_sensitity: threshold for magnitude of capacitance offset from
- *	from 'average' value.
  * @thresh_timeout: a timeout, in samples from the moment an
  *	adaptive threshold event occurs to when the average
  *	value jumps to current value.
- * @mag_timeout: a timeout, in sample from the moment an
- *	adaptive magnitude event occurs to when the average
- *	value jumps to the current value.
  * @old_state: store state from previous event, allowing confirmation
  *	of new condition.
  * @conversion_mode: the current conversion mode.
@@ -76,9 +71,7 @@ struct ad7150_chip_info {
 	u64 current_event;
 	u16 threshold[2][2];
 	u8 thresh_sensitivity[2][2];
-	u8 mag_sensitivity[2][2];
 	u8 thresh_timeout[2][2];
-	u8 mag_timeout[2][2];
 	int old_state;
 	char *conversion_mode;
 	struct mutex state_lock;
@@ -149,10 +142,6 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	thrfixed = FIELD_GET(AD7150_CFG_FIX, ret);
 
 	switch (type) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		if (dir == IIO_EV_DIR_RISING)
-			return !thrfixed && (threshtype == 0x1);
-		return !thrfixed && (threshtype == 0x0);
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
 			return !thrfixed && (threshtype == 0x3);
@@ -193,10 +182,6 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 		return i2c_smbus_write_word_swapped(chip->client,
 						    ad7150_addresses[chan][3],
 						    value);
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		sens = chip->mag_sensitivity[rising][chan];
-		timeout = chip->mag_timeout[rising][chan];
-		break;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		sens = chip->thresh_sensitivity[rising][chan];
 		timeout = chip->thresh_timeout[rising][chan];
@@ -240,13 +225,6 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 	cfg = ret & ~((0x03 << 5) | BIT(7));
 
 	switch (type) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		adaptive = 1;
-		if (rising)
-			thresh_type = 0x1;
-		else
-			thresh_type = 0x0;
-		break;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		adaptive = 1;
 		if (rising)
@@ -294,9 +272,6 @@ static int ad7150_read_event_value(struct iio_dev *indio_dev,
 
 	/* Complex register sharing going on here */
 	switch (type) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		*val = chip->mag_sensitivity[rising][chan->channel];
-		return IIO_VAL_INT;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		*val = chip->thresh_sensitivity[rising][chan->channel];
 		return IIO_VAL_INT;
@@ -321,9 +296,6 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->state_lock);
 	switch (type) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		chip->mag_sensitivity[rising][chan->channel] = val;
-		break;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		chip->thresh_sensitivity[rising][chan->channel] = val;
 		break;
@@ -358,9 +330,6 @@ static ssize_t ad7150_show_timeout(struct device *dev,
 		      == IIO_EV_DIR_RISING) ? 1 : 0;
 
 	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		value = chip->mag_timeout[rising][chan];
-		break;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		value = chip->thresh_timeout[rising][chan];
 		break;
@@ -396,9 +365,6 @@ static ssize_t ad7150_store_timeout(struct device *dev,
 
 	mutex_lock(&chip->state_lock);
 	switch (type) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		chip->mag_timeout[rising][chan] = data;
-		break;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		chip->thresh_timeout[rising][chan] = data;
 		break;
@@ -426,10 +392,6 @@ static ssize_t ad7150_store_timeout(struct device *dev,
 				     chan,				\
 				     IIO_EV_TYPE_##ev_type,		\
 				     IIO_EV_DIR_##ev_dir))
-static AD7150_TIMEOUT(0, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(0, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
-static AD7150_TIMEOUT(1, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(1, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
 static AD7150_TIMEOUT(0, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
 static AD7150_TIMEOUT(0, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
 static AD7150_TIMEOUT(1, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
@@ -456,16 +418,6 @@ static const struct iio_event_spec ad7150_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_ENABLE),
-	}, {
-		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
-	}, {
-		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
 	},
 };
 
@@ -539,14 +491,6 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 
 /* Timeouts not currently handled by core */
 static struct attribute *ad7150_event_attributes[] = {
-	&iio_dev_attr_in_capacitance0_mag_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_mag_adaptive_falling_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_mag_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_mag_adaptive_falling_timeout
-	.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_thresh_adaptive_rising_timeout
 	.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_thresh_adaptive_falling_timeout
-- 
2.30.0

