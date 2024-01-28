Return-Path: <linux-iio+bounces-1986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF883F60B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D4C28478C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5AC23769;
	Sun, 28 Jan 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw5ZCeRm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57222EE8
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454398; cv=none; b=qR2Dpp+cnHUps1+UCu7zxOBX1NuKRTPOq+2OzHXGRMB0bxIJPl7u0jAt4LuL9HJ1xq94IZ2ESZydiHQFst9+K2vfBZVyQV6glP0BECAAPLpBSuDqevhL/72ojqAyEuxsCCIfdGLiGSMizmYDDK3zRdseVg+B1r2O8HoB+rpAgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454398; c=relaxed/simple;
	bh=EncyxZ2KugvNqvNoLDm0SgoeUxvI+n4WbtRdI/rptKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsfxMXueqmYtDd7TNP6f2MlS/dW7CLqGnr8TrimR8ysmc+EiiCD/KV/fjVi2AUrydgUdSC+6ShqffMJF2gmVoYfNadCIX3jzZvs0JbAWh9E/STbA4sPiuX6a6RNWbPbSElYCmvpW9fJFYE0IwOQQsXoOKTIrsUq8W8Fuuzj78RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw5ZCeRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2150C433F1;
	Sun, 28 Jan 2024 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454397;
	bh=EncyxZ2KugvNqvNoLDm0SgoeUxvI+n4WbtRdI/rptKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nw5ZCeRmQpR99+b1CiQi7WcCsGLMWVWe27C6gsl1D6GeQZOeaKRKdCuWKyqweJRnz
	 hUj+4tCe1ZcuCa4peK2z04Y3Ii2iDgydOrUzCobkV7N2eq1V8KzFL/cc/4vS1HvB/+
	 hNjckXjowbCMlvA1hxDQM8hCsUTb/HJ3LEOGyfaYMbrBtY10Lf6EqSTBvpQQTmKsob
	 ypsTKrYq+wtwG4/ZnbAVyOf2knYxubDnQAAr/Gad+mDpW7jmeaDspFaBVKFKQJY3wC
	 5FTXdAYcaLEan8OfbPs26yKj5snqrgzMyV0TMUvCbOaveTp6H8d9Brb4pcjKzVN+yQ
	 47+B7ygJhNZNA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/10] iio: proximity: sx9360: Use automated cleanup for locks and IIO mode claiming.
Date: Sun, 28 Jan 2024 15:05:33 +0000
Message-ID: <20240128150537.44592-7-jic23@kernel.org>
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

This simplifies error handling paths and generallly removes a bunch
of boilerplate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Changes since RFC:
 - use unreachable() to convince compiler we can't reach paths beyond
	iio_device_claim_direct_scoped(return -EBUSY, iio_dev) {
		return 0;
	}
	unreachable();
- reduce scope of int ret in resume callback.
---
 drivers/iio/proximity/sx9360.c | 115 +++++++++++----------------------
 1 file changed, 39 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2c4e14a4fe9f..75a1c29f14eb 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -322,25 +322,16 @@ static int sx9360_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = sx_common_read_proximity(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return sx_common_read_proximity(data, chan, val);
+		unreachable();
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = sx9360_read_gain(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return sx9360_read_gain(data, chan, val);
+		unreachable();
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9360_read_samp_freq(data, val, val2);
 	default:
@@ -387,19 +378,15 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
 static int sx9360_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int ret, reg;
+	int reg;
 	__be16 buf;
 
 	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
 	buf = cpu_to_be16(reg);
-	mutex_lock(&data->mutex);
-
-	ret = regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
-				sizeof(buf));
+	guard(mutex)(&data->mutex);
 
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
+				 sizeof(buf));
 }
 
 static int sx9360_read_thresh(struct sx_common_data *data, int *val)
@@ -510,7 +497,6 @@ static int sx9360_read_event_val(struct iio_dev *indio_dev,
 static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 {
 	unsigned int val = _val;
-	int ret;
 
 	if (val >= 1)
 		val = int_sqrt(2 * val);
@@ -518,11 +504,8 @@ static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 	if (val > 0xff)
 		return -EINVAL;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_write(data->regmap, SX9360_REG_PROX_CTRL5, val);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_write(data->regmap, SX9360_REG_PROX_CTRL5, val);
 }
 
 static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
@@ -546,18 +529,14 @@ static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
 		return -EINVAL;
 
 	hyst = FIELD_PREP(SX9360_REG_PROX_CTRL4_HYST_MASK, hyst);
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
-				 SX9360_REG_PROX_CTRL4_HYST_MASK, hyst);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
+				  SX9360_REG_PROX_CTRL4_HYST_MASK, hyst);
 }
 
 static int sx9360_write_far_debounce(struct sx_common_data *data, int _val)
 {
 	unsigned int regval, val = _val;
-	int ret;
 
 	if (val > 0)
 		val = ilog2(val);
@@ -566,19 +545,15 @@ static int sx9360_write_far_debounce(struct sx_common_data *data, int _val)
 
 	regval = FIELD_PREP(SX9360_REG_PROX_CTRL4_FAR_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
-				 SX9360_REG_PROX_CTRL4_FAR_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
+				  SX9360_REG_PROX_CTRL4_FAR_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9360_write_close_debounce(struct sx_common_data *data, int _val)
 {
 	unsigned int regval, val = _val;
-	int ret;
 
 	if (val > 0)
 		val = ilog2(val);
@@ -587,13 +562,10 @@ static int sx9360_write_close_debounce(struct sx_common_data *data, int _val)
 
 	regval = FIELD_PREP(SX9360_REG_PROX_CTRL4_CLOSE_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
-				 SX9360_REG_PROX_CTRL4_CLOSE_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
+				  SX9360_REG_PROX_CTRL4_CLOSE_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9360_write_event_val(struct iio_dev *indio_dev,
@@ -630,19 +602,15 @@ static int sx9360_write_gain(struct sx_common_data *data,
 			     const struct iio_chan_spec *chan, int val)
 {
 	unsigned int gain, reg;
-	int ret;
 
 	gain = ilog2(val);
 	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
 	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, reg,
-				 SX9360_REG_PROX_CTRL0_GAIN_MASK,
-				 gain);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, reg,
+				  SX9360_REG_PROX_CTRL0_GAIN_MASK,
+				  gain);
 }
 
 static int sx9360_write_raw(struct iio_dev *indio_dev,
@@ -827,36 +795,31 @@ static int sx9360_suspend(struct device *dev)
 
 	disable_irq_nosync(data->client->irq);
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
+	if (ret < 0)
+		return ret;
 
 	data->suspend_ctrl =
 		FIELD_GET(SX9360_REG_GNRL_CTRL0_PHEN_MASK, regval);
 
-	if (ret < 0)
-		goto out;
 
 	/* Disable all phases, send the device to sleep. */
-	ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
-
-out:
-	mutex_unlock(&data->mutex);
-	return ret;
+	return regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
 }
 
 static int sx9360_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_GNRL_CTRL0,
-				 SX9360_REG_GNRL_CTRL0_PHEN_MASK,
-				 data->suspend_ctrl);
-	mutex_unlock(&data->mutex);
-	if (ret)
-		return ret;
 
+	scoped_guard(mutex, &data->mutex) {
+		int ret = regmap_update_bits(data->regmap,
+					     SX9360_REG_GNRL_CTRL0,
+					     SX9360_REG_GNRL_CTRL0_PHEN_MASK,
+					     data->suspend_ctrl);
+		if (ret)
+			return ret;
+	}
 	enable_irq(data->client->irq);
 	return 0;
 }
-- 
2.43.0


