Return-Path: <linux-iio+bounces-19363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E837CAB111B
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DC81C401EE
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828628F519;
	Fri,  9 May 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ylQn6EkV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049C21D3EF;
	Fri,  9 May 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787837; cv=none; b=g3aiVeDmcPu8nb92m2XkMDqYlLe3WrEyPs9/N7pPBkcB9b7MRI7QTNrNG4MOoQSLGfcdk5tcBL60btOXpJ7xE+/5zn2lZKzO/E3QOTgYJe0mTcm6LqArqoAYtIpf8PIpYP4wA7Zp6OFgAO38YwPoWt5kDTfQNjTDMNFbEo1EgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787837; c=relaxed/simple;
	bh=G+V9pmXEb4CFSj8ih2qw+5iTb/+PZ7JtEx+MYpXwTBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mVJsqGbbCkbhWnPZUU7f64ir3gGrteu+CcvXak1Ssi9LgMxkRPMYkSjRI6y7EFNW685l78P3i04sRwXqqG0Jskl+jMCpAAN/9pFzCUHFE1nhmZ0CioaAMfhWV7KUm8Z5EZC1/MqujXRD1vQN1OXstcsO9LvymCXciwoHClYiokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ylQn6EkV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499kWbY007760;
	Fri, 9 May 2025 06:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=bjnw3iHsCoR3LAPcvOIdHwLv3tB
	Q+A0bqHblhrKrDgI=; b=ylQn6EkVPoRsDu/UloQKOSeUvd2SERb+073N/sc2Ncc
	rVvvevMWrf3Mj1mUbgMbPiBEFmoIu2s+uoiKUHsV2Vec+QR7npgLWGBlHH9XEa9n
	do4bQER9WyptJ4Tw1lhHh01VHgUQJcAvbmIjvSKQfM3VDkPkRVL/vvSG7WIlWWZI
	Y0cF5MUFclSb70bE68zO4CthmUo4lYxz1qff4Wdy3vclulRCFO4OlmM+APIta0Pn
	wjagl4kW18kNwM2tDEGbYThD2mi9FsB8dTIYfdjt/XgaCP+Vig5S0+d1oA1gDr8s
	yQ+RPbWrnFxj0iOyA3NwIOZ2VGoNtqE4VoU4GEBgYsg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46hc2yh8v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AoUla049011
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:30 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK10014223;
	Fri, 9 May 2025 06:50:23 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 00/10] Add support for AD4080 ADC
Date: Fri, 9 May 2025 13:50:09 +0300
Message-ID: <20250509105019.8887-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMyBTYWx0ZWRfXyQF/m8IdBz4v
 G+zZHOZZdGcF/G6sQHHSh7yWg1OdwEhAhBrFVokrQKaEEO5Q3dxILFkpeW/zWjlXZDoYV0nc2a+
 S5MtlGN8zLy9eHkJ/TcgI1yC80dmh6m5yj9Tntyors8ny+GUxuK4zc00LU48pF9gAxcP/Fw9uWE
 fmafw0REkYC9/5iNi8h5pRIt6LZdTPyTKaUBpzGDQAVjNxdW2Dx7xfAWUPHWdCTs3akLwYunsrN
 tJhaTH48Qtjy972mVEEC9hTQkghmxMSIN2ibpHuXbo1993HCX6k5gbMBU/fSe2FxV2CEMhu9lP1
 1mef2vdcAtIaMTV5a9DtT4lP0z8f0JK5eMH9wmo4aEPJxR2Mm3+XSAu+DQzTkZkVcdkfPKtJWk6
 B6XSB/+tiSt0/KGOtpCVSuDTghgYh0AiBEyBSM4LGi7IBn0ZFQDVLaTmoyzGvsO8HLh2cgP+
X-Proofpoint-ORIG-GUID: a-J5GaWMjrM8wXiYqRa0SZDvp-sqgo_j
X-Authority-Analysis: v=2.4 cv=UJbdHDfy c=1 sm=1 tr=0 ts=681dddf8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=HubKl35eoKcbRmig0ccA:9
X-Proofpoint-GUID: a-J5GaWMjrM8wXiYqRa0SZDvp-sqgo_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090103

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

 Documentation/ABI/testing/sysfs-bus-iio       |   3 +
 .../bindings/iio/adc/adi,ad4080.yaml          |  96 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4080.c                      | 575 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  77 +++
 drivers/iio/industrialio-backend.c            |  58 ++
 include/linux/iio/backend.h                   |  19 +
 10 files changed, 853 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 drivers/iio/adc/ad4080.c

-- 
2.49.0


