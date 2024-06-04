Return-Path: <linux-iio+bounces-5796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6468F8FBF63
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2280028475C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6478D14D2A3;
	Tue,  4 Jun 2024 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgH1nvRm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192D14D6F8;
	Tue,  4 Jun 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541888; cv=none; b=TngjDsDys7Hpvjqdr4bB/No0x/O8xUa1K5yVnzwLhpTtjLFYEzW3dbKSjr6NT6AXuoG5ekoRObnehQGRSb4QNNgJPOrA4J2hyvW6QIJgUW9sSkTm5Vh2gwcv9YVJdwe3k14+sr+xG0y7j/MUTeopMQd8f9UnHqSEtXjOTCc83cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541888; c=relaxed/simple;
	bh=jaccSrfWNdimxniSQ+8sK760H3HeuR0fZn2ChXZuJQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/bkfP0VQpm7c/J0gpFGpuFcuyotWFiHo317VUnEB/ChK1AdhpHGKDIBcmWiZlfZ+whiZf1ikHl7t2BsXZ3iuBlqacO+48gJKTnwiig1V7N6jDpFayR3x5IoLf9CklUBBEq3hEP6XcS803aO/EvL/9m2B7gjbw/12ccxgNoC1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgH1nvRm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f6a045d476so4830570b3a.1;
        Tue, 04 Jun 2024 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541886; x=1718146686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/3ZatKa4mrnJ7b8FLyAeDzEmtyVTBklWU1iYA6k6Co=;
        b=FgH1nvRmCQN1NdTUR631Sn/GRrv8qQrYnRa8sKO72IovghOvzSpJeUUvxQbDOye/Wv
         W/VYTeuLRvaeffCaKvdYvyu4oY2/AM0WQOgSZJFM4Cms91szIvIuyC6oFB4f2iiGTipe
         BlNEj4a5a8jWEwck/d1xsCHwttyPKw5bj2yUQ+PC3xAcYdOPPtOs1ikkcQotnN1RHwe9
         HhGqQsmSZFCshfilsVQv/ts52yP8yC9lX2QqOlTdNh0JWcrQyb7u4LGdlkktG0TpVVSC
         r/In/LGMG7jXRY7wg6djUlNESnKwtzvvImqJJUOObxWWiT4ryvxEo5NjfXQQHzx5yhLX
         YsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541886; x=1718146686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/3ZatKa4mrnJ7b8FLyAeDzEmtyVTBklWU1iYA6k6Co=;
        b=cm2yeb7GEZK0sc0ou3eZ+CQ/jMMLM16gFdevDmi2rCp9PCIm8pos2fnlZDhvhz2TCn
         GJxeLUn14LtBOnn6qi1D2+gYcQVefLPNrXQoSFvVwD1OuQDhXtOzGvZ03KRiWqOKLQ+2
         xSOfPiUhZbF07ksiXUM+LUSBAiOFPIj0fKv10Rc5CF1+7G/Tf6dw882Hl94VOwNhRby9
         33RJKIl8aRdRRy7sk3b08U8L0j8mwqZIoDjOuJBky+5HJVxIXEEE6YY1lSeDE4jonyuT
         qJs+RpGKFbIZz2aDHTXNFZFJKtz2JfgvKrLjBB/yUYc6blMfOwYG3S3p8NvVxYjlnFOi
         yfzA==
X-Forwarded-Encrypted: i=1; AJvYcCUwr90qTXVYC3Q9adxwjo68Xbc9t702+2thapigPJAuZtCE/mdaL2c5J383ZW0HBSH3qez66EzXobBscRPlNqUFqOtCsRb5O9ss0zsf4TcYSjK5cVDqPVf9QoFyGDL1RImCvqBFuxGNymfLURFw9EsY7kmPlt2PLIgB09CwljrYVZO0Ig==
X-Gm-Message-State: AOJu0YxPYUdsDbqV7g3TdsbtWWA8K+BVZQrcPeWTqtkCbFAs8n0l88gF
	gpjs4MjsQGENCFgeXsV8Fl16Gh+DFIG5eoYB7Pkx5bPLef45rZqV
X-Google-Smtp-Source: AGHT+IG6HtXG+L5NbNCxquI4zVSqkHk92ntjYPr2fohLAXLWrKy0s68y9y1ZsmsC4vM3o8jI2yaU/w==
X-Received: by 2002:a05:6a00:2e1b:b0:6ea:bb00:dbb6 with SMTP id d2e1a72fcca58-703e594abf2mr907176b3a.8.1717541885904;
        Tue, 04 Jun 2024 15:58:05 -0700 (PDT)
Received: from localhost.localdomain ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a955dd1sm5312125b3a.64.2024.06.04.15.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:58:05 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/6] dt-bindings: iio: chemical: add ENS160 sensor
Date: Tue,  4 Jun 2024 19:57:26 -0300
Message-ID: <20240604225747.7212-3-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604225747.7212-1-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for ScioSense ENS160 multi-gas sensor.

Datasheet: https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 .../iio/chemical/sciosense,ens160.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml b/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
new file mode 100644
index 000000000..267033a68
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
@@ -0,0 +1,70 @@
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
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
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


