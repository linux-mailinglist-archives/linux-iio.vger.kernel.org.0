Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0640E33A762
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCNSRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233369AbhCNSRc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CC7064EC8;
        Sun, 14 Mar 2021 18:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745851;
        bh=y4/tq/NppJRs+u5Ll0hQtdHLEVm8dJtkbFOpgHffGew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDwcuwyEwqZnBLiMtPtv3Z2B2unTaISVEtsjbtN3DVWdvS0JSXaqNdVd9Z12Y+hpE
         oEcTzu1dVO19Bqldr5/Ef+UAsWXciBtgMcQRq0zj4f1rneKIXaijHp6JnsmkBohI2C
         A5bpbNLSwLCBAcu+5k183jPirlznjp66DuLjYY9nuzZlp8QosY/zh8DqiEqPYnZHFr
         fyeRrXFmKHk84OWyqiw/X4heRtX05FHm0gnGKqrLaA3k7qs99oDujtDyEPACsDDsp5
         A5NkyvQIlRj9Flkq+lhvRBOV5Ds2Phkk9zFEhpfItc7EcxP/Te00zK1TK6KE2nj0Er
         Q+qIpUyy3N/Qw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 04/24] staging:iio:cdc:ad7150: Timeout register covers both directions so both need updating
Date:   Sun, 14 Mar 2021 18:14:51 +0000
Message-Id: <20210314181511.531414-5-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The timeout is treated as one single value, but the datasheet describes
it as two 4 bit values, one for each direction of event.
As such change the driver to support the separate directions.
Also add limit checking to ensure it fits within the 4 bits.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-5-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index d6a7bfd94f1c..0dce1b8ce76d 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -49,6 +49,8 @@
 /* AD7150 masks */
 #define AD7150_THRESHTYPE_MSK			GENMASK(6, 5)
 
+#define AD7150_CH_TIMEOUT_RECEDING		GENMASK(3, 0)
+#define AD7150_CH_TIMEOUT_APPROACHING		GENMASK(7, 4)
 /**
  * struct ad7150_chip_info - instance specific chip data
  * @client: i2c client for this device
@@ -59,7 +61,9 @@
  *	from 'average' value.
  * @thresh_timeout: a timeout, in samples from the moment an
  *	adaptive threshold event occurs to when the average
- *	value jumps to current value.
+ *	value jumps to current value.  Note made up of two fields,
+ *      3:0 are for timeout receding - applies if below lower threshold
+ *      7:4 are for timeout approaching - applies if above upper threshold
  * @old_state: store state from previous event, allowing confirmation
  *	of new condition.
  * @conversion_mode: the current conversion mode.
@@ -191,7 +195,14 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		timeout = chip->thresh_timeout[rising][chan];
+		/*
+		 * Single timeout register contains timeouts for both
+		 * directions.
+		 */
+		timeout = FIELD_PREP(AD7150_CH_TIMEOUT_APPROACHING,
+				     chip->thresh_timeout[1][chan]);
+		timeout |= FIELD_PREP(AD7150_CH_TIMEOUT_RECEDING,
+				      chip->thresh_timeout[0][chan]);
 		return i2c_smbus_write_byte_data(chip->client,
 						 ad7150_addresses[chan][5],
 						 timeout);
@@ -365,6 +376,9 @@ static ssize_t ad7150_store_timeout(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (data > GENMASK(3, 0))
+		return -EINVAL;
+
 	mutex_lock(&chip->state_lock);
 	switch (type) {
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-- 
2.30.2

