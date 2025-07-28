Return-Path: <linux-iio+bounces-22095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86CBB13BC1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA103BDF40
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B226A0EB;
	Mon, 28 Jul 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tVhoebOL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C628E7;
	Mon, 28 Jul 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710336; cv=none; b=oEzYaCp0TsOzoNsr2XSM7JDvwHCw7BBMaMx30M6sFR07Lx/+oOuGKs/AqJpui8LpiYjVhaDi3P9FNk152aUB8ZQyN6e3bzU4bGKUDa5H2UGWuxcdA36cw6yCuLXPGamLF+G+aHilBp3wAopK6Re/Grn050C6gGlDrDRGsPOmx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710336; c=relaxed/simple;
	bh=EX+CVNKIlqtFkcqcONHLVJKfh2xJYdc4FM5BU3IfekE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZkUA7Jdk4W+HRqBIKIIC/8PoPGEaBA7DDUMzEjucNBwl2KyGHOTWciPIVAmyiNyRuSKvvmnPWPX3BYq+7qGbyG3FCUeEx/rXMNtXMR9/cEF5BY85pNE5oSAiAMWH07Yf/W2O08ctvP45GaCUckJBgNgSlQzHWpvPjfjp4yHoxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tVhoebOL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S9kUVu015237;
	Mon, 28 Jul 2025 09:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gTJ6QBX8KQsWqt9J6wL9+7y9HOG
	DUlCQ2fA6r9NN0ao=; b=tVhoebOLJVFMm1RflYi4wQKzDUjXslXtRTVhEc3/KsI
	7xN2x5sOLYd47cBv+WGEaF4WrYqIIMnLt9EVeAJ6Un+yvKAQxfnyYZU6/Si8KLzm
	nXj2D20Yse16yV9K9MmefaW+pCkgCp9WkGxnRooRmdu4KhQEGHoJeKNZunVKd3IZ
	+67gubzYxgvW/ZLsiw/hsNxPP3oEvb5xRGhBOlLVJmcns1aTIsy7T8nuJYbll7Cu
	stfnqupBMtsjemvaqGuYfjoq+87AD3ndMZqYhusUwC3r/s+ZB+U6PS7rU7rpQhe7
	g1P+Ye3eihFLIj6qs3qKmoOEKRLjPY349EvjkEXPGUA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 485dbhwx35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:45:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56SDj7L0047102
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Jul 2025 09:45:07 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 28 Jul 2025 09:45:06 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.169])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56SDitBR027767;
	Mon, 28 Jul 2025 09:44:58 -0400
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
Subject: [PATCH 0/4] Add IIO backend support for AD7779
Date: Mon, 28 Jul 2025 16:43:32 +0300
Message-ID: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5OSBTYWx0ZWRfX7dOckw9CPR22
 UtbJYDemE9WYoPAt2flaNmSxb20AoXJ9WTRWG0BjZsdml42Y96XRmWzW6jWAOh9H2TMYLzu52lc
 hbi1ynp/OruJjcecH1DnsQUb5UQyDa4ammtkVTIMN4Mf085ShSZHbRYWJxhVj8QYrgS1cW8q5o2
 U+z55+TavXvnnbLxTHJLCWCMwuf/+H6wZiRdbJHJnYO5otNg0D9+m9uv9r1fJiQ/R3N0o4gVKwc
 7NrYRqJtbaHn9rDejwCnb/H7IqD2ppu2ky9W9n1ccrE1+JJZgnyQX4o8V00eFxKzl9cKhcWbnrW
 IS2qIqwl2MunuFKd+bDq7j1R1l/7NBiETbNpWyc9zSjJmeR/UG1tFcjP7LGJ+qKSrj+lprlpLql
 Mube5Kgd74k4N8JS6gCiMSrswBVT0t1lwu+1+d5RZSObW6QizrCjJ9Hoj7jf1dMJupVNxrOy
X-Authority-Analysis: v=2.4 cv=WN9/XmsR c=1 sm=1 tr=0 ts=68877ee4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=Jq-WqpOEp3qT1ab-Eg8A:9
X-Proofpoint-GUID: _oVj7TL7upG_xVIcUN8L1Ovt6D_5ay-I
X-Proofpoint-ORIG-GUID: _oVj7TL7upG_xVIcUN8L1Ovt6D_5ay-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=900
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280099

 - Add a new compatible for the AD777x AXI IP core, a variant of the
   generic AXI ADC IP.
 - Add new compatible string and corresponding iio_backend_ops for AD777x
   axi family.
 - Add the generic io-backends property to the AD7779 binding to enable
   support for the IIO backend framework.
 - Add a new functionality to ad7779 driver that streams data through data
   output interface using IIO backend interface.

Ioana Risteiu (4):
  dt-bindigs: iio: adc: Add ad777x axi variant
  iio: adc: adi-axi-adc: Add support for ad777x
  dt-bindings: iio: adc: Add IIO backend support
  iio: adc: Update ad7779 to use IIO backend

 .../bindings/iio/adc/adi,ad7779.yaml          |  26 +-
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 drivers/iio/adc/ad7779.c                      | 299 +++++++++++++++---
 drivers/iio/adc/adi-axi-adc.c                 |  25 ++
 4 files changed, 308 insertions(+), 44 deletions(-)

-- 
2.47.2


