Return-Path: <linux-iio+bounces-7853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD593B3FE
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D7D281D7C
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81F15E5D1;
	Wed, 24 Jul 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f3BjWzMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098FD15D5C4;
	Wed, 24 Jul 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835626; cv=none; b=fshB1phUtRJkM+z1RPvPi6PpHVSM7b2buzphugznS6pmlU3xiXRVl2vzpxX+SRXVasy38c9WSms38CZitNiLhzPenDurd3haTcC8Yo9RzOFMeJF9C5y5mLDWQZSv7+if7XtsAdpa3vS0wS4GoxLTOYC6Gadw8QofQRrzZoqZYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835626; c=relaxed/simple;
	bh=ACMw6OrhWT8DLEUSXg0DCsjt2bgw9R8f1+y3yiiW0WQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLnl+sr4mQDjRwwFdJ/5+dOpHCDhV+c8dNDfjP4XAWiCYky/A7qAGTf+doZi5gDj/bx3rorpitq0Pj9VH9MSr3kYWC/nmWombMwFr0rdTmjXA8vob9K9xDRIO0KLMpbZfBgq8sgPKp0H6sq2MHYlSzA8W0+lkjahnkIxS6ior6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f3BjWzMW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OB3vlm014224;
	Wed, 24 Jul 2024 17:40:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/npYISOct7pomZUB0oHtp4IjfuX37MB3TRfqf89/z2s=; b=f3BjWzMW6NZ24H6x
	ByQ6OqAbEGCvYg9/4qrE1doAG3O8UuMv1X3elOKrJDzaVrxL9BebL9+Q6wu1vWvA
	WDsjDOyoZ2tfWrz+qdBbpto/oZLTquqBoV5/+DR53uzWHtZHbz43slvL19dKAlFC
	rBaIRksZfN6uTirX9dF2cZnZR+qLPL3cq6bCFSXJbb0/Y17weY1ssswO9dxG/kf7
	iTtLTRTjn72gvecqAbSvrRSXjZBLLy7tGqj78QmSJ5qSWLjS5/HhBUV6ar0mkDTT
	Jbb6XRujufwUP9Zl4Ao2pRmBz/xoDq1i8I5zzeDaCSNQr3ZGRNFPukJBT7EJqSpx
	EJRwIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40g2nh87s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 17:40:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AE50D40050;
	Wed, 24 Jul 2024 17:40:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DBD8241B41;
	Wed, 24 Jul 2024 17:39:34 +0200 (CEST)
Received: from localhost (10.252.12.39) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 24 Jul
 2024 17:39:33 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/9] dt-bindings: iio: add vref support to sd modulator
Date: Wed, 24 Jul 2024 17:36:34 +0200
Message-ID: <20240724153639.803263-7-olivier.moysan@foss.st.com>
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

Allow to specify the reference voltage used by the SD modulator.
When the SD modulator is defined as an IIO backend, the reference
voltage can be used to evaluate scaling information of the IIO device.
The reference voltage is not used otherwise.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../bindings/iio/adc/sigma-delta-modulator.yaml           | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
index b245971fecb0..ff04ae08f264 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -31,6 +31,14 @@ anyOf:
   - required: ['#io-backend-cells']
   - required: ['#io-channel-cells']
 
+if:
+  required:
+    - '#io-backend-cells'
+then:
+  properties:
+    vref-supply:
+      description: Phandle to the vref input analog reference voltage.
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


