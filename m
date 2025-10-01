Return-Path: <linux-iio+bounces-24634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52EBB0C95
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B8A7B118A
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC43043C3;
	Wed,  1 Oct 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uul9dGu8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA82F25E7;
	Wed,  1 Oct 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329927; cv=none; b=N0Ai/oM26sMGxTXJiEH4u0zsw/YxS0dc2BQGvF5ctXGhrrUqjOMEHNCqTziQn/jYYAR1n0KIrGK+45o+F6cqXXtkP08BUO707KwEkXpedECL4jw3M4/NEsCALfaAKgdTYLR12b33d8K+4IohZiP3YpBhg5ucaCZkbAukERANxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329927; c=relaxed/simple;
	bh=9vaA4FMhW0MekYgJqaxLqGXu2oCeYVlfscW4ugupryg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN4ybmWMvs8mZSHE2XN9cVNDDEVHlkJp0skSovMYgEvW5wcQGOtVIfaXyNni2e9N/UpRMfrFaj9zTjEeuKFod5GUg+fofNbb2ebp25eTjxIkZ75Hx+HXxeiTr/q5Wb48GwyZGUc315cXtxSUkJ6iOKwaARHQP+t7j2bgxgGZdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uul9dGu8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5916Y4qU008978;
	Wed, 1 Oct 2025 14:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fF9atfBGhzqb4KhbU
	vP6g/mO8dQyz+omul09LHYAz+E=; b=Uul9dGu8aL9eEhl0rFqVjPiXpjimItO2W
	kH9xchLqUtsZitG04cUdT+kS+C9P3D2XNNRNqEOcjzSMju6HzKRqPLlQiR1oR9xF
	ekn6UORDkZSs28OCaJczPVFELrSjjfmsJXWawsJa2TLkYgYZbO86Z05FiYnqMHsl
	7R2uKI0xqmBoSuGhilqcWaMQrkIbTHA//utu6zl5Obl0sG0wfsHot7J3T00AjDV8
	ohiD+43E6oPOqayRkiFEEIGpDPUbkJaVSeHRbGoFQzqKpaBWpgareKbFAc9t9eA0
	b8RkOvBgh7yHdVnaeUhNk6yx1BhrX9i9x1X7LGk04DzjjaY+FcIDw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqyjfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591DE2gw026746;
	Wed, 1 Oct 2025 14:44:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8n197c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591Ein6O27919002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE91258043;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D55058059;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 5/7] dt-bindings: hwmon: max31790: Use addressed fan nodes
Date: Wed,  1 Oct 2025 09:44:39 -0500
Message-ID: <20251001144441.310950-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX/VcnatYu7APw
 fCYsoCTi02TpqW4mqGvbTC0Q6/rlD+DzBJyPzXDUnrOQE1Kk4jBQogL7oZ6XLrv+1VQQUU9O0pD
 W9rjogTJmyoMlDdE3JOLxsLax6W/eZ2YlMYF7RQTr21tWDg3HQe3LTCoBEUMtI0ChWl4CRz10i6
 quXKYNPQNUYfEQPlYmaeX3WdcEFwfXUEZTQNHbF20fu6ffGc1mXIYeCLvHaC061RbkFbIFxK991
 ebt7YBpxUWjdWEGBsXnh/ovXJDhlGBCGtheDr52/u+U9iowNFwUSR4cxM9UIfnb6cwRPIGDrYv+
 /UN7wYt7z57BHz5KW9GnXw5nKfv8D+GciRhca2itB4xgftOsvN+pcS6flt4G+sQueCo9D8JO9aO
 gyc8xSMHSu/3lynFABsi53dc2J/HXg==
X-Proofpoint-GUID: TTNAdzhCCVT-C3MFVnJgGMPOmKCgX0Fq
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68dd3e63 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=n6X2Zvpy7yjbfLGLM-4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: TTNAdzhCCVT-C3MFVnJgGMPOmKCgX0Fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

Since fan properties can include reg, the fan controller should be
able to specify address-cells and size-cells properties and use
an addressed fan child node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/hwmon/maxim,max31790.yaml           | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index b2dc813b1ab44..558cbd251b0fd 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -35,11 +35,17 @@ properties:
   resets:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   "#pwm-cells":
     const: 1
 
 patternProperties:
-  "^fan-[0-9]+$":
+  "^fan@[0-9]+$":
     $ref: fan-common.yaml#
     unevaluatedProperties: false
 
@@ -60,13 +66,17 @@ examples:
         reg = <0x20>;
         clocks = <&sys_clk>;
         resets = <&reset 0>;
+        #address-cells = <1>;
         #pwm-cells = <1>;
+        #size-cells = <0>;
 
-        fan-0 {
+        fan@0 {
+          reg = <0x0>;
           pwms = <&pwm_provider 1>;
         };
 
-        fan-1 {
+        fan@1 {
+          reg = <0x1>;
           pwms = <&pwm_provider 2>;
         };
       };
-- 
2.51.0


