Return-Path: <linux-iio+bounces-10372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA98996D6A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0121C21F5A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030919C560;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be4F2LIJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7B18BBAE
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483405; cv=none; b=Khcq2d/6hWC2iH2aKr91czbaAyL7zqU16R++TM/m6HjegSTMLsmwYMpk8oLXmxJC434wqEqsrqczK47QKLHZLiKEISnoyrVxs16JWXUVUMbYKI9NL07JIx4EY0WUdJlZRQWHpa7L47CURJo4K0DXzNisJKnkaNb/3S+6hvsjcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483405; c=relaxed/simple;
	bh=+/dityUc5wn114IVF17+AyRQGPqD0EBKXypj6trz0nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxF6M+X9tdYcu6ONwg0z5m5dIkJFbNU+Mse/U5w5SoTxTLeXPXwniu0d3RXrH2TiR/5kLIYLn/hu8o+e2IQNT76fNLQJm84ubmrDa52F6MTGnHkJcf9Gm9lkTojCjqsRvxK2IXfgWMmagWzpi352902YQbl9Ui3HlQGQWVru1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be4F2LIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FA26C4CED2;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728483405;
	bh=+/dityUc5wn114IVF17+AyRQGPqD0EBKXypj6trz0nQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Be4F2LIJE/Gv4KXZZp+COK/P3dsBOBVd84Cutt1T7h1QQWpsMsj3bY8RfdpFlb97W
	 cJ6rJ69Yx5mEQdpcDUzg5odV99ZJ0AmKqc3Ap4V6GxNOWqQzR773TdaLe6mCLnHXp9
	 EogM4eHSOE687FEiQAtL25e/05B7/KG1AgzFCNf+7lnR8ZT8oC3j5ofvtB6E0GycxS
	 8mzvpv1PlH7959F/NZMThbWCUkv6sa1QaNs6ZD4+xuEmjXfkwDNNlxhT1e8NlgSUjc
	 hn011rU+i7xJjMEZsUqKoqUvS2KoPBbWtDPYMw+WFL19CaINsiK9Qy6XqmSmt0h2Bv
	 +mT9dqYYX1E1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274BCEDD9E;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 09 Oct 2024 16:16:46 +0200
Subject: [PATCH 4/4] iio: frequency: adf4371: make use of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-dev-adf4371-minor-improv-v1-4-97f4f22ed941@analog.com>
References: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
In-Reply-To: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728483403; l=1733;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=DGH4I8LERGUVBi449GUHzvNvBiAJHsHztF+43+7F+ac=;
 b=WUiHMjYXsVhamHZoKp5SXwyL2fY/16mdslO7qxD9UkUMiZOLD/6K8CR+s4T2Y5EpYdqKf3JQu
 il75xzcUJFnDGY0blvg5wYcCKofRDCiAia3HsHT3jh1gX7rWoGJVxOP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use dev_err_probe() to simplify probe() error handling. While at it, add
some error log in case we fail to get clkin.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/frequency/adf4371.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index 45c8398a45d0..d752507e0c98 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2019 Analog Devices Inc.
  */
+#include "linux/dev_printk.h"
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -554,11 +555,9 @@ static int adf4371_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	regmap = devm_regmap_init_spi(spi, &adf4371_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Error initializing spi regmap\n");
 
 	st = iio_priv(indio_dev);
 	st->spi = spi;
@@ -577,15 +576,14 @@ static int adf4371_probe(struct spi_device *spi)
 
 	clkin = devm_clk_get_enabled(&spi->dev, "clkin");
 	if (IS_ERR(clkin))
-		return PTR_ERR(clkin);
+		return dev_err_probe(&spi->dev, PTR_ERR(clkin),
+				     "Failed to get clkin\n");
 
 	st->clkin_freq = clk_get_rate(clkin);
 
 	ret = adf4371_setup(st);
-	if (ret < 0) {
-		dev_err(&spi->dev, "ADF4371 setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "ADF4371 setup failed\n");
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }

-- 
2.46.1



