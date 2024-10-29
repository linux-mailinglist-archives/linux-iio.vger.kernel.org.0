Return-Path: <linux-iio+bounces-11545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB1E9B4341
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D201C21C41
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B685202F8D;
	Tue, 29 Oct 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LkEUZVaz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33520265E
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187544; cv=none; b=VsI7a5B6tejaJHt89bgam4HxhczCNfKiRtZKKjGrPnv4hZkB4FGWc5vb/UrC1ogFNxUejOvHL3nVCQnVGE4jNuGi+C/AT/ppgojrMCqVmxPM6GMkLBpiiJ12Ek7nJey5Ba1JM7B9E4gsL4zIQG5SYVNgcaXpv8m4Wmwpos80wzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187544; c=relaxed/simple;
	bh=5KsorQSJgZeTJd1wUS9Cebj4jWXpxz/aBH8FLYD4+HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOSNK1CK+si6MJ2cHxBPflXK3sYGIOEojp3c8H1RfynrI0C2bsuhJjKJxrAi8ADE7QZWi2VcqQoMNcXGrKqChdZL3MgeJ0lCNRAcHzXHyQl0Tll4KZ//MKW/ntrAXdp3Nti3i0PJKkuygwRgMA31o2mjJrWVQVgc5G7w8qbVSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LkEUZVaz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so3606620f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730187541; x=1730792341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st9um2/AfYYcoCBp73pspcb++48Yu2jLzSVNVtzZmUw=;
        b=LkEUZVazbcDMqFVp4oc8wZhFHVw0BN/Xehi+VX8KED5eWO68cYh98BcwGOu498ouWq
         TtarIMzzvFOxixRTEuv4uc4W/wiVpjAMI5oJZiqM1KkzxrkLyQkbGXIIS7nn2d4ycQoY
         5ympZpcnntMsHWQN2vcEUlQZ26ayEfdQXwGhF7oIphMpboZqfW68oHsEg0dDmKt5JarA
         WFjPz8yVOKxsZaF6a/ifFnslh2fBB9Yd2MwiEwPP2qdHQvVhzc45g1sSyn3jr4mBpKTg
         ZHYtlHN6L3SWABoKlgO6QEq4DgPrksm9gosf6BaRNPPF6SeW5tvj6IblzxxHT1zKfq60
         A6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187541; x=1730792341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st9um2/AfYYcoCBp73pspcb++48Yu2jLzSVNVtzZmUw=;
        b=sQK9T4fhJZqNen2RVKU1emLugGV0pPyQAFiA9JxVqMIgNIDyIEnIDGFpV77H5QHYaf
         kg3DXIz8OiyddpzQPwNMDsLLVwCD1RXxAKVuD+MeY1cavY4bJVQM7S6LYV3iiWdMYSy5
         jj+Fv1H2XhYjYttspCOlHA36JN3e0bVH3PRfUoDlaY/9VYCpaST6IheAmuJ+oSIx3GYo
         lKdcO+RAShqNEcRQFshkvCBTuGKqpgHBxgXGaS55mCXJzbq/Loyu1regWgAck8gy6cnj
         eQ61okvubU+AEZv6BupYoJbvoEp5DCaPSFwYHIFi4ZR1uCHrovW2KJ9tm1nNCxZv3VsF
         s27Q==
X-Gm-Message-State: AOJu0YyglsAlN54rfkAaYPPlGLBTx349HWrRoIir67xtgyW3Vqj5i0+7
	2fQcBRt3VfLK0zw1uL6jZTZR5PQN5F+7HmWNcEXhgP3LUpQzkm+Ep3rEhTFCYfw=
X-Google-Smtp-Source: AGHT+IGbUlhfPKvrjzJQWDaPkc53rwcJ2pi1RJFhGDGbUz2U7WeyKmGEC8fiWSl6/vyb71XnnECg2A==
X-Received: by 2002:a05:6000:1f11:b0:37c:c4bc:181c with SMTP id ffacd0b85a97d-380610e6bbfmr7704435f8f.11.1730187540947;
        Tue, 29 Oct 2024 00:39:00 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm11692939f8f.71.2024.10.29.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:39:00 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
Date: Tue, 29 Oct 2024 08:38:52 +0100
Message-Id: <20241029073857.753782-2-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029073857.753782-1-ahaslam@baylibre.com>
References: <20241029073857.753782-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Depending on board layout, the ad57xx may need control of reset, clear,
and ldac pins by the host driver. Add optional bindings for these gpios.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index c81285d84db7..fe664378c966 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -31,6 +31,17 @@ properties:
       gain of two configuration.
     type: boolean
 
+  reset-gpios:
+    maxItems: 1
+
+  clear-gpios:
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      LDAC pin to be used as a hardware trigger to update the DAC channels.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -44,6 +55,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -53,6 +65,9 @@ examples:
             reg = <0>;
             vss-supply = <&dac_vss>;
             vdd-supply = <&dac_vdd>;
+            reset-gpios = <&gpio_bd 16 GPIO_ACTIVE_LOW>;
+            clear-gpios = <&gpio_bd 17 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_HIGH>;
         };
     };
 ...
-- 
2.34.1


