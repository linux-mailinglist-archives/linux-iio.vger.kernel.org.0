Return-Path: <linux-iio+bounces-17446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C15CA76588
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576D21888F5E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EAB1E1A08;
	Mon, 31 Mar 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS+hRJy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE48153801
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423315; cv=none; b=WLMU8102wuV+0zSCe5gfDGvZubp41/TezIFLo3o4FOC0Hm6jH55fGTHrgbqcKV/hB4xVDVQLmuBk3jOA2317vdWT/G0Z5baEkRUxzioH0K6tuZHnoQVyCTT5mKb16XXnvCQ5ktWPR/+6JyLgogcWhi0CG83fn3u/4y0E0MdG1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423315; c=relaxed/simple;
	bh=JE4XuKAKGgE7k0/xEL8h1v5KsxeemlI6chjEJgf7m5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP2V0Pd+Xi4rpvcWv7tHUYZ+byUr6hCUHxJP+TxjUGOvtn7f2u0LwRnRzgG3NvwY7vK+wJ27EsNyjWa+9IAk6BXdzSJCX157YV4ynj0t/Dr51XdL5LzG+yiJv6aygHTyMfGFO89EDJ30aZPyNaovkA7NmsE6SX+lNIWodN+yVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FS+hRJy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1ACC4CEE3;
	Mon, 31 Mar 2025 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423315;
	bh=JE4XuKAKGgE7k0/xEL8h1v5KsxeemlI6chjEJgf7m5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FS+hRJy0c7rHEkIWPlTQV0FFYhgctWse06SlgZSV9zTBfN8E7d7EV0Sxmn/JEmtoe
	 oz5blDtRcXzIA2AQJkYSllGSfCjHK1EqaE/SIp2EY4c6rwtHmWm3LMZW1M3GebgTEW
	 SIvRxse0c6fnii6tAG31U1DTkNwBWkeIyym3bWslD6gRN0lZfznRIbD4qHEUSqxCJb
	 xj/yu28r0voGQ8dHcFQKujwX/fIQUUYWJAPWzV6LiNzwrdZNt27+W0agRIpy+ONA98
	 IZWT4fzVft+jNCYy4/FIaQ40lbPpiSoE2g8JRtJ2s8y52CjvtJFsri2EgWJ4Wx/R8M
	 wmhCy3WwkOZLQ==
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
Subject: [PATCH 16/37] iio: imu: inv_mpu6050: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:56 +0100
Message-ID: <20250331121317.1694135-17-jic23@kernel.org>
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
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5bcd5e797046..b8656c02354a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -755,13 +755,12 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		mutex_lock(&st->lock);
 		ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
 		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
@@ -895,9 +894,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	 * we should only update scale when the chip is disabled, i.e.
 	 * not running
 	 */
-	result = iio_device_claim_direct_mode(indio_dev);
-	if (result)
-		return result;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	mutex_lock(&st->lock);
 	result = pm_runtime_resume_and_get(pdev);
@@ -944,7 +942,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	pm_runtime_put_autosuspend(pdev);
 error_write_raw_unlock:
 	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return result;
 }
-- 
2.48.1


