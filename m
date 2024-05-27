Return-Path: <linux-iio+bounces-5368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E098D09F5
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862311F22790
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA4161330;
	Mon, 27 May 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuTLqu2B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A36160796;
	Mon, 27 May 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835101; cv=none; b=tI3m582Pok1yJ59bqxHWHAsa/eBmtD7XTGZAJpwzChaIpTspX6Cttt0D/tYIYpGWS/9GJw9PDa7Wy7QGwz5uPqrDR6QDwI281hkXPdplDmvUBVDos1bPDzS5mdoUTr+i+hHOpFytqSo1wZS3J6sy67If7lj8Wb1d/WOapJMylFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835101; c=relaxed/simple;
	bh=wg8PkYq2vv17rsR/l8nMQ5doyUXlPzOS6Z0DMcQ8DJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s09nb2FZOrGL5v0m9sfoO5vLH3UGTyk2suPoXAWml8uUwwBXsY4fTjXdweQzhabom0lgHWCGss4Pgtm23frdI0Niuh5m7DzS32PL/EU0Hya0CL9GtNyD9dXPFka2UFhV+Mg2yadrY9R5V45SytfbIkJObAcosHTOHsDvCniG8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuTLqu2B; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295a66e775so82931e87.0;
        Mon, 27 May 2024 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835098; x=1717439898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcTV1qQ2q91YjgXekUdE0FTmBFj0P4pw7uvqhX9sQ4E=;
        b=AuTLqu2BP6wbzz5SpIAyLzp0cuPkBLDQ3Yuq/3a4Dsom3A70h0N5GVBcorxsEvZ1nY
         eCVYbxNePmABadNrBHXqKYeFJSILKcNNwxOxndnMg1a3E/G0TqWBqWRV1G75YvsvTeWK
         sJCOLl0O3DB7gUYIQ8HND0iyUNa951mRAA4GVqhHfPgJk7/FyVJCdV/PfLatWjxguAlS
         lYhCZjiHPyq61uR2i5ob2UorzqQrrosgTkH1nOz0ZjpZXMSUYfGlIzdLjWcO/ccnJHa9
         ni+j7biTDlxtagiZTe+kECX75bZvQhC2zYnmGFclCkfEPfudOn0MmY/VdRIVKq61epuG
         JELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835098; x=1717439898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcTV1qQ2q91YjgXekUdE0FTmBFj0P4pw7uvqhX9sQ4E=;
        b=UwNOrtgJX9A/qykinaV2w6GZyWT3oYSHX+F6WjvBQ3EnyhpMyU/Id4kqd3uGcnz20a
         +2XtI/UBDJsh+b5geH9TYCjjWFZyuQPjM2wUyuExB756H7RKUj+jpKVAz6w7mIqNVIr+
         VByH7xa4KKAipKk/YtKRb3pAByPSKCFepwRrtlzjkKWYC0kHXQaxP31TYzjbR54nfTSB
         k0nZPMyhgGt9v0HAHB0SY5X71gKXi/6DLsPF18ncnUkgBXnEdbmVlU0rpdEg4opYDqy+
         LqElAshd8uw5iZfLBm3HhueuiIiBiZk60hLJ841MFLHKs/swHHXs1541b+p24QzGGokX
         MiRw==
X-Forwarded-Encrypted: i=1; AJvYcCVcM3VlmEb0rJHY9XxkP1QG+wzDRcwrA/Pc8QJupW6mO4WocuMN+NDqPn1AkD0EzHOBiMw94eIy4cYUpdVlmCGtGcwmS790SyAFbO6x6BXdB2OP6ycwtEhhEh6EYgcrbClHtzxWqLig
X-Gm-Message-State: AOJu0Ywv6FBd5PCuLD0U6DR98Eg3wHBM18cVt5568QIA3FfsKQvyIkld
	aM2aTdOZuOD+Os+hdCJFjc3VOUTlvl1E+E/SJatkDNz6t0KQYs5w
X-Google-Smtp-Source: AGHT+IGvXJrQ2FmzU+IvnS0r1WXIa/25Zr1inRriKMA8HqVVPGoFHmihzoODuY80fATEpZXWCBQLnw==
X-Received: by 2002:a05:6512:3c6:b0:523:8723:32de with SMTP id 2adb3069b0e04-52966f8f472mr8776908e87.53.1716835098035;
        Mon, 27 May 2024 11:38:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 05/17] iio: chemical: bme680: Fix type in define
Date: Mon, 27 May 2024 20:37:53 +0200
Message-Id: <20240527183805.311501-6-vassilisamir@gmail.com>
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

Fix a define typo that instead of BME680_... it is
saying BM6880_...

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      | 2 +-
 drivers/iio/chemical/bme680_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 4edc5d21cb9f..3133d624270a 100644
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
index dd2cd11b6dd3..8b42c4716412 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -719,7 +719,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
+	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
 			       &tmp, sizeof(tmp));
 	if (ret < 0) {
 		dev_err(dev, "failed to read humidity\n");
-- 
2.25.1


