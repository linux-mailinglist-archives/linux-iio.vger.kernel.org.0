Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254287D23C0
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjJVPrq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJVPrp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0504112
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB6EC433C7;
        Sun, 22 Oct 2023 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989663;
        bh=ci4yf5UFGbEtoOMwIhY9LgUd80wRyR7eM9SPLgEOd5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ec/HgRRFRARUVR6PE78HCBM8bsa96zMBA46Tg74ZOKHZJlmoioYAjkIGB1EOvgKoS
         AxvAcZq2DroufHvsVpuRYKTL/Z5EC8z49bGmxmCLzDPQQ8mNP5AOQ2eWcxxM1Y7PeN
         cPlM09tEnddFrWKwmtOnj3imzRRDtKLQ4CbwlBTI+ZVfldDw3raRySbacLB+12z9D4
         tSVfiuT2O66BQwajKLA+jyUbMIWqPWFszZe+LKOGp9gl2YkT8qDc8hopnlbcyGwhSc
         iyn8VsMRI8C0DJdlS6GrGcpOH68SoOQRTSDHoegEBHquv6CN5chOmGDaClkYoaM756
         ppOB/LQ1lA+mw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 4/8] iio: imu: bmi323: Use cleanup handling for iio_device_claim_direct_mode()
Date:   Sun, 22 Oct 2023 16:47:06 +0100
Message-ID: <20231022154710.402590-5-jic23@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022154710.402590-1-jic23@kernel.org>
References: <20231022154710.402590-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Similar to existing use of guard() in this driver,
CLASS(iio_claim_direct, claimed_dev)(indio_Dev);
if (IS_ERR(claimed_dev))
	return PTR_ERR(claimed_dev);

will ensure that scope based cleanup occurs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 61 ++++++++++++----------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 0bd5dedd9a63..c9784ad01d44 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1671,34 +1671,30 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+		if (IS_ERR(claimed_dev))
+			return PTR_ERR(claimed_dev);
 
-		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
-				     val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
-	case IIO_CHAN_INFO_SCALE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
-				       val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		return bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
+				      val, val2);
+	}
+	case IIO_CHAN_INFO_SCALE: {
+		CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+		if (IS_ERR(claimed_dev))
+			return PTR_ERR(claimed_dev);
 
-		ret = bmi323_set_average(data, bmi323_iio_to_sensor(chan->type),
-					 val);
+		return bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
+					val, val2);
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+		if (IS_ERR(claimed_dev))
+			return PTR_ERR(claimed_dev);
 
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		return bmi323_set_average(data, bmi323_iio_to_sensor(chan->type),
+					  val);
+	}
 	case IIO_CHAN_INFO_ENABLE:
 		return bmi323_enable_steps(data, val);
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1724,7 +1720,6 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1732,15 +1727,13 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_ACCEL:
-		case IIO_ANGL_VEL:
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
+		case IIO_ANGL_VEL: {
+			CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+			if (IS_ERR(claimed_dev))
+				return PTR_ERR(claimed_dev);
 
-			ret = bmi323_read_axis(data, chan, val);
-
-			iio_device_release_direct_mode(indio_dev);
-			return ret;
+			return bmi323_read_axis(data, chan, val);
+		}
 		case IIO_TEMP:
 			return bmi323_get_temp_data(data, val);
 		default:
-- 
2.42.0

