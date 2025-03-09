Return-Path: <linux-iio+bounces-16616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155EAA58603
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A1B16A13C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4D11E1DF3;
	Sun,  9 Mar 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elcax4ap"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03552AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540047; cv=none; b=m99YLeuxvtxBlOaFs3W0I/38jJXnJm8qd3hwTjMW3/sQKENaoWLvpeV9b1Dh3B7x0JoA3C95WysNtp2ghjR/c2PBZZ+xotif6W2RnorCGI8h9WswOkAL2fF0aNo+6dkoZ1boN0+TdHJcMV3QToG0+tKlX+rkHUGdauGNvxNEqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540047; c=relaxed/simple;
	bh=Glm054UF7gsijxp1o0fpgRfdd9zpxnntrRxRUgPbgtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XF7T4IEdMMDKK7t62SpyM5pcAZAwvakQDhJMDYpUyWNrAkPa+zJvfSDz8fxcRMx1e1aLQ/uE2mxejyBscPJdEFjhj4MwAIVlCtmr7QTXDWVmTGvPq3hfKZp6aFvpgG9uFaF5jChrQ42Hu3F4tm9e0v2d4+tBoOUiR2dlxhM49PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elcax4ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B99C4CEE5;
	Sun,  9 Mar 2025 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540046;
	bh=Glm054UF7gsijxp1o0fpgRfdd9zpxnntrRxRUgPbgtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elcax4apKfSWDXz5JV0+u25D2cqfxNzQjd0VRUkJpkSSS5S828QdPGk44Z+4zXqTR
	 HizGhyeYUJEQfCQS2Urnr9EmEm8/tIvqXSxUGfoC8t4HAEyVTiOuMNGG4ygwnrAGUq
	 PzMSXO+37VpLHTcSHLBJVQC5pphyJ7sl98B5dSq6FHA0rCcx1yG3zpBnFoDOrtD6Zt
	 Ovi28xJzjaWK6i3r7XKigi9YAHne+Z0Z4Kf8296xQJ1uhVppUp2XCrDimJnegJJFzB
	 SUgAOOKa1TzPRZ2gFEAeu2kaFZEQHrtODIwfvCHi5yjDiHgW51t5AJ14g5IpC/VJ/u
	 ZpllyDnJ33auA==
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
Subject: [PATCH 10/18] iio: light: rohm-bu27034: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:25 +0000
Message-ID: <20250309170633.1347476-11-jic23@kernel.org>
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
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/light/rohm-bu27034.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index cc25596cb248..7cec5e943373 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -998,9 +998,8 @@ static int bu27034_read_raw(struct iio_dev *idev,
 			return -EINVAL;
 
 		/* Don't mess with measurement enabling while buffering */
-		ret = iio_device_claim_direct_mode(idev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(idev))
+			return -EBUSY;
 
 		mutex_lock(&data->mutex);
 		/*
@@ -1011,7 +1010,7 @@ static int bu27034_read_raw(struct iio_dev *idev,
 		ret = result_get(data, chan->channel, val);
 
 		mutex_unlock(&data->mutex);
-		iio_device_release_direct_mode(idev);
+		iio_device_release_direct(idev);
 
 		if (ret)
 			return ret;
@@ -1050,9 +1049,8 @@ static int bu27034_write_raw(struct iio_dev *idev,
 	struct bu27034_data *data = iio_priv(idev);
 	int ret;
 
-	ret = iio_device_claim_direct_mode(idev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(idev))
+		return -EBUSY;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -1069,7 +1067,7 @@ static int bu27034_write_raw(struct iio_dev *idev,
 		break;
 	}
 
-	iio_device_release_direct_mode(idev);
+	iio_device_release_direct(idev);
 
 	return ret;
 }
-- 
2.48.1


