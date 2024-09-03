Return-Path: <linux-iio+bounces-9057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB0969265
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 05:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DC81F2349D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 03:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5BF1CDFDA;
	Tue,  3 Sep 2024 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQO4CQWK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73861CDFAE;
	Tue,  3 Sep 2024 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725335846; cv=none; b=jjHeVDW3imWD3xOfnfdR7vvOHDlkxz5Sv14W3t6sumyI/RIDfTkBdFa69EYl0++zpn8F6pYN2Q7F3toF0qRiUjA+BPr45CGoQSEOW95266QEBTAqq2G7GA6tXoJt2QbjPHR4SvljOuFuc7aG3+KfhC25xpi6ww/ZmpFyIFM6pWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725335846; c=relaxed/simple;
	bh=Fr8OpO3pInva+n0odfLO1pe4AXIoe7xZoCq6yMF63Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL9GYdcWv2N8Rx514ORLQ4sQIwsZpSvNFscNhNSL2wk5Oox/2impYFtBXpRwRQG3mEHPZGko7oRRlI+7OOicTv5Wc0nCd8NussItICrdbsaJauYxAiqG8fLrhQGpkwlacJQjtNwQTP73p2DP2XE1chT4G/J0zXmKt12sRzhM/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQO4CQWK; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277fdd7d468so627424fac.1;
        Mon, 02 Sep 2024 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725335843; x=1725940643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yamzlvp+sBiLht08ddSodYih1n4CTjg4h+6yXqEB3Fs=;
        b=IQO4CQWK0WGd6m5Jkt5dpH1EaLgLjJtqJahJyP6UMEZQQZKjyU7hylwY4DHHf39v3Z
         +gJKstk6tmgjWAsiZrUgmvOG4tf2zgxqZ1QFW8V8D0hpSIGZ6O8RBlcA1kO8FzFJqIlL
         hStucAg0E8lIrWKTU+smURR9QlTN3dVVSa3R2jyOxXfroBI/crd6xgyYrRrmLXuo3oSa
         9ggGvjQJg4g76H/6zRCdNf8mY5E+UAwZE5oAGZ8ayxX0knmfppB5vgTIH4LzGQ23Upr5
         7IYPUKZMSiXl2RfC3M1IzdaKJdU0vVpyO89+hZ/vNoyLn/cdxU/d/JLpfTolp8mZ8f6x
         QGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725335843; x=1725940643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yamzlvp+sBiLht08ddSodYih1n4CTjg4h+6yXqEB3Fs=;
        b=RQLFV7/JE9IUimf7Scholv8lqjEPondBiOtzXnE16zQUJsTSfBB2VBuTmaJCsIqbbX
         KacdD+u0CrTsUPH1OzYjPW4VWRrV1Id1uWM6ZHN6xB+G3E4PzA2ksxM4DX1nIWSLKVBj
         U+oeVzyIYoWZC1rXjzkHYOmbjLh//JumlPWRLWltFqV/JZX/xrrJSVORS52Ujyq+dttl
         /F03Wh56dt16LEBUIn76d397uyBnQ823b/5TzkktOacPd7BY0xnuxZQSgLUha8LUOO73
         NSgn6X7YH0aNmvODVMZJF3FRHFPAkXGJoAH8gSL/lsk8iXiAPEjpV8mAGcqzxD6u8LqM
         bycg==
X-Forwarded-Encrypted: i=1; AJvYcCWlKCHpzjsyrgsWofeF5XSlB7C5UZrR37n9F+ybWyddqdeaPrJBF4wHWykMG6oMdFYnYuur6Y5P11/mhfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6kK1S8SmWdlrEBioTXHMXp2yvObz65se6XG+ifEV9jlk/DuN
	n6OoTtuv/MRfbs2lkN3Hy65lNkfQVheWpU9HveOOzu08G6ssAhRuR+9xhCqd
X-Google-Smtp-Source: AGHT+IHaniAv1rZbRFPapk8xmn5NFqwCfeMA5p5z0eNQ0bPhmR1/G5+vkvFznCJAv2HCHYoz0RSh1Q==
X-Received: by 2002:a05:6870:bac3:b0:277:ecd2:7b7 with SMTP id 586e51a60fabf-277fffc1867mr4005934fac.7.1725335843339;
        Mon, 02 Sep 2024 20:57:23 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7d22e785333sm8329421a12.56.2024.09.02.20.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 20:57:22 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 1/2] iio: proximity: vl53l0x-i2c: Added sensor ID check
Date: Tue,  3 Sep 2024 09:26:35 +0530
Message-ID: <20240903035636.9559-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903035636.9559-1-abhashkumarjha123@gmail.com>
References: <20240903035636.9559-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit adds a check for the sensor's model ID. We read the model
identification register (0xC0) and expect a value of 0xEE.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 8d4f3f849..31d6aeb95 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -39,8 +39,11 @@
 
 #define VL_REG_RESULT_INT_STATUS			0x13
 #define VL_REG_RESULT_RANGE_STATUS			0x14
+#define VL_REG_IDENTIFICATION_MODEL_ID			0xC0
 #define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
 
+#define VL53L0X_MODEL_ID_VAL				0xEE
+
 struct vl53l0x_data {
 	struct i2c_client *client;
 	struct completion completion;
@@ -223,6 +226,7 @@ static int vl53l0x_probe(struct i2c_client *client)
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
 	int error;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -237,6 +241,13 @@ static int vl53l0x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EOPNOTSUPP;
 
+	ret = i2c_smbus_read_byte_data(data->client, VL_REG_IDENTIFICATION_MODEL_ID);
+	if (ret < 0)
+		return -EINVAL;
+
+	if (ret != VL53L0X_MODEL_ID_VAL)
+		dev_info(&client->dev, "Received invalid model id: 0x%x", ret);
+
 	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->vdd_supply))
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
@@ -265,8 +276,6 @@ static int vl53l0x_probe(struct i2c_client *client)
 
 	/* usage of interrupt is optional */
 	if (client->irq) {
-		int ret;
-
 		init_completion(&data->completion);
 
 		ret = vl53l0x_configure_irq(client, indio_dev);
-- 
2.43.0


