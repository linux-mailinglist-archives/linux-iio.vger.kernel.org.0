Return-Path: <linux-iio+bounces-22917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A579CB2A472
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F11177624
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D5531B13B;
	Mon, 18 Aug 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FBl46aQZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951B2765D9;
	Mon, 18 Aug 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522820; cv=none; b=N4SyGvydRicTvJqT8UlwCeM9KI7J4aGgED76uW7r8pX1piFDFL9+dqC0EwKx1I3G9qPrL7UBcuN2ql+1K1UWKWRT+jkoh6MIn+ebm6QUdJXnMHUeN6gdY7onyvjGxJXI1sZt2q7C24ZgfQQ4yV7wiEEoOaS8tIw/tNxsGJVk0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522820; c=relaxed/simple;
	bh=dlucAk4El/+I9baniHrvw1nhO2SynSaQcp3KzgsisWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgR6SR/K80I1iZoiAj4WUndhZ2vJoU7E+dH4yPXMWgzHfPWfd90WcnhkA7F4SnQzMjNAw1vRKa1Gede5mFZXAUi2Xsq0f7E4OFHumzAIiTxzMW9Oem7KhKkIM7HhlS44wmdSnE24zj4qX3RcEd79ju2uFGfOb1J7DKumOpkDNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FBl46aQZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBfQb9022585;
	Mon, 18 Aug 2025 09:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GbW2j+pqklWjZs9p3f9/a1M4fDm
	vJ6d0JaowlW52OP8=; b=FBl46aQZKYxJFjvEaKsLsMm0kCIkVyoFbK2v4Nd/EaU
	3oGJVW1rpTJeTKSr1UmXK7dasWjtpyykcwwpCl9Cgw+1EUCGJhVameOrhlNu7eUJ
	lcFdVXoPXDO4SdDhO+y1jIZOritmOerKLQi+8hUOqOgHAkYodtzYeRu6GGgC+s5O
	Lq9yQjh/RiCj7wh3p6TskalwRKc7O398vCXP5QVh9KOOt9hsSTJ/Ms+kLaB6OBdf
	mhPWx6eYxi67OIODP/s+dW5/ThnUD9boYSSTquEjrI2CDVNYMvmZZlDOiG0g68FG
	beuYEsZEeIg+YF1Lck7VN6GESIGH35yqS+I+JvONY9w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48kn0t446a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 09:13:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57IDDNUd011888
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 09:13:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 09:13:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 09:13:23 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IDD8Ol008451;
	Mon, 18 Aug 2025 09:13:14 -0400
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
Subject: [PATCH v3 0/4] Add IIO backend support for AD7779
Date: Mon, 18 Aug 2025 16:12:46 +0300
Message-ID: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDE5OSBTYWx0ZWRfX5NYwoNau+A9Y
 wlV2cP4nirDpo9+HsuuBzVHoeNKgrppZwHwLXpU5r7k03gdXT9s4paP0qFlOEHP5vxdHCjylBnT
 ChFUsg+dlf1IiiT/WqkTbOg/jTqzYoyoNNzRAiL4CKDoeLiUwrcxcz/u58gYlBWJXVMNfrokKLk
 EVSqmk1K0U5SWZvmXUWdpRBmhoB2xa+7eRQsRXM4J6ANNxRAnhxUyK+KNfVGaC0sIxgx9FVwhRu
 nJ0DmKyD+7skMn7KZE2fiK9m1jusIi/sE2C+mStaO0ygYBXj5nQ1BOyYPQp9XOqTR51DiYQLT4L
 cmzy1YQa1M9r5KmFEryTVaj9L+AfRij+moJo3CEwq00l6TOD4QjKeVUcPU6csMHwW17N6+TfgE5
 jmFbBhhd
X-Authority-Analysis: v=2.4 cv=JrbxrN4C c=1 sm=1 tr=0 ts=68a326f4 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=nAsWaW9lDWL_MRO3WFIA:9
X-Proofpoint-GUID: g85uXU4MMpZrP83lUtqSZWY9ggEu9sRR
X-Proofpoint-ORIG-GUID: g85uXU4MMpZrP83lUtqSZWY9ggEu9sRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170199

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

 .../bindings/iio/adc/adi,ad7779.yaml          |  35 +++-
 drivers/iio/adc/ad7779.c                      | 188 ++++++++++++++----
 drivers/iio/adc/adi-axi-adc.c                 |   1 +
 3 files changed, 185 insertions(+), 39 deletions(-)

-- 
2.47.2


