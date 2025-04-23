Return-Path: <linux-iio+bounces-18580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36894A998BD
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB34A2454
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 19:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376EE293461;
	Wed, 23 Apr 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIDus6cc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91118291170;
	Wed, 23 Apr 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437289; cv=none; b=WZdbgq5iZ9yW+SN9+wvQw5UyiPtoyl/qcOIg/olxvh5Al4EaModKCEJZB5ZKD6bdwWE1+vlOCyniqmaCB38P1s8NYZYyU+gs34btAqgrYjagiOeUb/mWEXexatt3k8DftnTAAB/go+dGzxVM2kzZBIKK1OzbZiDPrv6GBc8vXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437289; c=relaxed/simple;
	bh=yACdJRSdFlbrwugc5XWqL4ChgNtxLB48ThqI1zU1sTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOdKge3AE/6QNK1PqznZ7ReTdLhpTmvZ/BTsfOr3RnwZjjTcGc5XW/j3/Kfx5wEEyFbHloX0FS9G14VFnWRxSDpQQz/KJcYpjdHO5WM/ezB2/6f1lrGvNWFJ3otgSUqq2i9jv8Zb4fmuY0a4GNMH6mbTjg9OHbcgFQ3aULn+gjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIDus6cc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73712952e1cso176307b3a.1;
        Wed, 23 Apr 2025 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437287; x=1746042087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Iq2RtCkIEuYnk39B5deaIj3H9MzSo+wi9CKer8HoYQ=;
        b=LIDus6ccxqHyz9MXxTfaEjjvw93lOONZX5/gNCXFvesQN2Q/HjWLB0q/DuyguMDj04
         0agTAxTvLMKAM7oU/slGPRmFGyT/FwVFHbwRmrUPTsUJK8cysl9kt0SpMFDYsXt7MA/b
         ZhHfCN2UKSeNwo1hzHtL8FiT8jtVQCWnsYcyx/LqghtyGzmIflH9N7VcVOl4JX1vRmJU
         9g0FCLAnzgj6U1h12rkusHGfTu6bbaamLDqkb+1ArYMcL97mL4uhzQSuv0XJ1LVJvS8O
         W2kMH6TWBXH0S/rjThKaRcqXUSPq34vY8NXESnl7PnxVuHDX4/QxD3acxQ5cn7iKQBEX
         pfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437287; x=1746042087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Iq2RtCkIEuYnk39B5deaIj3H9MzSo+wi9CKer8HoYQ=;
        b=E1D7SxwWEGo/Rjp9wJ4bvvYm+vdcqb1kv5jZnEomo30DTUB57azapE+B/KEAdxdBnO
         n01M7+/frOudEIYDJ6bETE1Cff1+gMjgwpvCZT0B6mskXBj/4fQUcJ5XJxERI4CAT3FR
         Xr52fGBNsQBQadjPLXad8Gc9hY8+eVivK/k3FMB6xEEz4N9cZmqPEGtWr1NsEBMpgNgD
         Xtp0wbPzcj4SLzB5OzNckOUV156G/UonW3VeMUsH69CfKkSwnKlzOoNrkPkm0wwmBf4/
         zVowegHQssbV7GaZE5yHvOOwu/Tuar83Vu+Xr9EfVDFztdigAP+0RPVK0yO7Fn3jtZpb
         sTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNCjGg611iDLy+QKVuAfsjbJwlhtNttfXNoWSZzLRj3i8Lz6aYzeBXOUAkfm2IHX5JiOplLwHfE1R6@vger.kernel.org, AJvYcCWaPuLvAGvoL9gEtyAgDJiqbDv9L8fLV2PhKtZ3scaBkuWIvem0CilWXJPZZn/w81mwrMWuKLwFO37i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SS8mDDVf6ECPWX1iP8nK2uGIeIIkZaAuGuThEW+XWlx5Cmew
	9Vp5nBRr4k2Iy1ZVwMMKXI7/dTHL/Ml0mMpzopLKtFxTqnlqQvS7
X-Gm-Gg: ASbGncsqsu4ZqaxxWJrZhdvfGbVxnUbrywE+O0+Ig1hl2Rd0+huwpRaL0SD85HOyrHN
	wXUJE9V8rNx1RXj72rKZT9AesDOf+n2/Ywo1cToZ+x6mgY7zqFN18lOVGCBrjc9FGi7HTyPxwrt
	Tu5yzbfLN5sEK0IsyT4yVlHMuzR3aCWX7cQ6gMW1v6E/rZ8l5xvEPxus3Vx9MXe+dB8dRnw8XxU
	tIYaO/Efrk6jFCAKVsoOMS4vqjq32HH83x0jPKlMZeLk523pojzQ7ZKwSbvyo55QosDyFozNYs9
	mODa4pf2pkKOIfuyWC/ZWPZUCTLXllQ9ZWguN9vtXSBgHfy4/ztA/Q8eEw==
X-Google-Smtp-Source: AGHT+IGVKCdUkBGUPc1lmqk4FZqhTAoQosLoDKSNBRYqhSmRUWWy5MM+ugcR7Ai0P20Ur9tUHbSCpw==
X-Received: by 2002:a05:6a00:2d21:b0:736:a4ca:62e1 with SMTP id d2e1a72fcca58-73e2460543dmr16264b3a.6.1745437286880;
        Wed, 23 Apr 2025 12:41:26 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf6a2dbesm10938291b3a.0.2025.04.23.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:26 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/4] dt-bindings: Add device tree support for Winsen MHZ19B CO2 sensor
Date: Thu, 24 Apr 2025 04:40:58 +0900
Message-Id: <20250423194100.53934-3-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423194100.53934-1-gye976@gmail.com>
References: <20250423194100.53934-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree support for Winsen MHZ19B sensor.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/chemical/winsen,mhz19b.yaml  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
new file mode 100644
index 000000000000..2a6ddb33f163
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/winsen,mhz19b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MHZ19B CO2 sensor
+
+maintainers:
+  - Gyeyoung Baek <gye976@gmail.com>
+
+properties:
+  compatible:
+    const: winsen,mhz19b
+
+  vin-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - vin-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+      co2-sensor {
+        compatible = "winsen,mhz19b";
+        vin-supply = <&vdd>;
+      };
+    };
+...
--
2.34.1


