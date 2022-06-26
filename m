Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A755B1E3
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiFZMUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiFZMUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C97E029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0476D6120E
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E10C34114;
        Sun, 26 Jun 2022 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246045;
        bh=eMUslhvZQlE0g0XrmIQTICD5BUIUzJzqEAxexe0PZws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HT/vMw9B1cOOYAM7ptOYogpBCjMdf8uEMPBB6/UWmjhUoVf3q2WZhQa6c+Qm8moxD
         Umt03PVdrZXWJETut2BCS8tFBL01X3Ck1or1kv5GWIkJoT6P5KhDiL6eve9Do5UPh2
         vCeOnScfginlmcvLHWDUikW3TEQ82KK1jGcOLaq8CeMLafdLVQwWtfyyQFT5Mm84vC
         3phy1wdeYv8HoRxiUpAz9Enq6QvQG8Xtapg6YZqDKAIq8k7XqM4lLPPuvduOJNfHzL
         nU7SSh50+QImxEnFRQFwJ+geBWjX3/RiMFnZYtQAXr8ATk5Sox0K7yeGan2Cycpruu
         Aa9RMwD6U6FlQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 10/17] staging: iio: cdc: ad7746: Use _raw and _scale for temperature channels.
Date:   Sun, 26 Jun 2022 13:29:31 +0100
Message-Id: <20220626122938.582107-11-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
References: <20220626122938.582107-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index c574bc1c7d3d..2b27a2cb807c 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -178,14 +178,16 @@ static const struct iio_chan_spec ad7746_channels[] = {
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
@@ -581,18 +583,6 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
 
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
 
@@ -607,7 +597,6 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-	case IIO_CHAN_INFO_PROCESSED:
 		mutex_lock(&chip->lock);
 		ret = ad7746_read_channel(indio_dev, chan, val);
 		mutex_unlock(&chip->lock);
@@ -666,6 +655,10 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
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

