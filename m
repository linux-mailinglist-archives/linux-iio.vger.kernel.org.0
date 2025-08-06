Return-Path: <linux-iio+bounces-22351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8352B1CC7E
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 21:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927A23A26D7
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3002BD011;
	Wed,  6 Aug 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zFPjReSO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273217A2FC;
	Wed,  6 Aug 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508411; cv=none; b=HlDtRe/+0pn74LD8Wd53UZ3BYQd9l6T3c+iZwJnzARZo+rNVY+6PrBrdBzthnQy9rgdOmrAz5pyR7xYJYyf+OO9sNT43Yflll8R2BhaIpSD2a88LyYN0jiiVC91Mr/peQ8RpBEPXfsGXEYBQtxyuC0KYL2M4ym2mkpULWlxWBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508411; c=relaxed/simple;
	bh=FLk4XAA+p3aJrsMNtrBkzUm4IFZkyVA5tmi6fb2HYus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTn5mjap4dRX3X/IAaAYxJYgl4K175V2EmCtuCSiS5kOd2JFZUXlz77ZDQhcRP2i7REljlKQiR/k7MrUoeFWvdNwb0tQHpg/DTmtHHej/4HlZrMaaRE2KB5MNiXNF7Axw8G+9axgSOnuIz4EI/yBpD1CqguG+3w9xkawMadVAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zFPjReSO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576ILAUC013530;
	Wed, 6 Aug 2025 15:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+LytJof51L3yWLzIl8+qZEEhWJj
	qvq7lb3taG7EjwdE=; b=zFPjReSO8XKckHsWxbxumEd/B8pzUR6e9e975CtA44H
	wdSfxtbAAtzomObQFday516zT64zb9ZpsD/KSmGEcw5QTJeUk1HVOLF94+uL5KkB
	A/c/GAiUXdcjYpGmjkoQvkuuyqVhyrN/8QRszXmhQLhQ2sK2pULLwGCKoDJniSUn
	iPsEl+hwBXVxq8EAzdXWS2wuZJMBSdr7kLt6yIFS9kFN3CutAPevVddxBLZkGO2y
	OjGfWnO5FSb5fn5WTN159dsK8u4UqsC3dg3JD0MYlmSxgpyDweRMuyJGTjQbshBA
	Fa25Ve4hvCp+4hV0sdYYxvFxg6CWk7CuHMCtt24BkDA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48bpw269y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:26:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 576JQMSj053607
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Aug 2025 15:26:22 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 15:26:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 15:26:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 6 Aug 2025 15:26:21 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.132.255.77])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 576JQAa2004911;
	Wed, 6 Aug 2025 15:26:12 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
Subject: [PATCH v2 0/3] Add IIO backend support for AD7779
Date: Wed, 6 Aug 2025 22:24:57 +0300
Message-ID: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=I79lRMgg c=1 sm=1 tr=0 ts=6893ac5f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=IkzjAD-2iTRiC1O549UA:9
X-Proofpoint-ORIG-GUID: _d4XbSsIBkNDxAEntJ_gfIASpddyaFDy
X-Proofpoint-GUID: _d4XbSsIBkNDxAEntJ_gfIASpddyaFDy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE2MyBTYWx0ZWRfX9F1nvZwPqHsb
 tL6Y+gwidUMHEKmL8BqtdoTQJH5N0dtpcaQeuyrnQ1N1TO0q35ROZzw5IAkIwrdRNsG2p1oveCJ
 rAo4eQLFC8+opCVDFc6qNwXXPM2jxtLesbKeKi1Cqn8jJHvpucTmste/ajdLLBEihOtKdG7+FHS
 rJyCwSENxCOq8k9WXroypogq+MX03g5pLEZwuRkT8sTGONI7JfaOIbEz7zIt9COUBPF4YP0edjB
 YiyRquvXj7wxBqhjbGGM2I1m0xrcWXGd8o7SClDk63njB+xLNCU+5/aqAosrb6QOKVsrcexCOfj
 bDfMfnn6+RFwOnOoJ70RRMAFu9zK+ZGR0TUAGCCxcyBlemIX2HyUIS2cjTjFS370PvdF3e750z/
 03Yq/TQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508050163

  - Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
  setting number of lanes used by AXI ADC.
  - Add the generic io-backends property to the AD7779 binding to enable
  support for the IIO backend framework.
  - Add the adi,num-lanes property to set the number of lanes used by
  AD7779.
  - Add a new functionality to ad7779 driver that streams data through data
  output interface using IIO backend interface.

Ioana Risteiu (3):
  iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
  dt-bindings: iio: adc: add IIO backend support
  iio: adc: update ad7779 to use IIO backend

 .../bindings/iio/adc/adi,ad7779.yaml          |  34 ++-
 drivers/iio/adc/ad7779.c                      | 242 +++++++++++++-----
 drivers/iio/adc/adi-axi-adc.c                 |   1 +
 3 files changed, 217 insertions(+), 60 deletions(-)

-- 
2.47.2


