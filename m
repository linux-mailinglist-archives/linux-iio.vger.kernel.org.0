Return-Path: <linux-iio+bounces-23366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30233B3BA3B
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC871C86F2E
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC63043CA;
	Fri, 29 Aug 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mkL2p+/b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4E2D0C8D;
	Fri, 29 Aug 2025 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468383; cv=none; b=WpKvDktq1BetNxa/GksWEK/pDYSm3YvWwVJbTJWnZWD+M6NN+It9/6rsxcY54Gcjw2Yvm8BB7EmWcEQlDOvBCyadu1Riujbrca8F15nm/AaSEdjZV6LwXpYFbX84SV858fJrfNa7IkGt5Xmz2wrQjHES60AY8zv4//hGyyv3jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468383; c=relaxed/simple;
	bh=NiS6maFenS6lHlot8Hk0gbDW8+p9lvTxXzzWtvQAkXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=biLALwJHkrHOofMlIaKuWbw454Zm60tRHvGlOitRZbgZD4uodF0R2dwnLsCL5qPiLh6K/FQMvokg39KGWpMgt/WqI3//gmnxWazEFhAu/EX/SUARPNp1wJqjTBWdhusjoPeiL8iATf7eRjyBGqJoBQuFxFkSSiTm32Y172mWoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mkL2p+/b; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85G0X016082;
	Fri, 29 Aug 2025 07:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=JvZydoAGNgbmVzvlDdRVBEFMMT3
	3WURXIU3ZbMpqHEY=; b=mkL2p+/b8toqEcN3LL56qyCb7IEXnLhRORjsPdKLXT8
	O8T1tgMYPNCsokFJirwYP4EDcdZ3qCwfyBcKFja5erNCOBBVFkQrQsAA7zntLDEL
	NbtK5qi2BDeG/Dy/43FccDgGMZ/tHQFnMX+j3QQWhbLQwLZOiMZ3avdz62QMbxc1
	zgMMgY/Io2vsGrIXjyCqfrqCSn2N22649NMMlM7wLNQ2KgCwLHdP7bB7QGgQhvZX
	Yic1nLl8pohAX5X4/x5NyuT109FPKk++wkdyeRD++zRcI1JtiMv//3dcI4QYF9mS
	iAE2I6kENSDvsyCc8hXLT7trrWEizkQsiINyIk9rrIQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqat7f93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 07:52:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57TBqlwn036251
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 07:52:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 07:52:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 07:52:46 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57TBqdAR017911;
	Fri, 29 Aug 2025 07:52:41 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 0/6] iio: adc: add support for ADE9000 Energy Monitoring IC
Date: Fri, 29 Aug 2025 11:41:34 +0000
Message-ID: <20250829115227.47712-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfX0wiFqFRoJ7eR
 /8StdjXmofSxQ7pZmk5EwONvHJj6Vp3mw53tzOvJebfoiCOvhN6TpLjDb326oy51sM7M/HzUxgF
 TNLNW5La0hRocnfZWspHfRISLHokTafAQI4TmaKD8WpikgmjPDVrw85D7EyS0jS3b1CuX8BASEM
 51sC7NxEgZTE1unPgnZCI0bAR7uQSLEwhp74D9YliY1dusfPic0zMPiSv3XMU+i2dTH1IurH26G
 UG+/5ACJv5Vot9IfO26hs4TgipESPXhhSmWEzKCPdGaRKeqb85R8aG2+m2aZAoGf+Mhb82XtaHM
 sQQYs2fEaO0HDcRRgqbBsPQXlMSHKZRofQwy2i/6Pt844elRKClljG3ghJq8r2t9MagCGCvzQZQ
 6EcorEsQ
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68b19490 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=MilyVcYQlkyFfA35S9cA:9
X-Proofpoint-ORIG-GUID: 4gdatVQHFvd_vxTlMwjdue2kAHRYFnEa
X-Proofpoint-GUID: 4gdatVQHFvd_vxTlMwjdue2kAHRYFnEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

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
 .../bindings/iio/adc/adi,ade9000.yaml         |   99 +
 Documentation/iio/ade9000.rst                 |  292 +++
 Documentation/iio/index.rst                   |    1 +
 drivers/iio/adc/Kconfig                       |   19 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ade9000.c                     | 1845 +++++++++++++++++
 drivers/iio/industrialio-core.c               |    6 +
 include/linux/iio/types.h                     |    1 +
 include/uapi/linux/iio/types.h                |    5 +
 tools/iio/iio_event_monitor.c                 |    2 +
 11 files changed, 2301 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
 create mode 100644 Documentation/iio/ade9000.rst
 create mode 100644 drivers/iio/adc/ade9000.c

-- 
2.43.0


