Return-Path: <linux-iio+bounces-15660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2346DA38541
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD53171915
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87176216E3D;
	Mon, 17 Feb 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo4r12bO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866633DF
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800909; cv=none; b=nT+wLcL0MADT6CGFSIMUE2oUe7jDllzdwnqySCUe6uerxeQeMj1JpN2YG5RM1cI34V0t6WNBcd4p9ZculQndKrE0xoK0UoTZi/IKRkktcmGkJsiFJJyG4S2oJciWRgGzQo5wfBPto5gSeypKLwSHABbT5tcQCkwU90f+JsihRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800909; c=relaxed/simple;
	bh=9YWcOgh3TsA0sSkB58gSiKoqn6UaLbJG93pRHT+gH/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALKMznaFyJplS1H9mS0qhwF/y5TQOHylSJYKwFt4dQrAF6TPPW8Tz0s0yn9OaiEhpXSCraVMvN0EpQHkQCmsk6FhN1nEMiKlxJDuzUKUjKipDSZw4SscOPO2kWpeOhbF7az2TdEAu/cJBk/qtEQfefIwc913CchFGt/6H0/u4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo4r12bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F49C4CEE4;
	Mon, 17 Feb 2025 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800908;
	bh=9YWcOgh3TsA0sSkB58gSiKoqn6UaLbJG93pRHT+gH/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lo4r12bODZ9IrEWAd6EwSQ76UFfH5xIzp8fHIeiV7F8RVaGJe1tzjXQxMcrqgWZNq
	 UO5m02SPX/LiCVgz+jZs3nHYQ1TmYXirU+c4tnecc1sH4zu48KsIonIRbDJCF0W2BY
	 pOx5hRQbko2t3mwgsYiVa1Xb73+X6TWaRvtPeJKpbKCzzJkoL/5dSkVGvN72O4O4rO
	 +0LUwmuetZhX+ldSWXuFNjIROc0FW65MmU4PvrO9fZWWAo2qAEqADbro2+xCMTs7/+
	 gKYDHfjD11CrV++MpXYUaLcTDG/dm0k21iAHgG8QR0cM8dXXnbWMI+mEcQ2IOz587u
	 8Dxf8k1feukSg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/8] iio: accel: mma8452: Ensure error return on failure to matching oversampling ratio
Date: Mon, 17 Feb 2025 14:01:28 +0000
Message-ID: <20250217140135.896574-2-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217140135.896574-1-jic23@kernel.org>
References: <20250217140135.896574-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If a match was not found, then the write_raw() callback would return
the odr index, not an error. Return -EINVAL if this occurs.
To avoid similar issues in future, introduce j, a new indexing variable
rather than using ret for this purpose.

Fixes: 79de2ee469aa ("iio: accel: mma8452: claim direct mode during write raw")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma8452.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 962d289065ab..1b2014c4c4b4 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -712,7 +712,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int i, ret;
+	int i, j, ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
@@ -772,14 +772,18 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = mma8452_get_odr_index(data);
+		j = mma8452_get_odr_index(data);
 
 		for (i = 0; i < ARRAY_SIZE(mma8452_os_ratio); i++) {
-			if (mma8452_os_ratio[i][ret] == val) {
+			if (mma8452_os_ratio[i][j] == val) {
 				ret = mma8452_set_power_mode(data, i);
 				break;
 			}
 		}
+		if (i == ARRAY_SIZE(mma8452_os_ratio)) {
+			ret = -EINVAL;
+			break;
+		}
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.48.1


