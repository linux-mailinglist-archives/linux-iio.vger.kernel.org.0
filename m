Return-Path: <linux-iio+bounces-26794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DCFCA8007
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F36E43060197
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DEA3254B2;
	Fri,  5 Dec 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="N6uox8N5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340731ED9E;
	Fri,  5 Dec 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945972; cv=none; b=IqqyuhPaauBTRSMwXGfk65XALsya5zTSmFamX26wmNFGJc4AqBQox3+mRxpJkaY+5i4hHW5mvfh2pT9o4Bd90SWDFtQbhXqqxX82YifOuof3ejuoRVzYhRUtosgqmVBaKTwuMEQYXAUDc+dbEnDG8FG7vwBDs97DBQSYylDx08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945972; c=relaxed/simple;
	bh=jsE+RkVMP7nN9WNKqqv2OiZe39i7SZcHIIDcWGCQfGE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WfbdWGYv62+dUAcWBdzkZaPGV70yX9cFPMDbaPa2YneIAebzPqI6oErtQ1wFGjHWvUpkUaXbIB9Wq7x5UIx7HxICe5SbajBH/TYihcQDzjCoEnV4Cu1P7ZCvJaeR3887WM6o0rOhG1MmBlP1T8lvg+8bxvQI2QjKSWqor0aOaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=N6uox8N5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5E7OwG172682;
	Fri, 5 Dec 2025 09:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HImubeP7FLWsbqtaXs6Vaz8nY6d
	9eIKYZE6XT6Vp2/I=; b=N6uox8N59Ei+1G1wveqCQfaSRDbMhbhLEvSS4Y0cIpE
	xPsVNoW7qKqnA9a4UPO48OOSaezQNr0Iu4V59x5Pt2usoojvID9IkGguwEl+Ue9J
	n0LD6ZQpyuKH9Yldj35IvkKQyVtcMmicTbSc21ZbgyRSPtM2N+2J8gcePh1Xtefz
	KESeSXj7auaKWXQX9jFvEV0qEKbEVEezsu7gAVee/Of9BDysSZ/gQhzndT/ZiCoh
	swkpEQibAfN9AmpBr+sa/8l82HerTToAoY6gMlrehGK1I006jkCY7Bra0wjA5kr/
	gTJ/cyNuNfg5p2KBWMEF/ZxJ7cG8NZrWNzj8gWZzq5w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aufyscgx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 09:45:47 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5Ejjct029896
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 09:45:46 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:45:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:45:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 09:45:45 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5EjRaY028130;
	Fri, 5 Dec 2025 09:45:29 -0500
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
Subject: [PATCH v6 0/2] iio: amplifiers: add support for ADL8113 Low Noise Amplifier
Date: Fri, 5 Dec 2025 16:40:39 +0200
Message-ID: <20251205144058.1918-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=G4cR0tk5 c=1 sm=1 tr=0 ts=6932f01b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=_jDn8YihPVvimUYNn0YA:9
X-Proofpoint-GUID: uToOZ9Bao-Ur8BYuQ5VQI4TrKrNoHJWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNiBTYWx0ZWRfXy7SDWe/jzkht
 dkczdErZA3YZwxwUi3jlgVof2Tjjh0aRHbm+aBzCNbYlTCfXkNpBUcdcoGoMaPim4+t8PJ9EAsM
 TLo7pDup1BsHXSx/PNpcmuAjdWTkLs+O/gE9tLtZJjbzsxmJZ84onXO27aYud+IHghhbAziLr6U
 ItUFhT8HEocPyWOBjao2NdJlvSQ8WuaKe+2rtAwb6BvKNg7TigziyYu4m8op9GcdhW1etJg2ldH
 KE61C30eDnT0YF8g5VH+zNEDTpehNfbnhRVseT86QJ72bHEiPh2GBndjSSRrNgeLiCU8yXUYKQD
 fPohhkoBQYp5y/F61IT8nCdhfcF/EFIUtShYRvHG9RwZxX+7Ko1VxDh6e+DBm4aw0gQ/V5WI8Pk
 2DeTA2BCNtJ6JqnU1XvP/2bbsXH7Kw==
X-Proofpoint-ORIG-GUID: uToOZ9Bao-Ur8BYuQ5VQI4TrKrNoHJWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050106

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
 drivers/iio/amplifiers/adl8113.c              | 290 ++++++++++++++++++
 4 files changed, 390 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
 create mode 100644 drivers/iio/amplifiers/adl8113.c

-- 
2.43.0


