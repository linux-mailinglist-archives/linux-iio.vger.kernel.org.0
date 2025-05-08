Return-Path: <linux-iio+bounces-19287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E98AAF960
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C814A4A44A9
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6A52253EE;
	Thu,  8 May 2025 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVxbTEYD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD281F4161;
	Thu,  8 May 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706136; cv=none; b=m6qA102XLvC/JuzhzpI8sYfSgMket0a5TZYfP8bXYgXdtiFGnc9H2dxbp+Tdl5piQGhCJqcUkmx29rnmFOeCLocRCD+huj8B2c5oouBtehBnw6DJKqMJXhFrvi3W5WKstB8JsPPs1dUWqzZaB7+FMbjqg2LP7CdV/8r8+7Abcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706136; c=relaxed/simple;
	bh=EYQ+LUzR+5GivFsY8DBexvTjy4faNCq8/YGh/sCqcVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JsqIowCTp4T5x1IWdCERzkH6SM79nMgiTt+0RiWjqFZIwvuRgksvDQ7Tzm3+HXkMykPIZRA7UD2fAjJoUSAx8StgXx6NDeSpSI3iHqngAMwOeDMtRzlja8wGhi5SVgeflOvai5JzYjl6vhJ9SxuzFDLxliYVEsxxeYTvO9IO3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVxbTEYD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33e4fdb8so7746475ad.2;
        Thu, 08 May 2025 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746706134; x=1747310934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDFrU1dwKxCtT2HG3D9TgB4dTXvicewbnTeZEvli90Q=;
        b=lVxbTEYDWF6CifoH4xQjoNpjj/VvxK8Inb12BuEpOwQRbXmIa6wdHmyvy80Uq/NAKV
         PuikVuLCNwmt+LeGanrvzlFLpPaGd1932jQwNgj6mV+O600WaR8NRb2jDnMOZl4BfLvl
         mzguRxoSCYdZyxnKXY0xPhmfLZ/IYXlpph83dFa2krYafSRCyUXtNvUmk6HOb70kgqLb
         PRCm7nldwWCrtDc2jpyoutnkJvY8UOIF4Rvp01T7r2u6156AbUtT+kA6LwbECWiI2b2I
         Egb3cfbHOeI04bJKycISomAJG4pZ4SvulAN7oZvFTMaBXYtW1XqDvI5CLJhwOGz5S+xj
         sP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706134; x=1747310934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDFrU1dwKxCtT2HG3D9TgB4dTXvicewbnTeZEvli90Q=;
        b=J3oHz+YqcgoN1VNDZQLLT6O7mQx/w1ppEqnss+G88kXo8LVdBeO/DIysJaS0HYOmD3
         C3EqmS47oN5c3Tae1+ci2/KFEC0+Hg+QccyRx70XFsjiPkJXVS0n4b3UmmFU4YhFsu6S
         i1+YqkpM2dTmPAMOzc2rpvCGx127FC88v0JrR1lYDURiRRctCm0EqJEI+l/9bPBy8OF7
         2t6PGa3dhzMm3NZJ5+yrjqpxyNYXbnrE+S272yvG0fy1rUhvwNwb9xiGcXH3L59nNZKg
         DyqHYjlYPjiU8+XUAwh4yb3JMljftK9laSAQOCGirPgP/LPLib02eo4j6O09YkkSEfMV
         9BEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlzCar3MIfAgTWBT21jqKykameKZ7PBCjvYdZyrmP5OYKsWJUghSaYV9VbZU8gQwbbJh7D/TJLRAns@vger.kernel.org, AJvYcCX2UbKge50v8wPTzTisbJR/APHk8u6X5gq753Xeuib/xUyFJ8P4f6uRyQjTtWXcux1QfYsZFdowF1+v9qOq@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqVv2lHwDqtsN++g6W7tQpXg1sXX0kHZVPRQBaxpNru1FIhXf
	WT3djQvlROEX4ltS1by7lwGUYvstuMiB1Oo0sc6qlHo8GiH8IF+VMWv1ByS42dA=
X-Gm-Gg: ASbGnct4HnPPmCr/xknaLdXN2QhmdnYxWMkPw4cNz9CGf3cfxhJTDv8DdTYbw7rN7tG
	Trw7/swcXNYtj+wJNaMYayJLhyNPxeQ/nWNoyTxTq/pnpVeLMMBR/ObnGePDBrE1g6dl7O4R7jK
	ddlfXH+bHtzyMcbHYSnh4FJdjP1zT/++XPUm2J7Moqac+NQ5entj3W4rWobPpgj7DlFJfL1RG81
	JVP/kGQ7sZlCzHCD2adcOhChioz1xmPhFZISvj7yiV2uY3b03cfb+7y8G/4zSGhJrgXGutqlqw7
	31FSYEXC9lNzareAHAtog5ddSe7CouFuJB/C3RkMzQrsnTDo/csegX+PNYq3
X-Google-Smtp-Source: AGHT+IGPFw2bwvnUakLVrHOuVvzt8Wqf31wkeLEzLALwtItOfmWU37mwK/dxll8iCHFZz++2K/Qwsw==
X-Received: by 2002:a17:903:2391:b0:223:66bb:8993 with SMTP id d9443c01a7336-22e867077d3mr46493425ad.43.1746706134040;
        Thu, 08 May 2025 05:08:54 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e69f04d53sm29311715ad.246.2025.05.08.05.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:08:53 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v2 2/5] dt-bindings: iio: magnetometer: qst: Add QMC5883L device tree binding
Date: Thu,  8 May 2025 13:08:46 +0100
Message-Id: <20250508120846.114262-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 .../iio/magnetometer/qst,qmc5883l.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
new file mode 100644
index 000000000000..a2e6982a177d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/qst,qmc5883l.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QST QMC5883L 3-Axis Magnetometer
+
+maintainers:
+  - Brajesh Patil <brajeshpatil11@gmail.com>
+
+description: |
+  The QMC5883L is a 3-axis magnetic sensor with I2C interface. It provides
+  measurements of magnetic field strength along X, Y and Z axes, as well as
+  temperature readings.
+
+properties:
+  compatible:
+    const: qst,qmc5883l
+
+  reg:
+    maxItems: 1
+    description: I2C slave address (0x0d)
+
+  mount-matrix:
+    description: |
+      A 3x3 rotation matrix describing how the magnetometer is mounted
+      on the device. This is used to orient the sensor measurements
+      to match the device's coordinate system.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@0d {
+            compatible = "qst,qmc5883l";
+            reg = <0x0d>;
+            mount-matrix = "1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "1";
+        };
+    };
+...
+
--
2.39.5


