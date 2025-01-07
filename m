Return-Path: <linux-iio+bounces-13956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A81A0402C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 14:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBE53A87FC
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3711F1309;
	Tue,  7 Jan 2025 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3gQLIvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BA1F1303
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254736; cv=none; b=rJ2GDMqs0nkW5z9gYKJzI2tEuXNF4ajwQtvX3/LKaTTLrLJkuBXgsUKohxSyTbx0dLwSvZti8/FY7MBBO6yyBCqdHhC+psmjAx7Is5lZNTBWb1KIX9MFKm1RfCN3RPpAn9RwD64DaiHS+g2i+0Rl3RguXKi1KrBO40B+0EDJ7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254736; c=relaxed/simple;
	bh=t4rRBQmo5PbKUK/M1fQaSIj1hFg+1lZQQrb46lNPPHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LV4hYfu4r1Ya4Y/BYlIKfLDlVK0jW2oEkBothCG8vSyAozecM6p3DPf1oaauB+9VQlReCfwGmmsPxxmm6LqKHH8Hm1mQ/ohVW5JJqQSILOWC2qwvtA1jEy+SLFYn5xT4K7tmkwiwYKAIJuD60TW0vEwspWbTH/q8GzPw75DpC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3gQLIvz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e0d47720so983518f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736254731; x=1736859531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2sxL0kyOnJtbxiCpqFSPJaxyhbxDHZZxCjJuwsLyyM=;
        b=q3gQLIvzqKpsU+ebJNrK0cXH4fHM3ljbfxNpxJ+4XFa4hrP7eq1Z3unZT2J4OspZoQ
         ZIGushmnZSHCs+OvF81FeuMV5fdPdSsAAf9anZiUjDuUzrw1nAGkGrewg+tym+Fdwlk3
         k42LtBtcqG7p3KGOhMiiCZhHS40f+rfArAhYT6fGG3iZv9w24YfLr4Pj9PkAuTjI9y/g
         XlFd/jL45mFh9U3MYLIi7ACphpJFLlVvFlGL2JLNa8sMNhESoYcXY6/zxw8y4xDBUH+x
         DAv2s+cdodOeRpYIeT1in2aU7NkzmhSHpWcKdtWWKP8wxVk+iKDM5LJrnNQYsB0ib2Fs
         w+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254731; x=1736859531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2sxL0kyOnJtbxiCpqFSPJaxyhbxDHZZxCjJuwsLyyM=;
        b=Wgvlqq5Yfl63Cdqc+2Yf+uLlOVo5N2OFtdvvubKuJdy/5OqapFcwhclhTA5LJT6bET
         SU5Y6+HQQsEDlgWzkZQH+eenhJNziwvjJJhCVuiKH8EwlCz3TRkPtrVbHTjG1V0G/98Q
         IyajyZyu6FAoVq267q/Jfbacx/X1QT/V6WpyhLKSMH1MzjDHDy4Nh2LklGqkPzE7hDwT
         WhR0qVksys7CqlPGrHl8X1gs3zJVUQyw9cDxyFmofVpdhpLHpPoGQoSV6Ky4Wq4wT+ub
         laKgCDjCHDAh8BgD13NFLIABt80E4XfnXzvRU6EEH8MWpbZd6wIXhv6wF2+CK0CWyIj6
         8Sdg==
X-Forwarded-Encrypted: i=1; AJvYcCUPGY9LXkgpyeM4bIvNjhX4olhR8zH2Z+aYEpkcmKZiob67iT3ufMmAyQh3hJjvKcPhN8LPBqJ2FtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQKDCWnYAwi3KffM1ZdtC+XxG3Y+rOLqEdxPfpyfZi90AzL28
	ptJLKVoqooWrholIiJtGwRwF9jAIC5tMgE7gjsR0pgXmBO7vZD8SVIbiLA9SYkE=
X-Gm-Gg: ASbGnctN5va7Veyd4+Auy9Tna1TZTpUGRQivhH/d/03j+xq1R4E9dRrnplRA/akcW5L
	0gqgA/zKupnlTpPLXXmbTYYqEFxxSf1/oKI0wM4zEASguygYA2BbF9394iLYYYM3LezN9j8sV0g
	wub5kdrl0JoxyvIG5kpySsm4j9aMVunvm9oU5QEJNJKXf2E3t4pq4YDxcOf98gpFyB3FKes1oO5
	/sf3Br9SZaowM6NbdS9Ni0qtwiaw2NhmeFwVRuxj5/nxLd6SdPGmrGvXtRhNBCFTrbaotM=
X-Google-Smtp-Source: AGHT+IEzXNziYvB8cMSs56bRM+d+7RHATIssfR61yGfXU8wPeStQWQQ6p2QHKq5/TPazJN7kZIGr2Q==
X-Received: by 2002:a5d:47a1:0:b0:388:c61d:4401 with SMTP id ffacd0b85a97d-38a221fa14emr20278640f8f.7.1736254730828;
        Tue, 07 Jan 2025 04:58:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832a90sm49786756f8f.28.2025.01.07.04.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:58:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
	Sankar Velliangiri <navin@linumiz.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: Correct indentation and style in DTS example
Date: Tue,  7 Jan 2025 13:58:47 +0100
Message-ID: <20250107125848.226899-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/dac/adi,ad5380.yaml           | 18 +++++++++---------
 .../iio/humidity/sciosense,ens210.yaml         | 12 ++++++------
 .../iio/temperature/maxim,max31865.yaml        | 18 +++++++++---------
 .../bindings/iio/temperature/ti,tmp117.yaml    |  6 +++---
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
index 9eb9928500e2..3e323f1a5458 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
@@ -55,18 +55,18 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         dac@0 {
-           reg = <0>;
-           compatible = "adi,ad5390-5";
-           vref-supply = <&dacvref>;
+            reg = <0>;
+            compatible = "adi,ad5390-5";
+            vref-supply = <&dacvref>;
         };
     };
   - |
     i2c {
-       #address-cells = <1>;
-       #size-cells = <0>;
-       dac@42 {
-          reg = <0x42>;
-          compatible = "adi,ad5380-3";
-       };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@42 {
+            reg = <0x42>;
+            compatible = "adi,ad5380-3";
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml
index ed0ea938f7f8..1e25cf781cf1 100644
--- a/Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml
@@ -43,13 +43,13 @@ additionalProperties: false
 examples:
   - |
     i2c {
-       #address-cells = <1>;
-       #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-       temperature-sensor@43 {
-           compatible = "sciosense,ens210";
-           reg = <0x43>;
-       };
+        temperature-sensor@43 {
+            compatible = "sciosense,ens210";
+            reg = <0x43>;
+        };
     };
 ...
 
diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
index 7cc365e0ebc8..7c0c6ab6fc69 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
@@ -40,15 +40,15 @@ unevaluatedProperties: false
 examples:
   - |
     spi {
-       #address-cells = <1>;
-       #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-       temperature-sensor@0 {
-           compatible = "maxim,max31865";
-           reg = <0>;
-           spi-max-frequency = <400000>;
-           spi-cpha;
-           maxim,3-wire;
-       };
+        temperature-sensor@0 {
+            compatible = "maxim,max31865";
+            reg = <0>;
+            spi-max-frequency = <400000>;
+            spi-cpha;
+            maxim,3-wire;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 58aa1542776b..fbba5e934861 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -44,8 +44,8 @@ examples:
         #size-cells = <0>;
 
         tmp117@48 {
-             compatible = "ti,tmp117";
-             reg = <0x48>;
-             vcc-supply = <&pmic_reg_3v3>;
+            compatible = "ti,tmp117";
+            reg = <0x48>;
+            vcc-supply = <&pmic_reg_3v3>;
         };
     };
-- 
2.43.0


