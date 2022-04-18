Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90F505E74
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347674AbiDRTYS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbiDRTYS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971235862
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47BF5B8108E
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4F0C385A1;
        Mon, 18 Apr 2022 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309695;
        bh=0aZlaNHVqsKqlVWGe8WBUFWTAjkEzfYtXa79EvUXAkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWsW8z8+xiYMc5KdD291qJoZQlyEvqlM8znnkjVC8uSeba77NLdLn05a8Mk1fq9V0
         rtIVxey+baD9DPS6NnKKXjIzPKP9/AwUm6DMiThRkV4SMo5Px1R+mgjh6J4Ft8oNwv
         ciyq5UfBVL1XWvG4w7jGjPLlw8U45e5VJ91O2QAnC0uOdmB/AtG5UflJLUFjhSCo/c
         qperPQaUmbz1Pjk83y186F/TiCEaiDVc4Pny7Zaxtpcdz4VFzOEMBX+nby038MQsIC
         uAYvoaRO0AYmKDXT9LnQC3XPbpRqUza9oDnJ6k9L+4qViBBWAOdRBiuglihC/OFQmM
         4omZL6e5wRvyA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/17] staging: iio: cdc: ad7746: Use read_avail() rather than opencoding.
Date:   Mon, 18 Apr 2022 20:29:03 +0100
Message-Id: <20220418192907.763933-14-jic23@kernel.org>
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

Switch over to the IIO core handling for _available attributes
making them available for in kernel users and enforcing correct
naming etc automatically.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 39 +++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 46cdddab495f..6fe3221c8ace 100644
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
2.35.3

