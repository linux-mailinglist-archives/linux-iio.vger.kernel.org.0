Return-Path: <linux-iio+bounces-25284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCDDBF3216
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 21:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB9118C05C1
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048DD2D6E42;
	Mon, 20 Oct 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PsYNGtOh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EB2C0F89;
	Mon, 20 Oct 2025 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987628; cv=none; b=CmN069zTBYI4QfXM/BDdm7ib9tfsNU9MdS561pC/1XlWkB5xgZi1C5ThSbEhoIbYfq3Viq2QNn6apTIZw9iFmOK1IL84E2jOIApcMl2S90Bnxg5N00YU9EUJzTh9nBw+xq9AFSeGD2jFxH06HHtnVFMmrwSkm70PvtsO2NV0bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987628; c=relaxed/simple;
	bh=mQ4xmNeD7YorO6/RxmRgf0EhxY9gTZ6kF3baNx5GUpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U376QXYUFjH09DZ3jQEb1cMI0SuJfQ13joS56vrrZkrke6SHhpb5ZTV0T1a0c5z9zgVZABPL1fNch71hikFqYQ2w5e++y8DQFmMNM4oy9qO21VB+WEtfkx+dtvf6+cgOp7kxZQUl7vt3eTRW9vPOTm/IFV0R3pqdkyXWs5U93lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PsYNGtOh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KIwdZC012280;
	Mon, 20 Oct 2025 15:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=2T9+C2/M5XpWLtNSmdShPk1Uu7U
	8XckpqfMc06KYx78=; b=PsYNGtOh0hLDhyE1j7zNptfScgH5NQiIEzSo9qiOUrT
	hKdhkqqxVnESEYlgJZ7VX+uuTsdBp4fqORvlcREeJ4nWFNlndWHtRIHNuwW5klic
	yhNtvCuVrwfqP5ES74/bgdoXdASf9ZhJ2u68TFppf8v2zNthXIAL5vKu909cNxwT
	xcD9BcfojrVAr9WvZuTb1D8m0GcRMiFb7aQgZocWAIW/wJr047UY8ceWY6IkP+v/
	PSqUtoLCYpHtVQ8alPrZ1SV6RZkPLdKUbPfHvpeE1XrpR2+Qg83LiC9UUGcJJm8z
	4cVJzn6shmR4RL6feiiKrPVgQmCc//56qY5NWHteBFw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v7t3b4fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:13:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59KJDSmL026414
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Oct 2025 15:13:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Oct
 2025 15:13:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Oct 2025 15:13:28 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59KJDEd1013249;
	Mon, 20 Oct 2025 15:13:17 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 0/8] Add SPI offload support to AD4030
Date: Mon, 20 Oct 2025 16:13:12 -0300
Message-ID: <cover.1760984107.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDA2MiBTYWx0ZWRfX90za4SV46K4c
 NoxXPluWvXxDYZoEBIGlcmYB4OGZ1EuNojcxk4sdJE3s7Oo7Wad6oz2ACzoqf3uOfcqT7YuijIq
 cGscQD9qIuGpZ6+LKGDHHT7GQp4G4Im/BzJVDbkGfhNJHKgKfdzfpbJmrgcGaNN8T9UQ106ISMv
 4wyII6aBs7IZw4R8oG3DaS12DTnu1fcbpqF+oX72/Ly+aWrnDqVscRLALg0NftzB7xZLcUqN5z4
 J15wlinJRtx5dhzRzDxOqdvOc76MefL9OCIGEoUI2b5u5KGfhvAMI218FIGpVv/MscTWE2Y5q1j
 LEavqF3yrVaQ8rfPsnofiyrkVSv67qHge1Ru8p5VEtbD56S4Nfe2DqW55fAW84lnv6BGvbc+Kt1
 AoxmKiIVNtiYxco1MHe+3ovTygezFg==
X-Authority-Analysis: v=2.4 cv=UPPQ3Sfy c=1 sm=1 tr=0 ts=68f689d9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=te3JqoWVX6TxUQVAJjQA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: jR3xD3oatN1Rg3gMhXcM7b4w5mvwzMd0
X-Proofpoint-GUID: jR3xD3oatN1Rg3gMhXcM7b4w5mvwzMd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180062

Hi,

Thanks for all reviews and suggestions to v5.
I believe to have addressed them all and here comes v6.

Change log v5 -> v6
[DT]
- Picked up Conor's review tag.
[IIO]
- Adjusted comment on list of average modes.
- Dropped link associated with Suggested-by tag.
- Fixed IIO device number of channels in base offload support patch for AD4030.
- Dropped st->offload_trigger check in paths only reachable with offload support.
- Adjusted comment about sample averaging and sampling frequency configurations.
- Dropped redundant parentheses on declaration of ADAQ hw gain table.
- Dropped unneeded cast to u64.
- Use constant for number of ADAQ PGA pins in error message.
- Picked up review tags.
- Re-added common-mode channel for offload setups in a separate patch.

There is a patch to the SPI subsystem [1] that contains a feature required by
AD4030 offload support.

[1]: https://lore.kernel.org/linux-spi/cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com/

When that patch become available in an immutable branch or similar, I'll gladly
rebase this series on top of that.

Thanks,
Marcelo


Marcelo Schmitt (8):
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Support common-mode channels with SPI offloading

 .../bindings/iio/adc/adi,ad4030.yaml          |  76 +-
 Documentation/iio/ad4030.rst                  |  39 ++
 drivers/iio/adc/Kconfig                       |   5 +
 drivers/iio/adc/ad4030.c                      | 658 +++++++++++++++++-
 4 files changed, 753 insertions(+), 25 deletions(-)


base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
-- 
2.39.2


