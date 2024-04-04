Return-Path: <linux-iio+bounces-4045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E438898390
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 10:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E65C1C23525
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB773505;
	Thu,  4 Apr 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="czqEtyRX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29E71B42;
	Thu,  4 Apr 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220927; cv=none; b=GxsfGtbj5NZuClNnAt0dX9BuFbrkUHjjIvXxbhxcbBuKV8jwbIAM3W0FTw9qhIwgJngwibeKfFTu8Z9kQCP9c7bmBlKw1Asd4oS+1Ru8x/MXXNgvtW4mYEZqqJiWhFw2yP8edUJMm6UIrK+jcW8XMWf9I8GCdxpOhiZKlk+Zfos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220927; c=relaxed/simple;
	bh=rnQzwLPbXO4Riqnz6PXrWUTn4Pd8xKChQYwf/cGw4js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=u2CcU9Yr8A5SyVqQHzijYfIQIrynhfsfCCGeNmpX65tOjIKVwQ/u/RXCXvVhr5Y+w0kR4jHddid27cpbGipYwastDzZiLXIN9Saab69auCfKOqsTALLxBesoyswrS1q18S1ASKMKzUJ+Srmm9rhMCC3Ek+W29BBTP3PumQFd4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=czqEtyRX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4343TKhb010078;
	Thu, 4 Apr 2024 04:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=MLG/mkqWSx+MahDAcyrXfdbWEJbtwW4FPVhEO3CWzrk=; b=
	czqEtyRXHG9TX4AowpnsXnwOTzdA1uaHdWnDzGesdUxMU2RpU6oMMFaAKirwKiz5
	pSS6/s08fqOz2JsKnUKoTsbkENLNL0PIm1O5Ia5/GOCWHNFXOvgyPWPotPYiqJYM
	d7KsRAFZdyoGtH/Ju/8iCqF9eM/o8WCXmKAQ16n9MJR3uqOqYCSKHnVrTa80RzXG
	f0X/FnaEo08TYptayaZgBJnxt4hOsN6tzQ3mRoNPHZwF2tnrGCd/YSHV2uqsN5vS
	dzNWRgdO+5CbYdqYMZMnsvRROvYQejTJk8d+qduMhWfBSCCt69C82OVJL5/iwGAg
	ngaddvnaE+SuCXuv5kI8eA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9epgj4fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 04:55:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4348tAan008117
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 04:55:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 4 Apr 2024
 04:55:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Apr 2024 04:55:09 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4348ssse001282;
	Thu, 4 Apr 2024 04:55:03 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Apr 2024 10:58:17 +0200
Subject: [PATCH v5 1/2] dt-bindings: iio: temperature: ltc2983: document
 power supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240404-ltc2983-misc-improv-v5-1-c1f58057fcea@analog.com>
References: <20240404-ltc2983-misc-improv-v5-0-c1f58057fcea@analog.com>
In-Reply-To: <20240404-ltc2983-misc-improv-v5-0-c1f58057fcea@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712221106; l=1227;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rnQzwLPbXO4Riqnz6PXrWUTn4Pd8xKChQYwf/cGw4js=;
 b=TCbjoyoFG9K30L3Rc/XoiPF007WQHh1jGuSHKVcQOL4so14CI3FXbUkjI+X8fQrFVRS7snG4e
 tcPMrd++cCUBbccKtyCHyWBEWhllY1uTLZKHDjdpLnFBBX+jwEUtpTk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 25ScQpUNtfReymNRk97vCpk8R6aYlwPD
X-Proofpoint-GUID: 25ScQpUNtfReymNRk97vCpk8R6aYlwPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_04,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=843 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040058

Add a property for the VDD power supply regulator.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index dbb85135fd66..312febeeb3bb 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -57,6 +57,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
   adi,mux-delay-config-us:
     description: |
       Extra delay prior to each conversion, in addition to the internal 1ms
@@ -460,6 +462,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - vdd-supply
 
 additionalProperties: false
 
@@ -489,6 +492,7 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
+            vdd-supply = <&supply>;
             interrupts = <20 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
 

-- 
2.44.0


