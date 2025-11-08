Return-Path: <linux-iio+bounces-26045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B48FC43247
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98A91888BBE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C71265298;
	Sat,  8 Nov 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EkHBkyB5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8F26B760;
	Sat,  8 Nov 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623860; cv=none; b=e0qr+7VfRiCxhZHMMuyARCvAh/TYggaHqMqixsnN4Nw5i17ML8d0WbLncDnf7eaeti3GZjjvlZ66/65irMd1NRHFqjDm/IvJqnssvu/KQr4VrJH/Fm4aOi923dx75C3MXixBReuTPhqrXKWNfFdvNJstIMbYjjKBeKVIl0CVStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623860; c=relaxed/simple;
	bh=Re4S4dKXRVbaERIxDtE0E9AJh05tyQX6I3uSsHystLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EYs7aYcEYumIeuCZbos5AiCO2oc+15AFvf53r5/ZyaJaxpc/++M4xVjaPAnNwEfT7QUuiynPKouEqVaiGPJOi5UJbzmc9PEV+tBrKHwrGsCe9XpRu9Fzzv49fd5INkLdap6LrVIZEEpRt8W3CMZBHcfZp91+5RLs6rQZGalijws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EkHBkyB5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8G44df4004370;
	Sat, 8 Nov 2025 12:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gd0P/sgSuKsR4NnPk6hh4Wk7H8F
	YLqZ3RGcaXbDm+oA=; b=EkHBkyB5/WTOUJY7f9gjk/q5V/MThHhFcjjgBChnD/v
	CoKcgj6JEqDzVQMQfiy/iL964eGi4BAs04ZxGmagHZv6LPitCHYTJX+P4VCaM00I
	Z+6CWHYop/4T31Buu6ebNRVjsDmxnYnT5LELMvot3zCBC2zhzV2efObJxBh2XqxE
	wBElnGg3NWbF/GlLrzazFrRSdT+mAHz81aoPNiUm+7jT/KpHHaFfsNG0j6pTVrug
	DM8olg8RAnQ9N3opNZxhOYLIDxzQ+A5GwiE1Vf6SAFmV9yvnPZXRIHjLPWBQ1fT+
	bh/BJJzu4Kbjf0VttN3NEIhekwpAIKqpIPnUN4NPpgA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aa3n69cd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 12:44:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5A8HiFlf030843
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 8 Nov 2025 12:44:15 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 8 Nov 2025 12:44:15 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 8 Nov 2025 12:44:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 8 Nov 2025 12:44:14 -0500
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5A8Hi4Xh028553;
	Sat, 8 Nov 2025 12:44:07 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 0/3] iio: amplifiers: add support for ADL8113 Low Noise Amplifier
Date: Sat, 8 Nov 2025 17:43:51 +0000
Message-ID: <20251108174357.3748-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JoD8bc4C c=1 sm=1 tr=0 ts=690f8170 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_jDn8YihPVvimUYNn0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: _9PaFGoK8wF1TSrJE87n40czZtHm_p76
X-Proofpoint-ORIG-GUID: _9PaFGoK8wF1TSrJE87n40czZtHm_p76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0MyBTYWx0ZWRfX3X9IB4E4CBPN
 ZVRwnYhumqkakqmhBBf3mI3kV56AXFwqsv3dC6QOco0T//tNn+pu4Dr8Mjj4dOgk0bH+oNARp9x
 UOGdOgDJmcy24ZiaM+ycHwPS+sXjBNbYKGagV/3nOaBwatAl5d30AJ4PHD4oXtTDnLmvynk0znU
 jhJulxrwU9haUNV5jE1OERFU8bHUqe1g4OCxLgAadTEDLJwF9/MgM+558X5jYP7ANJ535cLvNoz
 kRLACCllA7nksk4/RpOFxTRSDdBnoB84ZtJr0xX+DTe3H2symd7jWptuXCVaD+HGKoY0ddy8OOY
 y6GUXTMBTFSsib4St0SXeTXriwwg30U1PUhMM9+WINv0IbAu/Wpb67Prt9FgivkqfZpIrRlLKdH
 50WT/p2pzalvvbXc/dYcGIqPISf5Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080143

This patch series adds support for the Analog Devices ADL8113, a 10MHz to 12GHz
Low Noise Amplifier with integrated bypass switches.

The ADL8113 provides four operation modes controlled by two GPIO pins:
- Internal Amplifier (14dB gain)
- Internal Bypass (0dB gain)
- External Bypass A (0dB gain) - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
- External Bypass B (0dB gain) - Signal routes from RFIN to OUT_B and from IN_B to RFOUT

The external bypass modes enable external signal processing, conditioning, or filtering
while maintaining signal integrity through dedicated signal paths.

Changes in v2:
- Enhanced documentation of external bypass A and B modes in device tree bindings,
  clarifying the signal routing paths (RFIN→OUT_A/OUT_B and IN_A/IN_B→RFOUT)
- Updated ABI documentation to provide clearer descriptions of external bypass
  modes and their signal routing behavior

Antoniu Miclaus (3):
  dt-bindings: iio: amplifiers: add adl8113
  iio: amplifiers: adl8113: add driver support
  Documentation: ABI: adl8113: add documentation

 .../testing/sysfs-bus-iio-amplifiers-adl8113  |  32 +++
 .../bindings/iio/amplifiers/adi,adl8113.yaml  |  65 ++++++
 drivers/iio/amplifiers/Kconfig                |  12 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/adl8113.c              | 213 ++++++++++++++++++
 5 files changed, 323 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
 create mode 100644 drivers/iio/amplifiers/adl8113.c

-- 
2.43.0


