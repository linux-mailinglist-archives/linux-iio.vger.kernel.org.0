Return-Path: <linux-iio+bounces-11835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F19BA04C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057DA2826B5
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB511A0BE1;
	Sat,  2 Nov 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCVw3U5o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148319D065;
	Sat,  2 Nov 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553214; cv=none; b=UfX1OqDMWK6Mb8HB1kuwBY/1/gsyhqYXnM/7TT8jDmMH5JJaG7Klnw8gm29NxAQvO9ylMnwCSfNCIzqyHAtY8xymqUOcxiG99K4sfl1DaKsTMNiw1pE1aEcDtZOJmUJCZdqeptZaXAQxFTZ5pYpmAi8x88BgpPYXJp1zopSG2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553214; c=relaxed/simple;
	bh=KZ7yRqFrxO5vZ6XwJuTZtI8BBPu1nq9S72MpajT8Xds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIK14tnbu9yfT1vuDq7SC4AArtsFOhWfCLjPdTj3LjoQcztSP9Aw4MhNeecHxg5X9bHXvOXnfl/5+MS+XBLMp+a2Oe0ETRz/Ztduv555Ntu+nxwo7eBSKN1VUqXaWt9WiOIijKeK+Qhdq3O3KG8ontFPAcXqP1D7rjdHolmVMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCVw3U5o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d41894a32so1492747f8f.1;
        Sat, 02 Nov 2024 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553211; x=1731158011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2Y13fa6Xzzr6xJ4akxb48+KgpVI9Ht9FgRsxSII0Xw=;
        b=dCVw3U5oj4dZhlJtek+wFh0ACCL2nVP9lgDt9z6oqdjZOmT98C/cCY7eL+k0gipHOn
         khe0MkjfP6ZawbxLlcB9vMB7lhHDQ6mihe12A/x3luC4aXx9o4xQCtJkv6AkebpxPN+2
         NwbK4wKSXXXoZ/ZTnalxkrhLuqSY2bDaf9X2ipc+Gf6P0ImPdT+17DvPvu2YPBO5qs8T
         D0MndinSrLLIZ+RQse7vguaRSPjvj0Mbt5AQFMwg7niGd6X5nNMusMaXJK+TkUfEsHrF
         wvkYTW18ReW+ubf/rEsafG/BkZjr4CDEQ/GKit8Wc/H1CCd9ARlRf70Ub+YfPqskAkHI
         fOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553211; x=1731158011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2Y13fa6Xzzr6xJ4akxb48+KgpVI9Ht9FgRsxSII0Xw=;
        b=Klh5DHEGviCtpZ8z1J/dZn5a0SuBlcXRt5GGAKbXm3h3Fyul7DPOZ3b8Iz0OmlPnYk
         LmlK7TiYSM/Tqb3oOhB+AdKJAR/RHitAWCSFbWAdM6hWQ3wKOrlecBt1ZKCWyJE08/ML
         /IIV5sgEnGcinqF+6UOQZtt6lYg2lMGgxmwS6HKUD3RDUqE4sIIAWva0zCf3JhO8lS7I
         T9ky7TSurcf4hAvCNtVerdBTTVQblboR+YFTCRDy9KRKhELf/kqVrY9RJLt0ci6XRBbS
         8nu5pz9K6No7Lgj4Y1wnzrGpb6TYgLRCXzAZaZli09KV2xgWekF3wMVQFO9diO41dcmx
         9FIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9PbT3H52tGIqFI58b+to8oTf36CzRshsOUvsTIhVK7+Zi0riEuWstfaDP/pURBwsdN60Vqc88jlVM@vger.kernel.org, AJvYcCVoiHnf1a21+upryNshZ8nzaRUX4ppUqxe5GuQw+Zgob3BoTuVhotQSd5h96skfrkr8J0ditiUiD4/V@vger.kernel.org, AJvYcCXp+8oVvDNdKVGz7yjl4J+XIX+7+Tg9qrbAMCkjvU1+CP/1VUTWdkJimZyjVkon+s/1JHOCaHgu8AOpSI+C@vger.kernel.org
X-Gm-Message-State: AOJu0YxXu6YKVWQqZB0JiazJh3eqpVPLCZ0gTPOj8ZAOd8Xr6fRVntm2
	TihHxNGpejxS7lSwh0BrEH+ICdSysSKAY2pB2rq7k1weHeGkLCTR
X-Google-Smtp-Source: AGHT+IEHiBbDJyKEk4ts/PQ+bwvyRZE6BE+wTe1MqXo1sV/zE+BTw5GfoCfTpnPkTBR5RMXmn/6OCQ==
X-Received: by 2002:a5d:64ed:0:b0:374:c157:a84a with SMTP id ffacd0b85a97d-381c149f462mr7160631f8f.16.1730553211031;
        Sat, 02 Nov 2024 06:13:31 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:30 -0700 (PDT)
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
Subject: [PATCH v3 6/7] iio: chemical: bme680: add regulators
Date: Sat,  2 Nov 2024 14:13:10 +0100
Message-ID: <20241102131311.36210-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102131311.36210-1-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
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
 drivers/iio/chemical/bme680_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 6cc1cb9e0477..31769e0df7c2 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -15,6 +15,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -111,6 +112,10 @@ enum bme680_scan {
 	BME680_GAS,
 };
 
+static const char *const bme680_supply_names[] = { "vdd", "vddio" };
+
+#define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -1116,6 +1121,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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


