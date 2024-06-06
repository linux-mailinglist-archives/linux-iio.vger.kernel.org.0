Return-Path: <linux-iio+bounces-5963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E868FF6CF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E21282EAF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED319EEDC;
	Thu,  6 Jun 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJT2oDyr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DD19E7F1;
	Thu,  6 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709056; cv=none; b=dQPQGcLvQ7oFsk/w1LmWo6EoO8e1QnrbZzQrb8pByDRdP0tqc38bPQYCbfEUzoYGyCYdlr7rDQllBSCLSpXio1U2SbgPnYuwaxg/oWYgmRSP99dj9g4NN9+HKsTiLWUfiYXPnchw3C2IgImJCCWbSAOwNItRsB15VgFD0bf9SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709056; c=relaxed/simple;
	bh=T9imSyy6LLvoVoF08Ve6NKlWM7UOFrjsrvfcBYSqe7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXY+KWibiJ14pNF+vnwTCLfYTM24Cu9WRNmAetSPtxF5kz2bPbon7bH9ghpj3/pNu2JCyBRD4xILhZ2XJDlxH6wvROtFcaNpaV9VgcktD3xpEdu1pNAH7tlCvDqRhzUMo2ZDv+n6VVUzfxvlP4FY0TMJDGWp1aXvxUpwZdtmIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJT2oDyr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so1754147a12.1;
        Thu, 06 Jun 2024 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709052; x=1718313852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTO4UyIg4XRLdCfjT2Pgfa2wJW48nKGzXpcm091ANf0=;
        b=fJT2oDyr0c9yBG8u+ooFWUoUQI7devb/kEGYFkxIdf1mOD0+RzDmbfIHEMBa472ndP
         wduEiIMZdWnGFGon9SFdkUl+D0gkk5PL6yw/dIVwv/B/SUncGDKL3AqiPx1Fnoc8npeK
         /iWr5a80GaSfrKsCi+Hl4Lpk6yxdW9ysImBRTz1gehOLv6rJ41ADMEfLRWYChtkx5WZs
         cUA/14/WTPwfmgSGjeABXjb7pCZP1TmzoE/HqQvyt/Owia19pWlBR93J9d6qtzA1RBYY
         zMLKupsPyHYJz6AOgRYL87+rGU728/fO7P1crjw+BrAVXVrj249W3AYWibGJLUyhWgrH
         kH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709052; x=1718313852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTO4UyIg4XRLdCfjT2Pgfa2wJW48nKGzXpcm091ANf0=;
        b=TMcrvEdy6PPng8tEosWaygpy2F2lrGhOkUdGafzM4Og4gf35F0cfGEmZ/KaPr3ZrdH
         xklhlW4ZEftvXx31DB1nzEPEc4b9c5Zktgk73I+y4XWNmyyeHKNujutwy17NgwmHOQ4E
         uPbEVyOPxwfKbJfESkoWx0zCm1dkUCwh3TJXDDR/7I6lpA8P1u/gQLmbdwqGKbnc3FoZ
         3vjSQgp8thgZdiC8oG29C9kp/+sTC/vk0SunaPOUfswBrzJgQCC3wBDCWqo6NNujUgXl
         EL6bqh6qre/a6+2ZHE3EjrlaxvjGNM/0O0rvWzMlvNQiFi5li0QIFSuCFfJ/wZAcwNOw
         98IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp2xKQi1+036PXIAMNn0E4Y2joHZO9SuasPjzEs8K2Nn5zxSuLYjLda1BEaFhCCFAAvMIq/ar5D76bz2UeYO4PD0BnV5EVi08azc8aLQPBuHzh2Y2Z+GprLuFK+hL8Kpa+o3nxHgJx
X-Gm-Message-State: AOJu0YzSI2dpKva6JvtAOwJoFoGw0ubI42F9rvBp640oqil+CUFB4pxL
	X9hq6KuJYHI54wUER75V9JN5b5FSKGZzI7bc/ay4dpl9gpIia/h5
X-Google-Smtp-Source: AGHT+IGGigPx39kzEHAOvUkkKMc2vnxYGFQsA23KM9HiMfvEJzzPqurq2ZQp9uLDYA0uAxFvyW3lBQ==
X-Received: by 2002:a17:906:81c3:b0:a68:baca:f120 with SMTP id a640c23a62f3a-a6cdc0e089fmr49584066b.73.1717709052164;
        Thu, 06 Jun 2024 14:24:12 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:11 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 16/19] iio: chemical: bme680: Move probe errors to dev_err_probe()
Date: Thu,  6 Jun 2024 23:23:10 +0200
Message-Id: <20240606212313.207550-19-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple cases in the probe function that dev_err_probe()
fits the needs, so use it.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index e354eaa34d59..1cf375904b8d 100644
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


