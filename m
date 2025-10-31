Return-Path: <linux-iio+bounces-25763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F0C26068
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12964F518D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3F2F1FCB;
	Fri, 31 Oct 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sDaaXJVv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327F2C3774;
	Fri, 31 Oct 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926674; cv=none; b=casMFgJu77S8+mM2/3Gt3Qua8krstXjwIHuPJUDps7AfNLBo4Psu6LQkHORxUAUWa8cbmEHDWi5h51tWaIpRI/lsnRIladLzFc1RpLtIP7W4J7+jQJ7tl4DD8SueCVatBsQd+jxI0ZliO64+yT83cDpmW31uuQ/h71XnpgKsM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926674; c=relaxed/simple;
	bh=7AQo1vY22HczKSnd+iC5EmH0SlgyXV7nIFXh3/k5iRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IHFBjQtsXJey1gIORBjjdJ9n+bovwSj8aWPMLRbuCf5i8+7usgO1CPASNbMH9VdE4AOtyJXyfkgN6GEX2gj4gxnnBqtF03vlLEh/Wq1kCBgUJJhX2sR6SpRVXIH750RRp0ZjVc8IEmCfIp7u8Cc+H7xTGjt0dxVzxGoCMQVC61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sDaaXJVv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VEE1Pg1108548;
	Fri, 31 Oct 2025 12:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=mFjg5ahC32+3HBG8ud5rqvVpfUn
	0GsUisqVjTP8LKfw=; b=sDaaXJVvAof8uMFKV29lA9Qx3jnk/sVFUBNUDacj0xx
	rjGRFiE11PbOK/gQ9NYYSEoCcHGoOKtQLdZl5mPqE9el5RQZqmeA6isuK5Ul7U+j
	ItTaeuJXG07TXltf5qvhrf7t2qtTtOJGosM4Mfq/MSFJRFLY4Auf+8AAL+PSmCKz
	HIx3yykeSfGtyEEF+8O42dzDWMyEVSDRNBDcw4SECIkO7VC4naPIjKrhsFgyHv+Q
	aagyagVwwqLeFguBcR6vv4ZzlUcwsAvucCXrmumgdnUS/j8OLQ9WqkfiJD4qJS93
	MSKkmyD3/phUiWZx6W63PsyRr0Mv1KpXkZ+cD7GDWQg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4a4p8atvf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 12:04:30 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59VG4TDu064367
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Oct 2025 12:04:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 31 Oct
 2025 12:04:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Oct 2025 12:04:29 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59VG4K1K006874;
	Fri, 31 Oct 2025 12:04:23 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/3] iio: amplifiers: add support for ADL8113 Low Noise Amplifier
Date: Fri, 31 Oct 2025 16:04:02 +0000
Message-ID: <20251031160405.13286-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=R4QO2NRX c=1 sm=1 tr=0 ts=6904de0e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=_jDn8YihPVvimUYNn0YA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 1Jh6jCTeWcW8bB5NaGMXxZDbuFKgwoPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0NCBTYWx0ZWRfX1guhB4Yv4VIG
 700LUBS3SJlGDDjyuW5amR6mm5qAjxxUGL9JWQp0DM/Fbk3AlHPGhp4013ofspIPSG01SKgNhgk
 lrB2vFV3wVU/CIyz3aZ0ES+gDG3Q6yWC+KluHsOY361mpX3Zh5KDBOiHHaMGuWAVL+OvNh046ip
 y03LmEWsPw/fcViWImEepoYKWogImxFx12fph89ok6JbHhDqxCAHqKHf4qy4x/tuWadxP2O1Hq7
 A/xxV4GDBhuKnTfHFu1F9L2d0sirmi5RV1dr3hg+zeaOB5t7kL/MXBluol12OnAbFBWbLllA51/
 3zSaj6c8brl8as9gi1jnTLek966tmcXQkqI2ysqoGUQ8sW3RQVr8JQ/KeMHXJntvgTMHsBgOFFA
 b9cEBcKIy84YThkr+dn5oEM5TZibog==
X-Proofpoint-GUID: 1Jh6jCTeWcW8bB5NaGMXxZDbuFKgwoPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310144

This patch series adds support for the Analog Devices ADL8113, a 10MHz to 12GHz
Low Noise Amplifier with integrated bypass switches.

The ADL8113 provides four operation modes controlled by two GPIO pins:
- Internal Amplifier (14dB gain)
- Internal Bypass (0dB gain)
- External Bypass A (0dB gain)
- External Bypass B (0dB gain)

Antoniu Miclaus (3):
  dt-bindings: iio: amplifiers: add adl8113
  iio: amplifiers: adl8113: add driver support
  Documentation: ABI: adl8113: add documentation

 .../testing/sysfs-bus-iio-amplifiers-adl8113  |  32 +++
 .../bindings/iio/amplifiers/adi,adl8113.yaml  |  76 ++++++
 drivers/iio/amplifiers/Kconfig                |  12 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/adl8113.c              | 235 ++++++++++++++++++
 5 files changed, 356 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
 create mode 100644 drivers/iio/amplifiers/adl8113.c

-- 
2.43.0


