Return-Path: <linux-iio+bounces-17450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51038A7658D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BB07A3444
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9211E3DFA;
	Mon, 31 Mar 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZByWwBfo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A513B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423340; cv=none; b=Ef3AKvxXwqO4umxBKxTSkj7BZ8QPSrBAzOyowAu02xJLfW8z6EFlB7fnUidFctnZPBDqqFkjlfmuJPaHamoQ/J9XE1gMxjuqbeER5KQP5lnbJO0nCSVPXSH/AsDiBB3j6KeVTufIpmwsaIq1dJYAtPANo6/IYBy81bbLuUK/b8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423340; c=relaxed/simple;
	bh=VR++2UOfr364mmXn8Q2zor6eP186CmZ42rR19LJy9Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFKOejC3PJXxXEyFVVVSOSM6CibAZ36Bd5kuriAxPjHNtKLm1M+r/WXDynY7TkYmi+GhFNR9NxXx474mLWiicTMP6Fe+nngG6d0yYcrkKzLDh6DRDp2suvQdljYgtiszBe1L7SSUfv2jLpHV49oHZLiG4DaK/1N2OkdT6i5nYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZByWwBfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFE3C4CEE3;
	Mon, 31 Mar 2025 12:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423340;
	bh=VR++2UOfr364mmXn8Q2zor6eP186CmZ42rR19LJy9Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZByWwBfoitwNBET9/22z00D9iUPTwisDA61Sm/P/8fgFgH6jnUybVH+QSRChqhGtk
	 FzI8cDc2WBWBh/r8Q3fuSbIl3Vm9jvpbwgCkvQk0Q1VgoTOElg0aowAFAXyhb4QfIO
	 VezlGR+c+lSHatWpCzIZkToO4bURd/IxZGeM+TXCgNLrowngFcUA4RZ27ad9TVlndu
	 4ecEdTG1YP6V+S7avVPh4iAVcddtaQw2S1L5KVtF0vrIH8Ac8Pp6GVLF18CoHMyfS6
	 DgvE63DriZAYOZDTW97d7KyOEalrU7XI9L6kLZ0sbsl+FJVUxrgE8l2vCNoKB9MElz
	 IZb4Fn1KdmuqQ==
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
Subject: [PATCH 20/37] iio: imu: st_lsm6dsx: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:00 +0100
Message-ID: <20250331121317.1694135-21-jic23@kernel.org>
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
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 17a74f5adfc0..3c5e65dc0f97 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -558,12 +558,11 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(iio_dev);
-		if (ret)
-			break;
+		if (!iio_device_claim_direct(iio_dev))
+			return -EBUSY;
 
 		ret = st_lsm6dsx_shub_read_oneshot(sensor, ch, val);
-		iio_device_release_direct_mode(iio_dev);
+		iio_device_release_direct(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = sensor->ext_info.slv_odr / 1000;
@@ -657,13 +656,12 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(iio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
 
 	ret = __st_lsm6dsx_shub_write_raw(iio_dev, chan, val, val2, mask);
 
-	iio_device_release_direct_mode(iio_dev);
+	iio_device_release_direct(iio_dev);
 
 	return ret;
 }
-- 
2.48.1


