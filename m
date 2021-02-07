Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415F7312598
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBGPuw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhBGPuv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39EE264E5A;
        Sun,  7 Feb 2021 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712950;
        bh=SoRbZ4bjAi+0oTP5ndExAjb/by4PTKbnns+ox/vRLJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCmclsbjl8u1ehnlkFxVgDuAui8u9w4X/T5lyv2VL1IEtl5Gd7lY9VLFo8e6Elyt1
         YAUeGM9ch3XvJMuMisKOs+akfDebTLnve+lJhQgO931BLJZ8Taht90Xd3vejskZh48
         wvk1Yt4WGJZhEEwV/uCbB0BaEyFc1L6o0YWAH3Qu3g5Hao6+Px9SPTZozkq6Ax0uHy
         0lzXX1f5Dw/TWneN7VZqfh7NL//fsX5uYMnVipL8WAQAlH2/GkpwZkw6b3O2Ytw2HC
         VM/JdiHb5Rww6/WGoOetYYaT2XsVCmM+bqwDcPRhPaVST1uu6U+BoZlVUFprHffNCG
         9Kvdm9X3qy5bw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 18/24] staging:iio:cdc:ad7150: Add scale and offset to info_mask_shared_by_type
Date:   Sun,  7 Feb 2021 15:46:17 +0000
Message-Id: <20210207154623.433442-19-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
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
---
 drivers/staging/iio/cdc/ad7150.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 97689625f26c..a2aae370c231 100644
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
2.30.0

