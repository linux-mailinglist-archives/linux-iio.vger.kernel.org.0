Return-Path: <linux-iio+bounces-15662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF4A38543
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C733A37D5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60E13A86C;
	Mon, 17 Feb 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLnXQC5T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAA33DF
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800915; cv=none; b=gm++rsGjJ7yNajWtE7bW4kcJMbMjTrJyt6JJwcIMn7ivDhkEFENPb4XJzUBVB2At4ZFcrPyYDcp0XxumRlt/RueCHNNZh4OnsQo/Yms2D5PUbmmZWSD244nXmr2261vFhw24wDBzGX7dBdPMDS/3t/5yMRFxcW8k+9GQAYIhKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800915; c=relaxed/simple;
	bh=TJoaSjvpYQoqgTt+vD4XOI0TBbWlYvKyeZoU82p+YWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDGxN9BIfAeuCRh+Cl7UnsiAz6/Zes/dTdL+As52iCh7WiTXU/N73804zxKQSyf8dgL1E7TrjZuFX6G6VETTZephkpnysSwXmbQjl6CM0EWQ5XOyeK3EN5HyJLdRlK6B6E8jrdt24ktea3E3rtG0bjeK6+Lsh9lgS5xxCSq3IdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLnXQC5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C874BC4CED1;
	Mon, 17 Feb 2025 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800914;
	bh=TJoaSjvpYQoqgTt+vD4XOI0TBbWlYvKyeZoU82p+YWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLnXQC5ThaE4SSPvR2u3wxJ3/N9nnJmH6MV3V044d0qnlAnps7AauV+pi/TrKDBf6
	 Cu8xsRz1edsasUKRHDW2eLgCELvMgg6qvywhWHBEQq1+RQGFVkxviCGOQrB6KAss+Q
	 RekDIFVQjVVvZR/Y9aCiOnsX4H+/EVf83UgRPmXshe3xsTuC8slB1op7NM+dURnlbr
	 2pyU8ObdEU5ROdFE8owno20x88appSIUcorGf7JRPq/q0P/cXoGgx/4mbJe2QvUc4M
	 SLEYspQqkhtL4PIy27NVHYXDSRW/2mTNSdYC4+JHM8lAqjwbv5V9XIoE/+Nx3zkcRo
	 xQU8r3J+mo+zQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/8] iio: accel: mma8452: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:01:30 +0000
Message-ID: <20250217140135.896574-4-jic23@kernel.org>
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

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma8452.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 8ce4ddadc559..05f5482f366e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -497,14 +497,13 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		mutex_lock(&data->lock);
 		ret = mma8452_read(data, buffer);
 		mutex_unlock(&data->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -781,12 +780,11 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = __mma8452_write_raw(indio_dev, chan, val, val2, mask);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
-- 
2.48.1


