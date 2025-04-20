Return-Path: <linux-iio+bounces-18383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A9A948C5
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0F616F84F
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2320D4FA;
	Sun, 20 Apr 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+0V1GdB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A81E98FE;
	Sun, 20 Apr 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172642; cv=none; b=SX278FjOcw6bLo26fsvP02aPjvYTDD0AW35DpP79E5S9HwWDDpMs1pPqWWWQOjHaq0OTVPUeK0fU+tW2EgJ15fzZZJPgCb97SaYsj4ETKEdC6CmopabyUt1bE79oN0XSjcj0QHw1LAqtz5JPvNKpYQojExAUktFWL3kfZCoKBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172642; c=relaxed/simple;
	bh=pcaZUQDdhGhgn/ojHFGzFc8kjllioseeupjsELDrcyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuu4DJ4ZqUXmSQqt06MRAQ/GF63mCSBIMRq4tj68m9PJQ4KR8lnbBaELLqtQNHLxf8dvkpf07o7S8Y0C4jWedwu9VZkSlXv71b6aEWLN4e8HoGFFqPDUuqPIAmc931KDLVYvqzU1Bqo2MggOjNuvfclcdrieh+0ULnv8r+e7+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+0V1GdB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c062b1f5so2539811b3a.0;
        Sun, 20 Apr 2025 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172640; x=1745777440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20XJ+Ilq7bm7Sy6IEU5Sip+0wAc16SX8KYqgavA9uhA=;
        b=b+0V1GdBmC/QDyDZ0AK3Si3H4PdlMffVTEjTAk4QC49bXipFjAP+efJyt/4WFQ8lr2
         jcON8JpkhNzuVSCXWRkW7vkGv9uXAERl3acTNutMdvDOuy/dOrn4VWud88V9Dcib2daM
         3SPYggeTEN86HTH+XeWAERXbC3Swe51vGS0r0wiw1KWFIeTzvjLtbbWBFVemu/OstMx+
         O3EBatuOAmCf0mSd5ouS/zShWwnaqJgsIk5IyKjn8Bww/5j22mMd5F6hGlB1VZLqxnG7
         4vv2gTqJTo9HLZuzv78t2MI+A03pWA1igVZ8m+Mvsk3K0BL2XVKE54y05JDSWUKgBRPz
         nRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172640; x=1745777440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20XJ+Ilq7bm7Sy6IEU5Sip+0wAc16SX8KYqgavA9uhA=;
        b=v3rcwBe0tA4CbCrX/w/V8jgf7UpIKZDtNyROlwPsnmQbgxFMC3f+IRSM5vzGjl0XHT
         fiUcmzaOBsneccvK6geg1aZzvTXd6WO+zapA+1Bux9XmEdJW3+HBRXhzKPzyDHDSAfec
         CgG+jLMTbpeiFqZGQGLHI+9SPLgwVupemsA+5K5yOAM0sOiihOvCgYzZFyPfCbsT+EBy
         XOAbQ+UWHhjjpgqj/98YtUY6qYeOyO/lMvZDsla6bMIlQeDNkNUPMVsw91GeY6SAYhIa
         qQupSB8hktr4xzgVMeykM9vyQe1vKHawwu4R+K3Oafsip+/7b8wE+6M/+xot8SfksKUY
         FWCA==
X-Forwarded-Encrypted: i=1; AJvYcCWSDy2Iw4z6H833KZNiHAKhAYf3+2+XFZCUsmmpMUFGrXcwq/++resuK6e5sgkDBb3HMqQqCJYhVOCs@vger.kernel.org, AJvYcCWVqHm0FDxKccgwlS6EI9CdT4IhMZ1hCaU8yGIQDFPI/+w/PSlLvdw9zWf0JKEf0l317Qvgmb6YaDEn@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNpWrXtK8rCv9GT234el2i39ia8IrV5ueRcMOaKMmoBTC8V4B
	M24u1KnxDUKWrlQalnLPfi9QUvleZYJ2myqIWnhBSZBiEvm9oQ4h
X-Gm-Gg: ASbGncu5bnL/UFM5ow28AAyo6yXWyj/atD2d9i/IUKK8+ot3VXcBt1room7MMAMYhXI
	7h5OwLcwmGKgq9HBxEuAhzgC3dTixPEF/Blg/eaDXeDaVnqYvrZwuVkXGC+nbwtO8xOwBmfmOS7
	cu/eBTb5E83Z7gDVYoY54Iu3MKHzxWk6o1f5VynV3p0bhzxMNKDYq270ayHTs2O3HUo2HOXRLWo
	x9WSgylOgJHc8d5DrYW+6oK9O5Gi/WYWJEHFNvqTGIxpdSJzWGTa5zcJJe5snRoqp6ZpLARW6y0
	ihsdHeKdYxrmHbAr9XehWb+zL9Zq3yBDdKqTm4x7x+8cOb8=
X-Google-Smtp-Source: AGHT+IHrXNzMBZgyt9mRe4Nl9Rq+RuwpQwDxxDHSTPXTxOgn81LfQmsEcQuzmTsho+Ar+AAG0i7dMA==
X-Received: by 2002:a05:6a00:2e84:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-73dc15ca18emr10575635b3a.20.1745172639723;
        Sun, 20 Apr 2025 11:10:39 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf8c05b0sm5009347b3a.35.2025.04.20.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:10:39 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/4] dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
Date: Mon, 21 Apr 2025 03:10:13 +0900
Message-Id: <20250420181015.492671-3-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420181015.492671-1-gye976@gmail.com>
References: <20250420181015.492671-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree support for winsen MHZ19B sensor.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/chemical/winsen,mhz19b.yaml  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
new file mode 100644
index 000000000000..2a6ddb33f163
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/winsen,mhz19b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MHZ19B CO2 sensor
+
+maintainers:
+  - Gyeyoung Baek <gye976@gmail.com>
+
+properties:
+  compatible:
+    const: winsen,mhz19b
+
+  vin-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - vin-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+      co2-sensor {
+        compatible = "winsen,mhz19b";
+        vin-supply = <&vdd>;
+      };
+    };
+...
-- 
2.34.1


