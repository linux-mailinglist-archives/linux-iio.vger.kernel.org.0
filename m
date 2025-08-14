Return-Path: <linux-iio+bounces-22708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BCB25A13
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 05:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF98D889A7C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 03:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8A1F12E0;
	Thu, 14 Aug 2025 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1BRIVFn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AC3D6D;
	Thu, 14 Aug 2025 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143170; cv=none; b=Ldcol9aGmhxzmXT7vHR5nPAjGF6vaKwmpX9bDAgIuIMkr5r2KvkBxxNvNoCoHNmmzARO73GS4lkWRu+ZmlPvTV+I1y4AswRcGyXuv37F4DuYHcfRGke3n9SHoFSXuECug0ZK3v/6w5Jtm/HS/cDaXBMwRGnSn5wysC3lZByHuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143170; c=relaxed/simple;
	bh=SoCybG3RxH9DT8voZUnLlDQ0grdZZd96BaZUrq9N85Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJXW82Ui/MU/hQwyTwICdI7gk6NpHMIdQ5Hd3cee65uxIHPyYdJpkvZGnzSb8/rZTsq+D3HDRWZD1Gx0ZFp5EY8OIn0OJ59IA+N8MkUIV6SZAzOXcCQHRBCjQMT2GBsZ9iBhoyevBtS48bFxR0tCFeGPa1ddafpdy17pzpRvyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1BRIVFn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445824dc27so4138515ad.3;
        Wed, 13 Aug 2025 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755143168; x=1755747968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9KEtNPvnqPORiFNnpq5rZwSW5K9PoES//U7K/xZsS4=;
        b=H1BRIVFne53wY7/4nerGx34sAUT1oEw8y0cUU8xceyCIF6YXti6sWq/LqUCzv0JXLi
         iCsRWsKrZLRUrrOZe+ZwMQxmmmeNlpyCeE76UnGHIVLGgcGIQ7yC63mmO0M4JXsQ5lz3
         OshcNq0ptomvx1MJB88XGOfukhHo8OlXesGENLq7BUAO/FxXuUKuT984Ksb5K/yhpX1x
         nI3t/hSdWcI2dBvrkZxjuW6xbds18QgFheu9UspiQkEp/X9PUFq1ovVjoF+SqXfftBCg
         I3joWkEgkQYe+4w2F9Ogr1e/37cSvotLBEVAZEpoSeH+VKaSj/fdMCz+uqeY4n6hPBJJ
         hJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143168; x=1755747968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9KEtNPvnqPORiFNnpq5rZwSW5K9PoES//U7K/xZsS4=;
        b=Z11QE8gvHt0t2MRiIQlZ8MddCvGHwOS5v/Lb7rST4hsI39LE+wEOlK0hYdefjzhkA5
         FirptqOHVT+HY0YbuSCdN8QCMhh5IJO8/z5l2g5OmFoa1Fwj63xcpGEjNQoWN1q6yNJV
         4oEYUBKwCYCnd3vTMrJJfpjbMQnIqB0io5JEB5/YidftiQ9wXhrURj2ckdpT5Ce5F6rS
         2PEY32/I5M9SKdg/BBvCPYYwv/JIyFtirtDaZmLi3JvfK0AH3MWDxdXu+5lMSHSMnVjY
         SmFhWLj7vXO4CsOBjbYQbwMbqhVZqNlBX8rF2aTyOzfdC5dpCNW2sX8O+YvYzc9WnvaR
         +tIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC7W0wnqE5+dcnzl82C9gS9/W27w9Fj9kYa/ad5PQBCFJURUyHeR51vWdgslKziW7hN8UFXzELpkPYt3z/@vger.kernel.org, AJvYcCX2rvbprLa170LI7wAso1H6zmYSXtT/hhCwF8IEiUKe40UP3jBPjxdF4W7EyQzZr6qExGZMESeeG2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SA1H051BBrWSC8/8jvVgRReVO8m23F+VOqf7wgmho8D/NmnL
	9dZqBBlQPmZg77TBXNzIzw53QiyLAhtEvUBOnmjsPKDpMHs5KoNWNDt+
X-Gm-Gg: ASbGnctdU18iPsfbcKSsIyX79C0d4Nz7+8Wp7eXM2fwu5UVLMs8ItwN6zEwczEgsXUT
	bHzcCvJ834UltC6PKuZeLHQ5X38m9Txmwba2Psl3bwL9WOh99+kujLR0Od1gYfdqOa7tTDRKJjw
	CU+4yoLt8frKau+H7QTgt/Ejxf5hdrRHAJFTUF92j+Bu5ZP9togyJmtEOjMDQcTgDi67odBZUv7
	IyQlcrx7AgWfpST63BOiIKGESG6J2igajcIyi64cMFj93b1IAFQWs11s7rwdFkLdCmXn2mB9TBt
	WVIUD9NupeZ5d/i5moWmbRbj3mK5W8ZqaMSZCi8JA02xxIJ4x4zg7GVBghJWyoMw+qxQPulHa52
	n++gYPqXmN/q1n0HRQBjjQ5zJKt49MZ6LP/v3Kojq/7WC
X-Google-Smtp-Source: AGHT+IFhiSif59h02ASAFmjymBOYhKlCsKDnTRp8va5rcib9l7OdRsfPMCGKQqzlKZLW5FNUZa1+7Q==
X-Received: by 2002:a17:903:1b6f:b0:240:725d:c396 with SMTP id d9443c01a7336-2445868e731mr20075115ad.34.1755143168068;
        Wed, 13 Aug 2025 20:46:08 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.77.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899af03sm336927765ad.126.2025.08.13.20.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 20:46:07 -0700 (PDT)
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
Subject: [PATCH v4] iio: light: ltr390: Add device powerdown functionality via devm api
Date: Thu, 14 Aug 2025 09:15:43 +0530
Message-ID: <20250814034544.93331-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset() to do cleanup when the device is removed.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes Since v3:
-----------------
- Removed call i2c_set_clientdata().
- Modified changelog accordingly.

Changes Since v2:
-----------------
- Replace i2c_client with ltr390_data as action parameter of devm_add_action_or_reset().
- Place i2c_set_clientdata above data population line.
- Modify changelog accordingly.

Changes Since v1:
-----------------
- Switch from remove callback to devm_* API for powerdown.
- Modify changelog and summary accordingly.

Testing details:
----------------
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

 drivers/iio/light/ltr390.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 7733830dca67..2e1cf62e8201 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -680,6 +680,22 @@ static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void ltr390_powerdown(void *priv)
+{
+	struct ltr390_data *data = priv;
+
+	guard(mutex)(&data->lock);
+
+	/* Ensure that power off and interrupts are disabled */
+	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
+				LTR390_LS_INT_EN) < 0)
+		dev_err(&data->client->dev, "failed to disable interrupts\n");
+
+	if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
+			LTR390_SENSOR_ENABLE) < 0)
+		dev_err(&data->client->dev, "failed to disable sensor\n");
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -693,7 +709,6 @@ static int ltr390_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
@@ -733,6 +748,10 @@ static int ltr390_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
+	ret = devm_add_action_or_reset(dev, ltr390_powerdown, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action or reset\n");
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ltr390_interrupt_handler,
-- 
2.43.0


