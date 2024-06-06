Return-Path: <linux-iio+bounces-5948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF58FF6AF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C42B1F25E47
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363481993B5;
	Thu,  6 Jun 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3pjqCcb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34D199E81;
	Thu,  6 Jun 2024 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709040; cv=none; b=RNNBffXOEEIpuRtQnuxxtBm3o4rrulcWExVpF/IDcPWh5mIOVAxm0h/BXVL2gANkgMJSoS6YxKZdL12nSoj9AQEIbAJO0X0TnenOvdECjsqBbEPNDAtt2O5dKLO7vWICxv7eD1rNZ8n69iTU1H/RvJ6N47lPTX10pI3rYXKMz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709040; c=relaxed/simple;
	bh=01VTqY+UiDyJ+F6bLOiuC/A6F1/dAPjefl3eUzDwQxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyJBBG7w/U0qTiP9kjqRHGaWZW80tC3pqmNbT/8rle4BdDLB8e4B2F4F2DmghhoOlH5ETE9kBzBfCSa7pkuwH/ZHzt5Xf8udf7xj3EK/zbl+oBeYZSQiQ/quPe5fQZAVK6qSowpd+J/3LhF6TyQJLazu1KsRO5wr1jvTNEwJON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3pjqCcb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so185092866b.2;
        Thu, 06 Jun 2024 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709037; x=1718313837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFkYxgR+bMKdGkSXBR5z1iRX3ThnVE2piXmkmWSpRvg=;
        b=c3pjqCcbwyMItEjdbbCfDaMUCQas1PzJsiyGmXOoKwpTr39OE4aPDt6atlLTYeSuHA
         fGaWWaNKWMxJ5WZ3Cf9RBqStlYMj8sC1e8V4d7rp+DxKqOixP9reME1UVJLG2A1AK5ha
         M7LjUFGfCikymfXkg11RsdaJJJu2ZKB1ApOOKs3ZH4dUX9rAn+MsDUsD050v+vekNLV2
         LJArbrvgYAMaSceeMAfmgH5PtPPDC8PcHla0fyG5dkV/THKnIvzv8BmCekzOqARNa+L8
         XOv/Vihwop8nOZOMXUGmigvocgiN0f81Yy6xFriiGnLN+kspy0Uwt8oyLsq7y2ThUK0i
         O8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709037; x=1718313837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFkYxgR+bMKdGkSXBR5z1iRX3ThnVE2piXmkmWSpRvg=;
        b=i9E/5lAWxljCoAYUyVFC8NeoO6v3KdvarIAdpMEaQ4kF7Ao3Nwe5xcL5IsBuHlrY74
         K3hoFDXGgonSBMWVyzrdPucIVOfGaIPwoR7oh+mDWwDG4pF7oVxazbbSAWlzTOgt6F3+
         LwFCt7uF//+bPzinN3iPLnLEX+sI3P43zclvb6vkeYf9sk7JKLfVVDbU3qjsMRlRNukC
         /A6MA/ein1iGbP0TwSofS45oQ8QVNAX5JMJ/UskX8NbGE3g8wzwaeW45mrMcq66MBpI0
         7K+yppFtI86w6bf37wq53H6K3RAPjmFK8clKsgHEAoSuAj2W+GygACO8XidNDKGPanIp
         EaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaAyLdz/ZAMrxjTi35pT/cNozmd2mz35U90FLZgKTq+fM4wpVvppDSUp6FGAQVA9pwYuoaUUKop3OO4o9kG0S0/KvrVk8qtNW+za6R6MhmovnhXqLdC7Ou37zovMuHH8pKWThsZafy
X-Gm-Message-State: AOJu0YwB+u120/oR7ixsb9EN3a1eb+mKA5JOMFCy7Q9ZVRjSKKgGNLcz
	nbW4Jkn6sQOUBqNNmcp1nzrWH/cvq8bz/BCTUWTAIRjXlyKJDOT3lFo5EC5tyuE=
X-Google-Smtp-Source: AGHT+IFkFVTzqO9wt7+zowZbuHmqyW/PRJLLlrOoZnjBwhAVQVBK8JcGDwoCBrl6oWmrcuaaOuwUDQ==
X-Received: by 2002:a17:906:f802:b0:a61:c462:c612 with SMTP id a640c23a62f3a-a6cdaa0f583mr45906366b.53.1717709036595;
        Thu, 06 Jun 2024 14:23:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:23:56 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 03/19] iio: chemical: bme680: Fix overflows in compensate() functions
Date: Thu,  6 Jun 2024 23:22:55 +0200
Message-Id: <20240606212313.207550-4-vassilisamir@gmail.com>
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

There are cases in the compensate functions of the driver that
there could be overflows of variables due to bit shifting ops.
These implications were initially discussed here [1] and they
were mentioned in log message of Commit 1b3bd8592780 ("iio:
chemical: Add support for Bosch BME680 sensor").

[1]: https://lore.kernel.org/linux-iio/20180728114028.3c1bbe81@archlinux/
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 812829841733..5db48f6d646c 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -342,10 +342,10 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	if (!calib->par_t2)
 		bme680_read_calib(data, calib);
 
-	var1 = (adc_temp >> 3) - (calib->par_t1 << 1);
+	var1 = (adc_temp >> 3) - ((s32)calib->par_t1 << 1);
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
-	var3 = (var3 * (calib->par_t3 << 4)) >> 14;
+	var3 = (var3 * ((s32)calib->par_t3 << 4)) >> 14;
 	data->t_fine = var2 + var3;
 	calc_temp = (data->t_fine * 5 + 128) >> 8;
 
@@ -368,9 +368,9 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var1 = (data->t_fine >> 1) - 64000;
 	var2 = ((((var1 >> 2) * (var1 >> 2)) >> 11) * calib->par_p6) >> 2;
 	var2 = var2 + (var1 * calib->par_p5 << 1);
-	var2 = (var2 >> 2) + (calib->par_p4 << 16);
+	var2 = (var2 >> 2) + ((s32)calib->par_p4 << 16);
 	var1 = (((((var1 >> 2) * (var1 >> 2)) >> 13) *
-			(calib->par_p3 << 5)) >> 3) +
+			((s32)calib->par_p3 << 5)) >> 3) +
 			((calib->par_p2 * var1) >> 1);
 	var1 = var1 >> 18;
 	var1 = ((32768 + var1) * calib->par_p1) >> 15;
@@ -388,7 +388,7 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var3 = ((press_comp >> 8) * (press_comp >> 8) *
 			(press_comp >> 8) * calib->par_p10) >> 17;
 
-	press_comp += (var1 + var2 + var3 + (calib->par_p7 << 7)) >> 4;
+	press_comp += (var1 + var2 + var3 + ((s32)calib->par_p7 << 7)) >> 4;
 
 	return press_comp;
 }
@@ -414,7 +414,7 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 		 (((temp_scaled * ((temp_scaled * calib->par_h5) / 100))
 		   >> 6) / 100) + (1 << 14))) >> 10;
 	var3 = var1 * var2;
-	var4 = calib->par_h6 << 7;
+	var4 = (s32)calib->par_h6 << 7;
 	var4 = (var4 + ((temp_scaled * calib->par_h7) / 100)) >> 4;
 	var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
 	var6 = (var4 * var5) >> 1;
-- 
2.25.1


