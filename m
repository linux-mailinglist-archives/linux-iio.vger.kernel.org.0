Return-Path: <linux-iio+bounces-20142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B52ACAF52
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BBC1BA1A9A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A2C2206B1;
	Mon,  2 Jun 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mfYGx29N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EB2C324F;
	Mon,  2 Jun 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871921; cv=none; b=a4DkIhMapgyXxeou1UAbSTdlbumeUstSMxM5Hr7FWEnK7TaMV8qVOumDkPvim3nJX0YA2XXgXEhp4gxQqo2KUzEnUNaET91ACViiPzIrgrh75+/xNBFeyeE38fLpE27zg65GtglZZw/uk+G++JVbc7tRult4TCBYnsvkSk4vmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871921; c=relaxed/simple;
	bh=0mobXTglIxdo+eGStFtVCwyMr7/Y2lQT3ELVtKB3hsA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fnhxH+DvaGIB8hWZ3XrtU/W/5fiI9Sh2snpf/M3xW0SzHMFdesuKPKHoqbOW524bS8TIpZZrhCoY0hYUjyhPEi1hfNJBiGsMUBhQDEe/+/3xviEGe5MzwfmCFZj+JLoJdB7X6TiBESEvUtI4cp+YXxtZXuXtAamRPDqPWRPhFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mfYGx29N; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552Aq12D018475;
	Mon, 2 Jun 2025 09:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Zzr+R28twXQgddLKOTC9jC3aTBp
	2SzMm3/BX8KZ+6FM=; b=mfYGx29NEHpyFH6ufGK4jzJjAC/2jVargufVD1gDsD+
	thGbCSXfwPp0N2oZiK10EK4ya4fgMZjB1j4BfZlyxsQrdMcwkttA847Q5+r1TYw8
	tkajUw+yv3gJ76FqASwmTCH7xEWXJBOY+PP1w/Xs6CthlfsdAXoWw45mo4KD57RF
	EJkPmkkqv1SROC0p/K6eOh51DxRpnWzuYjKk45loTz7a0ObwdoPJxWaULY57xjL5
	y5kEOmBC7VtsDfE+sfLJBC/PJz0kl0F/5bqVLGWDF7P98TDsDocRLhDaOpPyJ204
	wYrwz9LxTpvpQm7zj4/7E1lC4orDxRhJDHDhszoGFig==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46yxdaqwam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 09:44:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 552Dings036956
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 09:44:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:44:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:44:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 09:44:49 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552DiSJL010531;
	Mon, 2 Jun 2025 09:44:31 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/5] Add support for AD7405/ADUM770x
Date: Mon, 2 Jun 2025 16:43:38 +0300
Message-ID: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMSBTYWx0ZWRfX5QE79aLefCvs
 wt+crjUvx9I/OzyDWyeN2Th+zaWoV+0Y3fa4h5kaDR+em6nJ2eB7+SK25YDHQcmzS96mo8yQXEr
 y96BDUDIYrZVoKlGI9JHE6ibOBeB23fK92njA0dOBJF4NOHDcllITFAp9qKuMu5zJA7YF+XB2eb
 aT2h6v3pd4Jeryt8Bwkjs8klfZn+D88/1gKlz5Dgl1X2Zm4/0sn+dKLHpx8lBsJQ7qb9LD1lIo3
 5ZYIXc+80u+abqJivTXup1H3WzHVmuPy37uWPUF58GzLsF+7uEnRem5lVh+yl/IhJ8g4h7AhUEx
 t3X8EK3Yw39bA0u8f+KTIgInXJrJnigP9RLrH6Z8tUyuPfvbfg56AAkW0wFI9DRm5WCUZaF3ZWm
 vLwkoSVuNO/A2ZfRKafnSAC8a6gbIC217ktCU5VqdfSGa/KKgWia4jdebSkHjPh7eAzevkxe
X-Proofpoint-ORIG-GUID: sDx7c3_jZsP7pRE4o5EJhKwlBohxd-L-
X-Proofpoint-GUID: sDx7c3_jZsP7pRE4o5EJhKwlBohxd-L-
X-Authority-Analysis: v=2.4 cv=S5XZwJsP c=1 sm=1 tr=0 ts=683daad2 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gkbNl49xHU_gtnum-JMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=863 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2506020111

The AD7405 is a high performance, second-order, Σ-Δ modulator
that converts an analog input signal into a high speed, single-bit
LVDS data stream, with on-chip digital isolation based on Analog
Devices, Inc., iCoupler technology. The AD7405 operates from a
4.5 V to 5.5 V (VDD1) power supply and accepts a differential input
signal of ±250 mV (±320 mV full-scale). The differential input is ideally
suited to shunt voltage monitoring in high voltage applications
where galvanic isolation is required.

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Pop Ioan Daniel (5):
  iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
  iio: backend: update iio_backend_oversampling_ratio_set
  iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
  dt-bindings: iio: adc: add ad7405
  iio: adc: ad7405: add ad7405 driver

 .../bindings/iio/adc/adi,ad7405.yaml          |  60 ++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4851.c                      |   7 +-
 drivers/iio/adc/ad7405.c                      | 256 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  20 +-
 drivers/iio/industrialio-backend.c            |   3 +-
 include/linux/iio/backend.h                   |   3 +-
 8 files changed, 353 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 drivers/iio/adc/ad7405.c

-- 
2.34.1


