Return-Path: <linux-iio+bounces-8899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81984966A4A
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 22:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB2528482D
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1781BF330;
	Fri, 30 Aug 2024 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6YuqOc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A91BD503;
	Fri, 30 Aug 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049033; cv=none; b=TDik8rUCBrlkyZDK2Rmeq+mFCVwmMzzX+BTjBZzn0BroOnz58UmTW1zhLUvQyqogqTZKr/SmFePOBFcGbDN+gdJuAR1MaiAkgjZKUWGJ1zXuWtW3aIau9ZodSo47Z3OL3dTkCq35XljhB4801oKiZyNbPrUdjXoyOEViUr+zwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049033; c=relaxed/simple;
	bh=FtQB4eRlURsdLorLAN11Um1AdZ7GI+yphW6uG1KZCRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVG3nE5lpYJfD/sLaeIBQdyWm1CIdlM8XPvKG+hAxuRm4DeJWujXfPaUl07DhRTCsIDK/OcUctDSMbI4LPMlULmRnPBxHQHmWSy5PVMHtUjPQ7Z/qhCV/5Pp+OsEs7MXsKL4Y73S5C4wJVTJU4433jw4yus8b591XhgZtAkRzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6YuqOc5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714226888dfso1859783b3a.1;
        Fri, 30 Aug 2024 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049030; x=1725653830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhoIbh0jbk7zzRX7G0VaVBoQVyOigzSeO5Rn8EjIAQY=;
        b=Z6YuqOc51xZLSxYXOaZZclj/ekF/ZlupN9ACzIM9u/ejGFlC4JD3WS1xU961e5xoZS
         0B0NJN+4QDHp5eQe7A4JICzIX9AD0nn3sVDlIt4PA4hACca5mTKTc8427NiT/U36MY5q
         PYcL6I/LK9TVrBrFzNbaNZea/wUZiOiaTvBMSsVXj+3pNFSf0942wnv8g4scFSicihOh
         +ahMXACbvZZI6hVRrnzlXdCu+XlL14hkPC5R3K/ApXYw4weptI5Cx5LdntCCUCAMw+EJ
         6aTTnfMgMQoomNbOtqPzK99MdVMYAAvTWGQJImwogEPebNif1tmbjob/Jj5Gj5ke4X6E
         EKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049030; x=1725653830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhoIbh0jbk7zzRX7G0VaVBoQVyOigzSeO5Rn8EjIAQY=;
        b=wPYn8TpTSVqEdLKqJxdr3PN5XmZJIpXd63/zY1pBPDdem6Y9diJCgBjcHERj8riv0/
         byFRwEXyzrFD0btJxgXjaltnFp2Ow+RLtCr3mwexf+DFPHEflkH8ShhgNBQPEXvBQlVt
         gPW+MjApWs0e9E87J1xTjqp/SJX1Qbf/R3vzZ+A5vgm0RYylkJrhhtTkSfA9zllSGtDE
         o8z84h0c7SrLgwW2IelR4XdFROsLlBZuiS8Bp1zaIrvcH8vrSDWHTBkxJq2HHQp1jjoa
         IL79r9JefzziDcdFMlMaZtXk5lT7dI/IVLGtWGDUaNvlN2KtDee4ZIv9IdXTN4pZmExB
         55Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUr+AGl0P7ixn1gne+gyqaAC9CyCj/HXJ4yfl82oxyCTQvUETuV2DEEuGGXM5rcM4WEH8lXxzGzxtt1lIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMd52LtHhvi0ailY9kRgBwbLtU4Y0vxfFkydV3Lfgbg7DjqfRu
	9acOUzwPDYzfjGvybkbxGiVzqs7qO5fZEF66C0Sk0vpjW0C48vS2dC6aHq//
X-Google-Smtp-Source: AGHT+IF6YrWJ0OeuN8M/KkQiFn44MDFRMKfb1t24dErWx+/7RrTPEFKDaSspDdeLI5oIaSdlkGqWJA==
X-Received: by 2002:a05:6a21:78b:b0:1c4:7d53:bf76 with SMTP id adf61e73a8af0-1cce10aafe2mr7423902637.38.1725049030464;
        Fri, 30 Aug 2024 13:17:10 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([2401:4900:608e:fa44:845a:20a9:791f:c32b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e56e5c23sm3257476b3a.172.2024.08.30.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:17:10 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 1/2] iio: proximity: vl53l0x-i2c: Added sensor ID check
Date: Sat, 31 Aug 2024 01:46:25 +0530
Message-ID: <20240830201627.298264-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
References: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 8d4f3f849..2b3dd18be 100644
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
@@ -237,6 +241,11 @@ static int vl53l0x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EOPNOTSUPP;
 
+	ret = i2c_smbus_read_byte_data(data->client, VL_REG_IDENTIFICATION_MODEL_ID);
+	if (ret != VL53L0X_MODEL_ID_VAL)
+		return dev_err_probe(&client->dev, ret,
+				     "Received invalid model id: 0x%x", ret);
+
 	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->vdd_supply))
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
@@ -265,8 +274,6 @@ static int vl53l0x_probe(struct i2c_client *client)
 
 	/* usage of interrupt is optional */
 	if (client->irq) {
-		int ret;
-
 		init_completion(&data->completion);
 
 		ret = vl53l0x_configure_irq(client, indio_dev);
-- 
2.43.0


