Return-Path: <linux-iio+bounces-6120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC89018A6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E121F20ED2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF15644E;
	Sun,  9 Jun 2024 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llb0y+j3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3205466B;
	Sun,  9 Jun 2024 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976315; cv=none; b=LkGoQMYD7w47bDmU+lgH8No9KGTym6OIH37RoSLuTECDlYfCASgtPDQlnEP/PV6o9AsKb0HKeqyPiHnLmf6feU6ax4rqqv6lknZsSeu+7ucpeWQP/TTO+f+Jh5gJOA9d6Wbav4jgl354JAsOLI15R0hfpBWqXZaIT276LsGDbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976315; c=relaxed/simple;
	bh=WZezGHBW7lNuyA2BtM03KIaX98EoYUexUTzkAk/OvKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMOzu8v1KXwo7W4np/Q8dnvSGzNYY8Kq4zkhJiXuDvNZKtxjPxmf8vRhfEdqOqp8BLlUUm0rg0QZuwylhzj81hzOvSACiHlo0YKQlUH3mLv8Al9rZXphwRreux0SB2R9nzU75be9ckYXfykQJQTVgdo0DkBRl1qZWFkbfabq7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llb0y+j3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f176c5c10so68238966b.2;
        Sun, 09 Jun 2024 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976313; x=1718581113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p69KGwneGFw5Zvl1/Wy4CEQETIxZiMeX9Wp/4PkCyA=;
        b=llb0y+j3kGpe7ROwc84Peo2H2wFDO1AX8mylfsPq3NnTzQlI0bnU6DoKY6Xj22Q9Vo
         JZK/0PhLCxvTbfAYj2wuPXFPZvbT2TyavcbGjqtuyJBH0WP8tKiHcdVjpOWy9ncJE5tD
         kccwAL2Z3xMRiGXt/SfK6uW3VV0UAy4/DDSmPVT6aMRFWgcmVlmNm3JKwU88WBB6eBLT
         2fd+s7NjkKJ5x2/YbTonsSOak3h/LAscT0SObcm93A4DyDs+F8YJsaSFoW0sGV6zF52C
         baHZea+G+gjy3/csgiXT+xAAJGrctNa1Um3EIKle3FI9Xohm0aVmsTERUd4mSogdARU9
         OBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976313; x=1718581113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p69KGwneGFw5Zvl1/Wy4CEQETIxZiMeX9Wp/4PkCyA=;
        b=OafRr1G4CVSHKkP8O75KPJU2M85LVlHw4XTy/+9rUDqCdaHbmGnn5Oh8a0ZvR4um/+
         NGJ5iW/anZN+FR6YFztOIVyLnw5ZWpd8o77J8c7YE0V7xIiCm1ynYMvkro+EwSD42+EV
         sd/fUqKspBl4oyA4G03VMtuYVdCgrvPWCyR1S2QcO5b7hA+WnDFtSyq9w1X+vlhEbxxI
         lhvXeTs82LVUsh6jsK2FAj3aqHY3aHGllk1NumI58ikP4NSsxou8A2VbZ02nAjslAdsf
         ZRKFfwAmg4xcXLZKHjpIIQn4C/Wna8h5DsMpOG/SgTtr+iiH0qUV9GWJ5L6aPVfcyWS6
         dzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa/lnz1aaCFVKsUZeexycAj47tk1Zy5YvyBvnijIdfTyIXFQrLOY9qRx09kKO0wZjieIUOpQK2KO2V5ewbrNF1w3clTL3J4nH3s1Tkdhp0mBvbkZNij2b786dgis4AxFZC6PVqPTF5
X-Gm-Message-State: AOJu0YzsDGscmGn0V+/nQ05wR/tmZ/g0RvsrNI8i2YULeSEwqhPZSp1U
	ZhmM2Y2bc2K0gfhWppsmMvWWI+sgSDeRgaQqIYi9+wPey2I/Iq+V
X-Google-Smtp-Source: AGHT+IGnu3PtZMC6ERAafp1iP7LLpTPSlOyVK9X8ODeRZsSyRx07Tg2xlc7JinZqiXl4ANCiHcXt5w==
X-Received: by 2002:a17:906:6bd5:b0:a6f:1244:29f1 with SMTP id a640c23a62f3a-a6f1244480emr168827266b.55.1717976312564;
        Sun, 09 Jun 2024 16:38:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:31 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 02/15] iio: chemical: bme680: Fix typo in define
Date: Mon, 10 Jun 2024 01:38:13 +0200
Message-Id: <20240609233826.330516-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a define typo that instead of BME680_... it is saying BM6880_...

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      | 2 +-
 drivers/iio/chemical/bme680_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index f959252a4fe6..c51bf2bdf504 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -12,7 +12,7 @@
 
 #define BME680_REG_TEMP_MSB			0x22
 #define BME680_REG_PRESS_MSB			0x1F
-#define BM6880_REG_HUMIDITY_MSB			0x25
+#define BME680_REG_HUMIDITY_MSB			0x25
 #define BME680_REG_GAS_MSB			0x2A
 #define BME680_REG_GAS_R_LSB			0x2B
 #define   BME680_GAS_STAB_BIT			BIT(4)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index a6bf689833da..c1a9ead1397e 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -740,7 +740,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
+	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
 			       &tmp, sizeof(tmp));
 	if (ret < 0) {
 		dev_err(dev, "failed to read humidity\n");
-- 
2.25.1


