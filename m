Return-Path: <linux-iio+bounces-17931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C32A85D49
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414E64A889E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF932BE7D0;
	Fri, 11 Apr 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QzEJiL1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F32BD5AB;
	Fri, 11 Apr 2025 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375010; cv=none; b=ANlW29FkCbPbQp/UGa102W9h8leXxbUs3dGiusiERsoEWJDGgI8njs6RbeJVobmrfm9cG3Rc0mBL2GCxEzi9HFf4HXXgDX4EscHdkyqSGmSoNJm49oJtS99hR60Oq2neNGD2+loJvOhQ+41UZX0/G54aWpc3COm59X3ta5rSyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375010; c=relaxed/simple;
	bh=uRZiw/amf7efcyO7dFKqmxQne6tASXslJWHYiB9UodM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lM1R369AmhSdRyHkkjn/JYxNGvc1GI1M2V35IqnDoIGxnEivyqW3aPDbzcV7pPQlIabyjZWgnUzdRzmzOlLUsa9OWLoo7bHXLsgg2GLENDfUltVgZXY9nVxGPLIJI2HN9/tKDY6tg03QEHmbNcVaZp5cEDetL0DNO/5FhX9SjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QzEJiL1u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9mgWl001847;
	Fri, 11 Apr 2025 08:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Qm07i6YZxhNBj9/ldmhyskFcrr5
	NVdNAXZ/sMM8b7zg=; b=QzEJiL1uotU5FsH8zlR3jLxmuK4kCoWIDfRY1cafNp/
	U0iQSKjtCNhwgR9GQ70nVunrCVxKG+oPyP4Llu9JzTVfRBEwuJGkGYi8a+U/FR0B
	dzv+iRj/g8JI4OUov1Nys7N4fNBkL3pO3cY1ftUX/k235RbhfMAob4OtjbCwPmDk
	Rsz9n+nFjkInpz8FUDZGQLezGB6fXLrlsEe9BY2+RU3WM92Ww2somclQDGu/l5eo
	NaKTS8f1z+MwwQIzBLaF6tQXPyT8jHOnmv7/o+9BxJOiOlH5xbQLcOXs4nw5c+IT
	twIpjqSiRZNTh9bYBS9CDYYQMhukZc2gejoAyLq8Zyw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp0br5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BCad3o001258
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:39 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:38 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPK006015;
	Fri, 11 Apr 2025 08:36:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 00/13] Add support for AD4080 ADC
Date: Fri, 11 Apr 2025 15:36:14 +0300
Message-ID: <20250411123627.6114-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 9pqRGxiSPyNWbihPwkPm5hGuK-NSIvgk
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f90cd8 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=HubKl35eoKcbRmig0ccA:9
X-Proofpoint-GUID: 9pqRGxiSPyNWbihPwkPm5hGuK-NSIvgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

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


Antoniu Miclaus (13):
  iio: backend: add support for filter config
  iio: backend: add support for sync process
  iio: backend: add support for self sync
  iio: backend: add support for sync status
  iio: backend: add support for number of lanes
  dt-bindings: iio: adc: add ad408x axi variant
  iio: adc: adi-axi-adc: add filter enable/disable
  iio: adc: adi-axi-adc: add bitslip enable/disable
  iio: adc: adi-axi-adc: add self sync support
  iio: adc: adi-axi-adc: add sync status
  iio: adc: adi-axi-adc: add num lanes support
  dt-bindings: iio: adc: add ad4080
  iio: adc: ad4080: add driver support

 .../bindings/iio/adc/adi,ad4080.yaml          |  96 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4080.c                      | 653 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 | 115 +++
 drivers/iio/industrialio-backend.c            | 113 +++
 include/linux/iio/backend.h                   |  24 +
 8 files changed, 1018 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 drivers/iio/adc/ad4080.c

-- 
2.49.0


