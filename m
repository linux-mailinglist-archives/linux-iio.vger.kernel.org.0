Return-Path: <linux-iio+bounces-22456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE75AB1EA04
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF45A16B063
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7CA27E05F;
	Fri,  8 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AGZd0/Yg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE827E05E;
	Fri,  8 Aug 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662281; cv=none; b=PzQONaL5plztEWUG1JUBIMH9n086d65k5lCobAqgUABDTcqzpcihKNraNklHB/IqLaRRKvoTOcwbAhUbVuYHv7g55Q2f72vjIOjaWjGybVeJQB7tSKd6gwutwOOwxfdSyueN0ajp9LdhDSJU2HKlyAA5IT0xZWIPT81oKJcPHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662281; c=relaxed/simple;
	bh=nMg2b6x/9MBlQOj76X/PeJ+VTbAfV3eDFBOfaO6FsZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dy1/cdt75YeC+NDPbcFAgTZeXGr4KnndBtjBKi5FiL3M3XFws3s5pAt+f5jqaiY8+d7/kwf/+N7ArM8Whob+UJ/w/UYxFw/TxTgPOtC+ULNSjxvVmZlRJ+rDsQBSxMTigZO0JGXOC0EngP61myhRS/dzU26U4x+Kx2maLlLI2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AGZd0/Yg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DHp7a026122;
	Fri, 8 Aug 2025 10:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=94LPkGFqnAm2n6dGMBjDHPJUj50
	096iqhag5yT3Ea8Y=; b=AGZd0/YgNz9kXkOvXq5yF8ifvFB077u4KzUxACI49Ri
	zcaDrPFrphTA6qLJqaxXHvnQ3DKvo0D5pyw8sM7QxAEZPpb4vIjCsZceGUzIc08s
	qYabstLnjsbnnUkm2VcLMEemx//Wwj6r3ymNANRX9izsht+dNnlpqbl5G01QgRKT
	aPaby90eluAf5bul/hqyNIF7PTfaLvOCrg0HIGZFG9dX+nKyaqOCWHRDUo1TQDRR
	Sv8rkuacd4YrmbgpHLpiyBJUFraeJbkSMT5c2dhv9ZeDkmVO7+Iky3L/xUnT8LzF
	uVKdPRKkfvEcNXuDgO89PRBH98J+W6Stil2wG43lMvA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48dj0708ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 10:11:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 578EB2Ax062919
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Aug 2025 10:11:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 8 Aug
 2025 10:11:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 8 Aug 2025 10:11:02 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.94])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 578EAqfA014662;
	Fri, 8 Aug 2025 10:10:55 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 0/4] iio: adc: add support for ADE9000 Energy Monitoring IC
Date: Fri, 8 Aug 2025 14:10:12 +0000
Message-ID: <20250808141020.4384-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=R4sDGcRX c=1 sm=1 tr=0 ts=68960577 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=MilyVcYQlkyFfA35S9cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEwNyBTYWx0ZWRfXy4sicPdqT4TV
 svuTk0lIYIqlxRtdOMp0dzowY+w7SoK1uhyNXnSnjkZK77zvq+hakqvq1Zq4NN7fE5ejnLyni20
 I3lj93YbZHQBezG3FEwPYkR/xUH/nt31VS0o2cIys2tgwU0LKzcDmzp5h2wM8gDugj3+6WaPmYe
 8hQbJJ9NSCBv6/c9dtU7dYMwFzveEuD8PBg/AMaatuHwfRPCDFadFNlmfKpxWF29Vu8FrvU6u9Z
 6Gbs2RrmqnQcat659nfoZpySVby7DP6JHwfXqE0gTLYC7Jq3XDgMlhDiPC1qKpHvUInFOEq/6q8
 xA/RlxhW+1Hwz+bWD31Y4KOhxJoRao0p30uXBSEU5gwoIuTNoMM+I7G1EIdhxddm1sQGfjnfjvq
 qTYcVXKJ
X-Proofpoint-ORIG-GUID: GJ3qRYj0lwvkDXdmAglw3ZtfIJVxtSP5
X-Proofpoint-GUID: GJ3qRYj0lwvkDXdmAglw3ZtfIJVxtSP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508080107

This patch series adds support for the Analog Devices ADE9000, a highly
accurate, fully integrated, multiphase energy and power quality monitoring
device. The ADE9000 is capable of measuring energy consumption and power
quality parameters in industrial and commercial applications.

The series includes:

1. New IIO modifiers for power and energy measurement devices, including
   support for active/reactive/apparent power, RMS masurements.

2. Device tree bindings for the ADE9000, supporting waveform buffer
   configuration, phase configuration, and trigger settings.

3. Complete driver implementation supporting:
   - Multi-phase energy measurement (3-phase support)
   - Power quality monitoring (voltage swell/dip detection)
   - Waveform buffer capture with configurable triggering
   - Energy accumulation with configurable time windows
   - IIO buffer interface for continuous data streaming
   - Event-based notifications for power quality events

The driver provides a comprehensive interface for energy monitoring
applications through the IIO framework, enabling userspace applications
to monitor power consumption, quality, and waveform data.

The driver will be extended in the future to support multiple parts such as
ade9039.

Antoniu Miclaus (4):
  iio: add power and energy measurement modifiers
  dt-bindings: iio: adc: add ade9000
  iio: adc: add ade9000 support
  Documentation: ABI: iio: add sinc4+lp

 Documentation/ABI/testing/sysfs-bus-iio       |   12 +
 .../bindings/iio/adc/adi,ade9000.yaml         |  110 +
 drivers/iio/adc/Kconfig                       |   19 +
 drivers/iio/adc/Makefile                      |    2 +
 drivers/iio/adc/ade9000.c                     | 2033 +++++++++++++++++
 drivers/iio/industrialio-core.c               |    5 +
 include/linux/iio/types.h                     |    1 +
 include/uapi/linux/iio/types.h                |    4 +
 8 files changed, 2186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
 create mode 100644 drivers/iio/adc/ade9000.c

-- 
2.43.0


