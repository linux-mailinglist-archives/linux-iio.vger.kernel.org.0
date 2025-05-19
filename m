Return-Path: <linux-iio+bounces-19673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB3ABC02B
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018AC3A6E9B
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A6283C87;
	Mon, 19 May 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f1iT1tXW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B128312E;
	Mon, 19 May 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663431; cv=none; b=EZOTAHWx3li+N+ufH4FZoSMJ3GKYvid3A5dVyUMSX01pcxbcdez//CA4fPl3SXm2AaiUHkYWNXAs3mLrcLulmTV7LSeavDANi+4bsgwaolH/dlHy6nCeBQ7ulRhrjtUQjSofPqJe31gLjlHteca4gq/gK5gpgAFqka8QTvrYWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663431; c=relaxed/simple;
	bh=aYWJWt3G7r/smo3ijK9C45OjuIVIcOmlu+UMmoR/0co=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGkQozMl10bvbHI4hop9+e6hBZA9WPm0RM0mCae1yR52Vi/GKqLwI2G2UEQ8ekvJixuuuAKG48NJJMZ+47vdWbeCnnKzNIEU00BFHfZ9JyJmS/HFESVFOy3542CGho+vL//eHlG/e3Kwj/mLzQi8vLB0jFBCloks4BxWhOkzJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f1iT1tXW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDmJ3v027763;
	Mon, 19 May 2025 10:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=IicPCQLIE2NnbKuRbTPpEXewK5U
	VDR946P0BhSGpJhg=; b=f1iT1tXWInK3p2k7YTiC2NcVzJhdO5jJ4W7gWsrdhrG
	mG+dLRrUBPXgLuzh6j+vxC273YDcSwFPCO+9EOe0/UsdB6ChTAouRKvBVdi6yL0U
	JoVTQUrOSFPHO28EqCGj06+3Gl/pSoRD8skouYS5Ra4A4yd9uqAmHe93zhNRnYwK
	Jy2YzpwdBnSoyqFJNo1ytwrwsmtCE1R/yJioiUEoeACsbc29IzUJT9CQJgQgO0Sc
	UpAs8H8JsTqdM/p5GwwSxX77Ei9SIvjMsQBe5Bux4gZN0SLmmQWm9NbKaKAmcDta
	/YM3MdYseIiBod7eq5FZJyw4MdWjbFi1VyQ3B4dpguA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46q8sfwjdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:02:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54JE2wxk038207
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 May 2025 10:02:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 19 May
 2025 10:02:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 19 May 2025 10:02:58 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54JE2bPC016713;
	Mon, 19 May 2025 10:02:39 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
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
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ioan
 Daniel <pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/6] Add support for AD7405/ADUM770x
Date: Mon, 19 May 2025 17:02:08 +0300
Message-ID: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
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
X-Authority-Analysis: v=2.4 cv=FusF/3rq c=1 sm=1 tr=0 ts=682b3a14 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gkbNl49xHU_gtnum-JMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nYXtFkxGYlptPEhwJsI_sp-oZVA9Gf5z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMCBTYWx0ZWRfX8FVuizBG7X9V
 uZidxgzOJGiy+ZLUEx2Y3AFnfTeW9XTYSf513lCErnEkObo1E0YoslncekWIBXFlvRWjzCD/zoP
 GU8ttbdhgKBHuN/y5GvvFbMaj1Ot0uVfKb0ZXdtE8lrF/2FurBH7rR4rOxasWtNpf+x9D6WxUKo
 8RX44B5yTEzkv8Z4gQoV6c3HdAe3PytwqMegrmQv6hJEEHtOCJ7R6DbFbfEBAvkxnbDO9meB5jc
 xXNOSrQvb9fsrnSZ9vVWXrv4Lx/kakAVjs2tAw6/4NWfdyrrak19fr1n86L9JYgYCYlU3UUIw3I
 bb/O+mHul4hF9e9fxVBAfCsq339iPlNnQehag4PBV5OCCStnkHz1fr/Bc/TiiAdYrNxQJnYQFEf
 UQNkYNbOX+Lz5Z95BeyZdmRWw21fbfefmn4YLF9B6RxKgsgVqGrlO8zHuDox3ofpP5e4Czh0
X-Proofpoint-ORIG-GUID: nYXtFkxGYlptPEhwJsI_sp-oZVA9Gf5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=875
 mlxscore=0 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190130

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

Pop Ioan Daniel (6):
  iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
  iio: backend: update iio_backend_oversampling_ratio_set
  iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
  dt-bindings: iio: adc: add ad7405
  dt-bindings: iio: adc: adi-axi-adc: add ad7405 example
  iio: adc: ad7405: add ad7405 driver

 .../bindings/iio/adc/adi,ad7405.yaml          |  60 +++++
 .../bindings/iio/adc/adi,axi-adc.yaml         |  17 ++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4851.c                      |   7 +-
 drivers/iio/adc/ad7405.c                      | 250 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  20 +-
 drivers/iio/industrialio-backend.c            |   3 +-
 include/linux/iio/backend.h                   |   3 +-
 9 files changed, 364 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 drivers/iio/adc/ad7405.c

-- 
2.34.1


