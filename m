Return-Path: <linux-iio+bounces-5686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA108D8712
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BB1B211D3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC8134415;
	Mon,  3 Jun 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhPEccFU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BF107A8;
	Mon,  3 Jun 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431720; cv=none; b=GAqXaDmMznDZH95q4zWOSGtubnu6y5T5KiZJjRZdY37Iv484iLzKOfXdnzNr2A0Jzh1d+i0yF2S475wzZGkI68eGKh2Eb5iA4OCvvKrqkXtk0bUagvjRJkT/jiySc/l5gcGqsOrDzLUtZHcWvTVZ3UVApz0UtXT/Y0hh8zxRa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431720; c=relaxed/simple;
	bh=5UdqhTYDdJ6XCunroqHqe5/BwihyhEMQZXMlLIW0q2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=md5sDV+8WZxPJepjkhkARk1cPzvZTwlll2v7wV9QDA5F3cMCbI3GZvsE8c8Hlvv8mY/eizIS3oaBLBGVnTY236+B3hKaNCMWfuvRntpx5opNQ/flKFqAXbHK5yuYrnXuRPlapuLhXAeNaWDk3drhwX6gDvLGiqqKwu8Uvq7noMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhPEccFU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ea903cd11bso47115971fa.1;
        Mon, 03 Jun 2024 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717431717; x=1718036517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UT/n64RkdFWABWe/J3nAKJc1oXeovt/hfh7Nn3LCSOg=;
        b=IhPEccFUqxfqvdQv8f7Il+3av/iWODU7tlrcxWHF74lhcp9Lp3Yx3YWP+R5CbWkGBp
         AwcD6QQYiOVZnIfidzL9bPnwKxySAY/XD6sieHqlJaWghJtJsFXHZ+U3kpmukBEQ96Zn
         6wcM/0NSQlUy5LIQbCAetnrTpDGYqOR1+2J4/PonqKRhaziaGxL+v/07NmcOPTrAaBjc
         fheUa9BXGITRcE4kBpt+fSmbMGAUmb7Qzc+KPV94wvAGq7WnGa9th3GsFuu6U4pJMTaE
         +hMC/mUYC6ejUVnxW12N4YgihC1OcicXzLRCiyVdKNClJ4oLxq7J0WZ6/N4WUpTOG7F6
         ZpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431717; x=1718036517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT/n64RkdFWABWe/J3nAKJc1oXeovt/hfh7Nn3LCSOg=;
        b=p0j8Vm3pMaiK0owxahBDW214vfcplpd1mzYbwfGWrGgpDp/gVV5KUm5Tv0AhSug8BW
         6L6IaR5UVsG7xwRFrOeyFexweUuta8M+jy/oJb2ZsVwFKAP+FjGZKtIIIhhD86VVZqVT
         KIxEPaMQdayiUD0wzcbfxowJUBFMUHDNjutJuPa7ebpGsak2cxrRSfXXDd0TPzRH9/js
         0YOyjtYuP2h3oMvd2Be+2/WPGvOSVJxeMFfoY+WEqfKvLb2xQ7AGJ0OB4tnZf4n7pSt0
         Ozr0gAigwPDCPVT7Yg9Pnagy64Z7EYjdjMQ6cUohKXB1qISka8FJ7Piu4keTEYy6OoY4
         C7eA==
X-Forwarded-Encrypted: i=1; AJvYcCXQL2d4rC+SZpdIuNj4AXmKOCn3Uvnm46CELpuE3yxQT3ks+w+QT85m3GTpAWeiDvu/ljKS7ZpxnmWVCINVwNfNyzILacqn+YURlR8SuPFf9G40JVbeYCmVUveOCWC/AaCPXK8Ia9MCOwgISVytSxqZNJO1lVLSCs79p3MK4tbo+HcQQw==
X-Gm-Message-State: AOJu0YxXghjG4ewCs8e4oWjMW2FcXOqOstiBhmdvsMG1avTUYBYkUuip
	BYGoGmwyUQCpGLQeBqzvd6pFtPi7kMmgAc78KghmXsw7PLNxg8SH
X-Google-Smtp-Source: AGHT+IHt7Kf9ZH7iwEqH8mZHyCmmBac2J8bezy5Ix5RpF+bJ6OCeEuOCUbk2YVM8MpEs2KAuu1IwIg==
X-Received: by 2002:a2e:b693:0:b0:2e9:8852:3d20 with SMTP id 38308e7fff4ca-2ea951e4c52mr77531291fa.41.1717431716922;
        Mon, 03 Jun 2024 09:21:56 -0700 (PDT)
Received: from localhost.localdomain ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213cd1c075sm43697765e9.0.2024.06.03.09.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:21:56 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: ivan.orlov0322@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: iio: light: ROHM BH1745
Date: Mon,  3 Jun 2024 17:21:20 +0100
Message-ID: <20240603162122.165943-1-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ROHM BH1745 - 4 channel I2C colour sensor's dt-bindings.

Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
---
v1->v2:
- Fix yaml issue: Make `maintainers` a list

 .../bindings/iio/light/rohm,bh1745.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
new file mode 100644
index 000000000000..ac5c4d160513
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bh1745.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BH1745 colour sensor
+
+maintainers:
+  - Mudit Sharma <muditsharma.info@gmail.com>
+
+description: |
+  BH1745 is an I2C colour sensor with red, green, blue and clear
+  channels. It has a programmable active low interrupt pin.
+  Interrupt occurs when the signal from the selected interrupt
+  source channel crosses set interrupt threshold high/low level.
+
+properties:
+  compatible:
+    const: rohm,bh1745
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        colour-sensor@38 {
+            compatible = "rohm,bh1745";
+            reg = <0x38>;
+            interrupt-parent = <&gpio>;
+            interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
-- 
2.43.0


