Return-Path: <linux-iio+bounces-17464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EBA7659F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031961889893
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694621E51EF;
	Mon, 31 Mar 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeiMFdPt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD713B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423430; cv=none; b=Gk+8dke6HovXK+cQR9+Wf7sAhpeblb2QIPHFtuf9ue7Z2GjKM29pzRSxTAIPz3xthDNpqBpXU5fbuHcFMSuuA7sVIWiiFPnA2KV0yYo3Sv+K2/loDTvWWOf5xil6q0aSsZ6dHD16QZq91Q8HMiyWvfZp3/546ib0oUM5OURm5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423430; c=relaxed/simple;
	bh=xblcPfOMh6aAs8TN16Jsn6pxnoWcn5GCCb3XLYu3Bsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M25WPhOz2lPS0EdwZbfJvSUS5/V/EDXLy7b5CvZ/vBnxHD27ySSWo9LLyDPqRsSWWrborwNzeJKoKhEjvUF61ADU8s9bHZyUH8qRcGEutBYxnAQWTbhEQ1GqA5/tJD5iZ4yg5WieJIqC9nKcb/v1rCa7woRbnwObvD2oBnGC13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeiMFdPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F95C4CEE3;
	Mon, 31 Mar 2025 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423429;
	bh=xblcPfOMh6aAs8TN16Jsn6pxnoWcn5GCCb3XLYu3Bsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeiMFdPtcgUBM8DGK17oYRvA2RW/3hxkClHoVJZ2f3FmvUet3kkkUDHoNE9p9SZoO
	 KsARWnvwCcPbDYjZGMPDTYgtrw3o/58A8JixWhifEcVy6GqmQlxZLnv67KiGVPHgD4
	 msk4Ie4iOYDFNw6QgtiZMdTqeVS427ZSrieqxL/NC8y4tzPlL5UKO4Rw0mKOvuA4qq
	 9esVAS6w1b0zS0c5PRJGMdk1nHJ59T4E0RfyzIKasqgVRgiXQ/W+jLgfC8MMjQKNRT
	 lSQ+QfgmrOk0SAPh8kZ2Ff95CVFm/+lnSITcuSWjKlo6T8zElHot6NvXkjvpa7UUB5
	 l/oUFCBJYC6kA==
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
Subject: [PATCH 34/37] iio: temp: maxim_thermocouple: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:14 +0100
Message-ID: <20250331121317.1694135-35-jic23@kernel.org>
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

Tidy up a few direct returns whilst here.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 29 ++++++++------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index c28a7a6dea5f..a1c213d5c469 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -183,40 +183,35 @@ static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
 				       int *val, int *val2, long mask)
 {
 	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = maxim_thermocouple_read(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (!ret)
-			return IIO_VAL_INT;
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
 
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel2) {
 		case IIO_MOD_TEMP_AMBIENT:
 			*val = 62;
 			*val2 = 500000; /* 1000 * 0.0625 */
-			ret = IIO_VAL_INT_PLUS_MICRO;
-			break;
+			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			*val = 250; /* 1000 * 0.25 */
-			ret = IIO_VAL_INT;
+			return IIO_VAL_INT;
 		}
-		break;
 	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
 		*val = data->tc_type;
-		ret = IIO_VAL_CHAR;
-		break;
+		return IIO_VAL_CHAR;
+	default:
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info maxim_thermocouple_info = {
-- 
2.48.1


