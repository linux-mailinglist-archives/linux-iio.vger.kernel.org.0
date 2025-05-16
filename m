Return-Path: <linux-iio+bounces-19575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21033AB9789
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0337D189ACC9
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015E22DA02;
	Fri, 16 May 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uUNTlPuR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484822CBE2;
	Fri, 16 May 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384014; cv=none; b=VVOTBOQ6mPv3WbXVkkgWQRuVD+SaJVxcp1ifL0grd4hSrul5FtPrAG4+AFDmIYkBlsYTfXLm1hD9/y+ayn0b4D+fkAmSithTzYbjHQzGOZJcyqtGSALuqoVGgJwQV25TAwMj/AJK2zjAUUar9Mk0CJxFUCHlcNv9sveceIkFERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384014; c=relaxed/simple;
	bh=4hfqqLCYnvX4cIiYK6kuNxNTn4dZ4USWwVsOOGg5dmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8J5uBrzVItkf53sJ8HxSYVIjpHiz/5uTxG5e5TcAv6XKQsVfXhEXWUSyrj9ZQxUTrMtJaBQoKFB79W23t2+96xiubWsdURijoXcLn+yZISTRzfjs1MgDEM88haUXbgpydOFn4Kn1Eg38QayaPTmpmi+1ypxrRzmiUCtf4gslXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uUNTlPuR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6CokK016353;
	Fri, 16 May 2025 04:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VlVSg
	3Pa/GYE3i4e4eVU1Vl0LeTwTvA/67Iw0CGs2Kg=; b=uUNTlPuRmWwQNI5DW5TVw
	9teeyWNeqq3dWoP4hXlbat+RjM7Mou9V9qDYIKmGXMiumOJV7gZTbALHBAw04tGo
	j2GpD/q/asmZpiH9X8XApvXRzuIAIIWkgnPw2igmaNGclWoTEXGo1nUkzr4rxZOS
	hVpe0MBHSqZEM/7WTqjoVtbMLJOUImEeBnW0aUnTViS/a09WUjPAX/uT226fkmVv
	sR1N49WhUwj1QxrycraihGjytSzNZMYguhAMN32I6XHAre52fZNCqczIBboxXVer
	Gu3gCr6JRDFjWyMT/oMstigLY6J/oVfkrPFyezCgpph6AYraxah4CAJbO/znPib7
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46mn654vfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8QnHO033610
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 16 May
 2025 04:26:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:48 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwi031549;
	Fri, 16 May 2025 04:26:45 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 04/10] dt-bindings: iio: adc: add ad408x axi variant
Date: Fri, 16 May 2025 11:26:24 +0300
Message-ID: <20250516082630.8236-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: eEWDR_NnOP7FLMrb7rf7Qc6AsIVdnm1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfXx1741pSaHSpi
 lA48yDVoIbf164X6j75si/46zX8MJeuuqApJN97DqwwwYyD8VL0rzCxY2nsuo5ZGhJg/QKmbGa1
 ane8lFKS8IGr/6zJ5mbn633/JEtOR/Kyxx1Xu1Ll5SEzVolQhlA6KcF5XGYN7N7/AJWaIu5ngd+
 yjgdWvDb4np+WtqSwkaf5QSfyiLZkRluBAUormJj5DGRBa/s5GrIb4hZJmHmZfVdXcW0R35KWe6
 7Z3Us/RbkTDTNo/tnboaAaBa7B4yz/lBMwUQjd//v16OWUmc8bP8yxfkO7z3uCIH4OZX56unIwz
 49erC/1fy+MswVUWmYdaQMspAexBhuUNR7AwhQcVG+dHlNhZvvmdGa19FGa2t4tLshMuLbyWbmP
 TMMGnDPZXMJ2P7XKTqVxG3NavuxCKZFmv8mD+kLYIuOnza65k/SrUKx4LU6LM4rQXLbzzl4f
X-Authority-Analysis: v=2.4 cv=SZL3duRu c=1 sm=1 tr=0 ts=6826f6ca cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8
 a=q2Ulk47HLb923_f0sX4A:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: eEWDR_NnOP7FLMrb7rf7Qc6AsIVdnm1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160079

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
no changes in v6.
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


