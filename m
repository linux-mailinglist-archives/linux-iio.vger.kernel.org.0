Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3765550CAB
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 21:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiFSS7c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiFSS7U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51ABC8F
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C97661132
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281ADC34114;
        Sun, 19 Jun 2022 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665159;
        bh=tFIzlXGV6WprNuWaExoK7AId3kH9pRITxhjtpD/oQuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HB4GyPM+yJARzPY6QOmjh7eYQEJAr7LmziBA6S7R0wkmikbAegednV+zVG6INCATE
         8zchRuiUnSDi3dZXGv5zZbD9Ki7vDBEG4FAygDrZyZGjSBnC2FSC+XEXyuGDXnOglc
         l74uHujksNDfHrG9hnc7O72KHyRJ7N62nqaKpIUvxwqO6QPHX1/9FCJLztjTDNyc7A
         aP9GfSmVUqSdhjHmhfEpKk+FlBF437AL7+xFA4WadQwqlzfNwoyrHfPFOT16lkjydh
         h1OdoGFBFnRTKPRFhSwzKcGgQd4ZPNkHDZrG3kBZRFHRjcDT2oTmYSXZPpky+CqYTu
         IMIyVUkQlC1iQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 10/17] staging: iio: cdc: ad7746: Use _raw and _scale for temperature channels.
Date:   Sun, 19 Jun 2022 19:58:32 +0100
Message-Id: <20220619185839.1363503-11-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Performing the maths to rescale a 24 bit raw reading within the driver
was resulting in precision losses.  So make that userspace's problem
by exporting the scale and letting the maths be done in userspace with
appropriate precision.  Issue identified using roadtester testing
framework.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 7eaffb90e8c3..3caba37afc63 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -176,14 +176,16 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = TEMP_INT,
 	},
 	[TEMP_EXT] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = TEMP_EXT,
 	},
 	[CIN1] = {
@@ -579,18 +581,6 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
 
 	*val = get_unaligned_be24(data) - 0x800000;
 
-	switch (chan->type) {
-	case IIO_TEMP:
-		/*
-		 * temperature in milli degrees Celsius
-		 * T = ((*val / 2048) - 4096) * 1000
-		 */
-		*val = (*val  * 125) / 256;
-		break;
-	default:
-		break;
-	}
-
 	return 0;
 }
 
@@ -605,7 +595,6 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-	case IIO_CHAN_INFO_PROCESSED:
 		mutex_lock(&chip->lock);
 		ret = ad7746_read_channel(indio_dev, chan, val);
 		mutex_unlock(&chip->lock);
@@ -664,6 +653,10 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 				*val *= 6;
 			*val2 = 23;
 			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_TEMP:
+			*val = 125;
+			*val2 = 8;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
-- 
2.36.1

