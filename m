Return-Path: <linux-iio+bounces-25877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC30C31E12
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9FD74F6EA3
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699132C93A;
	Tue,  4 Nov 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJkaig2C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3C2D2489;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=LTdItDad9qFMcV+x5yFIQFYs4L6Bzc1zOUBVP25nm9vKoUm172i2bY8iYbuoDp5x2VPn/NJ+whVq8LVlLH13MXXukL+Pt45VFzIVqth/oFZRGlW7rCz8c44zjmgQTYnqQuRhpyU+uMfjOUBz6uKVU1nMq5xnvvTA+8PguPD6YIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=KeKjYaBmXa/U7r84E4dAmA1b9Xcnv21bC3C+eO+U4Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8wS7lXnWqMwkJuFzjmPCSD8B/zFr3eyC2oPwnQsYAQEn/yiQI8Xjq47PD6vqNcEvPih1/C4M5fKM86ssW67upLu0tP63iCoAT5tBny5Mo2o1OgKzeBDHxMGBxixKPVPSpSuvYCcc61Xo5WZ++aFfuLUN8GANIGJhyqDP9dJPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJkaig2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6169DC2BCB2;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=KeKjYaBmXa/U7r84E4dAmA1b9Xcnv21bC3C+eO+U4Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MJkaig2CNs1tXVUj1wrzhGmUpga8fBRlUT4yQQ5Rln6stHpRXl8nM0DtbgY77E+Yj
	 C1qc4l8gkOy+RK+DmHxwKIS43ODCoWOZupzzT76CQNtZ0fj28gl3Eh7B3BSk1HhgRW
	 MygOUSvYBbZ0D9B9sKJ48dUU0aPZf5fj2UQpbBNwZjuhLR4VXxKyTvQoPPkfLPon21
	 hnw0UrRNtYU33b5+QfVewEnrMEMbfRiNi6YMQi/Rjnxy5N4pEv8B20QkmD+ag3PUG9
	 LqIlBHOwz308n6Njd8hRpr005+/QU+aphjELNJZLCYHctIjbsFXH9PxkhqY8uwzeXB
	 +F+ymM37+0Rrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4B4CCFA04;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:14 +0000
Subject: [PATCH v4 09/12] iio: dac: ad5446: Make use of the cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-9-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=2674;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=P6Q56RZLd4vphT9+7rmQ2/k6u0FMBB1x8oEsC8XLutE=;
 b=f22ZGkjQO8NVFBqBN0ycu/YMKvP9ulzJd0EKiMKVdz5wg1v9p9IrkVDnpLc8fcaISULlSGxZb
 HkTq4LG1sOdCgKBxRgrZ9Y/swp6x6B6/sKwbBCbFRZgdswX8WZTMhdf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use the auto unlocking helpers from cleanup.h. Allows for some code
simplification.

While at it, don't use the ternary operator in
ad5446_write_dac_powerdown() and add an helper function to write the DAC
code. The reason for the function was purely to avoid having to use
unreachable().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 59e1f67ef334..1943e8014990 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -5,6 +5,7 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
@@ -80,7 +81,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	st->pwr_down = powerdown;
 
 	if (st->pwr_down) {
@@ -91,9 +92,10 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	}
 
 	ret = st->chip_info->write(st, val);
-	mutex_unlock(&st->lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : len;
+	return len;
 }
 
 const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
@@ -129,32 +131,37 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad5446_write_dac_raw(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				int val)
+{
+	struct ad5446_state *st = iio_priv(indio_dev);
+
+	if (val >= (1 << chan->scan_type.realbits) || val < 0)
+		return -EINVAL;
+
+	val <<= chan->scan_type.shift;
+	guard(mutex)(&st->lock);
+
+	st->cached_val = val;
+	if (st->pwr_down)
+		return 0;
+
+	return st->chip_info->write(st, val);
+}
+
 static int ad5446_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
 			       int val2,
 			       long mask)
 {
-	struct ad5446_state *st = iio_priv(indio_dev);
-	int ret = 0;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val >= (1 << chan->scan_type.realbits) || val < 0)
-			return -EINVAL;
-
-		val <<= chan->scan_type.shift;
-		mutex_lock(&st->lock);
-		st->cached_val = val;
-		if (!st->pwr_down)
-			ret = st->chip_info->write(st, val);
-		mutex_unlock(&st->lock);
-		break;
+		return ad5446_write_dac_raw(indio_dev, chan, val);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info ad5446_info = {

-- 
2.51.0



