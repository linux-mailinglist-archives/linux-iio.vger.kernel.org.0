Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF9550CAC
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiFSS7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFSS71 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7772BC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BB88B80D8D
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E54FC34114;
        Sun, 19 Jun 2022 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665164;
        bh=VrtN/hDTKnm4GAmGeOeqkgeZQJYjpKHTmBdQCZSiMgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfnzNniVoMUa35eBh3D0Rx8th1edjD+gaM2W4HiSInv2olGeFomqAbvGHTI5hgTCW
         ydWRqS4QIV5U/nuXXu4IuwEvOjOU5Irb55rlNIC/oQ1qunUnFa2OO0ZlZ2xabsTn59
         QTwRYee4OjnKOyw/SkjwTLXQcIAYRxjZkTh6BUgVHSjASnYlOKepvlT9LP+6KDWmgh
         4niDpq7hbH0VWdTOJPNUuOiOwrQelfOLWfUkjGWU3VDCdkld5ccWRAvNW20mzAYGV8
         21rDBje1mpo2lm5kQ0QODKRoFUOfhIilN8273qeTCw+MItyVBfYsZl9+3Q1QX/++1s
         YDPYgnVCJVYXQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 12/17] staging: iio: cdc: ad7746: Switch from _offset to _inputoffset for differential channels.
Date:   Sun, 19 Jun 2022 19:58:34 +0100
Message-Id: <20220619185839.1363503-13-jic23@kernel.org>
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

As this offset is applied equally to both lines of the differential
pair, _ofset should not be used. Use the new ABI _inputoffset instead
to avoid userspace software applying this value when calculating
real value = (_raw + _offset) * _scale

Also add a comment to explain why an offset of 0x800000 is applied
within the driver rather than exposed to userspace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 3caba37afc63..3801bd0a6176 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -205,7 +205,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.channel = 0,
 		.channel2 = 2,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_INPUTOFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN1_DIFF,
@@ -227,7 +227,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.channel = 1,
 		.channel2 = 3,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_INPUTOFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN2_DIFF,
@@ -504,6 +504,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		return 0;
 	case IIO_CHAN_INFO_OFFSET:
+	case IIO_CHAN_INFO_INPUTOFFSET:
 		if (val < 0 || val > 43008000) /* 21pF */
 			return -EINVAL;
 
@@ -579,6 +580,10 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Offset applied internally becaue the _offset userspace interface is
+	 * needed for the CAP DACs which apply a controllable offset.
+	 */
 	*val = get_unaligned_be24(data) - 0x800000;
 
 	return 0;
@@ -635,6 +640,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
+	case IIO_CHAN_INFO_INPUTOFFSET:
 		*val = FIELD_GET(AD7746_CAPDAC_DACP_MASK,
 				 chip->capdac[chan->channel][chan->differential]) * 338646;
 
-- 
2.36.1

