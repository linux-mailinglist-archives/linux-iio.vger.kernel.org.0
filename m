Return-Path: <linux-iio+bounces-10336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653C9953A5
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D511C25726
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2B1E0B6F;
	Tue,  8 Oct 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DClRlhns"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24EA1E0DA5
	for <linux-iio@vger.kernel.org>; Tue,  8 Oct 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402311; cv=none; b=NogJnVTC0VEQL6Ji/Z9Lx+naW/6v4Wc9oaS9Xm2+4q30K9nidHgA472KzcBxKwkoFMPskFEOGPIXd4r1EKlOoLa45T+xC10jHSA57PaE+TWG0v7m3T5W6S/S39Nvs5XcU8S2tRJQXAtA8LXJsAXiHEoUlD21ZFPMlzb0YJCNeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402311; c=relaxed/simple;
	bh=MA2oG/y7V1+Goz7xziXlVN+hyrEb/+ZFaEcTpQoHM1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6O84PjT10J0Lazyh6a2rrQbQ5KVNDJlyF5P7r2hZrDEYnTInsO5xXiDdG60owP7AcOBZU0cgw/q1MgmuLGZxUUR2S3Nrcl5gJnnr7bJJ/4Lr75gx+ZkXJTPRZjVufPKl76sZkSqyxldQ3p/OO1Pr71JUjT0MKs3tWdTLkjdrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DClRlhns; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so51172335e9.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2024 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728402307; x=1729007107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3Jl9+VGm0G8JZ+DzIDolKuvv4I1MhBsGUOVMggicwA=;
        b=DClRlhnsnWEKjLBwHL6DSRuhuchX45OprSLToUhrFUWl9/Zws2RRmoYta5N5GvxtAR
         kBtEwy1VFkJeg1N71mLfPn6fbsiOuWYVOqRd44Zs8Pswo1Qlofa/NTyPHs9z16/0WB1Q
         1z2xt2FjW6Jnxa+sTh51h4jpJ4BN62tAP3g8kO3iNJFoobL0Eih7sKzpGrbyhycoirnn
         v3UzqVpFDxNkRSY1jbSTq7NvT/3UMzVLQ3tgZwP0M17RM8L9EJYr9Wj6rWq2UB49IT10
         vV2ug32LdsMekaDAJLrzhF0Lc0LOV2DOR081EfznnNFyQe4o9dmq0rgTV8kHdn9pmpj3
         oblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402307; x=1729007107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3Jl9+VGm0G8JZ+DzIDolKuvv4I1MhBsGUOVMggicwA=;
        b=fSsDRoxrcSYBwT3Zksc06QFW+025xXIaSpu/L339JObWmuWk2zJz2y1SM7OAJCOu/B
         k+82k7734nWOKmvKuoxHlJGaO6LIQlcGvtLxlHvDzXc3AppsmseTgFFl299h9bIg3C99
         tfKV6j5Zxuc7xyRZyVIAOgngW0uQdyJfJJlXKwenVB3SfNz7/lsQ8iWufVFx4kpfqo0q
         vuEgcomjwLJ86V6IILA6yerRM7Rb2vzDiv+j0ZEMIc1snxmlxDJowP3RBQ3e9a4CyHRY
         eFVYDEjYdbfBoPdgYcVv9O7gzGOSr392NbqMmQ8sjIBFw3CU045spR+EFn9CJ/KraP1s
         ykTA==
X-Forwarded-Encrypted: i=1; AJvYcCUoPNi8sYdzXxTOVYCL8GSze1D7hiwhkV8aqT4AFUQlvz47k+WDZJ14kVWaiOiPB+TiGLF85bYll70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBhIoUHnyg6SZ8vpU6LD/4jqqvLtDK9q+Wcp8RK8m9tVneXpY
	v9Tu3c09nRJSwhaIzrKPbMJpif4V4wbrIqF56YQl1reAQ5T0cvf7VGPhDh/+SKEWBv8aITHmtjD
	c
X-Google-Smtp-Source: AGHT+IFTTp9Kwvcs2xJ+U6HUZRKGCT3W1lMSPqgUuoJ5EX5vkfG97N5nyHnKMjxheMGueY3l/d9DZA==
X-Received: by 2002:a5d:5e0f:0:b0:37d:2e39:9753 with SMTP id ffacd0b85a97d-37d2e3998e7mr1296396f8f.8.1728402306981;
        Tue, 08 Oct 2024 08:45:06 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d826sm129591215e9.26.2024.10.08.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:45:05 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Oct 2024 17:43:35 +0200
Subject: [PATCH v5 03/10] dt-bindings: iio: dac: ad3552r: add iio backend
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-3-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dletchner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version of AXI DAC IP block (for FPGAs) that provides
a physical QSPI bus for AD3552R and similar chips, so supporting
spi-controller functionalities.

For this case, the binding is modified to include some additional
properties.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 41fe00034742..2d2561a52683 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,6 +60,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      Device can be optionally connected to the "axi-ad3552r IP" fpga-based
+      QSPI + DDR (Double Data Rate) controller to reach high speed transfers.
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -128,6 +134,7 @@ patternProperties:
           - custom-output-range-config
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:

-- 
2.45.0.rc1


