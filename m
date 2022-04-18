Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D877505E72
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbiDRTYR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347675AbiDRTYQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8332EFB
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5F7FB8105F
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A5C385AA;
        Mon, 18 Apr 2022 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309693;
        bh=okgAGAVfOgUl0WQ4R6oaY0E01YBenpl9Y5vuhP4A9P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wa2EYEijRWd/dKccx9LpB3H6dHjxHZu5WRw4YwNuvXj3+nnbaveMLlFbvKDppL75N
         DxtRCsPyRPCPWxBbEyxX+X2d/yc7bvi66Rnt1bOvJ3nz9Zdn/U//h870V0+vR9gV2a
         8AGD3kO+GKmjSe4LtXg2m1I6vzoKLVL9k4W5RGiEKsZUTmU/zdv858FOlrSs6fY3jU
         Eat24clzBAjjjetGT8azkQ+pKP53f/MuQSE9YkSLvEi8PzPlEXBE5Wh2hS75XvWise
         yP3zsPdVgWEXOXLqigC5lHA+cIg5oSIJuhtkFYQJQQHs2u7/F7HizQjVQq0zQAMhPr
         xuyeLPNuLOLvA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/17] staging: iio: cdc: ad7746: Switch from _offset to _inputoffset for differential channels.
Date:   Mon, 18 Apr 2022 20:29:02 +0100
Message-Id: <20220418192907.763933-13-jic23@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418192907.763933-1-jic23@kernel.org>
References: <20220418192907.763933-1-jic23@kernel.org>
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
index 0dc5630d0655..46cdddab495f 100644
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
2.35.3

