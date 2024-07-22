Return-Path: <linux-iio+bounces-7785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08029939126
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CE31F21F10
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414F16DC38;
	Mon, 22 Jul 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uPSCLXc+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D31598F4;
	Mon, 22 Jul 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660332; cv=none; b=msApms1ERam9UWWqVMFwwZtAuTWHrZzYWbxX3qxuwQ2rWRGXVW2tjs8qzVckzH56lsKe4FskKf8OLCRngkGJO7Zfnxk/rqQ7Mga6IBPrUCzeVMfM8oVUg7gz5JaBw2lk4j6bHc/7dIJNH/vE3E4l6q71BwU9fCM/Qy//Cm9isIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660332; c=relaxed/simple;
	bh=C/MBpDZjWPIQS5cLI7WOnqLI1/fZ+0rziP5aUhJv3MU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BVThKOifpLe+T24zO5AUkaVxoUlEp8XkgP9REaqIauNfuFY1GzxXR4LidF7hrR96CCRwxv7bxYkeunyCE8az9Px1YZ0aKuE+CqUW4n6E6srx6LTZJcIBIEBJ9tCRDwbmX+74hUVXdetgB3pjwkYPtO+c2C3Y6l6oSqzPjchywaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uPSCLXc+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MBqCi6025124;
	Mon, 22 Jul 2024 09:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HOIIX9wN5/wJs2WX7cLfRkVT4ya
	0pl+yior1HVd5iNY=; b=uPSCLXc+fxEU2lmP3TKs292fw7ajq9Mt66N1y1n2TWB
	9297ddpGEHUomjakRLL5VJGMw+oh1CEvPjSXK5GgSbk28uJ81JSg07ksYheaVw54
	wiJtc3dPNRslBEKY3Zvl1kCEU7Z/LVGGW+FjFWWO2+q7Fji4A0cjzmvFxWPpf5QB
	TUeu73K59mCxwiAQDD27M6MXAWctwNDVhDt8EU0hnPjy+aAISjpEKD0+3YYaL+54
	Ft1ujoUqGCtC1nDuFKEMSU5Vm2aZ5q147hWyOc7fV4l8Lqofhmiahp8XRCXRp/3t
	9l3C7YFKu0QN5x0XBA3XapKuTrvMC8dyylgUtkqEexg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40hj2b9d6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:45:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46MDjUWJ013051
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jul 2024 09:45:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 22 Jul 2024 09:45:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 22 Jul 2024 09:45:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 22 Jul 2024 09:45:29 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46MDjH9J016251;
	Mon, 22 Jul 2024 09:45:19 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: adf4377: add adf4378 support
Date: Mon, 22 Jul 2024 16:45:05 +0300
Message-ID: <20240722134508.25234-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: RhRZbkxCA3vxL-JvKhiLA_cF_fAsUnTU
X-Proofpoint-GUID: RhRZbkxCA3vxL-JvKhiLA_cF_fAsUnTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_09,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220103

Add porperty conditions for the adf4378.
Add product link for the adf4378.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - use property conditions for clk2 gpio
Note: the compatible is already available from the firs iteration of the driver
where these particularities weren't available for adf4378
 .../devicetree/bindings/iio/frequency/adi,adf4377.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
index aa6a3193b4e0..5f950ee9aec7 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -17,6 +17,7 @@ description: |
    applications.
 
    https://www.analog.com/en/products/adf4377.html
+   https://www.analog.com/en/products/adf4378.html
 
 properties:
   compatible:
@@ -73,6 +74,15 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adf4378
+    then:
+      properties:
+        clk2-enable-gpios: false
 
 unevaluatedProperties: false
 
-- 
2.45.2


