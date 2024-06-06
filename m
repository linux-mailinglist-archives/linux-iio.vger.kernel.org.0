Return-Path: <linux-iio+bounces-5905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1428FEF7D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE88AB28B7C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78731AB521;
	Thu,  6 Jun 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpIGnw1o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE21197A90
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684023; cv=none; b=brzded4kEy+M2e9yJX0+RNB+JixiZoMggiy+ky0wk4E8THq4qERcxQZLeKNfRHhEpxDqcyV78l7dLmrl9ACwHKYk/hjFRded9ChOXPHYsQ+1asrrGr0EgUg2o4NXtlzF3sZ7Q8U/8zC/8GH+olQPAWtnIGmvRLfqYd1AUVWDB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684023; c=relaxed/simple;
	bh=pXJ5RZwaW0aGhveGyDMTsmks+pERpkQf7TD1iLAxrEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OfxiZBLgwPWSB+yfs5xDmLOrgBQYg9Gize/R3nL2W7gUNVfDE9j9t8NnfLnai1IM1MnKtWf94AwXKzjpqyMqeRiCEozNJ62+Vak0+mNUh/PofIbaUb1IrApNg8ezZTtty9hsCapZMN8VKuuMEEVqZ/MI4hBUvl7yjErB+i6mYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IpIGnw1o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4214f52b810so13529365e9.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684020; x=1718288820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvIjHUcLB13dE1l/pHcT1U9CkNcZCiBlbfYeqNc16DE=;
        b=IpIGnw1oCaLlJl6EaGrfUqkZmh6bNpUuyUHrVIitEIlPD119lDMyyIrM52xoMJZyZZ
         8S49O/v5EAhrRbVVhCXBaZhlTkCw6VbOFNCwkr+2ooTASd3r7tEdMfrdu8IpIxbNrPK5
         cMUlYmB0B6ghEUT+geU/u/uMwJJcUkng+5bqoLlKyBRWrXJzoD+USnUvJ3zV6ysQBwKx
         LolPLVT4tmjJEukvUydQouqfQvpvCbF1DHb47oYcGp4+wIkV26slpBXmD6Hh+qV6nwnP
         GSb3Bq5xtcmyGGPKEn907J0Q6uq4FERFDfF8edcAH5OHHLCCafgWqNv5Dxfo25UiBQPj
         X7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684020; x=1718288820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvIjHUcLB13dE1l/pHcT1U9CkNcZCiBlbfYeqNc16DE=;
        b=FGmO/JkM/RITSuWZ9qzZ04YBdeJNG/kiPyikP2gV4B95ULQpqrvx3sW9qKA35pzfX6
         IyI5DyvUlkZEuhw4SCSl7w2gbh6cRoQ5JXVnY9JYEW2RAAPRV9IlRzBFeVVDg2Rxyh/I
         pu1ggjMbJ6eIbRroBrAP+aiUAi04vGrN1g+yD8b9245vBho0FjD7Y1BnDM0XMCweua1l
         tceUalkWg5bjTBie72/PJSecp7q7idf9dtogcD2HPCWLOUKnE8h24eFQo5j2f8bGeQ5F
         QTYfirzAPuT+xG1fJPpE0h+KWrWmOPHniEJqVAKsiI0843vv0iKgJycctEBPvISea7Qw
         79Ag==
X-Gm-Message-State: AOJu0Yx2we1Uk58L6ufJI+7fQt7HDLBxiE096+zcJwFtkJGShHG90bKq
	nGIYenI1egRhCO3pa3FwmGqaOPE/SGsGMyIaSK0jh6MeDeWhBrSwbRoJRyNv3ps=
X-Google-Smtp-Source: AGHT+IEcvghZweS3aoi5Ny823x+zSiczIX+Km9CFgpCxtTdLm5kKam+O2awv4QmT7N28BO5AH8SW4w==
X-Received: by 2002:a05:600c:458c:b0:41f:e7e6:7f27 with SMTP id 5b1f17b1804b1-4215633a0f5mr60502545e9.26.1717684020317;
        Thu, 06 Jun 2024 07:27:00 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:26:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:44 +0200
Subject: [PATCH 2/8] iio: accel: adxl355: simplify with
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-2-320b291ee1fe@linaro.org>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
In-Reply-To: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
To: Lucas Stankus <lucas.p.stankus@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Ramona Bolboaca <ramona.bolboaca@analog.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pXJ5RZwaW0aGhveGyDMTsmks+pERpkQf7TD1iLAxrEk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYccq9Lg/xM8hW2vXu4Hb3pmm56fyp8TW5HfEL
 vIyLQ3YXV2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHKgAKCRDBN2bmhouD
 1woFEACUyp4iynbgN1N3Aj/yRscdAtAupAgByc/F2itlyUnUF4paHlLIYasVOKclxHPPQGm8QRB
 UyYKY8R9Nhi5dYqteVzfocz8mF7ptw7egHjDyNRPoNtp8bzhghLH1k9neFJunB8njJdJA0bQHCQ
 lhhffs4KQAt+7G0AJ0Wys2SbbFrcVDc604+10R1VQ5Xk7o+K0Q5Dfkoj61DoBhaZ6gK5yiJi4ml
 CG1flp+3kSdkQJGg5AINg5rICMtMO/vvdTqadZzGi3ahr6217wFHPIV1WT3Pz1oOcZBbxenMmvN
 eu7UJv85lNTVDIIbcGjgsFMidg3/kYwSRfZtQnMbtCK1kp7nKvJpb7s3yWxABaCybHqgeQ64Wka
 C0shPsz/PCgYDDakt7BEXX2LtwadCr1YZ/E043qjR1YGP483dsYisHBpHC8e2X1Lc8nY9y5l2jT
 UaRA4uWHEAavaUNMVtYGYMh4kmiSs7stslG4XeIDi3h4GXdYMvHsM8l4+BFfPf8FgNMuEiyLUwP
 OR1zD/VfctsRLh3ZuttmLsmw14DNfRY0l8ofdiRlBUepJKiucUylx5SjEi80g1XPS/PwrfASfzL
 M9+fQAfbaaV8d9HEjxkmYVWd7lZHgrw/UkMzwg41eTtLcl1oO6cMcwj1Sy/35nOJYtXdw4mM/sI
 2G//bG2H1mXj1RA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/accel/adxl355_spi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
index fc99534d91ff..5153ac815e4b 100644
--- a/drivers/iio/accel/adxl355_spi.c
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -28,13 +28,9 @@ static int adxl355_spi_probe(struct spi_device *spi)
 	const struct adxl355_chip_info *chip_data;
 	struct regmap *regmap;
 
-	chip_data = device_get_match_data(&spi->dev);
-	if (!chip_data) {
-		chip_data = (void *)spi_get_device_id(spi)->driver_data;
-
-		if (!chip_data)
-			return -EINVAL;
-	}
+	chip_data = spi_get_device_match_data(spi);
+	if (!chip_data)
+		return -EINVAL;
 
 	regmap = devm_regmap_init_spi(spi, &adxl355_spi_regmap_config);
 	if (IS_ERR(regmap)) {

-- 
2.43.0


