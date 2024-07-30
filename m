Return-Path: <linux-iio+bounces-8053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF7940C33
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD82B27959
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A6187337;
	Tue, 30 Jul 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NO5CVZv+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B89193081;
	Tue, 30 Jul 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329332; cv=none; b=j5fZsnBsRjJkBsZlUcy+oCSof7a+6J8e4OsLX4dQDpmRTINu32HdMIakj4/b5hN1WHwgozeIQ3qIMq2p/Kc5yLTssUQs0bC6HlsDnMvdw6TBZLf/sM4AXC/JjY6wE7L743EDGtA+w1w+QBF7cCix91lY1jyft9wzhT9jMugPldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329332; c=relaxed/simple;
	bh=ffmDdoUjgHPvg4ewDokiYbFtdZGQEaM/ClDFB8mPSRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiEDI2bYmFmcuZx7ssd4uQbx+cDhjPp2jtqZeL/E0HBXAwrNXjMCkoae3Mv+v0PlpeKPx9TzqD9Wu5p1J+Mvfbm/rJK9pgSgVcjLiO2afMtP2JsuyojKhfN4niCbEioK33HBrL5GiPlkiZovwJCLBCAKDCMmRjRs5/zKkvAs+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NO5CVZv+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U6J18G032156;
	Tue, 30 Jul 2024 10:48:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pOMnBCNMQO6/J87ZVDIkr7Z67cShz0Qbz+Wxsr7PkWI=; b=NO5CVZv+Fq9f7Rni
	6LaGzbbTHPqZsONijyuK62ssDKVZZxgmBpQ+Km1GAy32CpkaJUsL2MA5KxiD0GDe
	L6DnpFZfvEfD/427J/wxrj4Fm23nJCEkJamUPFv5F/TrllrnyLP1OmY3Np+yBQPC
	+gIWgxPBiI5ItHpG7/Emr5HB7hfAOSHhsjz0GJs88alu/Ojqj/p9iAR2GUAQIRQV
	Qs3lwUppUthxgAVwiWBIAtXG+1K6i8otOD1qwCH24Tl+WHMV6VMcN2va8ZVQo21I
	sR6Lg7hLtbszuESmeXCTY2MEFCnRDuaJ1T4EugiH4EbxW1HvMiODIy6ym7o4sAbK
	Jf/j4Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40mr7wus53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:48:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C68AE40047;
	Tue, 30 Jul 2024 10:48:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8473A21ADC6;
	Tue, 30 Jul 2024 10:48:20 +0200 (CEST)
Received: from localhost (10.252.3.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 30 Jul
 2024 10:48:20 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 5/9] dt-bindings: iio: add backend support to sd modulator
Date: Tue, 30 Jul 2024 10:46:35 +0200
Message-ID: <20240730084640.1307938-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01

The legacy sd modulator driver registers the sigma delta modulator as
an IIO channel provider. This implementation is not convenient when the
SD modulator has to be cascaded with another IIO device. The scaling
information is distributed across devices, which makes it difficult to
report consistent scaling data on IIO devices.

The solution is to expose these cascaded IIO devices as an aggregate
device, which report global scaling information.
Add IIO backend support to SD modulator to allow scaling information
management.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../iio/adc/sigma-delta-modulator.yaml         | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
index cab0d425eaa4..7d33c4e09905 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -18,18 +18,32 @@ properties:
       - sd-modulator
       - ads1201
 
+  '#io-backend-cells':
+    const: 0
+
   '#io-channel-cells':
     const: 0
 
 required:
   - compatible
-  - '#io-channel-cells'
+
+anyOf:
+  - required: ['#io-backend-cells']
+  - required: ['#io-channel-cells']
 
 additionalProperties: false
 
 examples:
   - |
-    ads1202: adc {
+    // Backend binding example. SD modulator configured as an IIO backend device
+    ads1201_0: adc {
+      compatible = "sd-modulator";
+      #io-backend-cells = <0>;
+    };
+
+  - |
+    // Legacy binding example. SD modulator configured as an IIO channel provider
+    ads1201_1: adc {
       compatible = "sd-modulator";
       #io-channel-cells = <0>;
     };
-- 
2.25.1


