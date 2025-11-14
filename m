Return-Path: <linux-iio+bounces-26222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E1C5D1E2
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 13:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6216C4EEB67
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA10315D2C;
	Fri, 14 Nov 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="07Mvw1+v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3270814;
	Fri, 14 Nov 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122917; cv=none; b=ItnFWQ392GRtCcJneMSI3NEhTFYJoFPmx6E0H+epgmOpRtK/Xrbrp72/CiLjQTCTDpI3E4Q2bndLluJ3MHWQAROk/eq4VX7lGdpVoqBeLcHToRjGQ/g373TTehP+xBHMXAp6Bfg9xtVcjbeUiRj4vKHreA1FsnmeIlR3Vd6AENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122917; c=relaxed/simple;
	bh=/ISDbU1ilBWuVQD9bWqp2bZ0HH+19UdxcLjjY+s7pbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/GR46R641/veJAUCrDRwoI53aWcfcUWyIxmK+tyJxXV2GpRdQTIDUJKQjOqM3ANpyD9+DuhZsjKk9qOWa30ApiTOvrs11bqz404p5/9S383FcWxBRkzJivGhDn0Xt9MNWXKPZ0N/UvRfI5ARGU2EO6t1evrkFUHY7fkhMUOkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=07Mvw1+v; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEA43b5182679;
	Fri, 14 Nov 2025 07:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7l01w
	RPnZnirSagao5Vtw82wleq7x9bVwxbP6NtQrjE=; b=07Mvw1+vHyxvSvwvkqjVF
	XN+4sULtIw2wxfs2Ei1CQyf/HbzHT/VJXFEM4Vufu+s2l0iIiUXa1u2mqqenb6u5
	5FpAl6PPzPDvE/HIxMFUK8GKRdv13Djm0rcquzJlLjUXJRTzvO0RIWveRyDaFDTT
	6YyWjqals+GniZIBoewCwekNvXJFq8aTEkOfNC+OimryYQSphQ6/FENN/0m9aJTt
	EUfcIL3jeQq0e+nXnzT96Hhs0xVMO9H4CxebLSClsfRA7pZb8i9lapg/WLiy0jTY
	nZ7SPquRk5Kv/NZzQ73MCuwQIuseYI3wRuxexLCunDeK/nuabh13oS3w3naDIiqh
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ady1fhgy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 07:21:53 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AECLqs3046112
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 07:21:52 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 14 Nov
 2025 07:21:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 07:21:52 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AECLgLp019987;
	Fri, 14 Nov 2025 07:21:48 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] dt-bindings: frequency: adf4377: add clk provider
Date: Fri, 14 Nov 2025 11:59:22 +0000
Message-ID: <20251114115923.6043-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114115923.6043-1-antoniu.miclaus@analog.com>
References: <20251114115923.6043-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=YcywJgRf c=1 sm=1 tr=0 ts=69171ee1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=fzaCPHk0HxoCXYnEZVAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Pf4ubK3oayxW1fauIQfKv3Ly-ZEgfJ4g
X-Proofpoint-GUID: Pf4ubK3oayxW1fauIQfKv3Ly-ZEgfJ4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5OCBTYWx0ZWRfXzBcKkP1B8J26
 JcZdCi4XaXsnClCGQt4ceSuK0XoMzh6CIwQt/S8fX8srKHctKa8WCV1Fq0wBg/j773h/kIiBwUE
 0lTJyhtmVotZ39kOujOMpKnIuIO9TBTJGhkPMjyFLdL02EpFKqYav+DyHrG2cDa6t4FYDR31jfu
 ys6cvD5az/DaGM4UxHFD7FPZJnm2llGJ80q49FjgaE+bb82v1KkSLzVVBH86duHrg3vDD6zJHZ/
 NGgWrKUhaaBBFQxjSHDZuFZr5loaLKGyGIl907hbou+u9SfpTurhREsYNlj0EYvlqVt4/HRpcGB
 NwRLoGEJpzs038Mz4Cg+RD6pnosXrYORccGA5XirUuRZ/a5NAiZPlUFzMWDRhJRfFui6kIrQfA0
 Xcfod2s6fK925LbJ3gYsuHQWt+UWOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140098

Add support for clock provider.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/frequency/adi,adf4377.yaml   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
index 5f950ee9aec7..dab1591a36b3 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -40,6 +40,12 @@ properties:
     items:
       - const: ref_in
 
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
   chip-enable-gpios:
     description:
       GPIO that controls the Chip Enable Pin.
@@ -99,4 +105,18 @@ examples:
             clock-names = "ref_in";
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        frequency@0 {
+            compatible = "adi,adf4378";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            clocks = <&adf4378_ref_in>;
+            clock-names = "ref_in";
+            #clock-cells = <0>;
+            clock-output-names = "adf4378_clk";
+        };
+    };
 ...
-- 
2.43.0


