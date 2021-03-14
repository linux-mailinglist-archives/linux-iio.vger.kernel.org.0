Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF38533A761
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhCNSRk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhCNSR0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0A5964EC3;
        Sun, 14 Mar 2021 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745846;
        bh=0yy0K9rHUqCqzzRRNcRTpKrZHbakWr9rsVlqqPHzCKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRVfZpCEkSExo9s7CHl+qNWb2kuNbM6Z4XdwaAWVKv67ONOimaqJLvmcOda2BT+3o
         yKs9Uzqo3Mijyh0lVVtkqz7h/T2XYD8oZtvz3xB0KffW0L2pt+r4zA4U53MEbFQo9q
         OeGIP4h+lVdLV2sBLkykWj1iG8ojT2IzroHSwjZpl3dvKK7CbAjoI4BD8BBUAstyvl
         9qJ4GuW87ZJ1li1vCdfSDOoz+ODalkSE99dZq9m7niS2nHjX8TSGnMnoaVHWxiI3rF
         Pj8RyMbyvZq+o41JqgcVPk07P9WgntaMHr00xy1tEgbFjb5tv4ZaK74yArZWlk7AOq
         p04j9IiBO5phw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 01/24] staging:iio:cdc:ad7150: use swapped reads for i2c rather than open coding.
Date:   Sun, 14 Mar 2021 18:14:48 +0000
Message-Id: <20210314181511.531414-2-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces boilerplate and chances of getting the error handling wrong.
No functional change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-2-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 48132ab157ef..c3ed88c5e0a5 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -109,18 +109,20 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_smbus_read_word_data(chip->client,
-					       ad7150_addresses[channel][0]);
+		ret = i2c_smbus_read_word_swapped(chip->client,
+						  ad7150_addresses[channel][0]);
 		if (ret < 0)
 			return ret;
-		*val = swab16(ret);
+		*val = ret;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_AVERAGE_RAW:
-		ret = i2c_smbus_read_word_data(chip->client,
-					       ad7150_addresses[channel][1]);
+		ret = i2c_smbus_read_word_swapped(chip->client,
+						  ad7150_addresses[channel][1]);
 		if (ret < 0)
 			return ret;
-		*val = swab16(ret);
+		*val = ret;
+
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -188,9 +190,9 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 		/* Note completely different from the adaptive versions */
 	case IIO_EV_TYPE_THRESH:
 		value = chip->threshold[rising][chan];
-		return i2c_smbus_write_word_data(chip->client,
-						 ad7150_addresses[chan][3],
-						 swab16(value));
+		return i2c_smbus_write_word_swapped(chip->client,
+						    ad7150_addresses[chan][3],
+						    value);
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 		sens = chip->mag_sensitivity[rising][chan];
 		timeout = chip->mag_timeout[rising][chan];
-- 
2.30.2

