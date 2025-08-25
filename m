Return-Path: <linux-iio+bounces-23207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C51B33D2E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E017A85AD
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855242DBF69;
	Mon, 25 Aug 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DqBu30c6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30131A9F8F;
	Mon, 25 Aug 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119167; cv=none; b=K4EZfVdGHrcTTZRRhVK84mhUvOBjMQtuse96IIsQ04YTNOvZbV1CJbXNMCMTv38hKpaGwrUGqoHq3msGYtKN9hpFA+VqOgCfNjc4VkcDkI3phNwcO8ojzUSgS5iynO90K9TusqulsyE7ujupmlt6hvIaI/gYa/mc0M1R3XAV9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119167; c=relaxed/simple;
	bh=yhj1fsPc0ISd+iZXugAjGoFmWUvsklY4IxFvmTdTMA0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOw5LdUimBxaNaWmXfjueQFDa+YOn3KbasjMYM8O539URwMhEOjX/Q++Yi///DIICwY7BwZ4TtsQJSmcvMLOpn2Y4i9ofQ5GKh1mptQ6fkg3HX/DDTlcH9GjTks9I+OVCQuCft9fdrL1APyW++HWyrV5OxSTnrIzTpBS/FIfDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DqBu30c6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P70sLM010697;
	Mon, 25 Aug 2025 06:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=A3LnrByoROS6g+R/6qcQQeQnfUR
	ewxjQr6VYvkuY4mU=; b=DqBu30c65Fl29Q5D6RlhyshdNdlev+icIJA9qQAXSfP
	c8+y+fyhAdEyWXp6/oSIZV03UKe2KZCbqHHvqYLxucXf1B1nqfua9t/sRKJoW8ey
	RchylMGlXwi8SnRQehUtZhRhGaK8YE8uWN6Mcv6+OtytRzBKgr4hkR5ErgDc3W01
	Cp1IxR0CQg0ONYrFAUvyS5RoHda1Wm3EyqHLf21FI9COPh1cUtQbBaSeAJvVojBL
	+02RX5ZaGLN6k2hLeoXlyYPCoPB8KZd4dKPQL1+dwZUu92cXfSD1KqbVL1IJOPf6
	dL3VVQiTm06geibYY0s30ywvuh5sagtFoI3PhOHjtPA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48quyew2f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 06:52:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57PAqIOl038553
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Aug 2025 06:52:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 25 Aug
 2025 06:52:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 25 Aug 2025 06:52:18 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.65.213.1])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57PAq607026383;
	Mon, 25 Aug 2025 06:52:09 -0400
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
Subject: [PATCH v5 0/4] Add IIO backend support for AD7779
Date: Mon, 25 Aug 2025 13:51:15 +0300
Message-ID: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
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
X-Proofpoint-ORIG-GUID: iYYEgIprHFqg65jozGMWUEFj7Sk5S3Z-
X-Authority-Analysis: v=2.4 cv=DLSP4zNb c=1 sm=1 tr=0 ts=68ac4063 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=nAsWaW9lDWL_MRO3WFIA:9
X-Proofpoint-GUID: iYYEgIprHFqg65jozGMWUEFj7Sk5S3Z-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDA0MiBTYWx0ZWRfXyAjOR+rbbGrQ
 Gawh/3rfp/ZVWPYhmziV46VyBhzAgzbLXppW89s3TuBbIHhEKIBpNlZp61s4UhGTJ0dfp108qtu
 KY4uhfI07tnmM4cK6Mm/rhsIsmIMqZZKFoScvLSCWFAM3auSWKwSYG/0yJlVzvl8PMloI3nf9IC
 n4gCFO9QGhnCDtQpBrBi37Knspk4Nl2YlxElNZDHNhtHvlJvipKuFXpap7+WXG9EeKmpRwU7WH6
 0o28SWLIo9hbFaD618r7tQTx+2j9GVfjyXZHT2DyptLeo8ZArU08XSQyhph0rMyyib5aI/ar8ZW
 Ua6YisUNk+M2uLDYj7GOixWuPFvZGZOak8LgBcUmhZwdKRHyxxK9C5YCOd+VICKCFHdna9jixXS
 YjA8VLsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508240042

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
 3 files changed, 202 insertions(+), 40 deletions(-)

-- 
2.47.2


