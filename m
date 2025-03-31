Return-Path: <linux-iio+bounces-17452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50954A7658F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6D18891E5
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B11E47A5;
	Mon, 31 Mar 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEpSffGT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5913B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423353; cv=none; b=QB4tZ8ooHuW7Ff2dYAQxrdDXp2Vwzx1YYtfMFIsqexoKXc3D4EsMkRQ34AgcS8LxSC7MvhCuuY3Gx2vhP6WBxd9RZ60+KonlA/yvISkKZRmKqzcayoEM+62bxCl/1CPcgbhc1BK+h8uqS2gD2PXj4xnIS89AqadXhOIBnzH9MaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423353; c=relaxed/simple;
	bh=wWP4OSLDet9MTXy562O5het7Nk518Oxk5Zy2gCcxGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyF0pheATNf4Q2V0Qy3eTpStARYiOx7uf5ux24pWx0sD1ccKLp4/tZsACQMkPsvGwnRw1XPJvBGZB9vg8Qgx90nbi6BpmpnnDYOgJG4QLEiZ9Vnk+BjKW+KjtLFvLTJvXCeyexRgB3inZpTNq4lWgpzmhw+haOfpJPoTGecGiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEpSffGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D08AC4CEE3;
	Mon, 31 Mar 2025 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423353;
	bh=wWP4OSLDet9MTXy562O5het7Nk518Oxk5Zy2gCcxGfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEpSffGTNQwgeiDrguQrPhHABBu57Fd/BZRXe1hVu5tgvtISE5qOrQoSOWs4d2g8R
	 rK2yFtkAeR5xHCCM8Cpu8pPAL1ZJqWuvUIQd4pv87+iJwsSeNc5ynSNQKRJhm4hfrn
	 TiK/hRSKxqF6gDCXN19v2uebUWc8sp4kCuUvKRsZ9EZ3hRWrEAcOi31Vg8zzzXrYLI
	 RtaWRIi7j8HkseeIgq4S2wsy4W3C40DugYzY7kuX6UXCD9DbWQQi+eDAIZW4Cp5jOT
	 /TXX6r2L3fu9Ehr2i1erbLIO+ISvOEACjWHdc01oXug6prsPd6bppOoMTPy9CXjXkD
	 K332MY33w3VQA==
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
Subject: [PATCH 22/37] iio: magnetometer: mag3110: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:02 +0100
Message-ID: <20250331121317.1694135-23-jic23@kernel.org>
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
 drivers/iio/magnetometer/mag3110.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index b633bdf793ed..92d4511ed372 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -303,11 +303,10 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = __mag3110_read_info_raw(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -378,11 +377,10 @@ static int mag3110_write_raw(struct iio_dev *indio_dev,
 	struct mag3110_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 	ret = __mag3110_write_raw(data, chan, val, val2, mask);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
-- 
2.48.1


