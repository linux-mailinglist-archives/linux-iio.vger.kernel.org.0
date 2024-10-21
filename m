Return-Path: <linux-iio+bounces-10904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46139A905F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF51F2144F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247A1FF5FE;
	Mon, 21 Oct 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgSLa9UP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769BE1FF03F;
	Mon, 21 Oct 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540428; cv=none; b=relvCewhdgLOgzYWbWI8C5/OZv9VAZIEW9/ZV3WhSgOPs3Bx0u7wiQifOWWzkBazWXmgbmfFzdoAenX7fBuT9oQ1x6zAvsvcHgq1SzxwmGaaIbz0YChEx4/mOW09OrMKZOVX+hwb1uSNJbaf0vaNmPatnyKiWZNro37HJRZPjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540428; c=relaxed/simple;
	bh=Iv1qVeHWsnGwCkKp4JfXyhKcEjlk1L71tw7kBPDfmW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMKF6WGbknTcgfir60Dwdf8U21Lk1dgbI5NUekHFa7u16e5Zu34Wt8NQFlaFZjz3wG6UfkXnmEVhCwYYrMbV9D2WlgoR4pkAREiaBIrLuSCyFlpHpDSrwPKA0BJM8nYy+WSFMDZHCHVlL6ePoHMhmvO2KyvH60sKcNZxWjxRGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgSLa9UP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f84907caso5516286e87.3;
        Mon, 21 Oct 2024 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540424; x=1730145224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7S9rQla1y9kYh7NcqnpT6la+7XaYudbdijz15z2RK4=;
        b=ZgSLa9UPNEW7QvY3GE8dqxaz9qILZCv5Y6pXGszUphTyDAneXamETHZQib9LFRnjiG
         6R8l6N7vhI1/O2TgCy5V4Nvz5T9tvVgsjCjKfXbHdXDXOjxnJRiiBWJQqyfCUjE+ra7O
         NIoaYFHfLB1icR3UzkGKeqISt57M7fJHdvlgWnfoqsGnD5C+6I20duTZlw+aLOZ5kJCf
         jLv/IZ6jHL38nFcrKmUK1f1vc4i8bcZxk89H8JR6VfPSIxWXQQ+HuxOszxQJ6PWknu97
         qupOTa2dlVG38BoiRHXaVqphYkDWpWWNAXpsYdz0cjvk8xh7KrCIFiwxeuamxAWmacZD
         BGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540425; x=1730145225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7S9rQla1y9kYh7NcqnpT6la+7XaYudbdijz15z2RK4=;
        b=dbvErmFyH8j4lN13hDSRGMF0G8YP0r1c3wws7QsBXIwM9HxcN4E3bUwtPYkIhlcpMS
         u/F7YXVo4+IAHzXsHD8Pr4uA/XF9oLa4xBrspMd1+Fmxv4Lk3ei0sKyVa3aur/f/IpQj
         9k4ZmpJUxnULFeZNtit/vQitkOQoHF25LLQRSYa+FP4mUITQZON/BXItYUY8+l1RBs/z
         t8g8o4nrvskCroltulIvD2D30H93T+m3dL7wH3N0WEkvtbCHswLfoj2YUQVWE6Ur6uTY
         ZQdRlFainu/p8e4gOZKQDr/D08aZBaw74vD7slkXP+AqtiD4SS0gmhKepEx32W7rNZTA
         UuRw==
X-Forwarded-Encrypted: i=1; AJvYcCU+hdMeRBNGYps8vc5A/oNy5epEpJi2VZCbQR1zM7OCypkta72OeNHTuX6r2fnVfb+S4Bp0A7OyY/UC@vger.kernel.org, AJvYcCWJ+E58xRug0PwLsVN2+st7xsn+TlTvaD5iqKz3d4dwx4H+DtRKnSUpeoVnFt0deT1T5fbK5sj6LYTf@vger.kernel.org, AJvYcCWeKf1BzfLHGFj/tXF44SFCzu3ggPkuaC8cJZ0RV9emwKX4IEbosaSPRxdws14OqcFxvjLFXQXGu3w7HN96@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd17nnOPHpmLR5DGkCp8QCxp7FAR7je/8bj+HNvPjKX243d2YS
	LAQaqzV0i5my7CqNjOmGhmGHEjzYgw7GfTw9rmyk1QuRXwflr4L6
X-Google-Smtp-Source: AGHT+IEIPVVkuMV4TTd4zpUQBME0OL0V+C1tdauapDgdNByMAL8QgfDQfJGVgGhMQ0zoVTL4Qqmp8w==
X-Received: by 2002:a05:6512:3d05:b0:53a:16b:f14f with SMTP id 2adb3069b0e04-53a152193abmr6281588e87.19.1729540424350;
        Mon, 21 Oct 2024 12:53:44 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] iio: chemical: bme680: add regulators
Date: Mon, 21 Oct 2024 21:53:15 +0200
Message-ID: <20241021195316.58911-13-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the regulators described in the dt-binding.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 8c80a5f1ef9e..2d9d20f203aa 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -15,6 +15,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -110,6 +111,10 @@ enum bme680_scan {
 	BME680_GAS,
 };
 
+static const char *const bme680_supply_names[] = { "vdd", "vddio" };
+
+#define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -121,6 +126,8 @@ struct bme680_data {
 	u16 heater_dur;
 	u16 heater_temp;
 
+	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
+
 	struct {
 		s32 chan[4];
 		aligned_s64 ts;
@@ -1114,6 +1121,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_dur = 150;  /* milliseconds */
 	data->preheat_curr_mA = 0;
 
+	ret = devm_regulator_bulk_get_enable(dev, BME680_NUM_SUPPLIES,
+					     bme680_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get and enable supplies.\n");
+
+	fsleep(BME680_STARTUP_TIME_US);
+
 	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to reset chip\n");
-- 
2.43.0


