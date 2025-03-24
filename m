Return-Path: <linux-iio+bounces-17230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C299A6D707
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3213C16F0FA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE825DAFA;
	Mon, 24 Mar 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mKEOYXVE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3325DCE3;
	Mon, 24 Mar 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807449; cv=none; b=r1dZWH1Mj6yyJp1TMWlvxgy7sYp/5lnZdeQnE31ewJ79kECMp3xRclquEJ9YKirXyfodFBULr8WQmVSP+42Vwoi2JVSdAbk+p3JCZH7lXGssdrq8hg83fcDU17Y87w5C1CUYu69lCGKdX+UOzY+Z3cLdAAk3lELSOgbBrAcCEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807449; c=relaxed/simple;
	bh=UdDI1Te8uMOT0XIapN8tSxQLCFG3a6nyUStR7kIfAHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaXkzpPGq18qDdIp5fWD/q2n2oSCXDS9IV/z2494RF8hSEa+ygErGB3Q5OA8lqsGadEADHK/piNL0AZI9QwX+H+ZsGIbYiXOi5xXuUQYW/OrzZyBwpxBHZ/pMmcopdcXsubY08Hdpfmew80tAijEDAL8sRgnSGkR2Ua7Hp8mWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mKEOYXVE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6nv6P017279;
	Mon, 24 Mar 2025 05:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CKXnS
	E7YgkgNdQyxFicCRtT1M3XQxNnTgmpKxLRHEAo=; b=mKEOYXVEh6sdJD1bBHzKg
	kG2NdYgsb84BTTH7LNVwQnu7LMxWYDpYLpjgqQxdxHpCb85RkRS0kDT/kS29nD5L
	V8TK87l+Kwf6ht1Rv8R8/IQiQ4cq4MVhzqOBMfFNImU2QX8I6t1yr2kdrwU2oKMF
	cqOBOEVZCHKKmTg5xhg9ByUHSYNjMUKixwLLnz2NuMsTZ6rNbnT3rHihSJcgvVB3
	XYGnPBk9FgwVa06nK8AVVupUeewhN12fsPBCfqyt+6mSFK27bWi8BtOC5GW7SRtX
	LtoKAwdc5ImnXCXTwLKpTSn+0+ve5eygCXN7XaAsyzwS0zBs7+90iwBnpLbxur7i
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45k2fmgnf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 05:10:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52O9AQm4058960
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 05:10:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 24 Mar
 2025 05:10:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 05:10:26 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52O99Y6C001058;
	Mon, 24 Mar 2025 05:10:18 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        David Lechner <dlechner@baylibre.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Guillaume Stols <gstols@baylibre.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Pop Ioan Daniel
	<pop.ioan-daniel@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] dt-bindings: iio: adc: add ad7405 axi variant
Date: Mon, 24 Mar 2025 11:07:58 +0200
Message-ID: <20250324090813.2775011-4-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=As/u3P9P c=1 sm=1 tr=0 ts=67e12183 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=jiw2UTfpILs8DVZZAT8A:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: 0X-Eq4EWDFCpwrT0h2orRDdWOScbwrd0
X-Proofpoint-GUID: 0X-Eq4EWDFCpwrT0h2orRDdWOScbwrd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxlogscore=921 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Add a new compatible and related bindings for the fpga-based ad7405 AXI
IP core, a variant of the generic AXI ADC IP.

The AXI AD7405 IP is a very similar HDL (fpga) variant of the generic
AXI ADC IP, intended to control ad7405/adum770x family.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 4fa82dcf6fc9..1b02217ff8b5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -27,6 +27,7 @@ description: |
       the ad7606 family.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  https://analogdevicesinc.github.io/hdl/library/axi_ad7405/index.html
   http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
 
 properties:
@@ -34,6 +35,7 @@ properties:
     enum:
       - adi,axi-adc-10.0.a
       - adi,axi-ad7606x
+      - adi,axi-ad7405
 
   reg:
     maxItems: 1
-- 
2.34.1


