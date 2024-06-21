Return-Path: <linux-iio+bounces-6678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF19126EF
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FF41C25E5A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9901FB5;
	Fri, 21 Jun 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L8B9Gp1r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9120335;
	Fri, 21 Jun 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977504; cv=none; b=qdLL7FRTIQX8CXZYp0QeT1mrvpvjb346fBGWAO7rR/EoWqEZB2CyWvuQ6la3DN2BSCfgm4mBdDohjx5WWAwGS8tHqFMI042opd3Yax2iyZrAZNjaKSHR62sRI1iukNQthNeFQKYYNJKSBg96WRji2PMXJwW2pHIv1o7WDsyqQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977504; c=relaxed/simple;
	bh=WoquWunYmCSL+/95Rrnl6iED+A+KdzoiIUpUW0JykN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWogVBkYvtsUW2F7gYb4UMRPZACjHguz53bIlkBIIx2MRBnO+UaZ6jDyD2C5J8KtJn21+kFmaXkA6xxjuMWxDtyzwqeaVgU0to6PhtGN4ZnpYHbf5/VWunO1Mi4ykTyYyCkZ9XCBrlFa91VMmcE6G8MR4dlW5Mw72TojIH1Jw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L8B9Gp1r; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBel53014651;
	Fri, 21 Jun 2024 08:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=FRa3aI0ad3u7nydsNc44sEFGNZQ
	hulyTRHX1Q7HOfYY=; b=L8B9Gp1rQuEvKJ70pgMgEIohqQzyUnXFuEishOXEnsx
	G5dKGv97qbZc/OuF7Ty636rO6Ma19DNRsldTlSI4lG4CfgyQYXihTPG5kqzxnHao
	U04a+dlR1YD2aXLO9cZg6rR0QFvW9BsGRHu0OwgPxmQganQds8Bi3g8k5PnYKcGs
	K1DNzFMDD3DEGVqpT7uMtW8tITpdHLVxOFaEV2QDQKtUlMvgXiGYZSGdGCi23jF6
	I2Ge70brJvm47F0OZY/r9Zz5uSpjnR46Am0Ay6LeHmfv7MvkMd2YZONso5L9qk6p
	0xdhB+pBHnkRPbAKLZ103YAwCQVHPXXzJJD/YH146Iw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yw4yxs5v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 08:14:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45LCEMf0021835
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 08:14:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 21 Jun
 2024 08:14:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Jun 2024 08:14:21 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45LCE6Su032255;
	Fri, 21 Jun 2024 08:14:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: adf4350: add clk provider prop
Date: Fri, 21 Jun 2024 15:13:58 +0300
Message-ID: <20240621121403.47912-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: q5lCPQa3DyGBp6-UeJoXADohoYHrnZur
X-Proofpoint-ORIG-GUID: q5lCPQa3DyGBp6-UeJoXADohoYHrnZur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210091

Add properties required for providing clock to other consumers.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
no changes in v6.
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
2.45.2


