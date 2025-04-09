Return-Path: <linux-iio+bounces-17847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0542EA81B3F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 04:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30831B81841
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 02:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D519319D074;
	Wed,  9 Apr 2025 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2SlXOkf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C81990CD;
	Wed,  9 Apr 2025 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166700; cv=none; b=i4MJ4ivdMOp9bipNgbzfRkac/e4ZwHAv6eMsF2CL9RECXSKc+3rA39XBh4JJERd+ruXTGKbcEAaI2rrAiG+2Jy46ghEInRBcAlrZ0jCcjLbsrfLk2+r4+uJN0hN0zxCPIiVsrj696V3KVsgefxs3RgB0rYQ+wI9yhM1METmtYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166700; c=relaxed/simple;
	bh=b+/tUCLGxdbi91376Jy61UV3WZtfeFIH0dAi/gCpA9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZxUErdHTVA0tpoXiuc4ucwtMd53oVtDo0/alpyT0SciXwb++RfB5ypX03QSM7sbnjLrds6cxKxFvBUB1NA6QfScL7LdneHE+Adn5/uLDrQ29o3TG8p1Sh9KdxvLDybzqcmW4s0VTymBZmjIfjCsayJaWDwZHogbdYm13VTZiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2SlXOkf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ad5236e6fd6so5729539a12.0;
        Tue, 08 Apr 2025 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744166698; x=1744771498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20XJ+Ilq7bm7Sy6IEU5Sip+0wAc16SX8KYqgavA9uhA=;
        b=I2SlXOkf0uYpj//iTYZGTN+T3s9EhstqRJGM7flMx2ns53VzpgX3cyY4uXvMQoZKqk
         Gwqwo3Egt5s0F33nhyrI5D/i8Y0vbw48EXIAAIsowhqAIe0bbXNPUW6NJWaMacwszo41
         ODXfCRbGI5OGQ6je8ejK1FMdp/OwtB2wFEJXex0c1x67mqhi6WXPeXedGulzQPMPKUQJ
         QAI0vvG2HU79h/e2/CGVrkCIdaHYXMKMruiWB+5GZVp37XXuVUUuaiYSWLPSjPN4FzaD
         rYPWfa7vRBM+zYElh/h1SWODtX6+X6eTIDjflkcf9oS7PVJkpdueqZrnkx1VYp8sBOf4
         IgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744166698; x=1744771498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20XJ+Ilq7bm7Sy6IEU5Sip+0wAc16SX8KYqgavA9uhA=;
        b=bYv5sHsWdzcL+eQ6yFQjSgZKT/7O93WqvCVo0itRXb8ByhBPup8Tl3nSRBdHDMSJkq
         +sCsl5xYHj9JB1haz7tLSZ1C9APuUB7ifzxulHKQ+ICX45icXNwxS1RDnBHFxc3ane4V
         PZeLPoa9QEm0I7Yf9erPiWyQoK9tn5AE0sRfLZ9fmUFVquARKR6J0M/Se4BKW0+w9Tdg
         0lWqYXHtK1Pxw3YpEuT0pQYtvAdnUXGYT2WudesVe7NTEXw2OZ2MwJFtkH0eXnBZrPM3
         cZIys01JUbgP/0sNLv2/YMmc5MivT22IkHD/DdIOYneIzMLSj6VpF9xOU4w228onATLV
         RTkg==
X-Forwarded-Encrypted: i=1; AJvYcCUG4388xaa1LzL3GMrkWVTtwzxJlLcFmwGCp4vuKcDdFxOmbSIZkDnaR82vlTdjfhTDg8mVmaCBlIVm@vger.kernel.org, AJvYcCX5x4blIYHQBtERYxRvv4etq92qefPgiz1zmLZIst1uKIhCgjDELvRovkIlFOGDA250pR1KoqZOpWHW@vger.kernel.org
X-Gm-Message-State: AOJu0YxhA/0V1BMGBNoWBw0E/tRWpwrL8MDJypumninxVSg10Z3Rc0gt
	cJhw1o0cj9JoK+PyeMTk5R5eE3wEHs3lHjnAhAjsH7/tpPAH3Sts
X-Gm-Gg: ASbGnctCRhX4Y0yZK/TCMfIfMfERNtF0HAMPqJ1zLPR34WmxLVyRicOlxY/YtrNpVjb
	0jarBp53T58wgBTL0ygvG8TpMwVRgdUJA704MIaGXtGtJmmUcKH4ZIbEbCgMr38Qga6lXEbPui3
	lu3hFtio02LwwHbPBXAdGIKyU8LBnH/bsvVkRu/XuUDFhtEfO94CRhhYU6bp9XWRn20B3nf3FA5
	r4lYAcbm96NXSZjNi9+cBn3yWnCzSkpz+JNkF8hXD7MbXtpmFL/vx2Y0hg2v/tQUJNUEoi96658
	nBsgEfOnp3Dy9J+2sI02PdeHBr94XzN4NVt+nMPVmS06HcBo64gGag23Zya9
X-Google-Smtp-Source: AGHT+IEzmvKt+MEu0yKl0z+bAeeeLtKUkoenQ3RaabC23+MPJbmr5jNNqVdASM0oaCVsFQhvfGtVnQ==
X-Received: by 2002:a05:6a21:350f:b0:1f5:a3e8:64c8 with SMTP id adf61e73a8af0-2015b01fe4amr1286065637.36.1744166698459;
        Tue, 08 Apr 2025 19:44:58 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b02a2d3abffsm114028a12.48.2025.04.08.19.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:44:58 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
Date: Wed,  9 Apr 2025 11:43:09 +0900
Message-Id: <20250409024311.19466-4-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409024311.19466-1-gye976@gmail.com>
References: <20250409024311.19466-1-gye976@gmail.com>
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


