Return-Path: <linux-iio+bounces-14048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECDA069A5
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 00:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E99F18881BD
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281F3204F9B;
	Wed,  8 Jan 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvEK2S1N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCE1FA17C;
	Wed,  8 Jan 2025 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379941; cv=none; b=iD47i5350tNs67PbghOIfBHhPc0Txr6mKnsrMeQ/6W/FHNLzivOGsWIeTXor6Jq8Ills9T47QV+m8IgDm2+HfLeSTMDhTBWnht5cmK/TtjnPTO/D2yFiylcsXIEXvHMUHKv/13uasdS6oH3jjQDUa1gJ715TLFymdNadzdb45QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379941; c=relaxed/simple;
	bh=WvAlk+1MDLi96JTHIfvWHn28tKJMcqO+lAxClTv6mgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6Oz+OTETETQguLhF0iNqDu9zgOHZKeq8gSpuGyGrBHOqvbKvj6mImTepAg+CfCvFMkODULLdZuefrXcEc+wlF8iw5JcCX/K+Z4SZnt+FJmMcP4OYrNLakKflfgwZhsi3ovBTnq1HNTPTSfXvlKrtXpPyAaSlmaXrR8eMC+NgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvEK2S1N; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso515378a12.0;
        Wed, 08 Jan 2025 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736379939; x=1736984739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi576yClNX5RmrZVdNYDHqJP6gAGDXjnjIkbja5JyK0=;
        b=UvEK2S1NEkcNuQwhOCO5G6M1MOQs1WAYlxudHN13yqY74IyrUlIIiwg0Q/83u2Bz8B
         0EJjRipE8BDoisKef7GmpkTy8+UpWSGAC2YbOjv/h53ESzvdlXOnBpChpJMUITDq9iKZ
         WjgwUq1156JIIACskrqjoRkJSznmxLc1tYvC2doxIeiLFYi/i5sXmM5xwC8LNIeAtkp0
         wRDt5OLdYuYFY/WXuLLGFahdTvpSTPTmY+GbiaPz6WQappmXrdjhrFZ5vLDBKvMUXr6k
         4TVTGqOITUCRr8SamO82POSO0vK2sx+8Svouy3vGg7oy4Fs82NL5pYSur4uwqd0dNSCi
         XPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736379939; x=1736984739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi576yClNX5RmrZVdNYDHqJP6gAGDXjnjIkbja5JyK0=;
        b=nvCsAzfbV6Ftfas5bxkH4i35iBRrFkYdcnvyZyucZ1IKY3SDLem4ZuTofbGoM18BiO
         3GaGE47oaNFcVNr24mKKciqfNIkmDLcE5y0A1WDkgxckSkTLGF9eMLulEf4nYZjFz0pZ
         jea7pxiHVtL+zZIKn6yzzMPsO+sxRHe+1JR8PCytLckcPCDurAzbK7Y80CQ9bA1twF3W
         MhTvf9wlOMrNHyTv0MF1xXpn3GFeVmC3a0l+lXBEgohfVsv1Z+eswUTnQRN6GtF3X9+f
         +YPCTK7U4FQwcwAMH47mmKZPdzHtGUWBNcYcj3ZKhNBKNTtoNI9k8JcPGv6AiwQW9yUl
         ojsA==
X-Forwarded-Encrypted: i=1; AJvYcCUdOj+7M3QXBJs2tBMU4XKLcifStuCExqZ9IId4Abh6Arj+BLxvrOBmqxueOU3MsOU/aQ9/F8X/siIahw1D@vger.kernel.org, AJvYcCWGp2zKf9vEF+a0F9TK0qX/HWvkyJgtU3mH5TxMwA18SWiQAnU9izjgMRPwFzd/mCxUV8VOfxNTot6p@vger.kernel.org, AJvYcCWZMwwBF3UhnItLbSFBHzIQNmQnEevqO/e+MZMjLlji1YPq0N1k62vEkGUXE/23OAzzT6HLklXSYiuC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8tYiM4HyjpCiDNDsST7kVXB29igojMa7WJhJPlxpTGv5vmIn
	ykVPqzkz6qMxST8Bn5JO8m90pRHjPh5dcabrEqTG21dluE7w+BJ4
X-Gm-Gg: ASbGnctYphgFFxdllZN9f6/5Q9scqDKplqwEU+5lqtXHRHIuKBKpENlBYUMzJcyfod+
	DMJeAgu0R31fUc624E1OLkMHqhk837mGdt1GyCqVNSBVq+HV/Qg+2sXJq0dj7IN96BSAX1Fi2RR
	ZiQbp0GK2b/OSWLzBxlWAxHuL5SkJ87Z3C4d2lN2N4C3vMKleEEf3Wc7wp2o5krEu7jHazIj0+u
	Jla5dEwYZjmOHEsp0Dr9QQfWtXj8sGVURa4igPa5azi8wCgzaSzuw==
X-Google-Smtp-Source: AGHT+IEY1u46OUcaUizG2/3rQN4J92x0slqlwWkz8/nRuxG5h0i8ku8dB5cATLregNxF8Y2UfnDulA==
X-Received: by 2002:a05:6402:3493:b0:5d0:e73c:b7f2 with SMTP id 4fb4d7f45d1cf-5d972dfcb29mr4218817a12.7.1736379938317;
        Wed, 08 Jan 2025 15:45:38 -0800 (PST)
Received: from localhost.localdomain ([37.161.103.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c32a0sm3108a12.44.2025.01.08.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 15:45:37 -0800 (PST)
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
	and@kernel.org
Cc: apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add binding for Si7210
Date: Thu,  9 Jan 2025 00:44:10 +0100
Message-Id: <20250108234411.882768-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108234411.882768-1-apokusinski01@gmail.com>
References: <20250108234411.882768-1-apokusinski01@gmail.com>
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


