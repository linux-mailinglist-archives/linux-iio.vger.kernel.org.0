Return-Path: <linux-iio+bounces-9982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 085CE98C6C8
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229431C233E1
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C0D1CF5FB;
	Tue,  1 Oct 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mig3M1gf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFD1CF5E6;
	Tue,  1 Oct 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814124; cv=none; b=gVerbs8Pwqjetv1/vceZrrsUJdK8L0jo+Q0POuoptXMnainRBMg9rPGetu65Bez68LGFX4fKngYcF7fPwBsz1OzbMaJcDVUwVetMzAb4Z9xQ63cLQiF6VbCUY9JeuiNHERTKHZ6Zk40ktLqjOrUPUDoNy7WWDHNM5nXQ4+MIwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814124; c=relaxed/simple;
	bh=+GWkCMN4psn2gtNcb+/LyHIlKEDipE9L1RayFLQLUg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCeZJOcKqgBAen92ZNquXkhW2QwF01RWQomNbf6Z9DYQXoCXon+Ll9BV6xb7mUVw5gk9gdkCWfRllWEbf0HpHdqb1GP5+GJOBbkvyQ4lvXiI34kpnUeYlt58BU0vrGpiSucOtDhHmURzprzp1wZZ6Leu+3Ao6uma528XvN1WoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mig3M1gf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so2225762f8f.2;
        Tue, 01 Oct 2024 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814121; x=1728418921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9affU7BQtNzzNlV+YhjgliO4rgtVPUyI9GrtMaD5Zg=;
        b=Mig3M1gfCPITy1GVWIS7W6PAlmG8zQmMbNjaA9HLGpYFsn5OcZJs4ghKS7tJRoH+Va
         +0rV0JpLsMrEicRWQrPfgKRHByBvzP2CdwHGVJQqORcrKsBErIhD9VoTuQ+IpX//ANXc
         qYZw26cBpnSSkeSzWcKjY+mFqARP/ch2S76jd3e0E8VXvwrTU66lord9wH582ltfVH5v
         C1+ZA/WmwrScy8iLmRVoBacZ7Pgvr6lAqXLP5SYeqihFwUZxDQAyMJoWaucqrkwtx4Pl
         WmurkiLR66QTVP3OsUTBGPDaePPxaQTsFzgejyz7G0vWGQfNxme1pmaiw8u0epNiR7F7
         H3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814121; x=1728418921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9affU7BQtNzzNlV+YhjgliO4rgtVPUyI9GrtMaD5Zg=;
        b=m2JMczVjPRfozdWHhFZm94WZM7Lia0jwS9AtmKbNowmFG/XEk942L143o8/kEtCmuN
         wePVcJ09PMcs6pCW4iManRb9S/6+jZi4AvWNoiNinuVav4JdDB5tew4KY+EdQ2Crjy/n
         zbAyKn/t8SMPrNrYOcqJ3MPmPWUZFzjH2v5RUD3W2uaoD3LsPEhEoxRTS0gB8Ul5hPc0
         uhePPqV7ZvuDrCpk07pcnHUn+zSW1mcVphDJGT2VjvFfEt6avZSZt01UXOMFt4ncqyVO
         8hneRATpHLU9qhgZK65aIlCluMX2DuBg0aZ5vGhw+yqsX5F78tT9bZ5a4a2yD9BFJO6A
         mDmA==
X-Forwarded-Encrypted: i=1; AJvYcCWWqmozr+6qSq9g6iCbkirbF4M/bw/JgApUsi3IwJbIU248AuCEYCr0RLQrVEZzziV6k+VJYetLsiaLEerf@vger.kernel.org, AJvYcCX/qOKmUvn/yn7/lZEluSWhoN7f+4cA3pT/YfEaZuM2nMKuJWDXGWIIKLFnS5tXpsBPjvinlMe09yMS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yJGP6EWzjEpUhPLU0J3CB+dwuZbIgBUlrdJt0dGjK6Xo3XxF
	Fffk/QbudPai5VxAVh/7T0IPLNDWobu/YA+yyjg50vultbM8XEg+dWmj7pok
X-Google-Smtp-Source: AGHT+IE4JfnQv9+88lHTSu63DfabFVZhhunBTwUAeGlaC6TXLuqxgbfuRyxpYZUUNP0Kyw3s5g9fTw==
X-Received: by 2002:a5d:6acf:0:b0:378:e8cd:71fa with SMTP id ffacd0b85a97d-37cfba03ed2mr605024f8f.39.1727814120616;
        Tue, 01 Oct 2024 13:22:00 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:20 +0200
Subject: [PATCH v3 7/9] iio: light: veml6030: power off device in probe
 error paths
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-7-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=3359;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=+GWkCMN4psn2gtNcb+/LyHIlKEDipE9L1RayFLQLUg8=;
 b=V1dnjsWCjQV59GpuuHwxXxBTs+cDsj0NVRPEFo8LC5p0hOEX7p9VE04swzcbg/LGXh2jDdik/
 bcp9HBYRlN7DHT/HHXeQKiydC1CerSzQcpj66kOm6AXa/OiVmjkz1R0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Move devm_add_action_or_reset() with a device shut down action to the
hardware initialization function to ensure that any error path after
powering on the device leads to a power off. Add struct device *dev
to the argument list to clarify the device the action is registered
against, and use it wherever &client->dev was used.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 677374e401b3..0e4c36e8a566 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -740,45 +740,44 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
  * interrupt disabled by default. First shutdown the sensor,
  * update registers and then power on the sensor.
  */
-static int veml6030_hw_init(struct iio_dev *indio_dev)
+static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 {
 	int ret, val;
 	struct veml6030_data *data = iio_priv(indio_dev);
-	struct i2c_client *client = data->client;
 
 	ret = veml6030_als_shut_down(data);
 	if (ret)
-		return dev_err_probe(&client->dev, ret, "can't shutdown als\n");
+		return dev_err_probe(dev, ret, "can't shutdown als\n");
 
 	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "can't setup als configs\n");
+		return dev_err_probe(dev, ret, "can't setup als configs\n");
 
 	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
 				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "can't setup default PSM\n");
+		return dev_err_probe(dev, ret, "can't setup default PSM\n");
 
 	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "can't setup high threshold\n");
+		return dev_err_probe(dev, ret, "can't setup high threshold\n");
 
 	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "can't setup low threshold\n");
+		return dev_err_probe(dev, ret, "can't setup low threshold\n");
 
 	ret = veml6030_als_pwr_on(data);
 	if (ret)
-		return dev_err_probe(&client->dev, ret, "can't poweron als\n");
+		return dev_err_probe(dev, ret, "can't poweron als\n");
+
+	ret = devm_add_action_or_reset(dev, veml6030_als_shut_down_action, data);
+	if (ret < 0)
+		return ret;
 
 	/* Clear stale interrupt status bits if any during start */
 	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "can't clear als interrupt status\n");
 
 	/* Cache currently active measurement parameters */
@@ -839,12 +838,7 @@ static int veml6030_probe(struct i2c_client *client)
 		indio_dev->info = &veml6030_info_no_irq;
 	}
 
-	ret = veml6030_hw_init(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&client->dev,
-					veml6030_als_shut_down_action, data);
+	ret = veml6030_hw_init(indio_dev, &client->dev);
 	if (ret < 0)
 		return ret;
 

-- 
2.43.0


