Return-Path: <linux-iio+bounces-26791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FFECA7FC5
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E215302A2CE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E3427C866;
	Fri,  5 Dec 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qqjLchFr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485891DBB3A;
	Fri,  5 Dec 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945590; cv=none; b=eXJNIw+q2uKJGOvhs9pTpkbtltj6seOQ7VsUYzuhJg9abulABNVlWXOU8R52dK3q94RqIRnLV5fKpcrs7fX9vR2HG7XVrfZvm4Sv284qDiBFxwgpTzPbeUS5Jwkl/pf88If9k6e0oZoh/F7hXThAoeX11TIYfCSv8BgTktXN36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945590; c=relaxed/simple;
	bh=oUmMnc8xejYGbc2lGoFWiVeGVU9QA8ZrQPDfsp53xew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRmXFivU2B7ANsOJu/PEu7ADUM4yNPRiUrxiSqdRuUtxiuJIvq5zbXken9bGd6UFTKECG+Den1PHirYULfuVCL3hbkGbmUEw2h1KGPkP5DYJ04to1mG4bi0J/ZWGBxNCx2h28QGw1rrvw9jLNMULTpI9YVIu/70dPZ3U9ZhMWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qqjLchFr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B59R33E172678;
	Fri, 5 Dec 2025 09:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=8x93ym73UQhgTalxOGTeQlRsQEx
	TkCbFm/bOlHOQ22E=; b=qqjLchFr9VlN4pinlexcef0uXc5Q0nclBpnJxgABAaK
	n3sNv6bNmXZEv542u8uHiddPDOSK2zVFfPN0TIckOUFxCZrBRt2yqUyWOj2B1J8E
	tnXF9tWWwYGkBfegjLD2BMqRO5b9SpREzmmU+D56XyiexPFg0DBCnigsyslWHb9E
	L6feQ/DbuLP1StrgR9HeQvb4lqYN5mBFG3SErrblqto9XIAuNBFCAC4bamcAvFTs
	654aodlnwfEw0/fz4BdCLeU409408Gpqeu4WrArO1NWCtHFoHerDdaPHaLM7V1L5
	BI0tzS2Xa8hubqX42zId010TKsQDQcdsjqceQXSVAdw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aufyscg1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 09:39:18 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5EdGdT029269
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 09:39:16 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:39:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:39:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 09:39:16 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5Ed1pr027828;
	Fri, 5 Dec 2025 09:39:04 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v4 0/2] This series adds clock provider functionality to the ADF4377 frequency
Date: Fri, 5 Dec 2025 16:38:44 +0200
Message-ID: <20251205143848.989-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=G4cR0tk5 c=1 sm=1 tr=0 ts=6932ee96 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=TbiDcMNEsNnl46sf-WwA:9
X-Proofpoint-GUID: cCNnU-62KSAz94YmDGuXVuFCNsMvHPr5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNSBTYWx0ZWRfX1kSf3rRw3U/1
 yatwm9lelO5M1g6Eu/5lIokNiFJO7XXRQT+/OXU+KJmUDJByXrwDfoaFbC4dj5v0D8pshRk6pHp
 v3vmn7JzPxpCOhLVIlQmYaas0gW01Uom/oLzve6SrEWEeRZjmdZDhVKUA5e5fN4pMvkX+dVMng6
 qSJ5OU1Rl2D5U6YR6HYRml1NKT7Kaw4OKKNmtB9KNNzGRnhld1eYT7Zu/g2Af9hcFWowlGZZB1M
 gLYmux9CIc2GOvGxJ6BOAGqUv/WScl1uL2zLlF5CkjcNvnKrvIV+wN2B6d2GohEUIZD4oYc9S4F
 jXcoEx3M7FQ8jgUCIRXdMdchi4NUrHB49bLAzz0crdDdq61kbW5kQKefaTHGYCS5JZUWRTcL89j
 +xkbClDjm2+Esopd43sszMKimZAvqw==
X-Proofpoint-ORIG-GUID: cCNnU-62KSAz94YmDGuXVuFCNsMvHPr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050105

While implemented as an IIO driver, the ADF4377 is commonly used as a
clock source. This patch series enables it to function as either:
- A traditional IIO device (when #clock-cells is not specified)
- A clock provider (when #clock-cells is present in device tree)

The implementation provides standard clock framework integration with
rate control, enable/disable support, and maintains backward
compatibility with existing IIO configurations.

The current approach follows the recently accepted version of adding
clock provider for adf4350 device:
https://github.com/torvalds/linux/commit/a1a09713b40dfc1c0b7d1f9233a7698c93a9af05

Antoniu Miclaus (2):
  dt-bindings: iio: frequency: adf4377: add clk provider
  iio: frequency: adf4377: add clk provider support

 .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
 drivers/iio/frequency/adf4377.c               | 121 +++++++++++++++++-
 2 files changed, 127 insertions(+), 2 deletions(-)

-- 
2.43.0


