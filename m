Return-Path: <linux-iio+bounces-21217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6DAF067B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 00:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13764E50B7
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB74277813;
	Tue,  1 Jul 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO7OQvK4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C741E98EF;
	Tue,  1 Jul 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408236; cv=none; b=qdc6LIKsw22ojxni+wN4jEYbnWe5MqqEVv1nwX6OYsbOdBfFIY5GbuXHkaXXU0KQDHrVbl5VtpezyXFQWG4Fm3zBPl9MAQw2J814r/oM8mbE7zTSS2kvpPrDiFocTRAnwAZYXUCcbM82dUghONgKDK9Ce3HB6TwHsXPtaTvR6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408236; c=relaxed/simple;
	bh=ViKyait5fPHL8jCnoVnIZA79jdFnWsuRcx4Aa+jEnJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABBronaOhj1S2XqT6ga3/TmBCFVKqc+elxikvqxRP28DwPuJpgOpi0HvFiVwzgCB1+d6rG6P5jZNMMpLdOO+UP4G3WWy62ijiXBQdpZM+gudICJ6lYiQpJd67zA6WzHhImWuq9SoP6dvS97JiNUrSiRVzqVHNQtLDKPrd0A5iiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO7OQvK4; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso37958886d6.1;
        Tue, 01 Jul 2025 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751408233; x=1752013033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLDx1IV4oKSZDGpiKEen/beGqUru582RU0BBzDBbpkQ=;
        b=TO7OQvK4LgNN4tnMOy1XoPKPLk716A6iC40zTRxRstPnAjOGB7R47R7NIpv/YLQBNm
         9oV5LeqNFsHD41bMTAx6X2cJ68S8feYuqvJj0vqwkL/6RdBSvKWXk3sBRNvKzP1iA4d5
         2K8yf201tvPu5jzdPNKQQRqk0JX+BZGMvijCkvxH+xN3qvO9hq5YGS0EggDgo2hnyHda
         ieXT3hdiKYEm/HMV9eCxBHKDsraK+FmssLPZ4nP0uXzMfq8/hFY3x+E00+p0Y7g92mSX
         v9a3dsEpRAA1HjeNlfuFad3YhkpYiDLBnz1dU35KPxISqMiRmou6InrrQ9NZC47Fi/JO
         aZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751408233; x=1752013033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLDx1IV4oKSZDGpiKEen/beGqUru582RU0BBzDBbpkQ=;
        b=Vj0J1T/fb/y8ousSw/Z4bBkVsMZj1eQFDlsIQliX6hjZOMX0v8pYGVh5lYIrblg6O6
         QUOgHtOjWCPvcUJ0rwrzDipeHt06imGS/vHYAKfge7wUuIlySZCdCiClm+D2/WfK3K72
         XhMwsE57UTs5A7hWitX1S+JXRNM6qdHVDqmvaRrXVOu+P1sO6+v92yfi2yznYxpLWgMi
         +oDZuxaQaFY6ull34Hy9Icq8xIvIZn736srERDA/IbAEKpr9jP2gR4Twx6aAsmBc2JLN
         VZnGWFEHcy0lqT1+e9uvhcejtMT6Izt7AaoM29HW07SbpY6HuoxuDfyeEUHAuJLvZpdO
         4Ozw==
X-Forwarded-Encrypted: i=1; AJvYcCV90lYxnNjmDcudeOCv78pduF+NBswY4vTIn+ytxgKLVfAyfwNt7dUfesRDWzoyH+uC8W5QnEt7659Lyldx@vger.kernel.org, AJvYcCVF3DOVn/w2b7J1k8C1ImvDkVwPYUdRJgjFv1qJWOQFLajlrN1/rm3bfqG7m2JXPW0BkcRnlj91J03N@vger.kernel.org, AJvYcCXu07L149lI2maygjyrVTyMbLOzP4A7ybqQ9W+tJIVXilLYSiL+wp2qor2x8EFQFG0kBXEeQo33i7Hj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7rNKRg6MNiAPqqOKOa67Yg5b7AElY2xQmzjCkx+oCo7iLbvi
	oB8SEOJ3wafIYpRIUbX6MLP1clFIEj/gYVkCDy1j7lvMjrG79e14bRf5Dsd+9M4XizU=
X-Gm-Gg: ASbGnctajpBoTDXCsb3uNwXW5wdmQcG7Krb/MRZGDttFQvNxCceOTy21kUbGcGG+cqd
	EOi1/8nwUqOvQY9mkYsqGH8GBBXlxQbeZOio0/bPlKddLTLUtjJX3Y//P0dG3BzN3s5YJg2iLMs
	hWbqRxj1cdf/6LAtZCY3dRts67FoEcRa5olQa80yWsfct+c/YBBoKmHoofSpx68Og5YNm++0wDh
	Rs71v2RCLknZOEdey3R0Gsban2VNdkbB9Vre+6vL2lNaCTDDccBryXIbMEcI0c0yy5P2zpfIy81
	t/y7Jm/1mbicqkqrZ1L5WAG/H5NPuz/zLqkNBFBA/aV2rN83fw2XC914KLwG35Sp9BJcSU2lEjm
	uHLQMm726iA==
X-Google-Smtp-Source: AGHT+IGvNjIWMUl/cLnnB/EuLNLhBKCVzHOoWr7VWH567XXTYD71/DcE2cpc6mrk9FygNRo9rZv+iA==
X-Received: by 2002:a05:6214:5a0c:b0:6f5:106a:270e with SMTP id 6a1803df08f44-702b1c118e8mr4093046d6.44.1751408232755;
        Tue, 01 Jul 2025 15:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:632c:d5cb:2b3d:e72b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771bf9a1sm90750216d6.41.2025.07.01.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:17:11 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	jean-baptiste.maneyrol@tdk.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: pressure: add invensense,icp10100
Date: Tue,  1 Jul 2025 19:05:43 -0300
Message-ID: <20250701221700.34921-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no txt file for it, add yaml for invensense,icp10100
which is already used in the driver.

Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
@Krzysztof and @Jonathan,

from v1:
> Filename matching compatible, please.

and:
> No wild cards in file names please.  Just pick a device to name the binding
> after.  Wild cards have an annoying habit of getting messed up by companies
> releasing completely non compatible parts in the middle of what we thought
> was a reserved number range.
...understood the point about wildcards, I`ve changed that in this v2.
I was confused because when I was exploring other files over different trees, noticed
the same wildcard pattern like: [1] and [2] (maybe there are others).

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/power/supply/bq2515x.yaml#L81
[2] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml#L119

I`ve kept the "ICP-101xx" (wildcard) at title and description, if there is a problem with
that, let me know.

@Jean-Baptiste Maneyrol, tks for the answer and ack!
Best regards.

Changelog:
v2: removed wildcard + adding proper maintainer
v1: https://lore.kernel.org/all/20250626212742.7986-1-rodrigo.gobbi.7@gmail.com/
---
 .../iio/pressure/invensense,icp10100.yaml     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml b/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml
new file mode 100644
index 000000000000..f4f23dc89481
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/invensense,icp10100.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/invensense,icp10100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICP-101xx Barometric Pressure Sensors
+
+maintainers:
+  - Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
+
+description: |
+  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10111.
+  Those devices uses a simple I2C communication bus, measuring the pressure
+  in a ultra-low noise at the lowest power.
+  Datasheet: https://product.tdk.com/system/files/dam/doc/product/sensor/pressure/capacitive-pressure/data_sheet/ds-000186-icp-101xx.pdf
+
+properties:
+  compatible:
+    const: invensense,icp10100
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@63 {
+            compatible = "invensense,icp10100";
+            reg = <0x63>;
+            vdd-supply = <&vdd_1v8>;
+        };
+    };
+...
-- 
2.48.1


