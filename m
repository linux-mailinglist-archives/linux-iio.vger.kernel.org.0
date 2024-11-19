Return-Path: <linux-iio+bounces-12401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97B9D262F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 13:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B576F2846E0
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836461CBE9B;
	Tue, 19 Nov 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UtSv5NgW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69A1384BF;
	Tue, 19 Nov 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020835; cv=none; b=HFm6hXvYL3VxsAcznzIZfgJhc4Jqy7Au992WbTMVwV2cFG5ed42OpjjjtnxM0Glo62AjaZgWJjeTbbsJuaIwlr0MD9nRYpEIVxh4UZeVz2g5rkrxSuRmizGZF/7kzSZ4nIO9vLwgSOHnA/U2LR6wr0Uh/ykVyAf7U2yvwUoin4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020835; c=relaxed/simple;
	bh=WbijTlLuxpkWpdsD3x3JP84s5e5L3ZuB1ZIlacG8FSE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gNWOEDRAaT9fdXFGH/PCOL8+Y3zjXzaOhySN3g1REoW6XAUUr39x5zVSgFB4U+3LdupGPRop3zXe4uS9aNZ830RVoVGpHMbAi3ppbv5+o/CZhj8oKXl5GUUA438sE0FshphU+MuN1hM4zpNsupAS2jQQSLFPp5GSUho9MGVUrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UtSv5NgW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJCKPWj020192;
	Tue, 19 Nov 2024 07:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=d/fmtXw+xu9z4a6CohZ5c0LZ7Ek
	0JpzhOkkC7fKh0uU=; b=UtSv5NgWA4B2JZlrCKLHQp5bT0A6pZnmSxF2vzhGMhp
	/mFfuF+o1cAahyf5jRJEXqkWotF0P4fH3u1fw+KxT1MfK8DoeILDpZ6wOR4bo5+n
	IciCnTuVFgJbX6yI+5YI++lmmq3Def7mnyPjSJxdrTzns79nc2N58MjTItngg9tt
	dU5/1AtHXVZgt6exxOSAG59oLud1dZSKm9NnGWXVOp+z15i7kOgTnKklanzgYRB8
	hMnLB7HvVbDy/3j/8gdWTvKX83MCnx0xbIDsLcmLaVFcZUJmAuMwEfPfnXgGHcD+
	j/Q7IhE/TgCoPYSUADjqMm+i/ZXlMdUY5YAfCkQQlyA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43025m6h93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 07:53:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AJCrbLg020204
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Nov 2024 07:53:37 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Nov 2024 07:53:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Nov 2024 07:53:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Nov 2024 07:53:36 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AJCrOTZ007305;
	Tue, 19 Nov 2024 07:53:26 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Timestamp and PulSAR support for ad4000
Date: Tue, 19 Nov 2024 09:53:19 -0300
Message-ID: <cover.1732020224.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yu27W09Z8PUvMZmwIqILqqMoC8lC3hSl
X-Proofpoint-ORIG-GUID: yu27W09Z8PUvMZmwIqILqqMoC8lC3hSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190095

Complement the ad4000 driver with a timestamp channel, a minor adjust in
transfer timing, and support for single-channel PulSAR devices.

Change log v2 -> v3
[IIO]
- Reverted to direct assignment of ad4000_time_spec structs.

V3 had very few changes so I only (re)tested it with AD7687.

Link to v2: https://lore.kernel.org/linux-iio/cover.1731953012.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1731626099.git.marcelo.schmitt@analog.com/

Marcelo Schmitt (4):
  dt-bindings: iio: adc: adi,ad4000: Add PulSAR
  iio: adc: ad4000: Add timestamp channel
  iio: adc: ad4000: Use device specific timing for SPI transfers
  iio: adc: ad4000: Add support for PulSAR devices

 .../bindings/iio/adc/adi,ad4000.yaml          |  71 ++++
 drivers/iio/adc/ad4000.c                      | 311 +++++++++++++++---
 2 files changed, 331 insertions(+), 51 deletions(-)


base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
-- 
2.45.2


