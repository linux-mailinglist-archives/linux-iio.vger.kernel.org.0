Return-Path: <linux-iio+bounces-15144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE81A2CDCB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938EE168B52
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD1E1DF255;
	Fri,  7 Feb 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="erZFKx72"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242871DED6F
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958994; cv=none; b=FhNQmn8MhOBwo+zKONlV5rRDFPdddFP3KtVaZ3YZ8SN0S8ihqsKNWzbISpVSs6bPyXatee81pGc3R5rY1uWCR4Kz8S4WThMheJpsOYfab/AM+EH1UqrNBy8fvlzCXCLbYruP5MNEyE1MLRQYKxUA09pIddbSWtKXmIgR0VlYAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958994; c=relaxed/simple;
	bh=NDFiO3U0E1S/5X6Lz//TxxrYJLqr6ccKrjn8lgZTJIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLSS98uHD5zHCSDHnBvzgPxEelhDaLP3cwH9C3cCD8jAvR4Fh1kT4lodB/ITaKLfFWueJ/JixQdCsqybyGZGo59qsvai66B3q8OSz+R8qpCORvlHxTEBn4BsDg6IIvkZ8F48S9PJofuCj9l+F6bgblMGFUuynh7FyWKXINbJpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=erZFKx72; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2dee7d218so1163920eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958991; x=1739563791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iLwNjuSq2Wrxa12NE4/8IEuSETMFdqrFjSUkFlmHIg=;
        b=erZFKx72jNL8sn3fAjUiq0GvK52KR+iWUPdFTDsNz3v+dBI+sVh5pCH28qyvKAb48U
         hGc82+B5qZZRHzpSWkJoyeYUwwezp38vZ00D3RW+LV2Yfh84LotZ5EXUFrx0BkNMYum6
         mFsh0lYsnRh3EfPnEC1zMdA1MCpmDqaF96XJjH+Qo2QCKZXdMpFzFTz+xXQktfSCLU02
         CAclZ0qq/SlNi65mUcbg1kysDayiODUZ+ZCOAHV2wMgWu9SKHOoKoNw3hCq8uoSi2PSf
         ED/RtUVe0w5nVQqUP4xUW/pmFOCaZDL300IIl1HQSNYDQO/IIUzFvAGYZM6K5Qzf5s0D
         GJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958991; x=1739563791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iLwNjuSq2Wrxa12NE4/8IEuSETMFdqrFjSUkFlmHIg=;
        b=p2xJhJciJU/l3SCiMV6I+wHZNDnG11tOfxQNvKUrYH57eoGroshllr0N1KjWLW8F7t
         ZcxSJmngcUo3zYiWmvJ6Ng3Y5K4hSxakP2zstuAdddkMJBNIhn2D4OKfEW9rxHlHbCt+
         E+qBLe5byW7yEMORIz65ZUb9bsqZ/msuMC3YLHicfEjzPyKbZQO1i8AjmXTWnFY8ypqG
         2pYfrj+7eTHrt2uSVKyOWkqc7HAFa1nDQxae7ItjS4g3xhen5rgzwkAD19EnLZ3jYJ0W
         6w68SETnvhEz/Blh++c3IIvqEfYblRHTyoIl2l1CChqNFQ8H3aQK/UIPV1f+VOm+gS5m
         1+sA==
X-Forwarded-Encrypted: i=1; AJvYcCXQFkBIgPK5wOZ02/P35ZNJwmRyT5/i34qwIVKXXEEfDVNdCXIXMmrtZUmBK8WR8pRceDi0Hd4C2Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcmInvuXUj1QVtSiT4E2GksxlIpRjyrlXQtdA+HwCrc6oiyee
	RDBLGWvoTjkZFPELN1iDASJZNwOiNYtJeiRPf0kqcDFdM7jeH9P0+fHdftrMmPo=
X-Gm-Gg: ASbGncu1x46Yy4T98HcZzbq6VswSuMXv2xlDV9OKHzwd/qwPzfoWCB4WXqQtTViGDNN
	kgTdA11TSp9puaGqi/qQgygTI/7eYzAEliUR193XYyhwRBGhrga0PBzzddqiH3nfk03eNJEtqkT
	iQOfgXjWvpERUCETC/7DZkiUq85pKJON+j4UgUffUtI5RuxRBVUl8A1NrwgI+DuKLkO00WXUsmf
	NJB/YhTZSSbOIVSNsiN62GUJrJYGxxhatKmUs+eaawXcEaoU8ZfcWzxH5C0s9ZVnVloMLdx1t38
	EjR1dxQAXNbvAuD++QQoyTvEwTeIfHsVyAQ4HtxZ9NBdCLU=
X-Google-Smtp-Source: AGHT+IEsnyzcKsdTR3dUVyCVYzDHv54LzczlPeqEofvxzLvMfRB3mcsdxkx1bczd7e2abrb46nmuEQ==
X-Received: by 2002:a05:6820:f09:b0:5fa:1ee7:1325 with SMTP id 006d021491bc7-5fc5e746384mr3223073eaf.7.1738958991033;
        Fri, 07 Feb 2025 12:09:51 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:10 -0600
Subject: [PATCH v8 13/17] dt-bindings: iio: adc: adi,ad4695: add SPI
 offload properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-13-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a pwms property to the adi,ad4695 binding to specify an optional PWM
output connected to the CNV pin on the ADC.

Also add #trigger-source-cells property to allow the BUSY output to be
used as a SPI offload trigger source to indicate when a sample is ready
to be read.

Macros are added to adi,ad4695.h for the cell values to help with
readability since they are arbitrary values.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Drop $ref to trigger-source.yaml
* Add maxItems to pwms property

v5 changes:
* Added macros for cell values

v4 changes: new patch in v4
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 13 +++++++++++++
 include/dt-bindings/iio/adc/adi,ad4695.h                  |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index 7d2229dee4441e20a7bafc9165fe309ac2e9eada..cbde7a0505d2b5df22c54ca4556878bf22e9b4b1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -84,6 +84,10 @@ properties:
     description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     minItems: 1
     items:
@@ -106,6 +110,15 @@ properties:
       The first cell is the GPn number: 0 to 3.
       The second cell takes standard GPIO flags.
 
+  '#trigger-source-cells':
+    description: |
+      First cell indicates the output signal: 0 = BUSY, 1 = ALERT.
+      Second cell indicates which GPn pin is used: 0, 2 or 3.
+
+      For convenience, macros for these values are available in
+      dt-bindings/iio/adc/adi,ad4695.h.
+    const: 2
+
   "#address-cells":
     const: 1
 
diff --git a/include/dt-bindings/iio/adc/adi,ad4695.h b/include/dt-bindings/iio/adc/adi,ad4695.h
index 9fbef542bf670015c5b34bfbe1336e7e295bf8ab..fea4525d2710cbf58cd4236d3276bad4cb318df9 100644
--- a/include/dt-bindings/iio/adc/adi,ad4695.h
+++ b/include/dt-bindings/iio/adc/adi,ad4695.h
@@ -6,4 +6,11 @@
 #define AD4695_COMMON_MODE_REFGND	0xFF
 #define AD4695_COMMON_MODE_COM		0xFE
 
+#define AD4695_TRIGGER_EVENT_BUSY	0
+#define AD4695_TRIGGER_EVENT_ALERT	1
+
+#define AD4695_TRIGGER_PIN_GP0		0
+#define AD4695_TRIGGER_PIN_GP2		2
+#define AD4695_TRIGGER_PIN_GP3		3
+
 #endif /* _DT_BINDINGS_ADI_AD4695_H */

-- 
2.43.0


