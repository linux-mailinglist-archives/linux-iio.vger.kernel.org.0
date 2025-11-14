Return-Path: <linux-iio+bounces-26219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93980C5D070
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 13:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E11B0351CF8
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E8314D07;
	Fri, 14 Nov 2025 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QMs4itOD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88D314A75;
	Fri, 14 Nov 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122212; cv=none; b=DgKWGtx3S+DoDCqrKOQsNAKrgzYo6EI63sTi6zWKB9imJQ1uO/bSsRbxCgF831ngdL7YIXn8jtayBoRljNDM0cilpvODuKIC53ZHqa2oPK9eceq0HVkma6K6ZYRybzbtjnWJMqUixScvq/vHc0EUe3zmoyNapWZHIF53urBbh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122212; c=relaxed/simple;
	bh=/ISDbU1ilBWuVQD9bWqp2bZ0HH+19UdxcLjjY+s7pbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAG7r4A+oaoupAX1r+6BTItbWLsUlVB5zOnS+rv/ruu26yiFlKh+JtW1k+UUESnzDUhUvle64QOI2yc6DIM3Ucc1mbu9NnjeSJJReuFES9XhWFJc9o6UFmX7Xg6OR/VbqA0OXYqsJwsJ3aK/ZnBCv+fiI0kVAKCPEASVI8Uz/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QMs4itOD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEAbxwI3284220;
	Fri, 14 Nov 2025 07:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7l01w
	RPnZnirSagao5Vtw82wleq7x9bVwxbP6NtQrjE=; b=QMs4itODtePq/OLeVW2c7
	AAL0H5WMJRlSnedKP9fV3EG75cGmCgQ06LQRoSBby8ycVxpKInN72X3uZFsYuVtK
	QLPcOTt4zp55ST+rT1M9eSC8I7cjUUdQDG7GE0fb2AZAqHHbgSoO7OUq/3vXmRJT
	vrYg+ZPWttwGOrKvnncoGpavwN2k5tymQzNg6FWgsU4VCc6Sk6crYOijDK31Ty3u
	GA9kXf7psg0umZHxDyrIDcDPCe/OpnssvGDARrR8PIeDPSaSynLTsfaq4eZXGeQp
	J8EKW5iFvMjBnE4r+PccdvtQK4RjQkmXaN4K6TKaZMLAG1euS+qjCSfEuPe9zWXW
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4adr7uuewe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 07:10:08 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AECA74f045510
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 07:10:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 14 Nov
 2025 07:10:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 07:10:07 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEC9r20019558;
	Fri, 14 Nov 2025 07:09:59 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] dt-bindings: frequency: adf4377: add clk provider
Date: Fri, 14 Nov 2025 12:09:07 +0000
Message-ID: <20251114120908.6502-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114120908.6502-1-antoniu.miclaus@analog.com>
References: <20251114120908.6502-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iEuVzVYurwXDzVGTjt7U386jpOsc4FrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5NyBTYWx0ZWRfX9v+aONfnNwD6
 y5Gx6sPb461TpLre69n/gAKSPBw5mcsy5UfWnfxzua1olPQZoZOEWdnbYyyoFtYi71uirArdJdn
 KFzuuuZcwJBYfqlo45JYnqSnHOVjE9ocREdRPp5glrN7tz+0wUqCkL5G7KhGbryqp/SyUZjjnI3
 1UTEUbEoAFKoWtkRk3dLaeGyUmi8H6enIV1if2ClthXhtC/DmqiYuL9WPufiS+kdhZxd9FBvCho
 Z4KbsX8gGSLwUgDEa8RqztFyjdgj0pJuRKQt4qhDf62sn5HCj4iYap4H3jE1OGX0L00pVbL0hAs
 rM/Cp+TqH9vNx8KI2wCvHzkVT/2v8WcXxsIBAw8YsGrltyqC/0Sbnmly3kisbrPiFrnziWZ8TAg
 gzmwQCtwbx03GwzNUcQSk3CXz21F/Q==
X-Proofpoint-ORIG-GUID: iEuVzVYurwXDzVGTjt7U386jpOsc4FrO
X-Authority-Analysis: v=2.4 cv=NLTYOk6g c=1 sm=1 tr=0 ts=69171c20 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=fzaCPHk0HxoCXYnEZVAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140097

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


