Return-Path: <linux-iio+bounces-11530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F579B3D4A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 23:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D62887DD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 22:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F4201269;
	Mon, 28 Oct 2024 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="vAwdNzEc";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="SuR/92bu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A3201256;
	Mon, 28 Oct 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152417; cv=none; b=G34W7kIcC4CmX2sOAW+vR+t+Cx4kGmCBwOVHEoA1/MwEXTbIawnPP3B4nxnhgtcw6xLV/VISPzDYXoT0FjuFxLw+ih5GTxzKcEONhOIGB/Jx2ZK0BUtSHA7kmY48r9ZmIyqzXdLExQXcY9x1sRfIFGcn7c29RfNq1uTmGy2apoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152417; c=relaxed/simple;
	bh=Th+r5+3QSIZ7aSE6i5V6BvrZ8d7zYPEfyIYgBGD2g2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQI/RSSM0Xk5+KK//SWA/g0wZnmPHgLEUOsKK58ajyRFj82k+1h+jwOPXGqcyFfedDRDZauGd/XclJTFCgQqU7tmMu/qyDbs5UaS3rvaa+9c8Zz3FaWcVtAADyoeqrw/yYUqJlj7/4Heg5yhetfKkC/xDEFFC6g3z5IPU85ALGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=vAwdNzEc; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=SuR/92bu; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id 5d6bc37c;
	Mon, 28 Oct 2024 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=s1; bh=QazBe9UhAdm7LozitMwuoGLTeQc=; b=vAwdNzEcQUXzR44L1U
	go6b7EXoQ/3KZcmeA6oq9BACjnwq95Apdn/Z71xGZh9jvOidnVWj9UCXmDqhYer2
	Gtkwm5g5QziFUr50uyOPM0tgltquc6+PGedITeZ8EDImJJJS9pdab2GiBAgvUy2o
	TQFLHFNXbonR7oCWXkW3ikJ4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; q=dns; s=s1; b=tJGiOpr117B9hTA5HHCzXiFNw+4p7LUHpBeHhhqId2lZ
	ciEiS1wdPJverxJ0Ve+UcBs7x7jN800HvESTudmy8J/YFej+6V2LFk6BUB1VyFky
	9dTng4TZo1CTDajWY5C6w8RrN9W9Lnzu9JhlkZlKnInZhhA1amfZ9cnOJ3Xovds=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1730151472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzyyB9B/qnkH9OcKAyn3UopYThr7PemVvhy4e/2NL0=;
	b=SuR/92buf2/Wb52eQB0wSUiQIumVIAILtl7JBNov/b0Lh9ri9LFMP4muqp0F5tXuztzX1J
	Uyo2ByWf0h0O9trNe23VMVXfeenwfv4BETgDsT0BhtL3Tpa0e6f7rZfSJlk13e5DXOIG6W
	7LJ36F0Q++Epdz37COFbiteuC6ScM8M=
Received: from [127.0.1.1] (host-95-245-34-85.retail.telecomitalia.it [95.245.34.85])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 0d73985a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 21:37:52 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 28 Oct 2024 22:45:28 +0100
Subject: [PATCH v9 1/8] dt-bindings: iio: dac: ad3552r: add iio backend
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-1-f6960b4f9719@kernel-space.org>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
In-Reply-To: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version of AXI DAC IP block (for FPGAs) that provides
a physical QSPI bus for AD3552R and similar chips, so supporting
spi-controller functionalities.

For this case, the binding is modified to include some additional
properties.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


