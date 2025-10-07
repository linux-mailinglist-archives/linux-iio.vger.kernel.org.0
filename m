Return-Path: <linux-iio+bounces-24820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD8BC11ED
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 13:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04273B961E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DBD2D97BA;
	Tue,  7 Oct 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p6HB4R+n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52562DC32C;
	Tue,  7 Oct 2025 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835771; cv=none; b=rHRTGm3VWDJsG+ZxSOWvHwKLI14ZHxFCboLnfbpH55Fcqk1bKbpqpNaqnyx6Kza2oO1FJWxpOsgwzzCCXIyWLqQ4QWoPFXPE2XOorazLm7KIPY8jSJmtabKAJ+Ff2p/66jn8Sb9PYb7yZsBY9yilI1FzY31+HHKtPSMb/wTCBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835771; c=relaxed/simple;
	bh=/UsxgCS/snPxULF62Fy/IBHq7nunfP8Q2psiFYBfErY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4GYSKEPRoXogAHtR/EipmE8citzqDpPKpxbYiFtopS9b+8/SQ8H3HgO3Jw//szUr1MYWxNgrGPXRrKxwcAvXcN2fArQUeax0j91LHnMKcXUzjvm5Ci1vT55CYzD/YH6RiOwkl6+EA/CLl8bbMKAb0ap1Kt9K0AVJd3qKJrnGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p6HB4R+n; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5977w2MQ010600;
	Tue, 7 Oct 2025 07:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9HiDi
	rBOrmGdTdeWTvi0ZtGFhWkvhbr0npmy2Mg6gsw=; b=p6HB4R+nrRUnzfBjMKXR6
	2lRpdyO2jMXdkRsiPzWQX6dTzlxpf1CJb3+oST24SdqNnZkyAWdsb2kxMSI9fKVt
	eUZ278vbD29AL4ePgANtFrtJOX8JmOl5ZnXMYT6mv6BQlTCCx1zR5G8UKxjNV54a
	5Php/6NPKxTK7zlSh2Ve90BxtAtqoCfZhYEGpmf8kwcH2Y9nTwrTyntC04R1kieE
	lFHOV0KwNoUztlIc/wRhLu77WlsqVlL0mtpGuGyB0XUTzseKD8hKd8ZSCrPAitRS
	lU2Yi+oWwS0K4uRAmu9h+EHnD2G7E5h/KZkahLHfgJMl+pIImfjT2u473V3QQCht
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49jwe1y7g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:16:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 597BG3VU058211
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 07:16:03 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:16:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:16:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 07:16:01 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597BFftU006224;
	Tue, 7 Oct 2025 07:15:53 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 3/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4084
Date: Tue, 7 Oct 2025 11:15:22 +0000
Message-ID: <20251007111525.25711-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007111525.25711-1-antoniu.miclaus@analog.com>
References: <20251007111525.25711-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=68e4f674 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=oP9NV9ZnaF3-ZFNN28cA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 0CY2D0YE1lu6q6ruAvJAy5mUxOoFnBJq
X-Proofpoint-ORIG-GUID: 0CY2D0YE1lu6q6ruAvJAy5mUxOoFnBJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA0MyBTYWx0ZWRfX3fb75uiDKc13
 HKywF46V1+cf4TQIse0kuUmggiFVJqehjzbdJRnD32Y63FN7HTOjGNNzy4YPWzMzSSSA9SylbZh
 LTR1y5sMEPvO56OxdE7IMv53942lpbrlFbUTNMP8xN29/MhRdSodAV3m7pUeI25OjT1r6cIy53g
 zVc8Sal4sUSUYfPE5BIPAnXwg9vfc3inS0Mn4lzsqm7NNgY5gSEX7fVzA1pCYPNF+fxD7qM43St
 kabHwLPfs0gCYfuywJfwa3k0xolpWzR6OAQb7tR3kfHgEneDaiD3Un/UbDj3xjePH6XOIqeNSf0
 vzwjYszu7QVhQ8XmrlyhfPJ9RjC08JfRjir8bGMc0aGjxjxEWBtfDolKdq9diUS0UFsCa1X1PcX
 o7sLkHaMzz2SDs6lhg7TXw40agxSWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040043

Add device tree binding support for the AD4084 16-bit SAR ADC.
Add adi,ad4084 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4084 has different resolution (16-bit vs 20-bit) and LVDS CNV clock
count maximum (2 vs 7), requiring different driver configuration.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ed849ba1b77b..c4c5d208f502 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     enum:
       - adi,ad4080
+      - adi,ad4084
 
   reg:
     maxItems: 1
-- 
2.43.0


