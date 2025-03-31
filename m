Return-Path: <linux-iio+bounces-17435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BBA76579
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F90C166E6B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6751E32CD;
	Mon, 31 Mar 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUIPKJpL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E578F2B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423246; cv=none; b=nNc7Rzid/Lvrj9oPiEITvdY54P7iwVox7Wsj/odkOzTtSqK5+7/wh/1RxSBDRGnyFFycfK9+lLRk0ykVkcPd/t8u9gbhNNVyRGrcbWtxqJLfk6eELKdrGsT49JA2yhm7DFK5wiG2ZPVQmagfvi8uxm9Dt3VuwSoFAlpGbMzGi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423246; c=relaxed/simple;
	bh=BHrhbAFBX1TcGWm0wx4g1ujM5RoQN26rnafQTzyIoOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkeYrbLn52s3m8OdAioV3Z8m7bTv2pB5dEOG1K8DPslp0NyGSXipItBKckl94h1j6EzpcBRqwV2/SFUCYTmFvBbO72NvYvdJY8Mw1lC9iAp/QEb4UNuKFavpv3hoiEQ8tgXRQRxbdJBqDd5/43qz1i6LbusEOT1lOgSSz+oJ3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUIPKJpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C8CC4CEE3;
	Mon, 31 Mar 2025 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423246;
	bh=BHrhbAFBX1TcGWm0wx4g1ujM5RoQN26rnafQTzyIoOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUIPKJpL8unbxGMmplk9TXgWts8dc+F/r/jivB4jPhgY26Z2IT9P0YIHFM3XHFUwB
	 g1T6ZV9zDcATF/ulzVTVmpuIMCWKdd7MmenLPLj3qv0nOYhbedGmU/YIOMd45k0oUP
	 DXbXb2kxKQlThyPkZgGOX52/82UBvkQUeEVn29hnkXGTxjZXHgAoZdEwb2b5Bk22Cj
	 T9kazmqYV/1JpbfMXwL/8w+lEvn6NKQIpxFJ5hrSK+//Wc4x0se+oa/UrCzf7y2S7E
	 mietHXs+4OYMNaOBGUKXPJO0BZl5cOwV+GXCfwtpAl0h6wcFoKT9/EgzAN6rRLc1IH
	 6T/etl6BAXFhQ==
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
Subject: [PATCH 05/37] iio: chemical: scd4x: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:45 +0100
Message-ID: <20250331121317.1694135-6-jic23@kernel.org>
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
Cc: Roan van Dijk <roan@protonic.nl>
---
 drivers/iio/chemical/scd4x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 50e3ac44422b..4877bd3e907b 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -358,15 +358,14 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		mutex_lock(&state->lock);
 		ret = scd4x_read_channel(state, chan->address);
 		mutex_unlock(&state->lock);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


