Return-Path: <linux-iio+bounces-22731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6DBB263BF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE11888250
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A702ED15A;
	Thu, 14 Aug 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHYjrVJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3361243956;
	Thu, 14 Aug 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169227; cv=none; b=V1t3miuwTfaHtDoqsFMTuLvV4azxmm0b13quIwUhP7qPebndLQbnSUpFMW++afanY1yyWP3iN360UhMIjBH7Zz2w77OEaCDvPNavABN0xxtaTGDaFM4K5xuCx1aK4Z0e6ouZiuYEtqKCBvo06KY9CWsUz6B/YOTXymLidQidzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169227; c=relaxed/simple;
	bh=7ZAY+2Peo7S2rRiLYIRAhUNbUzK4+1P+0qH+dyOPnWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J693ldYNZOAsonA71jmAFAHv+KZn0TdrYD1o7UlWQxELul4SRmXQr8tpOfU2RWlGOL+9SyWeQbuoEeXGCL+TqRSDqZrvPlqwkcVFkI3Zw5FWG95iaZwZxpLk+fGisr3C+UPlSDHOFXLjZDG7ERmQBCKJizLnEmUJ/UaWsByNS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHYjrVJD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb72d51dcso122083166b.0;
        Thu, 14 Aug 2025 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755169224; x=1755774024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe/jpg8erHMI8XAl5plVXtak/ycKmWW+BnUpeddeEcY=;
        b=XHYjrVJDrlH22OCuyx5YEEtkdP9NRRIe4TEqHoHtIBjyUZmpkg70WCoFlAACOAOjfm
         bTuGDP9ntDXiwvBNWryvHf6/0RBTX+23ZkUndND0J+C/W0cIt8r9ERzTifo/0UgpLoWV
         3YoMylm7DZFn8XFF3d9a4HIfrN8Xc6/l0FtcsqyvOfRjz0DCV6NBvi9GFN3ixxQZzzB8
         T2COUBUCYKdgCrS2kkS5M6FkEhARFaHsYBYvDrzho2Vpo72T0F1IBW3Rr/7H+be0g95S
         k/0CMN0BHo+GC5sRiwlrA8yPtclklvKx8KUuyJWgncJzZp8iYWHh422RIiKFJh/w++cw
         CulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755169224; x=1755774024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe/jpg8erHMI8XAl5plVXtak/ycKmWW+BnUpeddeEcY=;
        b=clYBHHB7v95q57Stg10fMCtd0Laie8lgTz3Divy+8kffuCGf8c9QfY2xuWMtLo+0fk
         4ej7+B857CyYzGFEpRULV0FWv7XogxuS/FR1gg4XinE+5yh2An4k1e6Zk82Nf/gTwLX/
         vvNb7krTOyXhDAj1tHywu/zNssaC48ojEiA8bDHwOTbFvfMnZ6BEC4EyqwYEUN1q9De1
         tf80gFyrDQN84wAkeI2PBfy4GoFB5X5XfAOcCMVQ7msXFGXprmI5AgoWV7cNQoWFDHPH
         +OopnGpsetFHVqv0i3/eTP+UlCp+WoZGc5UlNDAvWb1z7mmH1zb8eMqpn1f5xEEbsW8l
         q1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW64V3RAeyT4QT9Tx+ICe+tjeii51xg9HCkoPQIr2Lvfpb2rrm35W5znycodtXrj66RH2CFlTiEEVmX@vger.kernel.org, AJvYcCXvD3g6KRPwriFOvlu5JlfSpbCli3mmcIbqfIbKLWF7fdB9kgwovv+Cq0sbtzHViE0dGkOgwJAg4M18@vger.kernel.org, AJvYcCXx0TgzGuMh6sp0N5QmjWg4nH8KGx1W/7I0Yeweg/4N9m+kKFfHdgqFPZ2pbrxJLMOGVzvV8sGgkqEHwtec@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1dURsFEeYHNBWnL0C8DoIU/uGRNbmxGslDUaOFtOEcxGmvG6
	cjDBTEubvxoWMJAZgEQMVgHihiqH4UH3oglomh5gmO1JA2NtW0qPMiJJ
X-Gm-Gg: ASbGncvzDP9mmfAJwnes4gwrTK5ZlizTC/7wJX2vUPvi1JxP2H6mQATBcRYAzCb3Xlx
	AjRHo7ztFFYnMvp2lqXDlT7MZctZvdok+asFuVIA3Yz/v0fy+vZmmo4zGVUI0gvmWEQN+9e2TEk
	v+IL/zRnjmsjjk+8FCA5P7oPTcAnrcrpZ/DloYDvTJCByKKeOGXs/yHfgA4FVnatyGZa2dEke/p
	m+bkTuPdBk6nxeDMaJ8yu1MpqwbZNoY7f1s0PJQWs9i6l+0azWVYgDM397VWH/rkRymWklxb5ho
	NEBa8y2vHQJqMzkKV/D9ItabRD+HGT2vpE+h0VlaA8Xek4CFTjzOrd/age8r3dGIioQEP4xi0OL
	CRgUINBJla3/vlMTgL9gfWp8TOBBX
X-Google-Smtp-Source: AGHT+IHeBKJpU+BMGLtp8zoOPw+MiHePwcCIe1+CEv2NIUg4BbKvdiwa3tWjJOCs0H94l3jVMWxe+g==
X-Received: by 2002:a17:906:aac8:b0:afc:c736:8b0d with SMTP id a640c23a62f3a-afcc7368bf6mr102799966b.22.1755169223921;
        Thu, 14 Aug 2025 04:00:23 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91dfd4b31sm2542980066b.85.2025.08.14.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:00:23 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Thu, 14 Aug 2025 13:00:17 +0200
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: ltc2497: add lltc,ltc2495
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-ltc2495-v3-1-c2a6cecd6b99@gmail.com>
References: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
In-Reply-To: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755169221; l=1424;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=7ZAY+2Peo7S2rRiLYIRAhUNbUzK4+1P+0qH+dyOPnWc=;
 b=dLCdd2X0Ga7YceosXOExWOlNqZLZOuvMTHGvqfyAtYjwDUTcR+XBrparpoIQzDjQ+wCpx4Gr6
 joSgiX/z+z4DESo+FtcPw6x8/skB0eq1nX725jQe1iXanBNPFOAnWUB
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


