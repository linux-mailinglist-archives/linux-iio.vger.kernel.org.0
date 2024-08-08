Return-Path: <linux-iio+bounces-8334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D073E94C532
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 21:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38137B22261
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A315AADB;
	Thu,  8 Aug 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwACziWO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036D15990E
	for <linux-iio@vger.kernel.org>; Thu,  8 Aug 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145305; cv=none; b=nBxrhqtc9dB8077b2X6Y7zCCpyoBX9kL6R6vLJPhUyfH56C0ZF8TJeDrUGpLt5cUJMFzCBnXZduLapwOr5En4wjcR1PAxHfQio6gmFqByfzodpmnMc7Mzkc6ZTP1mWwZ+eaL7mNf+F9DQ4x79SpbSVub+OnJ9qAdVqfhWGE/CJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145305; c=relaxed/simple;
	bh=NQU0Rv98JrX81/A1nEguAxQLbRP4/UsWjsfJGNGtA8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r2r+YVqCNGbJxM/3n2d6fyCr08KDPTa+k8JBlYmuk48F4ncXTIl+adN9Jmz02nnoTUAGeshCUHo5B37NisgGXQ0+oi6Uniob7/RHtQOHSjW02t9QQfEBu49ZkSGwlYtEnh40uRLqMuWzz6X53F0GYdGrqyAr5FAnjMQsVknizcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CwACziWO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so2829573e87.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Aug 2024 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723145302; x=1723750102; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmvNOlcZTqNimmDZ7x4m8PDONx3OgfdzukD/3f4hZ5w=;
        b=CwACziWOUTapdybnWrNogumsTX1V6OsrMKw78PQKu7KngUTQdcGc92gQio8YL67A1M
         /HJjnhRLN1MRe7e1ohM36s7AcMjIBI3ZqL07pQNJPnGGDRENikpY3Z4uJOAgYXvlAk6B
         LAFZMHdVCX3bAU6dOclgAQoaiK3LOGspzNDk5zcTHMAdomI/ZGBYlrHbMeCxcHqnAKbI
         vdLx6kqVCRc2teoLFnwg+89kOlgAbU8+MGSmlsljYAv+M/273NY0rbI2AcoYV2GFbaas
         RfDjumOQaUR+VfGrD6N9iQpEYq7tCn3N1M2MzTvAkOt5jEKzkzLUS74A8EstsOenSUcn
         2Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145302; x=1723750102;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmvNOlcZTqNimmDZ7x4m8PDONx3OgfdzukD/3f4hZ5w=;
        b=JwbN3/lGAYH8Z9ZrPLgCVePv+T7X+4lv4XWAi140M2vgIBW8UTUjVeFY4wiTwbQceB
         FfCw1X17lhW2qRsNtMGP5I6vtdTo/K5nUIIs+YArtGK2ycFQu+VfCwpJg1cmvBQSxKK5
         HWBSAAikB3DShYiVnAgmdoe+RA8x0D7a5jbrcQavofzBYT3pR7PSj8+rg9QLe+zDVBuR
         hCTDYvI5us6uWjMdWjKQ9UQ8hn2DgG/XARq5Imt+PPrz3KEP4Bry4yG/iOXebpAuaYKE
         wKdtnY0mPN5BnzZDUXHKbZj2Acp2Y2eD6C3NzoP1UpHXwJsJgbtT9cqPSMEKPb3kC03Y
         z2gA==
X-Forwarded-Encrypted: i=1; AJvYcCX7iEi5UK7n9ij7pwyAJFqbFcE5DnTP5LpI7Y/Iz8kMLxb+GLjYz+91m2IPi/lmCzGLzeQuA4Xtmg+hwgj+OeEci1D2gjbkFaDm
X-Gm-Message-State: AOJu0Yx8FOCo9k3Es7+0CGu03vKF0Xlwtrq4Zqbjg2zURr+wvEfiPcZL
	YV8D1dCR2mJkexny3B9RwJj+gZfNcSE+z+Bm0KuD/y+Rko8I+tRd4bp/3vga1TQ=
X-Google-Smtp-Source: AGHT+IHtLnvvzJHxqOQEnHLayXZTmudxUv+Krktv9ZXkQDMBM8SbtIwTknWYYCVUWgTw7Owo1+ANLg==
X-Received: by 2002:a05:6512:280e:b0:52c:dd25:9ac6 with SMTP id 2adb3069b0e04-530e583df3dmr2798111e87.29.1723145301524;
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcaf7esm786912266b.12.2024.08.08.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
Date: Thu, 8 Aug 2024 22:28:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: pac1921: add missing error return in probe()
Message-ID: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error path was intended to return, and not just print an error.  The
current code will lead to an error pointer dereference.

Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/adc/pac1921.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index d04c6685d780..8200a47bdf21 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *client)
 
 	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
 	if (IS_ERR(priv->regmap))
-		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
-			      "Cannot initialize register map\n");
+		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
+				     "Cannot initialize register map\n");
 
 	devm_mutex_init(dev, &priv->lock);
 
-- 
2.43.0


