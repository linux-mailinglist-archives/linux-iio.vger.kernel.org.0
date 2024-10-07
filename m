Return-Path: <linux-iio+bounces-10290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C652F9931C9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F520284805
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6911DA0FC;
	Mon,  7 Oct 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OgI6OA5u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2591D95B7
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315949; cv=none; b=mwu+oTnPo3D46V7l+yNmNv+SMpxrnorfmPXH6O8NrBz/7yYWgsBsDdVUoY6jdZR0o0KQdnIDxriU6fyorfYXeQoEFq1r7y3qZ64I5FVBobeO8GTv3X/7j48Np0hBjETpo739xDhTZla2qZ9kSSQonuT3zQB67THgEEzfN/fHYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315949; c=relaxed/simple;
	bh=rg89aYnjskRblLkaWHAx7yUxNX2UOdUO/BrbnwFj+/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZHMTD3p7361z9hWayIju0BAZ9iRPh5d42C4UD8QVbXhHdf4HXAAkphkd5/g69yhBDHwjsrb1vyC/vBIAbbSX2TqTQQ74HQKQLFXuDA82teniIb2skgwDjF/96Gt+LhqPO7bt4vwNKPXwZ1B2CEsaOTPSDJ2+HoiTse6OCbbVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OgI6OA5u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cafda818aso47690985e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315945; x=1728920745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmGBhvpiUt0ysoyCWioVypN2QdKwvc+Q4vGDC3NYxco=;
        b=OgI6OA5uk4JacegvrhmegUeRw/5nhINtZmRSE3QjWA5KaduJKtwAs/dLKLex0R7oOp
         qldDI6K5E9N/BQm52AHLRsY6L7IP33L+f4Wjbjl33U/BwbOCFT69iXoTx7nAZplS1/Om
         5vb5V/VC64lvifE15oP2KwP5uzp48k5HRme/qwFVBRIsW08pCd9/kr7BL38yxCEN+r1S
         zCmyIfEtlIEqUENdxpFbDDhYIqSPV5bjzJb8cAgp/cf8yK2ZyiWV5lJDVtK6uf1UI5FI
         hn4msotgr0y4PYCEklDLYPkCUzZQe52YwjX+bRYX4U2MwadfB8gQxxEPOTIDMk94gJVJ
         hjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315945; x=1728920745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmGBhvpiUt0ysoyCWioVypN2QdKwvc+Q4vGDC3NYxco=;
        b=X1SkrA0Q53mte3RKzIIKhjEj31xNPiIsq5qUk3Te1+BnO84cIPCXhRgXR7N7p946HE
         WSGrAnzdtIJUaY3w1/u+r824ow9Oj8kHPTjP8kw610+P7XM5o3ZOsuZrPLsz44LbKYpY
         l3Rhuu/oIdqv6a2svNoqM0RDceVuIvc2Rn97QmnpIxmHvENMccsQ3epqYPXGKLKRZlVU
         E695z8z63wd5twZTlPYLusuEJkugDUez9KWmOPBT/myIWQ/tr2arQsNxWXlE2q2X3nr/
         FQMdGuK/HQvyeSBl4B+KMPcxtJ8QFhMICbtpj1ZjlWKrXcVZSYCldaEspYD7CQ38/Dup
         t7/A==
X-Gm-Message-State: AOJu0Yxff4n02D5geI/r5ZroSk1mtxOkgns+xxy/+ApYyAenh8GDJyOo
	JnUfvCyKCsgPNPuMv6ENmXzk6++OArFmaj0Bih+el5vWPAcJsNnvI5+aXfb2Zw4=
X-Google-Smtp-Source: AGHT+IEpbrR/lL3jrtHbnvPjM/a+YxVcE22pFcjH4V0hGT0JBxqNv/8vtmxPzywnVZWvQ1VZDd5VLA==
X-Received: by 2002:a05:600c:4f02:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-42f85aef888mr75203235e9.35.1728315945049;
        Mon, 07 Oct 2024 08:45:45 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:44 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 07 Oct 2024 17:45:44 +0200
Subject: [PATCH 1/6] dt-bindings: iio: adc: ad7380: remove voltage
 reference for supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad7380-fix-supplies-v1-1-badcf813c9b9@baylibre.com>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
In-Reply-To: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

Voltages may not bo valid for future compatible parts, so remove them and
remove useless description

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index bd19abb867d9..72c51b3de97b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -55,17 +55,9 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
-  vcc-supply:
-    description: A 3V to 3.6V supply that powers the chip.
-
-  vlogic-supply:
-    description:
-      A 1.65V to 3.6V supply for the logic pins.
-
-  refio-supply:
-    description:
-      A 2.5V to 3.3V supply for the external reference voltage. When omitted,
-      the internal 2.5V reference is used.
+  vcc-supply: true
+  vlogic-supply: true
+  refio-supply: true
 
   aina-supply:
     description:

-- 
2.46.0


