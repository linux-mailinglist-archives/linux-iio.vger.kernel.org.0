Return-Path: <linux-iio+bounces-1990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9B83F610
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7D81C229BA
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043042557A;
	Sun, 28 Jan 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KScWDada"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9717249E0
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454404; cv=none; b=Tej0ZIpnm9bOnuQhs9ziXfIOxZzVQVmfGA0lIiyglx75gIyRo0tgVb0tpkFbJ4ffTu1WxLDQuxpAO5FXuKLpQgJhvfzjadMgaGTDH1+lm4LMLrrZwe3eVa029C5yRR74n5WsFknrX3TN5xuL7ZwpFV0dem3mG2NHzoK9KEUHFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454404; c=relaxed/simple;
	bh=HVoS3YxvEkDwt2oQNhZDXQ1CS1eObXSJ3K4jflM6Stg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbfwjxBSOfa3NlMMS8ISrBIrDC/yNkWZovNpmHVtFpPR8SdSpltNL7wt/O+tVSrfAXDrb82M8r4EY4u+hjRgAeCmNshckqxJZIhWmSp4/ONS2HIuf11o0NIPOV3os7abTaGAgBVN7S/EHZJq+zvV56GRlhjFkC8pqLnzDZ/3ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KScWDada; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C51CC43399;
	Sun, 28 Jan 2024 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454404;
	bh=HVoS3YxvEkDwt2oQNhZDXQ1CS1eObXSJ3K4jflM6Stg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KScWDadaA4RXnqbiqlWUN/ZTdcdXU2R//D/gDNyKdP3a9Q7iLZOVdq4brcq6dNkEU
	 B0VNFZ3QzuWBmroRpVKd+0H7fUJ464BuCnbWGIfX4ST0DWoC8YQcIVjo+056hpMeG8
	 DpGq/Z93R2FLslHLokaTAGakn+Ws0h4X0EdrJ+qSuVwu4+0yQTK+O1PKTLIESafJ3B
	 3EzZhC1AQgjWkU1rSRWik6xr57+koa+b9fAzKpjnt99V0iB5SxTLaRJXyRhO3fd9+g
	 SSogohisrHcpLb8yY1yCmIm/qdtj9gyu4uwkFkVT6hDrV2F8H6zCyWQ5XShOukzFj9
	 a0UYtisdgr/7w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/10] iio: adc: ad7091r-base: Use auto cleanup of locks.
Date: Sun, 28 Jan 2024 15:05:37 +0000
Message-ID: <20240128150537.44592-11-jic23@kernel.org>
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

Done to reduce boilerplate and simplify code flow by allowing early
returns with the lock automatically released.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7091r-base.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index f4255b91acfc..d6876259ad14 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -86,28 +86,25 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 	unsigned int read_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		if (st->mode != AD7091R_MODE_COMMAND) {
-			ret = -EBUSY;
-			goto unlock;
-		}
+		if (st->mode != AD7091R_MODE_COMMAND)
+			return -EBUSY;
 
 		ret = ad7091r_read_one(iio_dev, chan->channel, &read_val);
 		if (ret)
-			goto unlock;
+			return ret;
 
 		*val = read_val;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
 		if (st->vref) {
 			ret = regulator_get_voltage(st->vref);
 			if (ret < 0)
-				goto unlock;
+				return ret;
 
 			*val = ret / 1000;
 		} else {
@@ -115,17 +112,11 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 		}
 
 		*val2 = chan->scan_type.realbits;
-		ret = IIO_VAL_FRACTIONAL_LOG2;
-		break;
+		return IIO_VAL_FRACTIONAL_LOG2;
 
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static int ad7091r_read_event_config(struct iio_dev *indio_dev,
-- 
2.43.0


