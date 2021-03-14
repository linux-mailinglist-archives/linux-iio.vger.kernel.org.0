Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8333A775
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhCNSST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233999AbhCNSR7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 414DB64EC3;
        Sun, 14 Mar 2021 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745878;
        bh=9vWpsOiQPAIbFpELFCIdERQRoN290obi3D64Or/s1Hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEEPsHAO1tAyxD6eY70mPkDBkgJlpDzGyGxc1q3EnnUoNfqpS1jgpUwt+JX/tYFnN
         a1fyR6tLfnrbFmEuM+9WEVidJef3vk86TTY6zKxTpTYzh3b379bq9UqFAcdWB900tQ
         +pgts3h+ZpHqAgafBF9rn8h2HXkvZTtoKxlw/DqRqZOLpzJsT1qLsQYB1TuuAMrVgL
         WpYxZr3gycYJy3jzyBWNP5FR0tpdJ53trc7gja7AFu7GipjU6BBi4lqgehQR08Twqf
         YJU3m0GArzt7KrazkYNKFa5RKS2nERMEzSJy31ny3905eyCpNEQIK1PuFvejS3P5Vf
         aUaEBhJ///L4g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 18/24] staging:iio:cdc:ad7150: Add scale and offset to info_mask_shared_by_type
Date:   Sun, 14 Mar 2021 18:15:05 +0000
Message-Id: <20210314181511.531414-19-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The datasheet provides these two values on the assumption they are applied
to unshift raw value.  Hence shift both the offset and scale by 4
to compensate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-19-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 1a041396ff9e..39d70805d2a6 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -121,6 +121,18 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = ret;
 
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Base units for capacitance are nano farads and the value
+		 * calculated from the datasheet formula is in picofarad
+		 * so multiply by 1000
+		 */
+		*val = 1000;
+		*val2 = 40944 >> 4; /* To match shift in _RAW */
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -(12288 >> 4); /* To match shift in _RAW */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		/* Strangely same for both 1 and 2 chan parts */
@@ -425,6 +437,8 @@ static const struct iio_event_spec ad7150_events[] = {
 		.channel = _chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_OFFSET),		\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 		.event_spec = ad7150_events,			\
 		.num_event_specs = ARRAY_SIZE(ad7150_events),	\
@@ -436,6 +450,8 @@ static const struct iio_event_spec ad7150_events[] = {
 		.channel = _chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_OFFSET),		\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 	}
 
-- 
2.30.2

