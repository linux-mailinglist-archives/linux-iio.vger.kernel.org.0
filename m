Return-Path: <linux-iio+bounces-7553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1497492FE16
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64361B21F0D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C939E176240;
	Fri, 12 Jul 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lBSiWQge"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5D1741D2
	for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800247; cv=none; b=ewfIGgwNrDDBLG5QVJdmyvKMryC5wmpQv3ecbpuHG0fw4N5FGeA5ZxwFx9xaS291/TgpLfGU36tzUGo1R8qnk+dt9izTlU3v4V9j/9hs9sOoe2P/oMeDyniWYQOWZ6rRx3QhsxWW0qI/t8AB2HTqPEGiJVuIsKPCOPKb1i9++fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800247; c=relaxed/simple;
	bh=0VbOetS204hz3J5pkBmUitCsW+y9jRjY3qZVNN6H5vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmezHfj4FTFqXiqWAEJsaOWiqEfvHa1KWXyZTOkxhjt8VWGAT1YiQV/3B2xa+zbIwV3z7ZIKAKjM+48X8EtVjwIw0qT6f2EdjXchZEK7qXwNgBOieVrGLsK+tv2GxQE1xJPuTTffZAgBGGUbFPxCdaWjc7QrwtXbsofTu43+oEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lBSiWQge; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70368b53cc0so1040322a34.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800244; x=1721405044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+/He1wcvWjmLAJpdLkPUiwNIP+C83lJXvlwPZpJIgw=;
        b=lBSiWQgerEAy2fr7z4pByWR48BuAsT1R87VwVII8U/2Iy0eC8oiOgil7MkIr9/CeAu
         nPbSsLaRyiaWBOJujo9GEC2uAB3yFftpX9MOGmhyT4GfRrBXQFRiwQX4O84TR8MuyI8j
         ZzGe4/oBuRLoZVNo5fkr8o9NAx3f86iTQoijV6RMmqHnKD6bDbLBJS4NAc1Iu2y7oc4t
         NKkRSaBHjRkTp6ycfwl1JkhN/EMWAUDCtwyDHYwsFir8OY8vlgkR6jpoGgyCIedbTZej
         t7HWotzEcMjn2jxTQDZg5tbrcKQwIJ5LA/igeVW870hGR+6FKINx/ohuajkFPqtPUcG/
         d50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800244; x=1721405044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+/He1wcvWjmLAJpdLkPUiwNIP+C83lJXvlwPZpJIgw=;
        b=JAXDOIySj0KbktJfeRegAWBnqbovaEyDHrTAjwZZeeQO8YlOukedecOsCh92iD7Q1s
         ei0IrRZS6RtcgvG2MENQGmfHdMRXTm6SHpNtt3zIyNGG/+FPI2Lrd65wfoUefyX5OrIb
         6FvfhjyFN67Q+P5EEI9vy2m8gkPTjOEzt+zgVEP3lAFuO8OCKzH1OdvtyS1COijAHzpg
         zgIiWIR+It596qfBIvOQ2jALQs/wGfhGWXHAkPpbtYNx3vaFyAS7QZhufJH0ZT0Ape0n
         N1hYHB/x73QtsvX0sAkGPGMpeyvWRFT97LnHFLqud9lCGIKzKHBovGaBHx8gkc0Yvslm
         Fb0g==
X-Forwarded-Encrypted: i=1; AJvYcCWSeIo3qQr9qfRBTiPdwLF28WWXSnN50nWVFLlXt1GUQo4ytS9Qy4INqd++MP/xxee95uL/NuL2ubEBMqMraNO5IBIIL5Yxf1M6
X-Gm-Message-State: AOJu0YzZd+aU8LbRBxzzDq4JdAwSYLRE7A/4d/7BQqM/ffFfFvucIsFx
	mSNivXnmWF0K000nGPM0qNQ3ls7xzNkE7Z8j+HQ+HbWMWASTLJlFQpQYDGhI/f0=
X-Google-Smtp-Source: AGHT+IH/srFVuntJPDWvs53ehKj/qU4WBBDG3GMrsOa1plrNwF2SxPQ7RJAITmopV3xaWH2vtGNyxQ==
X-Received: by 2002:a05:6870:d69e:b0:254:9ded:a3bf with SMTP id 586e51a60fabf-25eaebdfb43mr10277746fac.45.1720800244107;
        Fri, 12 Jul 2024 09:04:04 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] iio: dac: mcp4728: rename err to ret in probe function
Date: Fri, 12 Jul 2024 11:03:52 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-1-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

To prepare for using a function that returns a non-error value, rename
the variable 'err' to 'ret' in the probe function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/mcp4728.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
index c449ca949465..300985beb35d 100644
--- a/drivers/iio/dac/mcp4728.c
+++ b/drivers/iio/dac/mcp4728.c
@@ -540,7 +540,7 @@ static int mcp4728_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct mcp4728_data *data;
 	struct iio_dev *indio_dev;
-	int err;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -554,14 +554,14 @@ static int mcp4728_probe(struct i2c_client *client)
 	if (IS_ERR(data->vdd_reg))
 		return PTR_ERR(data->vdd_reg);
 
-	err = regulator_enable(data->vdd_reg);
-	if (err)
-		return err;
+	ret = regulator_enable(data->vdd_reg);
+	if (ret)
+		return ret;
 
-	err = devm_add_action_or_reset(&client->dev, mcp4728_reg_disable,
+	ret = devm_add_action_or_reset(&client->dev, mcp4728_reg_disable,
 				       data->vdd_reg);
-	if (err)
-		return err;
+	if (ret)
+		return ret;
 
 	/*
 	 * MCP4728 has internal EEPROM that save each channel boot
@@ -569,15 +569,15 @@ static int mcp4728_probe(struct i2c_client *client)
 	 * driver at kernel boot. mcp4728_init_channels_data() reads back DAC
 	 * settings and stores them in data structure.
 	 */
-	err = mcp4728_init_channels_data(data);
-	if (err) {
-		return dev_err_probe(&client->dev, err,
+	ret = mcp4728_init_channels_data(data);
+	if (ret) {
+		return dev_err_probe(&client->dev, ret,
 			"failed to read mcp4728 current configuration\n");
 	}
 
-	err = mcp4728_init_scales_avail(data);
-	if (err) {
-		return dev_err_probe(&client->dev, err,
+	ret = mcp4728_init_scales_avail(data);
+	if (ret) {
+		return dev_err_probe(&client->dev, ret,
 				     "failed to init scales\n");
 	}
 

-- 
2.43.0


