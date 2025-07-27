Return-Path: <linux-iio+bounces-22077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410BAB131F4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79857176CDC
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FBF232368;
	Sun, 27 Jul 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/pmoCi7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59D155326
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650410; cv=none; b=XFz8jr/jvZa48S1WcponpxOdNmUVAa/Fb9UH9TCFS0DbUbXi0BQmKbuDHrExJF64OZASiI7SrPVffYEtlzhgXT07ENM+RMrRn6NsBNSjR6Ju7PDuGcCtB1xztIuV4NDSYvgp5JdwWFLi4TpnSrJ1VLdLz6XOr5E5CLXfA+hojrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650410; c=relaxed/simple;
	bh=aKB+dHHxOGmnbw6mlYRvcKnm7sSTei0qXryXjN/sKYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRKrdVLm0toqjaIEi6Shqj25eanOEiO+xjx/+YZu9LRs0dDt3NUDT8zq7jXvHWreBVcxoMHILtMB/jlD0Y97ShQUEwbk8VJ1rCVq8QDRJAJNEnuLX5mOMEfAqVH/37zL2j95udS1F8ygsmdSZx2noDR97dtZXKe/vxoZnWJYDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/pmoCi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7998AC4CEF7;
	Sun, 27 Jul 2025 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753650409;
	bh=aKB+dHHxOGmnbw6mlYRvcKnm7sSTei0qXryXjN/sKYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/pmoCi7PtexsWca1piRwoEQzMaSsbpfxX0AX5Jl2YMd6Ttg2+7bB2cILjlIxpnII
	 jGBosa9M4Vhp2qxi4tDJGo6h0Bh8a/Jh63fQAnrrsJ2etnVaxLjGly7r1+M8xB35VC
	 TzA7Q5+bCb4xAIDcz4dHPqCqS2lNk4Ugoc7CR5dFH20t1d66OIkhMNNL0PnYeuMSsk
	 pOmE9ahqdfwTFl2SjjP4dkCRCCTzBG+eO/7qFyS9qVOcjv3mE/d7Hush7T7jmXVAHD
	 pyJQIlYTSBOG4XJmUSLsKe+uXveif7m683qIRHdmXKrTrd7VHaBMVuoK0/8dVF1PJ2
	 1jUyLR6VUYfEQ==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] iio: Improve iio_read_channel_processed_scale() precision
Date: Sun, 27 Jul 2025 23:06:38 +0200
Message-ID: <20250727210639.196351-2-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250727210639.196351-1-hansg@kernel.org>
References: <20250727210639.196351-1-hansg@kernel.org>
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
account.

While at it also error out for IIO_VAL_* values which
iio_read_channel_processed_scale() does not know how to handle.

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v3:
- Use div_s64() instead of div_u64() to fix -1.0 - 0.0 range
- Directly return IIO_VAL_INT from valid cases and drop the final
  return ret after the switch-case

Changes in v2:
- New patch in v2 of this patch-series
---
 drivers/iio/inkern.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c174ebb7d5e6..46900be16ff8 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -714,20 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 				     unsigned int scale)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
-	int ret;
+	int ret, val2;
 
 	guard(mutex)(&iio_dev_opaque->info_exist_lock);
 	if (!chan->indio_dev->info)
 		return -ENODEV;
 
 	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
-		ret = iio_channel_read(chan, val, NULL,
+		ret = iio_channel_read(chan, val, &val2,
 				       IIO_CHAN_INFO_PROCESSED);
 		if (ret < 0)
 			return ret;
-		*val *= scale;
 
-		return ret;
+		switch (ret) {
+		case IIO_VAL_INT:
+			*val *= scale;
+			return IIO_VAL_INT;
+		case IIO_VAL_INT_PLUS_MICRO:
+			*val *= scale;
+			*val += div_s64((s64)val2 * scale, 1000000LL);
+			return IIO_VAL_INT;
+		case IIO_VAL_INT_PLUS_NANO:
+			*val *= scale;
+			*val += div_s64((s64)val2 * scale, 1000000000LL);
+			return IIO_VAL_INT;
+		default:
+			dev_err_once(&chan->indio_dev->dev,
+				     "unsupported processed IIO-val-type: %d\n",
+				     ret);
+			return -EINVAL;
+		}
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-- 
2.49.0


