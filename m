Return-Path: <linux-iio+bounces-17454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A05A76592
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536D516A329
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010891E51F2;
	Mon, 31 Mar 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhuPyIx2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CE1E51E0
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423365; cv=none; b=QPWFD7BMlA2878266ILqdiXUQm+OXM3bIOd/fpkeBvD8kjepVLDXbCAIEyX7/OA9iX2SDXmB6ZGvmZI0xwQ3Enwcr5IVH2qjJdZSpeYmrmsIXJRFKwEyx1VOs9jsipoQStE++IBXKJRirNUJhkgrp0d0FkreMBm+jovm+NJxIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423365; c=relaxed/simple;
	bh=814EvMRx0qFMRMvy57rOwBUuqPy4LiyubiQe0S3b5I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZvCOaOaZibLIRiY1K8T1BjfAp4Fuxb2D+Il7cY0fMWTU8Pj3jpoY2PlHSSqjcSy4PoWYNCkI/G6WfUDAO3sRRrVANtO5FaPmygwizwRtadF1A1qSrdE2YNHtVuAHcbzlHI50pr2Slj1QZK6OU3eulf78fSUgVWQsagCnSl3svA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhuPyIx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C413AC4CEE5;
	Mon, 31 Mar 2025 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423365;
	bh=814EvMRx0qFMRMvy57rOwBUuqPy4LiyubiQe0S3b5I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhuPyIx2xUb8WxvdSNYMuxAz/iEs4IFVZDiHCOHn9C7lNFU3gw66TQoCwzuT8ZPMB
	 XdCkQqtoTrFjluTylbqahz+qIGLDZt1mVUt0UdOsfJulh8IOrSmwhaQxI7NaU9M9ek
	 OqGUn+nMmoNMl+sr0tUiO6HpZz0j7xJBAvn4EzLTcu1ylExIX/++UUXBBmwfbNUZta
	 izOrJ33GtJhdtfKUnPyURXJHauMWeV8CBOEd4xfebu6uCjcd6gsU8c+bcI+g0M9uV1
	 Q4OyKm5vgr3F/FjYhg/Ms81pkHIkkwwDWiumroFQaA8J4WACd06ZWKiJ8lyVahb2sp
	 OZZjBJO0XjNKA==
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
Subject: [PATCH 24/37] iio: pressure: dlhl60d: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:04 +0100
Message-ID: <20250331121317.1694135-25-jic23@kernel.org>
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
 drivers/iio/pressure/dlhl60d.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index e99e97ea6300..e0aa12949cde 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -147,12 +147,11 @@ static int dlh_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = dlh_read_direct(st, &pressure, &temperature);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 
-- 
2.48.1


