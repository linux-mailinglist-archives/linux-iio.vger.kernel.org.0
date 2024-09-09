Return-Path: <linux-iio+bounces-9375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1097151C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABC41F239C7
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E21B3F08;
	Mon,  9 Sep 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY3IbYYD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB5176FDF;
	Mon,  9 Sep 2024 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876975; cv=none; b=hIx3FQScTRPTTY7jst+Ad2FG5F7l7+QFXrUe7vtofLjtkP2/1N5r9WGXbaDTrLWjbVysYmx82qaF0jZDXWEje2Wc/dIsneG87oZuyBtt5GcpLOI8sqk2tIGFXkvwcSF2hb10jVMNdo/LSkH4wl/VbO2dTAILzu+Pm5ByLDYO8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876975; c=relaxed/simple;
	bh=G38sv4XR3xasP3+tvojck46runUd80LpWHyyBF/nHAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB1M14xT1tFAf6TJtuUQO/5cYBz1kMts4JXfi/wblHrmnZio/cv+RL5+D7D8m67bLDn+qwVINriY4/HrHb52dw/VClEtOZMWnqSiOI8oNlkHq/z0M1gjpUEVSvW13PIo6jGJbdUZLJ9FJFk0xrgiCPxVAuEoK8eCG8sA1R8yUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY3IbYYD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206b9455460so33555035ad.0;
        Mon, 09 Sep 2024 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725876973; x=1726481773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU1ncfdHT15Ic64HsMbCwYVyILFDii0TETAChQZx3hI=;
        b=mY3IbYYDsaddUd03L6ixNgt333JETcwggrMi+ZbS+uS7FTiMVOR4Z8hMiKE7BwV/ZP
         yM0HNLcgvP61+yJuMPS2jKnYh1Iccyn2/W3SFXz0CCK6BUNT0aSB8xH2xYWMxthq8A9v
         vbTH8nXoPhLY6qMFBkndXmirX7yhgqSMU/csbb65zhQdzFO5wq5ge10/4eO90m1soZc7
         byUoqNDnERqgERlr1C8pNjOGmjJ8fdZT7y3r4U6H8x2OWdVQzKMklXZlLmVuya3i0V3x
         3YE9xjEFhGymcoNtj/wSs8UvcdLn9qKatpVxTQdbwYFuwxRYm3gc2cFd9bJGFMLlUFqC
         l24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725876973; x=1726481773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU1ncfdHT15Ic64HsMbCwYVyILFDii0TETAChQZx3hI=;
        b=N4NK02ViHBkE/SGkjU7kHB8eu3kodmfaAznpKgWSswEq2Im8ePGSb84tK3rxEfNrCZ
         fZ3p/hT3CXhaZyxIoxuE0BA83mrixdOfLitl3nUK1B3pvPXHWN2lA47RXyUqEzbKOcJs
         +t6h8ELIuesgNMK/YPhA3xcMztjuf1o4JATOol6VGqbFjTA2iV29ET7J1pNi2MUL6QcQ
         h0/sjrMrVeIH/IFcUO5bmoJnYec7nhIlUN4FLEa5yxuqUPxGKsNvVVHbq7BQVxc+YI2s
         MRNbqBy55AWuRA7hgdXw8nkOZG7I97C1ZgQuEXFzkPZnFgUkwUUIgsXJ8R9WysHobBL7
         oJOw==
X-Forwarded-Encrypted: i=1; AJvYcCX/CuVITE5ySdHzjdGcM+2OSyCu6CZQQ/190FXJfo31dTDnn9dif9T+BE7iJ0AZoSZPt4rKB5vscG4ighA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BSSjk/UJxXEOvrG/m+AuIrQnU2TfHWVroOz5UlwS2bEBjWfC
	G7e65gmWfqqeF6BeYdWp/ieI/Edf3A1JD4qovh+qLJZZtt+0TcihQAPuS+ey/B0=
X-Google-Smtp-Source: AGHT+IGuDmkIAHFb/Yr5TECZLAkE8FTYj9iiAYknnv3qac0W6ciqlKSMP5WDNwYfjCu6Ri4kOnPbHg==
X-Received: by 2002:a17:903:283:b0:205:656d:5f46 with SMTP id d9443c01a7336-206b8461b10mr284684385ad.28.1725876972630;
        Mon, 09 Sep 2024 03:16:12 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710e33456sm31219885ad.99.2024.09.09.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:16:12 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v4 1/2] iio: proximity: vl53l0x-i2c: Added sensor ID check
Date: Mon,  9 Sep 2024 15:45:06 +0530
Message-ID: <20240909101508.263085-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909101508.263085-1-abhashkumarjha123@gmail.com>
References: <20240909101508.263085-1-abhashkumarjha123@gmail.com>
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
index 8d4f3f849..3f416d3db 100644
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
+		dev_info(&client->dev, "Unknown model id: 0x%x", ret);
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


