Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88CE312583
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBGPta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhBGPt3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:49:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 742BF64E51;
        Sun,  7 Feb 2021 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712928;
        bh=ySulkE5dW404GovN4NGHULi+9DOHq5F+fmpoYTAxSJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcnrVa3DxiJXNhMlEGxzt7QNJ4VDJN7JF/zgZiaO6/hoLlZY+rMdz6R9l9XL5ehCC
         h33UFiMeAgAs8fFm4CgnRl1W6cUTyo+a2WEivA9UoM1WZbFso01zBix4x7jVzvvVoq
         mGDqiza/4yueDLePL+lX+cyCaRWSiwFKDG6IDU88brxRc7A1NVh6teNLU0tZuBTi50
         BR4uDHKuzAXNsqDWUzHJmbkwRSUPS0kF9vRMiSikcSCNCcv5bi+KvgS4Dza5FVBCPO
         bFmaBkDB8Lsxka41Zwdny34ulN5w3ciUOTX39a3wG+owvAaat89WItA/Z5iVSfjUfh
         xoN3mIbXcoFlA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/24] staging:iio:cdc:ad7150: Timeout register covers both directions so both need updating
Date:   Sun,  7 Feb 2021 15:46:03 +0000
Message-Id: <20210207154623.433442-5-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
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
2.30.0

