Return-Path: <linux-iio+bounces-12317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF759CF5B8
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 21:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725FC2837CE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2821B1E6338;
	Fri, 15 Nov 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hc2TLK+W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312D1E412A
	for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701938; cv=none; b=CUZKl9Pjsy3aXklYJxh8ItlHUCS+U5btwJSs7309NFDjCLGB0I98aKrVbFtb121k4veizqls8fXrVlBw+4EM2HK8zgL7TIN9D7wpVA3raHhIhrj6mi7/nymB9q/E3HtLUteYK9KexUGCuZ+Mn97wcFVAxqkNBhV0UOQvkItHGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701938; c=relaxed/simple;
	bh=wsgGx84cWBUtGa7G4wtbH/BWpIo6zEAdmqzXQ6w3/1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nq2sM5ML+Czh4TyXeVR7I3MNzaXH3XS+VZ4Icbl6CVKvIm4CDYE3R6p5x5H1K/AGCLvwsivuitk8/YG3rG9WULX+obli/IzRPyNmjz/oAmb4XRY2h/4+rXKuPAwztcLqZhKDOwBfJHw38Xlz0dgh1+6cIvwawwoPkDIKYzP8JCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hc2TLK+W; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29645a83b1bso364111fac.1
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 12:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701936; x=1732306736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3err676nsDhVRmrJ3FZsk1bPZcnOqEf2IqEsHND5yQ8=;
        b=Hc2TLK+WCyNylftJ1Ghnqidab30k6a4FIErC/STwtwJSYhYIlLKpCKr8YkU0qS25By
         CGd5WXUj26ThVrYTDKN39NTX3AA4AFT0DwzE7Y+i4O+XgFBJyCyJHl6JdRlMaYfunjgI
         kAkeN4NWU3T7DXmjHTV+sKA73+RjCFKhoy/oDliAOHuTBpqjuD4RsRKEOANE3079kGdc
         14Kb5dJb6MkeZ38pimvMKEvbTal92aisGTNF8FLms533xxtKW+iJfbDtw1CiS5E73MvP
         8yohe8hrel29Kd3ArwbUku/q9CFyK2pVfzAbxjNfCYwMCzUGLLVfCf3f6o44gKxdgvcO
         MDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701936; x=1732306736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3err676nsDhVRmrJ3FZsk1bPZcnOqEf2IqEsHND5yQ8=;
        b=drRQQrpHdd+pHZN61jD+zspLXL5BCODHtgaJ0C19JTUlNMEFHc88vNqVsp0Ycj0/5O
         Q3vXikfVCXTAA0O3CcKZ9KO74/P+YqxH0B/oHG6jQ2WuosNnHNT2rUGXVeKguCGl/UeM
         Ope8KPFdHsFMl6QUUQA4jnDoKSwIgAKMJj6RDu4BCe0X4Go6kwCD4DtqsXoz66abXOtO
         dF48+LH9y3+XLrnjaxqCb7nPYIwHTJ86ZFu4Xn99WcZVpSHGTsCDPGIvjFeRyQCcqe3p
         HBQZVM0HDuNUcvou8hJ8A/OA7rWOqo3EclzTS7/DFKDF425KJPPWACAPafOyWKeTU4CF
         qxVg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Pir8+oCdpAwLz8VHB+YfUSLOVzclb8ruve2anHDxccabvuH87IKO2W0FrojujSDd1X1ifsDOdrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngWQhxlU0bPTxX7aprcJiUrSrYjaoYObxa+OrueDxxRBh3+mj
	lXUJguXjX1fTWiQJ74ojNJwxXsq8klpAvwQYo4frcTyYL5AzKQYeXTu3e1JNkb8=
X-Google-Smtp-Source: AGHT+IFslhtXy2tcMW9lG2cdKDAvgBpEw3gZ1sN7XsFjpAzVktIDpcBrd6KtQD9GxRg2iyWZ/5Xb+g==
X-Received: by 2002:a05:6870:7028:b0:287:b9:349 with SMTP id 586e51a60fabf-2962e20d981mr3793513fac.36.1731701935768;
        Fri, 15 Nov 2024 12:18:55 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:18:54 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:43 -0600
Subject: [PATCH v5 04/16] spi: dt-bindings: add PWM SPI offload trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-4-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a new binding for using a PWM signal as a trigger for SPI offloads.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Add MAINTAINERS entry

v4 changes: new patch in v4
---
 .../devicetree/bindings/spi/trigger-pwm.yaml       | 39 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/trigger-pwm.yaml b/Documentation/devicetree/bindings/spi/trigger-pwm.yaml
new file mode 100644
index 000000000000..987638aa4732
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/trigger-pwm.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/trigger-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic SPI offload trigger using PWM
+
+description: Remaps a PWM channel as a trigger source.
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+$ref: /schemas/spi/trigger-source.yaml#
+
+properties:
+  compatible:
+    const: trigger-pwm
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
+        compatible = "trigger-pwm";
+        #trigger-source-cells = <0>;
+        pwms = <&pwm 0 1000000 0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 91a4a7eb6194..a43532a1edde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22021,6 +22021,7 @@ F:	include/linux/mtd/spi-nor.h
 
 SPI OFFLOAD
 R:	David Lechner <dlechner@baylibre.com>
+F:	Documentation/devicetree/bindings/spi/trigger-pwm.yaml
 F:	Documentation/devicetree/bindings/spi/trigger-source.yaml
 F:	drivers/spi/spi-offload.c
 F:	include/linux/spi/spi-offload.h

-- 
2.43.0


