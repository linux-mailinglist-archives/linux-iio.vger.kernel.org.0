Return-Path: <linux-iio+bounces-7343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA69286F2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB24D282159
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25A1494D8;
	Fri,  5 Jul 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tog5x2NA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3E149002
	for <linux-iio@vger.kernel.org>; Fri,  5 Jul 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176061; cv=none; b=S+/f1dGI+fihn/RBCWgXFcWW8dnA7Jfq2rOg57/Uty4Zkoo93Yuoh7IzAMlQ4VA/wXv9zwr+sOZt+A953vfdQD9mcDi0v6LqTSrfviDh+CafPJOiOpIvenz2ph3JQO6CB/7yRUia9QCMp5Lq4dgnaoVB3TPbEbCToZk0KbhKilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176061; c=relaxed/simple;
	bh=p8oWdKJIvI/s9h6AmtHd1y9/mEFkDnWkbWLkspoDv58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4RdQt6ZMG9OLWmeqxCOK1uD9TU+6tvliWmVb/dgTTZx+mbmwKapaZdf25eogd6RSh/DRntoJMw1hAnvEIWlE0xR542Gejcl+QiTYh4Z5F2PADB0ta6E9i4Jqlvk1pMaegKQvUyljWhofYnw3fHLYxf1729dGBmiS5ATclQyH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tog5x2NA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367ab50a07aso298494f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2024 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176058; x=1720780858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7oWBhtqk3xwW6JyxZwaMMLkFEk7F/Zbtq+Lnku9XgY=;
        b=Tog5x2NALYnHmcso3U533v4FSLGzHqEAnqN58d4BAiyJ9nIqu/fHU+mB1lD5H7ItwI
         icFR9v4oCU/5AYdnK51IV02LciYmeyE2ipYaa69XFntMOz4RFBlZOVF2RNxx88nj65/C
         L0ssJOPV0JQqGgaa6iL3/u/Z5yQ3r7mvuwyBdREkey79Ib56JpiNMkuFrYbtjFspe1k0
         S0610MV+Pe/wSjbmF+QGjFcxBuylRLiqQ2epkanC51bU904zEl/tP/zAP69b0OdpfNM9
         MDGO5BRG1zecXl5FWavpgP75IIp4rKgBaS25nHWUoDmuYjF4QU377jVrCDmzlTZbAln9
         eNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176058; x=1720780858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7oWBhtqk3xwW6JyxZwaMMLkFEk7F/Zbtq+Lnku9XgY=;
        b=tRTUJfp+4BFVQE4zx9BNbz3mpq1WMfViRuZDnsrEdqqR/O1pmnfmsEclgNGOKG7sYM
         wzF3hhEZi1i2yduJZhdr77AfXt/svOszM2OttcAGpNXrpF1eFWBKTtsHYMd8pXIcgKRQ
         ezR7cAqKIw4c3Efzy9qnQ5vyhrwgC13D6Bm7REftUEmQ6JQKQzDa3hdBIN1QECQyCfEo
         Jr+StxsVY0TWB6hhPeJCSQgXj798dypjDJwGjkk3T/1rChoTFc98cpUqPykSi0gjSHNA
         cGFQLjY2btHE05USwTWesMAYdHrsYuFJNIWgkBDM87bEjHn7hqlqTdT2VkRSDFDw3hN6
         LrAQ==
X-Gm-Message-State: AOJu0YwS00xPZFSbgv9dlWrLX8y2kJR8LnkERk9pm6EvhV6YoXGn128y
	o7sTaykBLu3Clv2FH12CClOeSbYji4hvm8O5NbXn8hxai7lHROdg2TA/mm/XItM=
X-Google-Smtp-Source: AGHT+IHPMMzu5kdlcoZYnKj2xBCDHrdAzNmKY1tb0qjEiMJJj0RsjyKrxPl+gMGzYZqJroN4prirIQ==
X-Received: by 2002:adf:e68a:0:b0:35f:11c5:5c74 with SMTP id ffacd0b85a97d-3679dd34d4bmr3095033f8f.36.1720176058373;
        Fri, 05 Jul 2024 03:40:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:40:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 12:40:46 +0200
Subject: [PATCH 3/6] iio: adc: at91: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-cleanup-h-iio-v1-3-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
To: Dan Robertson <dan@dlrobertson.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=p8oWdKJIvI/s9h6AmtHd1y9/mEFkDnWkbWLkspoDv58=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82v0r6Jh34sMwY1mn3FW86/CEhm6tM4W7RnL
 uiEVj4Vr+mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNrwAKCRDBN2bmhouD
 1/3TD/9Na/SvzzL4bKKGkbGVC3TdFpp+yHgCyH52qQr8o7KQlHBEJKaH1jYv9NZmWAfRjEp/6WM
 DX8l8spwS2QfhfjRD61w2RJxeNHKpMOhfRUVIL3iBAHrwDkv2wUlIi6iYH421pgx8LKaMK7Oadh
 ZI8wacXDVGz0RHyrdOt5dYKeE/bzhdXMc6PD3z/VfdipVRtAkyUqdkqaof9EW1cm24JddMncVl7
 GgUa2VE6T9e59sqS3YfaM3QfvlZsxRdPFfGHba5PyoE4dUv0ppeTyKzWouv9GySZayvSnNVDQmd
 Sncvw4nm/LyKQKKIpLpjRv6t8r4aKWGastRB8/Xkq/6CaeR9geqf8/cepA6LiNsd5XqtTMgyCy0
 x/tyceFDPl7QQaZXKGuD4CbscN2FxQyZYNsxx1YGEopceTWnUa09mmhHCGKCnCJplvXIlHGa2F+
 fHZj0Z9dGL0kS8rP5ZdeEAZ+213jyU+fzDu9kapEegaH/3ycs+i/+6roOFLOONLTdJi3kbfykKl
 HwM/9WrCzw2ruPd5Kx1vu51mz7IU9QgbsKj9QqfhRRoxvK/9bKdWhvOLBSkz4ofs8CbE1zpJSFi
 eiARICHKU25nhyGaKKZUWQRdrUnt1N6n1Z5Xv7340vFdMMvK5C58k/NoPAoimRL1HlKPrF7Pery
 tEe0GOCnirntzpw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/at91_adc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index eb501e3c86a5..7bcda203436b 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -543,22 +544,18 @@ static int at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
 	int i;
 
 	for (i = 0; i < st->caps->trigger_number; i++) {
-		char *name = kasprintf(GFP_KERNEL,
-				"%s-dev%d-%s",
-				idev->name,
-				iio_device_id(idev),
-				triggers[i].name);
+		char *name __free(kfree) = kasprintf(GFP_KERNEL, "%s-dev%d-%s",
+						     idev->name,
+						     iio_device_id(idev),
+						     triggers[i].name);
 		if (!name)
 			return -ENOMEM;
 
 		if (strcmp(trigger_name, name) == 0) {
-			kfree(name);
 			if (triggers[i].value == 0)
 				return -EINVAL;
 			return triggers[i].value;
 		}
-
-		kfree(name);
 	}
 
 	return -EINVAL;

-- 
2.43.0


