Return-Path: <linux-iio+bounces-10369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED20996D67
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2951C22EAA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE019DF4C;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XojnCSEp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D218BBAE
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483405; cv=none; b=sKkonIF7EUiYmG6WgGDCzAaTt2LFBIHmD2GwYntWqihmKYT0V0yTQQS5d52IfVbQXiGlLSx56gZrJlaqLaOGNxGuf4G9AkNNWvwiCti/j4RvEH1PnjFq5ebD/3x8hUlEwihNH7RjO7hLFgEO8xI70NnlhJetoJulPq7daihc+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483405; c=relaxed/simple;
	bh=5wNlux5z+GNogEq0WHV+rdvAu3R+H+JeZIEZHnIemd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9QGiJlmmh9mIfj75At8ctPa6CfSNsLkrVbLx06zz0pCEMrC4BH38qq3NH2Q4W2wuKeWVKL1tNyHV4C2gBPMsMq1c9hfYDgRfpuknLhygwPTW+Oo8Pajj8nWZoGz/3QyP9Yf13aqt9BCvTY9PeGV6D/pg8VMhWJHXBJTpVAYa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XojnCSEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06B3DC4CEC5;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728483405;
	bh=5wNlux5z+GNogEq0WHV+rdvAu3R+H+JeZIEZHnIemd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XojnCSEpOzEGGxjhVItQLYhKbCfVAAR2+M7r+pOOk+kpqH/0/E7ZkYkfQa4KnSnDf
	 MYy+KCnXXRJlyBgPvI6oSmd18lKY4/aUAClgECo9VMhT4IMNEdbqeMHQdL6x+H9hPw
	 v54rJ31+8GE33DXo46Wv6k3mjF47hcDW6mLWZlDvXJgIn72ul7JuU7iq/hWNBEi+7z
	 MiQ5eKKJpVxSxBRstr2tPasbpzB4vy8le1BrpfoaQToez0fxhXshmqZMhVcI3eT+lc
	 lJJCtXG83Obg9fOZbsFkiPWMyf6A4+2YhFvQGCHwpCWfHUDcUCAm1yniNC47ls11GZ
	 zw71jx4wDrZFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FC7CEDD9B;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 09 Oct 2024 16:16:45 +0200
Subject: [PATCH 3/4] iio: frequency: adf4371: drop clkin from struct
 adf4371_state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-dev-adf4371-minor-improv-v1-3-97f4f22ed941@analog.com>
References: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
In-Reply-To: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728483403; l=1585;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Ic4YOIeGuD72RBXK+dHg9LtJlzq6oNWChpWqVJAnaFo=;
 b=2YprnA4ytZoZwrfvBTYZRKMx95RMEyoGkdCylRl78UCBuU+49E2hYEX1lj6CnDG9JhT4Sdmou
 DlTD4ZFJ2xEC+TYXbQISqmXg+OlNF3zZ+3vKnWcacHhRdlyIALCyKwd
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

We already cache clkin rate during probe and then never use the clk
object again. Hence, no point in saving in our global state struct.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/frequency/adf4371.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index eb31f442566c..45c8398a45d0 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -158,7 +158,6 @@ struct adf4371_chip_info {
 struct adf4371_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
-	struct clk *clkin;
 	/*
 	 * Lock for accessing device registers. Some operations require
 	 * multiple consecutive R/W operations, during which the device
@@ -547,6 +546,7 @@ static int adf4371_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct adf4371_state *st;
 	struct regmap *regmap;
+	struct clk *clkin;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -575,11 +575,11 @@ static int adf4371_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "clkin");
-	if (IS_ERR(st->clkin))
-		return PTR_ERR(st->clkin);
+	clkin = devm_clk_get_enabled(&spi->dev, "clkin");
+	if (IS_ERR(clkin))
+		return PTR_ERR(clkin);
 
-	st->clkin_freq = clk_get_rate(st->clkin);
+	st->clkin_freq = clk_get_rate(clkin);
 
 	ret = adf4371_setup(st);
 	if (ret < 0) {

-- 
2.46.1



