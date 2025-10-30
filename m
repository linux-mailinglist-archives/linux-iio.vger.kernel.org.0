Return-Path: <linux-iio+bounces-25685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF4C21388
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618AE189614B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404F2DCBE3;
	Thu, 30 Oct 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyNcFOBO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6772D12EB
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842094; cv=none; b=QTpI82rICsoFhcEJgx4W/3SyhwW0Nkr5Pkhfk1iOszSgCDLQMjc0xhTDOihmYmx3MzEu+7OZCdn3s9PAF0Q+0NcxtN4XJ1OJ1t6nfeWN6nTXtXRrR7HqRqIpWh5s40XNwgQIRyA5oNS/Ip88hh5xFwRVfLi2r/OkLUFSRq9VYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842094; c=relaxed/simple;
	bh=NaAhwhcT0GhzI+5hmo8klT6kVaD5KvGtkWB20H+nKZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j48M9QUrHDuvPZvNPQDxqUY8REg7oBQlawvufAEz26iiOC6yMCwhIvXo9GiIQhHabEi1TqxFn/4q0CL5Ee7kDmnGaCldVRmFDxPEWjCqAEpzFu/Ohg15uf1rRBuXuQe147kn125mPes1cCHbjkofwQimB6Cz4p363JeUPaBgGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyNcFOBO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso1124447a12.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842091; x=1762446891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EesdB0mWIJlesJlzqwPz+0cVXOTJiZY2fqJ5tr7PE+E=;
        b=YyNcFOBOwcqd+gjRghfjhtKssNBcr1TD9lZ+tRS4u72c8GFJA7pmFRY1X0Q0RA+Msl
         jQtRbQOQLZquGhfcMHaGUGrWqn5tWOx64tFwmKZSqNHTQph3qUZP4ir2vCBdZjadkLSK
         pN1tVwVQGEKV6SotMUpdq+JSKc42yR86VuLzgjB+Q32kBWON0QSsbXpkf77jU1PhUAFc
         S+DBpjhpnO23HkNSOArjMpDeFw8479qbbzsrvbt68HelR+ZF+jMpoIOgCxO5ZZd1diHP
         hFdiIfDgeoIIpDfYmagOt6OblvOl0QOOuxmDjRrvu8fwoA1JmYr77R0rKjrKosds0dZ4
         ZgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842091; x=1762446891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EesdB0mWIJlesJlzqwPz+0cVXOTJiZY2fqJ5tr7PE+E=;
        b=u4GedPhmMtJDEH1XkCPFmcXXMOzTjjDNRfka4tOLX8L1F095KHDUWpk5UWdVh46rhj
         VJoivxE/29KY1MuXmXm6zVPrGDXCQDneYrXharBeuw9GGP3dHsCX0rcCDImrbeOyOE3N
         Jm3RPq5VCG95B5McGrUHUIFNdyhao6CRSWeXUqR5IH7/WpYfXaJrFZsR4Y1C8XcBAz6M
         YQBdaF12ShYnw1iQ5TDouaIHahEIaDmTC1K7TQ/XU5bCs4xvDlytkZjoZVbwEeUZBbzU
         KCxVzR3J+O+0ICXfEsAjyFUIqJUbbMgJV5s16BbOTNSKWC4QtcdN8316dTElJ/od+XpL
         N5gA==
X-Gm-Message-State: AOJu0Yzd6M+WO6e46tojfy0olag1GhFQAI+aIfapSVu0KYkYM99mARCb
	YLIeUjPspAElMCN0w2bv8KSLZ/yO2SKGy4VztIVopbSLW+2vdoimB3yc1aeq/Zfa7rw=
X-Gm-Gg: ASbGncsNAxoZICoYeKI8b25I8LuFanli+9rORapaUUVaOI2bilOODyr5uP6vqtVLxSP
	Y1RKyBIhXCDxklRK8Fzzcn72putxIZYufgujbY4bEBmNtyU/3b+95wh2uycxLJPNODnzDd+TVJG
	CW4J8KpkjIxeQ1QjpdVIBNklfD0J2b+FzjR6/RG2/7br7nyX2E6N54k/RAaU5C3XK/jZMKsCvz3
	8yPbU2YMWUPfcK/XHjBAtvZXQVbB5W5QbH7Z5YymthfcoM4MREcfFlNdFn5SztngJLwEbE5kwWM
	HryKDj2/T3rlyoMSaQCCL7/1wcifTQoaEKA6NngQzsMoBli3an85AwT5I2RfY5aqRj61s1MGze7
	XfCgINxISOAHWqZlC3HvfNlFQUFx0wOQxhoNQXzkXlZL4ypdg42Q8mUF9INgmzW6XvLn1/KJb4h
	KczXwUxqUyIi8GcAlIwYZRaFoQqF2reTDMW+TZMOtGQS60z646y1TG4+U6NAFVlod9+y9fs13La
	lTTBdU5onvptNHSLzaK7g1ejld6pahsa474OM6NqwWe/eY=
X-Google-Smtp-Source: AGHT+IEOK5HPt/F8XF57/daB9IQTS2AhlduO2GsrV+6HzQnWa8iY1lYUOXSbd0WJUC0DwrxVWqok/A==
X-Received: by 2002:a17:903:246:b0:269:82a5:fa19 with SMTP id d9443c01a7336-2951a4aa4b6mr4203125ad.45.1761842091135;
        Thu, 30 Oct 2025 09:34:51 -0700 (PDT)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:339d:c9c4:e069:47f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm190932845ad.100.2025.10.30.09.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:34:50 -0700 (PDT)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [RFC PATCH 1/3] dt-bindings: iio: adc: Add TI ADS1120 binding
Date: Thu, 30 Oct 2025 22:04:09 +0530
Message-Id: <20251030163411.236672-2-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the Texas Instruments
ADS1120.

The binding defines required properties like compatible, reg, and
SPI configuration parameters.

Link: https://www.ti.com/lit/gpn/ads1120
Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
---
 .../bindings/iio/adc/ti,ads1120.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
new file mode 100644
index 000000000..09285c981
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1120.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS1120 4-channel, 16-bit, 2kSPS ADC
+
+maintainers:
+  - Ajith Anandhan <ajithanandhan0406@gmail.com>
+
+properties:
+  compatible:
+    const: ti,ads1120
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 4000000
+
+  spi-cpha: true
+
+  "#io-channel-cells":
+    const: 1
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
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1120";
+            reg = <0>;
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+        };
+    };
+...
+
-- 
2.34.1


