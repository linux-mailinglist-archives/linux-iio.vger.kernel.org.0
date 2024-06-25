Return-Path: <linux-iio+bounces-6896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C6916C9D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AF61F29AAD
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430A176FB6;
	Tue, 25 Jun 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8RkTq0ig"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4716FF58;
	Tue, 25 Jun 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328212; cv=none; b=Tkkju/i1MpE4qjTeuZdZIlUg8AXfELvWITtmM1DpIsE95DUB7wIPZmeX9x3Xg/6aCHtIxLZKLv3chFdJNNKJuv6wpRZtZLtJgHPjWQXf1jrUQM7pUDl75AAJwuzzQ1rTPsqHYQljjedB2qHkYjyI/EAGIfTlp9YUdhtQjtyhmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328212; c=relaxed/simple;
	bh=BluXeHwplUSe1CoPOTE9WTKDqlno0VegvObIVUK0mu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CfttZPQJH1+GtNMfJnT69lvoPZf5vToYaS8Qhlmn/pbKEjUUS9clXfUXkV05AL36APAWpRxgOFZ4jGC5/W8sX0AIKB0w12JpRJhfIutgBtAgO9+wPwGZpwCwID6Sa9RRZSytyu7a/VdD0w5PSbQ8eGc+0IlVKkHsWvRU94J5kGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8RkTq0ig; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PDMWtZ024615;
	Tue, 25 Jun 2024 17:09:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=bXWNzZd00d3Wno9/beXi93
	NETzadbrJvtUIR5akEHEQ=; b=8RkTq0igjgtyEMP6NGNT3YRxApOa+B8dyts+4i
	1Red80n3tz6aQ4p4w0Dtj4P4MZn+iIS/Ux8UHYn7DyQR08t0n/24vyfrZMXOnzkO
	NdKh381MpLsJdKHEhONSY5uUQ8KoSD7uU9t09m2gpN6iaefoyDPwX1dXpSpPms3p
	SAms+gHpqLk5XCGeWa639xOAuRoDnjrUQHsGUkkNRTL7fnqghnDQGTlENyoQQyc8
	19vvpw6Rj3hj46APcf5djh+TA09CfhIxWWpzBNdZh0+TrSFYc75FzmBvJMAnBxdq
	4iS1nCsyJPp/cg6oT9qwdikcUCXj/F4yWiiZ5+h9xsp7Dk9Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywkr5cbyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:09:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E13D540044;
	Tue, 25 Jun 2024 17:09:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 246242207A5;
	Tue, 25 Jun 2024 17:08:26 +0200 (CEST)
Received: from localhost (10.252.26.63) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:08:25 +0200
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
Subject: [PATCH v2 0/8] iio: adc: dfsdm: add scaling support
Date: Tue, 25 Jun 2024 17:07:08 +0200
Message-ID: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
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
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01

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
	This API is intented to retrieve the voltage information from the
	backend. It is based on IIO framework read_raw API.
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

Conor, in this v2, I left the SD modulator driver & binding unchanged,
regarding the naming issue you raised previously.

The problem here is that we have two versions of the generic sigma delta
modulator driver: one for legacy support and a new one to support new
binding. Maybe an alternate, is to rename former sd modulator as
"legacy" or something similar.
I will address this point in a v3 if necessary.

Olivier Moysan (8):
  iio: add read raw service to iio backend framework
  iio: add enable and disable services to iio backend framework
  iio: add child nodes support in iio backend framework
  dt-bindings: iio: dfsdm: move to backend framework
  dt-bindings: iio: add sigma delta modulator backend
  iio: adc: stm32-dfsdm: adopt generic channels bindings
  iio: add sd modulator generic iio backend
  iio: adc: stm32-dfsdm: add scaling support to dfsdm

 .../iio/adc/sd-modulator-backend.yaml         |  39 +++
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 157 ++++++++-
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/sd_adc_backend.c              | 117 +++++++
 drivers/iio/adc/stm32-dfsdm-adc.c             | 302 +++++++++++++++---
 drivers/iio/industrialio-backend.c            | 108 +++++--
 include/linux/iio/backend.h                   |  10 +-
 8 files changed, 679 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
 create mode 100644 drivers/iio/adc/sd_adc_backend.c


base-commit: 2dfa1b7bfc07e58acb9f9eaa8c871f37189dbfee
-- 
2.25.1


