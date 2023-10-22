Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5C7D23BD
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJVPrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjJVPrj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654CF4
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CBCC433C7;
        Sun, 22 Oct 2023 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989657;
        bh=gKwHevN7+QM1kXUDApxMjpWsPWjV85pazVEgWfWSzYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezgbcRVV/lI51oYB9ZdXXE/KIvV0rsUfdQgWmCVj7Zb+Loo21wN5xnSFJnrM3TzRW
         ciKdvvnuoYDcfEskYYcotbkzAdmmw23qV/3gZj+WX44MkgHbfUBcGD/5xPdjAZOMu9
         TSseSHR3FUguUe77biBa0K8AXs1KUZ8oqPJ1M1i3lydBpz2aFI+t+NfkgkC0NvSpTI
         McNYQpcVKtaxyEGUonQjCxGGzWinU4ToBM/vbQKo1NSTbgfdUD1Zlyhe2Cyyg6R2sx
         O4xFGHBLlhV5FWB+J8HjEPQatiFZkqWsU20LstYJ52OBRqqoHsJ2pB4eRSdcI8S8Lo
         esrbuhCdjMH7w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 2/8] iio: dummy: Add use of new automated cleanup of locks and direct mode claiming.
Date:   Sun, 22 Oct 2023 16:47:04 +0100
Message-ID: <20231022154710.402590-3-jic23@kernel.org>
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

As this driver is faking buffered access there isn't strictly any need
to prevent direct access whilst it is running. However, we do want this
to look like real devices where such restrictions are commonly needed.
Adding such protections also allow testing the automated cleanup via

CLASS(iio_claim_direct, claimed_dev)(indio_dev);
if (IS_ERR(claimed_dev))
	return PTR_ERR(claimed_dev);

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 145 ++++++++++++++-------------
 1 file changed, 74 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index c24f609c2ade..e412f6a84fc3 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -282,66 +282,73 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 			      int *val2,
 			      long mask)
 {
+	/*
+	 * Whilst it can be elegant to use the claimed device for this, it's not necessary
+	 * where we have a mixture of paths accessing under that protection, to prevent
+	 * access that might disrupt the buffered flow, and those that only care about
+	 * protection of the device specific state.
+	 */
 	struct iio_dummy_state *st = iio_priv(indio_dev);
-	int ret = -EINVAL;
 
-	mutex_lock(&st->lock);
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
+	case IIO_CHAN_INFO_RAW: { /* magic value - channel value read */
+		CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+		if (IS_ERR(claimed_dev))
+			return PTR_ERR(claimed_dev);
+		guard(mutex)(&st->lock);
+
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			if (chan->output) {
 				/* Set integer part to cached value */
 				*val = st->dac_val;
-				ret = IIO_VAL_INT;
+				return IIO_VAL_INT;
 			} else if (chan->differential) {
 				if (chan->channel == 1)
 					*val = st->differential_adc_val[0];
 				else
 					*val = st->differential_adc_val[1];
-				ret = IIO_VAL_INT;
+				return IIO_VAL_INT;
 			} else {
 				*val = st->single_ended_adc_val;
-				ret = IIO_VAL_INT;
+				return IIO_VAL_INT;
 			}
-			break;
+
 		case IIO_ACCEL:
 			*val = st->accel_val;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
-	case IIO_CHAN_INFO_PROCESSED:
+	}
+	case IIO_CHAN_INFO_PROCESSED: {
+		CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+		if (IS_ERR(claimed_dev))
+			return PTR_ERR(claimed_dev);
+		guard(mutex)(&st->lock);
 		switch (chan->type) {
 		case IIO_STEPS:
 			*val = st->steps;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_ACTIVITY:
 			switch (chan->channel2) {
 			case IIO_MOD_RUNNING:
 				*val = st->activity_running;
-				ret = IIO_VAL_INT;
-				break;
+				return IIO_VAL_INT;
 			case IIO_MOD_WALKING:
 				*val = st->activity_walking;
-				ret = IIO_VAL_INT;
-				break;
+				return IIO_VAL_INT;
 			default:
-				break;
+				return -EINVAL;
 			}
-			break;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
+	}
 	case IIO_CHAN_INFO_OFFSET:
 		/* only single ended adc -> 7 */
 		*val = 7;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -350,60 +357,57 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 				/* only single ended adc -> 0.001333 */
 				*val = 0;
 				*val2 = 1333;
-				ret = IIO_VAL_INT_PLUS_MICRO;
-				break;
+				return IIO_VAL_INT_PLUS_MICRO;
 			case 1:
 				/* all differential adc -> 0.000001344 */
 				*val = 0;
 				*val2 = 1344;
-				ret = IIO_VAL_INT_PLUS_NANO;
+				return IIO_VAL_INT_PLUS_NANO;
+			default:
+				return -EINVAL;
 			}
-			break;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
-	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBBIAS: {
+		guard(mutex)(&st->lock);
 		/* only the acceleration axis - read from cache */
 		*val = st->accel_calibbias;
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_CALIBSCALE: {
+		guard(mutex)(&st->lock);
 		*val = st->accel_calibscale->val;
 		*val2 = st->accel_calibscale->val2;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = 3;
 		*val2 = 33;
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
-	case IIO_CHAN_INFO_ENABLE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_ENABLE: {
+		guard(mutex)(&st->lock);
 		switch (chan->type) {
 		case IIO_STEPS:
 			*val = st->steps_enabled;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
-	case IIO_CHAN_INFO_CALIBHEIGHT:
+	}
+	case IIO_CHAN_INFO_CALIBHEIGHT: {
+		guard(mutex)(&st->lock);
 		switch (chan->type) {
 		case IIO_STEPS:
 			*val = st->height;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
-
+	}
 	default:
-		break;
+		return -EINVAL;
 	}
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 /**
@@ -436,10 +440,10 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 			if (chan->output == 0)
 				return -EINVAL;
 
-			/* Locking not required as writing single value */
-			mutex_lock(&st->lock);
-			st->dac_val = val;
-			mutex_unlock(&st->lock);
+			scoped_guard(mutex, &st->lock) {
+				/* Locking not required as writing single value */
+				st->dac_val = val;
+			}
 			return 0;
 		default:
 			return -EINVAL;
@@ -447,9 +451,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_STEPS:
-			mutex_lock(&st->lock);
-			st->steps = val;
-			mutex_unlock(&st->lock);
+			scoped_guard(mutex, &st->lock) {
+				st->steps = val;
+			}
 			return 0;
 		case IIO_ACTIVITY:
 			if (val < 0)
@@ -470,30 +474,29 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_CALIBSCALE:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_CALIBSCALE: {
+		guard(mutex)(&st->lock);
 		/* Compare against table - hard matching here */
 		for (i = 0; i < ARRAY_SIZE(dummy_scales); i++)
 			if (val == dummy_scales[i].val &&
 			    val2 == dummy_scales[i].val2)
 				break;
 		if (i == ARRAY_SIZE(dummy_scales))
-			ret = -EINVAL;
-		else
-			st->accel_calibscale = &dummy_scales[i];
-		mutex_unlock(&st->lock);
+			return  -EINVAL;
+		st->accel_calibscale = &dummy_scales[i];
 		return ret;
+	}
 	case IIO_CHAN_INFO_CALIBBIAS:
-		mutex_lock(&st->lock);
-		st->accel_calibbias = val;
-		mutex_unlock(&st->lock);
+		scoped_guard(mutex, &st->lock) {
+			st->accel_calibbias = val;
+		}
 		return 0;
 	case IIO_CHAN_INFO_ENABLE:
 		switch (chan->type) {
 		case IIO_STEPS:
-			mutex_lock(&st->lock);
-			st->steps_enabled = val;
-			mutex_unlock(&st->lock);
+			scoped_guard(mutex, &st->lock) {
+				st->steps_enabled = val;
+			}
 			return 0;
 		default:
 			return -EINVAL;
-- 
2.42.0

