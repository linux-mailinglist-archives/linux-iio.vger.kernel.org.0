Return-Path: <linux-iio+bounces-22177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B73B18928
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 00:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7BA5A1EBF
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF522A4F1;
	Fri,  1 Aug 2025 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb2ksHyC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA417DFE7;
	Fri,  1 Aug 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754086475; cv=none; b=vBsjgyFA8P3GYOHmg/pWi2ambhLMmlcLpO+vSGYKirqToCQuuUy2Eu8GQGDFvz1/9OQAxvk9UqCz5bEcLmgUNXnLmhn7XVPokcdOX/rCvVj2DenH+zXZgXwB+R9Psv5P2hG2PO7FyKLyRro0CnGXZzRcLruEks9nbxz2ULWsU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754086475; c=relaxed/simple;
	bh=6jFFp2TF2ORPTUkoemrBDFo+C640qqrBvWnhcj9YQgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNALiS2nRIVdHHEiu0A2er3togetpDB52k3YCXfILo/uiRKG25igS97pQhiveOYDzsybrrPdGQUZfh/uQ0u84wMjR6fiW8FJKE6AlXccltJD08PudNJtHGhrVsE+tqjCIRki8AJioYi6Jbvelb3DFUvKj4khn56V/T+0RolS0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb2ksHyC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2405c0c431cso27378695ad.1;
        Fri, 01 Aug 2025 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754086473; x=1754691273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka10QAcpnp+/cqg6oNfjmwxtyofLve/81RK2ixTruYE=;
        b=Fb2ksHyCJzFmShK/zYVOPBCaCbtQTPi/hvzYsFdCdRu1Ex9UFOq2UodHCN2fVZsD/3
         eWiwIq3BA0OSG9iOgZpXVtThAJWf1fSFFRywjMKeQL5/4cFZH1U8YhxRANQV/oOOEEwB
         BYKlm7EBryHbovOtTWuc6RNvSdjmHD+9bObVQ9z2nRTPTpr0+T4L5h789vEblZM+VKtS
         KV/ze3JxvuIntLAaN4rgaX0GoowU7vGdtd5n8jBbp23+5ffNH2xOQWYQ+aalkT2IoNCa
         TQwOVB2cnKRe3WaAnAhMT0QX2WXfLQFx4NVk/jRp72ttFx25DuzT/xOAZRgNdpgYIKLJ
         OocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754086473; x=1754691273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka10QAcpnp+/cqg6oNfjmwxtyofLve/81RK2ixTruYE=;
        b=mr9I0JqCbAs/RzF/jw++xpZlcKk/gwgt/rx5o2ywch8t/0T2GXTKhE6cjgUETdIw7x
         GUSCYsSOkGWTJTekEiUN9PTHbi2tnhbzSH1ufjGXf4PaXf+vuYhb8s/vmzLxUlnzmxbu
         0JyNUmvkgCydhGnDTDK/QDWVJZdqiguLdkbbyUXb4i+6Erw6rqPDwL2bwcpuhnH7xKx8
         GgPBO1xbGHscvlRwGX+/2xh4kYWjZQreU8KSNefSaLd2hCyF77qKPFqv3Xabw8y6xjOl
         knD7milk0uD9jkQvUcqIwWQbp9o0OGA7bi+NJQDGKBw2DVPaLLCUw41S9KH8lS7YM6dt
         OpZg==
X-Forwarded-Encrypted: i=1; AJvYcCX3mSlz9+gkW6Ih5IcfTDIU+INcBl10huRZSJopsH+yzp7aKZ0oaFGIlVIYK+gK1hmPhNR6aRjjdidxwhor@vger.kernel.org, AJvYcCXJ6dEPhLg3qp5U78HEIsrovMcaJ4Zrda3CvcId5+f5OGH10zc2WV/297Fpb23Rd0l3tdlVdtVnLDQb@vger.kernel.org, AJvYcCXOAFXb/uLm7OUHFLsRBddUrB3ajE9ksSLnb6wVmeCQ02kGNACYrk6eX4nvMVGug/GL32J+0u90xgsJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AL0Jzhw0PAoP/Kaqc2QlyZL2IKfQ+dqNarH6maI1P2jgoRyU
	CQjPIaYa7a1CZpZwUcKetxLgFVk/XZs1C/YXvX4zcq9cugJa7veOCpF/
X-Gm-Gg: ASbGncudHYJg1HYrUZ2uJW9U/xWDdjqQKEqArTZl+TbmAUnlVsXWVyJ3dPvCP8zJG7S
	3d4CJHmJnn8UBXJaEsRURSBPKkKfgSN4gn1HkfSTZkh40R1tpvZVULi7NpBvuj/qM/WaXJrHYqD
	GfOxg7AzFXnkxJkMholPNxoAj9/2oYTz0fku49GUj8z5SfDPoVVF5J0gAV6f5vFb2r4yjvyAden
	wm/Gmjb3x74LO35eY/63OlxNCmjHUyZrZJS7pwQgM9sU+LXM5ogvjmlROjV6p0zrGG7i8g61j30
	fGV2ELFktrTIO9CKdzwZ0l/ZDcEgCEfogJtgJWlqMfJuaUTFPidn+s5SqshxEER7oUvQg3tz0BK
	VvIByhqtt/4Qd7InqJcMeh34rl1xoWjLo1Y2ERUqbsk8M4w==
X-Google-Smtp-Source: AGHT+IFaBUwtnQp/p9GpecBpVBytui4XP9GVir2TB1oy4UveZJZ7U//s9gPI6sWgitSbxDFIqaxXsg==
X-Received: by 2002:a17:903:2351:b0:23f:c945:6081 with SMTP id d9443c01a7336-24246fe0988mr13127865ad.31.1754086472747;
        Fri, 01 Aug 2025 15:14:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:30ba:c1b2:e5d9:eced])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6f4csm5605047a91.5.2025.08.01.15.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 15:14:31 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	robh@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4] dt-bindings: iio: pressure: add invensense,icp10100
Date: Fri,  1 Aug 2025 19:10:00 -0300
Message-ID: <20250801221424.132305-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no txt file for it, add yaml for invensense,icp10100
which is already used in the driver. Also, document other compatibles
for ICP-101xx family and add invensense,icp10100 as a fallback.

Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
On 7/28/25 02:19, Krzysztof Kozlowski wrote:
> On Sun, Jul 27, 2025 at 09:32:02PM -0300, Rodrigo Gobbi wrote:
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - invensense,icp10101
>> +          - invensense,icp10110
>> +          - invensense,icp10111
>> +      - const: invensense,icp10100
> 
> This does not allow using invensense,icp10100 alone. Try it yourself on
> DTS - you will see warnings.
> 
> You need oneOf, just takek a peak at some random bindings.
> 
> Best regards,
> Krzysztof
Tested against a dummy dtb/dtbs_check and with dt_binding_check,
looks ok now.
Tks and regards.

Changelog:
v4: allow the fallback to be used alone
v3: https://lore.kernel.org/all/20250728004039.8634-1-rodrigo.gobbi.7@gmail.com/
v2: https://lore.kernel.org/linux-devicetree/20250701221700.34921-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20250626212742.7986-1-rodrigo.gobbi.7@gmail.com/
---
 .../iio/pressure/invensense,icp10100.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml b/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml
new file mode 100644
index 000000000000..5d980aa04bb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/invensense,icp10100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICP-101xx Barometric Pressure Sensors
+
+maintainers:
+  - Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
+
+description: |
+  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10111.
+  Those devices uses a simple I2C communication bus, measuring the pressure
+  in a ultra-low noise at the lowest power.
+  Datasheet: https://product.tdk.com/system/files/dam/doc/product/sensor/pressure/capacitive-pressure/data_sheet/ds-000186-icp-101xx.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - invensense,icp10101
+              - invensense,icp10110
+              - invensense,icp10111
+          - const: invensense,icp10100
+      - const: invensense,icp10100
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@63 {
+            compatible = "invensense,icp10101", "invensense,icp10100";
+            reg = <0x63>;
+            vdd-supply = <&vdd_1v8>;
+        };
+    };
+...
-- 
2.48.1


