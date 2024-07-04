Return-Path: <linux-iio+bounces-7320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73878927AA8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E09F1F24D35
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79DC1B29CE;
	Thu,  4 Jul 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LiONSKn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1E1B29C7;
	Thu,  4 Jul 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108662; cv=none; b=PmEwCoNmii91U1kRl3Plvz1g6QbvxD3/L14uRlMsFxS1qQvMi3AeZ8/HaWsV3dx/8EEVC5o12M6b4jutAWpYEiGR6LRqAIcTFeK2b1la9YO07jGV4dl0EsPWrip7uWDWdjptnoMBeATphE+Wh4hZpJ8xQQK9e1UA3NAUe/9Rg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108662; c=relaxed/simple;
	bh=IYhz2hsEWbnqz1wos9gCuQwp37Bn8vY78GHz98gcBRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urL0FwNG5TllDhresGrx/c1uYjl6eQTKrWvSC/qX8LLYMA87nj9rvF3iSHo8PN/p5obBYPnslSUktvxO1p1B6rYDbywVYzpUbVIwSPallrEh3gWOW8uzJNXW6D6GK/khcz4cG7SvrYrfVu1DDK5xG4L2ZBFdFxRb0pNTd73LneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LiONSKn+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464AtXL7027877;
	Thu, 4 Jul 2024 17:57:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	y//AZcnOFbO0AzHDB45XoYZWlI0kyd40ITyF2/S/9K0=; b=LiONSKn+lEYClyZR
	YBQKOR5MAv7YQr++bzqYUUSi59hgYA3rgSF3Bi3Y5ZKIXlUn0dZ4KeXJLjulnrWX
	XsGCVLaSnCGpQ1HbDC9kfpqmgWrN0/i/twnnh2MHvaNtTHZXpBeMP9XzaaS/Uj6i
	TwFz5TJc3PnAfCBtwIAQ0THdOtm4fMBRYvgWVQ0H8GkkEBXdkhPpOrN0fMdt97E2
	df3n3WX9vlmVvLFkN8oqwqs+D1F7oYzQSAGQj+/YTW24SPsvJ0QdTeowpDJ7bZNC
	X0qirLSFFCXSbmsMT+TO9F1CYKAtFvJ9i52JHh+HHjcOhsvIns9kqwnM8hMC86xf
	yoQw0w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402w7jbg34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 17:57:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 72F0E40044;
	Thu,  4 Jul 2024 17:57:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE8E4229A64;
	Thu,  4 Jul 2024 17:56:49 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jul
 2024 17:56:49 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/8] dt-bindings: iio: add backend support to sd modulator
Date: Thu, 4 Jul 2024 17:53:33 +0200
Message-ID: <20240704155338.2387858-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01

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
 .../iio/adc/sigma-delta-modulator.yaml        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
index cab0d425eaa4..3f682d95d807 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -18,18 +18,37 @@ properties:
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


