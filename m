Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88894550CA5
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiFSS7f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiFSS73 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5BBC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2F661133
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7437C3411D;
        Sun, 19 Jun 2022 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665167;
        bh=I2APeRVPpzoToyd0mdE1Ye6CWcs/rBftX9evEDXs3Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzvlcNPqmwpznOvvJdSLPh2tbGIx7Ejw7+hsmr5E1HeJvCOzJSqTH7MQ8WyVCHPD3
         Befb8AGqussv4QOZCOlmOhWpuRUbrJHZyCmFd7N3ly7iSyLTyf6kxYg1U8S6Jej5OP
         KJ7xP0lIBoJARhqTNArHLvjYcx3DQGKBZ4dJ4jFTusnkJp4NVHQGFY8hS/B5GVSPSD
         7INYoZHFmimqQRjN2UwzD4sam2IgzMFW6cwwxAMeynmeUAscicWHZLTczRNo/EzR1o
         UXmE6daKb9JN1weQ17htJELXQ1Qy09YvxXHh1nyUIrilidgV752Xs67Ta42Qm+nh3X
         Fspqsd36Ehfdg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 13/17] staging: iio: cdc: ad7746: Use read_avail() rather than opencoding.
Date:   Sun, 19 Jun 2022 19:58:35 +0100
Message-Id: <20220619185839.1363503-14-jic23@kernel.org>
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

Switch over to the IIO core handling for _available attributes
making them available for in kernel users and enforcing correct
naming etc automatically.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 39 +++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 3801bd0a6176..70dfb35d6135 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -161,6 +161,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = VIN,
 	},
 	[VIN_VDD] = {
@@ -170,6 +171,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.extend_name = "supply",
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = VIN_VDD,
 	},
 	[TEMP_INT] = {
@@ -196,6 +198,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN1,
 	},
 	[CIN1_DIFF] = {
@@ -208,6 +211,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_INPUTOFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN1_DIFF,
 	},
 	[CIN2] = {
@@ -218,6 +222,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN2,
 	},
 	[CIN2_DIFF] = {
@@ -230,6 +235,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_INPUTOFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
 		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = CIN2_DIFF,
 	}
 };
@@ -438,18 +444,12 @@ static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *chip,
 	return 0;
 }
 
-static IIO_CONST_ATTR(in_voltage_sampling_frequency_available, "50 31 16 8");
-static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
-		       "91 84 50 26 16 13 11 9");
-
 static struct attribute *ad7746_attributes[] = {
 	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
-	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
-	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
@@ -552,6 +552,32 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const int ad7746_v_samp_freq[] = { 50, 31, 16, 8, };
+static const int ad7746_cap_samp_freq[] = { 91, 84, 50, 26, 16, 13, 11, 9, };
+
+static int ad7746_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, const int **vals,
+			     int *type, int *length, long mask)
+{
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		*vals = ad7746_v_samp_freq;
+		*length = ARRAY_SIZE(ad7746_v_samp_freq);
+		break;
+	case IIO_CAPACITANCE:
+		*vals = ad7746_cap_samp_freq;
+		*length = ARRAY_SIZE(ad7746_cap_samp_freq);
+		break;
+	default:
+		return -EINVAL;
+	}
+	*type = IIO_VAL_INT;
+	return IIO_AVAIL_LIST;
+}
+
 static int ad7746_read_channel(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val)
@@ -687,6 +713,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad7746_info = {
 	.attrs = &ad7746_attribute_group,
 	.read_raw = ad7746_read_raw,
+	.read_avail = ad7746_read_avail,
 	.write_raw = ad7746_write_raw,
 };
 
-- 
2.36.1

