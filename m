Return-Path: <linux-iio+bounces-23672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF9B41BD0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E56F6814A5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A12ED143;
	Wed,  3 Sep 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bc/t6wiO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745B2EA146
	for <linux-iio@vger.kernel.org>; Wed,  3 Sep 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895284; cv=none; b=jNbznY7Szf9J/kxoMGnPjq+1grHZqRoL5s4rP8RxOw7/GhLU9gHD8rqoWZVRvPS6gvCD5v0B1dcUAG0hjI/EAd7TOPH7lTHXFAczNazZmDZ+PPdFYdWcNpWUAK7SYc45STrUhKJFjpf9unRB9PQpOQm+srifzlmCs9U175oaqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895284; c=relaxed/simple;
	bh=SkomEAWMr7dqJHQ8N7mLoE3pG7f6Vktqf3CG8y3O0qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYgRM7mRM5NaVDoiWzljjABiEm3PMxb2/aFDg11zytZkk99QBFXvqljNZEAVGx94ZG0jrInjBs6y3kmFE8cWixDkoMtgPQPAyINbk1xwiLyir0ST9kqVYwyWfW3dJEig06XYIMcKdDQM+1qEVENlKXvSd8kxkzr4Q1GwOM3JhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bc/t6wiO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b804ed966so23325855e9.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Sep 2025 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756895281; x=1757500081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjVYYBfOPHu5us2l/I8UPnxyPLOr26L4rzL/vKv2LrY=;
        b=bc/t6wiOSzGTRwzBHJwjcZWc3NrpL+oE0G3dawPq60iMEhV/zdvdka2j+voEQ8minM
         jrdh0J9r+IusE6oBXEyjFmZI3fVbLDS1vJlGWLtrq9vGlq3h+2DAlJeiY8LuAHfVIj8Q
         +hwaV65+CClatmXSVNxsOoJ2YfaQH2QQrcWY7Pbirm5+pzHGfwt4rscupuYl4uXrtL8h
         hKoVU8rs+nUTRac34YdugcMq8SZevy1Hw6ksGFdooLYt47AuX9/fSm7NgA7Iczk7mFWF
         TRvoXl7ivbnwyZzYZ4zCfZDSrFsHd1eq+BhBWu63vjjVY/VuFbbskjL0eMuLqqxzchtm
         OB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895281; x=1757500081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjVYYBfOPHu5us2l/I8UPnxyPLOr26L4rzL/vKv2LrY=;
        b=PLQ52p60A1CPDEeOZGUEjKL4emtkGiwyEkm2tCU414RBTfEFo3z1+sa8EhRdjO+YzD
         Cpob3yB9omw6XCJX0UveQGbb08NoPadO4N31AVD/xKqygK4nTVZ+Iqrc0Jl9sv/M49Cp
         Vkxts6K0BlX7wKgIm3PWT2y+nCJPodGeqBaVwvnymz5V8XXxIWezKkck60wwaeotmB//
         1gjNx3T5KbbccF1ZXls/aBBCdpD8lJrOibqIPkUd07FeJWzH3WjJJdpZs81+YZOngmay
         4Ln7cdO8pBAwMwfyN13AmWY/6mtKresHSPhos2wVD55SMDLnBFH3uaoLsZ8waOqT8chG
         B+EA==
X-Gm-Message-State: AOJu0Yw9tDcxbMDuWNsCR9LHKiJW5KOwZjXVYEXwPGLaN+pWXA6CX9pn
	AaZzHzVpItcnvkGQrqE8zQmF36LKhGk4kZG4P+CI5sIdgOsuQjUe8V3STY4HNB/UHJ9LdYBEw5q
	5jW8s
X-Gm-Gg: ASbGnctzb8Z7BN8WNEfnZ7FMzQPhgQbyDzmTpGOHEHoBgDlgmOXU+XfKjujSUFpz6eo
	AGb1uf/BkuigamgDl0TlbKbUTkhTJFBPrZKOu2cwaOyoDBMQkSnmtm59dIx6cyd3dj0L/h2sLBB
	1HnA0ZZRlLqNCiGC/pwDp7c0BlwAWCd/To9nYztWnMDRiVN4IqAYe4acfcF+Ejm8lr6d7tZj2OV
	vXHAc9g7uphcdSqJnjsFjsrblSfNEY3V3RiJchhHpsMlyn3+CT/x1yR/moO9be7d8oqqN0V6kSV
	pZ5aqUJpbVvTTR42Pnde/h7VbFLV0mObafwFpN3HRt6bIAbkh46op73uGgH9zjsy1svIqVeVTom
	Jxvus5alMNJ3XiWqw8wllCtBusugNf1EeOXrcDrjfOL0qU3M7/h6gfA==
X-Google-Smtp-Source: AGHT+IGSUORYJzBn7O96WsftU689TaesXpGZtVK+MUa18v5BS6kecsxo5Ta5IrwC022eEBj1aLixuA==
X-Received: by 2002:a05:600c:3b9a:b0:45b:8866:50fd with SMTP id 5b1f17b1804b1-45b88665357mr104875915e9.32.1756895280998;
        Wed, 03 Sep 2025 03:28:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2a30:223c:d73b:565a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm55992855e9.11.2025.09.03.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:28:00 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Wed,  3 Sep 2025 12:27:55 +0200
Message-ID: <20250903102756.1748596-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g2 and s32g3 NXP platforms have two instances of a Successive
Approximation Register ADC. It supports the raw, trigger and scan
modes which involves the DMA. Add their descriptions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
new file mode 100644
index 000000000000..dc6ec240f816
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,s32g2-sar-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Successive Approximation ADC
+
+description:
+  The NXP SAR ADC provides fast and accurate analog-to-digital
+  conversion using the Successive Approximation Register (SAR) method.
+  It has 12-bit resolution with 8 input channels. Conversions can be
+  launched in software or using hardware triggers. It supports
+  continuous and one-shot modes with separate registers.
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-sar-adc
+      - items:
+          - const: nxp,s32g3-sar-adc
+          - const: nxp,s32g2-sar-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    minItems: 1
+
+  dmas:
+    minItems: 1
+
+  dma-names:
+    const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc@401f8000 {
+        compatible = "nxp,s32g2-sar-adc";
+        reg = <0x401f8000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 0x41>;
+        clock-names = "adc";
+        dmas = <&edma0 0 32>;
+        dma-names = "rx";
+    };
-- 
2.43.0


