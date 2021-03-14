Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917D833A76B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhCNSSN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhCNSRl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D830064E31;
        Sun, 14 Mar 2021 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745861;
        bh=aY0zNJMlXtCx+W+ixd9Z4IxiPTaXFT72hRH1gNZmdv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zmuf3MW7BNPvzkMxMsJ+q/K+fP2Rgc19O/s5+bzRqVCRsgVq4RS9MVuSSjYJ/iCIv
         mp8elK4ZK/s8hAPROWAa965wyATMMpbK8SktOsOXG5nfPg7u689P8iGBsLruyf1PYS
         55JhiZzQPGLZSZox4WvxOSfvDx2poZms4lTTdmCSeEG2Wdxe1mAsDvZX9MbnESpVnq
         nxPfuNNGndH7FXIV4HNnOiqaVz/FpkyUIzIfu7X11qym6I1wgb3a0D2PIT+feb2lDv
         mYXZYNEtpfl4T1/QbB9O2it7v7hXGQluy9HZ7EWV8mj2UlvhprwGeRuRfbpbleBM3J
         gKwNMKSNNoCuA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 09/24] staging:iio:cdc:ad7150: Add sampling_frequency support
Date:   Sun, 14 Mar 2021 18:14:56 +0000
Message-Id: <20210314181511.531414-10-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Device uses a fixed sampling frequency. Let us expose it to userspace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-10-jic23@kernel.org
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
2.30.2

