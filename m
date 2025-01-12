Return-Path: <linux-iio+bounces-14159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B09FA0A859
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245141887FA4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2A1AA1C4;
	Sun, 12 Jan 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmQwu4u1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A761465A5;
	Sun, 12 Jan 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678742; cv=none; b=l9iZZzd0zcj85aWtkqGKn6emnamPyzGSjiU8BOvFZ5XICKIUQBi0fPvirGgYfZmYvimJfsrM7a85l6v2gctP5lPPfiat4XKNmu6QKf2F6nFM6EcQS3TYJs6Au/Y81z6a2wqzL0DmpjjCOfkfHgal9641YxOJat8/jFtkMeJlfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678742; c=relaxed/simple;
	bh=ar1h2TcY1mxL038b/A8b51EXhxGPSiLsQ3DDoDy9mUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCHMfq4+wky3Dz8QBik3Hek+ncgnaAt0874FTcEE/RXvjQhQ2O7RAYsr34HCexodTAuA9Fcbw/hC53oYT9eEr9tKbW9pNUjbyOQnOKxozJ+fV8kTilF0AutCnvVTY70x68Nhqpd+RrzOVU+4lIhTEpL8fhMwDJbcvKu/b+afedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmQwu4u1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so5698331a12.1;
        Sun, 12 Jan 2025 02:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736678739; x=1737283539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDhogYmxn9nFFr/Cayc1gvX78+DR1DlL9ARkoQx2kco=;
        b=HmQwu4u1lSj1Nv2LEroM20g77upwAPuWzdqWN7/N8B3HSDgdSvaejAMPNmJz9CGAg+
         DM/PSl+mO1xy7Ve4aImQ9W11C9D5x0JCCL9S+LeKb/sfYXqs7Dx29sOVsqabohpnO5fu
         G6Dos+gmNQPMMH9qAS+1ZY6kLoyPFZvpwM+nUog/oVwPZXc+boPoWf/UuW8/lgc6PSDO
         ypz2IIFghFcVe5dNR0CQBy9nWgrOb1e/CdZkSHn9HAo1SbpHSmP/P4KAL0hAjSSnaYQt
         9Wj1rvlN3h/YmBLd3oc/3cbNo2LbJV+fRF149rRjuueN2liWak6cTGXoSx3YBBiv7Yj/
         jqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736678739; x=1737283539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDhogYmxn9nFFr/Cayc1gvX78+DR1DlL9ARkoQx2kco=;
        b=LtOdvs52c1SulIY/tyLZiyr6AiE8tLesDIk7EX2VP4HLOsvlqyGKZCzUozNKYV/tTc
         cbmqC1TpujxhuN/go1CdGbEUwFlk9iOUOCDoUwMjc7X9SBcbF4fjRo3DLS8nttbUsTeD
         8YZH7RuFhzZMS+bTIDeXRnqw4MKw+89ZSDAGO47TsUKKd7/haLl770HvbCJRxbMRTC82
         ulBG7lz2reM4bcYpbaOpEG5rkmywGU0xSL3SmCi7vhmIb3ekv31dAJAvdmUSQnX1CUKQ
         ckxjsQzjH4x/Nl7Edbo6OtRLdLwJi63NqjU6NhTdYYfcAO6vw9tIwB7/Z9AxeYH2TG18
         /xFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi8coPSWPei0gMYSCSWXjXSiBtKgmddXAZsZJ/VxzBkjXHeiu3LV9iQIYqd00Gsu1h4XlK2QMFyjdB@vger.kernel.org, AJvYcCWJ0OtKk1Y2G1UnHQSOqHZV3utXoCcWvyRNlBcnDVQv0+HE3q74G6tZkwUX7C3VW7GqBrkXATAbjkNZ@vger.kernel.org, AJvYcCXgj2+CIa3mrO/I9sA5oFRkYaO3Dt++kXR61L431XfpWmAeKtMQslhI7oeHffZ1MIGJs/KIn55lSDkO7LbD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6T1NgdbjCM3AM93WYeqIFBPdtld06wJwTKXX7RB2zhDo0TiTK
	9zkmzVwl2vDTZArJrW8pnAEfEkM/u5+OGQdrKlSZsj81/6B5H92Kv1Yg+iAs
X-Gm-Gg: ASbGncurizSq8vOe+EH5P2njNAvl2Os7XMR4Zzj/eFeELGHmPRQ1cLtYUn+Szr1T6oq
	hAovTDJ1cWVfg0ge2OL4+MCJEM/uirwKl6EETBjBg3Gx8OJHSQt4jYhlifA1ZIDerhIYlSSKffl
	l3ieCvK9BdPMOBRZ8qYcxeysz7rX2VDNefhZcMy/jcT72GwMSs578sbE2556BYojMz6uI4w3FjM
	8DoBT8XcLranfjnhjRV/wrsqnjiDqC9u3fEJOOBLXtmPimsHfMEuA==
X-Google-Smtp-Source: AGHT+IFL7h83YDMROt9kOVp7NBa/dgF4Igi/4ma2DCwtgMYctU423RuAAp7BXGQLylnf6aYQvhZy/A==
X-Received: by 2002:a05:6402:268c:b0:5d2:d72a:77e4 with SMTP id 4fb4d7f45d1cf-5d972e6c9b0mr17259192a12.28.1736678739021;
        Sun, 12 Jan 2025 02:45:39 -0800 (PST)
Received: from localhost.localdomain ([37.161.61.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c4b2fsm3511822a12.29.2025.01.12.02.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 02:45:37 -0800 (PST)
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
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: magnetometer: add binding for Si7210
Date: Sun, 12 Jan 2025 11:44:52 +0100
Message-Id: <20250112104453.45673-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250112104453.45673-1-apokusinski01@gmail.com>
References: <20250112104453.45673-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Silicon Labs Si7210 is an I2C Hall effect magnetic position
and temperature sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


