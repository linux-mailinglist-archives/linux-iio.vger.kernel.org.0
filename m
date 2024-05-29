Return-Path: <linux-iio+bounces-5414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D88D2954
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 02:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D211F25340
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85F8BEA;
	Wed, 29 May 2024 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9++CxHU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B006AB8;
	Wed, 29 May 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941716; cv=none; b=Y7OQlv771s2D4PvlYnTzwTcjb0DGqxRUanVOdoAMsMgpT6swc79p71Kbf/IXPanCLm21lZWgfAslOYFbI2aiXsqHxi323zJgcJj0483Cerrm9etmwofc8TpeqW4IQ57/DGDAz18ZqiaEytqUAAAxA0blb7CuOZjd+6qrVEDCxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941716; c=relaxed/simple;
	bh=3ySH+jTc/L/dIVbHZ2ZTqDI9+5pLodfs8NbC1P/s2RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey7f7ZkLv6BCursISwde/4ipzBYKkq59hWgIU8+DSYg+r7ZNg0r7RrXy/N9RmPZwIb5JNHr4LfSP66QHuilQfXYsDEOtbDpibeMDukLXueoown+TgGvj0YGFJjIlks3sKPn9Cq1shnRM351I0K4xAm2/Y4LQloLeIwzsFlzsByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9++CxHU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-701ae8698d8so1170823b3a.0;
        Tue, 28 May 2024 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716941714; x=1717546514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHVXxNkKLM+Rbftg2VQtQvNGsn2A2WBaaezXU5OsSwU=;
        b=G9++CxHU13uL35WY+W2/16iHTn+gI2agZg/+mpowcl6P5NilBx69ibdhbWZfV9k13g
         4I1n2JWj4TCJJVqfZQC4lkf8T5zZrCy5QyLPykP6yfTMpRvE643rA06qN4z+U+99JkD4
         +SHtUly0bv8tYaQF1BKoARCgrW0kXcj97WlCpjaENktD2VMeHb5AWYmpkjvrGIWhotWS
         S3HV3zgqTT69BbwXq4momXT/fc25Q/CUQS/WGHeKCf8iV7S/qFnVwLda58VTIfmsavjS
         CQWyTqpYAL01m7LwOgUEaJmS0PWJSHCJUeWEnL/ni6fw02xS+jBQXei/5KMsiH0xYVkr
         NguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716941714; x=1717546514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHVXxNkKLM+Rbftg2VQtQvNGsn2A2WBaaezXU5OsSwU=;
        b=dh3xIhty0WNED4XPhQswLmAj7e3g2xiD4J4vgV25es7tEV6V0KqoA7fId1GFqvaKyl
         ylhr4xdCnySJ6oRM3ZLLMoJ4Z9QlE/IkTOi5iHVRAtaUd/hm6GpPt6k8KQaRLGZMXnh6
         WdheGTI9k0w3EE9phBUgWld55NFmMqTJOrgSJkraOtVsTCrIUGeiYknSRk0Vfr/H0I0R
         K89VphZBgeWAkCRdISjV0qH01483gDFYV51iBkuH+cmRv4w/hj5cz0DzEH/LMotvER6r
         FdTvEbdwVnNd6XFRUbDK8EGKzsljA6m26EI5p7b7MsDLnLFFC4+KV5uooxd9x0N91VuI
         MIAg==
X-Forwarded-Encrypted: i=1; AJvYcCW222ywRW7krxIgMkzhwQq+cNG5phFV9AsCNvlPNQ/UZzufQ4ywXs7PgyjmG3j2vxp7uEYbY3OUdmg6DWv27XmVkvyxr7Mal71B8xnAQzmgIbKmKtQs9i5Ff9MuOnCFIJDk27Md45dHBZRzfFRs1ftDjwV1kDgViIkx++f8IozMpPOn6A==
X-Gm-Message-State: AOJu0YwEzV0KKgWsUSk6v/aUVrxz+VhqkO5ms/kYYmjpbAlf/Rbe3Pb+
	mB1MIehS0kqB3aApgbmBEQpQN3zlG6rEwyW7IQoFpmzElaqLRRFZ
X-Google-Smtp-Source: AGHT+IGVZKoXeMCEWHgjDLJxQP7Y5wgw0WebOyx6d7ie/w4EWJMeBL9NNqFw/AZXSMoatxFeFcOsYw==
X-Received: by 2002:a05:6a20:5a89:b0:1b0:2472:da14 with SMTP id adf61e73a8af0-1b212d3905cmr13182334637.2.1716941714392;
        Tue, 28 May 2024 17:15:14 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dea2sm6941433b3a.24.2024.05.28.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:15:13 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: iio: chemical: add ENS160 sensor
Date: Tue, 28 May 2024 21:14:19 -0300
Message-ID: <20240529001504.33648-2-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529001504.33648-1-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for ScioSense ENS160 multi-gas sensor.

Datasheet: https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
changes in v2:
 - Add devicetree binding file specifically for this sensor instead of
   adding it to trivial-devices.yaml. This is needed in order to
   document that this chip supports Vdd and Vddio supplies.
 .../iio/chemical/sciosense,ens160.yaml        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml b/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
new file mode 100644
index 000000000..7dd442f94
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sciosense,ens160.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ScioSense ENS160 multi-gas sensor
+
+maintainers:
+  - Gustavo Silva <gustavograzs@gmail.com>
+
+description: |
+  Digital Multi-Gas Sensor for Monitoring Indoor Air Quality.
+
+  Datasheet:
+    https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf
+
+properties:
+  compatible:
+    enum:
+      - sciosense,ens160
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      gas-sensor@52 {
+        compatible = "sciosense,ens160";
+        reg = <0x52>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      gas-sensor@0 {
+        compatible = "sciosense,ens160";
+        reg = <0>;
+        spi-max-frequency = <10000000>;
+        interrupt-parent = <&gpio>;
+        interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+      };
+    };
+
+...
-- 
2.45.1


