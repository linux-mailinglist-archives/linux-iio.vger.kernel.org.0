Return-Path: <linux-iio+bounces-22760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064EEB27DCE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13385A20E1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B572FE06F;
	Fri, 15 Aug 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6syvQ2V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CCD42056;
	Fri, 15 Aug 2025 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252130; cv=none; b=ma1tjmEVIx03fyBiOZzJ7d0vyze5HNBzXwwPXZRsvEFskb3CS+SblJwyUtiDrMq8hFjOe47GAvsHb2tZRqBFhYYlPAyIp+xaTvvq4oTkhhvdfLUUWcUUXPXTrHbGdwiziytPkbDmQOxnRxJb40yqrKyeDtDf0hL3n+qv0rQiPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252130; c=relaxed/simple;
	bh=7ZAY+2Peo7S2rRiLYIRAhUNbUzK4+1P+0qH+dyOPnWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRt+urstsJ8VQgDaQC4tOwrHcNc0Voq2Ta4hgh9hvmQYCUFll66NPgkMi6qQ1iiE2n/eo0NnQVfHBb/z3t2zZZyywfUjgU2fsdxn9qXH7iOFeWfg1PDfYZJ+Tngr+eOQ43cANAmVysSxHSNK2y/5SDAPW5A/m8F4FwUkNflhEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6syvQ2V; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a0442bso275817166b.2;
        Fri, 15 Aug 2025 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755252127; x=1755856927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe/jpg8erHMI8XAl5plVXtak/ycKmWW+BnUpeddeEcY=;
        b=W6syvQ2Vj7wCz+AWKx+ZUuGZASMPleYBFNY+JhC/mVIl8v5nhEVTzorsm3ICAmb5Xx
         FrHcGqGmH3PhKJzTj5DNn/X+GTQVsVWMq5CsDUNG8J831URH9ilUhdwxmAYvRe+0C5Nn
         3jbQSC9ZGwis2FWx1b2eqGlDCH93fY4oJNM2D0mHHu4Q1yWpsdG38OQaLyLyygxw7Ouu
         mP2HN8ffl2g9LFWeoXHpd4WTdSdhzpM3kbvlGo4s2dFfAK7B5HBbSpZcI/PNHF/c2eSc
         +aCzpDGdCfbGWlzOjGrMmfncjFxzLIWq19P9BhmqBQxb0fPUrg/TRlxTEMB6PhJcuk6g
         D1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252127; x=1755856927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe/jpg8erHMI8XAl5plVXtak/ycKmWW+BnUpeddeEcY=;
        b=j++v7kxCI0xqIQ+LxabfZux9zu1xB6XTMBiYBJXapdIm+kuv7W8x9ocNTzJfOXztT4
         3noBc3FG8XEOBq+BAKOOog6eLXmTZBxqYqjSUth/IKrQYMr1hDqmvZcJD0Xo50+/rx0W
         ipUINJ3UnPt2S5CTzfpkFDgyfqFyI5mBmhDKZMelZh9NsL2So0Pq3HYxJ+LcGepfSDwJ
         TPryUhUEHAGyTqPaliV/ohKV9b4KkxICwQ7YdYcWkOVYMxCFPqAKjMLCGD3BnSbKIT/R
         Vx4U/hopbpDZ0sM9vDpj3oW0wAR5sBDWH1PfxYsvcHUQxTPjlkomFe+4qRXr86gkrV8t
         TV4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJALR44c7JAJAMQ6gLQN+MOC8Nyic8G/8ITsfYg0StPcsgkIEiLm4HsJZqFk3kiJwerw88MwgxrjV8@vger.kernel.org, AJvYcCWTte7EBkXXSqO4aVV0usV9LcJpbVyRBRgIRJRZKDgv5tXAYcqUx4OoJ0fH4fQq/UI5LQ/hzsr3pClr@vger.kernel.org, AJvYcCX1J+PzxoTbRHSebqsorO+dF4ffhLhmuIcDfDrNRiYhAwrW29UqPQBVpHLPo3/3c+bdAHqOEKHkcPPfMuMa@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMbBAfNN0Xpk9n5b0C3qDx3UG1q8TIlGQyz8c4DuH6+aWCDG/
	q5QRf+ffeKi0gftU9N58/P6web4KtEoyyQ9jagzAh8HgqdVD7PtwYNUMwNcnVDET
X-Gm-Gg: ASbGncun6gy43pW2OuNEL1Pa35rSgC1ABaRYao2ncKwg2q1qoPvnkxbE+nm3UCEMW9q
	51ouuK6Xv3PuhS/+py2cRw2kkwdYs2pjM/pX5Q3O1Ek/CrgFDHE/3y8c9EoM1Y8PHvzFJ3R8hw9
	Ucm7P4mIp+LD39c9KD47Wzllfuz3Ws4z7HW0POdpi3SGcVFT9iNP3Ulc2rP3o2hhVLdAXPbsXMF
	UX0ypVz653FiS1pes+gNc+KzQnsT+TTkZP1q/IAfa2ao7YOlDMYDBy4hN/f2tAbo5uDq1tMg/xI
	ybE6f07IwsGZ4I0uAEmzfpO3nYsIqmFxCm1Q80bSJ4Kzp4O5jKl4f3u22VVs96BJopUyE3Z0zqD
	h9LR5owb06F2x4vfbQ/0QkiNkrdYX
X-Google-Smtp-Source: AGHT+IF0llnTVaBNjnplbmfZQjRdfKlaWfXT74yRY8kCDjVSpRWMCEhECZKDAZxsCIIC8SS6Mq93UQ==
X-Received: by 2002:a17:907:962a:b0:ae3:f524:b51 with SMTP id a640c23a62f3a-afcdc25105dmr141869466b.10.1755252127037;
        Fri, 15 Aug 2025 03:02:07 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72d5dsm119031766b.37.2025.08.15.03.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:02:06 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Fri, 15 Aug 2025 12:02:02 +0200
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: ltc2497: add lltc,ltc2495
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ltc2495-v4-1-2d04e6005468@gmail.com>
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
In-Reply-To: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755252124; l=1424;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=7ZAY+2Peo7S2rRiLYIRAhUNbUzK4+1P+0qH+dyOPnWc=;
 b=EZjtrnBDYituhPsyMvnftMErGznq12QYkFh0bFyJq80i3Uva4wGvfHjThz/6PIyj5E6LXVWLb
 jZqCId/RBS4Dx5zM/HDDax5/Il1rG5Z63badrRsBfEzSroiNGWno4Eq
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


