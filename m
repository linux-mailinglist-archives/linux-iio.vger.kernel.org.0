Return-Path: <linux-iio+bounces-11566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072279B4BD3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 15:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA611F2433E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F009207202;
	Tue, 29 Oct 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0B6H6gr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6A206E8C
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211226; cv=none; b=rW08jC6s3R5a/dTNHDGK+tmAfMNP1gHA/gkUsfRcVJxolXk/EwbbaydV367i88s9Kp87FeEGbmJAEWdi8Oicc0MNI0PIFM01qYcS0dUaPXRLYskqyBfSzVBLJ3Okz0GtgtYsPc4ROHvn7H3UexD52lAWMqDZn8CbdZ+p/Idv5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211226; c=relaxed/simple;
	bh=VCywuuwYQzUwDiW7Kdz78e0AbhF/gpt3Et+zeQEyoQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/g59CBRpkmIkiIjQ5te6zZKhARHEaev0Q2fgBxvKgzNAwuavjujSEe4Z/E4yIpPp74//wV64oDWMu6SXODOIyd+ZJUSP3cHxIleqUZRs6XK25dwK95uWm9Z/mH1ajnll4lPVX2mIG52S+JbBNbbrs5+EnSbveabv2xyc1Zbuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0B6H6gr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so55143375e9.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730211222; x=1730816022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ouv8MfLcp6Kh4uX/Oe/HUpjciTuIWZJObxnGJ4zstA=;
        b=w0B6H6grrZTf9LYuCqniN7K+4zleCPWAo8pBC/Bx9lvRcRH37WOrSUi+zr4Pj+RGzI
         f5Ixd4iQZcWDVfTcmy78cPa9Vlniiua9X6uBDq6oULFFKp2dW7vRJKmh8h24YFUjCdWo
         clTSZqGQFof7sXOQ3+Y2A7MIiQFQOmPMIx485HK2U6a0Zr7L0UFK8uxyLovMdiqeyExj
         Bi297J+9QhyMPj7jluMhzl/xewqp9s7+EcZmoTaDdLWtytPnW6ju7AIHRLR96LKNDyD/
         iAreSzeBkDKcvAuYSfBp77oNMAiF8dZcbtUXkMMUsKN0lUWklEDLU7JzP65LGN8WzgO9
         82iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211222; x=1730816022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ouv8MfLcp6Kh4uX/Oe/HUpjciTuIWZJObxnGJ4zstA=;
        b=DvLEy8X6SM6IXF85wlXRejc2/NV1lcyQhwn93/+qLeb8vgd+r4jpNVOIS87JzoYLGy
         jBhxvJH9l7M6PPzTrV4yRHjRPTDlc8UKWCh2sJxGBCXUieX0kdbO9TZXJCihaLk+n3Ay
         INUE9x1avzVKbTwoOsKnzHCl0D7deeGQVlDeztb/1dP/nUKfPHxIsnOWTvep6vaCkiYf
         +dpnLTIBrWx9hmgC+2OI9mE4YA4xhg5fgYNX+W3t2DuejwqgTo1wSt8yajX7Lmd821v2
         Is2ifpjqm8ePuz3bp41mfbST0wMAtOXIEaPbpWPCj+Tl3uQO93JKsg5kymyVQ9etjVYL
         eQiA==
X-Forwarded-Encrypted: i=1; AJvYcCW333JbGo2K7jqD3zFkbIeIpP18rLt1bcohjkOk3RW7cA0SlTui+aGHCy4vxd7btthq20z9ENmrPRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMYZT3asuUt4vjktxt8DBtIhBkCp/A1OIbnVIRVZbWLGwfN2I
	wXk1rArX11vtfNcbaLO7BGkQ0sMgF+gu7S8u4atN6XOe1NO9RKx/IYB4p6lnEJA=
X-Google-Smtp-Source: AGHT+IEhSzI6MkzwuSBStylVFC99ApyDudmpuZxswYmr9kO8wAK54bjE2YK9NngMaJuM8w1OYco1Aw==
X-Received: by 2002:adf:ff87:0:b0:37d:4dcc:7fb4 with SMTP id ffacd0b85a97d-380610f4425mr8604397f8f.10.1730211222424;
        Tue, 29 Oct 2024 07:13:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm12645871f8f.71.2024.10.29.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:13:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 29 Oct 2024 15:13:38 +0100
Subject: [PATCH v3 2/3] dt-bindings: iio: magnetometer: document the
 Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-topic-input-upstream-als31300-v3-2-147926dd63b3@linaro.org>
References: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
In-Reply-To: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIO2Tl/Vg2+ITYFpFcJV1+DuC8PrAmVDuyChXwu1/
 hvWYioSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyDtkwAKCRB33NvayMhJ0WxKEA
 CLoWyTN9jcuu4PtCNp7x468keVemyG4Goe59+9t+JRbNQvh3mavFYoB5rWhZJQnlmGK5C2H0ZrhmYK
 UDm+zC3ziHxJzc3UK3Oi0gSZ3U9RRW6cL9zwG2SiZFasblB2xK2rpmAw/4wyHqp1XbHOfpquV3uLbc
 zXxyvY4WXhmW1jPk8RXIzNgMsp7zkWlI6lp6HiEoB7Qfz8bETrCvwTAp+LnmYHr3k63TfYuEuMRFwF
 eAUkQyI/WtCdwT2IYKNOETxdqYCDFSntOOWMSzATnWWRWTpwkZk92M6A7QZ0BtjNpcao8y9lVFPtYo
 FAUVbRZa/Eh+dwQtZB/59E73blGeD3tg1S8rydHsKms7XK+Au4lf2QWqCydh01HJk+QsfmN3vet/Yx
 gSHPrc62Q8D7fpyAZ9gt+Td03t9WjgDqUF6y/JugYoGPnm4JXkydtBklNX+FdAym4SF7Y6xu1Q27rR
 qCVpz7pCjEJcmuCrLZC13qYAcYjxe3BZqd6TBX/t2pGIX4nlnxFbkKQhHN5baVhvsxhP1gZuCjYRu6
 sHAF4K0pTsHzHX3g8rxjNQdnhkJ7Y0qZCueXBYynR2v1KHjHwzSwxE7V2eDADSVT5gDb4A6up5QMAO
 xe27VY5Zdi1Taxmdmv/j7btsYDXVePzh1Lv/gvG1C0PJKS6/D8S9HK+5AsPQ==
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


