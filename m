Return-Path: <linux-iio+bounces-6825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0AC915560
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE371F24524
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F919EEC4;
	Mon, 24 Jun 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1lRQq6U1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579D13A894
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250276; cv=none; b=SeqaIKSoUiKYQTSRMPRM6tqwzSZfIqflB5H7EpgxsVmrsF/rnCJkWU85dYZ9aRDSZ5lRt/T5EICnrSOCGKNG1YaWRxO49iXUCCcF3Aqqg3FBj56lJK20ZvuR1Ulvz39mmrNVGBF/3dUgO4Q53rLtqmOutnMaVowv1iTbTAW6CPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250276; c=relaxed/simple;
	bh=ESiT0v4XPWgKX6yOvx0PCA1YyOo6pgK/BKcUz++fGgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVqfZvouXiVWU+5T2UN2URkDkk0hl/o5k/bHxRk6aYxNHFT3NufTlSTyRdORp/msEemuhqqGfUjJQD0OAiDWrH4pW2jMTOI72oAiPv82afwsMWW9G3Y+pEgIQiYkx7PyEjZLmw2pPY6DR6VLteqQIm2tBP3Yi60YU9YHISZiiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1lRQq6U1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424798859dfso38561305e9.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719250273; x=1719855073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk8NTSSg2UNwZSS0z8KuJvpBdS4vH/E8VAcTr6zFpw4=;
        b=1lRQq6U1U24WcnKBgOK5f2rJ1tkLyw7mdHQFlmTpnhdUIydS8HNstxbl4lOlev5Z4o
         OypNBziNEIRM3juIbo3uYmhLgdjc91zW/AXTSvdXFuuVYMcPFjIBh/VnxoUvH2dheWcn
         3K3r6ngCjxtpAxHL7ZJJgPHzsoII0QOfUwCv87JRoMNQL5y3LMuPPDGmCox+YkinLrWt
         a8wRqm7eVTqOrw67ESH5sxWK+zCFrbnBErR26ajqHUCntVMQSSo6WIOuil5eLOMtPxsZ
         lyZSCfSjv9hdNpo3aDGF7Q9fHHrC2rdMnIpOkVlrTBIhKgWFAEAloLEDe0rv2KNJCFLN
         X24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250273; x=1719855073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk8NTSSg2UNwZSS0z8KuJvpBdS4vH/E8VAcTr6zFpw4=;
        b=XeHXR76JExqlfCZHcFJYwDMGJydzIS9RrliTlrcQLl8SbWS06DZl/f3RMi30LygPa7
         3x70GwAYE5NoQadOAmOK2djQBFgZXREz+1FNxXDGENJIlg0kZWKcDJcZiPfLO8hb7w/m
         AIK8lAzlkCObECcL7eWsBFx/Pu1W0mPDdLb3snfLtIr8RwUxPVT/4DxJyYOteyoS+sEe
         1qKmmsZ39945SfYT3MGcmmodG1iYSGVjPJvxwfLxpXLw/xwQ45EBkaOpl/AUJqVcYe5T
         oc+WbC1CX6c8kfAEwZWpW4yeC+0S4qID6xofZaKY6buwgEjJYtsNpb6H/TbtXa4NIOCY
         SMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0FPRl938U7YoLhwYEgY39nWiWQqZDWt7ikSFB8y7671H6wn9PqVbha9z21+eMrYi8KUgcl6yLYPvcdj3H/N9cOXljoui1Co1a
X-Gm-Message-State: AOJu0YwLD44lDtKEd4XbhJ7vsA3BrZcnxcYEoG/2RTb6GhqQH6zRqqGB
	dlSHmdGA/h9RpQV9/JvFj/Swu7/lHf8Ed/70j0FYrPzllFUN6kO8irmx9gSXpW4=
X-Google-Smtp-Source: AGHT+IEzdlJ7HFwRpLJJZgautx8tzjBGUtxs5fy5hAahIcqiziqFJibaNlYJW9Zd5bqWuU4GuS++yg==
X-Received: by 2002:a05:600c:1ca2:b0:424:8e12:9ef3 with SMTP id 5b1f17b1804b1-4248e129f6fmr34103285e9.0.1719250272804;
        Mon, 24 Jun 2024 10:31:12 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e4ee:e6f8:8fcc:a63b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d210ff9sm183742385e9.39.2024.06.24.10.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:31:12 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: frequency: add clock measure support
Date: Mon, 24 Jun 2024 19:31:02 +0200
Message-ID: <20240624173105.909554-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624173105.909554-1-jbrunet@baylibre.com>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Introduce new bindings for the clock measure IP found Amlogic SoCs.
These new bindings help bring IIO support to AML clock measure.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 NOTE:
  #1: Splitting the register space looks odd. This is done to help support
      future SoCs. From meson8 to sm1, duty register comes first, then the
      reg space. On s4 and c3, duty comes after the reg space.
  #2: 'reg' may look like a poor choice of name. This comes from the
       documentation.
       - MSR_CLK_REGx for the 'reg' space (x being a number)
       - MSR_CLK_DUTY for the 'duty' space

 .../iio/frequency/amlogic,clk-msr-io.yaml     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml b/Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
new file mode 100644
index 000000000000..eeb268b4a607
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/amlogic,clk-msr-io.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic System Clock Measurer
+
+description:
+  Internal clock rate sensor within Amlogic SoCs
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson8-clk-msr-io
+      - amlogic,gx-clk-msr-io
+      - amlogic,axg-clk-msr-io
+      - amlogic,g12a-clk-msr-io
+      - amlogic,sm1-clk-msr-io
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: reg
+      - const: duty
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clk_msr: rate-sensor@18000 {
+      compatible = "amlogic,axg-clk-msr-io";
+      reg = <0x18004 0xc>,
+            <0x18000 0x4>;
+      reg-names = "reg", "duty";
+      #io-channel-cells = <1>;
+    };
-- 
2.43.0


