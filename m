Return-Path: <linux-iio+bounces-10420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D896B99941B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A6F1C25DB8
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7331E7C3C;
	Thu, 10 Oct 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVfpJYoD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170901E5707;
	Thu, 10 Oct 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594047; cv=none; b=snOw5TjbrwXyDDDKYAzrvYFnWUFemEm9t1SS1i5PqwDi0n+FuJkGdfe/4vHyOR+idtK2I4U4A12DSRwzwAkrfRch/PjveLmb8XW7A5TiCqTY2GB6+99+aRArP9rEAAZjDWd+HcznNE721C4hft9IrYPjPv75adn9u0z+hQGhA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594047; c=relaxed/simple;
	bh=AuaAMGazf6D8nta5WHF12q2hhimpf8Onr02Dd4mTI1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYMIzv/69Wv2WxNF3ENUv8tfLFsnX1vsLq4tWgC5QaDOJlFzdxVQs2YvWBFwAkO7oAX/xwiyDO6WviKGvX+j0E9hpGS6DKMgkA7tmopfAECyEWsb2IQkPVziX5APwjJx1VO3m9uqatTekIZ5xDSuCVgeFr/HglboXRPZE9BIiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVfpJYoD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so196126166b.0;
        Thu, 10 Oct 2024 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594044; x=1729198844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtAYLbt/L++y5ER8m5fhu82PiDUM06VjetwOClPVgAc=;
        b=FVfpJYoD/V7NW//lrL4ApWI4OmRzD2lQrPFR8tRhP7o83i4JN0MsgEZCuhwsVcYxDj
         MxYceDX2H0X4CdPh8eVBi0hzE3B3ZBZTtl0FzUnvZyRV/uDabPl/fXQBnRlMaB0V7P1e
         kG6xpWqXj4KzzAQDKjeJ3EOoSM/dYEDdxa5FW6n3BFzH1WhuEZkSJ4oVT8VENe+/6oz7
         9qc5I6n5uxR9EPyNqwxxYWcURsLv9llcrdyRhGlHdpQFtq7Zu3lBpP2IX58XG+Rh6A4R
         CKsUq0CZGIhCXbb4QzF27g0EELcCdl8MpIVb6eJYsnFWegFoPdMk17apGEF/kdY0tZ8g
         DN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594044; x=1729198844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtAYLbt/L++y5ER8m5fhu82PiDUM06VjetwOClPVgAc=;
        b=gyoLFIasn64TacoLqdv/V3XLod3sUI+X3QRAt25KzBAZUnZhhKQOLYKZoeXhocXZYI
         YNHcbrvYhqhgIqjJa0ureZ1s/ZE1kDAgKxAutHeY7Z6ZAqj6qRpgJkei0DoITpiWuQy0
         oDuOHaged88Ao5r88XzgEvXo6rrjGE7UafDlXftIT1DmtFdI308P661ESM/wSGnUF76o
         5EeFPhN+bNnLzchu+dQ5nXNFNDG+prndKxmteOnHTjje4PMexYJRyDuUEHSDYWcH40tR
         DJAJpptZHXQyaSHLY/4c40kTSj/eJd8JFFpq3lcVoY4R6OeNqCzn3bCdoEqc/odEilKK
         a/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/+5WMB8yHiaxDQOGSlNYRz/NExdaHg27Ry2z0lMtpP+qgf7Ds5Y7ASEa0YrISPs1fakugpwBhihiZ@vger.kernel.org, AJvYcCWllxAHDVn+g0qE/9FI3kJwRXlg3JDB5fjwjs/AX1vfmcYPYKK0fwL6AAoJLGFEwoHniA1ARpP2POGI@vger.kernel.org, AJvYcCXsmiFhogq4RGlJ2Jk+U9ftQVBYyMQcFJ7Sh4rmQywkcjqS/dLLRjisap/GFiYSTWT0Ivyk+d+Ezs6HkSAr@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpRsAjhSa4oh0SQDvrvhpX+DB21dUYqQaSjMivr3XUNBX1XAG
	UrdicFg3GmFqZtzOwGs6r0GihB2RT5cJTcUmGFG91ADnx119TYr2
X-Google-Smtp-Source: AGHT+IFPqxYDkOvQOMMOFfLVz6YCBx3ZxfqLb+syFcib5ZBg4/3pNi67Fy8B699KHaXfe+dD8Ky7ow==
X-Received: by 2002:a17:907:7b8e:b0:a99:537d:5d10 with SMTP id a640c23a62f3a-a99b8e935e4mr27511866b.0.1728594044105;
        Thu, 10 Oct 2024 14:00:44 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:43 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/13] iio: chemical: bme680: move to fsleep()
Date: Thu, 10 Oct 2024 23:00:21 +0200
Message-ID: <20241010210030.33309-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Use the new fsleep() function in the remaining driver instances.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 3b4431998ca4..9e843e463502 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -545,7 +545,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 			   data->oversampling_humid) * 1936) + (477 * 4) +
 			   (477 * 5) + 1000 + (data->heater_dur * 1000);
 
-	usleep_range(wait_eoc_us, wait_eoc_us + 100);
+	fsleep(wait_eoc_us);
 
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
 	if (ret) {
@@ -887,7 +887,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to reset chip\n");
 
-	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
+	fsleep(BME680_STARTUP_TIME_US);
 
 	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
 	if (ret < 0)
-- 
2.43.0


