Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C17D23C1
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjJVPrs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJVPrs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF1B4
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BA6C433C9;
        Sun, 22 Oct 2023 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989665;
        bh=sJPegEq6vr86bTNptXsMt6pnMXHaPpi+4PkkRPN/xgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqMAm0EU6Y/DuFN3wLUGWnL/TKq7MAWfex7qUrr5T2W/gpv+AqebIM/orlOtA5IUG
         xO7Bx3HjHEW56dw1kS5LRevH8t/f3T1AXLNLGuamLh6Ii+Hv3rY7MGNm9Q+2JXVdnp
         6XH8doApTtVzCaIQIhJplf3Vsp/1Y/QrbmZiaMq/eST6UgRktdjaBiCtzUKsA+MyBL
         otjKIIPgWBEjhRTMot+Xy5E+wzRy6WGOo+BtfoEoBOqCdIgljzgeu2OsLVtk1JcJ2k
         sWxzLj1WbkX7DS5Zw4RCTtPixxrBn/2GEg+TO6bZ/qLNBsGNkXgIJxckVhgfk5d+an
         DOUgRDEFTXAVA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 5/8] iio: adc: max1363: Use automatic cleanup for locks and iio mode claiming.
Date:   Sun, 22 Oct 2023 16:47:07 +0100
Message-ID: <20231022154710.402590-6-jic23@kernel.org>
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

This simplifies error return paths.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max1363.c | 63 ++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 7c2a98b8c3a9..d0f4302807d0 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -363,10 +363,11 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	mutex_lock(&st->lock);
+	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+	if (IS_ERR(claimed_dev))
+		return PTR_ERR(claimed_dev);
+
+	guard(mutex)(&st->lock);
 
 	/*
 	 * If monitor mode is enabled, the method for reading a single
@@ -375,10 +376,8 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	 *
 	 * Also, cannot read directly if buffered capture enabled.
 	 */
-	if (st->monitor_on) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
+	if (st->monitor_on)
+		return -EBUSY;
 
 	/* Check to see if current scan mode is correct */
 	if (st->current_mode != &max1363_mode_table[chan->address]) {
@@ -386,33 +385,27 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		st->current_mode = &max1363_mode_table[chan->address];
 		ret = max1363_set_scan_mode(st);
 		if (ret < 0)
-			goto error_ret;
+			return ret;
 	}
 	if (st->chip_info->bits != 8) {
 		/* Get reading */
 		data = st->recv(client, rxbuf, 2);
-		if (data < 0) {
-			ret = data;
-			goto error_ret;
-		}
+		if (data < 0)
+			return data;
+
 		data = (rxbuf[1] | rxbuf[0] << 8) &
 		  ((1 << st->chip_info->bits) - 1);
 	} else {
 		/* Get reading */
 		data = st->recv(client, rxbuf, 1);
-		if (data < 0) {
-			ret = data;
-			goto error_ret;
-		}
+		if (data < 0)
+			return data;
+
 		data = rxbuf[0];
 	}
 	*val = data;
 
-error_ret:
-	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
-	return ret;
-
+	return 0;
 }
 
 static int max1363_read_raw(struct iio_dev *indio_dev,
@@ -710,9 +703,8 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	st->monitor_speed = i;
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock)
+		st->monitor_speed = i;
 
 	return 0;
 }
@@ -815,12 +807,11 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
 	int val;
 	int number = chan->channel;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (dir == IIO_EV_DIR_FALLING)
 		val = (1 << number) & st->mask_low;
 	else
 		val = (1 << number) & st->mask_high;
-	mutex_unlock(&st->lock);
 
 	return val;
 }
@@ -967,10 +958,11 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	u16 unifiedmask;
 	int number = chan->channel;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	mutex_lock(&st->lock);
+	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+	if (IS_ERR(claimed_dev))
+		return PTR_ERR(claimed_dev);
+
+	guard(mutex)(&st->lock);
 
 	unifiedmask = st->mask_low | st->mask_high;
 	if (dir == IIO_EV_DIR_FALLING) {
@@ -981,7 +973,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 			ret = __max1363_check_event_mask((1 << number),
 							 unifiedmask);
 			if (ret)
-				goto error_ret;
+				return ret;
 			st->mask_low |= (1 << number);
 		}
 	} else {
@@ -991,17 +983,14 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 			ret = __max1363_check_event_mask((1 << number),
 							 unifiedmask);
 			if (ret)
-				goto error_ret;
+				return ret;
 			st->mask_high |= (1 << number);
 		}
 	}
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
-error_ret:
-	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
 
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.42.0

