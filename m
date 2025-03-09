Return-Path: <linux-iio+bounces-16604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040EBA585F2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408D3169526
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176341E1DF4;
	Sun,  9 Mar 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReoqAITp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65A1E0E00
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539546; cv=none; b=ekeyfN/OyYc3zSpQc9Na28fHfrO8Dp/E+AeJTg87cgzijcf1FW+TH6QSSnSjtaM2T21irNLifzx45nTHwrFQmPwhRR7pOrm3ei7t6/4gwyas5hyRQDNYf2zjITtDyGDMnOcbZd2uF5vuUV7I0FbrFlLMKh/ML/W1mkgvx3L+BJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539546; c=relaxed/simple;
	bh=pvDTAzgh9oK6PbkuH8h0QyqpizHrElThmPx1HmLFAUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHPQDha4fkZUCZTYLQjmilv51gN7JPqKaSZaz0aQ5z6xzwbdYx+/7jflpkvgCMfbzPoSvJmi0ldmeWIBFXEpYgZqZm/1y64oA6aTOjTkPcZGoglgkF8LOva8x3z+uLnGzPcTluuiGfWvb0Hi238hqRnuZ2fbb8AMmI9sf9CPIts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReoqAITp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035A0C4CEE3;
	Sun,  9 Mar 2025 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539546;
	bh=pvDTAzgh9oK6PbkuH8h0QyqpizHrElThmPx1HmLFAUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReoqAITp6nH4kU37KEcAO6EfbgiXEFhaR52TcPKL/X0+OhX5LamDiZEy+uvaX4SSB
	 ZHoj3AqU3zE42JuZ0XNs2xq8ygn+FmGUZJ2TizmXgd689PPlYyXRW469u2cPBFRcDk
	 cwtX0GULmzVQkuV9eoD380uQhCvlUt1EATha78zJ/woDG0BZ8i4LCnz8jp1DcgU/TM
	 PsqviP2/JZ92UA9r7QWCcoLXdbW/nejxgEc+T9D6G5yiUF3tYYTNwHqM8jeH74IgTN
	 f5rKdIJyZ+kx1DR3ndsS1qb8aCWgrkEiBpzQlJXLugiwLbmjqDBXGHvZXM7MRyecNZ
	 V/i9O4squsb6w==
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 7/8] iio: adc: mxs-lradc: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 16:58:18 +0000
Message-ID: <20250309165819.1346684-8-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309165819.1346684-1-jic23@kernel.org>
References: <20250309165819.1346684-1-jic23@kernel.org>
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


