Return-Path: <linux-iio+bounces-15664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7991AA38545
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C3F3A3E5C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A121C177;
	Mon, 17 Feb 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0hExj4a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239813A86C
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800922; cv=none; b=k0HWpuLrmY78jgMyXbD8MP0fGwX7zqX131cLPP83CWvzvJURxychpf1TWBemwDpzocWptKD005wG0uEaCtmh94KjFTc2P6YYBq6BrbXKHyInyt8wcUpsUJdpd8j5lVGYH4uBlcXi6R5xKQdlGV/PzAPRrjQJl9prqR9m1qYhy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800922; c=relaxed/simple;
	bh=h3uWuEKi8JPVbMEvjUxHWkApiZJoBwydwSpccooW0zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HX6DjimwxGPJNDvx40L1a2F67GDbVADEzBP3Hwttb2MaPS4SOlPuoWpRUBUmLeMyFL55HD+DJ2cCyx0QcvnRqIhna5HJmKhscJnsDUgJJIssW4j6nC9BpbjnGHTYwYpxb0Om2j5//5D4utDIlq2DG2vDKdpkV82Ni2GN1bVVS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0hExj4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428B3C4CEEC;
	Mon, 17 Feb 2025 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800921;
	bh=h3uWuEKi8JPVbMEvjUxHWkApiZJoBwydwSpccooW0zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0hExj4aC3tfDdDTZCEro3yYRBTxm8CWo+6+2Fh39H3GHLhZRKGMST9Mz7xJ+Tf2T
	 Z0e2gCSxcsiB9hDiGT884ZA9PcyJMb2wTjtY1ShjLtKK1y+6sws3krCkRUoDXBojks
	 pGbMLC/oHVVpYdeXlNf2BdYL8lzdIdSfRi4yXhrAETRWk8fBX8g5z8jkgvurpg9XI1
	 SlC/PnvxIQzZ9Sd4+JzDRr7h6c2JJU6R+QtTQDvVI0vSBaNtKyx+v6IaKOZDI/unJE
	 9lYZMNqO0/t+Kzj56VHgALVB2nscutH0e77/ZC8nDASz9W/haJlWvxDQ1HsT+FA15x
	 eh6r0jLY3MOng==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:01:32 +0000
Message-ID: <20250217140135.896574-6-jic23@kernel.org>
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
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 727e007c5fc1..07dcf5f0599f 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
 	 * issues if users trust the watermark to be reached within known
 	 * time-limit).
 	 */
-	ret = iio_device_claim_direct_mode(idev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(idev))
+		return -EBUSY;
 
 	ret = __kx022a_write_raw(idev, chan, val, val2, mask);
 
-	iio_device_release_direct_mode(idev);
+	iio_device_release_direct(idev);
 
 	return ret;
 }
@@ -624,15 +623,14 @@ static int kx022a_read_raw(struct iio_dev *idev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(idev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(idev))
+			return -EBUSY;
 
 		mutex_lock(&data->mutex);
 		ret = kx022a_get_axis(data, chan, val);
 		mutex_unlock(&data->mutex);
 
-		iio_device_release_direct_mode(idev);
+		iio_device_release_direct(idev);
 
 		return ret;
 
-- 
2.48.1


