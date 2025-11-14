Return-Path: <linux-iio+bounces-26230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30710C5F7BB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 23:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 694914E2843
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 22:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04E32D451;
	Fri, 14 Nov 2025 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JMQQRvIg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4930DD21;
	Fri, 14 Nov 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158456; cv=none; b=Df5yb837PzQZ7GblqCj92Oo55GfG/CO3HzAGfzUxCUPCQTDF3mMaRsiXe/CylyshB/RWPC61rz4l5OKJLJGi1v6mmQARfwpbB5WK3bt4N6y20jTm8JmbCM6W7yALDcXJfYCjfhVYqJN8JrUgQrhmDnoW4VZLIkLI6q6fgNlE4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158456; c=relaxed/simple;
	bh=I/n/umDaG0wyFTA9deHSKF97P6x7F7Asozf3Srs9n4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ya/F9Kv0CS8a3m7mMqO6MLd2S1dAfQ8OA6hMwA06R5LDXwJoaHjKbup7xUeDAHvlNRYlc/orHJstfv2YdX9aLSkTWg9Ulo4mpDxxCCfMUaqCG3EthSYui/4FteDlZpggKUZvOEgVVm0VV9mH9X0GCU5mDEzY8Q6xY+65nbwrTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JMQQRvIg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEGg7qH940543;
	Fri, 14 Nov 2025 17:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=7TdyL0Hlv2aE6dt5TjGtS3RWKvK
	du8lRwhP9+Sf4NO8=; b=JMQQRvIg1JYIcXVVfzxvErM4cCSYpmMod72roGq0/zF
	ZEObkN8ZxfGQERcmIvwLZ+oNKZ6Fbd4bQ4sYq3XheTfkXhT494adYLSjNTZ/mYMa
	FYp+IDtaDceQE/h4o3pERd10vWnyh1wvSItd/6IWXaDXNRD4UjTG0DR0FfdY2mgG
	fVVpq9K0hQ6ijkiQl/R0be/n6DGE6RIpK2HzHIskpqQr/vf1NU36bJIJEP6z0S2h
	LZJlJNytqR3m7q5U0DNWQ9/CuB6enimbJRNJUCIInO8J74bG+Jcg9YaZUmHI5qq+
	6taFP9svRO0Y61qt53kJuHBs3jrMCyWPeVQD1RsC6aQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ae861978j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 17:14:10 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AEME93R009962
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 17:14:09 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 17:14:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 17:14:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 17:14:09 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEMDtBf030861;
	Fri, 14 Nov 2025 17:13:58 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <ramona.gradinariu@analog.com>,
        <antoniu.miclaus@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: accel: adxl380: add new supported parts
Date: Fri, 14 Nov 2025 19:13:55 -0300
Message-ID: <27fdb3b85015d29c01b804e7f1de5fa615cf9f5f.1763134751.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: 5_xMSQEX9bU8-P3oueMDVElWTnAvzD6w
X-Proofpoint-ORIG-GUID: 5_xMSQEX9bU8-P3oueMDVElWTnAvzD6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDE4MSBTYWx0ZWRfX1Fh71ipV/Sw5
 Fc1t6RJnj+Tk3GSxSe1cQ5fn61xzwsDkWOb/RUGBbyfSqiRDwEjTwVxYSeELLLpFNPCfY0gnwM3
 2lI+5iC86BP3ANdtrZmkw8Xmj/3Vixd0f7yuIFSUGjCE4Zw7/Sg0CZMBmBbOI89cDKaqQV31YDV
 LQh77RdE+BBrppuScKORaa2y+1+WgH7HoYXr0pUNHrZ6PqqpUxUqi4ZohqcU2xgbydCVI0nJm2P
 Ti4do8JvtAq9cOD9jSsmvjtG4xHs/tPAQrv7KaDcTGzn8toRj+bW+b/FcD6zDDdEJ9TKYVhPsSb
 z4n40JAEVW0oShZtY0evbq9bWhfKPP6/Dik6c8PPkn9u2pL68tgZ5ox/bqFLXCvqwY+Oog5O0c7
 Vn0FsskP95RQSs0aCNNgLfnPE/4gmQ==
X-Authority-Analysis: v=2.4 cv=b4O/I9Gx c=1 sm=1 tr=0 ts=6917a9b2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=k4j7YIrD2z0abcBcpGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=qG3zLgC56WEA:10 a=18YE-K8rVzMA:10 a=fBYpuoihzhcA:10 a=XfvEQclAs2gA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140181

Include ADXL318 and ADXL319 accelerometers to the documentation.
The ADXL318 is based on the ADXL380, while the ADXL319 is based on the
ADXL382. However, the ADXL318/319 do not support some built-in features
like single tap, double tap and triple tap detection, and also activity
and inactivity detection.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
- resorted the new parts references by numerical order.
---
 .../devicetree/bindings/iio/accel/adi,adxl380.yaml    | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
index f1ff5ff4f478..ab517720a6a7 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
@@ -11,16 +11,19 @@ maintainers:
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
 
+  https://www.analog.com/en/products/adxl318.html
   https://www.analog.com/en/products/adxl380.html
 
 properties:
   compatible:
     enum:
+      - adi,adxl318
+      - adi,adxl319
       - adi,adxl380
       - adi,adxl382
 

base-commit: 1c9986e782de45bf32fb4f886a40c1393d169568
-- 
2.34.1


