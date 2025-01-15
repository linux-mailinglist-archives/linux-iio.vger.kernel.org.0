Return-Path: <linux-iio+bounces-14383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582ECA12C63
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 21:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917CD188969C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11F31D9A66;
	Wed, 15 Jan 2025 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbgdlhJv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF821D9A51;
	Wed, 15 Jan 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972219; cv=none; b=EvYDKgnsHGI95xXBDVb8rgLRLJKdA6hQ0Ys8pz0LYHWHOgvfjXD3ZFdmeODsvms4PrBBsx+CKdzpb9EjWX99nmI1Oy4pFm/qZ96J/eTaxtyhcJLX1fxSFJarXg/4czuZZmqmpuCeBDq10adwx9X6XE0rwYJmppDljrs2DEKiiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972219; c=relaxed/simple;
	bh=WvAlk+1MDLi96JTHIfvWHn28tKJMcqO+lAxClTv6mgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXi6mFkf5berm1pvBwhnSV/QtrUwA7IshrKv9mljLdQSBJBleuuK0+0AdqmNx8Uso/MeoTVG4dbOXkgWz0JyiuBr87zMD2J8fQ33YPYU1/Ck+7ioJP9QgVk9YSLrFpHiGOXd6cGV43gh4Ai/vCx/z0yRb35OLI0rYF7qxRYebok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbgdlhJv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so283941a12.2;
        Wed, 15 Jan 2025 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972216; x=1737577016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi576yClNX5RmrZVdNYDHqJP6gAGDXjnjIkbja5JyK0=;
        b=KbgdlhJvLBS70MSVayQQA0PDpDLD0lCIKLKhkL50jpVTeIGMaOjyrR9lYGWbaqGXiG
         elKGaWbShi98lxqqpPEze+ZRZKmt+FIp94EeS4y5/tMrpRLtDIAxJUHhoWEgebsm2MnC
         PNRQomHKNtzF6id5bZAva4FNHgd6buc4KzyhbUUX7xmqR3GEcXyEtV1BR9LjINx6kdhw
         2jfZlhBynvo8nYHE2ZW7ccjHEnRcGfHHV7M/7elbCeybZqq7hTz0DW2EohYXQlvYZ9O6
         AcWtq6ktkWFa0WJh+6cyoNbosViWqWB4Hlz3QQfq/BPAWQJL3o+tckieCaAFCw8vfVmF
         ka9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972216; x=1737577016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi576yClNX5RmrZVdNYDHqJP6gAGDXjnjIkbja5JyK0=;
        b=EKNC62ERZpjN6K2aXGMcIuX6AG/XsYRHm9ZFHY/skFz42+rFs5GPyCmdvHYoRx880n
         3fFk21ZgMVWN8Ora5y53DjwaEpF1nQTEtxo9qiNGpPAgFKuKt+FWRPiRov5JG8afOBzX
         P2Uzl5PLMk0EqYhZrV/5apxsNgrJJyyJuNah+GcXhbHxRQifdawy23/U42WpdubO+djS
         O3iM5+KPa5Jt1QjyOwucrWk9BoVt2XDHQRWu+PIR90icf6mPxBJpQj9/e8K7FmiIqrlQ
         IEV30y1jLitSRj7CeQl8cHijjCle4lGhRwmjO2Ig6+lFVfFHsSpkBtXRdf562iSd/sbW
         fYjw==
X-Forwarded-Encrypted: i=1; AJvYcCVJw87vXIi2FAHlVyV2wtYAergb9vRhtqjf7CwKDbyTqPhwVZPKrlUNyurFsfPxbn15WyxN+kQiHBrUYRLv@vger.kernel.org, AJvYcCXUqzWh4to/9jVF6kuSojb0Lwkb7hnOgAxXlTXEpLzfwGas+VftjBP0Z5oSZNBxnZEBqANVg8lGVsP6@vger.kernel.org, AJvYcCXq8xhIzGdK2/G34EpMqLbApDE/TgF1a9fn2kzQrLZQZQ8Vdfygtuy8lII/18yVsl+LpFlio9LKCWSa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lr36QbL5W1Hoed1q/nqkM+pDY3oBTarjlmyfrd/VT1E+iUvt
	tAoQ6+FYDc0PdLdnC+5N7Uwhrre04iWSFdyxKeJDL+AuvmKy/ISd
X-Gm-Gg: ASbGncuHlk+gMpZ2kZOdUw+e3jeCJJ/O6D4ZNp7/3zUo9RfBnIHKY+HrqdLea++bGYX
	h2Pkd6ISEq+ana9eVLhSQWwTYV1UB/ZQ2dPNwB25dwcRDpnOO+5Up6iL5SxKiP9Dnn/cICXI2oy
	zNgpcR2Zpb1hPJuh1vmFRXFJ6qTj8BEd4UoERprKTq/QyafcfuUm8Aja9ozGCQfHlsn9wZ+IIUA
	EFMA0Tb98P8uX5jyqxIqntVX/L+Gyq+EN11vJBIRWUE/tANQsYKeyixN/ob4uOXQHOSWLpii6A=
X-Google-Smtp-Source: AGHT+IHcB//bcgzpbErd+MoC9HzCTMA270XerK/QuVYdX2CcOZpmuUB407WiCuPbZAkCeqmUcvDlIw==
X-Received: by 2002:a17:907:1c24:b0:aa6:85d0:1492 with SMTP id a640c23a62f3a-ab2abc6d423mr2965240466b.37.1736972215823;
        Wed, 15 Jan 2025 12:16:55 -0800 (PST)
Received: from localhost.localdomain ([78.210.102.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90dc101sm813697966b.56.2025.01.15.12.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:16:55 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org,
	icenowy@aosc.io,
	megi@xff.cz,
	danila@jiaxyga.com,
	javier.carrasco.cruz@gmail.com,
	andy@kernel.org
Cc: apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: magnetometer: add binding for Si7210
Date: Wed, 15 Jan 2025 21:16:21 +0100
Message-Id: <20250115201622.270130-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115201622.270130-1-apokusinski01@gmail.com>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Silicon Labs Si7210 is an I2C Hall effect magnetic position
and temperature sensor.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../iio/magnetometer/silabs,si7210.yaml       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
new file mode 100644
index 000000000000..d4a3f7981c36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/silabs,si7210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Si7210 magnetic position and temperature sensor
+
+maintainers:
+  - Antoni Pokusinski <apokusinski01@gmail.com>
+
+description: |
+  Silabs Si7210 I2C Hall effect magnetic position and temperature sensor.
+  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
+
+properties:
+  compatible:
+    const: silabs,si7210
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        magnetometer@30 {
+            compatible = "silabs,si7210";
+            reg = <0x30>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_3v3_reg>;
+        };
+    };
-- 
2.25.1


