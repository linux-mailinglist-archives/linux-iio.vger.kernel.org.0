Return-Path: <linux-iio+bounces-19583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC8AB97AE
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408411BC682E
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CACE22DA1C;
	Fri, 16 May 2025 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YWB6fLey"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20422DA09;
	Fri, 16 May 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384041; cv=none; b=biUbuf1W01jj0jwOGAwNYix+Hom7Ij8Ie0pyOylarnV8jQRsVdV+vU3ZpZixThYphlGlfpKKDAH9Asb6m+YWMShEDRavgqQ3SucQcnXEF6ugZ6hVC8Jx7BY29df4aQvW8NPjcAhNELC16apC8iXhQ0F9Fjd8ilid5IendSl7vJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384041; c=relaxed/simple;
	bh=UtR1DqMS1k3wSay4wJdxZB8iljHT9i5AeMOjluG12mQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vyla9gn95JvfmFNcE4GBqIs3sx+6cePnplpGwACGtZHj1VmW1CGgNAwKP95P5AFmGY20G20B01kzZnGWWxdzFR0k+yKCuVmEYnmGr7pTD3OM9yI1gvIfvIn4cuc5C4ossp1Kit1Rkltf7jqIBMm2l8DwxGyZzwsMQjiNRGQxGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YWB6fLey; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6Xg1J010012;
	Fri, 16 May 2025 04:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=9rIP9xVeUvRrmO4Kz0BbQfSJpOe
	KkI9QLLX2BtSSIDA=; b=YWB6fLeyhm278LGLYSwwxwcHhY1/wAaCjUF+SyjnqcC
	OI5sNiftNDZMXNng+1G1/1lffT0lzXbo4dQZsqRbM3Vhb3foYRF3ZL7cf5SbDygf
	wMwywbgEAoqCU1yLpPhy35PwVzO2LvJrumK054GY2qG0JlGvItge9uWkwnSsMbum
	u1bcjbyp+Akf75chryL6sVdaABnuIGSdtux+G60LbtO6Z+Wcs9BjalaZ9fhsfjrR
	2BFwjTLtxrvfiePpjBzf9KhXpXhnJyBaCIJrMXQSMiT/wlQpc2flINmtHrYqs4VU
	F88Je+r/YIjqzbvTE4S4xF+QWLCEbow/RVydncE/QLA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46p070retr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:27:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8QjKx033595
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:45 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwe031549;
	Fri, 16 May 2025 04:26:38 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 00/10] Add support for AD4080 ADC
Date: Fri, 16 May 2025 11:26:20 +0300
Message-ID: <20250516082630.8236-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: reOcnSfSbtYsURgzsmuMeC2NC9Y7aXip
X-Proofpoint-GUID: reOcnSfSbtYsURgzsmuMeC2NC9Y7aXip
X-Authority-Analysis: v=2.4 cv=A/9sP7WG c=1 sm=1 tr=0 ts=6826f6e3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=HubKl35eoKcbRmig0ccA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX2fdAE6zTxuBY
 TrBpNG2vJgRIl0azmIAuCKCOW8+5Ss2gfa3ai3eoeB7YIQwyeb9yT0Bov6aeZG/NV1q6Aev+OCz
 EQxyfX17DggkiZtktp0GBn2NuNugE9KBWGmsa9hxTmVocD7dSSTmkOT5RFhqpL0fjeeo4teEhvr
 ZDpnqIinn+4Wncvcg7UjYZBG64sexEOgaUYsqBxhaTVlNw/4iMVgIw+U+CbY+T3kn1UxF17oSf9
 eoSKRlS04aw/TtdLm5+XEgdVmCW/CZCvskYEjX5/FLLiJfFf5eYPnSHawyYF1saP2IoBII5M9Q8
 tHu+Yb7tqiVAEsKZwOUS5pjWE6CjXP8g4+7A2w4vFV5QzR8ZZqj2w1PW2Z3QwRLajc1hGfuzeLi
 8kNgG/wCfbkJYPsrBJVa9a8InRy2i/4l03yQEWoAS3XqbXJ1okfxlVHwajf37BC60dQ3hQ2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160079

The AD4080 is a high-speed, low noise, low distortion, 20-bit, Easy
Drive, successive approximation register (SAR) analog-to-digital
converter (ADC). Maintaining high performance (signal-to-noise and
distortion (SINAD) ratio > 90 dBFS) at signal frequencies in excess
of 1 MHz enables the AD4080 to service a wide variety of precision,
wide bandwidth data acquisition applications.

This driver aims to be extended in the future to support multiple parts that are
not released yet:
    AD4081
    AD4082
    AD4083
    AD4084
    AD4085
    AD4086
    AD4087
    AD4088

Antoniu Miclaus (10):
  iio: backend: add support for filter config
  iio: backend: add support for data alignment
  iio: backend: add support for number of lanes
  dt-bindings: iio: adc: add ad408x axi variant
  iio: adc: adi-axi-adc: add filter type config
  iio: adc: adi-axi-adc: add data align process
  iio: adc: adi-axi-adc: add num lanes support
  dt-bindings: iio: adc: add ad4080
  iio: adc: ad4080: add driver support
  Documetation: ABI: add sinc1 and sinc5+pf1 filter

 Documentation/ABI/testing/sysfs-bus-iio       |   4 +
 .../bindings/iio/adc/adi,ad4080.yaml          |  96 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4080.c                      | 620 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  77 +++
 drivers/iio/industrialio-backend.c            |  58 ++
 include/linux/iio/backend.h                   |  19 +
 10 files changed, 899 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 drivers/iio/adc/ad4080.c

-- 
2.49.0


