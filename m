Return-Path: <linux-iio+bounces-8055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCB940C39
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07D928649A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F601946CF;
	Tue, 30 Jul 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sJ/74LV7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E614194156;
	Tue, 30 Jul 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329335; cv=none; b=X+ocOcmsseVWA7coNUKcuLzqyHvaua7LIYphGUjM+tyd8Bb5jr4ST0h4DD8XdJgQoggK6yInxlyuDhZALsA1stpEFHoGUW/jWWc6PAnE4WxuintZKKpR85hdhc9I8FCFHEwTyp/6GKRY3bSx6xtMcAh+q3Ntz3VH4BWC2YKoqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329335; c=relaxed/simple;
	bh=khjDndLYXHzZAPFCxoaIB1hzF6l7thcZvrRJ8muy0lU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F6y1ph2rsCQDnqLL/0CwYHQSlUYuzfGsyPmRAoDOeviQJKJ8yBnyST3qdEsjSajotT/kPkRzIg3b6UPQo5kVBxXTsvsh8t36y44wS9yi7SqVa1NY/MaTnPVFdAMj025bUMyrB4CQTTNPFFBrGY2OZlJj/Z89h7EOhAgRggcNZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sJ/74LV7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U7FGQ9015481;
	Tue, 30 Jul 2024 10:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=EiPoUOUSjYhFBaJhI0Ab50
	w3gl5kD8XTqym4TetSUeU=; b=sJ/74LV7SEcl74BnY7JA6cH4323/T3m6zTyH6O
	WaFd6TwOmN4D8AAg8obZyyJx7jsghWrqK98HZY7hS29w5S4810zvXaBnUIwkbh6Q
	Zl9o9mkNXXad1o9Gi2VTcD6RhXP2g4m4KTfLBDEOZyFCNFfxXvBzRMDv5fxus/F1
	CXgyvutyIj7kL0JMyWl6lPQdv7sFtLCn/n8qjpKAGVK1LFC1g6cy+Gkv7EmN2L1x
	Et9Ahn2zUPMxsLpuTwDOGEG2wzePPh97J+TnPBuPuv0ciwwSGL5cgFG+syXzBZhu
	v0KDdhiELZIr0YE8QQBi93xvibAmW8ua3PiLBFcCUgn91lMA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40mr7wus4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 10:48:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C971540048;
	Tue, 30 Jul 2024 10:48:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD14F21ED50;
	Tue, 30 Jul 2024 10:47:14 +0200 (CEST)
Received: from localhost (10.252.3.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 30 Jul
 2024 10:47:14 +0200
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
Subject: [PATCH v6 0/9] iio: adc: dfsdm: add scaling support
Date: Tue, 30 Jul 2024 10:46:30 +0200
Message-ID: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01

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

Changes in v5:
- Move iio_backend_read_scale and iio_backend_read_offset to inline
  and update prototype
- Fix channel number & remove legacy binding example in DFSDM binding
- Rearrange DFSDM patches to fix build issue in serie
- Split SD modulator binding patch.
  Move reference voltage change in a separate patch

Changes in v6:
- Minor cleanup in DFSDM binding
- Fix vref-supply dependency condition in SD modulator binding

Olivier Moysan (9):
  iio: add read scale and offset services to iio backend framework
  iio: add enable and disable services to iio backend framework
  iio: add child nodes support in iio backend framework
  dt-bindings: iio: dfsdm: move to backend framework
  dt-bindings: iio: add backend support to sd modulator
  dt-bindings: iio: add vref support to sd modulator
  iio: adc: stm32-dfsdm: adopt generic channels bindings
  iio: add iio backend support to sd modulator
  iio: adc: stm32-dfsdm: add scaling support to dfsdm

 .../iio/adc/sigma-delta-modulator.yaml        |  25 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 122 +++++++-
 drivers/iio/adc/Kconfig                       |   2 +
 drivers/iio/adc/sd_adc_modulator.c            |  92 +++++-
 drivers/iio/adc/stm32-dfsdm-adc.c             | 293 +++++++++++++++---
 drivers/iio/industrialio-backend.c            | 101 +++++-
 include/linux/iio/backend.h                   |  29 +-
 7 files changed, 592 insertions(+), 72 deletions(-)


base-commit: bf829a98bc4bb9076a2fd70f4a69ea7e281863fa
-- 
2.25.1


