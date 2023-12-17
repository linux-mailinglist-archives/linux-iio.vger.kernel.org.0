Return-Path: <linux-iio+bounces-1022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94281613F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA51B1F21859
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF16846453;
	Sun, 17 Dec 2023 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+xG4zTo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AC4643C
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EF0C433C7;
	Sun, 17 Dec 2023 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834571;
	bh=RGo88E5su+gEIN6XFbsZ+I0miekS724xYvKvrgyFXFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+xG4zToJ4pCUClQDpKhvOkvvdf3stIKm7z84LsBPIfqdySPM2Ml950WsjgrusuIv
	 yWKb2IgqT5EhjbJeQBMDpvctgMTeqo+TWlUHKvz+04iNoBx0YL+tcr0D57k7Q8Xqkh
	 pnlogeQuFGCckg8FoRcO27z3MdzHaUn6oD8tmsPZAxFe3+O9F5qjQKc4ziC8FYf0yz
	 MVImE0RxmN7TXUCFMXpAg80NOv8yPDqQWrVVrLrn4TrXIs3whdFWCh145SSYoOtwxT
	 pVXYoRkuKDpeeekmNQdVTgSfGzls3aO9jjaaDeDeb0eeQ+W1ja4jFP2jXUe4EUL3lX
	 oVlN3YP3r8kOw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 02/10] iio: dummy: Use automatic lock and direct mode cleanup.
Date: Sun, 17 Dec 2023 17:35:40 +0000
Message-ID: <20231217173548.112701-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217173548.112701-1-jic23@kernel.org>
References: <20231217173548.112701-1-jic23@kernel.org>
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
be used in conjunction with guard(mutex) etc remove a lot of special place
handling.

Note that in this particular example code, there is no real reason you can't
read channels via sysfs at the same time as filling the software buffer.
To make it look more like a real driver constrain raw and processed
channel reads from occurring whilst the buffer is in use.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 189 +++++++++++++--------------
 1 file changed, 94 insertions(+), 95 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index c24f609c2ade..91c4629015e2 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -282,66 +282,69 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
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
-
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
+		return -EINVAL;
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
+		return -EINVAL;
 	case IIO_CHAN_INFO_OFFSET:
 		/* only single ended adc -> 7 */
 		*val = 7;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -350,60 +353,57 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
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
@@ -436,10 +436,10 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
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
@@ -447,9 +447,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
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
@@ -470,30 +470,29 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
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


