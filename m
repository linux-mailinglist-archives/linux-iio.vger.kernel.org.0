Return-Path: <linux-iio+bounces-17316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65096A74FB4
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514AE3B4556
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4201DA10C;
	Fri, 28 Mar 2025 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="chmBQV40"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-16.pe-a.jellyfish.systems (out-16.pe-a.jellyfish.systems [198.54.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEF1C6FEF;
	Fri, 28 Mar 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184154; cv=none; b=FfcDKqbZDFjwS77UPNDb8vGPleFKr3vWAeDbNgvx4LCT8N1DW/QkgQlR7iGsYSdnGLkZAduHczCn7Wm4QF1311pFmACF4ZX5+qWVf6jcaTB9GAi3Q4czO3FYqNY2BwMB/UuzobyyQUmsl5OM3z75rVRBE0wwB53DovEmr52mYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184154; c=relaxed/simple;
	bh=qONy+jnbuBALlK5A+bI7hZRdpLHf855BqexvaS6uC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bynaGK0xz25RqZiMX5YUkxK+ITuI+tD2g1NI/ZEYfPVNQwefI3SkdXnX6Y1qeEz67gQ2HAV+/Ytg4CIrKOn6JC04k4OPy7xohy3NmOEl4qxjZQVkmfitstQXjcORacFxKJvQuWiBEZCTPmE3uT7TvF2EJC7kqfAW4GomXu9v1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=chmBQV40; arc=none smtp.client-ip=198.54.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPSh74yh9z4wc4;
	Fri, 28 Mar 2025 17:49:11 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPSh74CJQz2Sd0R;
	Fri, 28 Mar 2025 13:49:11 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZPSh72grRz3hhTj;
	Fri, 28 Mar 2025 13:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743184151;
	bh=qONy+jnbuBALlK5A+bI7hZRdpLHf855BqexvaS6uC7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chmBQV40quBEJaZBc7+DB5cjvhZ4KwFExbFBJsGWfuxOXCIgLgFGRkgleI3AOGcW2
	 Kjuxy7UoFXLxUQrMGFuxb4aqiWmcztW9C124F0jJf4vmgeQVKgZzYpjsWz/8TB4+7G
	 m/Lth0Wgt3SQSZC2T3qQimDq5ucorahkE8j5Bw7XGBwUXGr2sfYC/B/fdqlreMScdA
	 tNIX5uR02FbTEHCq5NIGfsExWqK9PWUlsWvMwGFMVWa9apkWzfGSX+mefn4vf9/xMM
	 UFsdNMozA6Om6qEuIL7ovpn+QMEvsXowuA3Bn+9KTFeqdN/QGe6pobvwie2lIYrNeG
	 JNQaObet/QvUQ==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 13:48:54 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	sam.winchenbach@framepointer.org,
	bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Date: Fri, 28 Mar 2025 13:48:26 -0400
Message-ID: <20250328174831.227202-2-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

Adds two properties to add a margin when automatically finding the
corner frequencies.

Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
index b77e855bd5946..ff0cb553e8716 100644
--- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
+++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
@@ -44,6 +44,24 @@ properties:
   '#clock-cells':
     const: 0
 
+  adi,lpf-margin-mhz:
+    description:
+      Sets the minimum distance between the fundamental frequency of `rf_in`
+      and the corner frequency of the low-pass, output filter when operated in
+      'auto' mode. The selected low-pass corner frequency will be greater than,
+      or equal to, `rf_in` + `lpf-margin-hz`. If not setting is found that
+      satisfies this relationship the filter will be put into 'bypass'.
+    default: 0
+
+  adi,hpf-margin-mhz:
+    description:
+      Sets the minimum distance between the fundamental frequency of `rf_in`
+      and the corner frequency of the high-pass, input filter when operated in
+      'auto' mode. The selected high-pass corner frequency will be less than,
+      or equal to, `rf_in` - `hpf-margin-hz`. If not setting is found that
+      satisfies this relationship the filter will be put into 'bypass'.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -61,6 +79,8 @@ examples:
         spi-max-frequency = <10000000>;
         clocks = <&admv8818_rfin>;
         clock-names = "rf_in";
+        adi,lpf-margin-mhz = <300>;
+        adi,hpf-margin-mhz = <300>;
       };
     };
 ...
-- 
2.49.0


