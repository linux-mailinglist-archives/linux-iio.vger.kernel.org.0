Return-Path: <linux-iio+bounces-5903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968368FEF73
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A621C25041
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0319A2AD;
	Thu,  6 Jun 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Inxqd0l6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A7197A90
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684020; cv=none; b=q92WVg084YyCtg798vg/D6iOTSsiM8h4b3kOTxLSB/DOrOeBaNvabnegHOzwlhtFb/B8xWD0onKPMj3iDsrUlg2KgY8tLMLVbldshSydeHZNwjlzJWNoqYTqwtAXgKTv2t8XWR0Ir4gG6vu7M6FT/dj+5PUM58SVpt/kmIfK6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684020; c=relaxed/simple;
	bh=qnEQE+znEpMqv24asVKMZ/KkN6DF56o8w2SHpVB+m4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rCzARcw/k8jzM/oi6EAiBHKDE0Fn7Qnddb2uSvaBZdaY+dyIFxWBNMavLDmpgJToOGMN/kTF+oq6Cc4yCRT6oYQ69YgAFIJOAPtsQ2tlGAplWZCovKS6C8MRpIvy//FSadNgudG8v4adNe5vbeE6s9m7qXwRmWnFAehEHDRTGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Inxqd0l6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4215afa33b7so10781955e9.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684017; x=1718288817; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp5PTKFwAXtvx/todRiJJ+CxbMs0fyy3pTRLGPdv8KU=;
        b=Inxqd0l6h3oWeZA9w/N/3F1i27PdNAPDsWTmwSZkBDz0rYbSKgQK/XIj2uMGesrHAa
         aYLFfL4qczO7/h83mv21R1H5E461baimbA/bA9hsRzDdWBWTjwsOPGnZiG8n89SemyqM
         fz46EUnb8LO6UGoxCMyXPECx3L13gEB6KJTqNUaFXecpEbUyXNDW2zYOy/sLtdJMsAm/
         +XX4yfCAzzu/Fr32c9Tp2IgT1kV8Ykxp0LFgoptGI1ZqU7NLxCVZPKOpvXkRkAmKhSSf
         pBK7DQvoRGNWahC+XjjH1znGl6DCDbxfAGZtcw6GP/cyyxFuhlGCxrkvh79K+KAk5ZI7
         gnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684017; x=1718288817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tp5PTKFwAXtvx/todRiJJ+CxbMs0fyy3pTRLGPdv8KU=;
        b=io5xeJZ7g3lmFqu4exjBmhRK1VOqxX4+dtFrzC+jwxxeNIcpxm0IRpKZdvMEBIDUQl
         FLdAzhvc6VE02ecxQgdpfvAsM3O0IkswT7EL7ESWH6Ebm1L/WgW4TUKHQsIuPSwrPW2W
         XORrcXkkohViFpxBKtnouSfBXe3Srxkn7kK7LPquW9249PthY9OUUBJ8Di9Ms1A1LYaa
         wSMQIsaFJopsFcM8J/WLLqNu4QUqymSZNzlE2s5AzxHf2r1nflzhqWBD5p2YcfIA9SE9
         8aXrQV0mUpdjDuKZI1FXrOJTtNKputP0ylMZHfz96VULJ8WBgIoMQ670aFGP3ryulqko
         12mA==
X-Gm-Message-State: AOJu0YzSP2qPWHt2lPxsXiYwOr+yCcadV0KvypO6GxuLlkgct4sHoSCy
	vxQ4SiIrlfWj7Y/EMh8gSb7iJNebaxT/4C1yuI9bEvI2Wax3ump47F5jApe2Z9I=
X-Google-Smtp-Source: AGHT+IGaefabovxjkFtufxVtFDm1B6vY1P2ri+bP2YQyW2x/2qrrizvHNiOvAhP1IobXECg24+SwlA==
X-Received: by 2002:a05:600c:4ed2:b0:421:565b:e71c with SMTP id 5b1f17b1804b1-421565be9ecmr44309055e9.14.1717684017343;
        Thu, 06 Jun 2024 07:26:57 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:26:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/8] iio: simplify with spi_get_device_match_data()
Date: Thu, 06 Jun 2024 16:26:42 +0200
Message-Id: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACPHYWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMz3eKCTN3cxJLkDN2UxJJEXbOkNPNkU8OkREtDYyWgpoKi1LTMCrC
 B0bG1tQBguYVwYAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qnEQE+znEpMqv24asVKMZ/KkN6DF56o8w2SHpVB+m4s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYcclT7nf/6eJDtZqVXtzfOUHDIm1XQyhfBahv
 l7bw+69kuiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHJQAKCRDBN2bmhouD
 197aD/4hvZcXGISsqLzeIOqoPqzSqryKxhgdsh99qHrCeplMjhAyRFoMJ2L8zkYFn8ijWdTibyz
 17gXHmoBIOWxKXBrRNNp4DZ07Bn1dFS9lK79Hoc3BJnIQn4Ft35fabXIqknHltg/I47WA7NPGKB
 deyzkunspi3Z0Q3NLBRQXxAw685+iwf9LE0EdmgfoiHYntL/M9EPGGsdkev4JMdw4LIR8vwD7dR
 7pL0FrQpfg9RbcJBd00Bzit0eouLlJ56B0TC1HK+TTPQ7LjDkwGpzopwlzZOQ7SHWgJA1Y2vuB+
 mEwECGu52J1AIqElfCTQh1ZszRbcZDNKpHDOk9PrYmeqbm8o4o6iz25iHa9zV2DDgeAQzYara+V
 if3xAdgSQixsUGwXAwkoGGk18GEXKDQVXA2IBnvJ/r/kKzPXDC7r//nEeLRBsQE9apOH9pYirmL
 VRv6eQT2Dzci5G6zAsBWcEsc5ZGuZ+ArsMRqBQRuTTlE6K3skRZqKCkCm5Ag+8qUwSS5caR04Nm
 DdB7oio3557Ns+J0zgLAI1c22G5TrfD7HK2W2RSoS5+sie3rrC/aMlJZFRSBbrAlJELO0yEcav1
 wbWGF5iBmiu648mcnYSrVUk8i1XHuPeKbi3KoY4ULghSi+v5FXmEgB/8/8MU8X7MreP1YsM23+x
 BByBYtPlbmU5r/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Not tested on hardware, but code looks equivalent and should not have
functional effect.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (8):
      iio: accel: adxl313: simplify with spi_get_device_match_data()
      iio: accel: adxl355: simplify with spi_get_device_match_data()
      iio: adc: max11205: simplify with spi_get_device_match_data()
      iio: adc: ti-ads131e08: simplify with spi_get_device_match_data()
      iio: adc: ti-tsc2046: simplify with spi_get_device_match_data()
      iio: addac: ad74413r: simplify with spi_get_device_match_data()
      iio: dac: max5522: simplify with spi_get_device_match_data()
      iio: adc: mcp3564: drop redundant open-coded spi_get_device_match_data()

 drivers/iio/accel/adxl313_spi.c |  8 +-------
 drivers/iio/accel/adxl355_spi.c | 10 +++-------
 drivers/iio/adc/max11205.c      |  5 +----
 drivers/iio/adc/mcp3564.c       |  6 ------
 drivers/iio/adc/ti-ads131e08.c  |  4 +---
 drivers/iio/adc/ti-tsc2046.c    |  7 +------
 drivers/iio/addac/ad74413r.c    | 13 +++----------
 drivers/iio/dac/max5522.c       | 11 +++--------
 8 files changed, 13 insertions(+), 51 deletions(-)
---
base-commit: ed3dab9323648a17a85908c574787be12d4cc871
change-id: 20240606-spi-match-data-6bf7c51ba913

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


