Return-Path: <linux-iio+bounces-15700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682BA3864C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CABF3BB362
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4BE21D5AA;
	Mon, 17 Feb 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXWFLCBO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55A22257F
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801963; cv=none; b=XPWkuSNJB1916D8wWGhrK1LOITVJcR+ybPGP1D/Hbca3/BOqPeTXX3Ft6WpFD5jPIXskpnGAE5FFoxrz2+zUa/4p7hpR3Dk337G6ldlkXR/kJuq7VdTYBtOm/sgTSym/IdwfsFm0q/guadqPq7FLgS7XTgCXEQRE7mX1Vm2OFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801963; c=relaxed/simple;
	bh=pvDTAzgh9oK6PbkuH8h0QyqpizHrElThmPx1HmLFAUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OW3umraokFx4aDCK/REYMMe3uK/G4Kdixv1Xb8mEmU5wVHarXsabyOd/ZfVSSX2naGDz8LOFY2jiSYJiBipkySBEz8xj96FgK9CXoW6ywVmFSFAmoZcPJk2ULqmCHyIsdKd/bDH/ckjUm9WyAn8mk+0X5LKhsfqGioU0xy0YDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXWFLCBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048B1C4CED1;
	Mon, 17 Feb 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801963;
	bh=pvDTAzgh9oK6PbkuH8h0QyqpizHrElThmPx1HmLFAUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXWFLCBOTlRifp3qEPGyW8rcTbfK16EUnAZ4HHsybCMGrMlY10n7/SOTwA25/dr4k
	 a30S7aHvNn2hS3+8icEGtl4U1gmmNAvoGkO64yUEWU/yTEzDaL+rxi4nL7+iIaJC1t
	 G5FsuqEMtkGz+fFJddcOs9wTEoWomlOLtHVhrYMM6tR4GW7/odRcDfgXmoRzTtl1LD
	 AiAO6R2BUB6LRaFmZCrLq5mP8NSPIyjGD6rv6cSwb4BYPS2uGc122a4v3f6eXL+CJ9
	 Y4M5tK6G1lcLEmwX4vvfQuL8SvY6p3+Y4G0k+ufHXfReZTb/DpfJ7NlSaHJ6T+wp7E
	 y/s+9ADs9Z6ZA==
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
Subject: [PATCH 27/29] iio: adc: mxs-lradc: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:27 +0000
Message-ID: <20250217141630.897334-28-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/mxs-lradc-adc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 152cbe265e1a..8f1e6acea53b 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -141,9 +141,8 @@ static int mxs_lradc_adc_read_single(struct iio_dev *iio_dev, int chan,
 	 * the same time, yet the code becomes horribly complicated. Therefore I
 	 * applied KISS principle here.
 	 */
-	ret = iio_device_claim_direct_mode(iio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
 
 	reinit_completion(&adc->completion);
 
@@ -192,7 +191,7 @@ static int mxs_lradc_adc_read_single(struct iio_dev *iio_dev, int chan,
 	writel(LRADC_CTRL1_LRADC_IRQ_EN(0),
 	       adc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
-	iio_device_release_direct_mode(iio_dev);
+	iio_device_release_direct(iio_dev);
 
 	return ret;
 }
@@ -275,9 +274,8 @@ static int mxs_lradc_adc_write_raw(struct iio_dev *iio_dev,
 			adc->scale_avail[chan->channel];
 	int ret;
 
-	ret = iio_device_claim_direct_mode(iio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
@@ -300,7 +298,7 @@ static int mxs_lradc_adc_write_raw(struct iio_dev *iio_dev,
 		break;
 	}
 
-	iio_device_release_direct_mode(iio_dev);
+	iio_device_release_direct(iio_dev);
 
 	return ret;
 }
-- 
2.48.1


