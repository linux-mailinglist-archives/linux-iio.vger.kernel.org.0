Return-Path: <linux-iio+bounces-26812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28529CA944B
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1EC53136F41
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF42E92B7;
	Fri,  5 Dec 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npHRtsDJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838B2E11DD
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966517; cv=none; b=VzWu9aGDbl62oza2ngpR69/Wy71YLyHg+z5eih0SL+/5enmP2s/zHakdNGk/uznGqdzHtUaYOTyRPaQZvVsULahUazX3gGBte9cunOyNBrL+I4zKEpxC/M1MBOeIsH+WVdp0HfD5SATPPQMOk74UVmf1RU4bv8ov4M5r792b4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966517; c=relaxed/simple;
	bh=azE6/sKR/pDr9h9pZaYF+h/EQIlraEjWOI9ZhVf1gRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsvzSaNZ8FZab3UqPMFnIu+qYDpx2H2GCsuianzeLmFfnLGcaaKS2hZnZOdXz3N3aFXCn1SEyhThnqV7GRNRseRR84ixdJ/OzKevhDkGx2UuQQc/UKxG7GAp8/IZYzUWu90iAV2S5rO7Dt2fKUAkpxy6Y6qBguRgaD7ei+eFei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npHRtsDJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295548467c7so31430875ad.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764966514; x=1765571314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZogGanCrO7NukEfQvdNpvWFAmgObDEJxIVV+nj78Ze8=;
        b=npHRtsDJp48VnC2VrZNWvGLIH9YiQ+JDzbwASp334iq87bDXzW3/MYuQNRvkJxWciK
         TXmXJ6qkjHnOXTLZL7F57F/XdX+Twg+IaY5KOnEU2V5JVlM9ZZTQIWpM0maL0IROGSgE
         N1miSjXh3rswK66brjmxSDvSbuQcbLpD3DXYLskI60IxDRfZUAtioxEaFR9mdWsfj1F5
         +EH6DmxZdW3L9uwdaP5r8TgQrCPwfPNY3x9mrnK53VNR0DIly0+vmxuOd+x5Nav7SOua
         3MCQ3K+NqXi0ss5T0huP2ATCmC333c8+2WLhP/KF5ROTWGL3tAaGMKHqMnEpwrvFPkby
         7fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764966514; x=1765571314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZogGanCrO7NukEfQvdNpvWFAmgObDEJxIVV+nj78Ze8=;
        b=LNR3YkcixshgkDhxiU3lyTDxZENIml3Aq6M4dS0UsVIH93iN51SSUyexnWMRDd1qdV
         RCaZPF4zYBVLuUziuklxVXqL73GcQnWEEyn8S1njQc/nZ9slBzu2F3jv3WV4w7kIMpOK
         SqTZXKcRmyQ6+i92ltcUpi3aG9nKLtsqO6yRAeILr5dPDmhG/x9P11IJbQJ8N0fHubFi
         ZJVrWctq3ZcWBGN/Qg4GDqWcrLdkWRurA1kQx35mYUUE1Lgmmz4eJ486Ic1PYWji2s3M
         soT3q27lqTV8dxGmF3/fJKfgpm58wQugwCXV0mVecNXQLSXrC6WoFQsdGFlRWUMdDfzR
         QcIw==
X-Forwarded-Encrypted: i=1; AJvYcCWlViE/t0bOkz9+BUopPQm+1CdipJh2g32E3gBYFh5lp3TTk1c4QGpvHPTqSt0lnAQNmCkHuPwdhp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/fbcBJAPnze/43pKWOT5og5tehKi1Gxa48TBEpFpzYqeQO+R
	vh1bv6pDVBQO0WpaIokAKu8FERFqjGpSpRxQ3aETlBwD1Ea37cYo7xv/
X-Gm-Gg: ASbGncu2wq69H9TVdJuaSq+Tu59oMOGTEsj7QpXXo3b3ayYYCsLS2KDHpFXFAF0e4qW
	l1fTDJN/29wzO1n1lqpewNxzZbomJiZ2KSEkFkW8/fjXDspryQEF3mzjtE2x3uf83W5rj3P85wm
	m1hyzPJ6Rn9aVcloopbm2JcBgzICbMBUtztI1iNmNyYIDG+eaVrjt1rsGsg2100uE4Vk9oUFf5Z
	R6U1UrZ5X3NlKmphlKL5/R/s7YnHgAk4amED9y6PwTo4m8QN9ZU3dRVfEzUyQmFcFCT0XtWgq0P
	q6BiBA0+i6bNkw1I3BR0fEC4hfKKima9hIF6m5XKMt4IKMC7L3RN59Fmm8axvruGzZ7a2thzgG8
	Y7p+qHB+TalPfGLza+C3uJWpKq1wTpEQmdgWqSIAVbxkafaK1OY4Z3+cVLQC5U19fT0M2VeT4wn
	unOtZ9rg2yBQBgt6N6YByoDYNqv6gPUXbSFAeHUDLKebZw9Hy575tdS6l9TPicyj19prG4+i1wu
	I4apID1tsWxlAdRrnWQe3Cb9apEeqa9CDK9o3aYKjpXVjDNcRvG51hmCXbgsniNNqKnwzx1
X-Google-Smtp-Source: AGHT+IF1wT7Td3ZI2BC55SXXYAJaxCzsMe1hAMjfGfhAUPysLAPT7MMB+HubIzcEFfpLuQKK5R0Glg==
X-Received: by 2002:a17:902:cf0b:b0:297:fbff:fab8 with SMTP id d9443c01a7336-29df54761c4mr2295905ad.21.1764966513935;
        Fri, 05 Dec 2025 12:28:33 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99fa59sm57256845ad.58.2025.12.05.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 12:28:33 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [RFC PATCH 3/3] dt-bindings: iio: add analog devices ad9832/ad9835
Date: Fri,  5 Dec 2025 17:27:43 -0300
Message-ID: <20251205202743.10530-4-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205202743.10530-1-tomasborquez13@gmail.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding documentation for the AD9832 and AD9835
Digital Synthesizer chips.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 .../bindings/iio/frequency/adi,ad9832.yaml    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
new file mode 100644
index 0000000000..f14e054ab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,ad9832.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9832/AD9835 Direct Digital Synthesizer
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9832
+      - adi,ad9835
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  avdd-supply:
+    description: Analog power supply.
+
+  dvdd-supply:
+    description: Digital power supply.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - avdd-supply
+  - dvdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dds@0 {
+            compatible = "adi,ad9832";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            clocks = <&dds_clk>;
+            clock-names = "mclk";
+            avdd-supply = <&avdd_reg>;
+            dvdd-supply = <&dvdd_reg>;
+        };
+    };
+...
-- 
2.43.0


