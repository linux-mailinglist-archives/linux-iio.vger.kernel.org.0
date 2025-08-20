Return-Path: <linux-iio+bounces-23044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00309B2DBF9
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7F894E507E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1A2ED84C;
	Wed, 20 Aug 2025 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WMWpUo/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A99221F0C;
	Wed, 20 Aug 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691423; cv=none; b=JKKmfeWjyGOaWEEwX/QaIjCWYzdk0U0NeU1dOfgEvk8N3+wnS5YmeggRC4zd4gf5TgWOwH0kt194j2Gbd3XdyiY0PSpdieSLo3P4l3i5SDfUtfIdU1FVvcHMRETIr3EA3bIC70F/QnQSUT2QenSzYeDSF4lQMAR3gXLOD1SgB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691423; c=relaxed/simple;
	bh=iH2aEpZAIs2Ttrt2WX7X9DkIYXbh6w6N9H1OKDktGfA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vb+4IaLMehdIxq/pkXBglKdFQ3eZ9Px69qWfQ+2L/TS2C6ZwnvQv+aicrkwJnONfOp9vuLNEEzU85rz8M/wcM/pgpY/EZIHFXaLEddNrNOiB+rFBABBpdRMqscm6osFB3ZbDwWKspo/+8xg0OcKxFV0NwQ/msALASQKNftMhims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WMWpUo/6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAYTfT004315;
	Wed, 20 Aug 2025 08:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DQO2fPstsjoNNKgx27dGq8T1+0l
	edFcfgPjctQMPMjs=; b=WMWpUo/6ll000e9xv3CWSI6yr8zqd2tH2UHcFIpfCav
	LdIylBKmoJqNuTi3hcrIyn1wq3ny4XrC08oChjGhQ+sjTRtMCTVP8wEiytxdP0Or
	1qGv57HpiJsXO/M7wfhhD5Oxy1pMUoNhYH9b8OpBvyaA2N4KSlsoUePdDOVHTIz5
	pphHFa1qDpgxsYFn5V4TD+UwRwrrngVGJWn0cHrGWgds0+AoIRi6+9wtzMgLluPG
	QSjd/FRlWvz1q90+kc64phQLNIve22c40RvjxgTQJHoJjqsZ4wZh0ZzO9XgFHcUL
	8s89HLTj7U3vHris15ZjvFIP/ZGCpNYdaTrBTDvhl8g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48n0td3gs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:03:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57KC3Ejx037333
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Aug 2025 08:03:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 Aug
 2025 08:03:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 Aug 2025 08:03:14 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57KC31n0020092;
	Wed, 20 Aug 2025 08:03:03 -0400
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
Subject: [PATCH v4 0/4] Add IIO backend support for AD7779
Date: Wed, 20 Aug 2025 15:02:41 +0300
Message-ID: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bvAVxEai c=1 sm=1 tr=0 ts=68a5b983 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=nAsWaW9lDWL_MRO3WFIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: UepdhggsrW14I3SMO6ynExzMAYd4b6m2
X-Proofpoint-ORIG-GUID: UepdhggsrW14I3SMO6ynExzMAYd4b6m2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfXx2zgBEySksVs
 rAcyVL2b51ryHvE2yrxGkdDk4ExG+C29O50hI5WuPh2ujIk0UNLTyH5U82tjROk27nQEXk+Pr2Z
 GxuEi2U/zBYfTfmEwGtwUjfNoyPNIYC3nRwRrZpEP/agznxoGk1ppJhQtQjvP28ABBm3u9LSX5K
 V7bBqLxWPCEO9FyOoHh0ulVuI+fj7vp22EOA5ldsPo1ZLZifTTCm9bCgCAo+yCPQnRBqbA4lC30
 3WrzH3bT4GMaCgkmK40QoSGZ3FCKxhH55/ycXA/KdbZy8JL0Lc7dSX0bF5tWwVZLvcK9K7yEHAc
 iXUWtyIJosKcXkgmB2eIuCGTl3/w4eI5P1TAuUqxKfLaNNcc/X5qWyCXXkXbyBnck2F5nNbN28K
 ojpU1mJjlOH6WwAToMumwgkFkY2+KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190195

  - Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
  setting number of lanes used by AXI ADC.
  - Add the generic io-backends property to the AD7779 binding to enable
  support for the IIO backend framework.
  - Add the adi,num-lanes property to set the number of lanes used by
  AD7779.
  - Move the initialization specific to communication without iio-backend
  into a separate setup function.
  - Add a new functionality to ad7779 driver that streams data through data
  output interface using IIO backend interface.

Ioana Risteiu (4):
  iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
  dt-bindings: iio: adc: add IIO backend support
  iio: adc: extract setup function without backend
  iio: adc: update ad7779 to use IIO backend

 .../bindings/iio/adc/adi,ad7779.yaml          |  44 +++-
 drivers/iio/adc/ad7779.c                      | 197 ++++++++++++++----
 drivers/iio/adc/adi-axi-adc.c                 |   1 +
 3 files changed, 203 insertions(+), 39 deletions(-)

-- 
2.47.2


