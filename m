Return-Path: <linux-iio+bounces-2351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A371E84FC20
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 19:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7EF1F220AA
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8E80C1B;
	Fri,  9 Feb 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xnUnC2u9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D3069959;
	Fri,  9 Feb 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503963; cv=none; b=Lr/cjeP7h2LbE9uUccOOfQy9C3LhLz0nuBggTENKIiWdWTwuxE3snmxdymCaynMxDDh3urLGKZ5CJkQDMPNFDiA/3P9l6Zb6mrfn2CbesphVNCRPxZaAnSm4+HhKZWbcRUDC6PQ/e/yg8AXT826q/8Tu+4e7RLTQd2by37qkHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503963; c=relaxed/simple;
	bh=u0BDfBpNIPqTnjAdSKSUmF2FUWY8hltyVdK2adeadi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oZMwxvtDTo6x4ZyWQHHbovf0bojlibhVt03Q3NNJ/nm7cG1m9w/5uRaOO6Wxc0u+QV7IgycHVXhBPahJ/adlKd7J21eabc3iAsLyt41JM7iLJ7EPZB+mcRB6fnmo1zF9sx3zLE3wf1zUH4Y7ZsFAXwo5Y8eud7VTj2HVN01ThwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xnUnC2u9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419DnEcn013275;
	Fri, 9 Feb 2024 10:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=+N7LqXesUPlF7A4snIhVfkTW4DLwk2UctZRtddVDbik=; b=
	xnUnC2u9arUhsriMPUvV1mCu6FEiJ1vMJC+HjdubbsnxICUc7/DDPnEshKn+SyoU
	PSe2CiLFYkb33LMYg9mMVKZRuz/JM7AoX4C4QqLZE8nTwacrjVSGn2ITebMo/gsd
	Wt7lS9MeGPPZooI0KMfwboSnHUgl/LhHptQNFH2Ve9AvgvsY1VzX93f9SNTzqdpj
	na9XUTo6C5U8ciTKSuuVU1qF5MZJBceVKfsLhM+GmZh+lUwHdXFRiSWtxpdKGCib
	8T3O9FGx25DV27OWJ5zLrZsZncv5W7HprozUEWlkMeysP+XGMVdgX0AzGGic1SVh
	4fPW+bwNWIqabM/Xa9YxbA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w53423p92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:25:51 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 419FPoAh047831
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 10:25:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Feb 2024
 10:25:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Feb 2024 10:25:49 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 419FPVJ1013228;
	Fri, 9 Feb 2024 10:25:41 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 9 Feb 2024 16:28:51 +0100
Subject: [PATCH v10 1/7] dt-bindings: adc: ad9467: add new io-backend
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240209-iio-backend-v10-1-3ed842064318@analog.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <andy.shevchenko@gmail.com>, Rob Herring
	<robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707492532; l=1193;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u0BDfBpNIPqTnjAdSKSUmF2FUWY8hltyVdK2adeadi0=;
 b=O62OYaPaDMI30+z6NBY9yvoQntxGzO4awCxE63t5jJw3pOEra7aC9PCmGgULzlMWnZc5TC8y5
 NsA9hVup0IvCa9oxPsSusluhRCMtpjsZLC0f8qQziWMHD56+2bEFlN2
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Rsol3yqtaHJENcL0VUTC7FaSS8EiUteD
X-Proofpoint-ORIG-GUID: Rsol3yqtaHJENcL0VUTC7FaSS8EiUteD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=778 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090113

The ad9467 will make use of the new IIO backend framework which is a
provider - consumer interface where IIO backends provide services to
consumers. As such, and being this device a consumer,  add the new
generic io-backend property to the bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 7aa748d6b7a0..eecd5fbab695 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -44,6 +44,9 @@ properties:
       Pin that controls the powerdown mode of the device.
     maxItems: 1
 
+  io-backends:
+    maxItems: 1
+
   reset-gpios:
     description:
       Reset pin for the device.
@@ -68,6 +71,7 @@ examples:
             reg = <0>;
             clocks = <&adc_clk>;
             clock-names = "adc-clk";
+            io-backends = <&iio_backend>;
         };
     };
 ...

-- 
2.43.0


