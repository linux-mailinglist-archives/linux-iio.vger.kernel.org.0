Return-Path: <linux-iio+bounces-21567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4BB01D66
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 15:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C1F3AF2FA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96082D3725;
	Fri, 11 Jul 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zSErziQG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D770810;
	Fri, 11 Jul 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240394; cv=none; b=aqru70koZ6E8S5cdGdBFwQXErlmRO5y8zkTIr9F9aPyIf1ASW3TpRbj4Nvrr37pZ4ak+eSLlcaQ0iYdeCBxo+Zk13XA9A8/4CDmJgN4sqQe5GvwvHxvg6m3dmJbxLrJKrtW+25ugcTs4rvIhCBrDG8QwJqO/2fNuP6QCHiUk/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240394; c=relaxed/simple;
	bh=Jl/vU5lJC9S0oeOQ6YknUU2pLPlX3/BkkLX3JiVHe/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KHioOjDLjfR5TsSwTG9pkeOWOgLxERQcqq6dvW8TP+v6ws1Mz+X7JEvC8UpW4UDsYuf9dQHJMR05J/djoAGVFn4vvbYkqp82EhcV1GcF/i4UtrlGOCBSW7Ejt8QrNlzJQO2GMJcVFfe3h2P1YmfiYqhV+KpOBKS60Kup2glHAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zSErziQG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBxKk4015882;
	Fri, 11 Jul 2025 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=MzrXBBg7elftyNlRdd2fDLtgh+l
	+x3GeP6CWd2zgxOo=; b=zSErziQGrQ1zEeze+7LFlDRlIqKWlZ0gU3ZkbDC8CKv
	COTcJgaGT9HzODdmcJWXZsFtx3uFRfxuCERH7kh8YWTLEnONVLUBI7J5Q9hjTlLz
	4g8UjyxXuW+CYxC7HrqCjP8a5BOXm9j8Uln9vV31WiQWf3l6F9Q2BDCy6sQII/k4
	qoEEBs8XG1eWnfylIcc2SksQlWiCJOGk+Op0FxlnIktSDz/94N0TBWkKa/8y821w
	qhMiXycHxaXypsZc/KxgMjGrrLoB09QzVPAYYSVw/vSNKps9h3dZ/PsAmxUN3XMb
	kBMmLxhS7WuDAB3bIBlGW59pCR8Rr7up57PUstYhAuw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47tt54ac0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:03:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56BD3RNX026783
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Jul 2025 09:03:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 11 Jul
 2025 09:03:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 11 Jul 2025 09:03:27 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.132])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56BD3Jqq027484;
	Fri, 11 Jul 2025 09:03:22 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/3] iio: adc: add support for ADE9000 Energy Monitoring IC
Date: Fri, 11 Jul 2025 16:02:34 +0300
Message-ID: <20250711130241.159143-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5MiBTYWx0ZWRfX0WR0VjnvW/Jn
 QVob3DQ3pBd3KH4r1kpbTgWBpnAv3fQiM3RIuUJQKa6bTniCYpYNzkW3sVuAbTq1iAnMLSbckr7
 dhXdlOcDNdWPaM8GPupKphaHWVD35pYe2enAGmKZXocBHpgWQ2Ra9qn79E1HehrLYI+F6qADh9n
 Vr2ceC+DrmaxOQNAbrqA30zh1cyws3ctagolAI1cX4DcIXjVxbnOUaeloWVRjF5uoUqPS6YPz70
 X2egbg7+NcA9yoBLoc1yQZpB7SFs+1h8xKR9uYINsdyXROmZJDoZ2sn3Vd8ol9GYjUDbFWcFmqM
 ZBWxASvvcDfBZ8vuQCZWOyVbGqBHFJm46PwrXnj6zZsG6whJmjAgFBGdq949cTI9adU7Zrd7/5n
 5bqy9h2RTmLtkejKDuOuojuIMBQyqZ44zf9pcv4phNvycR3LdqSlNinDh395JTo34eZm54ge
X-Authority-Analysis: v=2.4 cv=QZ5mvtbv c=1 sm=1 tr=0 ts=68710ba0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=MilyVcYQlkyFfA35S9cA:9
X-Proofpoint-GUID: IXQ3riGyR0bE73Mn9qbE6ozor0nPhwJs
X-Proofpoint-ORIG-GUID: IXQ3riGyR0bE73Mn9qbE6ozor0nPhwJs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110092

This patch series adds support for the Analog Devices ADE9000, a highly
accurate, fully integrated, multiphase energy and power quality monitoring
device. The ADE9000 is capable of measuring energy consumption and power
quality parameters in industrial and commercial applications.

The series includes:

1. New IIO modifiers for power and energy measurement devices, including
   support for active/reactive/apparent power, energy accumulation, RMS
   measurements, and power quality indicators (swell/dip detection).

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

Antoniu Miclaus (3):
  iio: add power and energy measurement modifiers
  dt-bindings: iio: adc: add ade9000
  iio: adc: add ade9000 support

 Documentation/ABI/testing/sysfs-bus-iio       |   19 +
 .../bindings/iio/adc/adi,ade9000.yaml         |  157 ++
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ade9000.c                     | 2187 +++++++++++++++++
 drivers/iio/industrialio-core.c               |   11 +
 include/uapi/linux/iio/types.h                |   11 +
 7 files changed, 2399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
 create mode 100644 drivers/iio/adc/ade9000.c

-- 
2.49.0


