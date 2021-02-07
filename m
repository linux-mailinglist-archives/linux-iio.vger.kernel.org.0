Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646D631258F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBGPuL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhBGPuJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 404EA64E56;
        Sun,  7 Feb 2021 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712936;
        bh=SOMyTxKeIeIWFoMLtYk0Cyyi9hMbUmQfLc6M434EXww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbSut3ZOEgqSpKptg27WCH8Pkn4gPhRExeLOF5U7kQX8ZYZ8zibOjsvSvW413grfo
         GJWXdOHll+BhM6c7QmQsF6xY5c18MzlLwd01qikxyXvEJL1UR0U2UavJI8WISl2EJn
         +LwzuGKT4FksfHre9QLEgkwdcAqGYMUiBDc3TEk/2+X4NgErDBo7OVfq+ZusfGbVJd
         fhBjdddKn7NajWFgj6fEiyo0R2WSERlksIBX8cOi7tL3CQ1j1b8HIUXurOk4a9jZ5C
         ZPnYwJQnBXG8Av4DRF0VXi7Gp3lMZf7NEFX7zBjK5/wDXMoM6bbJSrwfpm0dJj4rgl
         euAzOlBbLxMAg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/24] staging:iio:cdc:ad7150: Add sampling_frequency support
Date:   Sun,  7 Feb 2021 15:46:08 +0000
Message-Id: <20210207154623.433442-10-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Device uses a fixed sampling frequency. Let us expose it to userspace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 8f8e472e3240..54f31aadc92a 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -126,6 +126,10 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = ret;
 
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/* Strangely same for both 1 and 2 chan parts */
+		*val = 100;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -449,6 +453,7 @@ static const struct iio_event_spec ad7150_events[] = {
 		.channel = _chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 		.event_spec = ad7150_events,			\
 		.num_event_specs = ARRAY_SIZE(ad7150_events),	\
 	}
@@ -459,6 +464,7 @@ static const struct iio_event_spec ad7150_events[] = {
 		.channel = _chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 	}
 
 static const struct iio_chan_spec ad7150_channels[] = {
-- 
2.30.0

