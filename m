Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2B55B1DF
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiFZMUe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiFZMUd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC9E029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2D41B80D8A
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84305C341CA;
        Sun, 26 Jun 2022 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246029;
        bh=F2j6jnRX+tNSBVs8/1ZtEMJAZqreIv4VtVSkjPGVCVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEauqWblPXy3kKxDJUzJZp+6OAjanm2rOEL8ylzPrQPPXHCQ3VSh25foJ2ahLyetp
         GW7SjJ+60zfLaX5ze7b/s0UaY2QDltv3w1PkyIlvA+WPmGOzruv6xlkpLbzZv/E5IB
         rpYqdWALKIkx57HKO/zUoJ+ZcxDBecsFz+MTSLPfbTciRIZtD+JzlXwgTi9cT1AMSd
         fJave74HieT+kWfqRt3fmms5GPz5d30trecyMrQV3k0O96VAL39OiTXk5OtVB9E6X2
         cTVJ/e84hejExxD3NFuxpKdg/YA5zES45ukJ1+MUIEHeXZINA0pkL8XFVHpHh4VnC0
         r4/96wwYKDRbQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/17] staging: iio: cdc: ad7746: Push handling of supply voltage scale to userspace.
Date:   Sun, 26 Jun 2022 13:29:25 +0100
Message-Id: <20220626122938.582107-5-jic23@kernel.org>
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

The supply voltage is attenuated by 6 before being fed to the ADC.
Handle this explicitly rather than pre-multiplying the _raw value by 6.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 08f73be5797a..0b5cb788abee 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -116,9 +116,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
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
@@ -127,9 +126,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
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
@@ -562,10 +560,6 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
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
@@ -620,6 +614,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 			/* 1170mV / 2^23 */
 			*val = 1170;
+			if (chan->channel == 1)
+				*val *= 6;
 			*val2 = 23;
 			ret = IIO_VAL_FRACTIONAL_LOG2;
 			break;
-- 
2.36.1

