Return-Path: <linux-iio+bounces-14385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81413A12C84
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 21:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35571888172
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75491D90BE;
	Wed, 15 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ettSrmJg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC5191F75;
	Wed, 15 Jan 2025 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972676; cv=none; b=K19w5/4rMhwybKp/zAm8Ix643j51k8VGae7yfoUUU6390Viev4yXTQDDM9uvVff7G6+sNiWuxZlEc49mebKLvXVyc0/7rgWrqI8uWOev8BVzjEgrWPITe7eITvZEH5hNjbjgIP2DDnfz1Eyod2mTDQ1BNEPXJj9+2ULRSuN9waQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972676; c=relaxed/simple;
	bh=4gGBLBm2WNgM0NeOFcF0ipjCwZG22PvWbgxnJfvHN2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/OShW0m+wSmD1MwGc7Z/NUxk/dW9yuhKWVZOrg+lmWPY7tQlDfo2/uAmSc2qwm26psyP1yQLcSlxj2edn5/NtP7jfs4mconbNLsn+W0mrjBdFriNdu8XJvW0vEH49DY0M9SEzz9oBYSLJ0GrOH0JRutFhptmZWiVIqWO6rBaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ettSrmJg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaef00ab172so30996466b.3;
        Wed, 15 Jan 2025 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972673; x=1737577473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46A7egOfjGktXi1rPu6cT+acsY9JmFRJLf+A/0J2Lio=;
        b=ettSrmJgfVxsaIeUXnqGFZl1OnNTkI06KwzqVcExFDO30o1GveHMiZmnxD+0sc0Jse
         Wx5IKl2UO9itF/eEQ3PsfNa47MaJD5TLuDlRnyYjQ1v+m6hiPSc6/NcaK/LEBQLaAZGP
         4xkXoj0h3yZm94/duhYQvkZ9bAePlLCQRjJe0hRIpW5oowDZzO/VmXuCqtLQqXI+SOUi
         qjOluOiqIf6oyQtnTdegj4ifTRzGmAFCNIS8zcrzIgu4JJYuh07QJ+gGC7/PixicZuTR
         QsTczdFWgi/Kt7H3XUfh9VbSoSs59gWAB8cQHd99lfc2KIBTiuKsTKfCLpWA6sA2m+rx
         GRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972673; x=1737577473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46A7egOfjGktXi1rPu6cT+acsY9JmFRJLf+A/0J2Lio=;
        b=WtV76Jon4V86GXjtnUeWt++wJJ993/QGTJuhFJA5ycnJSShF6MAH/SpNDEINnxXrAG
         ja0dE+4FyFUrC7VTOMcpn9uTh3XFBAU5s8nZOKDFTZjs/QJDoZEXXnmJ9TfPoqLtgOSx
         i/VUWA7Cn/woNk4DO/oHZx7aDQoXQ4wPlhYB2lmDrptlAB0lIHQHLlKZVoOyBO9gtsIb
         7PfQ1WT4/TNvPZ9qhW+geLuUteJZiZyoy/W+IsUtmzbHOt88wH1470/Xm56Ys6g0ayA/
         F8Bdi8AOZFlIlOv5QpQmQXc0pGvxB+c2NUlKA5B8IAcDjV5PUUgcOcw5GiRqcTwu2rPJ
         JYIg==
X-Forwarded-Encrypted: i=1; AJvYcCV5wHnOOFvY+gGg0lZoQVR57wEhEOfWqwrkqL9/07h/SbWwshi6XlDz4hulaX20R3opYfIEPpuC8Xa8@vger.kernel.org, AJvYcCWasq4SPHV/cHWTTq7DNbFYdEEnRsZA6tZ7IN4FqUUq0S74oaot+M2ll8lk39l3xigMXJVKSO+3U+A4@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHn2FKmRKIjEfEWig0anY/p6XzDnTXu1t9qf0EqFwzO2K33ZZ
	4BEXwo0ulPhNlaPUI5UMcao8850EKGxvo9lY8glSvLPYiSI3931e
X-Gm-Gg: ASbGncueWfzS3o44J5FHAFLzajAQoWFWntNc/3d1f7SxyG2Rb3iqAudln9rSm/FuZ5r
	MnVcybDJpo6ITQ36m/Yp4hsZoBpssj2X4iObIQ0FMutGj7SglPBSUKCNqvX+JsV6dmr0ymKh82z
	d7tq45QTLgbZ/JcLlGv89Ub0Dl0z+rHCIuoNMTBhxxXMAWwSWVP4bNZQsbNh010N0tHjXsS0HhV
	QWQcW+x+PmUfby8oPlsixQNs38SAunwXt1GpLWftYF3LuCmSjbYBx8JInxpjxhL0DTJBhHW9asN
	qMUsE37oSZLfeonLB11aC3ooAA==
X-Google-Smtp-Source: AGHT+IFl1rg/QeCIREhZNbg50IZ/OKIksuM+ncImQokSsbydCvH9xhiCosiZ5pbL16uQR8Vu1AXPAg==
X-Received: by 2002:a05:6402:5251:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5d972e63ddfmr65207595a12.23.1736972673007;
        Wed, 15 Jan 2025 12:24:33 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.210.102.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046a195sm7612304a12.57.2025.01.15.12.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:24:31 -0800 (PST)
Date: Wed, 15 Jan 2025 21:24:08 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org, icenowy@aosc.io, megi@xff.cz,
	danila@jiaxyga.com, javier.carrasco.cruz@gmail.com, andy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: magnetometer: add binding for
 Si7210
Message-ID: <20250115202408.ub5f2w4ovygsh2zd@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
 <20250115201622.270130-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115201622.270130-2-apokusinski01@gmail.com>

Silicon Labs Si7210 is an I2C Hall effect magnetic position
and temperature sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
In the first email I forgot about the `Reviewed-by` tag. Added it in
here. Sorry for the confusion.

Kind regards,
Antoni
---
 .../iio/magnetometer/silabs,si7210.yaml       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
new file mode 100644
index 000000000000..d4a3f7981c36
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/silabs,si7210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Si7210 magnetic position and temperature sensor
+
+maintainers:
+  - Antoni Pokusinski <apokusinski01@gmail.com>
+
+description: |
+  Silabs Si7210 I2C Hall effect magnetic position and temperature sensor.
+  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
+
+properties:
+  compatible:
+    const: silabs,si7210
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        magnetometer@30 {
+            compatible = "silabs,si7210";
+            reg = <0x30>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_3v3_reg>;
+        };
+    };
--
2.25.1



