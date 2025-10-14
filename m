Return-Path: <linux-iio+bounces-25069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF9BDB8CE
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5300C4E1C4A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365012EA47F;
	Tue, 14 Oct 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LMj8g6F+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9E30CDB8
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479393; cv=none; b=VdOjEA+Bs9jI5K1XdBUejymIDyXvhkFMmmsKIGNTKLR6/kjoBylK8+D9a4r2iRMoszj38YOQKWmnr3nMG4R+FPrmSkTRCWBkM8m4QHcMzStxoiYmIQ33uOGp6Hn64wcG1eTRoIUFVFf65b+tZ9+LP7zWXYRDnzUb4uGEn8ojXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479393; c=relaxed/simple;
	bh=IHJ6jqS9j1TBQ/H15wgnAkkcZ2ZWT9EdgyEMDoCMZD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cu1SAXmObUYY9iAaOdwJCrCLNkUEaffBpXtzfs4FBIp3b9SMDce1su+GTbBsHqmQCGKJ5CPq7MWnK1Hi1EDLlMHaGvIm75uGqMtjgqsOWM4UN0cXR3sBijiR8USkZ3CA7zyS3P7BQE5uLk1M4rPZFqr9vYjLUXKdiWkBd0z/Mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LMj8g6F+; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-64fdca63b41so2845954eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760479389; x=1761084189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjdWBz3OHh5wnT6vj+9iQMxZ4HDopZIIFl/DtR5apKM=;
        b=LMj8g6F+EJys6gyHhDweuYb8zuMOHUjb4KtKHEmaeaQnCDGGMGH5DDC/4h0qBWbCrs
         b6nLUAyrQcYvWxFfRyOlkOD5qbhqFKR5jQofqhp3V9TOvGfN6WlAL97dN3E1Nn8UvG6n
         7ix3b6d+gPd88ERrJyQlj3TyDuXXIDI6CCR7H5o4mf/H7dct7KeDuclL2S47AAN+y68N
         pVl5wwDTxnTIHBXH7PxR8Q9is/tTUOxv40nz5GP4MJSKae5xCb8CjkaTB3gXhE79YCN/
         NePZS8ex2eGu5OVOIB37YMA6abNlbgRpqDqTrSOMFG5iK0nLZeYzoWtGMXeStpNltilq
         eUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479389; x=1761084189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjdWBz3OHh5wnT6vj+9iQMxZ4HDopZIIFl/DtR5apKM=;
        b=MzlzmcVdRts1Nz6r4dmzfrk92qbqzQRaA5pjdx6XVoYNqexm9YnrCWmuDfnLWfta2C
         RQ196/on/ey87fBc8WpqCNmX8vjQMChNGGqEqdzB+j6pcTUuhDdqfwuR60YyRQL43zQO
         u19pqsYTqe5Nm1GvqVL/2NHTdOAel1kPVei78UiOVIngOnN8yCpXYlAwwnlsyrfjI9+c
         xhtMRar1HdglzwNlHTHED+zvwlEoDo6AUqxQJxiZfnlASgFe6FV79BmpfEDT27guIKZl
         WZ2id77APoKYr9d6i9ZDd5o73qYyc0ly/A7wL8Yn2WO3RFZ7ZTU8AMGB7nkXwB0O1IBQ
         vlwA==
X-Forwarded-Encrypted: i=1; AJvYcCXRVXKJPsaUWenDM7qnIeEwVJyiZ0rGv+493foKtnCcYnyhVsxDeIMw4mD1d8zNIH0qoi52WBe8ca8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+B5Lp8s0xbmhQIXslDyblUp5uNphg+Nqx+0aI9VR2w2qeB3TT
	Ad6QOFqfSBWxK3LOB5OR8mEVwq8cwDDAgnsnrWXJl8ALjtwP5kPTqz0hOItLGuGvwEU=
X-Gm-Gg: ASbGncuTWbgydNYFJPT52a3ezRR+M5KKoGNQR3CLGMTq2LVS8Gq8Mg6qj8KstOQShMw
	Gxlrc24S0j3v77WwL7jjOXZH8Bi/SkvwJZYnLG5rrRZz4rl3Ktb8z3J3mMxf95WUQzkxZguzr43
	bFrypgd3aTD2b8c03yIpNovP2yZSOOiJqBhEXwOqZRtRr5e05ul5pbO1QN0Azt/lLD1eezX65Yb
	ogzRx/pPs3bT6S0gVVtLhFIjoOUkIzwqrp0nDHK5woSXh6f8Rc6xOAzgyKSwUMwCHXj9irkP3Sg
	RhdTTMF3ShaDi7eNsYHdjQpuFIswRQ57r5uGuJINYNLg343ZrXxULRtFH1aVnxW44JCp7VDFGg0
	IPWSpRLxwAPyv/7eo55id+uBRZQpywyvthMUkmTLMmP+qiBYM9j1OFeXc
X-Google-Smtp-Source: AGHT+IGYULH+vEt9jMeQ3wNinq+GIQBTNYo8odpGkZUDNsT8ayyDdjFDcErrGxKAs8sjUAHkp5uP/w==
X-Received: by 2002:a05:6808:211e:b0:43f:ab03:4707 with SMTP id 5614622812f47-4417b38f302mr11734631b6e.28.1760479389551;
        Tue, 14 Oct 2025 15:03:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419895119bsm3593732b6e.21.2025.10.14.15.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:03:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Oct 2025 17:02:15 -0500
Subject: [PATCH 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-spi-add-multi-bus-support-v1-5-2098c12d6f5f@baylibre.com>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=IHJ6jqS9j1TBQ/H15wgnAkkcZ2ZWT9EdgyEMDoCMZD4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7siH26/02TCQ8eSWEMletSTgpdB4d1Rg+3+M+
 jj9N7o11gWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO7IhwAKCRDCzCAB/wGP
 wJ/NCACX5YcnQ3hVfnY/WVicDwJ6ddQBIGqDCFDl4gjJg7mO3jmuS5JqPkH4fSTb2ZQpAom0wa8
 dg4w9CdovnLolP4ZaAEvLojW5Vs1qTlaRDWBhhAy89v4zSQuZUTcisgfnvSfQqCmvBqRe9C7sme
 3Yu/u3lOR/bNEVzWQO5qQtC/3N1cEl2J00l6I2q/9KInYcQuJajUYn9XC4C1ty6pfyOUY4rE+yZ
 ItqZCm8nKFk7i1fqf87XTtBcdlKtPR+8X3nbzkgvUm5ThdUbPiibPag93cIzWM/R4Mew+5nY4we
 /Ih3BMdxcX1ueqTvXXJnxV+kpvNzrhdyXKMqLxIBkIlYpRQj
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-buses property to describe how many SDO lines are wired up on
the ADC. These chips are simultaneous sampling ADCs and have one SDO
line per channel, either 2 or 4 total depending on the part number.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 8dae89ecb64d723dcf2b4af1e0505fc5db49595b..78002bdaa795800a3927570d639e7f8eda9206c2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -63,6 +63,10 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  spi-buses:
+    minItems: 1
+    maxItems: 4
+
   vcc-supply:
     description: A 3V to 3.6V supply that powers the chip.
 
@@ -246,6 +250,22 @@ allOf:
       patternProperties:
         "^channel@[0-3]$": false
 
+  # 2-channel chip can only have up to 2 buses
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380
+            - adi,ad7381
+            - adi,ad7386
+            - adi,ad7387
+            - adi,ad7388
+            - adi,ad7389
+    then:
+      properties:
+        spi-buses:
+          maxItems: 2
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -261,6 +281,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-buses = <0>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;
@@ -285,6 +306,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-buses = <0>, <1>, <2>, <3>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0


