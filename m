Return-Path: <linux-iio+bounces-7263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2247E92659A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC4A289366
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367B1836D0;
	Wed,  3 Jul 2024 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WuZEpSdb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B62181CF6;
	Wed,  3 Jul 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022906; cv=none; b=KEGPhuq1In/TUkXdVVVdIGl0RnJzsi4F99z1A+Y4VGYGxYlaQDBMizZXXiY+FryFjLObAcd+Q1UuUnp6D7/Si/94iuNn2xjW5UJlyhHxNKrcHd8psJsIY7s9yytBu/Pl/qnC79W7/EDN2OElrpiStVS3ZtoCIZztrDsSDfxVZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022906; c=relaxed/simple;
	bh=7BaNISH55n/A/MVA9c++n/zTtTouz5E5BL82HUun+bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb/Z6a123ES30A6oTsstbCRVPRZtvp/JEya6HKuX6l+9c/KCGaRKQpcYX5m363vvRkpvbD2o6FvvVKpjMsMckEbKzqFdq1dUBdfPzkO5dFQ9KOpIi5MfSBLD4PkX7KuXQITOb0mGcpEBQLzgTRwjmxLJ+0dQi1TvJBvLzFFof9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WuZEpSdb; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FtSDj024015;
	Wed, 3 Jul 2024 18:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	P+kNXBwzIwoxxa4OyxqdIx5+Zo644vt/ZB+ntrLN0Ns=; b=WuZEpSdbcUXBU1Ff
	HPXQfgAl3nQSUnwv55nc8rHvADFKNtYeApr+aOCwXlu01xEROOu+a5V6l/pX01Ej
	/Y2hyTe/dUxKv3haIzTHfoCwHAG2jQxLQ+ODads6n+/qK14dxBJtossQ2n+wLjH3
	q2KTi8cLHW9mDNt3ERzIohzpNUSxpXHuu1gtCVd4H+MJUIhDWSZ0AFy2NVx2aoee
	adIePkC0yny6Xjik+ne2359vk4plTvnCwqgN+DfOImUyBKvV+dWhTmJ5U/vQB5Ne
	Z7yG5rU2z1wiVAnNBDYmCNmSfQki3b2WX/P5rC4DHLfIqpwwp403FPAFVrmCt02I
	/b+Gtw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4029kx1ggf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:08:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0095D40046;
	Wed,  3 Jul 2024 18:08:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A28E02291B2;
	Wed,  3 Jul 2024 18:07:31 +0200 (CEST)
Received: from localhost (10.252.27.110) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jul
 2024 18:07:31 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/8] dt-bindings: iio: add backend support to sd modulator
Date: Wed, 3 Jul 2024 18:05:30 +0200
Message-ID: <20240703160535.2277871-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
References: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_11,2024-07-03_01,2024-05-17_01

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
 .../iio/adc/sigma-delta-modulator.yaml        | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
index cab0d425eaa4..e34aa560da63 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -18,18 +18,38 @@ properties:
       - sd-modulator
       - ads1201
 
+  '#io-backend-cells':
+    const: 0
+
   '#io-channel-cells':
     const: 0
 
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: Phandle to the vref input analog reference voltage.
+
 required:
   - compatible
-  - '#io-channel-cells'
+
+allOf:
+  - anyOf:
+    - required: ['#io-backend-cells']
+    - required: ['#io-channel-cells']
 
 additionalProperties: false
 
 examples:
   - |
-    ads1202: adc {
+    // Exemple1: SD modulator is an IIO backend device
+    ads1201_0 {
+      compatible = "ti,ads1201";
+      #io-backend-cells = <0>;
+    };
+
+    //Example2: SD modulator is an IIO channel provider
+    ads1201_1 {
       compatible = "sd-modulator";
       #io-channel-cells = <0>;
     };
-- 
2.25.1


