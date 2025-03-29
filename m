Return-Path: <linux-iio+bounces-17329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBEFA75737
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CB61890557
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A21DE3AA;
	Sat, 29 Mar 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aowtYDx3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54F13C3C2;
	Sat, 29 Mar 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743267008; cv=none; b=B61RlugWbEKl+x880ZGCApP0F2VEdj5+cWrEXLHLuiJBFeRLsQMSPFrSI8VF4OBgTjKmsyqp603S5s8acBx1ZM/vQY7v8i3voGTI/x0KHY+cUsrbkR6M1cBbilteupeGDYQrbO9MIkfi/3lUfu1K4wJAh9eDn1l9Zl3fRUCLmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743267008; c=relaxed/simple;
	bh=opOCxAKea52rx8esMkZMfx3djoOpboLQEP/YzculpAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIf0VjFqlqEUoovMPKl4AqgPNVA+OW6soO/7CjMrVtc/wMuujbA0q+3NjlHbflOAhUtp7xBTki/r1hcq5xvwgNtkkI8VFsVQ/RV+IPRzZEqKD6OdPGDURK2Ve41JUEPRYtDc2bS9PRe7gSONuVurUQO8AIu+Ig0IRvXFOCFPQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aowtYDx3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223a7065ff8so33981115ad.0;
        Sat, 29 Mar 2025 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743267006; x=1743871806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfDiV4QR8ilIi1uVqsCo7LZR3U+6qOM/UziA1IsLxak=;
        b=aowtYDx31IDe18FnNifcpnEuEJ5blUnz3rcCSUQ0wW7oJWvROS+DZ1FpDcKBYT6Kze
         qrkvULUwnnC7wPzb7otSS5eZwyKQDmFNUH512gouRgDITG+rBWJ7U5p2lr2lrDLY7504
         z/0QjeiwK3t2claiFPqAGD3Di7Igov94u7iIcRdZByAuM6F6qQkloRbkauxI4PcPDeva
         fmUuyd8YThUvm+YsVJSJ+wE/O4GEuAUHiNpfMVSAo8t2hHVUl0IECyxzsSERPE+bBE80
         LkjuuzBAax/q7Q93dhFD0duB4Ymo1bliP3PT4iPGQ8/vNBeLRGvflCj/LxhvnENl/zSw
         TKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743267006; x=1743871806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfDiV4QR8ilIi1uVqsCo7LZR3U+6qOM/UziA1IsLxak=;
        b=iw+9S9Vv8b18uO1G+zDkcd12rv33waPYn6z5IErB4wQcqODuEQOQvOIByXWLrmD3Mi
         0zaOVHnZFObmSJz5yz7MbXgfc/kwP/nUo6gGIG15Q63r/S3eNfKDDyk3vbDw8uxuBDrL
         e84baZUsSIKWbpH2Y1pTwuLaqJ5VV3UkG/DJGH3/GQqRKLvK6JD0ZaJRVxB7DvCTCca8
         IyCDy8zM43pBZgzRNRSIuTx1ce4Psd1dI5gaS3G7TaL6h3x5QFtAqSuYkI6xnZ1spzTG
         6YKqDFFrRTqTfFe9sYfVZvlzWeP1IxujdMfi3/sSV3wVmxkDFH2D6YPvgkhjvWjHXqLo
         uFfw==
X-Forwarded-Encrypted: i=1; AJvYcCVwak7FAv/zWg6EpjbTTmpWKxkmZ0Gq6ums+m9yOfn8fHbPxs3ZCIdJt9JzFlttg8ZJjXEiMbvGLkf1@vger.kernel.org, AJvYcCW2LrIkOLb5Hq9ryQqMsalCF+iTtqpQsVII0duSspgofqFI/u0/WPk/+NhYgNPEDSgBXPbdNGo9qnIg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7zVI+LwfIlqdi7w8YrN83KB8vtfhW4o3tTPom5w3QmcxPWQ3
	bQaX6oNSbZxKN00KOuiontPtrqGcqoLDz5mgILdjSp/wZjHZ+7qrT9132Q==
X-Gm-Gg: ASbGncvMom6c/bpaVfCStXmXRNFiyXcjdNk4wJ4geE+pRoOC5h6F55bj/5e7gUa9YJz
	wcUk06mdni3T8eAu4L37YEmaCF7CciZxJjNNKsQStK9+CLOJ+nvcoIeGbQ/icyeVWS7+E0f0R3h
	KQaN0qd5Va7TRjlcUq7OEscDnEC7Ziefg7fMHhQfnfQNYEQSN4cu9ZesWhBWVQxXy0cOz1+Awd7
	bL0M+O286N/3Zj1amB/cJv8wbFcaG14QGjTNYT9/GuM24wkieoeyCS5Gh3B/IWGAF6i75g737zB
	PM7DvQTWPW2rnrSwZu/c+xe1O6ItlOUWxdnXtdHK6wnIkIHygV0SA1Xr3R/Yow==
X-Google-Smtp-Source: AGHT+IFIGlLa80LmefN+gXtkfiUPGVjQhs70FX/wKDG3DfBTuZPXAFEMlXFroI04YzGAO/9S5F3TCQ==
X-Received: by 2002:a17:903:19ef:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-2292f9421b7mr57777095ad.1.1743267006357;
        Sat, 29 Mar 2025 09:50:06 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291eec6fb2sm38565425ad.26.2025.03.29.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 09:50:06 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
Date: Sun, 30 Mar 2025 01:49:04 +0900
Message-Id: <20250329164905.632491-3-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250329164905.632491-1-gye976@gmail.com>
References: <20250329164905.632491-1-gye976@gmail.com>
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
 .../bindings/iio/chemical/winsen,mhz19b.yaml  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
new file mode 100644
index 000000000000..c08681e43281
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/dht11.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MHZ19B CO2 sensor
+
+maintainers:
+  - Gyeyoung Baek <gye976@gmail.com>
+
+description: |
+   CO2 sensor using UART serdev bus interface.
+
+properties:
+  compatible:
+    const: winsen,mhz19b
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+      mhz19b-co2-sensor {
+        compatible = "winsen,mhz19b";
+      };
+    };
+...
-- 
2.34.1


