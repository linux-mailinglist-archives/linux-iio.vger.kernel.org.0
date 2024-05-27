Return-Path: <linux-iio+bounces-5364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F28D09EC
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AFC28287F
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FD15FA7D;
	Mon, 27 May 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl7QhIeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904A15E5D1;
	Mon, 27 May 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835097; cv=none; b=tDSTZplS0W56tdKA/UpNGHoBxmH0CVEAYmd6eJQbjNYHSU40yPVo9FIyiYJ5m0h20eWwBJ33Mv2N3p++yOJDPOGenfxrvbvlUmTFCPWc46WjZgMYRoAwKAMA7RqOT4oTWu6kdVMxOh65PUqOlOEBFGChRIV0OJnnfnnt2KpQWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835097; c=relaxed/simple;
	bh=tFqyr10ieLRJ5DI6lE1JW2jdiFMNDP2b+vQxz/y0vJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TT3w9EW4l1LzOTh8h9kH9pX2o3tuekaXIj7JA+pk70Q2CnSNa2Dtyz8IHV5++LSRkOPT7kuOUgIZm7e5xP746f9RFjl2CYkLOl+R8Za901QiaAm3ugtwsWYXmtQ3t2WeeH8MhN13dSjVB0iBkcLsNJ5PBB6lwpT/zNZ4AgdIugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl7QhIeV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6266ffdba8so6483566b.1;
        Mon, 27 May 2024 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835094; x=1717439894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsGa43X4Kza6EU2ZExLXgNUwaJuDByoCS0kpZNvCdFQ=;
        b=Rl7QhIeV9Jx1Mb+IIbymLmG3BzFXAmGzUhxEQVNH6LH5TQB5wWG41it0d51r1ZFVQP
         sgpKBh+pVueiit492mxiRxrAkcnDpQQ5OYvkV5azZXs01QY00ZMiQCoO44HL0zr8FyqP
         IYPiBcwWbAihOXOI+pQywOYtqgd/FZygkHXp4EoijjpfQ0oBHISaCGZ3X8yqb4Zjew2n
         sOVfnN7pJM1TlIuI4ls8Yr+Jr6ZqQPJjAMFAMhnh1gaTnCt6DJ44yjuKNZ0Acor/nJpX
         psmvmdWVGkJWZffPl3GzKGG7Ktueg3TP5xc+BCssrtbXYBwdfL6VsDIOMzdAfxAM5Ty+
         DJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835094; x=1717439894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsGa43X4Kza6EU2ZExLXgNUwaJuDByoCS0kpZNvCdFQ=;
        b=GqE/zPIzegp3vaR+weBu6kIUDKNdzdE/RVHbiufvHKZLU1EKzdnTcJStOV1Kb5ezXZ
         uTrRFpOK75yLmiBr3WPrglGx0IKdlFIdiRNXLlkUscXNFJeAp9zNbmRRjyprsjT7/ik8
         MwnQlO5gbb3X/4YPl070QRRTcFyZWDBl3LufGaVs4MTVVQ6H2cwzm6f/iVTNVfnsS1QV
         6sbLV55kHBEu3ww1gCfUvvqD4WUisoSKGa3znIc9Th2MGvh7bCOXbrf2SUN9Fi7bUjpm
         bbLKXzpmGmLbn9LupJzn8paYbxVM5vU/4VCpxn7d5EoSwGCU0mdjU3C/KC5gEqGfkJ5F
         OG5g==
X-Forwarded-Encrypted: i=1; AJvYcCV9vkMAre8gRoBRMw88BQeUbMFjt6HKNE8BkHMA2WMpx75vVM8Od23ohQEefLzMu33ZoecZSRQEQIcTHMZ+npEVR0/o27o4h7EsAPIRr9TByHWgQA3Na9pSVk+YRu1chxROdl6MJlb5
X-Gm-Message-State: AOJu0Yw0dhx63NH6L1vSqByRNGSU2u4WUb9XXhuTzcF7c05rus7pAvuf
	WXlbIbhSVzxPoZ51gp/Ek3e1L3DqWyLg60VgVS+6EsKufUw6V6sl
X-Google-Smtp-Source: AGHT+IEmGSQMC3M5YeeYosybrmsr18vOr2yKbke9bbguDCtx2GZuViYsDvKZ1K0/w+dZk4HnTAZk1Q==
X-Received: by 2002:a17:906:d057:b0:a59:a112:add2 with SMTP id a640c23a62f3a-a62651122demr594771466b.69.1716835094383;
        Mon, 27 May 2024 11:38:14 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:14 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 01/17] iio: chemical: bme680: Fix pressure value output
Date: Mon, 27 May 2024 20:37:49 +0200
Message-Id: <20240527183805.311501-2-vassilisamir@gmail.com>
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

The IIO standard units are measured in kPa while the driver
is using hPa.

Apart from checking the userspace value itself, it is mentioned also
in the Bosch API [1] that the pressure value is in Pascal.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L742
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ef5e0e46fd34..2c40c13fe97a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -678,7 +678,7 @@ static int bme680_read_press(struct bme680_data *data,
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 
-- 
2.25.1


