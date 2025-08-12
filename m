Return-Path: <linux-iio+bounces-22628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529EFB22E8E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5C4188A051
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D262FA0F4;
	Tue, 12 Aug 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQAyHCxw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1D2EFD9B;
	Tue, 12 Aug 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018461; cv=none; b=mKur/XSf1VgMdFSUQfQF8w+S8n+vmDLZNT77Vegn5spOiC1gdr6O8QPb2mjH6IF7Rj04E/+TcAhhycrFo4ddQBEAAWK09gg6ltuAhXPlScGdh1ogjTaC6TbQ/ZLumnqTVQOYefV/zkWeCafvnZgGBCBErgUb0Mm/z0988we0qJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018461; c=relaxed/simple;
	bh=5I5T6NT3xvIjT27mRfFta1+b4feAhQzOdh4KrrC6clY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0QuJMqkpSHzUzb4XjHyM+322LZfKGqu0BgrMLYhlJYRz060wCL6dXaWvsHxpFDZVx5cw5fX38BhrBBwyXRmbOjgBFlFLrOwglz0wU0eqwhkdmahJKDO5e+lePkIc/mN0ndn+ZhUtpYFjsR/5z36Mb1gq3cPGbPM+wr/LNkxADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQAyHCxw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76b8d289f73so5418362b3a.1;
        Tue, 12 Aug 2025 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018459; x=1755623259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiI5qaPggnwl6KII4CiCwm2S44IlH9sez1L/qTHY7Bk=;
        b=HQAyHCxwhGnWUVjmw7pBAS8vT9tIh+XDIaVAjBm9LNC4BXxnE+Dm3PORD6HvSaU7NI
         iIHHzWC04qtkFplZH2Eova6BCTAqqHfXAfrgnxrLyRpq2R1T5Izzuk7yshrFXdgYng+6
         HkCtpXBzFggNgJqYOwmD53sbvIZqFhJDbWbTNufuwgP0fgb6eladzjXjt7NLJBU5JtwD
         gL9JTvgVkpZXiXiPcA4jmDLbri1XSIZwxyYtM0lRKaSk13fdyGxJwt551ZExMmqXfmRt
         8kp+nsSDDQesi2jBOtLKNWuIeEG1eSqr7PixrEYnucLtJoTa4cIXlldNLOJH+THz2SXJ
         Qr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018459; x=1755623259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiI5qaPggnwl6KII4CiCwm2S44IlH9sez1L/qTHY7Bk=;
        b=cIOGrtv0IFm8pIUzpvpFKVtsvsheETkkI2W92zGk1fjPd2N2AlYQWRXfg2aEQecjWW
         TBu3Rf9MI0owp7D6k+nGaF3OSj/Ut38Vi7sUt7sfobxfWrE4bSQQIkliKUtyxauNRnNl
         rbFLofi3/YCfYLo5dgH4kz+NCjd+dBxTbDz1Y2jBgA85NG4KCGItCPZAQw+QZtJrZ5mv
         7rFtzNe8D13W1K/zO3Ijkli3SAin23w6H164N+HLoHSl9JcGNPcbQhMH8eWdNgJZqz52
         qCpYqAAF/KHAK5NHZ5u84gON2aWLFpItdgRKSmCDjo0jVSAHUuERcSsGe9oDbYcf3zx4
         aTbw==
X-Forwarded-Encrypted: i=1; AJvYcCUvb8gQfmiqHXnfhm8zZ4XRW6/+3K4Mg5ml/vI2FPJ0Ts53/znBPUIiCIR1p3lnZ14wnT5jBfFHGyg=@vger.kernel.org, AJvYcCWNlOKA+C05i0F/VBPamwoZ61LXDpmLSSi3y0KWbQnj4dijhdQncMiLuu1tK/28kT+JMHhJ0GtQx/JTgz8U@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSqKfXksDypOHC/KoA/3qZ50cyhkkO23axZy6lLGqqBLP913a
	vRdFdfbgUUNxAgOXf98TdH9gsKQn/roRP3SbM5Slst+kbcu/DDWxxbgU05YALg==
X-Gm-Gg: ASbGncuAl/HxjBZ19u9A5XKaRex7cOcnAW9SkIFLq4pV2eGlfxLnfrVORPlhtNlB0bd
	hyZgotYQbuvHfJDPe1f1BxzXxDtXZpwlolyZbyW1ikzBIbcBfd/wAmG3IYJA/NEWSjgMFjKF02j
	F7rjvow2ifazwMLOdUW5fGDc2ltYL5ZaXksp5ldiMV4qAjjjt0iI3XLf04LorHJu0FW868OSiTm
	EccL3W7YGAlVqyHL5Lx/EAH2U42XHgXSv0sa66g4zPS46dLeL6Mf2M4xCSBQsVPectDIAhpwBIr
	AHenN3AUQqgpG3bOrdn80FnpLJat33/cSXb18JqW+xTKI6IG1bT7UHXS5nl0XNGyy8RFNAvhOZX
	mWN4zDt5WPa8AZ0LP6LCFv2LgPj6nAEnhUw==
X-Google-Smtp-Source: AGHT+IGzdLhcexuTkOIjNGn8PdUy4hc49e+TVEXl7hecisnA3tBwFdDE74KWRW72IXKttCn/H4lH6w==
X-Received: by 2002:a05:6a20:3d83:b0:240:167:9c3f with SMTP id adf61e73a8af0-240a8a424c1mr6540637.14.1755018459067;
        Tue, 12 Aug 2025 10:07:39 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.77.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b428e6244a5sm11788035a12.23.2025.08.12.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:07:38 -0700 (PDT)
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
Subject: [PATCH v2] iio: light: ltr390: Add device powerdown functionality via devm api
Date: Tue, 12 Aug 2025 22:37:18 +0530
Message-ID: <20250812170723.51639-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset to do cleanup when the device is removed.
Set client data with i2c_set_clientdata() to ensure indio_dev is accessible
in powerdown function.

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

 drivers/iio/light/ltr390.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 7733830dca67..f9c8e7fc57fd 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -680,6 +680,24 @@ static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void ltr390_powerdown(void *client)
+{
+	struct i2c_client *i2c_clnt = client;
+	struct iio_dev *indio_dev = i2c_get_clientdata(i2c_clnt);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	/* Ensure that power off and interrupts are disabled */
+	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
+				LTR390_LS_INT_EN) < 0)
+		dev_err(&i2c_clnt->dev, "failed to disable interrupts\n");
+
+	if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
+			LTR390_SENSOR_ENABLE) < 0)
+		dev_err(&i2c_clnt->dev, "failed to disable sensor\n");
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -693,7 +711,7 @@ static int ltr390_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-
+	i2c_set_clientdata(client, indio_dev);
 	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
@@ -733,6 +751,10 @@ static int ltr390_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
+	ret = devm_add_action_or_reset(dev, ltr390_powerdown, client);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action or reset\n");
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ltr390_interrupt_handler,
-- 
2.43.0


