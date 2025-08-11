Return-Path: <linux-iio+bounces-22583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE5B210DB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C14C7B883C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06951CAA7D;
	Mon, 11 Aug 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB6Eck2K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D41A9F84
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927704; cv=none; b=fsj5f6U0AcLjTDvhukIkspXHptN3P6NTThfCi650qevi20+RZPf0rq1CFDpFg3chPVsW9ZyU1GmKwsR4DUcvN7aWYE1lWOV/JeAQW2+ha7X6L3c+Ss+pGMPgTw+UdyiVDlilIx4aNGfjjUihbDZWZJK8I8/UHh4PNvadGYRLrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927704; c=relaxed/simple;
	bh=gIW+xRryWwHSnRYNFk0fTX6prP6IPPNwKM+JOs0DOo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1Na6iMFAZr8+zBU4DCrnYNQL04+TMdKyOtMf+CRR9Nq6JqZmmJcXYmv1H05MSA1pwdPe2tU77PT4Ey1marWhTpdiGQhiidx2qXB/HrJzknDXQG4pjOuxFlUEGpnmHv2XI91KlBrGE/N1YsBl0tb5xNZOyuHpLdSmwznczae3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB6Eck2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D07C4CEF7;
	Mon, 11 Aug 2025 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927704;
	bh=gIW+xRryWwHSnRYNFk0fTX6prP6IPPNwKM+JOs0DOo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GB6Eck2K5KPcibBToxQY3uIkSDXwZvnl6Sj42Xj6KZX5Gn9f4Npk4IGNd+IyeJGne
	 BUgcdyno2Q4oPS87zfOnExGCS1fqRbVC3G/ZIE5B0GaBG3rHLWM9CBQdVOFewixM/W
	 HhV31XjuSbjtJvGMniHSgXlAcsMOitcLHWJflcBcLDkw6qhjzfufCnGBMvE3d4m3Sa
	 htwA3hF4HuAM2ZQoyPJ1o22w/xNh5tuXmsjLJVWlmlqGcb0/3v/iLEuG+wUtGm+1l5
	 /Z/OSkQ1//ifmDzDHQRYqLB+x0dO/037yixsXIKk3I2LMQ9hLyBx93PtKgIO4cRDte
	 E0jDT0FH4oqPQ==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 1/6] iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()
Date: Mon, 11 Aug 2025 17:54:48 +0200
Message-ID: <20250811155453.31525-2-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811155453.31525-1-hansg@kernel.org>
References: <20250811155453.31525-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an issue with the handling of negative channel scales
in iio_convert_raw_to_processed_unlocked() when the channel-scale
is of the IIO_VAL_INT_PLUS_[MICRO|NANO] type:

Things work for channel-scale values > -1.0 and < 0.0 because of
the use of signed values in:

	*processed += div_s64(raw64 * (s64)scale_val2 * scale, 1000000LL);

Things will break however for scale values < -1.0. Lets for example say
that raw = 2, (caller-provided)scale = 10 and (channel)scale_val = -1.5.

The result should then be 2 * 10 * -1.5 = -30.

channel-scale = -1.5 means scale_val = -1 and scale_val2 = 500000,
now lets see what gets stored in processed:

1. *processed = raw64 * scale_val * scale;
2. *processed += raw64 * scale_val2 * scale / 1000000LL;

1. Sets processed to 2 * -1 * 10 = -20
2. Adds 2 * 500000 * 10 / 1000000 = 10 to processed

And the end result is processed = -20 + 10 = -10, which is not correct.

Fix this by always using the abs value of both scale_val and scale_val2
and if either is negative multiply the end-result by -1.

Note there seems to be an unwritten rule about negative
IIO_VAL_INT_PLUS_[MICRO|NANO] values that:

i.   values > -1.0 and < 0.0 are written as val=0 val2=-xxx
ii.  values <= -1.0 are written as val=-xxx val2=xxx

But iio_format_value() will also correctly display a third option:

iii. values <= -1.0 written as val=-xxx val2=-xxx

Since iio_format_value() uses abs(val) when val2 < 0.

This fix also makes iio_convert_raw_to_processed() properly handle
channel-scales using this third option.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Cc: Matteo Martelli <matteomartelli3@gmail.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/inkern.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c174ebb7d5e6..508534f96962 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
@@ -604,7 +605,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 {
 	int scale_type, scale_val, scale_val2;
 	int offset_type, offset_val, offset_val2;
-	s64 raw64 = raw;
+	s64 denominator, raw64 = raw;
 
 	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
 				       IIO_CHAN_INFO_OFFSET);
@@ -648,20 +649,15 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
-		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val * scale;
-		else
-			*processed = raw64 * scale_val * scale;
-		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
-				      1000000LL);
-		break;
 	case IIO_VAL_INT_PLUS_NANO:
-		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val * scale;
-		else
-			*processed = raw64 * scale_val * scale;
-		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
-				      1000000000LL);
+		switch (scale_type) {
+		case IIO_VAL_INT_PLUS_MICRO: denominator = MICRO; break;
+		case IIO_VAL_INT_PLUS_NANO: denominator = NANO; break;
+		}
+		*processed = raw64 * scale * abs(scale_val);
+		*processed += div_s64(raw64 * scale * abs(scale_val2), denominator);
+		if (scale_val < 0 || scale_val2 < 0)
+			*processed *= -1;
 		break;
 	case IIO_VAL_FRACTIONAL:
 		*processed = div_s64(raw64 * (s64)scale_val * scale,
-- 
2.49.0


