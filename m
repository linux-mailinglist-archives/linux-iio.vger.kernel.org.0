Return-Path: <linux-iio+bounces-12805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3D9DE70E
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 14:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C1E164F2C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3919E804;
	Fri, 29 Nov 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UiOLbgIr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91F19E7D0;
	Fri, 29 Nov 2024 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886042; cv=none; b=mEeC2nl5G9r32xHK+cVGK2A/NY4mITwd1Ecr2yFH56kWjsqr1HxZidWMcSajnjbUiuJzjoMVyZtWddv3r5Ic0WIGYEAr5o+G+Yh/sqSEdW7E7sg0Gqv3JbuJDEoErSisUm6z4JT2HPej/tSloJteAgmecrx78ty0TLbsAssgYF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886042; c=relaxed/simple;
	bh=MhDXriinalpNr+V/p3gCLOYLmh5yVPXLt+uAcLHPNiE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8nWAFj40z+TkDo5IbGt9Zt58XZbXsTI8dbuLM93VeD8A0SEdaMsODzIrdraoldtez1vFJ82u3645bKOYJ24NaHXSWA10iatMLgJRvGiir9bjkOjLfsQjULRbzoONyG3d9yU6g0IerDJZ99rQBvhJ1PP/e4bcinoR33wVx0NK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UiOLbgIr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATBku2A018125;
	Fri, 29 Nov 2024 08:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gOwni8TXokS15RCv6YxyJiH8bwP
	XyoCaPMYem5f0jek=; b=UiOLbgIrWl6Oq9yTGwNGSY4ph2UKNeAkm/HSvQCdHwD
	6iPJTsf2ER/7jIFa+45ld4aay4Rko1PjV1hEhkpNffMqMLSAvlIPpnGzNv3ggAMu
	hZz+OlLEJcw1eQqGZf3p5pCIy1FaExMSeebqp5dnEzNpT83kRWvb8rchjijNELO3
	aAbD0YA3YHr379qHc96bzkR1k6e2dtaR/W2Bf6LMG99Wu2G6e9oQzsMhrfg44Oly
	VzEnG781ySxjM9/kis40av5NgpkXjqPYubd3T138odlt0/P+Lp7RTZSeCN/7w5mm
	lJ3lRmrZdSSueCXNZs4ZE0l4nYlLxmi0CH4hyLeKfUA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 436715t0b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:13:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4ATDDXUh047457
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 08:13:33 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 08:13:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 08:13:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 08:13:33 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATDDLs7027156;
	Fri, 29 Nov 2024 08:13:23 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 0/4] Timestamp and PulSAR support for ad4000
Date: Fri, 29 Nov 2024 10:13:17 -0300
Message-ID: <cover.1732885470.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: Ex1scHEu2xRMN87rdoQTfcojG-Wt80AB
X-Proofpoint-GUID: Ex1scHEu2xRMN87rdoQTfcojG-Wt80AB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290108

Complement the ad4000 driver with a timestamp channel, a minor adjust in
transfer timing, and support for single-channel PulSAR devices.

Change log v4 -> v5
[IIO]
- No changes.
[Device tree]
- Added const items for fallback compatibles.

Change log v3 -> v4
[IIO]
- No changes.
[Device tree]
- Sorted compatible strings in alphabetical order.
- Left only fallback compatibles in allOf check list for adi,sdi-pin property.

Change log v2 -> v3
[IIO]
- Reverted to direct assignment of ad4000_time_spec structs.
[Device tree]
- No changes.

Change log v1 -> v2
- Added Suggested-by and Reviewed-by tags.
[IIO]
- Commented the removal of unused AD4000_TQUIET1_NS define in commit body.
- Made a common macro to assign ad4000_time_spec.
- Explicitly initialized PulSAR t_quiet2_ns with 0 as those don't need any quiet time.
- Improved PulSAR support commit description with more context.
- Dropped support for AD7694.
[Device tree]
- Made "cs" the default adi,sdi-pin value for PulSAR devices.

Link to v4: https://lore.kernel.org/linux-iio/cover.1732660478.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1732020224.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1731953012.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1731626099.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (4):
  dt-bindings: iio: adc: adi,ad4000: Add PulSAR
  iio: adc: ad4000: Add timestamp channel
  iio: adc: ad4000: Use device specific timing for SPI transfers
  iio: adc: ad4000: Add support for PulSAR devices

 .../bindings/iio/adc/adi,ad4000.yaml          |  59 ++++
 drivers/iio/adc/ad4000.c                      | 311 +++++++++++++++---
 2 files changed, 319 insertions(+), 51 deletions(-)


base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
-- 
2.45.2


