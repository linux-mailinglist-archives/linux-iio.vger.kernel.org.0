Return-Path: <linux-iio+bounces-23490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD9B3CEB8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C4918975DA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901042DA757;
	Sat, 30 Aug 2025 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7acQcqM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D42D9EF9;
	Sat, 30 Aug 2025 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579398; cv=none; b=c1aI/kpZc3LrTt5QBS8ZVyOHN1i/bE1BCJU0LK+wqnHXbN+c9KFAZ34Rrab1XLmCTMc+TggWFmz5V/Wh/P6elkjz+qPHFs7LBYbScBLSCaOOFxkCr+2xLgkIb0LmC7j43UUYx58AGeH7qWz29XlF+3H30TIV0d/6aktScyrdLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579398; c=relaxed/simple;
	bh=oVbXo+WlMRVlhb0eRpFRU7JepS0fcP7SScAWqWR1jf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H36qUCEGSZ6SPgcFq7BwajNFdkDJreX2IgsecVpRzoJPnr0XX0KDncMassAFnEsOkDHoTGPZpmIcFAyxn6JhN2mKo/0i9bOGKSHxPA5v5fvrDU+81TmdOTj0muHTAsQE4WMuaewimBDq0qQ91pcllR942D+yI/Ll0a73RuJyc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7acQcqM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445826fd9dso37165215ad.3;
        Sat, 30 Aug 2025 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756579396; x=1757184196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk13z4Oe3MH+BwozPqkdTJOMupLgkm8t2078zZl5Y1c=;
        b=b7acQcqMFYo9Tb5LW4ToJu5R2cTiqkFHB/uqeW+J5NxeiiZ9xT6LmKlneBkOpGRJPr
         DqIF9+uFPGyQADQfeLmpS2Kdk7qhcSP3mpIdf5WaIcU19evtNRtw6H6pUfx5TQp640zu
         IJCIPCJC8yVO6UA18vfwKsRpWeDI5R2etPwrCKC5bUW6zDGfDJbS6oBxEoAv60kIwIcV
         syUDwJqLvQiHLApCu+71H/2sGFJHdQ7Hzsg2pcxcDHFApH3f1dBhs++/ZAjTfZDL1YmQ
         W3DgkB7mz51MGBrV8iFZyQ4XL3gU55A8IkRXmsCAP8wlRoxeDOTUy3NZPjBeDWI4mThz
         mxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579396; x=1757184196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zk13z4Oe3MH+BwozPqkdTJOMupLgkm8t2078zZl5Y1c=;
        b=H6LdRG6A4joWciTfnMg+1i5XSUF65SANMFDOi/nDO4UPgTboRnlAlqXxFwkHqzTnyp
         fYsrcoRmHzbfVRw3fz39Ushs0ZcobRWEeqJDQmNi5VPdzEnXX6PrMKo8rxBPL/wWE4gg
         MwP5xMum/30ELMYzZf0KiAA/zmYSEaqLZRTIZ9hL+pi69sErpsc0L5EOr+67TQxqr/Ym
         XP9n14uASj35QlbJEfIH+2jsD/oMm/0KHWfev7u+5e2IB7FgET/yXOZ4YsiRAqvcPDPq
         qu6ByX0zVXgwm6wU2/TeI0yolgS5QZHkUPzT8+XjaLRNz4VSBkr9EgfFmFFxo8NjGj1O
         t6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrWTsF4OD8jPLx6vJKbGcstEBrmdvACIq+WZGZeRH9SAr0AZnaMfLUX46sspVnjGTPnOLZhA9u3Ap6@vger.kernel.org, AJvYcCXXh3+yZT+nz2dM9Co3Ma4igdGEFn9WkZE5HVmp2nFtxf5VohMpEX9dh6Z6RAxDfCNDoNyBeyvC7y1e5Us5@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXHeYNwvSCG1/793Pw5HxSnjXZmDvAyMQEhDMVC1DXeexczHl
	klD8MX2NbwYbKh4dUPT9m+7560LKJA9zhQS4rpihwVWohJAAkShbvdQF
X-Gm-Gg: ASbGncuspDtPcZs/rBGpMfDJYI6DkuZzy7RNkJbDRi2GiCsWZi/ukpPWd92fXJVLfv8
	hyWD3lVb9vsjmrAUiAJvRQWRxqGGWSTcGK9bE1FxnH8z6clfN02Y6YmnCHzprn/AoAmUjvMlf+7
	vth1GBR+B9qnKcodtSBBuQ8iC8OI69tNhQJy5PqMbMyKdVNuNfe4UIy9NTAQKYa8TE29dohG5DE
	uWZb3EVzIJPzDZh0zEmMtnqVoI6QJEQe1xfMcYfqg69Uumv1cwghBLTn8AwLVEMYslR4z3GIvFg
	CdJADouGrRuWeEX0luF/SejrIao5FySBWVWNbx5stmy3rLZWchQPlXvlVQtvZEQlkzyZhG4Bknk
	Jq7hXzeI6uF7TOBhBT1ml4Z6gh5R8pBzIvDNl0w==
X-Google-Smtp-Source: AGHT+IHiAEKzjNZ893PL+wikbfz76WmuOnADXgWPN/rVP9WwwZX/uNaqkN6hmqwjlZCMidnBEi0GKw==
X-Received: by 2002:a17:903:32c9:b0:245:fa00:6e25 with SMTP id d9443c01a7336-24944a9bebdmr38079485ad.28.1756579396315;
        Sat, 30 Aug 2025 11:43:16 -0700 (PDT)
Received: from [192.168.1.19] ([122.177.240.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm56821665ad.112.2025.08.30.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 11:43:15 -0700 (PDT)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Date: Sun, 31 Aug 2025 00:12:45 +0530
Subject: [PATCH 1/5] dt-bindings: iio: imu: Add ICM-20948
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-icm20948-v1-1-1fe560a38de4@gmail.com>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
In-Reply-To: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shuah@kernel.org, 
 linux-kernel-mentees@lists.linux.dev, 
 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756579380; l=1510;
 i=bharadwaj.raju777@gmail.com; s=20250830; h=from:subject:message-id;
 bh=oVbXo+WlMRVlhb0eRpFRU7JepS0fcP7SScAWqWR1jf8=;
 b=cK6T2sOCnhY+6oWzEJ29uRSw2k4Ip7H30NUZdkO1uKtolKDKWb1JA+B5ESNnIftxn5E/mXNLF
 yAZf5y3MDa0C/bTJ/mgzQvpNozNyUeurGMUf0YjbhPVzx0NYKEeSxlz
X-Developer-Key: i=bharadwaj.raju777@gmail.com; a=ed25519;
 pk=s+pP76EgUCC/7pyu4E6Q5AizWQ1T6hUf1jUWrQRl040=

Document device-tree bindings for the InvenSense ICM-20948 device.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 .../bindings/iio/imu/invensense,icm20948.yaml      | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm20948.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm20948.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..00c8210a0285972f8084137c69a4618a1f674485
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm20948.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/invensense,icm20948.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-20948 Inertial Measurement Unit
+
+maintainers:
+  - Bharadwaj Raju <bharadwaj.raju777@gmail.com>
+
+description: |
+  9-axis motion-tracking device that combines a 3-axis gyroscope, 3-axis
+  accelerometer, and a 3-axis magnetometer.
+
+  https://invensense.tdk.com/wp-content/uploads/2024/03/DS-000189-ICM-20948-v1.6.pdf
+
+properties:
+  compatible:
+    enum:
+      - invensense,icm20948
+
+  reg:
+    maxItems: 1
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      icm20948 {
+        compatible = "invensense,icm20948";
+        reg = <0x69>;
+      }
+    }

-- 
2.51.0


