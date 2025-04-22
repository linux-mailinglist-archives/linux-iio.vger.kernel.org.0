Return-Path: <linux-iio+bounces-18512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA8A971B9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225CF3B5B73
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4B290BA6;
	Tue, 22 Apr 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nACHF0pX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8527BF7F;
	Tue, 22 Apr 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337212; cv=none; b=HeQGhnq4I2jnctPQijCvjyc2rPMfxUOQh2JCubqFwFSASCpDpOILdjPgFNPSt5iwbJqva1Yyljg8OgS4r63QA9V9QVH9/eomNn8odidGl6nuX3WoBYAdCNXs2PZBgxWBPhqsldBOCBtV9W9JXq3oUfg42fyqvRjh7HPrLtr2+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337212; c=relaxed/simple;
	bh=pcaZUQDdhGhgn/ojHFGzFc8kjllioseeupjsELDrcyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmyDYCtv/eVj9ZJjezcRgEdvaEBAf9jvo+dTDjneSgpvWEP1v4r07TQcS0BUN5UQ3+kSHmPIn0e5bVVuwenTWIvEGCxwQXkuNUrKBEH0Z6Y7GiJc7J+zDgIyox3mal0749Q/6FtyPlkkzO++OES1UR71t+nBj41zVrwsNVmoKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nACHF0pX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso78980345ad.2;
        Tue, 22 Apr 2025 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337210; x=1745942010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20XJ+Ilq7bm7Sy6IEU5Sip+0wAc16SX8KYqgavA9uhA=;
        b=nACHF0pXO7ifrIYfcQZfsPP3WpCdkOxNLmK3WFT2pK+vCk0oek15jtNM6TWHQS/S54
         8ydS2dhiYu04ciQwETkF1iBewCgtXBOI3WeGP/fuALXr84WTMGPSFjjZpdAzCh4fCFOq
         xfI+eWimBNBBclxEvpawYMoYkb1DnW+6z+EHP75sjbghKGeJWCcj47/7Yd8kElcTkuUM
         4798zW/zvR3jw/VPZncXmdj2ohD/3juZ88xf6X77v9ob+3zjN9YAaPx6DVLNZbv6neBz
         aeCV8a/pGGPGK93u3mu2z/tOB/KZPNRMflHIwgbAUXCGMJMDvS8gq8MgOu1NQaRA8m/V
         lwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337210; x=1745942010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20XJ+Ilq7bm7Sy6IEU5Sip+0wAc16SX8KYqgavA9uhA=;
        b=fVDb2VN7DUM6f+KAE1KEw9lI8dKie7HrIkhWluz8nljScl5OUagejKZuuue96xUVNP
         35NljuU5VzzrmB5HqDEQb44RkMeiS7uiZzXDmmHS3FeWztvhLXlw0xvqb8n7fWTD7Imz
         U1YIEbZmM9cPOiwXlOeL4Ya3ByrSdZSV/a5cZAb6TT9Fg4NZ4If3aslDMuKlCSASC5Ty
         O9gRD1jGLDnIfaZih2QrthyPQbFhxgRwPLh7XNFEmcpdA2aQ6Xietm8oxGFBZ1QhQrYW
         iC6ErXtTQixUrsmz6lhyS3tdDMAn9uFku+jE+o5G5Hhy8683PJwCKBdr1HIZGtds1EZi
         lksg==
X-Forwarded-Encrypted: i=1; AJvYcCWxBGRNCXAT7vkxAVDjhumILw8v7xrTQauTK6qogStPcqx/F51CXAvnmsN03Pa25kWw0219h4+mlNvi@vger.kernel.org, AJvYcCXRoJbn9YVJvvRBg0gme5d4ohAN+C76Ucjmej2TQEZU9rMBcyeNHNUxaHZoCoR6fbIK7HCbuAAuaKE8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85TlzL/dzm1ykIfSfNam8/pgaSzL/jIAvfLzgHfo9io5Anj2t
	OaE80Y6uR63L8KNkofNqbpChn1cYWMwXN1pUal+It3YB9beEyV0gYIzHxOLa
X-Gm-Gg: ASbGnculpXmINZull+33L7TAStX2KBnkXTOXRVfw1tmXUIMR7D8xN9B9Dcd7cjD7/ZO
	MHdvOJWBmapjrrYoGhV0LL9jJ/wngtQjvVd+hjyV6ZQ9dL5557eyMbwspVrDg7DDz9Zz6mq0gAO
	Ajifh+X5nQgOMAjdmFtRX3j5psV4bfnDttpsck7qvuU23Fche6bCMcYyGhBE/IceHb9vcDoHjzd
	E2BxZHWW1n2eDK86qTJbeB0/EpkKA63OXUAYuk7m1CJnBbAyJX7W4yBmXHzZ7bq+ncdCZC5gozG
	C2tEwXeikphVWLpGwacFGhDezJZpyldD3Rd9yd1hOJtjeSo=
X-Google-Smtp-Source: AGHT+IHiTc+niLbQRV9vL6xODU5VNA6dKebfAHlM02+qxbMcX4kq+VLfSPk6jHMiXvN3t0tjqAbLTA==
X-Received: by 2002:a17:902:dacf:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22c5357ef75mr221379435ad.16.1745337210003;
        Tue, 22 Apr 2025 08:53:30 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c50bdda46sm87078705ad.3.2025.04.22.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:53:29 -0700 (PDT)
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
Subject: [PATCH v5 2/4] dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
Date: Wed, 23 Apr 2025 00:53:00 +0900
Message-Id: <20250422155302.669960-3-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422155302.669960-1-gye976@gmail.com>
References: <20250422155302.669960-1-gye976@gmail.com>
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


