Return-Path: <linux-iio+bounces-17449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BAA7658C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA057188919F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3901E3DFA;
	Mon, 31 Mar 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwsCch5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD413B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423334; cv=none; b=BgGMHzzpO6oxi1EyyJ6JCbP0OAFlvqAE6HPpUFwNeN88/wYqWIK/cmthrlMq1G1TWxO+6xMrQ0pe65ADJbkhKyDOmQKmT2/l3kQz97KPWSrB3SH55YSJWU6YHgMYsYnCH1//JQ6aQUGPH0/9xdSDKcQLVmBayYxwUhiYnLu5iq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423334; c=relaxed/simple;
	bh=jrfpwY9AnpDdjNfVj8WPPVFTu9qh9emfIv3+kOxZ45s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHo44cbC9S1zZs5RSccdVeHlOBktNts8DHs4CaZXS89ew78rU4oFZIPRUuOucoGe0rG24ZvhTv47t5M5tPD2T0+XQPqLTyrXdwfyHOat4iztfPjfJAKUI8XxCS1zpyPH4zOMOUYI3KzSD7vXV6V5f/Rpqcp/YFVRSR+8bdS5FVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwsCch5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7280AC4CEE3;
	Mon, 31 Mar 2025 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423334;
	bh=jrfpwY9AnpDdjNfVj8WPPVFTu9qh9emfIv3+kOxZ45s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwsCch5CodVgMq5xjfpxQsfhS507G+Z8iz5C6Raci+pxR6iRNHPXKyn6At2DZw2vf
	 rF5Q5+7ffe9ibEvh1G8zALKgN4+tET7TKlIfegrHjWH035yDitCnYkeuTAbyI16TOx
	 gdUBaBEPyHMnzxgoxl2UX5uUK8689x6+IjyM32dXQQbsLoM7KcPKFq9Bx5d88+LcP/
	 ktDoRFJyYNDyNk8SWa/HAZ7LDrzvHzu325FNyTVCR5Lr0RjEHOgstQM7hKz4of1JkQ
	 lOkmyqJ4fiZlrLwaSjLkbYUD5lQ21Klz3onPyOjPPONf2iXsyF7PPAxkaQbllZC+l1
	 jXv8fdtPa47hQ==
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
Subject: [PATCH 19/37] iio: imu: st_lsm6dsx: Switch to sparse friendly claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:59 +0100
Message-ID: <20250331121317.1694135-20-jic23@kernel.org>
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

This driver caused a false positive with __cond_lock() style solution
but is fine with the simple boolean return approach now used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4fdcc2acc94e..670cd217eb50 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1804,12 +1804,11 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(iio_dev);
-		if (ret)
-			break;
+		if (!iio_device_claim_direct(iio_dev))
+			return -EBUSY;
 
 		ret = st_lsm6dsx_read_oneshot(sensor, ch->address, val);
-		iio_device_release_direct_mode(iio_dev);
+		iio_device_release_direct(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = sensor->odr / 1000;
@@ -1834,11 +1833,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 				int val, int val2, long mask)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
-	int err;
+	int err = 0;
 
-	err = iio_device_claim_direct_mode(iio_dev);
-	if (err)
-		return err;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -1860,7 +1858,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 		break;
 	}
 
-	iio_device_release_direct_mode(iio_dev);
+	iio_device_release_direct(iio_dev);
 
 	return err;
 }
-- 
2.48.1


