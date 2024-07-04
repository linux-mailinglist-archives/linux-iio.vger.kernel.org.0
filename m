Return-Path: <linux-iio+bounces-7304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCAB9272E3
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673C71F24E7F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41D1AAE38;
	Thu,  4 Jul 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I/QeSf/O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AA1A4F38;
	Thu,  4 Jul 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084953; cv=none; b=u1PZFp3aURLdkVBTP48PVRMJRUBZgCg0yOTaGfmJd6TJ7sSLDsjoJIXAlBo+ftx1aBDs+zb73rl+YkVHTvhMApFlml6oX/ZcaPXmNn6hiaON7WAU68aU7L3K+tu6na72RRkYSJbyNtOsDahfu6xyPhOOIz+2kVdpuHBfWl0vRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084953; c=relaxed/simple;
	bh=pHO626iZhwN4BCQ3m/P0amFN+UbMJa8G9SI+X3gIH8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=l7nyMkH88lluWL4V7FufnRlY1Cs8E0gMnS1XAI8F6/FaetL/kFFOco+jfCCDNgsJc8oZaQJNF+r+3522LfYHzb3sJ7R23ft+YiXvN6SIX6H/dp7YNRENG+0+hHQzJwqpo+oEM3aRtQ3aqc4t8nsZpLFfpRxzxcoQC1JS4mT/swg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I/QeSf/O; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4644oict006966;
	Thu, 4 Jul 2024 05:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8mcOb
	WTTmqXr9oQvcxL7j77WsLK5TTAf2NEDDvcZOxw=; b=I/QeSf/OMI8pA4yKit/BR
	XCW2joXtDV4E9YI9vBCVW7eFs3wYtq7qnk3ktaYYmlf4bWEvj6hi+xX9VonzVlFd
	EhY3Rz5+231a/WI/V9Cfv+zfC7n3/pntPAqVfKSi5e7ReJaFxUrbLh7M2fuqmmIr
	RXAn8Rs+Mj49t7GP41v1my0Xo7mQgHBtdcLJm6yZV4URosAy4QnH4AVXy4twkj/D
	9ptwh0H+tlFIoF5QKfcCbrrFjntavszesliuNnOPwWu6PkWps/3yPuWUEJeOPknc
	trcotod1W1aic0V0DFxBXAVzN9bcZnoc3+Ciz9II8ZnDqXvWYGbFlxRMMV49TARE
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 405n2p0u73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 05:22:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4649MHJW058894
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 05:22:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 05:22:16 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4649M1dm012858;
	Thu, 4 Jul 2024 05:22:10 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 11:25:24 +0200
Subject: [PATCH 4/5] dt-bindings: adc: ad9467: support new parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-iio-ad9467-new-devs-v1-4-f1adfee921f7@analog.com>
References: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
In-Reply-To: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720085156; l=1003;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pHO626iZhwN4BCQ3m/P0amFN+UbMJa8G9SI+X3gIH8E=;
 b=3C395z06siwUeCgE/Be3uigxhwUXqHQ1GzsiIL4L1EbBmOnHOQitvrhb1N+RWfyxjw2x7bk2z
 Txs+kJ5lT1+AoObIlJNAXzGhbyGak1NLQNKNsJYNMzDU4kIaq/GonPG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ql3hfctkJwh1lZiYgPj5uvMmHm9UTnkx
X-Proofpoint-GUID: ql3hfctkJwh1lZiYgPj5uvMmHm9UTnkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=553 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040064

Add support for new devices:
 * Analog Devices AD9652 16-bit 310 MSPS ADC;
 * Analog Devices AD9643 14-Bit, 170/210/250 MSPS ADC;
 * Analog Devices AD9649 14-bit 20/40/65/80 MSPS ADC.

Note all these parts have subtle differences in their programming model
(different scales, number of channels, etc..) so fallbacks are not
possible.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index eecd5fbab695..2606c0c5dfc6 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -28,6 +28,9 @@ properties:
       - adi,ad9265
       - adi,ad9434
       - adi,ad9467
+      - adi,ad9643
+      - adi,ad9649
+      - adi,ad9652
 
   reg:
     maxItems: 1

-- 
2.45.2


