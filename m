Return-Path: <linux-iio+bounces-6130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23879018BA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643FEB20D08
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7592C770F7;
	Sun,  9 Jun 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ8+cx3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A67603F;
	Sun,  9 Jun 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976327; cv=none; b=tOC0VCIvP5iSyC4lVipHa+h/t0Iy4VgjHWLu8tLya6YTiBq+uuslo1bBQ0kfJfk+KGaq3ww/C0CzhuXZtp9gG3QmNx86jBtT0BdJuyPWy5YFgeZqFn97nMq8VzVYwEtCdTEHLZMNNo4QtPUyY06iN7OtnSLmQcTtvs5XVQr+Rbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976327; c=relaxed/simple;
	bh=v/aOwIvmgfHwNIU70Q9N6/ID1xtbp2EUX/VBKJ4uSIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsG++5YUf+SSvmDmlJrMImUZFLqi2qmCvxb0uxWsY0U2hJHxT46nrko+U/5+Gf6Wx0/iQLHgvz04zg6KjDs0QYheN2AKBUaiNGfcwx2bj60k+uL66ZlW3iQ+altykR/1E+Hla6+Ut4zDrt0mJKVGfTUfpNRp6pUDhOAjaZOIZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ8+cx3w; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c7ec8f1fcso651113a12.0;
        Sun, 09 Jun 2024 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976324; x=1718581124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgvwNQnXyFmRcVDABKMNh6lBKNiuu39ffT9szVloPkE=;
        b=iQ8+cx3w4XJpKT8DWiLI6bAswMBMYjm+qBUq/Z3gFBjw5G5B05do7tdrIzrewz5X9O
         nScBzWnDA8vPDK6lsvLBas+jMb6LcnMAj9TnJRf0jMY8gnjc3biyOe1vwq3wL8++SHH9
         O2ftOkzH2WhBSCjdcYCwbxIcQjTEEr6FEjBC/M2VFiwTkZmWI2ROkNgFEV9he5P/ItQy
         nqS1/Iaio9If3NIQvkw6U1ub/1FX6ATrH6xdzcylAj6LGi+drssu4DwQdbCDcztOqf0f
         QgH4cc5a9LVuZIlY762eGBvkJ0abJPNku3jet3q1LnSwZnsdtUECezXs9PcJCvLxGDdP
         U40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976324; x=1718581124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgvwNQnXyFmRcVDABKMNh6lBKNiuu39ffT9szVloPkE=;
        b=UlO4w2G3DQJ+bY8jLEhifANC8j9HDNFQ+ezUdmdBZ7k7vePcdC3Nr5Dy0EC4BWdDaA
         RkWDNszLd/LIHnnMUTQyqdQo8N66Tpao+5/lrqr+xh0HFvl4MbfhOit1reV0QLGkynNe
         oIUdwkRaEVIPJ7jvHFb4HYuhjoN6r3PxdbeJg599J3E2RlVhg4u+tKRbY6bn5d0tPINd
         MkKyTiUKg/2lJ7sxyDqjl+74FMGg2ZS34LUK4bRcKel3nNPxvCiN7xwbIWFjIuGmOCXK
         /oI/htrnY7mBaqzuq5kAA5fPOX48I8Ni8PFE3O+5rUAkp4gN+Ixqfl224wifp30T0e01
         KL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW094e9kvjvsicNF28W/4WEJG/blPLn06UumxgcngE84aFe/zrOYkGM11BWcLP357FpXvdJkgFVPa22TIyC2XTvKt+LdlsodwIHMJPAT9u0ztGMAGfFo/ewo4AFwO3geycL+VaG2e2/
X-Gm-Message-State: AOJu0Yxs8YeOGlcWITzMyfj4iLevavhj2Ega/EVUkmL9DMvfAr/1WQej
	WCriaOzkzy/zQ5q+ou+vgtzDjBvTfafBXJPn/1aZpQEsxG6nSweO
X-Google-Smtp-Source: AGHT+IGKY4Oom8DrqciFksBMZsLFQb+n8sZ2wbOLqy2/xNIne4o5Cz+csy1SXbJ7wT3Rl5PqoWRnIQ==
X-Received: by 2002:a17:907:5c4:b0:a67:a2e0:9dcc with SMTP id a640c23a62f3a-a6cd56108ebmr674134866b.5.1717976324116;
        Sun, 09 Jun 2024 16:38:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 12/15] iio: chemical: bme680: Move probe errors to dev_err_probe()
Date: Mon, 10 Jun 2024 01:38:23 +0200
Message-Id: <20240609233826.330516-13-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple cases in the probe function that dev_err_probe() fits
the needs, so use it.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 0390c298fdd8..b357871ef601 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -866,18 +866,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 
 	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
 			   BME680_CMD_SOFTRESET);
-	if (ret < 0) {
-		dev_err(dev, "Failed to reset chip\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to reset chip\n");
 
 	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
 
 	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
-	if (ret < 0) {
-		dev_err(dev, "Error reading chip ID\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error reading chip ID\n");
 
 	if (data->check != BME680_CHIP_ID_VAL) {
 		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
@@ -887,22 +883,19 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 
 	ret = bme680_read_calib(data, &data->bme680);
 	if (ret < 0) {
-		dev_err(dev,
+		return dev_err_probe(dev, ret,
 			"failed to read calibration coefficients at probe\n");
-		return ret;
 	}
 
 	ret = bme680_chip_config(data);
-	if (ret < 0) {
-		dev_err(dev, "failed to set chip_config data\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to set chip_config data\n");
 
 	ret = bme680_gas_config(data);
-	if (ret < 0) {
-		dev_err(dev, "failed to set gas config data\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to set gas config data\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.25.1


