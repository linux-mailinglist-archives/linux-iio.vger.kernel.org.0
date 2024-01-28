Return-Path: <linux-iio+bounces-1982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6783F608
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE341F22131
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9824B39;
	Sun, 28 Jan 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwjvBeIC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0D249E0
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454391; cv=none; b=tCXlvoMP5bOu7rwuolModDks7GizwU5Az60fDuJaQaUK3sNCAaDTPgCGfN2KNZBYVm4VAXsNr1uMRf+qidK7Y7JeFLmaU/dsVlyoUBFPXHGToldebQnwjqMvz97r9u7L8oNAntfaaFZDC/WI+8NR3/5YPvJeXD3qCoTlopTpJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454391; c=relaxed/simple;
	bh=6CPqUyum2zElftouZAXwLsMpESWjiO9AypwSaSdSw90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajdl5oUqr2/jyDL46eJTXMaMqz44ETfMKp4mbhY9FYmG1E6RVV+RybGKgbnk9jBRg2FJUuZpdy2F7uABrVJy9Zb6Dv8uyUV8EQFWe0j75weHQYByzgJjHTDVm7kAdvRvVzjZSMOZoELxIrhbyJ0EiPc6pPA5icrw51MklKc+E0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwjvBeIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4827C43399;
	Sun, 28 Jan 2024 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454391;
	bh=6CPqUyum2zElftouZAXwLsMpESWjiO9AypwSaSdSw90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwjvBeICHpDXb53L/YS6lMXvdUzW6g1dR/zHKxAloMoUndXK0QgGJgAbzCtiOkkSu
	 UsoKCqpNquVN5M1lm1zxgn+HGyYLrV1qcGyEjmRMMwmHp+JKtX99y+yKpgwQdkRUu2
	 uZxAEgtUn7UdHyZyXezWVLvRe+uVFd8Sh8/B+gx+W59tL5whuoX5uGqlcLoiDEJt91
	 OfUvP7yo77JraSB16wvdOFKWKWLIIQnLoJbpFBMha/Z3Ux31OwKJytpUSLJeuLpaFf
	 9VCNe99Mbut+jJGp8mfB4qdUCy4gnACE4I3dX/YY+SiI6FgHk1x/uMBfuOBegQkdN6
	 XxgIfZFpHGWSQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/10] iio: dummy: Use automatic lock and direct mode cleanup.
Date: Sun, 28 Jan 2024 15:05:29 +0000
Message-ID: <20240128150537.44592-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128150537.44592-1-jic23@kernel.org>
References: <20240128150537.44592-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given we now have iio_device_claim_direct_scoped() to perform automatic
releasing of direct mode at exit from the scope that follows it, this can
be used in conjunction with guard(mutex) etc remove a lot of special case
handling.

Note that in this particular example code, there is no real reason you can't
read channels via sysfs at the same time as filling the software buffer.
To make it look more like a real driver constrain raw and processed
channel reads from occurring whilst the buffer is in use.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Since RFC:
- Dropped a stale comment about a local variable that existed
  in an earlier version of this patch before the new scoped_guard_cond()
  infrastructure was added.
- Use unreachable() to convince the compiler we can't get to code
  at end of the pattern.

	iio_device_claim_direct_scoped(return -EBUSY, iio_dev) {
		return 0;
	}
	unreacahable();
---
 drivers/iio/dummy/iio_simple_dummy.c | 182 +++++++++++++--------------
 1 file changed, 88 insertions(+), 94 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index c24f609c2ade..d6ef556698fb 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -283,65 +283,63 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
-	int ret = -EINVAL;
 
-	mutex_lock(&st->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			if (chan->output) {
-				/* Set integer part to cached value */
-				*val = st->dac_val;
-				ret = IIO_VAL_INT;
-			} else if (chan->differential) {
-				if (chan->channel == 1)
-					*val = st->differential_adc_val[0];
-				else
-					*val = st->differential_adc_val[1];
-				ret = IIO_VAL_INT;
-			} else {
-				*val = st->single_ended_adc_val;
-				ret = IIO_VAL_INT;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			guard(mutex)(&st->lock);
+			switch (chan->type) {
+			case IIO_VOLTAGE:
+				if (chan->output) {
+					/* Set integer part to cached value */
+					*val = st->dac_val;
+					return IIO_VAL_INT;
+				} else if (chan->differential) {
+					if (chan->channel == 1)
+						*val = st->differential_adc_val[0];
+					else
+						*val = st->differential_adc_val[1];
+					return IIO_VAL_INT;
+				} else {
+					*val = st->single_ended_adc_val;
+					return IIO_VAL_INT;
+				}
+
+			case IIO_ACCEL:
+				*val = st->accel_val;
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
 			}
-			break;
-		case IIO_ACCEL:
-			*val = st->accel_val;
-			ret = IIO_VAL_INT;
-			break;
-		default:
-			break;
 		}
-		break;
+		unreachable();
 	case IIO_CHAN_INFO_PROCESSED:
-		switch (chan->type) {
-		case IIO_STEPS:
-			*val = st->steps;
-			ret = IIO_VAL_INT;
-			break;
-		case IIO_ACTIVITY:
-			switch (chan->channel2) {
-			case IIO_MOD_RUNNING:
-				*val = st->activity_running;
-				ret = IIO_VAL_INT;
-				break;
-			case IIO_MOD_WALKING:
-				*val = st->activity_walking;
-				ret = IIO_VAL_INT;
-				break;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			guard(mutex)(&st->lock);
+			switch (chan->type) {
+			case IIO_STEPS:
+				*val = st->steps;
+				return IIO_VAL_INT;
+			case IIO_ACTIVITY:
+				switch (chan->channel2) {
+				case IIO_MOD_RUNNING:
+					*val = st->activity_running;
+					return IIO_VAL_INT;
+				case IIO_MOD_WALKING:
+					*val = st->activity_walking;
+					return IIO_VAL_INT;
+				default:
+					return -EINVAL;
+				}
 			default:
-				break;
+				return -EINVAL;
 			}
-			break;
-		default:
-			break;
 		}
-		break;
+		unreachable();
 	case IIO_CHAN_INFO_OFFSET:
 		/* only single ended adc -> 7 */
 		*val = 7;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -350,60 +348,57 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
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
@@ -436,10 +431,10 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
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
@@ -447,9 +442,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
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
@@ -470,30 +465,29 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
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
2.43.0


