Return-Path: <linux-iio+bounces-13923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297F4A01AED
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E93D1882D6D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D118A6AE;
	Sun,  5 Jan 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe8wwTE1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE28F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098046; cv=none; b=FHBg0SMVW7PV6bA+/euPkSw5H6zoMlh8pWiF1aVSCr/WrSRG/BMEJjF0mmEY37kPFI2oIMZqNTZBPu+iPtzWRV79ysg4Rkwlt2GDW+Gupn4DSsM89UyVNQx6gE2m/GJ99lOpNmz/xqJ/mj91g7ATz+mzagA1dIYx3+yd28v1iL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098046; c=relaxed/simple;
	bh=AoDf4nBDGo++mG69k4T1L8PEeggQpxjopLGcZh3X2xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeBq06LBGsDwvJhaU1XIT0otFJ4Dbv/Y+m7T79A+zXU0pDScbeZU9cvYF+LBKsNDDg4t5Ei08CDPZO3VElG1PW+RFGrmXv/OzlIkz7V9PHpAXPK4fHFFJfVt2XPEbZeZ39V6In7ItcpLrQpRHhtLgkDEB7VGfRZsxEX0P6PKaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe8wwTE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6612C4CEDD;
	Sun,  5 Jan 2025 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098046;
	bh=AoDf4nBDGo++mG69k4T1L8PEeggQpxjopLGcZh3X2xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fe8wwTE1SiYhradFfB6vT469t71qqcqEaLJGjyQ77dIRIFaLJxiD6yfE8CAtRZrmx
	 DNBfM+DD03TZE74o9Pl8fat7BOd1BVhI5jJmWyTwVn+Y976x9ar22vhUuEY4mIhIFm
	 HcyEw7r7tpg2byMpviEAHdKB+Mc92mCpqG41tyo1Gy+MVfytgbwnuUfrY88tFYtWF3
	 WXSvsTz7v7HYXS6GF0TDXd07OfvUeYvvtAc2bb5fPwEP2hjzTJNtlvufsUczV+7mZy
	 Qrs4qsruwixLPxU37LE8wdmzSmNHzl+2+Fesqy785vfBlr4PrGIv4RZG7eUaQ6AQX0
	 bWVcU2dAqcRxg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 24/27] iio: dac: ad8460: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:09 +0000
Message-ID: <20250105172613.1204781-25-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad8460.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index 535ee3105af6..6e45686902dd 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -264,9 +264,12 @@ static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, uintptr_t priva
 	if (ret)
 		return ret;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-		return ad8460_enable_apg_mode(state, toggle_en);
-	unreachable();
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad8460_enable_apg_mode(state, toggle_en);
+	iio_device_release_direct(indio_dev);
+	return ret;
 }
 
 static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
@@ -421,14 +424,17 @@ static int ad8460_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad8460_state *state = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-				return ad8460_set_sample(state, val);
-			unreachable();
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+			ret = ad8460_set_sample(state, val);
+			iio_device_release_direct(indio_dev);
+			return ret;
 		case IIO_CURRENT:
 			return regmap_write(state->regmap, AD8460_CTRL_REG(0x04),
 					    FIELD_PREP(AD8460_QUIESCENT_CURRENT_MSK, val));
-- 
2.47.1


