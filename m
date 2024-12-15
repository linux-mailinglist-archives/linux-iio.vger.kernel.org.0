Return-Path: <linux-iio+bounces-13520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4179F2556
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E92163D75
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95491B87C8;
	Sun, 15 Dec 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSqH/IAy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720A1B81C1
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287410; cv=none; b=j6maxsHlgyE2YFscLF4beGjIDmZeFYZcAD1jib7tm48oTj3hHElKuisRSwd3La57HNeQi3ENVFRhrnW55n97dYwXZo++8eYTs8WvdpUMcjMR5Qg5CppOOGGuXgbUnbqwCPDhDLzGOkHIHX05sV6PSxZatvJ6aNnjNQFyjVq3uYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287410; c=relaxed/simple;
	bh=5PrNw/Y/zmvWCTV4BWaNgwfR6d4W7+Xf24j91EFCgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy+uD+V/g6UTQnNyFXrfukXNcb5xtfanJKBPf1CkhRXkSzudnQH98tPUTe9xlRHzPN/zxfbm2QGyUQkLY8YezDSKcd9augVHVVl1oRJJ92KYOIgVgHCreTDtb/Twz7wZhkr2QFgj7+scGVYOcKz131M2j4MnHGFSkDokGcqZd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSqH/IAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBE4C4CED3;
	Sun, 15 Dec 2024 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287410;
	bh=5PrNw/Y/zmvWCTV4BWaNgwfR6d4W7+Xf24j91EFCgN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSqH/IAyzLdCGglsfRGW4n/2BjeVcKXFz0lNH5IRTi+lD8OjjDH3Yc2UPg+Prp0CB
	 vrBuop5UYGq+XbrCmTRqPMwIOt95XiE+A2UD9Fp0oWkN4dKDSzEHDa/Z1dP3dvfDKc
	 xVDLnjIDqmm7eNuqHbts+DVX1DHC3hVApGMUUfyVwc0yKEuSmlJhVNSHTzEjG9y1fR
	 chaJvm9k+V2YzLtOLeZPrbZCIYlQVI2Ya9TWrSrXZmPnERLS0SMHM1AsjDn4B/mr+W
	 VlFAfV8673PFbbHzXwIjBzUBYPkdLQ8oMj9TbLNmbzdsP1F9wVZ63CkOds/+/UJcPW
	 J5VxaBWtLo/EA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/20] iio: buffer: Make timestamp s64 in iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Dec 2024 18:29:06 +0000
Message-ID: <20241215182912.481706-16-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a bit of a corner case for selecting between the in kernel types
and standard c integer types we tend to prefer for userspace interfaces.
The interface is entirely within the kernel but in many cases the data
ultimately ends up in userspace (via some time in a kfifo).  On balance
the value passed is almost always an s64, so standardize on that.
Main reason to change this is that it has led to some inconsistency in
the storage type used.  The majority use aligned_s64 rather than
int64_t __aligned(8) and this will ensure there is one obvious choice.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/buffer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 418b1307d3f2..88699a341669 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -35,11 +35,11 @@ int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
  * Returns 0 on success, a negative error code otherwise.
  */
 static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
-	void *data, int64_t timestamp)
+	void *data, s64 timestamp)
 {
 	if (indio_dev->scan_timestamp) {
-		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
-		((int64_t *)data)[ts_offset] = timestamp;
+		size_t ts_offset = indio_dev->scan_bytes / sizeof(s64) - 1;
+		((s64 *)data)[ts_offset] = timestamp;
 	}
 
 	return iio_push_to_buffers(indio_dev, data);
-- 
2.47.1


