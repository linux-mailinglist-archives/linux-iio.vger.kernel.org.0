Return-Path: <linux-iio+bounces-11038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD89AD8C0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2641F26986
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520052003AE;
	Wed, 23 Oct 2024 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XeADY2iq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450F1BDDF
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727684; cv=none; b=EeoQJN6TycPLIknRjeSZhXvfrMGCG1fHUKGviQU5EL4/9vZIO7z7Kuxr+mmfz7k3Mb5FAzzxte4AmC5qMcovGE57a/POiMMFAThO0mSHqEhL7GPEXuG+Fe+llzVMVg0m9cdYZ+Om0kWceZyhrFhLJAYnFIN39/iyDWPY2sZXgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727684; c=relaxed/simple;
	bh=+qQPhpRBI2xebpxF2IUsDgxiRfAaR2OlImrgtgTUDY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULBBX3Xw78XuI1645OGiBOjCeIEVYcmUnVX7iojhxnf0M4QwVagKRE548dYTx3C9lFkT29wpaIlnZXt0g+JFKGDoyR7KuaWCrZnEd5+9gCQO/AKaZKP3m+wiCeBbC1m/x2l7V+YAnooWNRK+k9wTQt+L88HuYRp3yMC0Qs5a38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XeADY2iq; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ebc0c05e25so160529eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727680; x=1730332480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h499UsT6sj6xlYcZ1JadzuP0YnfDcZeLc9oTI16DnbI=;
        b=XeADY2iqLRL+REpr+OZSm17VgKoloGRHGFJ4+eqC3YT6BwSr7r9aZIULa0t9czILw4
         /HuwkkDFkdVKduOjlmzFLW3Gi4UC3vgs4o+FV47Ej3zEAQ9lZE7SGCSAdbcEJ0uYoUF6
         cS40p9bFP/cYaSpQ72DmuGz3Pb9Unddm9iV4OwFXH8+2d2uCY7Omz8ikv+9U2AeqnZSM
         tbYE9Ry8mw0S1tNXg2tifXwzN6HgC7xMEm8K0/zzecIt+LszllIRiGuApSi/jQXoj7GZ
         jMcXxxXnNJ9+VcmH/zIXoQ0FVsTwe+PGvqWjANqwKAcOVKe6esMaeNAOxw0+yPfhaHxB
         NSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727680; x=1730332480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h499UsT6sj6xlYcZ1JadzuP0YnfDcZeLc9oTI16DnbI=;
        b=Rt6C1rUiLoJHlcLR9bbHMRv/re3A2oJmegkb11viYDna1UlxU3U6s0OW8IniQy7q9X
         ZDAcktf42Rg2gFUzkgk2FzGc2NugPMgyrPN59Vyi3bbn1SLHPAx2zwNtSmLtli7Hf60C
         3b+uXDyHueVvz7dPII4UnbFpB52HnxSU5wrBIWWKfDr6EcfFGDB4FXS05kk7FQ7pccrw
         kW0akXel5j/qZz7WnWp5LX6PO9xu5jbmqbIOyUAjvQ/rBNBmRkNq67ZmrFQUY+nlnPXs
         ArOUUC5sSD338Q5AKZTpj9SGbfxlHxoRAfx8Jlb2UIzuBXcUKoCdCsMQDmM0BkqmGFE9
         TIQw==
X-Forwarded-Encrypted: i=1; AJvYcCWBt9hxm8LdOsw5lW4qWcQ4g+/dq3SI0dBiN/Imcs+PUUzCd6glyI19qKP7VO3fFrnCHbV8b9xMBIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2DjZrBvqcz5ZlXAsZfoW0uC7QUSS+zqPTQx3H9I7c/rj1zF4
	FUY9xoqkykSgnoXMsiQlRteBGWDPW09yHMiMzATPPmKhLOJJe/TGCb61IxeQmNs=
X-Google-Smtp-Source: AGHT+IG0LoE+A40aIKnVIo1drlkt/dwuoqY7uHdyZBDpLRMrmduBDPpg6jxRGWmIdxyPu5IIHKkMeA==
X-Received: by 2002:a4a:ee95:0:b0:5eb:db1c:a860 with SMTP id 006d021491bc7-5ec057e1c3cmr123250eaf.8.1729727679948;
        Wed, 23 Oct 2024 16:54:39 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:05 -0500
Subject: [PATCH 01/11] iio: dac: ad5380: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-1-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5380.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 2e3e33f92bc0..7d1d7053c29e 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -47,7 +47,6 @@ struct ad5380_chip_info {
  * struct ad5380_state - driver instance specific data
  * @regmap:		regmap instance used by the device
  * @chip_info:		chip model specific constants, available modes etc
- * @vref_reg:		vref supply regulator
  * @vref:		actual reference voltage used in uA
  * @pwr_down:		whether the chip is currently in power down mode
  * @lock:		lock to protect the data buffer during regmap ops
@@ -55,7 +54,6 @@ struct ad5380_chip_info {
 struct ad5380_state {
 	struct regmap			*regmap;
 	const struct ad5380_chip_info	*chip_info;
-	struct regulator		*vref_reg;
 	int				vref;
 	bool				pwr_down;
 	struct mutex			lock;
@@ -400,42 +398,32 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	if (st->chip_info->int_vref == 2500)
 		ctrl |= AD5380_CTRL_INT_VREF_2V5;
 
-	st->vref_reg = devm_regulator_get(dev, "vref");
-	if (!IS_ERR(st->vref_reg)) {
-		ret = regulator_enable(st->vref_reg);
-		if (ret) {
-			dev_err(dev, "Failed to enable vref regulators: %d\n",
-				ret);
-			goto error_free_reg;
-		}
-
-		ret = regulator_get_voltage(st->vref_reg);
-		if (ret < 0)
-			goto error_disable_reg;
-
-		st->vref = ret / 1000;
-	} else {
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV) {
+		dev_err(dev, "Failed to get vref voltage: %d\n", ret);
+		goto error_free_reg;
+	}
+	if (ret == -ENODEV) {
 		st->vref = st->chip_info->int_vref;
 		ctrl |= AD5380_CTRL_INT_VREF_EN;
+	} else {
+		st->vref = ret / 1000;
 	}
 
 	ret = regmap_write(st->regmap, AD5380_REG_SF_CTRL, ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to write to device: %d\n", ret);
-		goto error_disable_reg;
+		goto error_free_reg;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iio device: %d\n", ret);
-		goto error_disable_reg;
+		goto error_free_reg;
 	}
 
 	return 0;
 
-error_disable_reg:
-	if (!IS_ERR(st->vref_reg))
-		regulator_disable(st->vref_reg);
 error_free_reg:
 	kfree(indio_dev->channels);
 
@@ -445,14 +433,10 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 static void ad5380_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5380_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
 	kfree(indio_dev->channels);
-
-	if (!IS_ERR(st->vref_reg))
-		regulator_disable(st->vref_reg);
 }
 
 static bool ad5380_reg_false(struct device *dev, unsigned int reg)

-- 
2.43.0


