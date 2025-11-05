Return-Path: <linux-iio+bounces-25911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A2C35AE2
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 13:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D06018C7450
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4231353E;
	Wed,  5 Nov 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hki81own"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4F2641FB;
	Wed,  5 Nov 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346446; cv=none; b=X/wquHqAVpN1ZBXTt6omzx313kGvaPXjVBsvNUwPF30UTBI6nU3aSkY0gtP/7KLc+2qBkgJkBBXjkO0xGAYDTra1pInpdiHM5bCD64z0HjefaatpWhSZ9UQXuQB+hn6KfrrW1ksMhBY9avW4gCtn620gPgXxbSVaFtfREnXcsaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346446; c=relaxed/simple;
	bh=oaaReKe65Ldrjs+vQFAWW+YaO/BzAbds8ca0L9Gbi5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oT6QvXUNgg74VpFGNlRRKMRoPzba9g5KPhMpcPj3SRjDbIJLZXor3D9HqOf1OAmHezq5XAhC5hQ0Lq8lX30SfhB1YvyMh/wWjG4LwcnUo26bc/13YWn61VWYaByfSoscOG/fde8XURLff4OWEw0UJr2MWXCaNXSnp/Ub6UB5ozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hki81own; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5CK9cc3419206;
	Wed, 5 Nov 2025 07:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ABOm/8XyIXxM9kRwOL7gTH/6+fd
	yIqtB6/vXxvQ5/8w=; b=Hki81ownH2YgsMAqI1/MpAXPXmwL08cDecUqxE89uUX
	7CLsdLozu/YQt0W8ovZxHR/m3ZyWZssvHvhOBW3R5dCwXBp/WX50Bzib+WhOBAzz
	rot67gMIXYUevrH3+QT9HfCGXt7lMFGR0FYbO1asO7EjPyaCbVYkCrrTQ1mf0rOx
	8D8aalid6XLPkMsb5m0+Mc9ePjFiqIM7XtXl0c2Iren1A/XLFQoJVh8IB9b3XPSv
	UWlL+8j1YDYmhV9cMLI4erz+JAs6hsRedvobsSUHeYcKeh7TcIFWh6gL8M5HzRwk
	PBesEoA+D9l+w05cG+lJzzg8/8fgl3JDChgRtxMg6hA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4a82p013v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 07:40:41 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5A5CeeAt044370
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Nov 2025 07:40:40 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 5 Nov
 2025 07:40:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:40 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5A5CeQK3007837;
	Wed, 5 Nov 2025 07:40:29 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <ramona.gradinariu@analog.com>,
        <antoniu.miclaus@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: accel: adxl380: add new supported parts
Date: Wed, 5 Nov 2025 09:40:24 -0300
Message-ID: <2b8fc2ea006d06660c83f1e9e1ccfc865803dafb.1762281527.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA5NSBTYWx0ZWRfX+P4+Bm52RXYk
 OKfsE5xrCkEv9xvnS8yHE+KPh3oseW2YObUcsX/ujJsmDeti+ngcIuzNC3H6hQVxwPQNwQIhNuL
 /dfGjgZ1WJf5B5y1eK/XbvhEyVVNZ9lEDcQo7S5N1KwPDzIZafwDZRokjKSYEW+rBJq5JJ5Tm/v
 gaEpZrjHREvUj9OSVyI5BFSAnu7BAKE2GIMEl/HNaiWVCuU2GAhjLS7GJsfc106QdALfsaiq5QR
 qTEhSfP3eNg+0gNEZgd6CzuENaRAaubezvr0Tc1IbvlbI7P8h3daDB+DiV/32KnZPYN6CFxfDVq
 32vRJOeI3Taogt07tMPOLXFAPzrvwJHlvcLy6JwD+CQIolGvKEYWn9QpUgSUk6XTDATKWsJhTd+
 Iw6RdjjWjcdCLvMb+vwU+5xBttXo0g==
X-Proofpoint-ORIG-GUID: o6sDeC_L2OSg_25-yO00A8bKPi5VzoKI
X-Proofpoint-GUID: o6sDeC_L2OSg_25-yO00A8bKPi5VzoKI
X-Authority-Analysis: v=2.4 cv=GIwF0+NK c=1 sm=1 tr=0 ts=690b45c9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=k4j7YIrD2z0abcBcpGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=18YE-K8rVzMA:10 a=qG3zLgC56WEA:10 a=XfvEQclAs2gA:10 a=fBYpuoihzhcA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050095

Include ADXL318 and ADXL319 accelerometers to the documentation.
The ADXL318 is based on the ADXL380, while the ADXL319 is based on the
ADXL382. However, the ADXL318/319 do not support some built-in features
like single tap, double tap and triple tap detection, and also activity
and inactivity detection.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl380.yaml    | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
index f1ff5ff4f478..f38f384dd818 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
@@ -11,18 +11,21 @@ maintainers:
   - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
-  The ADXL380/ADXL382 is a low noise density, low power, 3-axis
-  accelerometer with selectable measurement ranges. The ADXL380
-  supports the ±4 g, ±8 g, and ±16 g ranges, and the ADXL382 supports
-  ±15 g, ±30 g, and ±60 g ranges.
+  The ADXL380/ADXL382 and ADXL318/ADXL319 are low noise density,
+  low power, 3-axis accelerometers with selectable measurement ranges.
+  The ADXL380 and ADXL318 support the ±4 g, ±8 g, and ±16 g ranges,
+  while the ADXL382 and ADXL319 support ±15 g, ±30 g, and ±60 g ranges.
 
   https://www.analog.com/en/products/adxl380.html
+  https://www.analog.com/en/products/adxl318.html
 
 properties:
   compatible:
     enum:
       - adi,adxl380
       - adi,adxl382
+      - adi,adxl318
+      - adi,adxl319
 
   reg:
     maxItems: 1

base-commit: 70437bbd7529e9860fb7f0c92a89e0e6abaa994e
-- 
2.34.1


