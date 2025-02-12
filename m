Return-Path: <linux-iio+bounces-15461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FDCA32E50
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051A7168383
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4A262164;
	Wed, 12 Feb 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m5Jq2m8Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A8260A4F;
	Wed, 12 Feb 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384216; cv=none; b=t5+yP0HPBE/HVt00ZLidloEwrEAo78/dcqd8YG7E5QonCGt8kWfR4USxQ3iIMf6nAmWtedRXOn5PTRnmsUV5sacKl6++E+LcygFSIyWpuGAihKRpvE+aQpPAzvJbNrR5qJLJ+lfHsimPHPMf4UOjbAbVG33WydpgUNht1SoR1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384216; c=relaxed/simple;
	bh=mQIXLH4fE5iyN5DNQS/iTb2+vSgH2O60G5i2mzCiw68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVQpeKRN1H4PGgVkVpvGrK7yXZ2mthud5Fk0TSDhB1qbEtbjwIeSZ1zHiEeN8enyUBYlISJLgFNKIX+YIE1VwaQrBY+3oqGMTA02LCD/ip95ePGQLEbSTnzFsXR8Dd+2u0mwZ1XjtkDsCKGLiAUYOcHGYW9BdGNT8KmOLV2YKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m5Jq2m8Q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFHXJq023492;
	Wed, 12 Feb 2025 13:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uHa0E
	wpXnQlJrC56BiW8qeA0fzYz2O0g85hoK9rrtbU=; b=m5Jq2m8QkQi68LYnsuHSl
	QXGpULaNGOuXg9H+kIljIn5e4161DEt2Q+43ACZX6++oOjKg2vY1holvpcCHhXB0
	deAlExiBPsLE5aKDPkhYfxG0WjFfHsAvpFKgPxUNYHkS87hMcKdTYhQ1nrtE8df/
	KV+q/OJGafrHtD3uXrjxjjwZltU7dOaoxyZuzGUqHYhAKSCoDhdhwnrm2QeJMYsU
	Fcf+N1nGQrgAMm2dRhDHuD/Y/SdQKkgpl7jk5mIwHGoavLBll/mjdlkD1esxWXY1
	8XRxxYG2IdCSb8WYr3TWrOA/AIC8k4cXlTJOw3mWV1rvmGaoAw4qVWrp3VvLulTy
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44rnspk2hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:16:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51CIGdrJ041120
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:16:39 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Feb
 2025 13:16:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:16:39 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIGQnb017457;
	Wed, 12 Feb 2025 13:16:28 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 04/17] dt-bindings: iio: adc: ad7768-1: Document GPIO controller
Date: Wed, 12 Feb 2025 15:16:26 -0300
Message-ID: <d055d21a2a1e4e1d64c457d38e3cf6630d4183bc.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RZxqC0tv c=1 sm=1 tr=0 ts=67ace589 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=FDCdkw0c5cjSjuxHnEwA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: kkOxGi_3HykObgR3ks5V5stSVvVnUQzV
X-Proofpoint-ORIG-GUID: kkOxGi_3HykObgR3ks5V5stSVvVnUQzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

The AD7768-1 ADC exports four bidirectional GPIOs accessible
via register map.

Document GPIO properties necessary to enable GPIO controller for this
device.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* none.

v2 Changes:
* New patch in v2.
---
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 4bcc9e20fab9..e2f9782b5fc8 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -72,6 +72,14 @@ properties:
   "#trigger-source-cells":
     const: 0
 
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      The first cell is for the GPIO number: 0 to 3.
+      The second cell takes standard GPIO flags.
+
 required:
   - compatible
   - reg
@@ -126,6 +134,8 @@ examples:
             spi-max-frequency = <2000000>;
             spi-cpol;
             spi-cpha;
+            gpio-controller;
+            #gpio-cells = <2>;
             vref-supply = <&adc_vref>;
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
-- 
2.34.1


