Return-Path: <linux-iio+bounces-23171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7CB32D75
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 06:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C35F447AAD
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 04:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93E1E1E12;
	Sun, 24 Aug 2025 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AXAUr971"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E72DDA9;
	Sun, 24 Aug 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756008620; cv=none; b=dKF3C4Zl4PH/4xJo9+0elUbuXXm4iqj0bwAC/SHMda/PbmgOImaJtc9Bv3hEil7vS1dqz3p0aq+EW7OPRWztxubNqEpf+shcAGmGSmSFxW/HdF7AGEpYHPc8BagK8zARyw7/EmV3SRuk0jXQ4WM6lhF3Gsdc3aYYPWxRHA78ELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756008620; c=relaxed/simple;
	bh=jq3F1zDJ2yZcCXOErAn7hE/PCpZ6bt+ZlM2OukJrQQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rVk8Y9I09mHb0Pgy8GT+sFDGpJKbg7dJ2SqSlFGXaAx6FveBDuG+LFsiyk6zilDwuBuMKf5TnKCxGWCeAujpeE12kcxUYkbd6GuzByehjGayl3Opqe03slIIHp+ngw0hS6bfxQzSGM+Y8ZlQgoE2+XMLzbmJ5iH8XbSgCqf8Sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AXAUr971; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57O1Y6aZ016602;
	Sun, 24 Aug 2025 00:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=cCWLrFENcMrCC98jYhox49b/WLG
	aapMV8dVSyXpwcOk=; b=AXAUr97176CA9ML9FGKczKxDIQL7+a1F8LGbf2TrSyC
	tD12nexeVohkaEUMscDj/N/RIA3FtvStyWO02ta99v4RMWZ7AvDEAP1oXhoHTx7V
	OGxCtzlgm2PGMnyRB97Zw5/5WgfnZVvDjtNjInK9aOgSMBPCoICXA2ceKnpGgbu5
	tMTIVaptAjtP+7Sirep660qPZ0xqIZBI4hn/BRifrZYxFwfde6lnrMNOJg8PFDLL
	P0JY8E3ccgw96jycSNYpCvAKL28k3OwPQc7DQK/qBIWyhgM/5H3lkD1cvrfYiXks
	CEV5juA3FR1kfJ2sB87oNVeF658sFeqP1fmEqcGgErg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48q5uhktj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Aug 2025 00:09:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57O49mv7051698
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Aug 2025 00:09:48 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 24 Aug 2025 00:09:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 24 Aug 2025 00:09:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 24 Aug 2025 00:09:47 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57O49YM9006311;
	Sun, 24 Aug 2025 00:09:36 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/4] Add support for ADAQ776x-1 ADC Family
Date: Sun, 24 Aug 2025 01:09:33 -0300
Message-ID: <20250824040933.9134-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfXyN4on4XJvT5f
 gxjEGuQhN/gdsKX8+RsszZxU2JZCbLGd/M8vB7DkRZpa/Qmq1j9oUyCg7Tn9A+39aUqullYhmKi
 HtgzUtCZyJnoI9BDcQFkv5vJ3smiQfjH4Sv6rBxMt/fMWuVBjQkLtB0qHr0gwzLtONcCGHJ60FB
 hVp14vGccNsSZWqIZSL7sI18BDFAr6MX6SJ/YFLltTDRkk3Xi/VOnGivqnC8CPllzbMmIOaF1Df
 Dr/jopsdK63/3ddRPIrs+rzwbu5LdpiwJ6EVuJTyeBT2LYiGAcohBv4mB54sInY6+BuO+lxFlZb
 ZhHRPy7A7R0B6JdwKwfCgB9+/9X0ZwzG8AbHtm9jqBq7muBpkDk6lEo1dDtBCYwcnYzekTbR+EQ
 mJ5ZlfYw
X-Proofpoint-ORIG-GUID: oau-2dlmdTg02khvktFce47swSoYHgka
X-Proofpoint-GUID: oau-2dlmdTg02khvktFce47swSoYHgka
X-Authority-Analysis: v=2.4 cv=S8XZwJsP c=1 sm=1 tr=0 ts=68aa908d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=uFM56Sq5py_6AZWyf6cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

This adds support for the ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1 devices. 

The ADAQ7768-1 and ADAQ7769-1 integrate a programmable gain amplifier (PGA)
with 7 and 8 gain options, respectively. The ADAQ7767-1 and ADAQ7769-1 
also feature a 3-pin selectable Anti-aliasing filter (AAF) gain.

---
Changes in v2:
* adi,aaf-gain property renamed to adi,gain-milli. Default value added.
* fixed some commit messages. 
* Added 'select RATIONAL' to Kconfig.
* Added lock to protect PGA value access.
* rewrote AAF gain check and replaced error returns with warnings.
* Addressed other review comments, see individual patches.
* Link to v1: https://lore.kernel.org/linux-iio/cover.1754617360.git.Jonathan.Santos@analog.com/T/#t
---

Jonathan Santos (4):
  dt-bindings: iio: adc: ad7768-1: add new supported parts
  iio: adc: ad7768-1: introduce chip info for future multidevice support
  iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage()
  iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  43 +-
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 396 +++++++++++++++---
 3 files changed, 384 insertions(+), 56 deletions(-)


base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
-- 
2.34.1


