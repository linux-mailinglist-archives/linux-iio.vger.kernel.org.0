Return-Path: <linux-iio+bounces-23875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C438AB48571
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 09:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA271B216E4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8772E8B62;
	Mon,  8 Sep 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cd6q73Hk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF32E7199;
	Mon,  8 Sep 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316976; cv=none; b=X1acdTxRopVIbFHLv+lU5cCL5QQEEc2C+nzj8LHRVTQDBki6DPFmeZNJTZkeiyhkb+LSnC89t55hStdjD7psNa7S6kCjkc7USufuXdP1g15YUDgZsNrbyOcTvQacOXXhkHQjWQlVumvl0L8ECd6lxghjXbPEklzMTgqJ3YVm3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316976; c=relaxed/simple;
	bh=iD7afXGINa8wKYnfggOQluNVtH4rwBtqwQECDBlM9cQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBZ/Wst9vAjqNe2+cCRsApuTq04/N24Cn21waEMcp85CTe97skA3/n4g63lmmTB8IsRp7ATkOcJi8iJWrEjBwjuIO9WZwjJGOZrw1WiKnQPZfjGlzjOYJ1SzBf4e1VkyZF+yyL2P5usaKHjp3wVbLgRy3d628hPNwxeKPXP+HQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cd6q73Hk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58866OMw030808;
	Mon, 8 Sep 2025 03:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=JcIsIi80A3kNOKSZA0ZHGKtEpmg
	ALvXTJCjWpRQZNRY=; b=cd6q73HkLwxN4UfrOMl70S6YTop8iAlEdIIS2LKk9e3
	YtDeycHKODWa6rPmSEUH4VAlJ5RElXOaIAqDjskZHYUfFHSF456IK4MCSc1fVAqj
	cG2Qf1NgL6GGSJJTvQYohJNE/L3sHES8q4EkoJXSeSAnU3EWjZV0I+7zZ1azW4tz
	4BtFMnIxLoQzGC28RWKhuHL6mj8aOP/+OngpUirRnE9F5KpvTkf/B4iuGeK5JGzA
	huRZZzHEMQXuFWOVsw5k46XUkcm2gIB7yxBRORD62x8fimBudFMGGFnVIAmo6QV1
	ec4yBfLp3UtMJhqJRKdmpYiSPZ83R6NCiNpJdzEsIQA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 491h0na9gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 03:36:01 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5887a05V036386
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Sep 2025 03:36:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 8 Sep 2025 03:36:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 8 Sep 2025 03:35:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 03:35:59 -0400
Received: from Ubuntu.ad.analog.com ([10.132.255.227])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5887ZpEc004718;
	Mon, 8 Sep 2025 03:35:53 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 0/6] iio: adc: add support for ADE9000 Energy Monitoring IC
Date: Mon, 8 Sep 2025 07:35:20 +0000
Message-ID: <20250908073531.3639-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=H4rbw/Yi c=1 sm=1 tr=0 ts=68be8761 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=MilyVcYQlkyFfA35S9cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDIxMiBTYWx0ZWRfXyZEE8h0Vao5L
 AWJDXmLKsTznz/WaTOE9c98iPcY1LuV1Pr0NYqVkZhUMPwljLc3weB2ymDZVYhrxZvK2hWIY0T1
 ZsJdgeatEwflfmvp7ECIimWkePv/CbZISalZ8eME2vQDksi5UDmW/X9rWCaktBMnNu902AWRbUz
 6U7ga/IauEMXjpxYeW5PCmOUpTLeT0nJe4onBFNl6Tmwq+1N/Bc8XFKmJOJIWqcnl7qUixYx2mD
 4dGOCkV2jOnwWVPqO3UyrMVVF0Vg/ARJ7RNMWKy4HqjMAI5mMAq8n/opzc23KZ7dbkHy1GXQqNF
 JhdetovdQcSw5+0mfHlg7IQKsdR2+rHgqcaHZymrJhkWOx+8gf99FveCh6VznS7JvLLkn3QJSvk
 XzmHvAjT
X-Proofpoint-GUID: vXyQjUyH9gWTQw38qBEuFSxcl9XiFAfR
X-Proofpoint-ORIG-GUID: vXyQjUyH9gWTQw38qBEuFSxcl9XiFAfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509070212

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
 .../bindings/iio/adc/adi,ade9000.yaml         |   95 +
 Documentation/iio/ade9000.rst                 |  265 +++
 Documentation/iio/index.rst                   |    1 +
 drivers/iio/adc/Kconfig                       |   19 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ade9000.c                     | 1793 +++++++++++++++++
 drivers/iio/industrialio-core.c               |    6 +
 include/linux/iio/types.h                     |    1 +
 include/uapi/linux/iio/types.h                |    5 +
 tools/iio/iio_event_monitor.c                 |   10 +
 11 files changed, 2226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
 create mode 100644 Documentation/iio/ade9000.rst
 create mode 100644 drivers/iio/adc/ade9000.c

-- 
2.43.0


