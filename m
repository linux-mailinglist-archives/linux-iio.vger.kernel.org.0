Return-Path: <linux-iio+bounces-5988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C998FFFF1
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13142842AB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D3E157A56;
	Fri,  7 Jun 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="STmvo/D7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C8152511;
	Fri,  7 Jun 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754352; cv=none; b=i634h7trSAeCJvE13M3Q5L9SexdzTwFXCGwlyzDYc6BIcLi/aepPXL4HYiFyJ67zFS9cDbPEW33bRlGNKCwBc6Y/K+zDXZV0OWaz9aDF0sZjCSIC36PG0+4I47pvPfFfxwvSoAZaPcbwuXmAbLwR2cP/uoS6t7mocSvh8A80+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754352; c=relaxed/simple;
	bh=5J3JJRK29K0dslcOj1N/uvs/sgKzOFZ3FxanzmMPRuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YTgnpiJcArjCy8OkEllYHsbnTPz+S+PIbFhhQSmPQWsz6g9C9Jj/SoF0XKBBdti8z2vW69KdEv/9+F9ak63xHsUMoNI42j0lxmJo7s21piZ8XAMbTxLCWrg1t62HBKKCn3pQlx9nvwzdV3oUiUeVVgiTMjWroFa2A2T1AEIRv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=STmvo/D7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4579D4kG017159;
	Fri, 7 Jun 2024 05:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ufSo6bdOJ6uT4RpytdbYtfLYN8w
	u61Y4PO8S41m6gds=; b=STmvo/D79lD00rE4NgzXdEyxVJXeARbHEJayMOulJTJ
	uz5O9yPOz/klP/ng6PnmDZP0tPwzQWWSVfcuX5+MVwe7IilTjJcRKE46MT9VN5Vf
	G8cDwGC5Y6n0zBpLQwg9H0OUQdJsyCdy9ulQvaonCpT9gD0Ix2VMqRa+SL6vd4k1
	XKMFwpaeBEmePtGqMoAGH3XS9Fw3z1xwEibSJ1+2xKSDmopj+nnmca0oXXOmIbs7
	xRsdCPkLP+NhzGDpmmfynjnDzkW5IlZ4jo14yJw4u6/FqhwJ+RW/AecHB3bQHfUE
	5+g2mT3Ok+7iSwZBAIyAzUdkh+YE6Vnx6nYnprAOFVw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ykycjrc78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:58:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4579wbou021240
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 05:58:37 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Jun 2024 05:58:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Jun 2024 05:58:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Jun 2024 05:58:36 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4579wOa7031809;
	Fri, 7 Jun 2024 05:58:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adf4350: add clk provider prop
Date: Fri, 7 Jun 2024 12:57:52 +0300
Message-ID: <20240607095806.3299-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bOuMrbvj05h3egNp_Vtsu_LtNENpzZQZ
X-Proofpoint-ORIG-GUID: bOuMrbvj05h3egNp_Vtsu_LtNENpzZQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070072

Add properties required for providing clock to other consumers.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
changes in v2:
  - rework commit title and body
 .../devicetree/bindings/iio/frequency/adi,adf4350.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
index 43cbf27114c7..d1d1311332f8 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
@@ -28,6 +28,12 @@ properties:
   clock-names:
     const: clkin
 
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
   gpios:
     maxItems: 1
     description: Lock detect GPIO.
-- 
2.45.1


