Return-Path: <linux-iio+bounces-11625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E108A9B67E4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638091F221A6
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853942141AD;
	Wed, 30 Oct 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBd3ana+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BEB2139A7
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302233; cv=none; b=he87hRtv6sTGuOqQYnO5M8g6vvvwa9nPeVit70VaA8h6njzsow6K1HI2oU9f4UOPZdfMQrtYEminp+cutqavO+jmr+pQg9VCtyNXcRKyuqwKdIxlO8HPB5N/MS3byiIesXbvhHVz2y1+B7SLlJEk+xj5iE4sBfBYXi5v/r+V7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302233; c=relaxed/simple;
	bh=VCywuuwYQzUwDiW7Kdz78e0AbhF/gpt3Et+zeQEyoQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alvlg3gLIX2qXQRLMyZdlk08QUz1DJJzWrOYj8gR2E2JDQEv3blC72Zbf0WbABKy8C3qn2hWqhkQt2/J8N3TFl6nkeisLjPUfCJlmNdrPInp0FpddDjgpPFPLrVZCNj7jUmP9a30MRTn3MM7tOhpg6zXUDz5KJCrxJF9UXixKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBd3ana+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c452180so7017175e9.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730302229; x=1730907029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ouv8MfLcp6Kh4uX/Oe/HUpjciTuIWZJObxnGJ4zstA=;
        b=nBd3ana+aZ6oUGFfNZqxG/Mnr6Rgdj6NlVaZzkUTx+NmLGH0ngkr47+64T8zqZDhFi
         wephGOV3AXzozstG2SQ5EkjmEaEGI/xT18erEDv4sf6nkLvMoyVUsSE2USdWRhQBXTr3
         P0nKQfjjQFfYH+ES4ALXFtDCn1kLoNHzOduSrCvneOOcYZeK5WYPE3G2PvEGSEMkhcIz
         gvDAp26k3cIWHx3AK5kjqsrSaZRXcv2W7T2irLhHyamIGGCx3weRP9y2tTnJEAEajvDn
         KCeZ9Xqgwy5uLS44YZjpTGKHNaUr9f2lR95WSi3HvtZKt6CXkgZPzpNyFlg0ADfa/5jM
         BEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302229; x=1730907029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ouv8MfLcp6Kh4uX/Oe/HUpjciTuIWZJObxnGJ4zstA=;
        b=YFJ6k1A/M1GkkqRjvsRGcvmQ3VoEMHbCVJ3QEEn/RGqJ7VMwWaJrWqSgJxbhhoZArK
         CcgbVW/Kvf5CVxEhnd6CE07kZt7bBoURFs1Bofegy8OurtHsrw0r5H5OdB4mGP1Es2pO
         pRkSiQ8PCLjq18yl4JCqXySISEalk7VUeKpbt322rUKFhEfTWSiThpgIW3IAzHLqCpl4
         AQM9I2+fzysEvWYdKFFpugr/ZuWQQV4ae9JaGw8IQ2XdeFDq4N7SjA07lVvPCHOWRO55
         8RwWdcdcJmNyWFoWK7NPMHAhoD8MPHK9udJ7K011eTRf0tUddV4DdHPZPZ+mgcbWLASW
         IF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlN+GJvEl4HYQV8Sm7CcuvxcrCLMGJdpMQHjz/xLTCEaxt375TZzbe3ZPBF13K2fIPuyG9fvwuF78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWOt+nPfc2phWDIKZVOzlh+fdRaLCsBvSjToYYe83xbsRFqeX
	AQ53yxFithHQrM48KAhSpVfFwC4Bf20oEXU9yHyqPyAIrzV7b2hmfBYUVgxB0P0=
X-Google-Smtp-Source: AGHT+IFdcA3r60tQ/UYq/rCP94zXhnuaDucY2c1LJoUNA2Iuh28irk5zqOSChwj/5NLjkJ/efzP4ZA==
X-Received: by 2002:a5d:5d85:0:b0:381:b20b:ff3e with SMTP id ffacd0b85a97d-381b20bffa5mr4537680f8f.26.1730302228838;
        Wed, 30 Oct 2024 08:30:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c236sm15604040f8f.35.2024.10.30.08.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:30:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 30 Oct 2024 16:30:23 +0100
Subject: [PATCH v4 2/3] dt-bindings: iio: magnetometer: document the
 Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-topic-input-upstream-als31300-v4-2-494297c9e50a@linaro.org>
References: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
In-Reply-To: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2381;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VCywuuwYQzUwDiW7Kdz78e0AbhF/gpt3Et+zeQEyoQ0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIlER0KyvyI/liH7ZKTXqG/Vj/JCaNfHcFA9dhJvm
 eBe8taGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyJREQAKCRB33NvayMhJ0TeND/
 4ji6YXqtO2WEH2zX7NFGwzIQWGaX4r4K62XKUKx+tNj5nsQB9Hbzasv8qKTIQSuGpj+cQ37l3z6JjE
 zqte7593seE8Fe4v5hudBgZOg4nVXozcXGr08PiVwH5EBYU1ixqwrJFoLFt5P46kRJhaG2KrSqlWYW
 jUJWSjLYZ24TsaK4lVAYt2BD9V7VE3Z+Y27jpnJ+XOw5lMEn/1yV8fX4l89R371tOF1qWVkpCfaPcv
 VaW6vxt8p7SozHrzTfyiKqOWgI+295rQriBCPuiEGgdpgBHrf3sRbGjTrgaNAFL6CnvxA6watDMIG9
 L3gZomb1SLvam4xWGCYpiOOnnxFzPDGO89yhEHO5BFdhHbrXSdbtsBQGZmyynh/dMFVMEPJRM9b/XC
 Ywncp38GpAg17s9d96kkOSShCmiwfcwnR6UengHz5YBERYGTOZGC/WrvY1YslM9vwz/lfDCjd6QnfK
 CrqTuiy9ZxZv2vCRlySwRYhvwuSZvpQDe9ysOAs4FkblKjkwsDlJoLwTIzSV0dDxcKs4qwQAjFodjU
 h1/Aq3DPMQQHou0TM8nu71YxzvWK2APU1d++zwWCPA3Pv3IM/Q2qEMbiZoyoIjuhnszWTW4XDv65D4
 t8ndPzrt0X4F9zjNqdL/YL4ZbU6N1BbNmxJwrfCUkFX+XT7mTjUP7BAfC7vQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the bindings for the Allegro MicroSystems ALS31300 3-D Linear
Hall Effect Sensor controller by an I2C interface, mainly used in 3D
head-on motion sensing applications.

The device can be configured with different sensitivities in factory,
but the sensitivity value used to calculate value into the Gauss unit
is not available from registers, thus the sensitivity is provided by
the compatible/device-id string which is based on the part number as
described in the datasheet page 2.

Datasheet: https://www.allegromicro.com/-/media/files/datasheets/als31300-datasheet.pdf
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../iio/magnetometer/allegromicro,als31300.yaml    | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/allegromicro,als31300.yaml b/Documentation/devicetree/bindings/iio/magnetometer/allegromicro,als31300.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..52e3781834ee9d98aa84c5d340ae75ffbf76f925
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/allegromicro,als31300.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/allegromicro,als31300.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allegro MicroSystems ALS31300 3-D Linear Hall Effect sensor
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  $nodename:
+    pattern: '^magnetometer@[0-9a-f]+$'
+
+  compatible:
+    enum:
+      - allegromicro,als31300-500 # Factory configured at 500 Gauss input range
+      - allegromicro,als31300-1000 # Factory configured at 1000 Gauss input range
+      - allegromicro,als31300-2000 # Factory configured at 2000 Gauss input range
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: 5.5V supply
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      magnetometer@61 {
+        compatible = "allegromicro,als31300-500";
+        reg = <0x61>;
+        vcc-supply = <&hall_vcc>;
+      };
+    };

-- 
2.34.1


