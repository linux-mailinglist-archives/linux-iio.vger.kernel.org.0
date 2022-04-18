Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D77505E6A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347668AbiDRTX7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347671AbiDRTX5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852335862
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202FE60E9A
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00FAC385AA;
        Mon, 18 Apr 2022 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309676;
        bh=ikMVn+SMOgW3yNKey75lSpwVSFSGho5UFplLdRuXp78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3EY/hmpdTi1F71d5d5SP0wMnNkS8S5xtuWXwpMuxe68hfdcdZrEP6N4W7UmG+LEK
         DoLxTfLfG7+g5ZciSicZOQOHloYDpez0nz4KkSYKZOTIp6f3/K4aOdcOZSfH7Qs49m
         EnpcOABXXCumZDTW9mPRGk4JtJaDLpkogtyJIZpTGndAm6ijwtvO/2RItm3hUXPZJ5
         4+ELLAa3+s4Y0uYFhZAed9rPFkZsu2Z67NZ8hrBBKKbO7decc+53BAdQZO3LF4MbRt
         f408m1JlUpzrVnqidSonkmOB95IJCOSRJnjOSwkKWzWDId+Qp0lrUClZULFkEAi9yL
         Hkq2499UnIChA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/17] staging: iio: cdc: ad7746: Push handling of supply voltage scale to userspace.
Date:   Mon, 18 Apr 2022 20:28:54 +0100
Message-Id: <20220418192907.763933-5-jic23@kernel.org>
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

The supply voltage is attenuated by 6 before being fed to the ADC.
Handle this explcitly rather than premultiplying the _raw value by 6.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 1f510610ed32..1379caf88b83 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -114,9 +114,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_VIN,
 	},
@@ -125,9 +124,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "supply",
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_VDD_MON,
 	},
@@ -559,10 +557,6 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 			 */
 			*val = (*val * 125) / 256;
 			break;
-		case IIO_VOLTAGE:
-			if (chan->channel == 1) /* supply_raw*/
-				*val = *val * 6;
-			break;
 		default:
 			break;
 		}
@@ -617,6 +611,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 			/* 1170mV / 2^23 */
 			*val = 1170;
+			if (chan->channel == 1)
+				*val *= 6;
 			*val2 = 23;
 			ret = IIO_VAL_FRACTIONAL_LOG2;
 			break;
-- 
2.35.3

