Return-Path: <linux-iio+bounces-22366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFDB1D0E5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 04:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EF4560E87
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 02:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BB18DF9D;
	Thu,  7 Aug 2025 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk06o5uJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBF9461;
	Thu,  7 Aug 2025 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754533537; cv=none; b=qi+76O2dYRMXbzemYrFVEOTFFcIRxSpMN4HBj4EdKx2HSIOF20rAUellbe+W47/JcGmwgYQ85Ovv8wGC+OPeSi38DF1kvqN/9ZL1a+bm4Sz9R6E6YvvQ3sFoc1/tL2n/mbWeqr3g8FHAqvvi22VRBAv/jtbcxbl34UWG3W/eIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754533537; c=relaxed/simple;
	bh=VAcIpiYbNavCmEfofOSZSFkC8vdNWnYR59BMZcNhK40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LuUBybthRGzSQ/s7joG2MTexTSMZRCcOzVGAbkS1sTI6iNyZIEAMetn3hJTzRlYdIwXMJ50E+ZpvZFcKQpNqNlVOrtCfbolkF8CaAmVnaKKDPgrv/llCpgl/i1uKFJ61e0hsC/M2VX1rC+y62WkwZ0yocCWtWJIxPlrazsFAzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk06o5uJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459e72abdd2so2639615e9.2;
        Wed, 06 Aug 2025 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754533533; x=1755138333; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOKfp/L7cUWb7rrl2maivCk72RO8hyn6s6ZLI+PKx/o=;
        b=Bk06o5uJS4PRePzh1nCBKASN483ivScCNp99PRLXmO3Ue+m9H/OTN5ACtZlBhuvnvb
         UicqibgsieVdqPRh0sy7Ba8nYoFeujrbHqBBPfzHwiw4J6iBlUx+I7XO+zSssnWy8vj7
         9vRjY5EaLS8lmPXo+QBN8NY30TTFxNJGIep8fuMe6q9+26fcZ44vUhHeQBd1LPVusc7t
         UbIBhILlADfdHJtHOhZe/u8iaRqn0y4o8stM+LOrt8BLK2m/ospmQ8gSsDL3qSJh7MVk
         7bNCaz1Ph1tWmMjYSY2loZqlCsudB+AL/5gG9XYKbhm7xBHCWWEB/x00kFGNkrK0h7yZ
         y6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754533533; x=1755138333;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOKfp/L7cUWb7rrl2maivCk72RO8hyn6s6ZLI+PKx/o=;
        b=d/a86Dq5MiQZzMrQV7MUPKWK7JU2A3V6e0uyg+NYFq0kix9uo+VwDvOIxXz5IhzIKl
         T4Y6THUwkz7dXhRTG6KNWr6SavGS70aKOgq7wMW2g/Na8DrcVD7obGy/DQ1l8cKBCp7P
         N/IrpAbvImM994X5G3+JeLy+g4+LGyvfOdyW3Ms1GyQKdUGnXq9os2ZHJOuirtQUEMBe
         xcg4ZCn3ZmwZXUMOP48MaCOH8ucgvvFXdKUMlN5QJDfpJACzeudExSMH5P6mnlwHNPlv
         FPLbcM89Vn4sb6KDvDO/V/tu9dGMNehCxlHBOe8a47Y5h334OZK7MW9IXTe7BARVnkPS
         vjzw==
X-Forwarded-Encrypted: i=1; AJvYcCVlJTaNYCUInDOgnfgsAMs7qc8MWSaHhlDqbjK7L8DlYmhic+epDhO4RNOEsOq0fzpdN+gpY1l5wYw=@vger.kernel.org, AJvYcCXi+/HzXKkoZBN50T2kAAOhyp3xBo98LafczeGGEsrr5+ZA6ESFuhDsvvw6nmrrq/j3VIqSZ+2ayV0XEQ+j@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2aIz3Nu0uZyn7MgQuZS+TJOh4fnilynF4DshSBLg0szdQG08
	zuQ5WFTRSL0P9Rv1RNsyGjVZNYaB3FHf3FXUtkbmjNNkN9Es8hU6efcp
X-Gm-Gg: ASbGnctOxM3QSoDp0Sy1GW8g2tAea6WuBfVjLNASIBM7OJCFKZDL/6O+7aog3O9WskC
	zjTxfGgbdjCDwtXLsUCK6MVS8F7quu+5BKT26efEp/Hv0zBct612Ssz+PwVC7xNU3dn7SktRzQL
	5dkS9f4hXXFCSBe6CjOl2Ya+5staT6qDaY6TfEHjNxjy6De50syf51U4ySwDfmtcHVwcgoye8Cr
	ijd5k67sp2qKcuHEVzV3j6gQy9uqy4qJVMbOJShVfb1wa0ypihrmu8vGhBWUUSNKcpl3CUyt8Ju
	IYQwCMhoeR5Z/4p4LzhkMbMXYOWxDx3aSNSTGTaycLlM7ymRPziZCzctkWJtKomrtFcAkplkpUw
	Bm0lTKdVz5nYVgQ==
X-Google-Smtp-Source: AGHT+IGBB9KM0Ib9EDpmFrm/9F91UOoVAow/2sfdHRugEUByN7CAkUGUQoPYPelIYkKFg2ttF59I8w==
X-Received: by 2002:a05:600c:4705:b0:459:d6a6:792 with SMTP id 5b1f17b1804b1-459ee88642amr7173615e9.29.1754533532698;
        Wed, 06 Aug 2025 19:25:32 -0700 (PDT)
Received: from pc ([196.235.182.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e585586esm76552915e9.13.2025.08.06.19.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 19:25:32 -0700 (PDT)
Date: Thu, 7 Aug 2025 03:25:29 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v2] iio: pressure: bmp280: Use IS_ERR() in
 bmp280_common_probe()
Message-ID: <aJQOmQKO219rS8ZN@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
Check its return value using `IS_ERR()` and propagate the error if
necessary.

`dev_info()` has been dropped as it was considered noisy.

Also switch to `gpiod_set_value_cansleep()`, which is safe to use in
sleepable contexts like probe.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
   - Use IS_ERR() instead of IS_ERR_OR_NULL()
   - Drop dev_info()
   - Use gpiod_set_value_cansleep()
   - Improve commit title and message
   
 drivers/iio/pressure/bmp280-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..be6c981a4cc7 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3213,11 +3213,11 @@ int bmp280_common_probe(struct device *dev,
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	gpiod_set_value_cansleep(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.43.0


