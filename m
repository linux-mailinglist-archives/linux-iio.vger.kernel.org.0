Return-Path: <linux-iio+bounces-17442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4269EA76583
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B17C3AA0A3
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E81E3DCD;
	Mon, 31 Mar 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTHBaHIv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5E1E377F
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423291; cv=none; b=qiG9onkr5wJ3u07fxdebnStwy72VmUgnMrAdlt7NtNk12JV5d886FEwzuewD3ZjhstTrAr/dYqpIvIHievZc2twSCTfIZkJDZSSdyPBin64w9Ho+ubtxIvuzrFXjkxTdNHm9DzYN9sqt/ZhQBKuSNAXDKBdblLTzzQ3X1Cy65Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423291; c=relaxed/simple;
	bh=XHdwhv0AaXUg1kPAk8S0qAkPHuUhiza78tbUhyE/d/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxD5UdyOFsjllzHtkQiJgZkVNH238RHOVc3ae3dE3QWF02nB0uSWJ1mvANH07CbNjHi2I0hozGPRaCWXQF0/hJU33PNAtFFT1YzrM3BoKjmtN6spZKA3EvJGApoIq2DM9RK/gXv3gr8RbROalTA+vqWZHcICb8p5QE7ZdqzACZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTHBaHIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F17AC4CEE3;
	Mon, 31 Mar 2025 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423290;
	bh=XHdwhv0AaXUg1kPAk8S0qAkPHuUhiza78tbUhyE/d/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTHBaHIvddWblmAKVPLWTR4wEhaVvcepc5zcLM6vEhBYQ4IPjJ2vHg92jW85k+tiq
	 bTAoQ2JrNYIa7LuUgplyEhEcFgsO4UMSKPVjLk0vWd34Fxmky/yIE56mjOEF1yYw8j
	 MVOJkffYEwXskIl2wRo4HNWKiX28S6iK67OU3pbdyQmaYFCNoAsfcT6Gukno2d6DD+
	 q+Bi0uycs8v0cmQBLWIZk61fQcpVr3JR1HYH0Bcipy6xvL5HZEK8CJrYfDpbzM06sz
	 aQZv2iVX9b/Ar7H+DPuzjR59f+OClY0tKXaSlgaUwZvndYAOQ1bxHdDpDfFggR9wsA
	 qjxWmyaibMr9A==
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
Subject: [PATCH 12/37] iio: humidity: hdc2010: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:52 +0100
Message-ID: <20250331121317.1694135-13-jic23@kernel.org>
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
Cc: Eugene Zaikonnikov <ez@norphonic.com>
---
 drivers/iio/humidity/hdc2010.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc2010.c
index f5867659e00f..894a8b4ab193 100644
--- a/drivers/iio/humidity/hdc2010.c
+++ b/drivers/iio/humidity/hdc2010.c
@@ -169,13 +169,12 @@ static int hdc2010_read_raw(struct iio_dev *indio_dev,
 			*val = hdc2010_get_heater_status(data);
 			return IIO_VAL_INT;
 		}
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		mutex_lock(&data->lock);
 		ret = hdc2010_get_prim_measurement_word(data, chan);
 		mutex_unlock(&data->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -184,13 +183,12 @@ static int hdc2010_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PEAK: {
 		int ret;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		mutex_lock(&data->lock);
 		ret = hdc2010_get_peak_measurement_byte(data, chan);
 		mutex_unlock(&data->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		/* Scaling up the value so we can use same offset as RAW */
-- 
2.48.1


