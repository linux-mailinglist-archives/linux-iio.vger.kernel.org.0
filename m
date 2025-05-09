Return-Path: <linux-iio+bounces-19365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA2AB1122
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5B61C402FA
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A928FA82;
	Fri,  9 May 2025 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KgR5WI6V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A928F52C;
	Fri,  9 May 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787839; cv=none; b=a6Jv2bJ6dmv+AO2zj58Vw0qZxgwAqo84jk4LcL23sqbiqjMBFI5IhTYyRRVd3VPOJpf28mx13/Qr6AaTFiDRlhR4SHWY8lIjXPnX9StbiBLaoJtesUw6rjElLh5BwaWwW+yC5SKI3BV9+aESVw19BeQrkm/+B0b/1h6s4XK11Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787839; c=relaxed/simple;
	bh=EWVeRctj+17odomDsX+LSXZ706yQHQxOmz0ZW1ao4JQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ygm8SYKvMeX6zJ0UbaK9O7O86/d6BzyxHDvOEfOwskeMram0vZdDHH+FoCCA2FrZ9SHQoAsPoGunYdYLkoPgnS2F5v+7RgwXVFq1tOA2W+v8ht8ErquM4ADt8BB9dlnWlDCuSjIVT/UPtQlC0LUUI6K/xSHq8OUJCyf9M61vGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KgR5WI6V; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AGdcr000591;
	Fri, 9 May 2025 06:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eF6zH
	J9z1eJG/UJ92P1eZBWwfxjXKvILmQ9bzMsplYM=; b=KgR5WI6VKCW4NP3PM9T0x
	j41irVa3tTF+/rFFNxXIIA3POlvw6QrXPjNoh2znSru8/FusATK1g0/MysG+gOAy
	GFIfssrfwu9kEDWHNKlzHZm2zha291Wfk7xTbA3HSCSoaXWsNKGXHREw/z9+v0I0
	ck+/EWDVrBqW9HZ4dABCoAmehEiCTwk6XYNeOYl4fcKgziokSSucJm0fWA2DYD9W
	x6l4sg/vH1tTUTZx2fQnSpNihYJHOAF/tSi5tqWgvrmS1jMNWQgroKHMe2BHFfLg
	qrhZguI2Aw1+iaUT6VBBvtNUGvqsK1ZbXEKUCWxvcNzqzzMwy3b+1i4zhdQOI5s0
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46hftdr3vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AoXKW049025
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 May 2025
 06:50:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:33 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK14014223;
	Fri, 9 May 2025 06:50:30 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 04/10] dt-bindings: iio: adc: add ad408x axi variant
Date: Fri, 9 May 2025 13:50:13 +0300
Message-ID: <20250509105019.8887-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=CP4qXQrD c=1 sm=1 tr=0 ts=681dddfa cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8
 a=q2Ulk47HLb923_f0sX4A:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNCBTYWx0ZWRfX9Us8O7yXy/e6
 uMFpvMq6zDubd3/9NEg3rB2OkIUJhsAvfLM1vmMIE8Y7iJVqSPA9ktbkmoXdUKSi+cgAX6sCR7c
 yC6UYR6/8hCTHLtSGH9Tacuva97A3cmcjP777F6YZvhy/tyFLIzauhRmSqFPFB4Eixntko8X+hc
 XJS8UCisDFRPdGWgnMCpCD6AgFUiBoy5SJ29Da0CMpvVDytY0GtOt/kMGXhUgaypi2z9B8Ddg5f
 7WSvGslvSdqn9TPWeaaDZ2mM1pHAsD0FqOfi4AWMc3wdsPq9jxxG/0qew6nEkh9tNWnxxJdLNYI
 G0Ez0MZxXhHa6fkxW0i3QC1cVVp6x5n5SdMtpscyq4PWFhy0gYs3cf8bZZDxi+BmkMHxrZWkuNr
 rbuof2WdgKlNV/32MGpDyaxTNWx9B2D9bWa9P2XX2NJpQkNm1vBwpgseh59Dm4P3Mwux6Pp5
X-Proofpoint-GUID: YhEGRjANqUkvSNQ04Jwxtx6ra6OX23Dp
X-Proofpoint-ORIG-GUID: YhEGRjANqUkvSNQ04Jwxtx6ra6OX23Dp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090104

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
no changes in v5.
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


