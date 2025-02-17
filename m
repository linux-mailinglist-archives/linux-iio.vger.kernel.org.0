Return-Path: <linux-iio+bounces-15686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE7A38619
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A9A17594A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7721B1BC;
	Mon, 17 Feb 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyGgHvEN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EF2253EA
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801887; cv=none; b=W0gCRAn/CVG4YV2m2FHSoHTYxQq1WbjOnNyvvGLmoh8cEb1KwvbX0EPnhmPh/ODQxyQkNp0vbjZhp6z5CYIen5ZZnZdVZcFaKHV64ccG8UgODh6jWQYV53uDKLBkmJljnpYrZ49r1h4iPfg/ZWXwLp953mA6DVJIlweiCUGVaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801887; c=relaxed/simple;
	bh=C/HQQyOzuOQLBbRNHNdTKQbUq2bADVZRuKhUYAro1bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIOUMV8/V90WPfAs/3k90fJyOW8PvQKFjmshWTup4/TvJdulkkvmOwG827rbOOOgp/LPziyTbpFgUD+yQvLDrA8iaEEwCxB3AOeg5mJ7bS2VreqtHqwi6cofaF0a9O6L+YPK7NflMqohKP7rAIM5clDsMG72L2jHYfwe1jAyJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyGgHvEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF85C4CEE4;
	Mon, 17 Feb 2025 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801887;
	bh=C/HQQyOzuOQLBbRNHNdTKQbUq2bADVZRuKhUYAro1bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyGgHvENVy8m0vYJGnUM7Z2gM2FgMVaftD6v0zJAi20yDnCiwxRpBw9vqloHcbpDP
	 rw1cHAceit1wreafj6hW3JgdzbiEhv9R+OTbwTAdrMPSk3OIICWUwEO+7MTlIZd3OL
	 DOeefXY/hL8bDxjB2ttZdl/EdiNdjZFZ73rO9Gse+ng6AXHliP1FHVsQs7tbB00rwo
	 iAhK7O7b9e5eXNcWRTWGJQHYW+JVyBzbTq/e1cg5wVsi65CkpYy6eQZdJq2AtUYmIL
	 Y0e/9hvO4AUwqwOiAvfoziA3GO3GkCTnRBwTgZLFkUjhLDizHXYbKRUXFlKKp8Wfuh
	 qLsYS9BQULFOA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/29] iio: adc: ad7606: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:14 +0000
Message-ID: <20250217141630.897334-15-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

This driver got partly converted during removal of the _scoped form.
However some more cases got added in parallel.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 87908cc51e48..f566248db70a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -862,11 +862,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		val = (val * MICRO) + val2;
 		i = find_closest(val, scale_avail_uv, cs->num_scales);
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		cs->range = i;
@@ -878,11 +877,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = st->write_os(indio_dev, i);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		st->oversampling = st->oversampling_avail[i];
-- 
2.48.1


