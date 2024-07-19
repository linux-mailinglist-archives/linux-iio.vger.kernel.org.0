Return-Path: <linux-iio+bounces-7709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC29377FC
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 14:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C3D1C21030
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BB013E022;
	Fri, 19 Jul 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="OYlJC2Y5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6913AD04
	for <linux-iio@vger.kernel.org>; Fri, 19 Jul 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721393465; cv=none; b=NrpBGH4Y9I77awZ0evrzXiDtDY+hhq2w/gK2bYqhGlfzbljtxovFXV7h9M9/v0Mj33Wm4FtlIKRzg2JeGg2YSsSyr+MrUwd6iUsQxn1eEDllUXBBQExzux5L5kHREL3xXRajV0uru1J7qWx3JlHm4+QJv88UWzW86RpXL/C6v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721393465; c=relaxed/simple;
	bh=y/rn74vXp3VmNsr+fCQxctMOwKY8V1bRIITpxLrG+I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVVB9q2usvWYHAdEBtsRimgo9SPbRxcpREgs4TrXIzQ2BFBgzf1CPFW3w5QVzSqvnAzyCxUc5e+MAA1SX8uXpzcQSq0NgP8ipVToodJ4Ear84sZ3hDo3opmUy1knlOTaYHP7rAzywZhTjSJQMz4Rbnvl3Q/jRCUVEuFQJByAVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=OYlJC2Y5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427b9dcbb09so13026725e9.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jul 2024 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1721393462; x=1721998262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzdySMOqaABd0LnHE5maj2gn5DJm78TP1NIjNJNGE9s=;
        b=OYlJC2Y5G70GmDgcodM/ToyMlILJ7MVlD00H5xmd21uYY4uoHboU2ruKeFpNWQxo0i
         7zwypypgjTFrxwqfjMTNvZ9m93YRS8ceWW5KWe/lHlzIXGM2eP0p+1BH97f902i8ZJ44
         gegq4rZZ1leqGP/kFYjPonHQHlzSivynZsvDaHUX2HtKcHn0R5T6f29/mnB46ok9MwRi
         Jxk9SgdI+fiNVCQzFK8tpSloJOqcKieofBsNHrGZYgdhQJ+ERIUEhK//KadcLHsJL9zu
         Z6/1Uyfi7NtLu1ndR//zfXdyPEGTq2kb0HIhy7uZD+DhlBYstPQ/mpyFLS8XP6zl0rq0
         abRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721393462; x=1721998262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzdySMOqaABd0LnHE5maj2gn5DJm78TP1NIjNJNGE9s=;
        b=jGK1XC0AdGaZ5DsYC/5lfOqzOGVZL2Azn3QFdVmk1+7KJQKfJTcJGjJxGdSvFtG75t
         OzC74DTjMmnjDywNoZEtjQguvkOE0KWm7Iy8KQkMDNDkLKBZjWcXoFLqHUvKVBO+HoA6
         ARMRzXGbYeDpAoGxjjFh6MuHovjqn8I8rK6FlhmOjUxggQE+umd/qcNKuCaG8R1pAdWl
         ExophXzCNix0mCaUizr+aarrw8HZOwWkuhviITFC7TyQfJHatfZB28v1U/zbip9a2a6L
         QAVW6pDhTMR5b9RZZAHQQh9el6lrMt7QCx2oK4ke/99RgOGEBdR7sehE2gynSdCDYUx8
         WcCg==
X-Gm-Message-State: AOJu0Yyk9S7Iu8mBb2j3L1e6lz8JfiG7fQ4N3BSnzix7/HI5gnA+gvil
	xDVw1ba/t/+kr0bLFKBO9+ewQGDZkpQyvRq+IUv9xMcn9J6knccfIwJ+YwFy2nY=
X-Google-Smtp-Source: AGHT+IFX/fqMk6o+eSLJ9BoBQxkMeXzrWeNbqLkcz1jdyKXAOSt0NwVBjAmM2mY9yLx6s9q+2K2yIA==
X-Received: by 2002:a05:600c:198b:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-427c2d1bffcmr45251875e9.27.1721393461773;
        Fri, 19 Jul 2024 05:51:01 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2911486sm21217445e9.0.2024.07.19.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 05:51:01 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Date: Fri, 19 Jul 2024 13:50:53 +0100
Subject: [PATCH v4 1/2] dt-bindings: iio: humidity: add ENS210 sensor
 family
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-ens21x-v4-1-6044e48a376a@thegoodpenguin.co.uk>
References: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
In-Reply-To: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721393458; l=1876;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=y/rn74vXp3VmNsr+fCQxctMOwKY8V1bRIITpxLrG+I8=;
 b=JRludKGe8VWUb/+d7PZAhqnN35sT0EnIdca6S6VfS1uASfVfZVxSYzR1Wpos3Rw6vfu6FUaG5
 eYwbJOGhFuLBAcv/gAPFWDKzBE+Oa20zF5RI7/sg89zi9QovuCLJ6XO
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

Add device tree documentation for ENS210 family of temperature and
humidity sensors

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 .../bindings/iio/humidity/sciosense,ens210.yaml    | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml
new file mode 100644
index 000000000000..ed0ea938f7f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/sciosense,ens210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ScioSense ENS210 temperature and humidity sensor
+
+maintainers:
+  - Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
+
+description: |
+  Temperature and Humidity sensor.
+
+  Datasheet:
+    https://www.sciosense.com/wp-content/uploads/2024/04/ENS21x-Datasheet.pdf
+    https://www.sciosense.com/wp-content/uploads/2023/12/ENS210-Datasheet.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sciosense,ens210a
+              - sciosense,ens211
+              - sciosense,ens212
+              - sciosense,ens213a
+              - sciosense,ens215
+          - const: sciosense,ens210
+      - const: sciosense,ens210
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       temperature-sensor@43 {
+           compatible = "sciosense,ens210";
+           reg = <0x43>;
+       };
+    };
+...
+

-- 
2.39.2


