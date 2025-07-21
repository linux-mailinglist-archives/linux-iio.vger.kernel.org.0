Return-Path: <linux-iio+bounces-21832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD3FB0C73F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D228B169879
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F31F2B88;
	Mon, 21 Jul 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqbwKzYJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224872617
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110388; cv=none; b=CeHHtjGiXHnB/Qoy5cMWVBREADp6Y9nbF/uH9qZCLE1g8p7pPGSb45ibEDWatqx58Zk4bGh2hToLv3395lEENe9YT/gbaH+jgFSawxvlL9xveC+NDHdspoGzN6CAS9bQHq2nSaHFygP6GADYC0qMC4QjY594p+4ZrS+h7/J8s+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110388; c=relaxed/simple;
	bh=rWwvfgY6xKfAMq1OTGuMmeZTeIu7lezWF3Sms5veOlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrG11/G9qfonSj2DpyYgSaKc43apvJXZrwTDCeTeSESORAJ2rU4kvN80eA8bAYoAP2TRVPzb+hYNJ/RlRdoaGufas2Aq6skCTsPIMXnOnSW8p02E4RtX2DZ8628VBMJ1yZaqi2OhjlyJIsyUPtIir1XKm9oJhkz64ySrCljRews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqbwKzYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E84C4CEF4;
	Mon, 21 Jul 2025 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753110387;
	bh=rWwvfgY6xKfAMq1OTGuMmeZTeIu7lezWF3Sms5veOlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqbwKzYJa3ip99zyt0jSAzzrJJxYgzSX78X38C+8CTwdJVTBoI+U7avRoAhz3izlG
	 //n+g88x9RRoo2gL4xBUHIRRP+NNqLSixiu0Ro9WvCJlSyUh2Q3q0dHkdSD3YZt9Ac
	 xkR4MbfXZQ/tMmVi/lrxNd7kjfTUwTUcJ7UBYGWkcnl7WnMXAXwBai16c9UYpN6yFv
	 xYCyF1ApR3ytk3iXUF4AxzuRCK9zeTpqoL08b85NPAXDKr/WVkn+FFcgyqQWj+aVe4
	 bSpRrfQHITaKcL+GSMn/rfa4LmNCWEIz6QgSgJWop+GvyRrvHVblACy+TgTunAyyRb
	 XLerCE5vYgoOw==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] iio: Improve iio_read_channel_processed_scale() precision
Date: Mon, 21 Jul 2025 17:06:13 +0200
Message-ID: <20250721150614.51918-2-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721150614.51918-1-hansg@kernel.org>
References: <20250721150614.51918-1-hansg@kernel.org>
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
Changes in v2:
- New patch in v3 of this patch-series
---
 drivers/iio/inkern.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c174ebb7d5e6..e9669f552eb3 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -714,18 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
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
+
+		switch (ret) {
+		case IIO_VAL_INT:
+			*val *= scale;
+			break;
+		case IIO_VAL_INT_PLUS_MICRO:
+			*val *= scale;
+			*val += div_u64((u64)val2 * scale, 1000000LLU);
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			*val *= scale;
+			*val += div_u64((u64)val2 * scale, 1000000000LLU);
+			break;
+		default:
+			dev_err_once(&chan->indio_dev->dev,
+				     "unsupported processed IIO-val-type: %d\n",
+				     ret);
+			return -EINVAL;
+		}
 
 		return ret;
 	} else {
-- 
2.49.0


