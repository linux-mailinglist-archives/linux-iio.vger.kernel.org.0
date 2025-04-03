Return-Path: <linux-iio+bounces-17569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443EA79B51
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B7F3B5F2C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69C19D06B;
	Thu,  3 Apr 2025 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBqv6sB2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AE19CCEC;
	Thu,  3 Apr 2025 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658463; cv=none; b=Ii8ELlEdXf9qE+i5HNOap1w4nJa3MOV2yp2kxZdOtFsR5wVrqdQZ6k0XVmQLNuCaMsxrO7BWyVE39MrWwwqHNew41FX7W3yqltcMtZ/MYnVXINLiYDBYWuyV21f/AQklEv7Jy0CTXJc/owM5YX4R6VcB5PefTre7FK1UAAme6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658463; c=relaxed/simple;
	bh=VLNPLeC12AEoU9rDIa9o/83SXKAuM855cpR3HtpEZmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/fix7Kvne2+7CtM0qHaPTOzNrjPcCriIH0rLOmJKMRNyJGm5UP0XsPaXWkr75Id+Q3Fv2+fpDRaI+CokvTD4eW7LUCn5Ry6bp84AKMvuJ9aSWCvapnU3Df3uwt5IkyZGK32GwK7IpF7RMs7ldNprA6ungIHnLmD7yoDktatvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBqv6sB2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224100e9a5cso5414265ad.2;
        Wed, 02 Apr 2025 22:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743658462; x=1744263262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXnOMlB/9rWVjqA9q3b7pF6bOI11URF+QKz6rkVSzRo=;
        b=dBqv6sB2bNRub1hmUXDPcSmCt39dXLQHvuv9cCfuBwPOAGlSiunfwsoe/uTgngVz86
         8Hu5p/g1bpkPc4SD9xHfBTFf+bGmjaY48ePqQcjvIgd4guVzSzBOwaCAGE9oXeYFyWSN
         x4yzRNVMx7r51Gh+37Xfih0kOuSx6NzKr6kJ72eYJXWJ/X5qZaBdmlSUFKRzVdX59J8a
         W+rJwd+PeKSsn0WpgFcqYMUo306ooyqGvvKlBGjIZLsxOr8m7HM1nt9i+F9i4Gf1ZhD/
         Vo/4UY4Vot3lieWQlSs0Hcokg8ZB0wPparnjf21qyVARpyIqJeKE0xmxRt4RE+pvNNql
         8ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743658462; x=1744263262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXnOMlB/9rWVjqA9q3b7pF6bOI11URF+QKz6rkVSzRo=;
        b=ebmZdLhsZxKcJBnp3QhAuscTVcFIOiDFzU648c1S2mNnX0jS3sWIGY5gUoudWf8GwI
         sdE1g/jsgWQWJ0wJglT/67BSi6hIl8nPXpj5LeBdY3swI4JMddMvIp73IyqWtzbCvMoU
         CPd79N/lKjPOgN8rQDamuGjybnuSqHSI8/BSRukcl/eqW88gULe6ko3ebZGr/y9UsCIG
         6RA65ThN6MJjNeyKwBrILOVBh4N36CuqS2D3MDctgkUZLq74SUM3/KpatxvXD6DTbCx0
         C6Cf9S2ID657aCbGwDMBneuWZxzc33o28NmhEjKtp33n34QX8mSe7368bixHUN+NjzL8
         F2hA==
X-Forwarded-Encrypted: i=1; AJvYcCVTjkoL+w8BosFvjm99Q2a8DVmmIW/wkyK1mJTSTuEhXae4xLwH6mbuFm4GtxZUrOGkTIWQhSxF1fx8@vger.kernel.org, AJvYcCWQNKsdPGVkPgh6komt/sx7GRECBzGywXrS2nMUIbqDuF0V6+cOfWX1J++ls3oyGgPmHBVdBa6+27lN@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7JISVQCvNCQf1fLKrjJTf2MLv8lcnc0hMm+xlGvakpaK3WSn
	6UeudOlrmVoyrZziRUbMAzDtoMc88AbiyxotbEHdtk/q7EkYaXonwGgXtH5T
X-Gm-Gg: ASbGncvheEll3TUr0NuG0gQnfm/OltRHEj6tjQNBvMZuEw0VlrZtgNxZbM8JIsqejWz
	aD5o5Odf3sTqpuVqy8rjovjr/LrAcRL72nBGUuVBdbR0+RzEWhHIK9bWEQ7r5AyocoEJChWDHTz
	u0B+YO7RBM0vTmuuiU0M8BZY7PT83kPIWQRwaHa1fchbzlXjvVAne1reVa6sgBq/ss2qOMBE5RH
	snZh2Am/DTqa+EGuCWDdhpK14GCkbdoyAtNSSBtGD3dq28qw5XIH/FGHdUiz1mlC94MfEKibxKs
	PcMqYKOuqf9cJoeKdf6vJwmnwjR5qvLWzGocPyIbvd10+2wvng==
X-Google-Smtp-Source: AGHT+IG7XLDm6zLf92mLkEv4BsnDQOX6/Jwh9eFMyuPmCJnsv+EQ/0O5DkSS5zJGFtJUD/iXm8gRtw==
X-Received: by 2002:a17:902:f688:b0:224:1935:fb7e with SMTP id d9443c01a7336-2292f979c51mr327453525ad.24.1743658461624;
        Wed, 02 Apr 2025 22:34:21 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22978776601sm5537575ad.237.2025.04.02.22.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:34:21 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v1 2/5] dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
Date: Thu,  3 Apr 2025 14:32:22 +0900
Message-Id: <20250403053225.298308-3-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403053225.298308-1-gye976@gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree support for winsen MHZ19B sensor.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 .../bindings/iio/chemical/winsen,mhz19b.yaml  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
new file mode 100644
index 000000000000..16ec902c906e
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


