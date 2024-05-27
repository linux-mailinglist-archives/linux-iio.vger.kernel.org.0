Return-Path: <linux-iio+bounces-5371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855A8D09FB
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46E6B21C8A
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DE11667E4;
	Mon, 27 May 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFVgx3Yy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D1161936;
	Mon, 27 May 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835104; cv=none; b=RXWbC21g/+1LQGOCpiBlmQJIldN6ozFbLXIKyqhdxG+XA3TQIgB0YWmwEKhi/rGPVCPQ/xnQnbTcSYiVCd65u43/NBpXSCP84CWQFwBWESI6Vp8+xtrINbQxi7klRq+4U1GdF7oe3HFpa3seiZKQJLVugfosj87foH3jBG4dJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835104; c=relaxed/simple;
	bh=0dfNx7DIWoTHcOaWPc+zEobJOaN8XKXivqc3NTO03mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JbKC0oQ3hTh3GmCI2rpRPHhAttOT9xyMW+Okquhsq8jeVMtA5Usi0zSj/gG3ec6PHoR8tC9vOphDIZPqTUW7oiktE92AguE8iB3c84SEKCCzZHFutN48cfQA06GNKHdUwQHeoylSlYXVaPPDejfC+6tSPn71ln6HaApWPYz/eY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFVgx3Yy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-523b017a5c6so82451e87.1;
        Mon, 27 May 2024 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835101; x=1717439901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jorQRSEWiRbefIBVk6pwpNbetVkXTLRRe3J2qG6vfu8=;
        b=YFVgx3Yy90sqTSPBfA+CloHIs0miwGaG6uVy8syDqeEBKKPVBYM6t7amRYSj2i2bes
         KTq2aggtnml4oG0kohOg3/llncwA2OtnRy3DDwvOlk1waI4TQTXGDsMdmyfEGopLuCll
         w0EO00KzUCOgS+2CXoHPqn55q//Wh3oXDPOpSBCl6kd32DPS0QstXPEQq6Dz9ghEUGsf
         27R89vLRwvr+ZTb2w9a6ccqMBB1gvbU6rL5FgZLqDSAeFvreBQ2N34wFtQ79g/qJsBkF
         RDo72pOAQGzjOZ9mLaPd2K0OF+ChjmHVFHfzEWfeexQnXRh15nk3E655PuX0Nbz2FIpO
         p1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835101; x=1717439901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jorQRSEWiRbefIBVk6pwpNbetVkXTLRRe3J2qG6vfu8=;
        b=chsaJh+siCGac5XZpKAbIwCKZ5Do5u0qhujYkcnIl03lOe47YC3LZvgX5rRRIWjH8/
         AanxdvduvWrc9y6vL2XC3ZjhWt2jynt1AreY2hXs1WDKzDsP9xRCRnwfSA8VHqvhw+W6
         +Zs2bR3rz4iQraEBXHE1kv+myX0gk/5GcrFqo1GbspqnHHRncYoHfrml2d5fsMBA+EN2
         nReDQxyWCvDEAN2bv82UF5ACTGcsRTCefdeTrpm0wBjxhpNvy7JZgjugY0JV6mo0hNDg
         cQvziVec+RCPTi8RZy6Iw+0+M5GIOeiNvmp1diy93Azq2fw+pf3RwV1/49MonLefqkLk
         tMmA==
X-Forwarded-Encrypted: i=1; AJvYcCVTuR9CrLZ5HbqsMjijN+foN+DM6uLD2o1hOhni97tSI0AXURb/gtwFq5IUHD4GaTycARjtaUv9oGL6IglF/iXQF/PjybRp/KL2Q+nEn0mrfCAierS9KH16/sidQyvt9VADbQsl6E8d
X-Gm-Message-State: AOJu0YxgtjSURRDCeAJGc857JB1seyUW9NcS3F2pDiWafTKh+FjRZ9C4
	nb02Xy48QPHYEOYXCRQPwd2M3GmxRc5QeOkpkp0r1a/zCNTIB2PR
X-Google-Smtp-Source: AGHT+IFywxc74HY9TdQGDsKcwIwYP/Ak47o9U4sR0HoURKU1rNqxkPhbfduVUMDA3lFV+XXCu6NzFQ==
X-Received: by 2002:a05:6512:1295:b0:525:32aa:443e with SMTP id 2adb3069b0e04-5296594ccfbmr10128075e87.17.1716835100688;
        Mon, 27 May 2024 11:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 08/17] iio: chemical: bme680: Remove remaining ACPI-only stuff
Date: Mon, 27 May 2024 20:37:56 +0200
Message-Id: <20240527183805.311501-9-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI ID table was removed with the following 2 commits:
Commit b73d21dccf68 ("iio: bme680_i2c: Remove acpi_device_id table")
Commit f0e4057e97c1 ("iio: bme680_spi: Remove acpi_device_id table")

Remove the remaining ACPI related stuff to this driver since they are
not directly used.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7607c3167e24..e61d1f0b67c8 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -8,7 +8,6 @@
  * Datasheet:
  * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
  */
-#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -906,17 +905,6 @@ static const struct iio_info bme680_info = {
 	.attrs = &bme680_attribute_group,
 };
 
-static const char *bme680_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -948,9 +936,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	if (!name && ACPI_HANDLE(dev))
-		name = bme680_match_acpi_device(dev);
-
 	data = iio_priv(indio_dev);
 	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
-- 
2.25.1


