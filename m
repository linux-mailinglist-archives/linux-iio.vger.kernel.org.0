Return-Path: <linux-iio+bounces-26456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22738C85D57
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8473AEEF2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63D224B01;
	Tue, 25 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tV2CZVfT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC81FCFFC;
	Tue, 25 Nov 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085735; cv=none; b=qANFk92UyYhsoUqVootZcMy+Ty/Xy2rFu5oKI/T5p70claNWaeZhdXfAIiCx54ErfheMU95u0bf1fAXImNitnAONcWgXd2I0Nys5B9DiN9r+GYor9cfneVAzxE32hKXWRI/tbFcTyrsNkojbchCdGxm6dvhUvyQ1+OwquKE/8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085735; c=relaxed/simple;
	bh=9VfIVc5GPJqqA6hHB2psJl02WjHL4L+F1dZ8A4tATjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bi+Q/dcf4f//8Y0pduhzhn6atqmCSCV4P9r3unumqagAINq+IT2hl3fC39DeqwudRBf1wo/kRn0686qDLEGqapbkwja/4BoQlcxO0Dux2zd2gaCzw8l+Dp9hUokbZSTxnkKs8EqUm/r6IZCG2yja/CP7z+eDDGs09BbhMIa6R4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tV2CZVfT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APDYcsj840469;
	Tue, 25 Nov 2025 10:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aZUY0
	w7sYVtMmpRsddN7efbzoPo01tkSUQkdIzhrVsg=; b=tV2CZVfT3srgykXSEsud9
	0TceSV0D1Vl+58ve59w0HmIkUBUhDmiFi7XjBuMV6Uccr0yiLLdrXo6Thtv+Ipf3
	Xx5ur4o+Cf9Drs55WvvUkQHaagWMFvfU599MCZzX1H1ptGkXjiAW1keenK3Dagur
	N/k9029ef8lUwcwW7RN8c1wLK8HDW1EtG0wAaU887lo2+SZU2GOW/pF/pm0b4tkX
	O79wpag8FMKvgvQ1GvghrH4kqd7moBcVLaspcTXy82zSVw7vG2gnaY7ZNe0caway
	BRtijmAvUs0Qg+fvPL2jYkP1lhIljU7nN6RLQZRluwdqyrI8c+rzzgf+xWyfTzmq
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4an6cean7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 10:48:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5APFmQ8I016025
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Nov 2025 10:48:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 25 Nov
 2025 10:48:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 25 Nov 2025 10:48:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.177])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5APFmAEG021473;
	Tue, 25 Nov 2025 10:48:19 -0500
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
Subject: [PATCH v3 1/2] dt-bindings: iio: frequency: adf4377: add clk provider
Date: Tue, 25 Nov 2025 17:47:35 +0200
Message-ID: <20251125154738.55869-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125154738.55869-1-antoniu.miclaus@analog.com>
References: <20251125154738.55869-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ZfsQ98VA c=1 sm=1 tr=0 ts=6925cfcb cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=WZGvS3g7MfmD9D08EBQA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: y7oKNdWlTa_ljsuaE-daS9NQ4WnHoYr_
X-Proofpoint-GUID: y7oKNdWlTa_ljsuaE-daS9NQ4WnHoYr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEzMSBTYWx0ZWRfX+g1DEZfQYcCA
 vKv6Ob1Lt6xpF1WKNAo+7BVA6GurhFddnD91rBbVoiy2cEbB1JYK8aRHWBAyr9AqGTdmmcP9g1K
 pbPE6fvTjerMYIsQs2kxzzTy8pxtX1W8Q5vvcAAHy5cEpw2Njquqnjnyl9FUQKQs9jRmIYeQcjy
 R4tFjqb9egKDKZ0dtJ09DyLVw4G4d3IGT4J1MIA6cbd8tx1ZaPD4qkBC+Y9hOWorGC5gm0zZEa+
 IYpUPyiAptL/VtW7LxITtcPkeUnzuEVhTp1W00nws7Gh6xAHt42tocuMaNvRyPvISzug6fuSvpO
 OrI/waOiH22fY9l+tO1UVBYujHxZ7XadHAzGvB08PtVkUBi9Ap0Pv5qj4/naJDtojq/SSNTUWBz
 0hX7mBrgNT0+GRMDmfpuPKil/P0KnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250131

Add support for clock provider.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - fix commit title
 - drop _clk suffix for clock names
 - drop additional example and update the existing one
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


