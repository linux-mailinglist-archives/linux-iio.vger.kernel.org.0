Return-Path: <linux-iio+bounces-22683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B3B25051
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43E572753F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607B28BAB3;
	Wed, 13 Aug 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG45woBt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12452874ED;
	Wed, 13 Aug 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104089; cv=none; b=HSEV2YXdDOJYupiLt8iVTQW1rd+Qw5GSh2iHJ55kaZH8QbwFmQG+Pbbp88jzJagsTfs3ySukVR3ytij9qAEb17cEhwiHb1xTnWUB94sO4U38d8553T1V/Q1GJOTHn7YN8lwG8WXO8TPsOtl3xStOrCDXC/4gVRLXaAsu1Ioqg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104089; c=relaxed/simple;
	bh=7ZAY+2Peo7S2rRiLYIRAhUNbUzK4+1P+0qH+dyOPnWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBr/G+cWRstnfUe+N/2/vro3lPnz2G9M/nll8G09WmuD/NRgVD+nxWw21jE/V7+LhfVpIEaw+GAMXYSd+82AZcPDebmzbkqwpLHZtLShaBxksq0//vDXtn9g091fnEq8SZYRE+5A1qZf0xypqwGlCJwjToN+l8190Z41OxH3XYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG45woBt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78c66dcso8472966b.1;
        Wed, 13 Aug 2025 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104086; x=1755708886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe/jpg8erHMI8XAl5plVXtak/ycKmWW+BnUpeddeEcY=;
        b=jG45woBt8NqOOZhatTA0vNf9mjWvxucIWsTE4/BARnFKIQVBHXJzf1euONV8hsWzt+
         pcsnFP3Y4fqFk0NXtrdJ9q1P7ZtB3IUZDTjXxHY+LxsHYbCFeaTBCFXu+eovXSlD9u/9
         uDYgVY9p4DGcZlbJd2nUmsLvwz4EmQL6gK/QDmkaeVP/5FbsgRxGvzX9tCmcpG0OTbr6
         6rNVV5OZ66Go1gTw8HN53D+ChMfREo/B1jqHeyfgbKqt6ajaCq8h5ZAaqCK7q9n4ACzO
         RFW4Shp7zkm9NGBiw4mJB8AnYPTEbnyUi6wuR27FBFS1797NLtwNl9Fm0TNqeRnyaYf5
         2v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104086; x=1755708886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe/jpg8erHMI8XAl5plVXtak/ycKmWW+BnUpeddeEcY=;
        b=qBjZJtzdNVBLCwY3eE/wRfCGXpYdP1cOLBdKhmu9KjgdZRycIzPQZ5Ko0KcgDZnfdj
         3miFVjhFqJEJ9d33evEOSh2ZYLA++RUhBh9mD/+vogt5s8lrWX3zx4qimPq38wqU9Wnn
         VcPmilISvD94xtMowVfFyo92NNEU6nfhteFX+ktdg7svuo09bkC9eG6d+ZjYUNABtefW
         +Jk0F5JeKNkpNQmwH7AeC2hr3GkrXES8jAh/UekdRU2BOL4Jqiy1q2v7hBUppbsb/zOi
         qDuYqv1Xwc2xS+aWdqtsdg+NoFzFh0zdIWvjLsJpPhYTPl/FcdG73P4vGYuYcuBy34q4
         QgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUIEh570KoCrUaoBeJwfwTBWJVFdAdSRvef4DkQ0ssoBToKUpC785M8z4V5tRokVB6HG9EzRTugRxwA@vger.kernel.org, AJvYcCULJIiuRR2AQIDXT4EVCioZmg1QODOFpS2ZUOh9nru5bhYzxAFKNF8poe/CAFMDHjbcvw3LHo8nl/xOI+5g@vger.kernel.org, AJvYcCXQqxzBOdRaTbeejlaUZIvmKbRwixNBth5i6DO5ZEKNm8CjTIFVnWY7Efjy0ZOJZjaTGzX3H2VZv0oI@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWjpET5K6Un2BIMFk6XehCt36vMVHDX4dc4duR0H8Dl/OyWly
	csZvizRqM8OBkasFpl2dTDC+i4bcG8WnUn3N2zYfrqwWnIOiK3GHDYOG
X-Gm-Gg: ASbGncsh8qFd4Sy888QXjhkijOktJKx8myiPlV79x5/OL3pUdLjqvs4aWTW/5eWVoav
	CT8gr9Ac59kZZojnmm0HJPuYMyC4vF2Ey9ijOwWLwHIH+X/tftNuoJ7Vk5VF8qRSijN68oRxy+5
	4F71ZNM0Dwcv820g1MCmjRE9jddZkbMfziXB/dy8DWJCI9DJ1NAMur7j7cg6vBqX1nP/Z3+iEdy
	3bglXWrHAKzcdU+6GjlaxxvpNmO2lt8YOS0XCU0IG9XKbXcTzN9dzpKMThcs06ijRxPTYu9GX73
	SWkZAR+C/51ONQsf+752mjgeCVcXz+iSGOr7cJHaazJOjbvI/wluwfcGA6dDD4zA2ueMkOFOYgq
	pOGx6eaIpL6zhRXHAzOkHJo8lk+pa
X-Google-Smtp-Source: AGHT+IHPFeXX+HURtJQtp4tZ1Sf/tzFbmOItLXWhDtsdSG6P9lJxjSbu4QqPESDcJHgTrPsizLZIWQ==
X-Received: by 2002:a17:907:7e96:b0:ae3:c767:da11 with SMTP id a640c23a62f3a-afca4e5efefmr330067466b.50.1755104085722;
        Wed, 13 Aug 2025 09:54:45 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm2428573766b.82.2025.08.13.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:54:45 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Wed, 13 Aug 2025 18:54:29 +0200
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: ltc2497: add lltc,ltc2495
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ltc2495-v2-1-bbaf20f6ba07@gmail.com>
References: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
In-Reply-To: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755104084; l=1424;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=7ZAY+2Peo7S2rRiLYIRAhUNbUzK4+1P+0qH+dyOPnWc=;
 b=u9C2vZ5QWj43U/isacaWwihEG5Y0XBGgciAiGN0TAr0rnDF7CfJcqtem3NakXDncIalJLDvkq
 xC+Pr4ndV8ACpPtp0fdvfR8p+B0ohUR/UvX16wgUEPMmUFxaIvwWSiG
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Update the binding documentation for LTC2497 to include LTC2495 to
enable support for its internal temperature sensor, which requires a
different I2C command format and a new IIO channel.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 5cc6a96840778473895f436b7e2627d6240b254b..2a3e3dcc6ca7a48a0fccb88d8d42fee34efcff73 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -17,11 +17,13 @@ description: |
 
     https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
 
+  LTC2495:
   LTC2497:
   LTC2499:
     16bit ADC supporting up to 16 single ended or 8 differential inputs.
     I2C interface.
 
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2495fe.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
 
@@ -29,6 +31,7 @@ properties:
   compatible:
     enum:
       - lltc,ltc2309
+      - lltc,ltc2495
       - lltc,ltc2497
       - lltc,ltc2499
 

-- 
2.43.0


