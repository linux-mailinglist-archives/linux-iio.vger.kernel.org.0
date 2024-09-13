Return-Path: <linux-iio+bounces-9501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6A9780F3
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461051C22749
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B81DB958;
	Fri, 13 Sep 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJOhsmTB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58951DB555;
	Fri, 13 Sep 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233562; cv=none; b=dWj1NEnyOmzhB+kpebR57sRu6tv8QyK8vdddbL9/ycDw+jx3p1yuHd1GAJXtKST3H15kDAaVhiiyxLtFegcO6g/uzU24SxG3qwUL+ILOOhsU2BPpGbnRpNkzuyuVk9FADYUUyoL4sJxgXsZT4V70si0lM2uwoYANfMYhnkua7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233562; c=relaxed/simple;
	bh=1o+RujVAQZnAD3qfV2O0LLel9fgxe9gwMp5ZPSdYRNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iX9+cRiZG8K0q1HwXm3CBUyuP4cQ9uB1FOxoPnWt3FcA9fJdR/fsdcS4CayEFicyLhWw6pT4ffud3xNOOrnkHULBT3vd0lBLp6ZYBJy4WCHn4zEw35RndqCftszxJgej974r32XvwuQEdvIrAvZmgGQ8ns+OjEdmilMZbxyASWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJOhsmTB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so107321866b.3;
        Fri, 13 Sep 2024 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233559; x=1726838359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IF4qGvII+dur0qzTSrxsUrxH0fWjZLIM0pUAGbbih0=;
        b=iJOhsmTBwGSL4eqoxDINnseAAiO+hxFkJ1LddtGNUpzPfk6pTLeS1agxUMin7Slg1Y
         nEBX/yqTTs4Zh9OCnXy/waER8parEEHs1DA94NoZqbN1QCn+pTZaM7tprEE61ZlKge/p
         9cCct4A/a40NGFh9JSKsJAFkU0n3syoDUI13dmzZ2eWaQ8zincyUO5jTSkHJxBorUEJO
         eykxHYEEh6p9GI7vvxUoAWdVDtcVjkVpGsQLlWfBiuykMJQmMg0/M/D1Acmp0/RJIXM5
         B3Y61QkdZfz8dZmX9jTnrBgVula1acs6BM4pPBcY5lL8XoCiQXHzwt0NfaG/zUPYqhBH
         xKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233559; x=1726838359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IF4qGvII+dur0qzTSrxsUrxH0fWjZLIM0pUAGbbih0=;
        b=EX1V0RkiYgRxOgseft9SYu0A7JjynaVo7pTYcy64kxMQIh9ZAD2dOHMr5IUcdVVUa8
         wvFUv57ojBYCb4g/KylT+hIxhK1nUaauqYoMfyR2bnoxp3SQE1WuMIrVp6wD+9TdDrbD
         h3MJLG26Ds2gXRT33rWW6DzntLV26diQcXwqfd8SU/MvVMoKjCQ8XQl+rndrj2uJcW72
         xJvM41plxUDpbn84ztJjGbEO8cZM8FJ4VpTK2UUxHqvad1fo02jR3sM5dveuwlOO04dI
         OvQ9M7otUw8RMM+XRoUp+kY0mCXB3wyFCoBS668TBlChP7cgZpKfl2/gb0/rzgjM+Hpe
         bO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVD14xrwnl3WerRAR2Lfs6X72JphwtCer5h9gaj3FRWE10LLcFKo8NygPGDYy60WLkPa9X1NL7IMrNYKpWd@vger.kernel.org, AJvYcCWkVogmzK2FBrOwlyULkPqbYEDuJ8EHabiqV0TTmqBULULpJ/vTo+P0316eSGoRU+EA6DL9abeH@vger.kernel.org, AJvYcCXztUHOiFbuRZG6Igjd/klPvU6ZcDOWusJFhxMTHZiPYZg9ZY1ngwOEnB4QyC41MCAJt76hbMS7d2Cr@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZ3vU+hKwO81yqYRL09lX3Dil7/vjJ0Vdo1GFWG2eaFmeYfU2
	nLwC7F+9XJUZYt15GAX7e3sQL+W6ReOYbbBtWTO5/yU0LhyT0nEZ
X-Google-Smtp-Source: AGHT+IGls/PJoarlAbHcGQA/sOJ/gjWdxcBKwteEvQzmyudaC7u8D3sWcLe/9CjdeJO4QCbLfDuWTw==
X-Received: by 2002:a17:907:60d1:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a904758f269mr225921266b.0.1726233559073;
        Fri, 13 Sep 2024 06:19:19 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:18 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 13 Sep 2024 15:18:58 +0200
Subject: [PATCH 3/7] iio: light: veml6030: fix IIO device retrieval from
 embedded device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-veml6035-v1-3-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
In-Reply-To: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=1569;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=1o+RujVAQZnAD3qfV2O0LLel9fgxe9gwMp5ZPSdYRNo=;
 b=qnqEVdzyMlkDlPv3IGJ5UBVq48lMpPTlZpPD+gPuneJcVhNhh7lDifOVYEfLYL6/sMphF5oe1
 7+hBxFB4fX/CZ+SpmC7WZUZHftW+GNNzYTKpD3hrBZehd+c/gxvUiL+
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The dev pointer that is received as an argument in the
in_illuminance_period_available_show function references the device
embedded in the IIO device, not in the i2c client.

dev_to_iio_dev() must be used to accessthe right data. The current
implementation leads to a segmentation fault on every attempt to read
the attribute because indio_dev gets a NULL assignment.

This bug has been present since the first appearance of the driver,
apparently since the last version (V6) before getting applied. A
constant attribute was used until then, and the last modifications might
have not been tested again.

Cc: stable@vger.kernel.org
Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 2e86d310952e..df2ba3078b91 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -99,9 +99,8 @@ static const char * const period_values[] = {
 static ssize_t in_illuminance_period_available_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
+	struct veml6030_data *data = iio_priv(dev_to_iio_dev(dev));
 	int ret, reg, x;
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct veml6030_data *data = iio_priv(indio_dev);
 
 	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
 	if (ret) {

-- 
2.43.0


