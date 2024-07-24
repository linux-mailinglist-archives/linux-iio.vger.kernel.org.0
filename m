Return-Path: <linux-iio+bounces-7849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FF93B3EE
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118C6281D9B
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15115B995;
	Wed, 24 Jul 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IQB3RJHv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963D15B102;
	Wed, 24 Jul 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835564; cv=none; b=FViihi/3FATzxLbKAx/oWsYrsz+U+zktccAWJUe9TdOWikXHiAMFdtIi2yVX376jjEsYWbcFA6T4FCUtLrSVx2tqjKu11mMa4FKe4hiCxM4NaZiHffvnzVyXHddi9gQQcw8KfIEJDCXxObiRTF4Lpr3Xb6pyh1evA1JMYLdO564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835564; c=relaxed/simple;
	bh=yeQfMN7yreKLnANCDTFSWDaOwTj4sS65J0sKMCzIxVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXZHI2QcS65xI2cukZOpEJyX50lmDDCKdLaDvj7bhAW0OkQB9MTDg5DsZPBqamq5aqBJ4PWijrkXNDkBx39zat//aeODc+rbheWp9QGzjthnXFua5jV4/mvI9tI5+FSRCILHgjICIAdzKo33WPaAmbf3PqVJMzhQMdCGyb5UJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IQB3RJHv; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OBxQ4Z007183;
	Wed, 24 Jul 2024 17:39:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	L/C9dHL921+AiIjkcSXro2gpQoD393DjMVEmput5l44=; b=IQB3RJHvYXrc/tf9
	YE+ZF0MGxykUYkwDM1oEx3n8U+SxHACF35UZAQThJHPh7wOQ02TADEanHZJy4atE
	xo2sfwlv1Epd4/l3+Mf553I3hVy/UXrc/ZvgHLFYwpKnwEEJO6HN9ausoObYQkP7
	3bn54R01iSiPA2Nemdu3DCZ81FaPhRG+tGthnXa9UmYIin1XmDqxGS8H0KwVFQqS
	vo6qm8u7ExpPY1zGldogZJYolikSDw6ZXCg5s33YmfxBhHlcy8WNutpXTYMbD/qF
	ukMP3Pq3+ZkDsS21QiG269as3euAY3Jb4hej+bz5VBRfN/6xgXcoMZCt0ZPe2SB1
	O6C3Dg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40gpt16a12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 17:39:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 407F940045;
	Wed, 24 Jul 2024 17:39:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00B2A2414BC;
	Wed, 24 Jul 2024 17:38:33 +0200 (CEST)
Received: from localhost (10.252.12.39) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 24 Jul
 2024 17:38:32 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/9] dt-bindings: iio: add backend support to sd modulator
Date: Wed, 24 Jul 2024 17:36:33 +0200
Message-ID: <20240724153639.803263-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724153639.803263-1-olivier.moysan@foss.st.com>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
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
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

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
 .../bindings/iio/adc/sigma-delta-modulator.yaml | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
index cab0d425eaa4..b245971fecb0 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -18,18 +18,31 @@ properties:
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
+    ads1201_0 {
+      compatible = "sd-modulator";
+      #io-backend-cells = <0>;
+    };
+
+    // Legacy binding example. SD modulator configured as an IIO channel provider
+    ads1201_1 {
       compatible = "sd-modulator";
       #io-channel-cells = <0>;
     };
-- 
2.25.1


