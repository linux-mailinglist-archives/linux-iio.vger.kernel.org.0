Return-Path: <linux-iio+bounces-17460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6CA7659A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CCB188991B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE11E51EF;
	Mon, 31 Mar 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBDiI7CA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8813B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423404; cv=none; b=REPcTfkRabt7JGGpM++tTqY2vNvDCRIu7kZhuElCBdnydMhgPys+JbpTOv6Xiv+YqALiP5HKIOrF25UsTcx/nZopbZUSi0jPRLH3OyrezDgBUUp2dAy3/Kw3saguYfLtpQ/y7RYr7Fq0FwQ+QaseKAAzGaZC+9hOvpYLgfp0P4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423404; c=relaxed/simple;
	bh=dnCGsUoYuKQ62zcc48laVLaiJRe3tyDVfJ4ijD3rWrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAkUhrQyNjFwPexnwrHOGIZ0q6eCM4SENCLBLpPzalMh4JOzxglBSC2Gid4HKaxMo2LNnNTH5BPhExPR1L1F6x1vBz1Kj0jSLOu+Tx8Tr3t4yq3o6YjT40HfQHrwn3qjCV+SOrXR4ROjvmRVNPlFpxyDxetfiCuzXWIRu+a2EaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBDiI7CA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65502C4CEE3;
	Mon, 31 Mar 2025 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423404;
	bh=dnCGsUoYuKQ62zcc48laVLaiJRe3tyDVfJ4ijD3rWrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBDiI7CAfQSPE38PFgL5R9/BRGCI2JD4Y0SokKOh2rzj59Vb8G3ytTBNJjce7hoC7
	 NB9I1rsqgRjs16LYXx2EeFxUBSMP/rjQ3MR2naJ3fXo7kYabmCgqdhgbEW4Ycn3Bpl
	 xXFr9kcvc/cpUnn6g+bghwFWgskCf5b4sdEiadfmgCldsyCgb7rG6gS7Hd7rkEBS1E
	 tDnN+xIeB5LxL/95gWf1fy5/R2Q3OAy9GY7tQMaWlY8bW6uOurioeYWahMjd/1bYFA
	 /fvwngg6BYH9Xq4BmZOR9n1+3hrYvggjalf7/cUShh1TTuN//ehvi2AVlpswlPrBPs
	 jxkvtu79hgi7w==
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
Subject: [PATCH 30/37] iio: pressure: zpa2326: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:10 +0100
Message-ID: <20250331121317.1694135-31-jic23@kernel.org>
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
 drivers/iio/pressure/zpa2326.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 9db1c94dfc18..0a510d5fc1d4 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1062,9 +1062,8 @@ static int zpa2326_sample_oneshot(struct iio_dev     *indio_dev,
 	int                     ret;
 	struct zpa2326_private *priv;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = zpa2326_resume(indio_dev);
 	if (ret < 0)
@@ -1120,7 +1119,7 @@ static int zpa2326_sample_oneshot(struct iio_dev     *indio_dev,
 suspend:
 	zpa2326_suspend(indio_dev);
 release:
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
@@ -1438,7 +1437,6 @@ static int zpa2326_set_frequency(struct iio_dev *indio_dev, int hz)
 {
 	struct zpa2326_private *priv = iio_priv(indio_dev);
 	int                     freq;
-	int                     err;
 
 	/* Check if requested frequency is supported. */
 	for (freq = 0; freq < ARRAY_SIZE(zpa2326_sampling_frequencies); freq++)
@@ -1448,13 +1446,12 @@ static int zpa2326_set_frequency(struct iio_dev *indio_dev, int hz)
 		return -EINVAL;
 
 	/* Don't allow changing frequency if buffered sampling is ongoing. */
-	err = iio_device_claim_direct_mode(indio_dev);
-	if (err)
-		return err;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	priv->frequency = &zpa2326_sampling_frequencies[freq];
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return 0;
 }
-- 
2.48.1


