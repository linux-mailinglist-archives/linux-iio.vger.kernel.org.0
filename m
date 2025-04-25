Return-Path: <linux-iio+bounces-18634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA3A9C77C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDA04E2161
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9F248891;
	Fri, 25 Apr 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qpi4jfdU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE68247293;
	Fri, 25 Apr 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580366; cv=none; b=C9Eqf/cgeta0uH4obYnZvi+dnafNJ6USiestamgv4ERH00Qwx+Yq/xLhDbm42OmLXv1OiXV+tv2GQQ98ZoUHbty91H3/UEjEU71nyJnnD+j2bYbfKsQDUceYkctT+3uLLI73mf1fEyy/iuqVyHk2xrD3ty5LQlycw+50aHvUAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580366; c=relaxed/simple;
	bh=luezTJpJz0RK2buP9pZzfZuqQ1R19pJY4CL1KohCf2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPeTDRzwMWuEWyXyGTPZHwLOR0ORaoypLo1lwHP1oADXprJGkLdqnWpScgnwoObTLWCKIgceRqRmsZ/VSe6VK20QeDJ+lX8S6ckU8abyNPGKL543zOx8ol9To3nBbwmkRPLL1sIFx8DICAvnk0FfRmBGde/24WwXYtCs6Iv9aXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qpi4jfdU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8g6NL016641;
	Fri, 25 Apr 2025 07:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=inrnn
	mBCMurOuxbxffwasYnpXiStrotr3slg59lcz4M=; b=qpi4jfdUdUqLpBr/JnA1X
	SqZipIL8fhMdJRbrPbPN6z9JuAd5JGRCHQTDTtG3hm7M8ioW2QLnmh6+9Oe7lQXk
	OownCUdUXur+2obWjADrp1ScV5HwXLgXcKL0cDNoH5lv+2iVhnqhzwOvGQyQiUKU
	5hyng+0ud+q5PWjAB8Kef8oDmy5iDBcfKCKHtIZBoiRKxyXE5Y57yXKNnhrpOKVF
	Pbc8Vu5SSHdEH657rUzhvvEhBpA43CBouIopxxAxeyLIv9ldI5ib9s71icylG06t
	7cAHA1xb3ooWlkX+Jcfk9ti7NkaQUwoBaK9FaJz3LZPtCbbzVcwBEsplEgfyuIk0
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46833j9qtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:26:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBQ0pA049233
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:26:00 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:26:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:26:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:26:00 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbv003881;
	Fri, 25 Apr 2025 07:25:55 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 05/11] dt-bindings: iio: adc: add ad408x axi variant
Date: Fri, 25 Apr 2025 14:25:32 +0300
Message-ID: <20250425112538.59792-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425112538.59792-1-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _czqMqDi4jEB3Sq-Tn7nQ682JqFr5jIu
X-Proofpoint-GUID: _czqMqDi4jEB3Sq-Tn7nQ682JqFr5jIu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX4pQDk9WRz3Vc mjiBwEiS0DSMf89yyjPqdkS4Y8zt4Inc1Q2Er0pjWIQlHHIfL9CJ4vHloxYFf6HZNZfxsVXMHbL u7oZVhr7oa8HmJ8m/Qe0m16zZgG0MskGIRBc1xDLQHLFLvSk1Csv+uIDYq7MPVHGQAqfgDgqgUQ
 8V/39MnDTe9BFBRKKoNW7DE7O/Y//RB55H49rMyD2/lyOgYkZNRy3HfHnBKLD82vrhr5fjcx8KK gQ/ZGELazVAz4QP3yFv32yUhlqT8qG8FFtEHwTgiA4cLguMCVrI0gO19J1qFp8WfXzn9cjhJ22y GQM17NDRG5pk8BqjYZ6w//vbLuH7SKATdgsqCp30KGIscMz8rwor63zoqMpIIGeTCX5hdTdsfAx
 p4KFSdXHXeV1D0coqYfZ6HJpMXSKwCqulNuCwTRYkvcekOurA8h/F0eyhV9IgUlE/BS2aXAs
X-Authority-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=680b714a cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=q2Ulk47HLb923_f0sX4A:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

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
no changes in v3.
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


