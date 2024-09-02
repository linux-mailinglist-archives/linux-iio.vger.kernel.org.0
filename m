Return-Path: <linux-iio+bounces-8997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACAA96876E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79678B22B7A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71CC19E987;
	Mon,  2 Sep 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJLTPdD0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8719E96F;
	Mon,  2 Sep 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280002; cv=none; b=S/GKBJql58iw7KCw7UELfZG64x2L/ezstD5I2DppmVOg/Pp2uwax8mIFw7SNLHaiiJZwNMepX8AZMjrTe1Kmpz9rvAD16n1Y178CYi0C00WNqkct1vEIfW9/9ypJbD9XE9eMUMaYEyYAL/DlMb3wdrwp6QX7MCXdnBb3/7Fnr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280002; c=relaxed/simple;
	bh=Fr8OpO3pInva+n0odfLO1pe4AXIoe7xZoCq6yMF63Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPfHjeD6f7/UdUN6bdQCpfoQKHDnlFQj5/b0F6QRbQFCCA/zkYn0mVY8obcP8eWLkgTqkpJtgzN/deMVxfcBZi7l/ixE+LX2PS9zZqfOnvPrAgJRw8JZYR/P+Te5QSiJd0ke1UTBp6xptdA1gc73bEGGOP6o66gXHQDxVtrD9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJLTPdD0; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5daa93677e1so2610996eaf.3;
        Mon, 02 Sep 2024 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279996; x=1725884796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yamzlvp+sBiLht08ddSodYih1n4CTjg4h+6yXqEB3Fs=;
        b=GJLTPdD0uUTWuWhaQwPhPCE022o1nM9wQzrTvBsgR5hibBCFYDnHjufSOXnEWG7kql
         jXnxx8kpfpoFb4g/20Fgs8PPaqEwB2DoM6W8PLRm5ziwf8GaqyZqPqzi4oNTsPGU1b+C
         Cl/sMRpCDyM0Cy4vooRyiQpi+6X28OVRjZ2WphYLxHc/L/vdZAsnp5zhMmoPBIKjiI48
         OG9pR4gumAHlnEbc500mV8f5ZsAQ1gQKMqlDzWZ0J1XtMe9q6Pi206uJ0DBkUUvR9BP8
         sBR47IuC1+Hc56ie3BUgIUVdmLKYucEEVxwaWBElGRWtM+wKMOngalS/UI4xwi1DN2tW
         ee4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279996; x=1725884796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yamzlvp+sBiLht08ddSodYih1n4CTjg4h+6yXqEB3Fs=;
        b=j/YrLnS4KrqLBoJ8YSrZk32XJY1l0Q27wGpjpdFXMaLGmqfk4yxEjOuUuL4fJwQcL+
         RgRMQyFXKCzBTO0ajIKYorjyLojDlOetHEQlQ26GPqj+I8fErrPjStMLZn/sthk48nWG
         bQCa82HUlHBUA/JjIZ2l/8TBhEWI5CRQgKm8P1jlJnu4RGoc+Z+RvSTVKbWCWWLAg+YD
         FzIL/C0QIRyT0ALxzaveqChlNDtre4WRkcubO0VoAzxAfAzS8rXpAyw3lBX9QVzztAn0
         EVvkWbEjx/UCYzPKxOeEwMRQJQvn/OMzT55uGjBUqwc9s9HDeMNCBX/5VWMNZeGcsyQQ
         VBcg==
X-Forwarded-Encrypted: i=1; AJvYcCWzGQC2eyE+/kRZsLHh7dZ+AHcHNz3Jiqu6hYmiz1YqLJtGyxJwrhYY+NOcdIO74mjtwZNfk+lri33RPnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRT1SDdG/fRRwQvcrgyKw0AaNwWn/ZoUfgVUxlbVT8Q3W7bBw
	kBSoRG6ueqTHOckLrm7lissy5fKexNQAWd/gUc1lfK9uQQ+nAmPD/v2pR3lP
X-Google-Smtp-Source: AGHT+IGm8VZa934lBH2JOCCzCQyDp55MMJH1rO+OT44p7RK+IXfoBxcHWQJDMnkfX0kjobbD0D3tdQ==
X-Received: by 2002:a05:6358:9496:b0:1b7:ec34:7139 with SMTP id e5c5f4694b2df-1b7ef6f9995mr849954455d.23.1725279996374;
        Mon, 02 Sep 2024 05:26:36 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e575b7dfsm6789541b3a.190.2024.09.02.05.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:26:35 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 1/2] iio: proximity: vl53l0x-i2c: Added sensor ID check
Date: Mon,  2 Sep 2024 17:55:55 +0530
Message-ID: <20240902122557.129013-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902122557.129013-1-abhashkumarjha123@gmail.com>
References: <20240902122557.129013-1-abhashkumarjha123@gmail.com>
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


