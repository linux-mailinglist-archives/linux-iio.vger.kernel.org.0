Return-Path: <linux-iio+bounces-26110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB58C44623
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 772FE4E3540
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BCF23AB98;
	Sun,  9 Nov 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8sd8LYq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233122538F;
	Sun,  9 Nov 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716363; cv=none; b=Z8QQFRrsVSIyoIjEU+g2SOccmUc6w2/WjBK79qVEsgCbtGzRG02YsTVKnUCPOWYfqzSxbPrxhUwafVpgHublF3JZV9QkUUzCqgeQdfACwijSAc685syFKWF0gBLZVEgdldom+j8J4w49EogXrpIAFHeG4gQ8S3Z3tgKKcLJ0ywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716363; c=relaxed/simple;
	bh=upaeob8j34GVSsqrAgEGkGc6v0cl/aFwYXGFTvPcMx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=in6hrFdBP8s82EKow0hLIO/V99/+ybEiLQk74psLC77V0s85ynBMOuNTRWQZ4tLVlbnDDqywpFflEdP5cGi0l0S71DjWY6dadI9wDA3ej7SI0GBMose9Tc95vGeR1A9Rj50xWKcitQGUWGlpefSK4FGkdDSne3GILZ+sePCiI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8sd8LYq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762716362; x=1794252362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=upaeob8j34GVSsqrAgEGkGc6v0cl/aFwYXGFTvPcMx0=;
  b=O8sd8LYqTitUaHqoMLA+OMFobvvuIUp4MRPg/dQmzPmWPSREryEouNUx
   QgqKT/ZmXwtTyxmToehIKbeEWesjGfyO7pKDxfPAlWibb/TUg7n1b3Aa2
   REAHKjWzSXg8c7IjB9CDnwy4q89uLzXI6xZgaxxVBq+zaAAw5RMCc6EIP
   Q/nqO6u3HVkoT4QevWwImYHs6adhoISUJMsZbkNnNV61ZMkguteHn7S+j
   B56ci1Sl+vML/UnuLkJ3/j6p32E8GDNcYs5lny5AmdCpUT4DCxHvH86wy
   Ozc7SPuNUphtgpYAC6b2DApJJyRzv1c1uJUXqLAyluTGQCu5+eo8g5CHj
   g==;
X-CSE-ConnectionGUID: +kM10htITjCa8+kwGEYxow==
X-CSE-MsgGUID: GagaVh8rTxqzLR2L694s+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64820684"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="64820684"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 11:26:01 -0800
X-CSE-ConnectionGUID: Ce9IDDcHRdOQGVYneTLvGA==
X-CSE-MsgGUID: NUDF3D6ATfOroRlKtba7Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="188664150"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 09 Nov 2025 11:25:59 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 24BEF95; Sun, 09 Nov 2025 20:25:58 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX integer types
Date: Sun,  9 Nov 2025 20:24:36 +0100
Message-ID: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver code is full of intXX_t and uintXX_t types which is
not the pattern we use in the IIO subsystem. Switch the driver
to use kernel internal types for that. No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Jonathan, what is the status of fixing the type for
iio_push_to_buffers_with_timestamp()? This patch doesn't do that
as I see no API has been fixed (and it seems the only one that uses
the *intXX_t parameter).

 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 54760d8f92a2..9be5ade24501 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1209,7 +1209,7 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
-	const int8_t *temp;
+	const s8 *temp;
 	unsigned int odr;
 	int64_t ts_val;
 	/* buffer is copied to userspace, zeroing it to avoid any data leak */
-- 
2.50.1


