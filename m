Return-Path: <linux-iio+bounces-27049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D8CB8FF3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 15:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6239F300A6F4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6FC293B5F;
	Fri, 12 Dec 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I7JSzV+C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF21B3925;
	Fri, 12 Dec 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550913; cv=none; b=tay/j2VtS6MLu5u+savjhgHJhkL6YgT+qPEFa7m6cY6f9rXq0W8qU5m1NgVkgaMoV0Db+M2CDqQwaOzu+x+ablvC2r0PiO2tD1exns+8PPcWg5Vqq+vbdWozcWb/XAuJPp3itzjTSFbpdLD9rkYU09KgtiV6FxhuRKWG9Gefrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550913; c=relaxed/simple;
	bh=Vzk64y9dQwnr0mxqA/tJ++fF28NTVNGhL9apaTAIZP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1dEq+XAG5MB0kxsYok17jeEdzFzQtdhfS4Mk2AnpC7/ppshzmGilaVLHnt+RdJIcgrDaiGWyNvAg1jvJ2Og02OR6xvUDNESMReo87QPONnmcjJY3S4qV1JeVSq7AgyNqg28Gf4luoQ3RlzmuxT724et3BORy+3rCAkIOqPhTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I7JSzV+C; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCB7x2e3366414;
	Fri, 12 Dec 2025 09:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=57epp
	w7lL3H2HD0YN6MIQIbspVK5aQam07akHNEY4gU=; b=I7JSzV+CYZPMyvVd9BUs3
	qYbAZuNpLGpL0qZWlQRj6VhmiBGtbxsZK82a5IQItp+yotduWBFEBvemBqAjJC5H
	0qRbmDAX7xsM/0aW3fr5dp3ZM2IOhTcYWnVsrYS8oHiSbMIVaETHbW/9I0FkPCO8
	Z7JXNpFBuZFZRj1bNMXF9Uxe91q0K5j573OAClvVZKiBVzbJvogKzcicVss/Xt6M
	3zgPhjAGMX0FvEnZvjcdh8RhCNhsFM80wMADyE4le/eybKqwKVntWESJ/SbXwy+V
	KALmff1MLVYw61HbtAa5lYa/cmdAOm/k3nSYi9D5RjlpwZ2J54ET4GkLsvckkRLE
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b05uhm0jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 09:48:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BCEmFhm042236
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Dec 2025 09:48:15 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 09:48:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 09:48:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 12 Dec 2025 09:48:14 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BCElrea017338;
	Fri, 12 Dec 2025 09:48:04 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: frequency: adf4377: add clk provider
Date: Fri, 12 Dec 2025 16:47:31 +0200
Message-ID: <20251212144733.127890-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212144733.127890-1-antoniu.miclaus@analog.com>
References: <20251212144733.127890-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Q-jmYX_TuHaZgCWQjPUS7B_6L7E8uKb-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDExNyBTYWx0ZWRfX56DtXZoGyYHz
 wB9aJsLbm5ZZ7xUwOeZBpyVnTF0X2nWyS1t9Oecapmv5G6h4rnntNHICcnTvwmrlZ3jzZbJe72i
 7tXm27iM8mEx3W8GrWOEeZlsO0lhvQ0bdVnNJ5Nh7GT4dxjfrdMIJ6MtGujtvi/UQcto8ivNBVk
 ID7utudyPJakLlIWl1r2Juik+CR809BTmtFpaxhzOi80NqIZJDQl8mrDpf+HG5RG8koCt2N/tWL
 ktQRh+VPnpt2quaM2g2JjNAArKUJkYIfiQr9aom7HqDYHIwmigEBAgJuP4Kn2dvAZHX4BFCJq3t
 vixfctlt9tR6oRL0UruHgyst5XosQYAiEz1sR7dbCH3l5KVMg82nO7pTg+Nk9plkmlOGfoAbkhp
 iIEHBNTirGX0BgEpGD7sISEUBQrwmg==
X-Proofpoint-ORIG-GUID: Q-jmYX_TuHaZgCWQjPUS7B_6L7E8uKb-
X-Authority-Analysis: v=2.4 cv=DeMaa/tW c=1 sm=1 tr=0 ts=693c2b30 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=A8WMtek4AFwDiOTggn8A:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120117

Add support for clock provider.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 .../devicetree/bindings/iio/frequency/adi,adf4377.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
index 5f950ee9aec7..be69b9c68e74 100644
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
@@ -97,6 +103,8 @@ examples:
             spi-max-frequency = <10000000>;
             clocks = <&adf4377_ref_in>;
             clock-names = "ref_in";
+            #clock-cells = <0>;
+            clock-output-names = "adf4377";
         };
     };
 ...
-- 
2.43.0


