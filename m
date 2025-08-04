Return-Path: <linux-iio+bounces-22294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A39B1A99E
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 21:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF9118A3370
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D5238C08;
	Mon,  4 Aug 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuCVKNaz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039041547D2;
	Mon,  4 Aug 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335536; cv=none; b=nmWyXRr4Acs3zH2cxlaLTBpP134evZnYJMat4ZIbFOQsjw7DPIGqL0uN/pcoepwh0Qy0r8DRLwCDrVJEyHrnnwYuXZTLbHL3C9Ib1n55uCNLlrN8hMHCUa6rTcmDW30kir3W0a8IgdE0GWwIsRFIbJCoHsKIgP+qpFZXKucLdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335536; c=relaxed/simple;
	bh=pT51uZ1AD2Vi0tN1qYNNpZVMDAXvR8mTgEEdc4Wf1+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuPgS/XBNL8ySoWgMz6CHsjQ5sznVn8U7zw5dbFpR4G1bknD9oQMEXv3E4oyDz3Ssqk/KKDUMK59/DgdFCVN1owHl57bVa8B+sIJ5NrHJns+HN7Xxr4EJB2CohMEVpsZRKuRQgusDFvB6rjPuFmNALu1XHpcFqI5HdQFw/rQrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuCVKNaz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23fd3fe0d81so43997245ad.3;
        Mon, 04 Aug 2025 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754335534; x=1754940334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmFvByYZ/o68+N83+lBpWj5txVEeLYFU29qPXeHQBrI=;
        b=UuCVKNaz8QOU29vTJlgTjE6CNoja6Riu1EyMqkGZr002oOqE4RqtYshHjanGPFXwcD
         6nktASM9aelRkupKKu11jev/Qjycto2VbadwBkc2IuiN4y6IR4zchPJG7C4Yma3xSy49
         NYOfVuBlblzeqgyMcgBio1EyF4n0nPqoE3GlSA1EdLXIK8MW5cv0KYAb0K0dTg87KHXG
         DX4Poj6ZxS4BujYGS6ZEYVjRY/yQLcSJ+AqSz/yAl2o39cJNre9YBN/k8tJckRSsD3Xm
         S9rdIqb2UQxnHm85KY5QT1UteABfAhUl4DMrN5MqHbAvtncwcPG2Wd0e75eXS5QMsaY5
         Guhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335534; x=1754940334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmFvByYZ/o68+N83+lBpWj5txVEeLYFU29qPXeHQBrI=;
        b=JRYN8NqanBekJfbGj3gg1Pymna3HKe+wod+6ScP44uH7tXEiOQz2ugXGqV7mBUShzm
         qWBY94YfUjF7TlDZ1xi5GMOSaQMM+M3sHVZpc6SlbK1kPiMF+VptFw/AiQAGaW4Mv2KB
         KsewEc+KDz0/NVRzlZ6iieI97+A1gSNU2n4pvMqhA8HbeZuk6t9LECPP5IEGnJB3f7k7
         vyk4x2aaCDkLRqdd9sqtaIfBJBQ6uoUQ+egxo66vTL8r+ue0GSnKHyrUf2irSVx6H23O
         E4fjXlrlYeKLoVG0oTEZ2P334bJmaHAiFBnKP3SyZOhG29Tp1/b3f/65+nOSHaiv9jEF
         8tSA==
X-Forwarded-Encrypted: i=1; AJvYcCVjVxvAC6aZH1vZzcCOB5GjNWHnRhvK2bjskYMpQit9pNU81ePJ8/3HbRwFATd4hbE3tlhg49gyyRZAuQeY@vger.kernel.org, AJvYcCWCSgGYo6wq2YJVzCWV4zTU7r4fqUroIpyvdfQBHgcARlPENTQvP13pzIDvz0VgGxxtWDyHQUCiq0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxN4Ou2yFWvFy5v1M0bXoWGRqDFae4fuJAGcwn9AERtHC7w0Pk
	cyVqPONK4O/uf8ZkY4QP+aBboKHIsSxa5xyRcqCQsb6drr4FyoaHjAb9
X-Gm-Gg: ASbGnctWDMp7ePnhF0MVuehKeIZP6dQG6X4L2sq8K5dvF85r1R0wXa2Pj6VD9KxvvSB
	UO1VhcPDSPg2J3slRUFfgn7qk6KUPYKmjyehvqpj7iPvpL3UHnb+xt1t22Odgnj/rJmBcVdSGfP
	vCem/bCwxe1XMN7fEZNtKWArPq8a7CFXC5ViVZ0wcX0WFXD4UJhhHbBHObDIexLZfy1zCMLrsft
	fpNG471ojbE2m0yD5SoPdtkao7N/uxXR6BJGV7BlZE4AJjFnatr7kZijtKMrr1x8Bh2z+ib+QKz
	zCE+g/C6izYonjbVwPZLMuRJk9wAal5lcK0+OYYLO3iA+FS4j5oVf1ENFkI2zpopSjXTOrtm0Vp
	kAQ/vjO/FUu+qL/vvMHItGm1YScH4stDg01E=
X-Google-Smtp-Source: AGHT+IEu3nxLyVsoc333N2xdCcRkA9MPY8SdhyquiofjQyp3Jp8Y09f4z1T4MhyvUVsfvRQeVoDKmg==
X-Received: by 2002:a17:902:c94c:b0:242:1b:7f05 with SMTP id d9443c01a7336-24246ff1f80mr159978375ad.24.1754335534135;
        Mon, 04 Aug 2025 12:25:34 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.77.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6825sm116079975ad.30.2025.08.04.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:25:33 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: anshulusr@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: ltr390: Add remove callback with needed support in device registration
Date: Tue,  5 Aug 2025 00:55:11 +0530
Message-ID: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the .remove() callback in the ltr390 driver to ensure proper
cleanup when the device is removed.

Set client data with i2c_set_clientdata() to ensure indio_dev is accessible
in .remove(). Replace devm_iio_device_register() with iio_device_register()
and explicitly unregister the device to align with the updated removal path
and follow common patterns used in other IIO drivers.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Testing details:
================
-> Tested on Raspberrypi 4B. Following tests were performed.

1. Sensor and interrupts should be disabled after module unload.
-> Before unload
akshayaj@raspberrypi:~ $ echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_either_en
1
akshayaj@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_either_en
1
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x19
0x14
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x0
0x02

-> After unload
akshayaj@raspberrypi:~ $ sudo rmmod ltr390
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x0
0x00
akshayaj@raspberrypi:~ $ i2cget -f -y 1 0x53 0x19
0x10

 drivers/iio/light/ltr390.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 7733830dca67..af1b04c8524e 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -693,7 +693,7 @@ static int ltr390_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-
+	i2c_set_clientdata(client, indio_dev);
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
@@ -744,7 +744,26 @@ static int ltr390_probe(struct i2c_client *client)
 					     "request irq (%d) failed\n", client->irq);
 	}
 
-	return devm_iio_device_register(dev, indio_dev);
+	return iio_device_register(indio_dev);
+}
+
+static void ltr390_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	/* Ensure that power off and interrupts are disabled */
+	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
+				LTR390_LS_INT_EN) < 0)
+		dev_err(&client->dev, "failed to disable interrupts\n");
+
+	if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
+			LTR390_SENSOR_ENABLE) < 0)
+		dev_err(&client->dev, "failed to disable sensor\n");
+
+	iio_device_unregister(indio_dev);
 }
 
 static int ltr390_suspend(struct device *dev)
@@ -786,6 +805,7 @@ static struct i2c_driver ltr390_driver = {
 		.pm = pm_sleep_ptr(&ltr390_pm_ops),
 	},
 	.probe = ltr390_probe,
+	.remove = ltr390_remove,
 	.id_table = ltr390_id,
 };
 module_i2c_driver(ltr390_driver);
-- 
2.43.0


