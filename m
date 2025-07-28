Return-Path: <linux-iio+bounces-22096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD500B13BC6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4F5189DF8D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BFA26B09A;
	Mon, 28 Jul 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gTUIsHOB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9782268C42;
	Mon, 28 Jul 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710336; cv=none; b=fhQLAf/eIyH7c5Bs5g3dyiXHYM5jvFyYm4cKCoFQUs8JXuziKFffqHN3t9KbMEFR076D07zNHvv9mfx0oSWmJ3fwFuu3TU8NZViM89gsE9/fjyg/IeQ8oYW+rrOC52aVfDqCW1rfK9jRze69s7gSTfw4z/7HHyhcTAAGJ3A3giE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710336; c=relaxed/simple;
	bh=EavrRgy3qsG5xzZRcdjYsYdEkadJbLebYi6Ve8L9Tog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezLNNigAm3QnhYKfvKDn9XCF1LqDHMK8Nu5OcstipLDggjvMqiTdpLIn/azN60wFaf2oSgx21ARe0vDPe48IxkCKa6cZHaUYo/AWBmKtXyszbfKoM8xPGLRlIqNKD0VO1nzzFJWeqgnxUtKhK832Or8WkaLxmVvRj5gB4gadOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gTUIsHOB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S9v4hI029738;
	Mon, 28 Jul 2025 09:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=irHXK
	+ZFVJcUMz0vch1U3lok4PDoor8aMZcurirFzFU=; b=gTUIsHOBj3v6TQIiuCffv
	L0tSTvbxWq3Frikiqa3DTvuIj4U/+dt+pLZTR2fRCOBmTyySlj3UwwX/Vm/HTmvh
	hXqR6EvkiiEgENZOFKpMULyI+KU1FwNUMnkO3na8IEjVpJdiSFGM1JZRgfThqK4T
	KwGbbLw8L3pTtEV/zNIBzGhC2gqastENOVRFqBBCNQiRob1nvRye3rIMkX43SXxe
	G9UJYjwkh4/9cCyrqrKjYQtU5X+rWDeLUis0cqfe61FjhdsPr3PahOOoTveU8TXF
	/AYqoN5BSTshVC+DxhGs3iq9j0tsxEwvV1MI7zTOKWn3TnTO+6pZkLEEkjTS8pi5
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 484ux78xyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:45:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56SDjBuv022176
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Jul 2025 09:45:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 28 Jul
 2025 09:45:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 28 Jul 2025 09:45:11 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.169])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56SDitBS027767;
	Mon, 28 Jul 2025 09:45:04 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH 1/4] dt-bindigs: iio: adc: Add ad777x axi variant
Date: Mon, 28 Jul 2025 16:43:33 +0300
Message-ID: <20250728134340.3644-2-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfX5TRAMLQPv6y2
 A5+Hsjhx30dKcyULfULtKCgadyl3yWDSrVNHY8849XpzsP1Bxi97IQOeRb0JSTgyidogAEzRRh1
 c4krIRwfzZUcZzz+GKefkyAw/pMbj4DArSRq0DkiknbFbkuGu3VYpid7McBxqnhx4ClnuBjsB0j
 XN74cZXbIQ7NDMs1VvXLbqa4BIT771+TmT02SEF28XO4Cx97qcTce7RXTorsodDmf6n4dv9WKmN
 LseP9wQgzpOQNfzgSHkyrOo8mfGyxjQhSX1uVecgyYD/SQQtEvdPctHHJDwVrWWCFBDKO1PcWje
 lD1ZE/R6ZRtC7NoGIMGaJX9ebgPPZWtlg8PHFBIfDRbSSMr2Y3myVPTiVvGLToWsG37W1+xJIpH
 X1l+wvQ0TvwW9CZDu9SK6Jh4HY7VVb9bFJeljIt9WcWqUgdzLHvnwALUqIEu7iOkyZPOvbqx
X-Proofpoint-GUID: BHC1n7WN2HB_YfkTBMIBMumQgnlQ6kxn
X-Authority-Analysis: v=2.4 cv=fr3cZE4f c=1 sm=1 tr=0 ts=68877ee9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8 a=4T73O_D_NlsY_8CyJ2UA:9
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: BHC1n7WN2HB_YfkTBMIBMumQgnlQ6kxn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280101

Add a new compatible for the AD777x AXI IP core, a variant of the
generic AXI ADC IP.

While sharing some operations with the generic AXI ADC IP, the AD777x
variant has specific requirements such as setting number of lanes.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e91e421a3d6b..1265ec5390d1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -30,6 +30,7 @@ description: |
   https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html
   https://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
   http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
+  https://analogdevicesinc.github.io/hdl/library/axi_ad777x/index.html
 
 properties:
   compatible:
@@ -38,6 +39,7 @@ properties:
       - adi,axi-ad408x
       - adi,axi-ad7606x
       - adi,axi-ad485x
+      - adi,axi-ad777x
 
   reg:
     maxItems: 1
-- 
2.47.2


