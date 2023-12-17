Return-Path: <linux-iio+bounces-1030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EDB816147
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955D31C22082
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5B4653B;
	Sun, 17 Dec 2023 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUNwOOWL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528F46451
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5623C433C8;
	Sun, 17 Dec 2023 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834590;
	bh=puKnOC47ZhCvb22UwmJqZWOaQuV4eyTWq1x665cWbD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUNwOOWLsYo3V3MCflaUW/62k3EZYwQLdCCrOre0STdW67/T9TEVXXpfBYL4Z7jTM
	 pTaLoZsJQd7RuL2sctcD52CN7BgbnmP/+tzBWlJUcRrtoN32ltAGyvbzPk3gS00VK2
	 VaPDnBg3MIy384TmzrhvwFuFhzJ6kGCkzg5U2L9Noyh06iwdao8Eh9bg00GCc2XcKX
	 ypWOkTaBF03foGsEA6ULQSgqHR4btMuPDav/3/cv4M4OtP9Hi58/UI528RcjbkN2zL
	 bPh0p5pSjsPMeb4l2OV1c63RzpekmCkV0jAInmYRQUmwduRk97huYTGXqELpR1PdQP
	 kBpLs9ADiTOdQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 10/10] iio: adc: ad7091r-base: Use auto cleanup of locks.
Date: Sun, 17 Dec 2023 17:35:48 +0000
Message-ID: <20231217173548.112701-11-jic23@kernel.org>
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

Done to reduce boilerplate and simplify code flow by allowing early
returns with the lock automatically released.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7091r-base.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index d3d287d3b953..672dfd1809e0 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -127,28 +127,25 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
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
@@ -156,17 +153,11 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
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
 
 static const struct iio_info ad7091r_info = {
-- 
2.43.0


