Return-Path: <linux-iio+bounces-5961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9398FF6CA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518281F2200F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4919E7E1;
	Thu,  6 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5kOpqjP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB019DF71;
	Thu,  6 Jun 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709053; cv=none; b=S1GE1M95xsKi3UXk1eiIVZ2PTmpFnquLvQPVn13NJHyUCnDMtiVj42UIXqhURY86TKU22KD4DOxxkdyRHgaVqZ/mcWlAJDeoBTlIOAWJchWo92eSVmGvkXyqmRFRrFdLehoIRCqPzdwqfmXAxZsP2e85glmm2Bj212FT66RxC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709053; c=relaxed/simple;
	bh=msQ5Rd8eIGey9e76uvIlQE5lXAXhznI5XikWXS8238Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSNqNjKcTfz37LzomTiE8qYWvUhSQ0sad+pt+CyZCZzR9WZ51JAOqKDfvTJqKjHqPuYDNLKglmGJCVQiqkAG+C6B0owHvbaDaSTroqs2sKGOBDaGj+p0WjwwHf952OdbmtRN9isFsJOUe9cBxFRwaGEUT/42RjHpXNz5fKuH2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5kOpqjP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a683868f463so176583566b.0;
        Thu, 06 Jun 2024 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709050; x=1718313850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oWv68nrfdeiEj4L9X1NqpjcXD+oUDcRyB5rSGEHMKI=;
        b=J5kOpqjP8IPb9XlWYK9DFwAEZKitv3aPhDHa1Mfv6pBQpbarviO2aIT7bn1ao2sx4w
         0az2ElKBf+CTgLjbEcJxyBYLn/VaULQrMJjCwx8ThlQlitzQONDuCugdjyyWNSQ4ffYR
         CxP0FbwWg/eQyqUoDl8eZEGEoq0fU6w3RC+P2d/ijAI8jy/l8ZFYr4Ur3TUgyUJWWoN1
         EZ9aMsvuyWqThT7wN4Rycpifywnc/+SKJmi5iU8Er2HcvfHJxDVmGnEmyxY+VTmjC5F0
         QQ9my6gW/vL9j0xCT8CDPPxhKoL3ZhtpY7fV8/+24JuJjsG4DjpggU9sk9ZYwtBqMz1n
         AFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709050; x=1718313850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oWv68nrfdeiEj4L9X1NqpjcXD+oUDcRyB5rSGEHMKI=;
        b=euDB98OkK2waoYlowAqJH7QaPNCGMot7PRKi48LtCH1KBJCUCK2FqqVyrBT3LvGidj
         Vk0gxnapwqXV9jH4jOlwiUK0EAEwKJ7VXisANMJG6c8yW+DVe2fbhTwIvOIKUam9lqNf
         9rTf1h8C+FVtbIkXroWHCjs+cG84iRzZqzyNKTDV94r2nbhs0pUzL5cSK66ZbwCweKAR
         mfBlFKoPGufStYUss3vUaMXZfTaa04FBqpOpdNB58YI708PdSC0KM0Mln30/+t14/mnu
         agUv1uIi+ztiQbLYyy8iubc/NVdyX+wc94z8S2L6LYPWTxBdxAMtpUPBqRKghiM0iaXI
         QcOA==
X-Forwarded-Encrypted: i=1; AJvYcCUmHMWqJCCDct+Lv/4qr/yLWs0vAC6HtBQlzx3zSGUmx9DIarD1O1joX/9KACCrktO0sYPXgOeAIJFeArfaSoEgevP4hcMv8rks9HqtYV/Yo/MW0zrnA09BOuPvoGp9HEzinnQfNTHI
X-Gm-Message-State: AOJu0Yyr6qfJ6U2CQHGsjimFsbAw8aNAJlP8KYQ7joWq207ZCZaih1G0
	im03d1X5SltgGqSmh6bmbDa0s/qYnCJZfTUexHj0JrIHUhA3z4Hn
X-Google-Smtp-Source: AGHT+IF+y0UaTExH0gksc1Ri6TPheYhfVSJkhIXGsvnG5TYhQ5nTz7Uq1zKZysTr5aXBRKjRu02FZg==
X-Received: by 2002:a17:906:e2c7:b0:a66:7666:fc62 with SMTP id a640c23a62f3a-a6cd6664187mr54175666b.22.1717709050387;
        Thu, 06 Jun 2024 14:24:10 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:09 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 14/19] iio: chemical: bme680: Make error checks consistent
Date: Thu,  6 Jun 2024 23:23:08 +0200
Message-Id: <20240606212313.207550-17-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the majority of the error checks after a regmap_{read,write}()
operation the following coding style is used:

	ret = regmap_{read,write}(data->regmap, ...);
	if (ret < 0) {
		dev_err(dev, ...);
		return ret;
	}

In this particular case it was different so change it for consistency.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 3c33c21b5d6a..25d128e1ddcf 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -517,10 +517,12 @@ static int bme680_chip_config(struct bme680_data *data)
 	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
 				BME680_OSRS_TEMP_MASK | BME680_OSRS_PRESS_MASK,
 				osrs);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to write ctrl_meas register\n");
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int bme680_gas_config(struct bme680_data *data)
-- 
2.25.1


