Return-Path: <linux-iio+bounces-17455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEAFA76593
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A3416A3C4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC981E47D9;
	Mon, 31 Mar 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXDSZYTc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC513B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423372; cv=none; b=JGuYI3sEJFNdVji/ZLamzVEMYwFoT4Hnewga7lxfXZ8iqgLzbw5CG/D8sUgi9GjBiKV+2r8MTORETROggW0+FAd00AOk8jSgIB8IVX0GZvWxwMxBJIqbSFHjc6eu3Sm8tRQX1ly2X/7nuKkUbsZKdXtvrNYa9rVCCCNQrMJwqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423372; c=relaxed/simple;
	bh=a22iHUVEWcITkEW175cLzjZ/93VY9FSxJOe3GeehRec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+gQ2OhGX6pYn+n2wCyxiMaIbfD3Ojtd6xR8rBqCQbZio0o4AFKg4xZ2duaTURbEYVxNHgszMVDFt1+Aox6zMGCRZhTjuY4za8R0B5qr6uAXc9GRkFMiBD9XYrOKEcaylC6XPOXVtqW3uRtkCjDd+s3PTiu2SfJr3IoOif91AIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXDSZYTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E64C4CEE3;
	Mon, 31 Mar 2025 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423372;
	bh=a22iHUVEWcITkEW175cLzjZ/93VY9FSxJOe3GeehRec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXDSZYTctw4yB1dWpqvlYk2HYCqYel4f9dSYjOqtBLddq3MEJ1aT+/GKdkAvvDz1A
	 wXNEji7D8h7mQia4JYlHMQiJe1KAID7g4wmI93p0FGArxadFAHxCZYZnCnORDmhCRI
	 hDVa8SqDndsWt0MAN7NvyQ/Mqqgi4kVNN4//E+CvzFbstsGw+h4VXEqk9qlU7GA3Wt
	 Spk3irfADk5xTXRPHgj6Oua/hmebFLH9YQ03ZKwojppn2gLyZPv6ZZF14kJvZjvh5L
	 OijaFT8ClHc/vQMgwGS3ycLHWcOHWZ/NrFuElrS6oZcdut4IaSZ6anHKiXnZPE2HdZ
	 e4WJD+WNKs7FQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 25/37] iio: pressure: icp10100: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:05 +0100
Message-ID: <20250331121317.1694135-26-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/icp10100.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 3e0bf5d31ad7..1951c1cc84cf 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -343,9 +343,8 @@ static int icp10100_read_raw_measures(struct iio_dev *indio_dev,
 	uint32_t pressure_mPa;
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = icp10100_get_measures(st, &raw_pressure, &raw_temp);
 	if (ret)
@@ -370,7 +369,7 @@ static int icp10100_read_raw_measures(struct iio_dev *indio_dev,
 	}
 
 error_release:
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
@@ -439,7 +438,6 @@ static int icp10100_write_raw(struct iio_dev *indio_dev,
 {
 	struct icp10100_state *st = iio_priv(indio_dev);
 	unsigned int mode;
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -449,13 +447,12 @@ static int icp10100_write_raw(struct iio_dev *indio_dev,
 		mode = ilog2(val);
 		if (mode >= ICP10100_MODE_NB)
 			return -EINVAL;
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		mutex_lock(&st->lock);
 		st->mode = mode;
 		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.48.1


