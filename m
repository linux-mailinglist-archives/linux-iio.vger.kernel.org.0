Return-Path: <linux-iio+bounces-7318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD9927AA0
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A01C210D6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2121B14E2;
	Thu,  4 Jul 2024 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XGoZaxhk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1F1ACE67;
	Thu,  4 Jul 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108654; cv=none; b=ZpK166hsFy8Zi8iaj4Y244OWw5rJvre5NbVKgVP9aCKE5VEH+V28L7RsFHQhHJNBsSsbKqg/gbCPE6NxQtNoo3ld0+gEDMBEluMRb1l3V80mTgOIcXXQRhrrvNHb5zFLmM6jIALPkW/58CPQo15ooLfvIk7I+167h+LeLtNBoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108654; c=relaxed/simple;
	bh=sBoMD9MZcO/eEa6Y0GofDYQ2HWRU2LzOiLiKm9wzPJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hmmDqopoH0t4Ejr183nvlj0SvbK0ntn9eOh7JKsSZL32x6uU5O9hwkF5r1k7VKSGr18J547tc0I7mAXDhpk9gEYcDetZAm+m8A2q3ysxHuTow5ery84ET+m2jXVxQGDmyuPMQ8xbJqOPN7usExUkPGGSOT5vf0onJk++xy+m5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XGoZaxhk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464BNjGm007786;
	Thu, 4 Jul 2024 17:56:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=ibw80CV7lP34NHZuwWXqpZ
	j47HpMI7ZCa8Fr+wu/PcA=; b=XGoZaxhkEsY8QHgtBzEDNtOUTlCYOK7HfWg92N
	b7/VdYCIEr3Hx7erdPZBvzasz7Sa+RiRFl+q6PovlDdCtNWAqlcr5W+s8mznBj7R
	Hj4yjpeFxKReTQq5dEiFAKx4LQIr2IAQtifeWKC7miJCy/QMHOG42clDel0bAlpU
	T5UecT3hFHuIGYudiO+b/x48mIH63IBCOkprT0abOw5aJ/Vw+ET2fxlSdAM+EHpC
	B1j76efepq2AgHfOe2tQBZvRQuXOeUVxdh4aYHUSi9EA736o8ce5dmUN7RnOcspS
	LsID4ULKluepH/AWaWNQvCgYr51rShz/O3+WjmdY4x1Cy1gA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402w7jbg21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 17:56:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3ECA140044;
	Thu,  4 Jul 2024 17:56:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63DB82291CC;
	Thu,  4 Jul 2024 17:55:44 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jul
 2024 17:55:44 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nuno Sa
	<nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown
	<broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/8] iio: adc: dfsdm: add scaling support
Date: Thu, 4 Jul 2024 17:53:28 +0200
Message-ID: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01

The aim of this serie is to add scaling support to STM32 DFSDM
peripheral in the analog context.

The DFSDM currently operates as a consumer of IIO channels
provided by a generic SD modulator. As previously discussed in RFC [1],
this topology is not suitable for implementing scaling.

This series brings the integration of the DFSDM driver with the new 
IIO backend framework [2], enabling the DFSDM IIO device to offer 
scaling feature based on reference voltage data obtained from the
IIO SD modulator backend. This generic SD modulator backend takes the
place of the former SD modulator, used with legacy implementation.

The DFSDM driver has been updated to adopt the generic ADC channel
binding [3]. The reasons for this include:
- Reducing the use of proprietary properties
- Simplifying the coexistence of legacy and new backend bindings
- Prepare the support of the MDF peripheral on STM32MP25 SoC

Backward compatibility is maintained through legacy support.

This series extends the backend framework with the following APIs:
- iio_backend_read_raw:
	This API is intented to retrieve channel attributes from the
	backend. It is based on IIO framework read_raw API.
- iio_backend_read_scale / iio_backend_read_offset
	Dedicated APIs to read scale and offset channel values.
- iio_backend_disable / iio_backend_enable:
	backend enable/disable to be used for PM management
- devm_iio_backend_fwnode_get
	Intended for parsing DT subnodes to allow generic channel binding
	support, as generic channel DT nodes are not populated as devices.

[1]: https://lore.kernel.org/lkml/20200204101008.11411-1-olivier.moysan@st.com/
[2]: https://lore.kernel.org/all/20240206-iio-backend-v9-0-df66d159c000@analog.com/
[3]: devicetree/bindings/iio/adc/adc.yaml

Changes in v2:
- Update enable/disable backend API
- Rename devm_iio_backend_subnode_get(), as devm_iio_backend_fwnode_get()
- Update iio_backend_read_raw() prototype to fully match IIO framework
  read_raw callback prototype.
- Change st,adc-channel-type property name and type in DFSDM binding
- Remove sd-backend and rename ads1201 compatibles in SD binding

Changes in v3:
- Add iio_backend_read_scale and iio_backend_read_offset
- Remove sd-backend compatible. Adapt existing sd modulator driver and
  binding to support backend topology.
- Misc corrections in DFSDM binding & minor changes in DFSDM driver

Changes in v4:
- Remove allOf and rework examples in SD modulator binding
- Wrap lines to 80 characters in IIO code

Olivier Moysan (8):
  iio: add read scale and offset services to iio backend framework
  iio: add enable and disable services to iio backend framework
  iio: add child nodes support in iio backend framework
  dt-bindings: iio: dfsdm: move to backend framework
  dt-bindings: iio: add backend support to sd modulator
  iio: adc: stm32-dfsdm: adopt generic channels bindings
  iio: add iio backend support to sd modulator
  iio: adc: stm32-dfsdm: add scaling support to dfsdm

 .../iio/adc/sigma-delta-modulator.yaml        |  23 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 153 ++++++++-
 drivers/iio/adc/Kconfig                       |   2 +
 drivers/iio/adc/sd_adc_modulator.c            |  92 +++++-
 drivers/iio/adc/stm32-dfsdm-adc.c             | 298 +++++++++++++++---
 drivers/iio/industrialio-backend.c            | 116 ++++++-
 include/linux/iio/backend.h                   |  14 +-
 7 files changed, 633 insertions(+), 65 deletions(-)


base-commit: 529d2e1900642eba6df28307e26e19793e227546
-- 
2.25.1


