Return-Path: <linux-iio+bounces-10927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A848F9AA2F7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200771F24158
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FB19E7D3;
	Tue, 22 Oct 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IWqR6byb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58019E83D
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603365; cv=none; b=irb/FIzLVWVMVBkhrO0GNbK6tqQ6cA42/U6dLPyizMYCABTLZia54/lfGPFkS0Nyg14Erku1G3nH0QfJXWnCnJQYJq3F4xfwi85GVgl2eOeTSOMCGGp3Z2V483s5pgNFSsT2qWs65E+1jmli59tlSSxOhSkNfNW+d9X4dSUVZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603365; c=relaxed/simple;
	bh=rGPuVL1dDyibnQkLtOOHf4WjoginLpwd6c8MAzIFkdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5mN/dwefcxGnGVTVeZaIGZKjs3zirxAxX1Tjg14G0GfJk9QoLDINKNQE34rd8GYAng6qX3zZcZuYyY9m6TSefULlCLqc6L3E9aOSq+59CfqXAPhg3jYCLfwkZoTtGreiOLr7TbgHpya+yHx/3vCi79QEdrpSUqGVrXFkZW/qEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IWqR6byb; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb599aac99so55667741fa.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729603362; x=1730208162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x2yDA6UeXqOoRgaHDspYi1d8D2nCNMHkarUJjoV9w0=;
        b=IWqR6byby15f+B7F3Hwhe+IDQ49wiRjIDPZn8kphC3MZfVyNucdyMfY7wwPHGlDdSt
         LsOmmuGSZ/qGxS67Jk+VzS4FwZ0aWbh15nDF7VB20cQD3QbeGeTLLNtrGTQZ+gPfaTE5
         ygXjvkLlp5YWl4d2N0shSaagM9rZ6wCDSD2SMNQODyMMMzMYeJEgvgbHsuSTv9dlLTnn
         qNXX28Xwb4HAMbvoFoe/5IhdSseu8BLmve35uDnDT8unOFoCZE3HVeVZGRldyQ+ZUXQW
         ng078xMuJQS2hc4P32BPejsLef4ad/s9BgAmYjXiL/+kAhm92rS/gPkTGgMRebs2139S
         /tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603362; x=1730208162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x2yDA6UeXqOoRgaHDspYi1d8D2nCNMHkarUJjoV9w0=;
        b=nZmoIHn81eD7Zw0QpWBIqxwjP00gKVzApl51Rx20GJtHx9bNCkZt+n87FN5PZQpBcm
         bd9vfF1I2oYtvbtJZBiotYYINDF7LI4kexyX/WUdkGItIHHb/h+cT708ImFqknfzeT+L
         TCiY9eHWCBc1lmB6F0fRUHfFcGacLdOvwt6j+RVOBbOHy091PFC2ctVIX5Ujp/jz3vVr
         hhpou/Q+5I9kC7t/MwqAWSSXef/7q9zX/pEtntZ1OYw+ijaA+ZCk1G5tAGZdRxNQyFwL
         nO0ry71laIPfq9P16n8PnBYLWHzCiBFdfliVJKXot+e6eBW+4edDcX2KuwSB8Lj5nIRE
         I2Jg==
X-Gm-Message-State: AOJu0YxcKmrYgCOm7152pHdQRNOXTDvFyhPzNNL7gbt/H7KJxkFKZLEQ
	pDx45udvIu6ErYhNQ6cLa6dJBXZimVypL92LJ511SJSvVCwsPUWPCkO94Y6uazc=
X-Google-Smtp-Source: AGHT+IFdQdckJjzJibgyD+ES83HSrz6i1/GlbpEXNJBjyNii3V9oS7oHE8wOZ5i6EBJYl2jSQEGqTg==
X-Received: by 2002:a2e:9295:0:b0:2fb:5da7:47a7 with SMTP id 38308e7fff4ca-2fb82fb74edmr66614001fa.25.1729603361426;
        Tue, 22 Oct 2024 06:22:41 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c737c4sm3109496a12.96.2024.10.22.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:22:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 22 Oct 2024 15:22:36 +0200
Subject: [PATCH v3 1/5] dt-bindings: iio: adc: ad7380: fix ad7380-4
 reference supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-ad7380-fix-supplies-v3-1-f0cefe1b7fa6@baylibre.com>
References: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
In-Reply-To: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
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
X-Mailer: b4 0.14.2

ad7380-4 is the only device from ad738x family that doesn't have an
internal reference. Moreover its external reference is called REFIN in
the datasheet while all other use REFIO as an optional external
reference. If refio-supply is omitted the internal reference is
used.

Fix the binding by adding refin-supply and makes it required for
ad7380-4 only.

Fixes: 1a291cc8ee17 ("dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels variants")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index bd19abb867d98d46bdd1c9e0c197e10f06979204..0065d650882489e21b952bb9fb25f1e3a070ee68 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -67,6 +67,10 @@ properties:
       A 2.5V to 3.3V supply for the external reference voltage. When omitted,
       the internal 2.5V reference is used.
 
+  refin-supply:
+    description:
+      A 2.5V to 3.3V supply for external reference voltage, for ad7380-4 only.
+
   aina-supply:
     description:
       The common mode voltage supply for the AINA- pin on pseudo-differential
@@ -135,6 +139,23 @@ allOf:
         ainc-supply: false
         aind-supply: false
 
+  # ad7380-4 uses refin-supply as external reference.
+  # All other chips from ad738x family use refio as optional external reference.
+  # When refio-supply is omitted, internal reference is used.
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380-4
+    then:
+      properties:
+        refio-supply: false
+      required:
+        - refin-supply
+    else:
+      properties:
+        refin-supply: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.47.0


