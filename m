Return-Path: <linux-iio+bounces-23519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7FB3D233
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE88189E27D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208B248891;
	Sun, 31 Aug 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqKVjEYA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E211E502
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637311; cv=none; b=HBJgCg2MsaX5AqHX9ZYdhPflg+IJMbcS0DaxOWq7Me/qrKAj28Drg1wH7tmNN4RnjQgfEwR6j8ArJw/OUUTVRDmHWsAPxf9oiu69lbq6rGmylQVXW74YJWRjlT6S6RcjPiDl/MJNjYzXiZ2yvAqSvoyhAbqMZVEWK9jvKB8ZR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637311; c=relaxed/simple;
	bh=Mo5WJghxPr3gZX+w1GBDFdqG1uHqIS8YKLCGTwbcifM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKb707fW9vgjgN/jg0W/a5+vkZXN7E9mLVpz9DmfhGmO4Y4PJAA2cM0whdH9Er0+04ehT6fqrFVkbV/C7Wv0Z5xbdJ3lwcmeLtjw7Alkdbb2AhVX7QErnWCLqqne01CNu3oTJZBU5Wf/MnSXbJGEJAdjYiPSpQV1oInkx5lXVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqKVjEYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E5DC4CEF9;
	Sun, 31 Aug 2025 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637311;
	bh=Mo5WJghxPr3gZX+w1GBDFdqG1uHqIS8YKLCGTwbcifM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqKVjEYAFC+w1Q9oDDhGeNQfnNX2ksOCCMr8+Cf+GOjsk+uJ/9KFvMdcNxdV4vtH6
	 KMmjUIvvfGncHcvZDzrvsKfCRFXrwjEezeTWoXk8zpHBwhOEjnP+VKdF6mZhO72mJM
	 LgZ+aDsyppD47wYj4pw92Z+Y7/C8Uqzyu15AHRKN5g8NsSOk+/052J8+fQn4oyT5kN
	 sDGOpvHr7dAaGUKdA4SdWYDwL07IxVoK495eiuJbJVTtg7Y8BPN7/IZ9cUwrgLKC22
	 MhehG1nt2t4WVY3fMUJd47ZZ2DUuKqiLJqCJroE0TRzLaxSdX4zK/wxE/7AWDlGvVj
	 6sFl2g7Wsrgbw==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 1/6] iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()
Date: Sun, 31 Aug 2025 12:48:20 +0200
Message-ID: <20250831104825.15097-2-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831104825.15097-1-hansg@kernel.org>
References: <20250831104825.15097-1-hansg@kernel.org>
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v5:
- Do not put case foo: val = x; break; statements on a single line

Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/inkern.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c174ebb7d5e6..d36a80a7b8a9 100644
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
@@ -648,20 +649,19 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
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
+		case IIO_VAL_INT_PLUS_MICRO:
+			denominator = MICRO;
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			denominator = NANO;
+			break;
+		}
+		*processed = raw64 * scale * abs(scale_val);
+		*processed += div_s64(raw64 * scale * abs(scale_val2), denominator);
+		if (scale_val < 0 || scale_val2 < 0)
+			*processed *= -1;
 		break;
 	case IIO_VAL_FRACTIONAL:
 		*processed = div_s64(raw64 * (s64)scale_val * scale,
-- 
2.51.0


