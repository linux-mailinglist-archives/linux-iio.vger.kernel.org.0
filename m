Return-Path: <linux-iio+bounces-17071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810FAA683E7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 04:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304CB7A70F1
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4624EAA4;
	Wed, 19 Mar 2025 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QvD7hugs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33B14C5AA;
	Wed, 19 Mar 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356143; cv=none; b=DVfwvi2dhBSqPUvzz6Wc0bdTu6+W4Te/RSMqpbnR/4dHqS8EQs1WbM4SE4CWGYg2zR6GbHRD3KJwSwdkFS6YrL9X9UH10FlIGQO6+a2163UQOab5dnWaxcVF5zIzWdDBOeol+jqV0kd6xE8MQyeYleCnWfs8cE2XnZenJ+ACvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356143; c=relaxed/simple;
	bh=XKBAeu2Kjkp6C3yVxTjjHCog9pRay5+MoLL1102robk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PlMHWutzsJd/7G4yjruN99J6EKcWkG707hdqTi6X0Q9Hv1Ex4bQ2WHcLno945zqiqCyBaUO8DMjHdP43qB2paN3LQd5v/SO10DPcwoygKa2Loz5YS60q8ae6U7g2RVXy45OOfZPWtI3pZrIF15UIenu/b1xweEfPmGYxvnkDtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QvD7hugs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J1vcCE018558;
	Tue, 18 Mar 2025 23:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=neDd2ny0WKmFUJxoeESmK7MvdG6
	v64xSwXzRKrV1hB0=; b=QvD7hugsZfiZ0Y78+bv5v9YiVHl5L4SAAJt9w4wUREu
	5DHXCXEchGpYhDodtNPOJtrCcaGvk5+OjDJWoppwSTm73sMFwuQzfFSCEkB0GI5k
	1vHfK41aKIqBdGobsDdv5RzYir3n0dX6ouTdftgq/vkqS9fmYbICjFRkPnFI5M85
	ZNYIKXzSpcHKlhonC2jGRuxuJvjGC6lP9mztXu1zjzkvD0g+ua2k+cMEmHPxFDzV
	XsKJgJLCyxhkIuNJfsAbBoJaS3mrlimqCtyOYpwhtI8WwV9apiTttXGLn4lGnayL
	juVjTc0pBegx848hL0tUVYPHi/HFojOgyg33IW/M1sA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45d3d6ufk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 23:48:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52J3mXRu013789
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 23:48:33 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Mar 2025 23:48:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Mar 2025 23:48:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Mar 2025 23:48:33 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52J3mIC0005894;
	Tue, 18 Mar 2025 23:48:21 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH 0/4] Add driver for AD3530R and AD3531R DACs
Date: Wed, 19 Mar 2025 11:47:54 +0800
Message-ID: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGo+2mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0NL3ZL89KLUdN20ZLNEg8Q0SzPD1BQloOKCotS0zAqwQdGxtbUAoyT
 B+lgAAAA=
X-Change-ID: 20250319-togreg-fc6a0af961ed
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742356088; l=1670;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=XKBAeu2Kjkp6C3yVxTjjHCog9pRay5+MoLL1102robk=;
 b=QP4HXVfTAiVMj/Iu0ixw5o85+p8xElHG6jKGywrskx1t+EnPZe9Rnv+DCSLYdK1k10UCFhev+
 lUgYQ8doMenAPV8C5o8IED6iepLRioXaHnSU6u1KBRXJF7xJ/U0k3Di
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: RFBKay2xmkjYnwwu7b9B8juxKEiG6JZc
X-Authority-Analysis: v=2.4 cv=MsRS63ae c=1 sm=1 tr=0 ts=67da3e92 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=Bz3p57LwOhYugZDU6K4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RFBKay2xmkjYnwwu7b9B8juxKEiG6JZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxlogscore=822
 suspectscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190023

The AD3530R/AD3530 is an 8-Channel, 16-Bit Voltage Output DAC, while the
AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC. These devices
include software-programmable gain controls that provide full-scale
output spans of 2.5V or 5V for reference voltages of 2.5V. They operate
from a single supply voltage range of 2.7V to 5.5V and are guaranteed to
be monotonic by design. Additionally, these devices features a 2.5V,
5ppm/°C internal reference, which is disabled by default.

The AD3531R/AD3531 is not yet released, so the only available datasheet
for now is the AD3530R/AD3530. The only differences between the two is
the number of channels, and register addresses of some registers.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Kim Seer Paller (4):
      iio: ABI: add new DAC powerdown mode
      iio: dac: ad3530r: Add ABI file for the AD3530R DAC
      dt-bindings: iio: dac: Add adi,ad3530r.yaml
      iio: dac: ad3530r: Add driver for AD3530R and AD3531R

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +
 .../ABI/testing/sysfs-bus-iio-dac-ad3530r          |  68 +++
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |  89 ++++
 MAINTAINERS                                        |   9 +
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad3530r.c                          | 585 +++++++++++++++++++++
 7 files changed, 765 insertions(+)
---
base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc
change-id: 20250319-togreg-fc6a0af961ed

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


