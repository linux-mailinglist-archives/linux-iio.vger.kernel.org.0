Return-Path: <linux-iio+bounces-1984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE86583F60A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D4B1F22179
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989AF23748;
	Sun, 28 Jan 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBT24aAd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87C25776
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454395; cv=none; b=MlPmcVBTFHMQT1oOL2z1ilKC4aCU/BG4tJCVNYT67NIYXLeIg/RBdch9qQVZVWDu9b54yxrOXQgJxF1cQdLnXPtrRypxzh45Q804tQt1SRY4Iz7o8iv36N5FT6UTRMkLqxsdiBXqAZZmgWEaCDGSVYH3Bfkt71u5IOzUDMapxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454395; c=relaxed/simple;
	bh=DkcX22Vg4cJ8P79CIz63IbalRhGOgg/ALcziJmX5TFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZljUkwJP/+37+HfrW0gQv5ZdFaQJ5JVmMx08WGz+fusfoQit9liBlh8jgeUBKwSRzAnKtAQXIObrZPHrpgjbYPHOYyv3lynAk/NY0ItCRyYyyfMipavRY2VZ2QvzbsC1tQQ06WNv0qBNLAQuFmTpYynH5vaa/avb5T8ESJAh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBT24aAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987DEC433F1;
	Sun, 28 Jan 2024 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454394;
	bh=DkcX22Vg4cJ8P79CIz63IbalRhGOgg/ALcziJmX5TFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBT24aAd1OyhhdLeyaJL6LNVRvSQvkogD2lc+++AXaOKtYWrhz+UGtoF+UbbUVpG8
	 sBjONRumnGnHR/9R75u8NICzgg3mmv8BiXVeaz/h5XGCyAr4bjlSt36snOseENNptl
	 oXibz5BGfK2qNz1ht7vqiP4tYDa7rYg7ouzvQsG6iq97HIaKn+W1itgTizAjHaHNU3
	 vP+dfxZek4Ic5SL4dDxgCfDB13EgCUqjiU0sNgvJQci6ZAOky64ve+IL2AJGpKLsaT
	 PqinVfjcueIgSqWDMQVQo6vvXX9BS1N8O+WjUxuvu+lTNBK5QDWbW5Jd19nCba1Ext
	 Ryw9mDIlNtohw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/10] iio: imu: bmi323: Use cleanup handling for iio_device_claim_direct_mode()
Date: Sun, 28 Jan 2024 15:05:31 +0000
Message-ID: <20240128150537.44592-5-jic23@kernel.org>
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

Similar to existing use of guard() in this driver,
iio_device_claim_direct_scoped() will ensure that scope based cleanup
occurs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Since RFC:
 - Use unreachable() to avoid false warning from compiler in the
   pattern

	iio_device_claim_direct_scoped(return -EBUSY, iio_dev) {
		return 0;
	}
	unreachable();
- Switch one guard_scoped(mutex,..) to guard(mutex) to avoid need for
  an unreachable() marking (ended up a little neater).
---
 drivers/iio/imu/bmi323/bmi323_core.c | 78 +++++++++++-----------------
 1 file changed, 31 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 183af482828f..5d42ab9b176a 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1668,52 +1668,41 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
 			    int val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
-				     val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return bmi323_set_odr(data,
+					      bmi323_iio_to_sensor(chan->type),
+					      val, val2);
+		unreachable();
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
-				       val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return bmi323_set_scale(data,
+						bmi323_iio_to_sensor(chan->type),
+						val, val2);
+		unreachable();
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = bmi323_set_average(data, bmi323_iio_to_sensor(chan->type),
-					 val);
-
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return bmi323_set_average(data,
+						  bmi323_iio_to_sensor(chan->type),
+						  val);
+		unreachable();
 	case IIO_CHAN_INFO_ENABLE:
 		return bmi323_enable_steps(data, val);
-	case IIO_CHAN_INFO_PROCESSED:
-		scoped_guard(mutex, &data->mutex) {
-			if (val || !FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK,
-					      data->feature_events))
-				return -EINVAL;
+	case IIO_CHAN_INFO_PROCESSED: {
+		guard(mutex)(&data->mutex);
 
-			/* Clear step counter value */
-			ret = bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
-						    BMI323_STEP_SC1_RST_CNT_MSK,
-						    FIELD_PREP(BMI323_STEP_SC1_RST_CNT_MSK,
-							       1));
-		}
-		return ret;
+		if (val || !FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK,
+				      data->feature_events))
+			return -EINVAL;
+
+		/* Clear step counter value */
+		return bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
+					     BMI323_STEP_SC1_RST_CNT_MSK,
+					     FIELD_PREP(BMI323_STEP_SC1_RST_CNT_MSK,
+							1));
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1724,7 +1713,6 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1733,14 +1721,10 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_ANGL_VEL:
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
-
-			ret = bmi323_read_axis(data, chan, val);
-
-			iio_device_release_direct_mode(indio_dev);
-			return ret;
+			iio_device_claim_direct_scoped(return -EBUSY,
+						       indio_dev)
+				return bmi323_read_axis(data, chan, val);
+			unreachable();
 		case IIO_TEMP:
 			return bmi323_get_temp_data(data, val);
 		default:
-- 
2.43.0


