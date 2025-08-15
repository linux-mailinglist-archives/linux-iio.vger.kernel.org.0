Return-Path: <linux-iio+bounces-22753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7214BB27D99
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 11:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFEA587FFF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF452FCC05;
	Fri, 15 Aug 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UVobh7EZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A252FCBE2;
	Fri, 15 Aug 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251867; cv=none; b=L5P9zOSeFLK0ETH63LabM8wVSYdWWvyX/HFnf3yanIFLw/xzBDSO8R9jaSX/q9ZZAcjqzhkftePqK7p1khoTj+R96yyQ7+uRrvYm5WtmI48fJkI+JYQpuGL6+HV79mQ9FWNar3PsavGKBa3DcsqXleODuwbFh+t2qrwNOqsr0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251867; c=relaxed/simple;
	bh=Tf6Ci2fYzP5icFYzoJDkCvYLNjKoaUFLrXvPDgXtaIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJkwn397eIcn4gznotfhBa/YMrteimWwwRZ9beol9mUMcMy0fZtCkwrY8h3EHtSJsK6AEg9Hz4YKBGWykHPzkBzGCQKjPH1L9WUirUbn/Z1MI/tV0LulMAL0mXtrBpdT1EzbfU71VLxtDu0mpzIBpxIWvwj8rjLMDbKWviYua/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UVobh7EZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F7rB10007721;
	Fri, 15 Aug 2025 05:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pl8T11+ItcqhN5V9kxIxCAXhzKU
	TKTPpBmn6X2bo8r4=; b=UVobh7EZAiNhw1+ftmDFasSuspRPnDbgYFa5BfLAk4l
	Ilc81y4nNOBDlPbGMnNN6V6d6YI7S1uMb6pvO1AZGlfjnfTSncFiE/5h0sZfVwWW
	ecRriedYhGpFeRksW9GqsPiLqFZH5rwCEjPnxEpxIC5XU1M6clOGhMKZUEdSbp5x
	99hb+oXN8rwPN9VjGVjh5/51wfTJ5ca2CB1RKMgpaj2Vsa10T+433zNyvUgW1f/c
	OXoo6U0XG4hFf/As7xAEQ5SKilAzfRykRSN9Ny2SNd9kqhB/E87TJ3ozzaEI40xx
	XB62qdJxbg7t/VAdVYKVSRHJax4tC5KvDfDix+fQ2AQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48h51egp24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 05:57:30 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57F9vTuQ034239
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Aug 2025 05:57:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 15 Aug
 2025 05:57:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 15 Aug 2025 05:57:29 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57F9vJis027486;
	Fri, 15 Aug 2025 05:57:21 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 0/5] iio: adc: add support for ADE9000 Energy Monitoring IC
Date: Fri, 15 Aug 2025 09:56:33 +0000
Message-ID: <20250815095713.9830-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=BNezrEQG c=1 sm=1 tr=0 ts=689f048a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=MilyVcYQlkyFfA35S9cA:9
X-Proofpoint-GUID: lN7yi3OXjRBCUhEn8RQRO33I6wgEU6aK
X-Proofpoint-ORIG-GUID: lN7yi3OXjRBCUhEn8RQRO33I6wgEU6aK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDIyNCBTYWx0ZWRfX8UaeMja87cyl
 FqiZD8QrLnqmnEAiaresZ6xb9yUr9eaI1AunxQyGkIGClCKWZLiEOIBi1l3FgATNgjR84SrVKcH
 mQdYpEFytXlnVd6lERDNbeL4ug62N26Dkomu2d3Pq2KeEiSEEaC+6HU5vpotMXBVzwYXooiY4ZW
 VoiRK4564V24CsSxZl7wrYNyr8KUWpUxvb6SOqyXol1Hhwyh0k/Du+LgAhEDtC4cJlybAv3eY2f
 mTvtZQnlyJCR0S5nL6NF3CtJNkmTvuH04nt1jgX+WTSl4ainUrPmgDzrvIQD3BBfOumzzgp6gbR
 HwN5q2n7rX8zmvZZSpBR6jb2Rc8Bx69W+hkpkPs4HPcYjR0GpARNGywdexO68ReWlgVCf892GhJ
 bD0oq2pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130224

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

Antoniu Miclaus (5):
  iio: add IIO_ALTCURRENT channel type
  iio: add power and energy measurement modifiers
  dt-bindings: iio: adc: add ade9000
  iio: adc: add ade9000 support
  Documentation: ABI: iio: add sinc4+lp

 Documentation/ABI/testing/sysfs-bus-iio       |   28 +
 .../bindings/iio/adc/adi,ade9000.yaml         |  108 +
 drivers/iio/adc/Kconfig                       |   19 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ade9000.c                     | 2051 +++++++++++++++++
 drivers/iio/industrialio-core.c               |    6 +
 include/linux/iio/types.h                     |    1 +
 include/uapi/linux/iio/types.h                |    5 +
 tools/iio/iio_event_monitor.c                 |    2 +
 9 files changed, 2221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
 create mode 100644 drivers/iio/adc/ade9000.c

-- 
2.43.0


