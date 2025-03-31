Return-Path: <linux-iio+bounces-17439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2AA7657F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AB47A3440
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5F11E3780;
	Mon, 31 Mar 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2J2y7gF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000B1E32A0
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423272; cv=none; b=bYd+dV7WZDnTL+XLbRIISHeVsddAoWAVy4hrT5OJdJooag4nX/SwvieFWcvbzPSa02ChY5/RuvyVGSV9XygAJqLiQsr0+1TFFc00PMFxob5EwKOKFLZ4b6EjjI/lh9q7AEDjWPiY0Z+bvCJ1VHeOOvlYwd2vLSQda1M2BHepUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423272; c=relaxed/simple;
	bh=PMhnEKlnga3mxdWZiMXvLCRVbwuIgA20A9EgmuvdvjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdBKcXSDu2jcZxPcBHvVd2tA6jgV7akTchQvmXKQ3Ow2vVhMKF+fArUfYpgWf87WvzUf9AuQBFlxDc/Ib3QolDC1YajtzkvyoeTATPJAhsrezmcVRU7fQPfa5m0fPCULGiqXQ/KbbNUGXL+srRb6tky3uxev58BbyXmrL1GF++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2J2y7gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BEAC4CEE3;
	Mon, 31 Mar 2025 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423271;
	bh=PMhnEKlnga3mxdWZiMXvLCRVbwuIgA20A9EgmuvdvjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2J2y7gFjQctSnyeDnXpe+1SD2o1IWPgeo8RPV1L/1aQaL1W7QT5GotSTjkTdFsXa
	 DE1inXNCMdx8DvYGifqkLRaM2z9kuWlFpcOizoMfWTtErAmPfadrBI+w1LKzlg7aha
	 /a2nkll6GyEOUhwvWI8sJnNHwZuUyvYD1JegfrArPt/zxKTv/ucZEXVTgCymx75bX9
	 DwZYY0Z1CM9yu1vOeKbZJbL5JkUp97Yu8qlOxiNqwPYIjvRvsWcO370kzO8xSMNCKy
	 HXC05cRX7LnSKZl87p3cCaiKwWL7pugYPBp9CzyYb0W2TuY0Oe6GwKG4FlshQHao4v
	 RhCHNL8PdMTBA==
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
Subject: [PATCH 09/37] iio: health: max30102: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:49 +0100
Message-ID: <20250331121317.1694135-10-jic23@kernel.org>
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
functions that are deprecated. This particular case is about ensuring
the mode does not change rather than ensuring we are in direct mode.
A follow up may cleanup the buffer mode claim.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/health/max30102.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 1d074eb6a8c5..dacc489f7293 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -484,11 +484,11 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 			 * things cannot concurrently change. And we just keep
 			 * trying until we get one of the modes...
 			 */
-			if (iio_device_claim_direct_mode(indio_dev))
+			if (!iio_device_claim_direct(indio_dev))
 				goto any_mode_retry;
 
 			ret = max30102_get_temp(data, val, true);
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 		} else {
 			ret = max30102_get_temp(data, val, false);
 			iio_device_release_buffer_mode(indio_dev);
-- 
2.48.1


