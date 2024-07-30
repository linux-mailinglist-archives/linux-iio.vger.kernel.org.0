Return-Path: <linux-iio+bounces-8058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99756940C4E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4971F20ACA
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6581946B3;
	Tue, 30 Jul 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zDnKHrY3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383419307F;
	Tue, 30 Jul 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329421; cv=none; b=gEoMM947Abgv2vFKa4RLzU5bqaIE7pDB35CMX59Lcs1ISeQg564Mf52fLVqvkzuh3PyS7bUtQUde6tCEU1pl2ZeaVDgeEC+3hGjLj/Kt9eiwIQhVDC6dBpkd+tRg2ZkN0ekJOZWusDVVZ/UCUATPXxUfemTEWJgnwoWBZ7Ou12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329421; c=relaxed/simple;
	bh=TT6n1Bp04HEB8H1kcNVG29zae9hkvgT9KFgoJk/nSzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NInFiG/uUekCeGV3fy93gaFfP6/oX0SrTKoW/2ZXjQYm0apCl+Z71uY0WENupAV90Fb/9VJWhlkIwxhQ9hYdvGKKZuLX2i4IinTtvXRvvgncaqGsrGH/VDBDtoCNENRg1f1UFL7nQPqzBrckTZhdleFA3Bpfv8P6FQIG2iQ1ueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zDnKHrY3; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U7t3it012259;
	Tue, 30 Jul 2024 10:50:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	I0Zk3W8fI6BDHrh+oPXqCLcodJSbvz4vjqIf/DKXxPI=; b=zDnKHrY3lwZJ/lVA
	zQlclsBEk93jgi57kjXa3tlw+Kv2I0HQVU8KNG4PpwgLyH5js2byE89IP2wuQ8+w
	ApTeJKq9kSgSv6SUAHCXxYsyj9xp+AJobtziQ9llL+tNgb2BsEu4d6NrdqmllRec
	TU/Lku+OjZo0gKjV1NGQV39fFFgvFYpz1cKb5L3WSyaVZKYzhh+oC8Tl38Sk04VY
	orRsZcdezFOvJTIlajKnsaWxj6OGYV2jUqa84D5/9QbrUDl8sBDVw6XjWnGTUDwS
	uJXvUEzmuEIIAxxx81Po1VKqQIis6HZB4Dg7tVzXBejuR2ObYB1fF+xAAmzPg9g4
	/spQDQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40mr7wusb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:50:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EF68940049;
	Tue, 30 Jul 2024 10:49:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9C82B21B503;
	Tue, 30 Jul 2024 10:49:21 +0200 (CEST)
Received: from localhost (10.252.3.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 30 Jul
 2024 10:49:21 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 6/9] dt-bindings: iio: add vref support to sd modulator
Date: Tue, 30 Jul 2024 10:46:36 +0200
Message-ID: <20240730084640.1307938-7-olivier.moysan@foss.st.com>
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

Allow to specify the reference voltage used by the SD modulator.
When the SD modulator is defined as an IIO backend, the reference
voltage can be used to evaluate scaling information of the IIO device.
The reference voltage is not used otherwise.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../devicetree/bindings/iio/adc/sigma-delta-modulator.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
index 7d33c4e09905..c3a116427dc3 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -24,6 +24,12 @@ properties:
   '#io-channel-cells':
     const: 0
 
+  vref-supply:
+    description: Phandle to the vref input analog reference voltage.
+
+dependencies:
+  vref-supply: [ '#io-backend-cells' ]
+
 required:
   - compatible
 
@@ -38,6 +44,7 @@ examples:
     // Backend binding example. SD modulator configured as an IIO backend device
     ads1201_0: adc {
       compatible = "sd-modulator";
+      vref-supply = <&vdd_adc>;
       #io-backend-cells = <0>;
     };
 
-- 
2.25.1


