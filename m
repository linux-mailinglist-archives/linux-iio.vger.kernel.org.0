Return-Path: <linux-iio+bounces-5950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD488FF6B5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF271F25F37
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062519AA68;
	Thu,  6 Jun 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5U27s3v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8819A2A2;
	Thu,  6 Jun 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709041; cv=none; b=GIC3qRawUPzmlPdVsOLtr6G2ytAbIizJnBvjCSJP+IVhzVn2EC0SL3uArkZacs5MMHooaG99z7x0Ib3CnxC6JaAEvGVqq2I7dLtp7NWPgzpv3TmqXcecJ7gy9Y08I+sWvzBLW5JSqXicwdI3a9oeFknCnXZbvj1onf5jI1ODZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709041; c=relaxed/simple;
	bh=VXhsELu79O6/4D7jTvGtQAsy/KeKycEo9+kGErRd458=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPwZm4XmBHmf4jVyNYfY7a1u10o+Blf5lh85RbFdY5Y//C8pXvuSsH8lwjC9qAo9AeZhPsyq/lxtqq1wQ/0BjulirFTq7ZIrLHo4J0bXFGKFzITBJK+nkJk1QKnkFXi4bHvHPeh/yi6YGTsJIg5gm/2Nh9C0MowOGMUg4xdLi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5U27s3v; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68fc86acfaso230242366b.1;
        Thu, 06 Jun 2024 14:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709039; x=1718313839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hN5ntj/0ZGGtAfqb0KFVxTijixC5F46w1n62pNbLRE=;
        b=J5U27s3vPQRyNlqyAbHOpsvicMDXTOgLnzwXCOUiDL5HjTSyP1k9Kr3YYze4XJDrEL
         iuf4fBRSy3xXYWoPYYkrkuAa+H2wivMIEW21vhVlxzihx7B1TeoKcTmcdgSo3WHUBGNB
         VtQWXiclq0xxpx+IHmPhbRP5jsSPMaYrXYHPnEi7lhu4Jb5f1LXMT6/neN7bcRhWfxup
         3NCwK3NXLE83CMIEFxw/AgQvNmWaQBt9FYF7Dqj/oFNOdve34XJNew34NAsS4vnIJs0Y
         nCrMQaJrr4EFpt//hLsXDingYDCfxqP8OzQoObhVbcBp7FFEZb8bBDh4kjMGVbbgSHBd
         6qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709039; x=1718313839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hN5ntj/0ZGGtAfqb0KFVxTijixC5F46w1n62pNbLRE=;
        b=i2tqopHzGe9aPkgN1bZEMGPy9R/BNXc/d1URJ18nQxeWowqwe+CWCdDUl3gKoI7KTb
         1MqI9EQeraO/Pg+5+yh7nlx31CXujKm/TnB2sYfPFDeUVyYwlUgNNQbwPQzLntVwk2Xp
         +3VFanVvkfu78Qfy1PxCTAzZR9Zle9FCINWRwYpS5GITuqhupIVZ2NaBK0OzmuQTvJEc
         oUO/0aMGlKQz5AM8VcDX26FtTKbnxX4fRUsej5C8quQWr7pDRLS1CTVoZrQQDwbhVf1r
         txitUkXOY45SP14yzGTfTslwqfzoXpxEuYLbWZzk73DDOSy2rcLNnyuDMCCA/vuNePq5
         IN8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5hdORi68gg6XtUZH26KrdtsKk0t3117GPTO0oKHy0MljcEgMQvlInHOn9u7rvE9gHbRtUMTt4+nugtmdjd9W05BWOeyGSft5hn5QT9jh4vot+K/w08uoHvzmISeuU2M+WRPKKPPQd
X-Gm-Message-State: AOJu0YzIpDCUZaDwSMcQCcnxlv4kPuopRVyJf7cLpQ1XuXbEkILB/Ihr
	kI6Nl9hSavJpK79Xg5E7kBOwi3vzSjQBdbO4vZOJ0jRqLFCK+NmO
X-Google-Smtp-Source: AGHT+IHt2gQfKQoEPTTNV6KWs3NWZrn06ijxs/zDdLNa+0TL8OUN42rl/VbHuFwt2zyvIQQVMhrYzQ==
X-Received: by 2002:a17:906:adcf:b0:a67:490a:8162 with SMTP id a640c23a62f3a-a6cba4a1fb9mr66285166b.13.1717709038619;
        Thu, 06 Jun 2024 14:23:58 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:23:58 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 05/19] iio: chemical: bme680: Fix typo in define
Date: Thu,  6 Jun 2024 23:22:57 +0200
Message-Id: <20240606212313.207550-6-vassilisamir@gmail.com>
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

Fix a define typo that instead of BME680_... it is
saying BM6880_...

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
index 500f56834b01..66177f7e94a8 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -738,7 +738,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
+	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
 			       &tmp, sizeof(tmp));
 	if (ret < 0) {
 		dev_err(dev, "failed to read humidity\n");
-- 
2.25.1


