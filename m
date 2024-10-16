Return-Path: <linux-iio+bounces-10661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9129A0C81
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E6B1C20992
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B520C00B;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXBBDQ/V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DF1CB53F
	for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088522; cv=none; b=DGQv720A5g3C1YJLWXLF84CJJpQHtTKqN4Jl/l4miCdcEEMqZMlPmKWhCASl3GSRz5Ea2A3XLC/SoMOcfDo1TUUIIvLTMIIlvvkBYepTedQDR9LovTQQ2xyaCRTiLCjhuzYmUuZbiUp5Udur+QK3s9qw4I3+3XAHQHph6PQVB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088522; c=relaxed/simple;
	bh=5tjys1NEMsVNx4ISbn6ac1Z508d9HMzIneaQfGNdFWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGEaO9SR96bjbO1LwEqq5+5MK1gsIqmNqx9GAIdXe6NdcRiloWEtQwMqV1PoxBfkiEbMIra2SeO2y5U8OGEN2+jZ75COuLBrtL+MHmp0j6puXvbTO7tdZ5ZYVb+XgbWnkwj2D4d8BHY5OZKMQ4kbHgRSjcBCHUAmBNzwCdxwUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXBBDQ/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B998C4CED1;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088522;
	bh=5tjys1NEMsVNx4ISbn6ac1Z508d9HMzIneaQfGNdFWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MXBBDQ/VZCizlrW4bxaN3a5G3vnuGWKkwSya88XiBPUTRuAeTvAMRZxSkNZ2YwxZ9
	 cjDI5L7uX+HnbIvHkW2cTalQ1/HKYX9hWO/Mgqi9YRfJW2gb2EAVe1PjAHYlH9DXfy
	 ZFdHLeFfwcITS80lDc8n6EuUQVvYyh7Z2ZIkJlTTnOuxPvqS7xUTA+VBbqBbse+C7+
	 GPl/XXZ6AQN/1vccMp7ZartBgRXJMeNNrEsG3814yDEkRJd6ZfcvK95MHoTVyBqTRS
	 YntNg+IsU01ZS7hZWKNU1HuKTJCDIdEztOWkuPvjqr6E32QjiVKoGNRlZpp+vfW7ud
	 4/UDPYFA0MCsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C4DD206BC;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 16 Oct 2024 16:22:01 +0200
Subject: [PATCH 3/3] iio: addac: ad74413r: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-dev-ad74413r-minor-improv-v1-3-13c9c769237d@analog.com>
References: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
In-Reply-To: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
To: linux-iio@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729088521; l=3081;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=fSsvW/amVn55Zii+damJ6Q75Aec5l4o8BgF4z/jzw4k=;
 b=rT8vdmqfQoH1Cf9MlwNFOiXKSZlPayhyO2TcM1OmRJpYfVtawRSGu5vntKSAxpramZfNuPyL1
 0EfIwKzS+FxAcBx4CC5ejw6LXUbky+nZ7R6bXLUG/IAsT0HSC5rbBU1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make use of mutex guard() and IIO iio_device_claim_direct_scoped() to
simplify code and error handling.

While at it, use devm_mutex_init() to initialize the mutex.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/addac/ad74413r.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index cfe26a394465..daea2bde7acf 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -6,6 +6,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -864,19 +865,12 @@ static int ad74413r_get_single_adc_result(struct iio_dev *indio_dev,
 					  unsigned int channel, int *val)
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
-	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
-	ret = _ad74413r_get_single_adc_result(st, channel, val);
-	mutex_unlock(&st->lock);
-
-	iio_device_release_direct_mode(indio_dev);
-
-	return ret;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		guard(mutex)(&st->lock);
+		return _ad74413r_get_single_adc_result(st, channel, val);
+	}
+	unreachable();
 }
 
 static void ad74413r_adc_to_resistance_result(int adc_result, int *val)
@@ -898,7 +892,7 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 	unsigned int channel;
 	int ret = -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	spi_message_init(&st->adc_samples_msg);
 	st->adc_active_channels = 0;
@@ -906,11 +900,11 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 	for_each_clear_bit(channel, active_scan_mask, AD74413R_CHANNEL_MAX) {
 		ret = ad74413r_set_adc_channel_enable(st, channel, false);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (*active_scan_mask == 0)
-		goto out;
+		return ret;
 
 	/*
 	 * The read select register is used to select which register's value
@@ -928,7 +922,7 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 	for_each_set_bit(channel, active_scan_mask, AD74413R_CHANNEL_MAX) {
 		ret = ad74413r_set_adc_channel_enable(st, channel, true);
 		if (ret)
-			goto out;
+			return ret;
 
 		st->adc_active_channels++;
 
@@ -959,11 +953,7 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 	xfer->cs_change = 0;
 
 	spi_message_add_tail(xfer, &st->adc_samples_msg);
-
-out:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static int ad74413r_buffer_postenable(struct iio_dev *indio_dev)
@@ -1368,7 +1358,10 @@ static int ad74413r_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return -EINVAL;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(st->dev, &st->lock);
+	if (ret)
+		return ret;
+
 	init_completion(&st->adc_data_completion);
 
 	st->regmap = devm_regmap_init(st->dev, NULL, st,

-- 
2.46.1



