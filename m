Return-Path: <linux-iio+bounces-19800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4ECAC0CD5
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25841B60CA5
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4D28BA91;
	Thu, 22 May 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="doBLXO9U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CD28C872
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920611; cv=none; b=tKR6l9CU5Vo27t9CEGCSkPuGZvAGKzthhp39e9+wjfSW/TI+J1cSDw1hLhfBBeuuulL2QQucJqGlQOFqfbebj8qIksgwooCTMR/i4SGLNgaBRNpwcTG6PRM+R1susbnpyo9e4xbhhTasshZoftbHOUiD8DRF0sMAwqK/EzTZ7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920611; c=relaxed/simple;
	bh=0nIe8gZGvoRF2DsBrKBsu2KJOvKQjVrW3XZFMPilYfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cs8vWQQh/K5XMkED8qKPbPqIZJSgE9verRWA37Yd7KOVyoQr80VuPDr7I5KLO5WJ6pUqJhNhxpWppYGPNFhw3WMh4xg2uC2z4gBrnu2xT/As6DksNOrStj17LM3uiynMaKkJmfWh0KNKESmJQd614+lW+NcRqCoSyNHL3HFdVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=doBLXO9U; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso79869325e9.1
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747920609; x=1748525409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zedGelCVtGkH8UnHqcPHmZh/ZtT25oJw7cbep5q21KQ=;
        b=doBLXO9UQM6LgCUyv0dVeD0Ln6DU9wNyNEroe0bp3r1vmKDgoAI8JbhEO2Qk3iX9gM
         mOmXbRb7CB4DhqszWLMzk2zjsbhvY99QqXFogqpMsUHoqKS9niO4M9gxQtec7N7V8gQD
         Me5lUpICXEIpmD1wS65pVv7goHJ+gvrFoBEvGsrtC8mxWmZ8WBOT25Zg2ve1D7jWf2NC
         mJT1deFY6jPSgncEB5j9W+0eSlHtSvzlA1zAayTCmo59G+kTFVfDrZbQFYnVVfav5UG3
         SES2WQEPnTmnUzMR3AmQCb8jR5TD8RDShIzPRnUL/2ki7kQ5q+EmMb3qiX0y8hjG0nPS
         W+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920609; x=1748525409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zedGelCVtGkH8UnHqcPHmZh/ZtT25oJw7cbep5q21KQ=;
        b=vS+GZhH/oSOKB2qmMEr1vb8WAygBRkhZ5KK5i/6rTY9o/yHiqE+YAFIZFaN3p58Ldz
         KHtBDmhSg6lwWiOuiWaxLClz+y1JyWagGrW1Zy874JEpe3l5Ouhi7zRaiw3Kt8xErxDu
         fe6Yqg9CjavTKIQ2WQuT6uNl274HvbhERwAo/lu/U5OtR83e1kyNjMjj74XAbl8skwyK
         Kv3DNFKrzUiqwFD7a3KZwR7CuZogQ0OjKV7fv2DvTC0rwjGCMzU4rXXLMtAvB/yf62TG
         d/fsaU3CSZgaCGQ5dKUHcs/n5okeQP1+Y45OQ1Hywai+JrTxgSv/98GCqqzLeIpahNH7
         sFgw==
X-Gm-Message-State: AOJu0Yx3cagurpoWvQsXFtYQZz9ICAx74U0gS/CyWQ8bhhbTY3ZrJjKP
	PHsd10pC7N6rFON6I4OptkmA9OAoIB/oKY2lTSQpoAcJMhIqzijPjIPvxSFFrYnf8hE=
X-Gm-Gg: ASbGnctolX22iHkhCFPdNRZ4ywIQNYuGIzwRctuFH7Fqfq7NK5/E1Nee79PI8VIOBOW
	dmNpydcz6ng21py6kBTuqaZFI5qPe8nmY5aK9boppa8kGKZf1Wk0OGMfeVb2t4eodt1GL7Shwfj
	OmSuVkf66+5yTxujPDhobuhJlxWXJrtksnyeehpDDi3yZteNUIxqnAw/g+1pqgJy+QwXzFNp2nv
	fmaepYAmxRFzPZkzksGOL87SvHj9bvaHFUFQ1n71/zZQumvjCoSt942MTnV/ED1lA4aAu1G08WD
	K3fPlaopSPJ1/LpHoR98jeK6KFlnGlPQUFxDlDExm550pFj5blBHaVTS9H7EoEhhkmQsrmYt4zf
	Juw/gD9FfVKjeDD3BQ9HEV5KkO7UuL5Y=
X-Google-Smtp-Source: AGHT+IH+K32qNT/ePQRSF2E0pqSrNhSULvgvzcbuq0HC765uEjE9Op/hJ16W1+SFbnnKw5xt5IFglA==
X-Received: by 2002:a05:600c:1d8c:b0:442:e109:3032 with SMTP id 5b1f17b1804b1-445917d2a0amr152237185e9.24.1747920608592;
        Thu, 22 May 2025 06:30:08 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0b20sm109837585e9.14.2025.05.22.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:30:08 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 22 May 2025 15:27:06 +0200
Subject: [PATCH v6 5/6] iio: adc: ad7606: exit for invalid fdt dt_schema
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-wip-bl-ad7606-calibration-v6-5-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=NW1JeMg0S+0gI2cAzi0BWwFNupEZsJYBOb/eiNBCbAk=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQV0t7/bf47Y2NQe19O/43/DA9Xn9xbYH61HczMyNOq
 3X+5Fl3qqOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBEQlYwMhxcZv5+0mq+PfGV
 GWorjCueGKy0u7fxtbSNQIr5uZutYr8Y/kptFJTeJZJr/b18a6mJSM7JV47N5evmvv29+cpWNxV
 zHhYA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ad7606_get_chan_config() fdt parsing function to exit for error in
case of invalid dt_schema values.

Idea is to not allowing to proceed over when there are values that are
not allowed from the dt_schema.

Fixes: f3838e934dff ("iio: adc: ad7606: add support for AD7606C-{16,18} parts")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index bb0c89fc618874f4a5948d8e537716f87127bc92..f832fd0daf50a69a892636018bda2e43f73d1570 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -319,15 +319,13 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret)
-			continue;
+			return ret;
 
 		/* channel number (here) is from 1 to num_channels */
-		if (reg < 1 || reg > num_channels) {
-			dev_warn(dev,
-				 "Invalid channel number (ignoring): %d\n", reg);
-			continue;
-		}
+		if (reg < 1 || reg > num_channels)
+			return -EINVAL;
 
+		/* Loop until we are in the right channel. */
 		if (reg != (ch + 1))
 			continue;
 

-- 
2.49.0


