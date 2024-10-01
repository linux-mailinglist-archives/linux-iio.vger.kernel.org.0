Return-Path: <linux-iio+bounces-9977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E860898C6B8
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA138284D3A
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1B1CEAAD;
	Tue,  1 Oct 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDKJW6Qq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D01CDFAE;
	Tue,  1 Oct 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814108; cv=none; b=Paqu0bOoeYjMuflL7TdK+bF/gGBf+1Dlrip1dbAzYGk6H3JbR7vYjbd9qZDXApjn1QunwTkw9UGZmc+Pdb3RrtN8+ms9di65dQsF0Wro3TV9Ylb/agl5owO2w13aFzXhQOjMLOZLfMIGncqz5JYgnfChWvTxz3Cz5Cg3pbIMsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814108; c=relaxed/simple;
	bh=iCU63FBzBRIP83YwKMMy/0f2h/0RPDJeJcQgqOrF4G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GB5jq80/VfYgXpUNouYRqL7QS9CurKYBDBuFyO+4DOMXQZw94SxJ8+zHVNLCvTwcXhOrxwszmUqlWqvf5kIvAkI6NjiXIoaMo0uj5+V233q+dA/p6hRkZh14JJY0zyEcIywT0J2qpojNFn7l73rvvJ1RCoa52OZDQ+ZFdgVA/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDKJW6Qq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccd81de57so116006f8f.0;
        Tue, 01 Oct 2024 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814104; x=1728418904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1SEf8uN32PzFnwgT/mEmooqPepRUwIPluKBDrqdS9I=;
        b=lDKJW6QqgLjYWgPBFJ4y426HouvSH4zu1Pic8ST61rbPl0z7HHwnFbkhD5pDp0NUdM
         J1uD+2/LLX+/ogEkXyXCUeeWQ7yRI37hElr2l3wqZEC5GWvBWt4LF/byt+iqnIzfzW1R
         IkdOS4l6VqtZcX6rZ/i1fdDJivIem2hilkweMs9Emsbxwwd66Ipu9g7rBHSBGRokhjc/
         mq7gral5xnDsEX3Hmg744UReOJhrOSDONLD2+bGD7cDtNhXUYUG93cnuefBgXxZSDjKg
         HZRnu24mBbw7YvMyATQ/bT6YVFMfdQ9tS0XIKPXMRinnsjrmXbBDmVXmpELxIoANpGtX
         Z0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814104; x=1728418904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1SEf8uN32PzFnwgT/mEmooqPepRUwIPluKBDrqdS9I=;
        b=Kl4KgtY3bWwUadLYWYjmXHhJlpcZhvSvRmFhS3GW7qUD5aZp7NjR3L63dl95lgXZx9
         n+pDnKIfs/dfkYRENyhhPwrK8+j6GirRPLLT7fElAjMVHaqQmG/U9U+zFfTJVGSaMyb/
         74r+8gkclenDHU5lKOy26+vc/wYS4RaNMftJAGbFz36rZmpvPq1RJ7A9gmusOH2uOy62
         367dFVKoeawUdkQ16cEDEjQNfkDlHqdAcyby2W+WCI3TQky/SzIAi7jjcUxM0dxtgei8
         GbR46neJWTwQ0wjIHt2KN+WZ10S5vvDiRYTanU3UmGoowMD1jEmJq9MUuBuwO+WYmDD5
         +erw==
X-Forwarded-Encrypted: i=1; AJvYcCV6g435CK9C8JjRGySQpbSTkOulpxHPjaHZRWOaHE8LdEJtSUKKjoI0JL2NYi6L9mFcwnAvifNFdGwL8Y3i@vger.kernel.org, AJvYcCVcIzjR4ObYyssygsnrAp8W94KBOu6k7e4gHJc1uMOb90vrLMMV091AT4K0a+7rgyMtqnwDR4uPLQbc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkfe8OBe98xLb0tR29SET0rdoDQocEX0QgXM0gi80SC7epZ/VO
	5i+UaeJg0J2iDVdJ2t6BbIw7Z/wXuJjse5JucJgc2PUhwwgKfYaPCvuRscNP
X-Google-Smtp-Source: AGHT+IFGy4ajxWqzarP6iUs/nAWdUhAafGtqUsMgD5Qk+xaq0E765UC1ylngMiNeOYRqaQGfMNapLw==
X-Received: by 2002:a05:6000:4106:b0:37c:f997:5b94 with SMTP id ffacd0b85a97d-37cf997631amr2424923f8f.12.1727814104135;
        Tue, 01 Oct 2024 13:21:44 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:40 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:15 +0200
Subject: [PATCH v3 2/9] iio: light: veml6030: use dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-2-d789f6ff147c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=4012;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=iCU63FBzBRIP83YwKMMy/0f2h/0RPDJeJcQgqOrF4G0=;
 b=eub0w+xwIZM+n9FKemH5HdEBO8RiY42VFgAxBOfb/K7xINl7JvNBS1KsSiZZf0WZIJhS7JSNR
 1ZRnGE++miNAKwWBID4aw6LaJQAozuxcqrIj8EF3S+xHbPAFgQfZhFd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the more convenient dev_err_probe() to get rid of the dev_err() +
return sequence in the probe error paths.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 72 ++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 94e38a983cf3..6646fe2e74a7 100644
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


