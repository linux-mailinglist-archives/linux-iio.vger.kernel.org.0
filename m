Return-Path: <linux-iio+bounces-27053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B5CB92E2
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 16:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25A830D6843
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850AD31ED88;
	Fri, 12 Dec 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="auMhWcd/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173A239E97;
	Fri, 12 Dec 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554154; cv=none; b=S6eCvNte8KmFiK4R4kuClvExurnC8tMwWiGQOMDZraw+fB9dncCr/BubFqKbIlAjB1355EeYfv7HBAR0NG2rBn/CF/ds+pI/tlPwzu9iuDDyNIKru8UBmIWRMWPDEf6xN7BZjz11uUgKx38coi05bkq0A3filpaPJvxC822qzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554154; c=relaxed/simple;
	bh=A7S1m225m7dPOx4uWG0isST9OlDzlu89DU7VFxA/uwk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HXauotdORV2AOKM8rBA7+zkyDs1x9hMO/5dPTBSDI6IiAvFd0MfUUqWu4WCZfGmPp7B3epa6u+eGkp8Jkitl9o8iURvb/z3FtwHYSIpD7CjOsQDozesVEtRO59bsthIEaXpKLouk4fPGQPBGZ4nd415zUnbJ/mybCdZ5mFf5Vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=auMhWcd/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCBwN2U3366631;
	Fri, 12 Dec 2025 10:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=UrpX8QvRwUPayOcpdcwh01CSq5f
	3pvgyzbd3tIlvvrY=; b=auMhWcd/Snt50rT/KSaCYMYGre2J8zln3pYVbue8zKf
	STvvKKh2vlxlo4Zd5WKcF10+mxsMj3LxJnKt9TV2R5K09H9khUpHcMA2AwQWk6gd
	DLy8qXiZeMmb14PAdnlwz03//3IjGhV/mcry8dCPCf/yYajx9Mh5tvyhrMVce4Fx
	0btmBO9lxj7tyeDGnjMBFi2yE8P79IQgqbMxQGDkZnlLe6RuB0zYI862c0CFLUjc
	g00ZOqde7cpSBMm8tAQ77dL14ADEJ/ude7gaRhTGceaMMbsZgmUixnkS47zd6/Ik
	ioQbf4JBnukGo2XuqmRNr0wYr/eMZ4HVW1KCfYc7iFQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b05uhm8p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 10:42:18 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BCFgHer049171
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Dec 2025 10:42:17 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 10:42:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 10:42:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 12 Dec 2025 10:42:16 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BCFg2oS020112;
	Fri, 12 Dec 2025 10:42:04 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
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
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/2] iio: amplifiers: add support for ADL8113 Low Noise Amplifier
Date: Fri, 12 Dec 2025 17:38:24 +0200
Message-ID: <20251212153908.138422-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: BdRdcifokiLFiDQbJASxvPvU8WxC1FBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDEyNCBTYWx0ZWRfXwg+/M/gFIzaX
 JpNohMxkblPPaKWNZ6Y+bV06ENdFkcUgxzQsVgIpMl2coawULTIfGLlZTPK8xCGQPE8tRy8Q7Li
 vcb7mwiKx+46HeCCQQWbRCTcGj3mYw1X0tLt3NqwLDV3XfdKje+VZEfDY5nppY1vtZo5MSgGKIx
 c1rARsRGFB5NpKXU9qIhs5tZLzGp9J9APUlWAQMUut8riXSyBExWwXMn8p+H06Xx21YRAGUDpto
 62+tyH36xpUBWZ8/lfql7w7toAUYkAd6cHiRfMNNSvhn4tEcQWEDlLTZ6nIS4qjHNvAx1sFVwGh
 wrnEyuAtJBdJu41TaS2K4foT1hgHqrBalItmI7CzZ8ea1kF12nC25kS9Wp1Pl6G7amqC0hRGazM
 zQJR56ARRmnN1qVwZs5PVOobfSy0lg==
X-Proofpoint-ORIG-GUID: BdRdcifokiLFiDQbJASxvPvU8WxC1FBR
X-Authority-Analysis: v=2.4 cv=DeMaa/tW c=1 sm=1 tr=0 ts=693c37da cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=_jDn8YihPVvimUYNn0YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120124

This patch series adds support for the Analog Devices ADL8113, a 10MHz to 12GHz
Low Noise Amplifier with integrated bypass switches.

The ADL8113 provides four operation modes controlled by two GPIO pins:
- Internal Amplifier (14dB gain)
- Internal Bypass (-2dB insertion loss)
- External Bypass A (configurable gain) - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
- External Bypass B (configurable gain) - Signal routes from RFIN to OUT_B and from IN_B to RFOUT

The driver allows selecting between these paths via the IIO hardwaregain attribute,
with optional external amplifier gains configured through device tree properties.

Antoniu Miclaus (2):
  dt-bindings: iio: amplifiers: add adl8113
  iio: amplifiers: adl8113: add driver support

 .../bindings/iio/amplifiers/adi,adl8113.yaml  |  87 ++++++
 drivers/iio/amplifiers/Kconfig                |  12 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/adl8113.c              | 269 ++++++++++++++++++
 4 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
 create mode 100644 drivers/iio/amplifiers/adl8113.c

-- 
2.43.0


