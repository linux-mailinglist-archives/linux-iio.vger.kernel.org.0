Return-Path: <linux-iio+bounces-23150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E248AB32016
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8F6586BDE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95830258EF1;
	Fri, 22 Aug 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DwfRpffN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109C257848;
	Fri, 22 Aug 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878552; cv=none; b=n3A4kPV8WD74WwOqpwiCnO5Jg5/8LsmJ08LAJ59N0D4/85Fw2bCeDW2XkVZ7JN0L1lKru/T/WZaSyNfqNp7DfC4TldHmz5WoT9LPytGP0/H7C9oPR8KT47e5jjrxkAhXr/k+vrPxLMV7kiOdxTOTKu3mJvWoIsVjmTOJtqoUnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878552; c=relaxed/simple;
	bh=xHQCcPLbvAVhX2txU3BWFVKgLtyxFuPF8niMavqsiLE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PJ0QNb7oUYuiid6NTAUve8lCUCHjXtIwavD7ODa2SdCJpLXiHRwjsFlmG+cQt6WIKN5uRod0EtcxO5kE1IDz4PZV2Z/65P8NCGfaNsa1ElwU+IIx/rraJGeL8yUfGfOsuMuKaTD5Bivi3m5wP85IPkacH5P8LdzVDrSrBmPplko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DwfRpffN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCCc0Y004320;
	Fri, 22 Aug 2025 12:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=SEIq1zJVeVQahmB50Fa+f43OvBo
	7Unb6agSJxm505xs=; b=DwfRpffNxfapuN8QMzGU55GqsJdNhtdqPVSL7DbvOeY
	kG20mebbDHm+kVLNxRDTu1S8Koa6CQDxEixpbsATr9BAmi7vdcgwN5jiPoRIUedF
	pm0xlGK9Y1BRL8jANkPlF1ijOyP5Fee/RKewC3ARwWqGstW9foQusZSuTArKWdbz
	86oIVFkVHaaSMn1IN6XPuOMQ9U1GDmJO2ut8ntuNBDLWn7f1/eOF7gT0AGXiSXNJ
	ilJM+JdfWPOvMzXVIU4NgWb9DxQEaFxJ2nXIZXeqaytZvETRYr1ieSDbYISGw4ZA
	kZJv4eh4N3ebgmxXlSXEm5TTLyfjC9c4sjbc0VJUuqw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48n0tdh4tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:02:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57MG2EIj058811
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Aug 2025 12:02:14 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 Aug 2025 12:02:14 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57MG263L000568;
	Fri, 22 Aug 2025 12:02:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 0/6] iio: adc: add support for ADE9000 Energy Monitoring IC
Date: Fri, 22 Aug 2025 16:01:49 +0000
Message-ID: <20250822160157.5092-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bvAVxEai c=1 sm=1 tr=0 ts=68a89487 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=MilyVcYQlkyFfA35S9cA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: wPfhu_fv8lsnxdR7zpoMGWZO3-NDkq7D
X-Proofpoint-ORIG-GUID: wPfhu_fv8lsnxdR7zpoMGWZO3-NDkq7D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfX74ksyd5tC7OZ
 TVMQZfLAZVWOF4NJVnFo+uKVP9gtm4q7/PQwUwH40O7lnUUjWnvDTUuJI+2ZGwbJQjxCLASdRs5
 uNyJqQb68PBgfO5OpEJuIWdvvTVrltG+3MDJ09dr0ezV5I7YtxKQZI9KnncjASw4bGQeyDabjZS
 yQkZap6HxzELMGi17YilGNfA7RJAoxTgzKkcGDigpdH9jqvHMqgQuoT4QivrpkgPYdPkUSocANW
 moGUi6Y4qe4RvK0FgTfThBA0gvm7TlA1+ldgaQA+tTV/qHpjXuOquqquW4qiK+q8tMOic4rMtFO
 dalgJx3jC6jT3xgvVt9FPA0itq0QyhlZ6r/qzqlT5o3FTchHmBgTTmiCJPOy7EtHYeW3gIFazVZ
 ybBc+ehLxiw2eI0Pob8jFgYaSmHcfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190195

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

Antoniu Miclaus (6):
  iio: add IIO_ALTCURRENT channel type
  iio: add power and energy measurement modifiers
  dt-bindings: iio: adc: add ade9000
  iio: adc: add ade9000 support
  docs: iio: add documentation for ade9000 driver
  Documentation: ABI: iio: add sinc4+lp

 Documentation/ABI/testing/sysfs-bus-iio       |   30 +
 .../bindings/iio/adc/adi,ade9000.yaml         |   97 +
 Documentation/iio/ade9000.rst                 |  286 +++
 Documentation/iio/index.rst                   |    1 +
 drivers/iio/adc/Kconfig                       |   19 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ade9000.c                     | 2011 +++++++++++++++++
 drivers/iio/industrialio-core.c               |    6 +
 include/linux/iio/types.h                     |    1 +
 include/uapi/linux/iio/types.h                |    5 +
 tools/iio/iio_event_monitor.c                 |    2 +
 11 files changed, 2459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
 create mode 100644 Documentation/iio/ade9000.rst
 create mode 100644 drivers/iio/adc/ade9000.c

-- 
2.43.0


