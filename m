Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6180255B1DC
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiFZMUw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiFZMUw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCABE029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA2561212
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82380C34114;
        Sun, 26 Jun 2022 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246050;
        bh=uyVY8rNmlkLhQehYriF624eDZy3DayxqTYYG2yevrz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IO4y8CFSXCxrs60eIja/Pgm6f0CP8ZW0DjveRWyDXGPkq3MGYVjxk3sCst7uPhIgr
         G95PQrKqiLebC9Q8sss6dKiAmi4dPow04arInTHQT4cqAksh9wgbVUnrj8WVfKXilE
         HfvZQ4t8s4nrV+WgHn7YrPubV+lRA/Xo0WgUlZrAfeJ+OUoL2wiKAqrlxiRCtBrhgF
         2NFnvDuoOg2jOFEnaknv4P4pGTAzgw/+iZmDxN51m0kEhc24+G8VYsSBvuTJPKmsI1
         EEhy3wgbY87Ba2PTFajW/zrGqqv74l/m4kavdmChRJOAdjr3/4zu9ub0mWx5Q0gcT4
         LCMQJulJ1FBWw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 12/17] staging: iio: cdc: ad7746: Switch from _offset to _zeropoint for differential channels.
Date:   Sun, 26 Jun 2022 13:29:33 +0100
Message-Id: <20220626122938.582107-13-jic23@kernel.org>
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

As this offset is applied equally to both lines of the differential
pair, _ofset should not be used. Use the new ABI _zeropoint instead
to avoid userspace software applying this value when calculating
real value = (_raw + _offset) * _scale

Also add a comment to explain why an offset of 0x800000 is applied
within the driver rather than exposed to userspace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 2b27a2cb807c..d8fbb8a85bbf 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -207,7 +207,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.channel = 0,
 		.channel2 = 2,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_ZEROPOINT),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN1_DIFF,
@@ -229,7 +229,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.channel = 1,
 		.channel2 = 3,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_ZEROPOINT),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN2_DIFF,
@@ -506,6 +506,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		return 0;
 	case IIO_CHAN_INFO_OFFSET:
+	case IIO_CHAN_INFO_ZEROPOINT:
 		if (val < 0 || val > 43008000) /* 21pF */
 			return -EINVAL;
 
@@ -581,6 +582,10 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Offset applied internally becaue the _offset userspace interface is
+	 * needed for the CAP DACs which apply a controllable offset.
+	 */
 	*val = get_unaligned_be24(data) - 0x800000;
 
 	return 0;
@@ -637,6 +642,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
+	case IIO_CHAN_INFO_ZEROPOINT:
 		*val = FIELD_GET(AD7746_CAPDAC_DACP_MASK,
 				 chip->capdac[chan->channel][chan->differential]) * 338646;
 
-- 
2.36.1

