Return-Path: <linux-iio+bounces-16622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14EA5860A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55F7188B7A4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0B4A0C;
	Sun,  9 Mar 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZW/ZHyJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD11DF742
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540072; cv=none; b=qscTZZPaDm5Cd4y0Vq/8QQgksZwxnP2YwLHh4OI4OejlQpMyPB8l435HAbzayx4/uzCRMyVM9vHboFDbJIl2L3Sap+xVsAyj7LN2GbQ4WrQy0DSW49gC5PJCMk2aqkmEsCBTxA6snRU3lTL8uNg3bXtfZkL01REBvz8FaflJT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540072; c=relaxed/simple;
	bh=a/NPPG2XkfdR2ZuUuZhG5X4UdXWm5oNO9UxHKUQFO00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHvwlhgtMcwdR5PKQd+e1NmjrtBu9GNwu8SaMckT38Sl/ZGGXyPKJGpzZXVzsCgr5yXRtgPiV++Qr21igbqOyjc4OQH+0uuMlgZ2yjyI9B55ctoANHBeBFasRNT9EGMFmfL7iQdNYNbQpYAq/aNol5YBg4XGymywZCu87m+qjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZW/ZHyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BF6C4CEE3;
	Sun,  9 Mar 2025 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540072;
	bh=a/NPPG2XkfdR2ZuUuZhG5X4UdXWm5oNO9UxHKUQFO00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZW/ZHyJwz0FdNFlDrwDf4qWGeczCfcAs/gSaYNIKJjO6lXQ69Ii+Bno0o9Crc4i3
	 yNQ/m9jTxV2QZJ6YEX7R8yjLyZZp1unSDu4jcz2LGgMxmuHsabElB2ld56mJBy1ATO
	 Z+MzsDFm1r8zJIXp1AnAwaCUeTKW2y5VStj2tDq2Mq3B8JzHCNY4P57ocID3rZ8Zu0
	 sN25kzCDv3A54SA/Wqa/PfmMbaKZY7UB0gctJZBDgPHf19QiNe6JFHR1j15CAOtDk9
	 35zStVRQCMAYpbJq5nhV6bTzp97MjkRDA4+DY19u0c43t52oVmMPRS4ixULly5dFBU
	 4GrSPZCNWuq7A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/18] iio: light: tcs3472: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:31 +0000
Message-ID: <20250309170633.1347476-17-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
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
 drivers/iio/light/tcs3472.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 2bd36a344ea5..0f8bf8503edd 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -148,16 +148,15 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = tcs3472_req_data(data);
 		if (ret < 0) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 		ret = i2c_smbus_read_word_data(data->client, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
-- 
2.48.1


