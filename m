Return-Path: <linux-iio+bounces-18969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F9AA6D5B
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6C83A38C7
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102523C4EE;
	Fri,  2 May 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hCzHRVK0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4B22F773;
	Fri,  2 May 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176386; cv=none; b=f5gKl1py6eSaWnourPifrH3XH/45LOttia+1cProviSFk6YlNDmRZPHTP45UKsWKCYM3QDs6mpcFggp4zAglGrDZWsRs0LBTNcXRPpZ2sCG5Khvvmx64G5Q/8e1jlX3pJ9u5SR17qAZsNvC6CsfcH3EJRnJMCOqeoC7AWYCCP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176386; c=relaxed/simple;
	bh=FpzKrezyyTo7ArFlozAg6JQ0WxUTyuPqW2frH46R4Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejPYExfwQA21//RIIq6ZFdZtdesaMwE2v3jNX1rhxRo0T+zgDEfyTzcNvf30H+w0eNcKc8zoYuOVTEok0LyY36cVfiqgLKHuWjtF8//A+D8+pZVqs2RG8KwJQNZb26Nyb7eyrgluXcvgiLF+22+4BDEygAfiCR+ZnSXgkwRVzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hCzHRVK0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5427SOp3020069;
	Fri, 2 May 2025 04:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OznZr
	WrlZQen1axqbY+9g8lfWU8grjicI1djlcqMbhQ=; b=hCzHRVK0MeVmbHsP8bjgd
	ZII1ruBrTWJGrkFkzgIVvg5u1HFKPhMlhia4HSNda50ox4UtHXOazu9AuMQspql6
	W6taZZtRWkmpoUgUfJCo9/N0rHOwtgVo9/yRaYwpUYGd2A5lc5s1lX/VHJV2SInC
	9bXeQanQ7nB8UwPQAJ3aHduuKsW1XWTeDvdvZL/ZTgNNLk8J5jlRDgbwi/Ytk+Sh
	Dk95B0hgMdKMAWbyKQJLuBCSip6/jQRvHP/aYZUcXkmUwPz3GppMFY5Pv9lHC6/9
	a4w7l710RqPC2yvONJp2afwgKQ5MkHbrUYSTy1le+dL3Z5uspCSlD9763t/K2ORG
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46cm5pskhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5428xXnJ058964
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:33 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7N015723;
	Fri, 2 May 2025 04:59:30 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 04/10] dt-bindings: iio: adc: add ad408x axi variant
Date: Fri, 2 May 2025 11:58:59 +0300
Message-ID: <20250502085905.24926-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vey2Vp4jadPExRIFcJRxjiBOgk-G_nim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX8Z0Y6qZifQAC EIX7NKAhcB4JRf0Elj6aWis+AEH+B7IyjIVGqlpaGiHVlKnKJblduqBvqW4pcFH1L3sbmWZVT5A mCRXpA7ymdhEE/OPK3T7x64MGnHMfoRKl1O2r5znlf9dU1Vv9Gz3/B9WER6ptfpjMhwy13jMNiB
 8Ggx2ozsqNucBfJW1kmCHq/8tjEgGRo088IXttiHPkU4LwhT+YdOQjIVBpN+Uefrz5LtjtJJ5I7 WCm32SVM5dnquAiQMV/ycOAboS+849Jd6RNiV0NVusuXR6zaSD1hDs6uFsYszAwBlzlZocO1T8J 0qazDvgrz+7ijHBiZok3oMwxpCq6EXXN5U4ikEdT2uqRu29f2Movg7W0U7erWFhPdhEPRkbPn1x
 4mwRw8D7osH95JCHcbOL6vBBxTDCPCAJQP/RGR2FKnO7VHUsKhdNgwoM0OAGLJupIVVJD+RM
X-Proofpoint-GUID: vey2Vp4jadPExRIFcJRxjiBOgk-G_nim
X-Authority-Analysis: v=2.4 cv=RYCQC0tv c=1 sm=1 tr=0 ts=68148976 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=q2Ulk47HLb923_f0sX4A:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add a new compatible and related bindings for the fpga-based
AD408x AXI IP core, a variant of the generic AXI ADC IP.

The AXI AD408x IP is a very similar HDL (fpga) variant of the
generic AXI ADC IP, intended to control ad408x familiy.

Although there are some particularities added for extended
control of the ad408x devices such as the filter configuration.

Wildcard naming is used to match the naming of the published
firmware.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v4.
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index cf74f84d6103..e91e421a3d6b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -27,6 +27,7 @@ description: |
       the ad7606 family.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html
   https://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
   http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
 
@@ -34,6 +35,7 @@ properties:
   compatible:
     enum:
       - adi,axi-adc-10.0.a
+      - adi,axi-ad408x
       - adi,axi-ad7606x
       - adi,axi-ad485x
 
-- 
2.49.0


