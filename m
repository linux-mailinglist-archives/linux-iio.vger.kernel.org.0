Return-Path: <linux-iio+bounces-17693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33941A7CF1E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A4D7A41DC
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABB17A2E6;
	Sun,  6 Apr 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfoanVXP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D61487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960032; cv=none; b=ChD1nKa45IDRAcusVfmDt4bs+t36kMG1zqPBUcMXd4tPuok7oWTSxKwAfbZzc+6gzVU40nk0NdsPOxZBtsdmWMSLiE4tCm1Hr2UezdGasiX2GXsRCosylGc8NQRxdfvOdzWAlxOXlZZvnjLlHOBY1HgAe8RoXeNApeYQvsoUfgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960032; c=relaxed/simple;
	bh=/7pW/XwveocHbDYzDGr6Y+qEQgCQ2M31wVRjMsYrUW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG01PAJR8wbnVgOlbFD8QLxfTcE2bBe6jMxDBaJYApNVG+i5mbekLYdnRfG2LKudPXFDGV9edqaqtrA9TnRqe27wyz/Mr4vp98YD1jQWUqB7m95YoXM64VzuX9HylFrlic/uDQm4Ykrty7jHeY31nPocpLeRYKQdmDkII+T1fTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfoanVXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF26C4CEE3;
	Sun,  6 Apr 2025 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960032;
	bh=/7pW/XwveocHbDYzDGr6Y+qEQgCQ2M31wVRjMsYrUW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfoanVXPbVFSOA625rvlGzCbidpvTgERhjSDtRhnQoxFugM965A7YiK216fTRO+/F
	 mHuSHRry2JLlHVn+SvYff9cLwSuTIW7g05qUK1YVWD4mRV5eTZ6gZ35+Fvhcs3GZVY
	 iRSxg7mFfqtf6qCUu5pXzC+zryd03Dh6djyif3SEOH+nRUr8rezNe2olSHQLVZhShW
	 0vOX02/S0hLBeKSCktKbuRl33imGC4BfzjJPeuf6nwgLAHchjMwpCVtiNBpj1azFr0
	 d6vcRcZbwE4DiaeVOfz8TsIqIGgX76EJVbUS4/q45dNtZVLGB+WE64kT+TFc5/I6OD
	 jdnR5rcVA7uWA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 05/20] iio: introduced iio_push_to_buffers_with_ts() that takes a data_total_len argument.
Date: Sun,  6 Apr 2025 18:19:46 +0100
Message-ID: <20250406172001.2167607-6-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Check that data_total_len argument against iio_dev->scan_bytes.

The size needs to be at least as big as the scan. It can be larger,
which is typical if only part of fixed sized storage is used due to
a subset of channels being enabled.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
- Rename size to data_total_len to make it clear that it is about
  data but also that it isn't simply the length to be used.
- Added an unlikely marking.
---
 include/linux/iio/buffer.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 3b8d618bb3df..49c5347f35ea 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -45,6 +45,19 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
+static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
+					      void *data, size_t data_total_len,
+					      int64_t timestamp)
+{
+	if (unlikely(data_total_len < indio_dev->scan_bytes)) {
+		dev_err(&indio_dev->dev,
+			"Undersized storage pushed to buffer\n");
+		return -ENOSPC;
+	}
+
+	return iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+}
+
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data, size_t data_sz,
 					  int64_t timestamp);
-- 
2.49.0


