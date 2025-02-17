Return-Path: <linux-iio+bounces-15681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A8A385EB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884BE7A441E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60AC224882;
	Mon, 17 Feb 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KimZJf+B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F421D5BB
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801858; cv=none; b=OOSRBxEGfa3g4+BsmZml1MyI7zNIts2FJDXPVc7Nx8ASS1SCsGRrILEgBM4XcRPi7AuNk8BOhfeSCRedY4gMCXf1GoLyj3/ma0/6KU3ujMPzZjm0snyAcXA0b4zwr13ShORVf9pH9pd40hB3QzJ9znSKtbmKmigmbVPik0Jd3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801858; c=relaxed/simple;
	bh=z7jsxnacv+zgPXn/KPUBqzjEg2jD4ftieB6KHU7Fl94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMX2oN+2d/wId3jn5Kw673/IlPK9hYuZy+9z9MOU7YVUZpHjw3NHgJbplGBf/eI47Wc5tpDN7SinoU6EzIEtFclSKRvzy2DcdjNyLIiLaoWgVUNqHwNMJmuwT6oXm4II9WLRgjtDLHt+qAaBcjnOHPfPzNtPJo5REE4GsYjcux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KimZJf+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24D6C4CEE4;
	Mon, 17 Feb 2025 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801858;
	bh=z7jsxnacv+zgPXn/KPUBqzjEg2jD4ftieB6KHU7Fl94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KimZJf+BgHyPIaK+Keu3BM92NYX4PTUmhEjlKMFVxjW+pmx4UtwZPrxwu4oZ8ggrB
	 B5vqU3PG0eWxzmKCfZBDA6SXQ0BcmlBKpnhokrJe1g0AKVP2IE2NsyDe/UsEfoDnJe
	 Mvw3lI0MuTt/liXWvgPaE3N1+mdCVGy1BIW5FRqhXgRdd1pD58sXevSgDcNls3err9
	 WcIdwIMtWN+oY+M9vFIeV0s05zlAjkAIEMxos+2MfKZ3VvG6MJzmq2EJpHWUYwSmsp
	 VakGkhtCaM9/GLfd19tnIPTl5USGQ1mQZwUq0Dcio/sCCIDZ6NSMwznd/RPpPExK54
	 1Sttp3534RbVg==
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
Subject: [PATCH 09/29] iio: adc: ad4030: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:09 +0000
Message-ID: <20250217141630.897334-10-jic23@kernel.org>
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
 drivers/iio/adc/ad4030.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index ab5497c8ea1e..209cfc2e1785 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -784,13 +784,12 @@ static int ad4030_read_raw(struct iio_dev *indio_dev,
 	if (info == IIO_CHAN_INFO_SCALE)
 		return ad4030_get_chan_scale(indio_dev, chan, val, val2);
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = ad4030_read_raw_dispatch(indio_dev, chan, val, val2, info);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
@@ -822,13 +821,12 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = ad4030_write_raw_dispatch(indio_dev, chan, val, val2, info);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
@@ -839,16 +837,15 @@ static int ad4030_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	const struct ad4030_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	if (readval)
 		ret = regmap_read(st->regmap, reg, readval);
 	else
 		ret = regmap_write(st->regmap, reg, writeval);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
-- 
2.48.1


