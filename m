Return-Path: <linux-iio+bounces-24575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B3BAC862
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64428189B672
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E0302CC1;
	Tue, 30 Sep 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ovLKuCtH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F52FB621;
	Tue, 30 Sep 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228382; cv=none; b=ltSFxc7nkdFgUP1fIWbZi5eLwQwao1ff8k7Xk2YagDzwnirW7ALChNIFBXO0ceTAgOUp5Zqfi9ngfiDjUrfkd+ruP8qBFHuGDU2SbKN7PR5pZbbB900Ld0+dpwtmp/P3xNbzM6QeVPcTI+CK5DXvj7QcoBqFj5KBN4YVtSqkh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228382; c=relaxed/simple;
	bh=2k1KciQBK1CbG3Su5Z2u06t9roRSeI8ErDD274kKUL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZsya4Ii7CfgwyMb7DKazujCiptAE8N5KuSPIuVQc6PZ0VXWvD3MdvQ1LBwIUUe3TebL6T4j093696p5Jswwlt/CfS2b0EVLug8JFD+ml88FCQrols4wU/nl7mqGRFiUauoH9U1BxG1keZX/maFxDKnMZsFPSbJR8wPRlqMQGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ovLKuCtH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8BNbd026798;
	Tue, 30 Sep 2025 06:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TE6XI
	dyXC61ReTXsxo1nkGguIWBoGeEN4U4yd45CvnE=; b=ovLKuCtHl6yeCStIbQLMu
	CTOCh1We5e/0HStpGfieASTxLTPzIPuy0XWdUyInVHr1kNXARo//AKW6t6b3iabq
	o/TYpSb7Q9QT+EE0ES5aVakpDO+oTJaTLEW6M8bfrh8VnaG50Au1T4h2Wrzhb77v
	tDorauUQTY50zEMThlgDd7Q+el7n9P8F5bJ6sAi7O5bQv1hNoPSKEYfyw5/3T4mT
	6ifLTU4VNTiumIPWC1No4RXQ85gB4TkK8ZzekqwQb3lWZomlZWStofdHPiAPzEvX
	U3sYIb2UV+HkG6VkJy4/h2GUKSkmF9hxasKPXYpbeGbh22W+bnMZagAYBPs38LHB
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49g7sjhwnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:32:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58UAWunn027480
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 06:32:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 06:32:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 06:32:56 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58UAWipV025133;
	Tue, 30 Sep 2025 06:32:51 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 3/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4084
Date: Tue, 30 Sep 2025 10:32:26 +0000
Message-ID: <20250930103229.28696-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930103229.28696-1-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rugXg6DrM-KMKCjR8nUAW0QU_z0kZE03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAzMyBTYWx0ZWRfX1+J83lb3Eg1x
 XBaX8Y0FZS/U4rMg4RDTnHwBIlYj0HGabbHnH+463Wh0jBWxLfmuGcS2iYb/gH3n7AKChSZP/Lr
 GxDaL2mT04y5hj/NGb4gVn4paEwLJeZNItMFgDenGPytVuclVnA7AwnTfPH/8XDE5TmNIM2oMxk
 nRnqe0WmD3ovm4Xr7nmiRM4QfqEERzzsnCursS1ImyysEh1/BCjBIfxG5kAwREOro1tuzSk32dS
 0oAxf0C/a6FBZ1VaIceN8W++TRJlmQXiR3mceLGcWYzvRxjWcnmJUTSqUilaA01ON7jQ/MaSp4K
 x/6CKfeVhCJyfkmm2+RMEMuido43KoBP5lc8iq27aEXBE/PMisOXxR7ViccI1Mowud4O9wW66sG
 XF5uCl+Skxz9RDhkvfn0DnWXchw6wQ==
X-Proofpoint-GUID: rugXg6DrM-KMKCjR8nUAW0QU_z0kZE03
X-Authority-Analysis: v=2.4 cv=U/CfzOru c=1 sm=1 tr=0 ts=68dbb1d9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=oP9NV9ZnaF3-ZFNN28cA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509300033

Add device tree binding support for the AD4084 16-bit SAR ADC.
Add adi,ad4084 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4084 has different resolution (16-bit vs 20-bit) and LVDS CNV clock
count maximum (2 vs 7), requiring different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 - improve commit description with respect to fallback compatibility.
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


