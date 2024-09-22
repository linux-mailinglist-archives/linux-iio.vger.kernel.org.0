Return-Path: <linux-iio+bounces-9711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1997E3F6
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8553C1F2158B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4041F84A32;
	Sun, 22 Sep 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq+hvH05"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F381AD7;
	Sun, 22 Sep 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043484; cv=none; b=JeSDms4dfwiaeqpXsr9Rfrucmb4ZWBHHIwKJvbp8gDHOBIng1tB+Bpfj+2hdyeaNOzuL9DvXB09z1Jt7atqtxQZ7jygFp1feBISA4ulCFIWcUhhBPDpJXmhjItpX8xC+/df8KlxfUk1lHmiAAnAj7EO8WiE6+1QySNBr37FhUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043484; c=relaxed/simple;
	bh=2hNnr0G0p4cAYnjHVrBaiV9Cl8oax0EHyQjepu1ne/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbbeRrw305qMqGisLSdRN4PulXJgcqP1fgbyXJnFKFfOnZfX5fVD2aBhKGw20ufyt35w//okb1rRjl7/7FyOD4Y6ie5SZvM2qOd4ahSAqsgqN3UbUXlMaZbwMZY2zqsteeTFB3Q9eezJ0R7e0gBooVLdxfUN4X3mCMFaWv9k8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq+hvH05; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d3e662791so258403266b.1;
        Sun, 22 Sep 2024 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043480; x=1727648280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hat4AlBF/9tP2fYNihkVV28b7p3hj4YuYqLSFJgd68g=;
        b=Qq+hvH05Uz+F0CmyTYu8YmrrKkP01npSJsMPUy2zL1mqYIiL3IGONK7Fx2a8MxvhaZ
         EuV8rsbGlQ3JZ9SVvE+TeeFXN1m99csFw4dD5lhv8gIvWd7P5A5dnIKM08CE55ulmG3M
         JrpXHNh99O8Tf222YFx5SZDX6SfPdolmjgYwuYmvM7pB8Bcs4Jm7kVt7G3CsQdxKb4VB
         UbBPj6UEAkKUe1ldGBKe1B3meJQe8/VUUJ1SJhu/FlKXZXE23YbV+DJlu8Lresk0mXxB
         wYZ8qv9VqzPXcQBCZap4ePLHh74LJhqoclToqXV58Vq+V3t07XX/CPg1hIj0QnrkY2FF
         xrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043480; x=1727648280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hat4AlBF/9tP2fYNihkVV28b7p3hj4YuYqLSFJgd68g=;
        b=X5DFPlckWB/Go2Vnq4MO+W4dAtKhGSZ6iyJ+5nuK0SFF6GZtq1KqWZNUrBJQsFtZbR
         bpIR5KNqyCtz6UjjCZFFFjA8Uu+ZaF8LDqj9iF6jJ7UoBpFK6sdndhZ1pXZvQ92q5v9F
         316RYs4Jt4bb6/U91Atci0ahJPwg6IW4n4ezppl6p7qX0eEcE8JfxRyU7ZDyIvZZoR/k
         zoYv288ntwQSTm1rsINWkpzmeT5Usi3u9Zwvgab07CXJDNW3cLSMaR9KqgX7gqHQCAFC
         39Mh9xGhyv98W2fBuVu5M/9fyz9spgi2Brk1q4rKDaWB+r4EtCBYpEl4yMIvcpn0PfNF
         0+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWtkvnSCbaLPVpeaKMQBCK1m5Fo2DOKwtme//z8mfg3Dia7GkiyKcinMbJxo2J0xBmA/l1A5tOL7mYPz2sQ@vger.kernel.org, AJvYcCWvJq6LUDunOazCvrqxI0W77eKj/x3Gn5NGJww3tLvCgtYOXv+lVcoMBLgBFu7BAM/59Mp28N2Lu4cW@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWhKS9guS8+OEPzCV9ZOaBHtrnsQSQbvjgKXNHY8Jgyz7a9s0
	jVmcoDE9c2eqxQ0611RPRmVrIMURq/3XBtdwDSujrEJ+KoCAulm0bv8ECFR8
X-Google-Smtp-Source: AGHT+IE6M1lF7nOppXXtQ9GtMnuBqxmCz76k/XzS/imYMv7IJy17mJM5q2ctvZ/n8lnd4b76RMsEcw==
X-Received: by 2002:a05:6402:4313:b0:5c4:2fa2:93f0 with SMTP id 4fb4d7f45d1cf-5c46484f335mr13689005a12.1.1727043480514;
        Sun, 22 Sep 2024 15:18:00 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:51 +0200
Subject: [PATCH v2 03/10] iio: light: veml6030: use dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-3-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=4012;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=2hNnr0G0p4cAYnjHVrBaiV9Cl8oax0EHyQjepu1ne/A=;
 b=FsrlOYqOm5rMA2AoJKiRhET7cKTK88gyXRqkbH3UtOUHLpxYyLyJmaxlt6d0sTLQ4JIhpum68
 8nAASmT6fn+A6W7t8Ij+os4me2YT1aiykPAaj32Rr9wDyK0HKyxIa+x
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the more convenient dev_err_probe() to get rid of the dev_err() +
return sequence in the probe error paths.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 72 ++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index e412a22474e0..ccabd4c844e4 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -740,49 +740,39 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 	struct i2c_client *client = data->client;
 
 	ret = veml6030_als_shut_down(data);
-	if (ret) {
-		dev_err(&client->dev, "can't shutdown als %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "can't shutdown als\n");
 
 	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
-	if (ret) {
-		dev_err(&client->dev, "can't setup als configs %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup als configs\n");
 
 	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
 				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
-	if (ret) {
-		dev_err(&client->dev, "can't setup default PSM %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup default PSM\n");
 
 	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
-	if (ret) {
-		dev_err(&client->dev, "can't setup high threshold %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup high threshold\n");
 
 	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
-	if (ret) {
-		dev_err(&client->dev, "can't setup low threshold %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup low threshold\n");
 
 	ret = veml6030_als_pwr_on(data);
-	if (ret) {
-		dev_err(&client->dev, "can't poweron als %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "can't poweron als\n");
 
 	/* Clear stale interrupt status bits if any during start */
 	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"can't clear als interrupt status %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "can't clear als interrupt status\n");
 
 	/* Cache currently active measurement parameters */
 	data->cur_gain = 3;
@@ -799,16 +789,14 @@ static int veml6030_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		dev_err(&client->dev, "i2c adapter doesn't support plain i2c\n");
-		return -EOPNOTSUPP;
-	}
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(&client->dev, -EOPNOTSUPP,
+				     "i2c adapter doesn't support plain i2c\n");
 
 	regmap = devm_regmap_init_i2c(client, &veml6030_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "can't setup regmap\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "can't setup regmap\n");
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -829,11 +817,11 @@ static int veml6030_probe(struct i2c_client *client)
 						NULL, veml6030_event_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"veml6030", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev,
-					"irq %d request failed\n", client->irq);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&client->dev, ret,
+					     "irq %d request failed\n",
+					     client->irq);
+
 		indio_dev->info = &veml6030_info;
 	} else {
 		indio_dev->info = &veml6030_info_no_irq;

-- 
2.43.0


