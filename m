Return-Path: <linux-iio+bounces-13903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD61EA01AD9
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621453A2F08
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF61586C8;
	Sun,  5 Jan 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qituKUrM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA78F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736097998; cv=none; b=MXpQthPLwHdxUaz3jWwRlvGkYD+I2L3/HC+RTj5kq3za07AxpY6ncmbhXo3Fuxzt6sVk1KAwOyYQPr51V9gAE7k/CyRg242qypZqL1jqjUCy+Exgp1Nu4BTOzU5nUcKi+pkRjvKZ0zDvqvn1Pn+BiBtuxc/WhciusLvAercgeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736097998; c=relaxed/simple;
	bh=LvzCMEjAWQibg2zyOeH1mejoQc6abULYuWOuDF4cXx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ+ArsXw2Kmw4XRzpSAQBTKnCogzmxNfP0J35gSlGfBGStA5erl+Wz09DxfsWJLaaEU7wE5FDVAKLK2jhtsW+7R/Ts05ph7EzqmylJmYDQJK7zMOpbbbFViIWtvlyMKgZW84w5kwD21lF5LDAYjCxT3cUGpTNQImYdOW9RnqO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qituKUrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E9C4CED0;
	Sun,  5 Jan 2025 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736097998;
	bh=LvzCMEjAWQibg2zyOeH1mejoQc6abULYuWOuDF4cXx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qituKUrM6EInLLd4pJVomSXawLyTIYUGji7xARuj7xRpT5whoTHeqKrQk9DG/W9B5
	 uVzvObc2aBFlNaak+BIlrXHguYz+bxtwPO1HLNaXu0eoFOt2SR0yCTrLf5HAhO3nXI
	 9LyCyLEa2AJVD0tdd6BSEOTtX6UioW/Cga5mCDwTrLyQ5lFMmJOdyr+myv+Mlovx2v
	 oqHXso/vlmQYE/C7IJ8JT7sVbgqTfFibsX8y1rFMLJQsj6xRfZznLDTGUITV0KTo7S
	 Uit1Y+Cr6LnYYUiRHMOUf2BxMBIUx0w+nAxuPFtOJt5F8GcsMNdRG9I/HuP4xf4bTd
	 qY2ErySFmPzsQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 04/27] iio: imu: st_lsm6dsx: Switch to sparse friendly claim/release_direct()
Date: Sun,  5 Jan 2025 17:25:49 +0000
Message-ID: <20250105172613.1204781-5-jic23@kernel.org>
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

This driver caused a false positive with __cond_lock() style solution
but is fine with the simple boolean return approach now used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4fdcc2acc94e..cc7a62198982 100644
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
@@ -1836,9 +1835,8 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	int err;
 
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
2.47.1


