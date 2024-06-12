Return-Path: <linux-iio+bounces-6195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B43905325
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F16C1C24499
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076EE178398;
	Wed, 12 Jun 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YdIUwDHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DC176242;
	Wed, 12 Jun 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197389; cv=none; b=um6T8uPswjKPGo8Jpk+lduO4y9/1MnhYhdiSVuQVK2wLRR10MsPtNtzVwTO57/FgMWQxIi3N9izcQC7JBeJEDNJv1TJViOChRTOCfWEJIsBTa3DJtDd9AESDhfRba7TxLvGXMUE2dlf3uyAcsK+hzioGjlRysZx7S9KVpEZblJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197389; c=relaxed/simple;
	bh=ODb0AS8Gid72yudRJyiMhX1jDUeji0O92Qk5KnJi5HU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LKVKUquoiknPRT99pTmahwRXLmjuFN3oHZSeohOJcs+hXhq7VtEBXjvu7Gqvoj8bXxTctAHBPWNxPn6heKRH5czZEeL96gwjBbiDYS93cjl5/AJax8vJIre2SrW7iqkwdbeVEjw/0AD8JC8qoxAzQ6Q40jkPQtTdTJC0Eb5zDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YdIUwDHB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C7VjPa000785;
	Wed, 12 Jun 2024 09:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=s1jbBiljYWIQU2h5+M2d0n4QhEp
	apypLQmJWq50+k+s=; b=YdIUwDHBvCIK6R2kEVVjIZUua8gmChDdIveTi/BAAhE
	j1lrbwkgy/bQ8DqR120uOzMWrZU5SpIS6vtBtpkYWBeLPLB9Ws2Lq6T2ChIl5yD4
	1H9zs4LdkCrr0mCjb5vh7esX/o7XybNbrT0AETSZEOrptod7GeK5xcfF77yHa/oU
	jMteCoHBTi+rSnp1IW7Fn0pYKQcqREx4w+SqT55HAVkpva+K3QaaxbuCkzsqcmJy
	KaXeMfcACkub+52ml/g0FpNYzm9OLTitQ2KNUjxWT0jI+RB2WFiH+crj3wsUvjuQ
	uxG+MpXerljz0Kdew9kDdHXI4WP7ECEZ9ciuWMGjMSQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ymm72780p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:02:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45CD2qOW046969
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 09:02:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 09:02:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 09:02:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jun 2024 09:02:51 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45CD2eNE023729;
	Wed, 12 Jun 2024 09:02:43 -0400
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
Subject: [PATCH v4 1/2] dt-bindings: iio: adf4350: add clk provider prop
Date: Wed, 12 Jun 2024 16:02:28 +0300
Message-ID: <20240612130232.7692-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: hHP4s2TyhmTL28S-E10BDAemktVCqz7l
X-Proofpoint-GUID: hHP4s2TyhmTL28S-E10BDAemktVCqz7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120093

Add properties required for providing clock to other consumers.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
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


