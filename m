Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CE312585
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGPt3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhBGPtY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:49:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2B2B64E40;
        Sun,  7 Feb 2021 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712923;
        bh=pL2q7QCXkVZk9oyCfZKaz51q2nqsfCxTS94/9FlhASY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSjxLqS6Uco6Tbi4jqdFfBP09gwv06SiV5aYY+Xl57HLJoSsPjUAdSEM3eJM6MoB7
         sKKlgxohuUbde1ljaU58qH22KdlVpA5jM+1bXTU4QtGSub5huTaHdd2gs1k6s3iY/T
         /ZKR5JJf7craYli3+2buipQQUd2iTmXHCJNP03e4aQ+uZxY9QrqduxxrVBglnq2Od6
         MEWS170q4eoKyZ+WBIvaYOTLrprL6w2NMUlJ36kIEDjoe0le8zxx5P2h0TOndC4Gfz
         dtdp6Y8EJq4/npgmuclygBn0Ga4Oy3vnnN4kwkBOPE6S04mTVAvs2PAj/Q2SkjRaCl
         OYYGLBnb0xlnQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/24] staging:iio:cdc:ad7150: use swapped reads for i2c rather than open coding.
Date:   Sun,  7 Feb 2021 15:46:00 +0000
Message-Id: <20210207154623.433442-2-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduces boilerplate and chances of getting the error handling wrong.
No functional change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.30.0

