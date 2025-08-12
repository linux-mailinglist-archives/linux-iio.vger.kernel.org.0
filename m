Return-Path: <linux-iio+bounces-22630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB80B22E9D
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA171A238F3
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0EA2FD1C9;
	Tue, 12 Aug 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx4vSOtL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD7242D74;
	Tue, 12 Aug 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018594; cv=none; b=nrgHrdWyf6HwSsILUZvOkjWJXVfoAlUHK6Wi0uI0xCPTfHO7297sVnBn++n1Kjo74pVSwgpIZQys6J0/pZCifZlVCxxx5O732kcjMJGncQrUt75M9AR84IR1/nTVawXpb7bw2ieLflbNkhXGPkjiCR1PGkRK1l2//YwZPjLGt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018594; c=relaxed/simple;
	bh=G572eJNgoJpmTVvUJKerp0FvfLuLpTaAhKYMi9ltLoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTNx6rjJSPGyt91Qb+HQZBuStLT42U5IO2+4CEcHQMPaowQe/MoyS8PFSDWlSuM+pQ5vtYD/cQgI6mz0DRgtbTfwOAG3MebsVNBELQWAh7M5iKcI9BOA5o4yBQaffFUeM0rqrLImdYIVwLlBr44yaKxw9vIAbJkn5Cf1GtHHObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx4vSOtL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af96524c5a9so746037066b.1;
        Tue, 12 Aug 2025 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018591; x=1755623391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIFmo+rqWI9yAx0SCUbeCtzKg9MTSoXnkqtVecxX2qw=;
        b=Fx4vSOtLeQCExyvmu4EG7zFnstLUt+8L6u7qHylBzIbl3cUuYV1MlzzomjGVWVK5LX
         scw5UGygT0pIMBP7mMe00bMqYkyK8OjLahD7iuWMJeO9YYVoRS8Ei4PsyHtED0ck8vFH
         0loS9y+Rf4i33g+vk2N8BIpwY7qaO/rIGCVtvy4chr1fXPmJK4OhXVF/874JFxMURCS7
         mEVj8SbA2UWUp1EN9dsY7MWm1tR7cUPYHaojQPJCf7Qnlpw1Uu9IUOPlEBpgaENeWrek
         ZwCaJw1xJ5Ebv4Tv0qRrsaloIGvepSeM18/2P5ossj9cSAwyHwcJnxwgXjeWBxr8dXjM
         LfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018591; x=1755623391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIFmo+rqWI9yAx0SCUbeCtzKg9MTSoXnkqtVecxX2qw=;
        b=mKsl6qtgm8cs6wszlazCJoIgrgl0jG37gzfPVPCcwGw34hDpnycOpFXe4vHhZQaTmr
         0YHnh+DQXBmSMti9D+MZxgKqT55dzs0Rq24uc3I5r1y/u1QLcR94BI2y18YkKUikNUFv
         seZl/rqss/Bjef2jZxR6GYAkTuEJsef+BGcmMvtagVHrY5oMl/lTKSYBNiRi9G3dig98
         FCZ8NHzBwYVxF1VMW+u5g8mwDiROp57U9Km1B8Vn7Y18fyR83JathisHCKpgBwPBv1VY
         W54151krEfEqW599IVEFjIbnAgC/I7JA5k4yPzlyPomCpFg9KHitDkHr+qBn1lkduYmb
         nymg==
X-Forwarded-Encrypted: i=1; AJvYcCUwf04gL+haQnafwZ6DGwi6vOFjdGziPZlo7Wx9VR01ECq+GbfmAHptxv20qsOK2NEK4pHSYPvrelxs@vger.kernel.org, AJvYcCVtTBExP6QFOe+QNF7fHWS1KZCIA/vEW20VXv8L7XPWpph5BCtFfAiqaHCP8KTtGZZAOn0a9oTGZ6rTPSQV@vger.kernel.org, AJvYcCXr8p7BdfHvGFK+UwFCRQq8xErOBsbWjZPLIqg4uwuuZaIrQUjTdwiFLx5OrMJpoU2vaJWj/VijUWd9@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQwRz0VFbhuwIbwveLYI2CXeptYD5x2agdBdgWCygIibnQAYG
	dmCf6ACsiasZNjVgy3i0zxd1zFrLMHw0/VurzsK3gvZEOohcObA563CB
X-Gm-Gg: ASbGnctPlzjIiXnP5ffNZVrse6YvVFAge9Lss748F/3O2zXR9IN1kTV9ZLPirvLpDY+
	Xu8tETGg2UqVhBMk85pUvAg+E40iERERiozRt+9jTWCOQ0FBAZ4BHFNVdVg7loj84pF2WanLURE
	+9UGU7ps/DfbLIYhhYwuDTdJcixV2GR05RvemPEmsBh7k8q631RVfjijjM9mADUBHOGBBCYEk5u
	urQAtbZYtY6oNoUgUBWC2iZKlWl86nfPGRDtv7dvSrDJJmL0iHCSd1rd3Lvw5lSZsqnqSutNWaO
	uiIFqGgBohUgWMeA+JbiaS2Kf9raNPqjj+c35euDiR29OQrIYxNMQTQulUHsdx+PR1/TxBD690Y
	neLqw3CyBicC5XzJHQXve/aFBEkUX99rYy3dYhJ0=
X-Google-Smtp-Source: AGHT+IFI+fwxOfvNd6NoJKb78mBCsbkPGG6IrJ9RANHMsLUE6bu+J/MUbfwBmj0UzUkR0duDdHzcbQ==
X-Received: by 2002:a17:907:9445:b0:add:fe17:e970 with SMTP id a640c23a62f3a-afca4d0e901mr9242366b.14.1755018591379;
        Tue, 12 Aug 2025 10:09:51 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm20060302a12.60.2025.08.12.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:09:50 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Tue, 12 Aug 2025 19:04:10 +0200
Subject: [PATCH 1/3] dt-bindings: iio: adc: ltc2497: add docs for LTC2495
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-ltc2495-v1-1-7bf4c6feec2e@gmail.com>
References: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com>
In-Reply-To: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755018589; l=1305;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=G572eJNgoJpmTVvUJKerp0FvfLuLpTaAhKYMi9ltLoQ=;
 b=qHbsY3RxEFr75c7F268oMHET9IYwSLu2IXfch6UAIYGYtauu1Yuy/N/L0a2kN5TOm5WLLIW30
 8UIxGN0OCkBBrP+L9VXMJtjx5+t8xMLm48BCz54yJGM5+OwBJ7UMu1e
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

This updates the binding documentation for LTC2497 to include LTC2495.

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


