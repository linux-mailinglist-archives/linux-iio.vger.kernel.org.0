Return-Path: <linux-iio+bounces-6520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40B90D8B5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30FE1F21928
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1605113A41E;
	Tue, 18 Jun 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FpKjfsjY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5D12FB3B;
	Tue, 18 Jun 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727076; cv=none; b=cOF3CJFa/ZH94H03p4v6PNmhM9Fmqn3wXdgqDBioXJKYFJwiogeX18UU8T/ONGQvJWBe/Cw6wwnlCDAtRWsAi1WCegiRKkxd528gGibMUZB3a+1fmBIbOD8OU/HuizublUCduPHuzzEQKx8Zb5OO/W+R/qew+bArVLWDfKbVteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727076; c=relaxed/simple;
	bh=kZKXbV0lhStB0O+275SN390lj+8/FT/2I41VGYaOVP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cjirh6HWpTfqPnY/j/QHn/btxNZegm5efhv/JvH7O3OXg29i9xu+wPAKMtaivolKaFOSowK6f2Ar0F5Zx9yVuK6H7mCS/J0Qq2oYNiNNQ0hJfzz4MT3vwpYZssA/DwT2CuEHso9PaRrxW/qdm3WGE+Ro0x/gNv+YmpVg5rfSE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FpKjfsjY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IG79xx022142;
	Tue, 18 Jun 2024 18:10:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=z5NFMMQZPHGp3gWcmS7/W4
	PryNOHDlUiWMV40ZjgePg=; b=FpKjfsjYe0UVIP+QQtTdvaQXnWCVXGDk+0nyYT
	VMrq1aGxqwh/BYEyjx3zPbzo4w55eDVXrVlD/TeEnDZTjYvKJWZigq8PWceQ9fxq
	RMvKyGzBH7TngcD/ZVRei/LQJsyCqg8Ry26HFoLH6/LUSX9PpW2+pA4mo8KN+IPZ
	+9kHhGS1oBmpg5xq3ddYoBvU83HAfqMnpGBYn1LgPHy+Jda/4E2ljDNmiYcbqIcV
	Y1XPxuGv01WZC5jFnjZKcK8iDW6ckcyNRNFAG7fQPDKNTBb7lPbaSRwKcq0chGsK
	A9ZX/ikCiuhqnjRyik2IA+OmiIQj+WzvQY55sMVdCbd416NA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys1ucv1py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:10:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5C25040044;
	Tue, 18 Jun 2024 18:10:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 612BA21D3C9;
	Tue, 18 Jun 2024 18:09:22 +0200 (CEST)
Received: from localhost (10.252.27.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 18:09:22 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nuno Sa
	<nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown
	<broonie@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/8] iio: adc: dfsdm: add scaling support
Date: Tue, 18 Jun 2024 18:08:26 +0200
Message-ID: <20240618160836.945242-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

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

This series extends the backend framework with the following APIs 
(which may need further refinement):
- read_raw:
	This API is intented to retrieve the voltage information from the
	backend. It is based on IIO read_raw API, but maybe we need
	a more specialized API here.
- iio_backend_disable / iio_backend_enable:
	backend enable/disable to be used for PM management
- devm_iio_backend_subnode_get
	Intended for parsing DT subnodes to allow generic channel binding
	support, as generic channel DT nodes are not populated as devices.
	Ideally, a single API would be better, but I could not 
	identify a suitable alternative that doesn't affect the existing API
	(devm_iio_backend_get).

[1]: https://lore.kernel.org/lkml/20200204101008.11411-1-olivier.moysan@st.com/
[2]: https://lore.kernel.org/all/20240206-iio-backend-v9-0-df66d159c000@analog.com/
[3]: devicetree/bindings/iio/adc/adc.yaml

Olivier Moysan (8):
  iio: add read raw service to iio backend framework
  iio: add enable and disable services to iio backend framework
  iio: add child nodes support in iio backend framework
  dt-bindings: iio: dfsdm: move to backend framework
  dt-bindings: iio: add sigma delta modulator backend
  iio: adc: stm32-dfsdm: adopt generic channels bindings
  iio: add sd modulator generic iio backend
  iio: adc: stm32-dfsdm: add scaling support to dfsdm

 .../iio/adc/sd-modulator-backend.yaml         |  43 +++
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 158 ++++++++-
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/sd_adc_backend.c              | 110 +++++++
 drivers/iio/adc/stm32-dfsdm-adc.c             | 302 +++++++++++++++---
 drivers/iio/industrialio-backend.c            |  90 +++++-
 include/linux/iio/backend.h                   |   7 +
 8 files changed, 664 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
 create mode 100644 drivers/iio/adc/sd_adc_backend.c


base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
-- 
2.25.1


