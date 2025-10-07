Return-Path: <linux-iio+bounces-24819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E05BC11E0
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 13:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8583B71CF
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5F2DC33F;
	Tue,  7 Oct 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IcFkSfpD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF32D979B;
	Tue,  7 Oct 2025 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835769; cv=none; b=Fsaudbt425z45hGfoKDU4VwNLBvj2W8kmZK6ow0LOEnQ06jv8DXhCTCP4vFGwFBq3+BAWN4Tzl43GfdyBCasLpkzDlY2qcDSyouwF1hcDDEHFDN83cl2O3koN/xEtpHXJkeOplR6sbhLS6jBDgY9GlhoPb+jJCanSKlgtJ/u9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835769; c=relaxed/simple;
	bh=jOgDvwSxbvYJ89vK8YrkxDQzRdk6MzF0oeWOEDC0qXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugWtU2WXVaMpB1jRdlSTNxzSExv42nf25Nzp7L8/8/tujkKOOT6JpjvSDp5fX3AhNqvICUMzGllYStMM+EplV1gTGsMnFKvXrUMUohdgedheKjCk32VLmCBOEGF9b81kMQ/W1o3Ke1woDcxCOffB8F9ZRUFwail2jYJQCEgmLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IcFkSfpD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5978cxX1006425;
	Tue, 7 Oct 2025 07:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MiZWZ
	S4vTjspL484kzVfuKXNQdVXhFW8P1QQ9vuqTNs=; b=IcFkSfpDYr9p7/zyhIMVJ
	aHYSWVSUOGspI0H2HeTZdiA3uuynjiAjDa1tl47xHwMLtZ0u/PXd862OmMAAfuvx
	PBJpGxQrN3xkTpP7023btebNFeFiYqXhH5cqdjIdezOKmKxmUkhTbVpZ+nqLPTQP
	jmwISrVlVoCyOxLUCOlIyS7LoLuxTIss2w7Zfk6iU2OI330UBuRysZ1/M2WpxoFV
	Qte6Rdd82JYtA+KaL/JFXupwWNl7V9bT/PRwghp2cmGHnwe+jbxAYclmp3RqNH1V
	7FUw+N9VVceK5F1RsMDKk7EsJtk9O4798gLaM2WyjDM42RmyBlqJp0ijj/BrS4oY
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49myhq8qf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:16:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 597BG3wF058221
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 07:16:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 7 Oct
 2025 07:16:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 07:16:03 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597BFftW006224;
	Tue, 7 Oct 2025 07:15:57 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 5/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4081
Date: Tue, 7 Oct 2025 11:15:24 +0000
Message-ID: <20251007111525.25711-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA2OCBTYWx0ZWRfX/EOQnequk+OU
 TWPVhxmbbBFZLzQsZEHC61KjqYMAsUG4V8WWRsKQP5TQwg1Y7UYfN4ChA077LhJyLRo3JklCWBL
 I6g1wSHm/8odGjbucGE924gt+XLghbqwzG0HIhCX963prGkDSk3BfS16FlXu9bdFnpf5hpQFALj
 sjhhzwDwNeAQZdb9APgbRAtC4dcNnsPG4QZZQvU0zxC+sVBWgsJDZLTR9I2NO7gdYyJg6MDnatE
 916et9cnGlLm9DWPHf+ADxqpbgd5RwxsWZ7BKHTukA0tKD+FlGP4i+F60aaF1OZNqPxvIEFq/n2
 MscWgW/XozG8CYn1LUbA6L0rN89ca5KjWeniK/0L4/e1dtX7iOck6GmGT4cgMpiAHWA3iu3mosa
 EgzdjamPqvU4FjB7d+24s/6tK1tmxQ==
X-Authority-Analysis: v=2.4 cv=IdOKmGqa c=1 sm=1 tr=0 ts=68e4f674 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=agZHL2U0blbLjZyOsOkA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: crBYb_Tqm82ZE3Coh0f0l3LMpEl9NqAl
X-Proofpoint-ORIG-GUID: crBYb_Tqm82ZE3Coh0f0l3LMpEl9NqAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070068

Add device tree binding support for the AD4081 20-bit SAR ADC.
Add adi,ad4081 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4081 has a different LVDS CNV clock count maximum (2 vs 7), requiring
different driver configuration.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index c4c5d208f502..a9fa068189ea 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     enum:
       - adi,ad4080
+      - adi,ad4081
       - adi,ad4084
 
   reg:
-- 
2.43.0


