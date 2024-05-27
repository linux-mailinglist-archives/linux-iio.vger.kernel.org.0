Return-Path: <linux-iio+bounces-5366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F321C8D09F1
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C971B2157C
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBC16078F;
	Mon, 27 May 2024 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzFPDRu6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E215FA84;
	Mon, 27 May 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835099; cv=none; b=DPIeg+svVt7xKpnBIdDvuK0xHUgOKbtHYam8H1Q4iSZYvmMWjiNlO2aOPOgejuFqwu75UPcTj1cuEKQ5E/LzkkjUDWWw1FMn1GjEbt7d6Cs4hkW0iLyfipYC9lAMklpyMew9wIFw3MSHYzgJw3qC3io6f+2ipSRse9qNTLr3cdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835099; c=relaxed/simple;
	bh=01VTqY+UiDyJ+F6bLOiuC/A6F1/dAPjefl3eUzDwQxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkilQGVpK64rBB8RfGWXbWhqz78cKe71ZgB8kbAeU0Q5kYrrhGOmf8xS/9PO7LLdGEy4gaTbxT4ZI0DxNfLdc8TXyprsC9BB3yvEkfSypRWMABar1jkZMXizdyNa68dQycNOm0uDm0Lm3V3ALjKNlSe4XoXdPnP9b/Rdbc9M+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzFPDRu6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-529aa4e988aso61827e87.0;
        Mon, 27 May 2024 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835096; x=1717439896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFkYxgR+bMKdGkSXBR5z1iRX3ThnVE2piXmkmWSpRvg=;
        b=VzFPDRu63eTJNAmOBopg0IdKhAQr4Fif1jqjrum5fiCuaXEEa3Ubtij+5oSaPud+Lh
         s+DHl95fgce2AygLzY3sJrsWl9VVt8+wxikxs+V7Xg6d8WZxImGPsH83yzCi/naEjuRe
         ShrrroD1uC383Oz8lKxPLynSHI2BfRETgCy5gSMpoKRi4LLuBPMCADtJ5dTvuPaxV3Jh
         +v6Lk4JXqoZQawfOAZemxGs4B3VFS21rlkg7Qx17AxOJgka3Xd+HmhRK4poN39br7iuk
         kIU6NAbkINt1J6pT33UA4DAfbSPxiB0P9Gcg3CXp2iD9PeAW0KCLP/m2pu88MKmBNeDO
         rbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835096; x=1717439896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFkYxgR+bMKdGkSXBR5z1iRX3ThnVE2piXmkmWSpRvg=;
        b=N7Sj0EhSo0HoB9NYRMpfq7FOACPrdSCAC4YyrhyxxPdiz8cGAlcII8pH0MCJdGJhF/
         YmXAYJmmQI32ZM0gpdWAHohx6w8xpSQbIE55VyCpXAJQscSdao8zO2a8mRQEMT5nlfOb
         TYQmd3MfrhRYLXbnXeY6zNBq9eZrWBFVmmu8gsWRjuThE4mSl7JfeBXrb6GkLXmrelLR
         nDhB1rtoL8373+q+dK79PYJ4g8cz1WJ+XLSiJx1pCjwqxX9ZIcSl5cT/QaA3Tj/xwU7N
         yT/RsOivu5h1VFkV/ueKXMd+4N7GwmvNVPM0ch1nc6cN+T923vKaCHitw/yTMkoPFp9e
         fhqg==
X-Forwarded-Encrypted: i=1; AJvYcCW3fvXYHweDMxNZvTjduLZw15AdZtOTvEZNpi3snsywoHhCXX/xExvJ5pmOMiQrxF5CI+LLrH4+I2kDI41FpCGasNjhdJTZ6M39eAEHaOMTN5Y4ezAIYTFz1taXszS2N0qRzYrB3V2m
X-Gm-Message-State: AOJu0YzzH+0odBNzZ12y66hHK95EeWATwAcRVIi15cBGuXJZs0r/xMce
	7NV5GiuMPoQm9zznEIc2o/XemO5AqzTLiJDdTDx2J6hWvKFAtIsX
X-Google-Smtp-Source: AGHT+IH7f+zo8hCc7VUWF1TqYVddzQsSIQq6gWDfjZu9EcNDQe3FJaVzIQ9iJp/2lScgxX8qpc8saQ==
X-Received: by 2002:a05:6512:313a:b0:51f:4c53:8e4c with SMTP id 2adb3069b0e04-52964caac28mr6220554e87.33.1716835096244;
        Mon, 27 May 2024 11:38:16 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:15 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 03/17] iio: chemical: bme680: Fix overflows in compensate() functions
Date: Mon, 27 May 2024 20:37:51 +0200
Message-Id: <20240527183805.311501-4-vassilisamir@gmail.com>
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


