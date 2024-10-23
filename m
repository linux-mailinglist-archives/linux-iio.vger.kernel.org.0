Return-Path: <linux-iio+bounces-11025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E829AD600
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71751F21FFD
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB21FF030;
	Wed, 23 Oct 2024 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mCa42Cax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89B1FEFB6
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717172; cv=none; b=rSRmCY4kL4mAtF+bz9jWMEf7IzMQHs2BrP0p/bRxsDyD26aTaSaQpovaXyuI0qmdGru7OvVLDkb3tlsCpAuLSL3N4CECep8RPSHK1iD4inMLG8PBvgUJR0GwxkR2aLM8vpTVTwkuOtey/wWKFey//WdEIHwX9S1a6IvUIyDeW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717172; c=relaxed/simple;
	bh=EhwFAySOu0UzQT81pSGmKbzn70uQw3/Gq0l7793qgAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KqPSgey+UJu7qYjYWTJFPzFL2sOwI7ybQticbEbxltXixYfyPPr09s6lGWSHK2J6fVTgGKDjCMB9IQK4PU3C5Se9ZKgPPxZIryOYk2zPaVvctITPzFWPZZNekj7RCcWkPqE5bZyJXFjveeO1yJPUTSHyU6L573Li+bddbiYvZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mCa42Cax; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5eb70a779baso108267eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 13:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717170; x=1730321970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbZ0wRS+DoaTd3bUw74mY2hSGs8UvSjvOOeAQWDWam8=;
        b=mCa42CaxdB1jAlc44sM720Fjss7NuL1jctnbuU1XENxgsPCRNeP9htWuFtDrgf1sZp
         ZfVbfMrrcn7g+JBm1kw+hN1e2/jKxCLO7mbe/KcxLtjkS5K+gmS/FkP6iuycQBV/nD6P
         aYT7ScVPpGxO5OmBuxP8rxJP0QILL7/Stcfc8XhU4oOEEeVtU/2iOWzcBXayX52yykjZ
         MdMBtK4Rradwl4oaFnNnKCiggZfk2OHW/8rTctM9nfl/HFBESDLaVlkaGjIBlFDrSXe3
         LlqD8zcnK3ZObwEi+PXzE093SbxJ6+kbz5R+BgWI5ZGoFAnsOhs6dVxtwgnN/QLYV9KW
         hM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717170; x=1730321970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbZ0wRS+DoaTd3bUw74mY2hSGs8UvSjvOOeAQWDWam8=;
        b=j67YdhEhBC6Fa9lytIo6EdDnQlMkpw/3Zf16/yKe9ieKHfaPwY70vGQrNtl5C39o87
         b/yDZDq+MEGKSxF5f+lP+fGAqfzIqdLlErb3gCKk1VI/snbBvzFm2MuumJ47som1Oj+y
         EUPJFxLnKB2jx/4Am1r+myAMJ5eaz1fA7HhJenBXBSACdzOpwFkmKGF4zHaVtTv21XSv
         BIXeUJxRuJfNZKqeA2EIG5PHLAzv94ZLTqfj0rGdki+JSJzmbZ8JPN5BtKf85HrKS3g7
         0U1jJRh78AAPQ72Ju3R80A49t+pyGgCw0rUH8gaxRFz1OTtmTXtm1aTKR0iLRf0TOOv2
         vZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXV5JBCRIIpnGqxOpJVvq6/mbsUB4IMvaJVJ4iphG2w2sU2ou45+r2t6aiUa0m8YEKZnOLNj27xmaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTvUqnSDuR9i1GqRsNan1kF+FQosURVCTSq5WxxjLBWasULAF
	AeEbKM29GM44n1GxsVVIb0rfJD6lTmGZSlNgFRlp8Ipj8E8LcPLBSgBv+JmVzKA=
X-Google-Smtp-Source: AGHT+IGpSU6q9EbnjtFTPIfmjpti+RDQ5TmJq7nEwzLoenZew8VbFJCDXbbHeqPv7bl5G4IcllcUxQ==
X-Received: by 2002:a05:6820:229a:b0:5eb:c72e:e29c with SMTP id 006d021491bc7-5ebee94cdd8mr3110098eaf.8.1729717170663;
        Wed, 23 Oct 2024 13:59:30 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:12 -0500
Subject: [PATCH RFC v4 05/15] spi: dt-bindings: add PWM SPI offload trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-5-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a new binding for using a PWM signal as a trigger for SPI offloads.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: new patch in v4
---
 .../devicetree/bindings/spi/trigger-pwm.yaml       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

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

-- 
2.43.0


