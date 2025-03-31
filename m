Return-Path: <linux-iio+bounces-17433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F153AA76577
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CF9166AAC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168151E32CD;
	Mon, 31 Mar 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGrEuT9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86E1D89FD
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423234; cv=none; b=Ig4hOK9fw57EtBU9+ZvSNpHZiJOHB+GOvyFWKXVHfB7mKDl4irex7q4+mcqRjSLeIwDoKAUKNR1WG2Z0V9QEMSvOK3mxac/M9z7sfpk2E3SoD9XENG8cp/+jW7KkHA0vISmCAacgxbGQx4N5FoawscVKSMXO1+2uWrnsYhuX5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423234; c=relaxed/simple;
	bh=jEyMP4M6WeQnyIY2iM+tZzfcMeqjGyxQBd48I1lM9Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVuHGT34M3t10f0LUB5+KFc4I/9hcTqrQztw1Wf3lRMYQpX0mZGxY89F8qPv6ZYFOChwC2RinA30/dfx2fv2qakPwLMgPSSwNGkX75a8mIeLw0/bKjXus7zwJPRZEFq4foqVWwVdykItaSmDVfIStYqADkn92Q05X8Gcj2wR++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGrEuT9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE49C4CEE3;
	Mon, 31 Mar 2025 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423234;
	bh=jEyMP4M6WeQnyIY2iM+tZzfcMeqjGyxQBd48I1lM9Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGrEuT9BpbQ16FzTW5lFyoGnEAUMDJfRfoJ/vdcWwYOGU3gMDdoenTfnbZL3R2CS5
	 NGosyzLWxiPamMGLs4fJJRpyB3kB5KC0OZvmUi5Xva2cyzGIWHYY4wy0yCwGPOJoNb
	 WF+EsiUfC4MuQqg/LFU+O1BgZNN04fVZnxwobbqgXcHeTbyqnJg8wkaFX2l4vDI/E7
	 fJfNiQ7VBeK+AHExkhxuQcv+H97xAWv+kfwYJPd5c+4iy5xEndEUMCqB+51u+GFw9s
	 2hHahPbTgNE1yGaQt++sP18bq50Gqx/xNldsZXM9t/xMzZqk1jezSzT62Gpj0Z0oDW
	 Kl6jVbvtv4oKQ==
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
Subject: [PATCH 03/37] iio: chemical: ccs811: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:43 +0100
Message-ID: <20250331121317.1694135-4-jic23@kernel.org>
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
 drivers/iio/chemical/ccs811.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 75b0cb05dd86..1eab256a1e00 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -258,13 +258,12 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ccs811_read_info_raw(data, chan, val, mask);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		return ret;
 
-- 
2.48.1


