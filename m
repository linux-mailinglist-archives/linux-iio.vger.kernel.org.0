Return-Path: <linux-iio+bounces-17227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B3A6D6FB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34A91892711
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBD25DAEA;
	Mon, 24 Mar 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PND74vpT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD914EC46;
	Mon, 24 Mar 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807432; cv=none; b=eEFssxJGa1J65cxah7coXZBvKfdJK9Thh0lB9xZzmCqxkQHXSIbUv2Dsd8zsv31X66dVkQPPRb2PiK95mWmA5+Sj5CUq932sb4Pnavp19k5aGezjSLYHjqWA7E5HDWUs0DSOCZJZCpBZNyqXjFBCsMlCyWjQIM57W/E/DiPpgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807432; c=relaxed/simple;
	bh=ftj5n7Rc+EPXXFciNjJmHrV8643fluWt5NhYQ9eUJqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CLDcAhruQA8cnqWOBNrkJHkEc2hAz8CDZHusXAn9+lS8t1tlC+6J1+DWtqxbNUxodwJSG2CbtCWFRl8scdgeiPBqW6uvR6bvRkag14fQ2tojZrl6haxi+5a3uzV46+WpVSJ+6eYMrtdrAlxED1boBUAyvyRUtcOZ4XGL1K061VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PND74vpT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6oDoL018306;
	Mon, 24 Mar 2025 05:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=BKDTpGEXaq51Sg/p+bIns9yVApr
	9NhmRLk9rfCgRNI8=; b=PND74vpT3KnQ/MerDUEt/PCJF/DeZwcS1RZa3Udk/Kd
	EDGnfq33igtkbQ2ethFwcJaUm1xYumCtP6yVFyF8ROyBhD/KFaHy7RhFnX52yiKX
	XIZj3kIRdAkonK5LKP8YE/vFQP7tFyU/JOYri8FNSeE2X/xSHjsAozVs94Tf4VqQ
	hQkS0SzymU43FiVQMXJLgTrWim18XhIJjjnHpybzgIGJoroapzN0diXIc4i4SRpw
	+/UMrrZ0itYVL09N99iFXqGEYD4F1qSw05Zeo0fYaYbjxPowvVM4OR+oM0YOhQf0
	lMNL11X6TKGS3f07LyZ5i/XtS3GZ3U77JnyJk87suqQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45k2fmgnbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 05:09:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52O99tFc058882
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 05:09:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 24 Mar
 2025 05:09:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 05:09:55 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52O99Y69001058;
	Mon, 24 Mar 2025 05:09:36 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        David Lechner <dlechner@baylibre.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Guillaume Stols <gstols@baylibre.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Ramona Alexandra Nechita
	<ramona.nechita@analog.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Subject: [PATCH 0/5] Add support for AD7405/ADUM770x
Date: Mon, 24 Mar 2025 11:07:55 +0200
Message-ID: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
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
X-Authority-Analysis: v=2.4 cv=As/u3P9P c=1 sm=1 tr=0 ts=67e12164 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=-b-aYdi1BcR_ETs2v9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iXCc6ty2Eiqg9XWL1mNC_f-20UFSju_v
X-Proofpoint-GUID: iXCc6ty2Eiqg9XWL1mNC_f-20UFSju_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxlogscore=936 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

The AD7405 is a high performance, second-order, Σ-Δ modulator
that converts an analog input signal into a high speed, single-bit
LVDS data stream, with on-chip digital isolation based on Analog
Devices, Inc., iCoupler technology. The AD7405 operates from a
4.5 V to 5.5 V (VDD1) power supply and accepts a differential input
signal of ±250 mV (±320 mV full-scale). The differential input is ideally
suited to shunt voltage monitoring in high voltage applications
where galvanic isolation is required.

Pop Ioan Daniel (5):
  iio: backend: add support for decimation ratio set
  iio: adc: adi-axi-adc: add set decimation rate
  dt-bindings: iio: adc: add ad7405 axi variant
  dt-bindings: iio: adc: add ad7405
  iio: adc: ad7405: add ad7405 driver

 .../bindings/iio/adc/adi,ad7405.yaml          |  68 ++++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7405.c                      | 301 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  43 ++-
 drivers/iio/industrialio-backend.c            |  18 ++
 include/linux/iio/backend.h                   |   3 +
 8 files changed, 445 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 drivers/iio/adc/ad7405.c

-- 
2.34.1


