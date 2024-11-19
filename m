Return-Path: <linux-iio+bounces-12402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611069D26B8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C848B2F62B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01C91CCB25;
	Tue, 19 Nov 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nO61i+UD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421E1384BF;
	Tue, 19 Nov 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020853; cv=none; b=jts6Xx9Kz6wG+wASksVF0kKdrUt0lcUQe4iSrS+btVKs/0Fc375Cgc99yGXC0q7mRBIIRzm6uu5ANAznES9dFx5bNek5xXHfrJy+KqJ7LIjdfBtWhQlj5RUmQhvTc3bO6WDuKyQGHww9iLiFlLuq6bLN/NkKRA4yK/cEsGdu6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020853; c=relaxed/simple;
	bh=VovvSiGmUrV0t9+Xf0heE8+663WCB9icQPkL7ivgIdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6ZfoWpt32if3B6mFjeLS74anQuBvGQfqj8M1XUDo5vsLdGMSxxVTHl4v/p4pKqUBqnhcoxmlenDDSOpTzddHmRZG6GCbiP53tRu2oYmsJOkGp7rlRDDrETIForUR53CtNrZmien3gEzIZMWa8WW3lfH+wPafs6L8B0a9rYUpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nO61i+UD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJB18op009120;
	Tue, 19 Nov 2024 07:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=q1kCt
	ufGivdN8gh+vtObMebHErhtEEm1UZTBwdz/0Lk=; b=nO61i+UDBhWg2LS0hK9Dr
	mW/4fsjV0KkuVlFLeDeseo8sySXdb1PtI10C3aX9fOpvvzO2lYUME347FCVWTLQJ
	m1j9hh5ku4EeftFOu0owg54dQmwred386PQth4EBdyX6gNL07nonrUbwcurmZ547
	XtHYZgHRYmc/sdYy+LVvoF8szk4gejwN35njnnLzJXjrWY+uZg5Y+/7wq2TcBI7Q
	nY0BfYMRvSc7Pkc71+1D4FiDtzC3N9BG9JIuFQXs4eKoLqb85ncXrhfbMF5E7fwp
	jpTYAbD5MXz8/x98SUDGM6fKeXPlOHnN5nsSmYRqFcj9EIcA+oyOTXEseI7SCbhw
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 430seagef8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 07:53:57 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AJCruBL005017
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Nov 2024 07:53:56 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Nov 2024 07:53:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Nov 2024 07:53:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Nov 2024 07:53:56 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AJCrhF8007310;
	Tue, 19 Nov 2024 07:53:45 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Date: Tue, 19 Nov 2024 09:53:40 -0300
Message-ID: <dd7fd54585e1230d2da86b5e3d4ed770256b0af2.1732020224.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1732020224.git.marcelo.schmitt@analog.com>
References: <cover.1732020224.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: dxq_kf_dOOYPaFY_H6sJhRGYVK94DBpR
X-Proofpoint-ORIG-GUID: dxq_kf_dOOYPaFY_H6sJhRGYVK94DBpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190095

Extend the AD4000 series device tree documentation to also describe
PulSAR devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes from v2 -> v3.

 .../bindings/iio/adc/adi,ad4000.yaml          | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
index e413a9d8d2a2..4dbb3d2876f9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -19,6 +19,20 @@ description: |
     https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -63,6 +77,37 @@ properties:
 
       - const: adi,adaq4003
 
+      - const: adi,ad7946
+      - items:
+          - enum:
+              - adi,ad7942
+          - const: adi,ad7946
+
+      - const: adi,ad7983
+      - items:
+          - enum:
+              - adi,ad7980
+              - adi,ad7988-5
+              - adi,ad7686
+              - adi,ad7685
+              - adi,ad7988-1
+          - const: adi,ad7983
+
+      - const: adi,ad7688
+      - items:
+          - enum:
+              - adi,ad7693
+              - adi,ad7687
+          - const: adi,ad7688
+
+      - const: adi,ad7984
+      - items:
+          - enum:
+              - adi,ad7982
+              - adi,ad7690
+              - adi,ad7691
+          - const: adi,ad7984
+
   reg:
     maxItems: 1
 
@@ -133,6 +178,32 @@ required:
   - ref-supply
 
 allOf:
+  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7685
+              - adi,ad7686
+              - adi,ad7687
+              - adi,ad7688
+              - adi,ad7690
+              - adi,ad7691
+              - adi,ad7693
+              - adi,ad7942
+              - adi,ad7946
+              - adi,ad7980
+              - adi,ad7982
+              - adi,ad7983
+              - adi,ad7984
+              - adi,ad7988-1
+              - adi,ad7988-5
+    then:
+      properties:
+        adi,sdi-pin:
+          enum: [ high, low, cs ]
+          default: cs
   # The configuration register can only be accessed if SDI is connected to MOSI
   - if:
       required:
-- 
2.45.2


