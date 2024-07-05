Return-Path: <linux-iio+bounces-7341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 243759286ED
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F85B25314
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97704145B20;
	Fri,  5 Jul 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL3b9PJP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB722313
	for <linux-iio@vger.kernel.org>; Fri,  5 Jul 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176056; cv=none; b=L6s5lFiBICeXdScCciStswpmtcxPjcN1N3GMmfznjERD3sU579fJtEhDrNOzSo0gDJy6Qhpn2Os677kWrl1tRsoruqVc1KHOlu1s97Vw8eath1yAn5RquZCd1A3R2GghY8VqHwqsQINEWTWPoy9ygZUnFlCuiiS37tEj+Itds7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176056; c=relaxed/simple;
	bh=RkNmPr60yh76Qvmt5J3LbD5Vz6H4ie67KM+JSqZsdJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tUowJC0eOQNZGVu/tCQE4ZyV4e/NgWXD04DfvUHxtISMSFwc/iLpNhK1IOoCTxMtO2OeGAZEA3JSF9aoFdoShI1VkQjVk/AiBn9nzJVNR/6QvOuy8dljJSbmeRSrSMs5KHIjZGG8UgT++A7JU0ZDxKTZe/Oo3d4skAkkpBTYiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DL3b9PJP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee8911b451so17593741fa.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2024 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176053; x=1720780853; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1J4iEQb6bCrjMnr51kApYhZFe/dUsW9qOMreFh854I=;
        b=DL3b9PJP6q0SL75O8Ts9IBuQs8AxC2Oy7SErDi9KnOnRXurHwhG4qJJvoG4rxn9tKq
         aBEzwUqqNKrhoFOG8hUDbn5vIynQf8f6mDuufjxTKOYd9QELYaXg8mtOhTCmFOymTlLb
         FhWdKMvuNaVam4AEWczLYsyaByFDsNlWGhWdaCQw4WYcktXsdBIRjKhV/DknxtBMb4GG
         04t1psx2oSUN8BdeLKSSxSmLHGL2rxVy/GveaLYukRYvb+3uYGv6L67UpeVnDeWZ9K0m
         vTzTxitRy8RF5iA1sch/ahzW2VdwgyK/m+2H4qrEMwaT5cE0/rxPG0C/Pe9vUY3JhSL4
         ucQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176053; x=1720780853;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1J4iEQb6bCrjMnr51kApYhZFe/dUsW9qOMreFh854I=;
        b=VbhwBBzxE3S1jvKrWPypykHfQPv2vIGsqYyyzB1VzfOTUgbDqJLtKiBEG0tQyzfm63
         4/FENxYYzY8DqFtYnJ3Hete8K/FUMVho8XFDxJJ2NhQ8B/yKugv1S+mbq8P2w3iprbi+
         2zLiRcT9D6LargmlLTiMQTj4228aWqgMyktKXYeUN+83X5LgOdCJfv0no3AVM6Fifi90
         SDlNMdjjHTUbKsc0G5o4yolbR29wIuxJv9VjAqxhPeXG1n3Nsbet8lCw1JuvFCY2bbF1
         LRlZhOCcM5pr3qCxrxWs1nY872sBDF5fVAHfCNwfJp2j4+sA2u6wLUpL6lSXAiuxxdo/
         aqjg==
X-Gm-Message-State: AOJu0YzEXg5DYpGVbF8yd0jZE65tBdOq3AueGp8JdTpN33dzl+KlMfds
	LKUZKuAIaVQSkZtIIX3pgFYH5/XUt3djU9Pqes3Y8yxwmg4BF3VhaquLq9Sznow=
X-Google-Smtp-Source: AGHT+IHQnQG+cHJkwbA5epHZ0FILVGUAdo3ot8LEwDFf8erj1Ucgf8Ixfx9Xs2w38g8/S45HM3b8hg==
X-Received: by 2002:a2e:2c0b:0:b0:2ec:5b10:685a with SMTP id 38308e7fff4ca-2ee8ed8847bmr27194401fa.17.1720176052935;
        Fri, 05 Jul 2024 03:40:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:40:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] iio: adc: simplify with cleanup.h
Date: Fri, 05 Jul 2024 12:40:43 +0200
Message-Id: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvNh2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNT3eSc1MS80gLdDN3MzHzdZEuD5ERjCwsz00QTJaCegqLUtMwKsHn
 RsbW1AA/2SvRfAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RkNmPr60yh76Qvmt5J3LbD5Vz6H4ie67KM+JSqZsdJQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82sbNnREpGcwlzyajdyO8SZdwcgSZD3Agco5
 hqT32RjHOuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNrAAKCRDBN2bmhouD
 17KdD/42XrKF7DuAE6Qdhii4RVQMwatwwhx5n1mY6q6ruXvovznXxSiT61bn00AbSdnOb9MYyXp
 qrAizgl7gr9D69aC11h8pHMyrypgGvP3lXOyG+kEDmZJ1mR7KaSLRuYJW3/NsUcvaWKblblfkYC
 /pS/3s2zRqXSIORLiyJoOelf1yyMRLUHIic5ZG5qYI5VNj+/pwsOq65RZPWfNknxuBYFS/GBqzo
 ATZFIXPLAI3nZNMRKtCF/CJWTJan/noKP3PELHBoTOecvIkTl0qoOF9bjAvH39yPmRfY9pbkPft
 yErIvFzNTtzJTqB3TU/fquqnwm/NUiIqYWqcpWtQMFtEgl2tOEf708I1LCmwSuQF+XZ7KAw9cya
 /nhwiVaWGf3p9HS8afO8x611ce6GCLcPTz5XA02ycFSRZ8ZWVJnAtu+HOfEw04vpxzXCThscBrg
 jDWrB9NVsYEt4m95xaD6VisytNGujfOvLfqSEzXff1k8UFbilxkSCr8gHhbf0EX2tBUfPxb8N+7
 KWBCQvgx2xbB12Nh8FMrluSlPt2Wlkh8oCFsn0oSeKsOjidCoOL/kiAAWvaePGsu8HZBVeAfqvF
 XCMHJZHjkZK0fkoAbGkVM+xLgl6wPcBBQ2uSUU3t4YR06JCykF5c6VyeuoyPx7Y2j15kNfzAF/4
 ic/t80HvjjYGeBw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      iio: accel: bma400: simplify with cleanup.h
      iio: adc: ad7280a: simplify with cleanup.h
      iio: adc: at91: simplify with cleanup.h
      iio: adc: max1363: simplify with cleanup.h
      iio: adc: ti-tsc2046: simplify with cleanup.h
      iio: adc: ad5755: drop redundant devm_kfree()

 drivers/iio/accel/bma400_core.c | 11 +++++------
 drivers/iio/adc/ad7280a.c       | 10 ++++------
 drivers/iio/adc/at91_adc.c      | 13 +++++--------
 drivers/iio/adc/max1363.c       | 34 +++++++++++++---------------------
 drivers/iio/adc/ti-tsc2046.c    | 29 ++++++++++++-----------------
 drivers/iio/dac/ad5755.c        |  1 -
 6 files changed, 39 insertions(+), 59 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240705-cleanup-h-iio-c90ca38865a4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


