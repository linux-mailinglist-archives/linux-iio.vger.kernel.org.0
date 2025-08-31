Return-Path: <linux-iio+bounces-23522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6ABB3D236
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA653BEDE8
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0682475E3;
	Sun, 31 Aug 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heHXcMRz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16F1E502
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637317; cv=none; b=m0Iu7RQkqtgPIIpyyLGiqz4vq5Nv7VwWrvv+KRWywM7KkcFCJsM60AzyyZZTHQhHBugvPSZ/HW2VQRDEOhLTFwB8TgP+0FW64/DHjWlf1OL2fdXsdiJAoOC0KL41fmqgBlDi9td/mxttluFIvJRyJPxn7f7bPXowssiA4RwMeks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637317; c=relaxed/simple;
	bh=iTy1PwLqi+ldL49JLInNlzboMYEwUt5rYbE61LguGvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv+lR/xZ6KL50wSE4qkpCvDdX/M3cw2CscT8rzB+N2FSWKJP1A+29ygRylB1btsR/F3p1CcmOFQ1w5qCA17G9JnU/tEukg7SkVXHQfQnHK7qeYpmy1DgXEW+g3J2LUaYdJrb1rXbe3UDxjNMAfS8ClOJAawCiEJJ/q0yBZYWBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heHXcMRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B26C4CEED;
	Sun, 31 Aug 2025 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637316;
	bh=iTy1PwLqi+ldL49JLInNlzboMYEwUt5rYbE61LguGvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heHXcMRzmbRXwGX8GTnCmqTHfBjhQYe0ol8zXgY34QrqE693hDevOUgJT9E5C2CLw
	 j0ZRPn1qnNDm6CviY90HrWhxkFDUtrX8g7JkzL/+qWBHgsyDcExsg71Kho/yCd0z0p
	 TFrDE/i0T6c0xXOuWPbDzWhyTqekl9rn01ZNQQ9VUscu66Z3PLegBYhNanVek7nv6v
	 hKpgVMuCJfRkPmIRaGu2lD1YGCif4JOQR06UC8Y18BhMcFFgEHqLWHTZUb2nxVxeR3
	 UAGqREL3JcQ4phLiY3lqa2ZPWRLGYfksb1cIDt8LEOVXOuyHU9+B+JSi/77kQ1VCle
	 YW4O1FxNxM1gg==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 4/6] iio: Improve iio_read_channel_processed_scale() precision
Date: Sun, 31 Aug 2025 12:48:23 +0200
Message-ID: <20250831104825.15097-5-hansg@kernel.org>
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

Before this change iio_read_channel_processed_scale() always assumes that
channels which advertise IIO_CHAN_INFO_PROCESSED capability return
IIO_VAL_INT on success.

Ignoring any fractional values from drivers which return
IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
might become non fractional after scaling so these should be taken into
account for better precision.

Use the new iio_multiply_value() helper to do proper scaling taking
the fractionional values into account.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v5:
- Introduce pval + pval2 local variables for better readability

Changes in v4:
- Use the new iio_multiply_value() helper
---
 drivers/iio/inkern.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 158d54de14a7..1e5eb5a41271 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -726,20 +726,19 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 				     unsigned int scale)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
+	int ret, pval, pval2;
 
 	guard(mutex)(&iio_dev_opaque->info_exist_lock);
 	if (!chan->indio_dev->info)
 		return -ENODEV;
 
 	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
-		ret = iio_channel_read(chan, val, NULL,
+		ret = iio_channel_read(chan, &pval, &pval2,
 				       IIO_CHAN_INFO_PROCESSED);
 		if (ret < 0)
 			return ret;
-		*val *= scale;
 
-		return ret;
+		return iio_multiply_value(val, scale, ret, pval, pval2);
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-- 
2.51.0


