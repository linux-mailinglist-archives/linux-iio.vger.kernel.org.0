Return-Path: <linux-iio+bounces-15861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31775A3DBE1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2453C3BD611
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4581FE46F;
	Thu, 20 Feb 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rB6Z92PP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F11FCD06;
	Thu, 20 Feb 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059780; cv=none; b=V5LnI8sIawM0JPQ715oOdKbusU63w5tBwT62e8+3NakNShfmNSjX+OSDDYgKku6OCfK8O5kZv346OaCug5QAipacgQDmJWNgWSSM3843smVZQbAfoI/FgVDZscRBUaWaBUz+5Fdk9CPpcLKQbLgMSwGO8h/cDJ95R7dL4QJT8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059780; c=relaxed/simple;
	bh=1OUWunYYn6cV+0rjrO3Jo1SvDOy2ut5FkitBzbD1slY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu8bc6mVbe+FqB+zj8bb1+cBjPuaVY8pmXHAH58EVijJgMCxrsZrz2R439YdVx+rQmVSpPVvGEAdPCwb8dZoCNpz1ITqWT78egn+P0w3/BO/QBe+WY9YRppa2dKHnCv/ellyEQoOPnsc6znIcGaDfEIZXfb6O7bFgAWjuOujSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rB6Z92PP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBRDZF005631;
	Thu, 20 Feb 2025 08:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mRkxF
	Q6CouZUC0sXeP3X2+1m8ILqL2lgtXj3G88LZVw=; b=rB6Z92PPQc2UUzCtnoBib
	ye17BXCxB3xeb2KThIJOE6zkkU+xnuYRz8DLPQ+qCcQHeRx7YEzTWnvSz9c4iA/9
	ceGgav9NV3V5zLc5CEQkyEOIlpOyneO1UqyETdZfMDdp5sRxWN7fPVOnYbweFaL1
	8wV33jM8wcQ+hTVY0NQujenS2EJUtDt4cr7UbluKP3WCEqy1ljDO1QlwFH4AdtU6
	KLM2ZCC6yUXA7xSwUDdBFdqURAaNIa66a0x8SHPjqeARjmJce+pXTWgF4qQ7wQJA
	qSjMEI81jmtuGEFAmH9+fM4Th+TEPaXAq4QeW0L0bI1mAq/DxSv3PVxfSJRvB6Lz
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x3hj0h04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuFLK054138
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:15 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:14 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqt008409;
	Thu, 20 Feb 2025 08:56:10 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 06/14] dt-bindings: iio: adc: add ad408x axi variant
Date: Thu, 20 Feb 2025 15:54:16 +0200
Message-ID: <20250220135429.8615-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220135429.8615-1-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: C48EBvC-0NI-RLVyMTDTYRHhz0xVdE8K
X-Proofpoint-GUID: C48EBvC-0NI-RLVyMTDTYRHhz0xVdE8K
X-Authority-Analysis: v=2.4 cv=OJvd3TaB c=1 sm=1 tr=0 ts=67b73480 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=q2Ulk47HLb923_f0sX4A:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=961
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add a new compatible and related bindings for the fpga-based
AD408x AXI IP core, a variant of the generic AXI ADC IP.

The AXI AD408x IP is a very similar HDL (fpga) variant of the
generic AXI ADC IP, intended to control ad408x familiy.

Wildcard naming is used to match the naming of the published
firmware.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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
2.48.1


