Return-Path: <linux-iio+bounces-14617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7AA1D91D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB8318872CC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF1013D246;
	Mon, 27 Jan 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sWZDnrSZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ECE38DEC;
	Mon, 27 Jan 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990733; cv=none; b=WniXp48zwFij88rO82upPUC+4gfk0WgDHq81nhEK8E/mxqkQtY15JFVWEgwMLjd6DzrNFeaeDvfrcqkGyJN0WitWf9/miuYoucBCpV+uXMfwG4dF5mcbZsWfgK/dJMXeEXuEwIzU2EeOwPg1q8hSjYm7rB6Z1fqMcekHS4HWfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990733; c=relaxed/simple;
	bh=H42pzafHTic5M39JYO9nUPtSur2tFmPyYrSIKGybrJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4ANQFy/a5XxmbICIFN6M2zay33cUL9naMpno0lwuYUcuHJqoavi/u55lz7DVJS2p6EQVjtWv0CSBUHfH4IjJ5E6quG5YqoskDMGYxDIuIBUHaSJiFMDKyz/yFV10T57xdFHWlE40v19D+ozgVaAfJtgSi0HPJX02120iS1wFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sWZDnrSZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWC0o005706;
	Mon, 27 Jan 2025 10:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/GZs0
	U0NQqXndMNeBPKWIiVazVLXw0LPK+7N/5PrjG0=; b=sWZDnrSZVcBKvWvCcTSnU
	1A+5sdvkGth4xAY+xu5pUqS7mb/kShKQplPEDB2d3FRLC/cm72NCaI9eKHg3Ve/5
	han4HTelsjnmTX2ckLJrn5ynnDYv/TvqajJI5fqN5zv1UiWLxofPHfCVsY24ZPp9
	dfFjzfWF5Ge7Yp/3/qchVPYEcsl/NmU4pKxhzzTwgHTeutPzIAH47pWUm0AgeUT1
	vK6CS7iu1imnRHxm73pifTu3hNJoWmu4XfEAmHRmpv0SgU5fkrIrIgJZGCBC8bxM
	kSeitquEJMNQ0wHs73nvc+UkoDE5hDxvlaZcqzK+S+lK/t1jFDW6XmRJs7SM+w/z
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gddw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:11:57 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RFBumG038451
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:11:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:11:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:11:56 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFBiO3008394;
	Mon, 27 Jan 2025 10:11:47 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 03/16] dt-bindings: iio: adc: ad7768-1: Document GPIO controller
Date: Mon, 27 Jan 2025 12:11:44 -0300
Message-ID: <dc866cb508917828f83242f3438dd1d6ac9d874c.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: wo9AM1Q2OCjlqsigzHnD9z-ddrYxPWDX
X-Proofpoint-GUID: wo9AM1Q2OCjlqsigzHnD9z-ddrYxPWDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=878 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

The AD7768-1 ADC exports four bidirectional GPIOs accessible
via register map.

Document GPIO properties necessary to enable GPIO controller for this
device.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* New patch in v2.
---
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 3e119cf1754b..da05c8448530 100644
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
@@ -121,6 +129,8 @@ examples:
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


