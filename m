Return-Path: <linux-iio+bounces-15134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD9A2CDA0
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE9C168051
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365D1A9B4F;
	Fri,  7 Feb 2025 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V2r333t3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47619F11B
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958971; cv=none; b=ft5PS+nhfgVRZA9MJed4X9zFhxNUnVfxyetuxuSYP0PnlIOesGe7VSQIXjnmzctjAXEGfV9NDzUKqFi5R5u03BC7d4CsvaUST1xmuBwP9wz+B1aFTcDfs0PbMo61SAB25zP993ycrHjqLaNsrvUn0gCrLsAR5qYd2nEVLDnxhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958971; c=relaxed/simple;
	bh=rt+GniortcrL6xGxBnnoav6poPM6JFl88uJNx+IwPpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHGZgx/WSNR97qBzlHGKy5IJjcel/F7PyVghh9zrRFc0mxMiceXUN3dkTDCqvFnXkhrtChc3ZMESop+7X9rgu9hFO779u4W863qWkhLk1Zcnm5XEejNlvpxTu7nVtDH/i6E7D4kcHplQIcpy3JZjatX8+VemI/BR0dj2YEDKwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V2r333t3; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f88a93dceeso800389eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958969; x=1739563769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rxdAtHegvFqd0jnw3MaUYjpnQ120eeARkMko1E190M=;
        b=V2r333t3zEtSQgDRXsFrMqH/gp6HsYU/6GbajFYg7OnmyWlx3XvBoovxujwhrfU4WP
         7RqYut8KKJl3VEg3PXbzByYk/wnXeZMe+oE0sO/JigdmAQsO4gzwnVKnhmTcAkGQR+hK
         gkKmKJZaN4a6nXqdPCujZl3mQhOcPXePpHCDskSwZIg/n9GuECRjk3GPgNKPj+c/bEPa
         Fbrb8T09CpAW3JAhG8dCxPICWYYW/Pd6W5XwwoKeong9T3+mPcvsrj3T4s2qHvVHf5/7
         y71H0urnglNRdTPEdEJLsaS69AAfCqG349cI0OlJaG8hxhmmUsw1eIyPSmy48mON5z2k
         idKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958969; x=1739563769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rxdAtHegvFqd0jnw3MaUYjpnQ120eeARkMko1E190M=;
        b=ehBSwC8d4c/rFt6oJppgKE4UnD/wxEj9qnc3O2kzGKzfeDB+11U/7QfWl/N6aTj2RQ
         S8Exjxdi/lUBnZMxvVPeAsHW8TSE1eubr9kfF1t3tHGfN+t3hvNxYIA9axl4GYEpVULr
         qDsGbqBg3Yslmy0v8uV3c73Z7RuPbmqyqfmdAlBC0APvhIksylVEwvqe+GEewbxksQWn
         0nKl8g7TwynEinLtze4xL4vALNJYcOf2GyZQriftwJZEudy4fXISAQzG/eOjOtd54yAv
         IvaDeELI4s1m3KrA0Ktapr9r/QnnZj+BCTat5Ok7WIQZw2fLFVB05RqTl0dfX+V27o64
         houA==
X-Forwarded-Encrypted: i=1; AJvYcCWwf7x+An10TX8KeMv5kO8Gt/lshpjtJHg7hYu9+v/BXZXg2u+GHMeySha0nA1jzUGgNGKj8D7guHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtBoGVKYlDbfQyTndOWc1esqef4J+zpwcn6C8LUQKoHE67Uiu
	mm1FMthEVeA+XOW8FrUBs26aM7ouKyvUmZo00pYZFX9Ai8E2sALUczQnbGzAR5nPjhf6PujWSY9
	T
X-Gm-Gg: ASbGncs51FrEVGNRk6as14f7YFFcx3GJrwSvs5ex8wWCxcrIb6XejNNtCkk21hd9OFv
	YIQKgeGzhUqPMqHq3tnuAIETVDiv61+vcSvVjscHtNyFxMcXJ0ufYfw+dvhVWvB/YjesvSuBHC6
	lHLCQVGKAxrPr/bY6XV+296mgM8taPkLQQZpAF5Yqx6L6c8mzBOk32J75JoMwL9dnIarrEbmOug
	2e/7qR9/xH/1RBB6rdoYXQQmmRzKsy5U3m6nbGLvmL+DGQEHZGG9D2hQ/YumLRxuq8pzJtR6mIC
	M5WfA8Fert/x8UDgbMv78XDV/+eWx6QcOfYf066lmNDJ00w=
X-Google-Smtp-Source: AGHT+IH3nywXAStMc7fVsLOSc4VlZO41pla1zTMf86Ld9YGrejdTYExNnf8u2y6YSKz+yvEx7GllNw==
X-Received: by 2002:a05:6820:189a:b0:5fa:7bdc:e88 with SMTP id 006d021491bc7-5fc5e7bc42dmr3039099eaf.7.1738958969117;
        Fri, 07 Feb 2025 12:09:29 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:00 -0600
Subject: [PATCH v8 03/17] dt-bindings: trigger-source: add generic PWM
 trigger source
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a new binding for using a PWM signal as a trigger source.

The idea here is similar to e.g. "pwm-clock" to allow a trigger source
consumer to use a PWM provider as a trigger source.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Moved file from bindings/spi/ to bindings/trigger-source/
* Updated description to not mention SPI
* Dropped $ref: /schemas/spi/trigger-source.yaml#
* Swapped order in name to be consistent with "pwm-clock"

v5 changes:
* Add MAINTAINERS entry

v4 changes: new patch in v4
---
 .../bindings/trigger-source/pwm-trigger.yaml       | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1eac20031dc3cf921aafb8aa37f4e4eca1075835
--- /dev/null
+++ b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/trigger-source/pwm-trigger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic trigger source using PWM
+
+description: Remaps a PWM channel as a trigger source.
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+properties:
+  compatible:
+    const: pwm-trigger
+
+  '#trigger-source-cells':
+    const: 0
+
+  pwms:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#trigger-source-cells'
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    trigger {
+        compatible = "pwm-trigger";
+        #trigger-source-cells = <0>;
+        pwms = <&pwm 0 1000000 0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c37504e2e19f067b9835a28708dfd1d25700a608..d6ac6cdc6278536b5c4f81ff183588b491798036 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24103,6 +24103,11 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TRIGGER SOURCE - PWM
+M:	David Lechner <dlechner@baylibre.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
+
 TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev

-- 
2.43.0


