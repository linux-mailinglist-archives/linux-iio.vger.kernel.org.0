Return-Path: <linux-iio+bounces-17457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245FDA76595
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9C416A1ED
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC691E503D;
	Mon, 31 Mar 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+BRhsWN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070F1E4928
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423385; cv=none; b=VEvuf1o6wMiatEtxTehMDOy9eStTeRLyTtt35bx4KE6WFq6FMmEy1n96q03X1Lxv/nURUbmCj8ZLf0DJUjvL+cYDC+hR5CEU1Uz2fnebOjCqvJTw0tVtkf4ArHGTIPttaIon4ac8RtQqzfIoCgs7A40iJEYyeNLyG8WmDRhSV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423385; c=relaxed/simple;
	bh=ZcZGIii6/Ox7LyowmCk1Unk9ygW9GtczF1dAspq7l0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGI+RH3KlnVwM+wLrqt6ylb569N1gOlupm8hYc6azpJV7Vd4M+zTkKU8PR+ERGlglzfcucWWjBLZO8FhXxwABUl/CFiY1lI1cmamdZiwxq4D+MGu3xG60SNg4pvKz6XOMTIfM/tAKgn4vBJNh4/9WbrlT7TbYIlJnAx/y+oc/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+BRhsWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4BC4CEE3;
	Mon, 31 Mar 2025 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423384;
	bh=ZcZGIii6/Ox7LyowmCk1Unk9ygW9GtczF1dAspq7l0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+BRhsWNqZ4LGWlXzwDJtuGC2QvSAu32BnKXjoPOLFEy7wf6SpYEcANqUFK0g8+DQ
	 fJvwpjWrRRq1hpSmUb43gKCZ80ikqpdpwj4QIiZiHXSBe/knTP/K0hWzPRSO2BxexF
	 QQjZmJ3jf15bbryzp1e4DwJ/+o2H+vFIuqKHIX2VyOblCPipQvDD8xzlY1hddv8jSH
	 tvKgnPvk0VXAHhvEZTHREFbWG7H0s/6qn6tqUetf+MjFT81bz7P7/NjOX6Xs7QmOLZ
	 /7/Dy5XfExM9M+LFPfo5pwavJ7OyTmxxPN8g7WsKhkQY0r7PRN5PJm0Qg8LicwQNBx
	 faTr4baFyvjIg==
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
Subject: [PATCH 27/37] iio: pressure: mpl3115: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:07 +0100
Message-ID: <20250331121317.1694135-28-jic23@kernel.org>
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
 drivers/iio/pressure/mpl3115.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 207031b5ff72..8397155555bd 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -124,12 +124,11 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = mpl3115_read_info_raw(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
-- 
2.48.1


