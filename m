Return-Path: <linux-iio+bounces-5904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C98FEF74
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438951C24B8A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABB19D09F;
	Thu,  6 Jun 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yW66KuM6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB49196434
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684021; cv=none; b=gzeBVu0j81Dr7f4VCdMDsvdE7bd0ADPfQNYUpOfUlUZEzAJA6slvQF6ppW6f7+i/40iZSNWSzcNwf1VMJepB3fES4TQIh2LeDoK2blXvnBMKLDmZujnvAxHdW6I2nJI5xcMPCNmEgI8FxjS/qP/X7FU/5OaSqdCpG6RrosJmvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684021; c=relaxed/simple;
	bh=ouk3F+cKMwX5ogn8ACbnak02Gpi89OqUx3zLGy1oywE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6SKVUso+LrkU9IbzI6zuzchzED25bXfEn1TJssM4hMa7Q8Xsoh97wpS8Xp09ZgAe5iJYIMOUgBW4bpXic6qQhBqT56Rk+x6/ROoukeaP9HgN6tZ/f5Dw8LdpNaRaJ3y7khl+/akmCi48Ip0m3SGPgPt0Cu/TXhkb4gwBet9j2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yW66KuM6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4214f52b810so13529025e9.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684018; x=1718288818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDK+z+BE20Ye7HSxPtyubObznbtw0Pl4ppmqVjNx6fw=;
        b=yW66KuM66NH2r6bn09pOISvxMWwEUbU/45/+UY1TX08fjVNDvZjvwIdpHL9WmurU6W
         db/KQhZHJqfV7COgxNvZ/CtU2Su4L6DLa0jDXTkGUy0hg4kqsVPURBoRbHzepcl7pjy0
         HH6TqeIpCr+FLQ9jP4LG0bgm/jWbD/DMBpAp+OhYM+oXtWM2NiUoexqvipNInhG/vCW0
         bFdYhPM4aM6zzRPEeKIiX/a7QovyICSyiuz1p33gD+qfDCpVqcxqQteDH358/D4BRjT2
         ruKAQ/B45hl+5JH74dD7XhyX3DR+0qwEBnXnzTtgwcwFVCXxKsJ4hsGMj8xOYjtkcf7L
         fEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684018; x=1718288818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDK+z+BE20Ye7HSxPtyubObznbtw0Pl4ppmqVjNx6fw=;
        b=L6Vj0sjplc1UEGDYTlCkAWKwSoh82wE/aNw+rUQ7Wuf+7lIP11HWkpwBc7kqphGsxB
         +JKE+jwqlE934X0AMBq59HQ4KF/Ncypn/CHmFdMr6kFkPcy/w5vWcYJ6x9lZMouAvpc0
         J8av54tf5cqFnd+C4VCjzge+XrbDWShEvlzltl/hkVx0a22nfg3w1DCn2dtnBrnR/bk8
         1xYEjb3vetdVNx1T1CVr7/o3VYtlP7kN1NvhIpiQHaDcqPZyL3hhpTIHCBtcAthKZIEE
         RulGFuCE8Uqyig8zP/hm5XcPXzzA54mm+igjRSAAEyFvxF2zNeA4HmoBY5HjKKmk4wfg
         3HUQ==
X-Gm-Message-State: AOJu0YyV+Wo0Y/Wo5u5NDJxjvk+xc2MMiuVm7yDM8sZuAzIipG4yOBOn
	mVJxzH6rFVTl7DlhRHOevCrUR9Cj/wKQPz1um6MUmKV6C0743okVWyCaLNHW7F4=
X-Google-Smtp-Source: AGHT+IHqQD6kE3Sn25NWW0JWMcICj8nLQOU+AAyrH3gprNKKI0oFxr4HW1z8KPG80qivMhGLHl+wuA==
X-Received: by 2002:a05:600c:501e:b0:421:5d4a:7286 with SMTP id 5b1f17b1804b1-4215d4a7a35mr20202255e9.14.1717684018640;
        Thu, 06 Jun 2024 07:26:58 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:26:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:43 +0200
Subject: [PATCH 1/8] iio: accel: adxl313: simplify with
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-1-320b291ee1fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ouk3F+cKMwX5ogn8ACbnak02Gpi89OqUx3zLGy1oywE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYccprjyS2LgwnVtWogEoBWpz6wTM8bKGrrNsv
 gyCXV4PYKyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHKQAKCRDBN2bmhouD
 10+PD/0fnjJOmN3+DsIsgKEflH8Zhh5ToHHuYLzsKBz8wrBBGQhzGEv1YaZZd4EHycKRqe6DBgP
 gj/tyV62r4nWHIKpNyUIjwiQ35mshEEZC0QixeB58QyfYMqHVEmEDIPpU1rffMTRnhf+Fzon/l8
 QiP5Gz6dKOIDbimfyX8FkrR4VK1MQ2upW3tM+UYCTRmAaycEl5K8Zg/hGQrFyvjyuAalbd17x+X
 SYllu7li8dAc5jJSvAASJWsMC8MOllcIMD2qmL7keQ/vUpUngukveGME1NFjq8beiQZJpSIBfJc
 FUvLkeovuNUjlwxrHurPaW51485yq5/Ia46Kn5b7UmdUbUBKh+ZuX8lzJfJxHVDmXMB8Fg5OOwg
 LH8+qj5uDc48GSxGUSYJQxl6B/M3wV9EycEXm03N5OxfcDk02IoZmTmulPrxhwfJtq/Q4176Oi/
 DHFqKeuvhOzY5Kq/SWIT+6A8cw+a5NMQ5gfgxO+aq/cPIujM5Ifq/fw1HeqsmPu2+kY8d54YTL/
 0Y8Ow6BRgXafpVzPSzELW08b0adD8YK6vOA65htaqqm+00cs9b5p5+ezzANp+AiEK3k8kcUAwPL
 gOx24+rVtQjsmsRXBCs5kIPfepGET2ShMRAHXogg1lLz/AxsbqDxzu0yV3Pta/sAAIGYYdAWA5r
 OSW1FVLjh+UIY5g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/accel/adxl313_spi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index b7cc15678a2b..6f8d73f6e5a9 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -72,13 +72,7 @@ static int adxl313_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	/*
-	 * Retrieves device specific data as a pointer to a
-	 * adxl313_chip_info structure
-	 */
-	chip_data = device_get_match_data(&spi->dev);
-	if (!chip_data)
-		chip_data = (const struct adxl313_chip_info *)spi_get_device_id(spi)->driver_data;
+	chip_data = spi_get_device_match_data(spi);
 
 	regmap = devm_regmap_init_spi(spi,
 				      &adxl31x_spi_regmap_config[chip_data->type]);

-- 
2.43.0


