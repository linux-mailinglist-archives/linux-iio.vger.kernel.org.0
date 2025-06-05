Return-Path: <linux-iio+bounces-20242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BCAACF2B2
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 17:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80A1179241
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF861E1DE2;
	Thu,  5 Jun 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yC5Jwzdt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59121A2622;
	Thu,  5 Jun 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136258; cv=none; b=qKGStIGPtntjvom+815/O7cdSc6d9xurPszZjaDl+NQyZRmlZRYHdffaYIgw0GKIAbg/5nu3Pz9+SCN3QG8430G1HKnprvP888tOuokD5fh/ElqCzswS6N7T8Hw6+uUZkappSgfNnfEoZw/forbOdVLHltSJbe5Px7v0erT05Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136258; c=relaxed/simple;
	bh=DbkGtSX5uPQwnwHmaDPrbgS/BdSVnQmRRQ2CAF3LLE0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XlOLVwereehb/7+t1dSpM6fA6sJGgfJLmwRZ/qENX8H9PNgBjlSuvyaj1kLP5fpoTeN3SZrjDPe5vxHHC63Zl6ApmbIe31lXvc5JlqeKCIEukAaVuyAcA3XsBAxEN6DhLtdqi4nOCU+u6D/l4hj8SqT5xehiXNQg10II7Zwvps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yC5Jwzdt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555D2d5f014028;
	Thu, 5 Jun 2025 11:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vzDkF4v+KTwu+/2OCes+s1U9Sat
	3JuMlIoRhUM42ZRs=; b=yC5JwzdtYNva/kKhGfj9VYxLzEXvJmfgR0NUz2XCXjX
	hlt9ZW8Pnyhk4s5VTvll+aLmiWRrS8FLgolfp6bhAXIaNyfliqV0/rTo6ZJPmZ+q
	nSL5yBhTYhnX6lYYxNgU9SzxEQtnNbvtIQPpgTH5Yf4Qa6ckY6d++XXr7bLYKl27
	wOjregY0kSBPSSQPFhPabqDY1lM7ySNnOGzASRjtpRM5pCGsCUnKL7t89qnDpaUK
	wXfl34gj4UqcaNKF6l3bQ6oVAl3KPs9zxw8AExa/OJfrrLFcYnwBVww/H5S5Iko7
	o+CffPgQx8zbZwM2pi134bBSrsJZJlXQbtGmoWASAsQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47386c9phj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 11:10:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 555FAN6K046892
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Jun 2025 11:10:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 5 Jun 2025 11:10:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 5 Jun 2025 11:10:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Jun 2025 11:10:22 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 555FA1up027831;
	Thu, 5 Jun 2025 11:10:04 -0400
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
        Angelo Dureghello <adureghello@baylibre.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        "Ramona
 Alexandra Nechita" <ramona.nechita@analog.com>,
        Pop Ioan Daniel
	<pop.ioan-daniel@analog.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Herve Codina <herve.codina@bootlin.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/5] Add support for AD7405/ADUM770x
Date: Thu, 5 Jun 2025 18:09:38 +0300
Message-ID: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
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
X-Proofpoint-ORIG-GUID: MDmK1m5lpJ10jF8joYrN6XDWjNEt9bd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEzMSBTYWx0ZWRfXy0kDZdgTaXf2
 qilGvDuikq1JT4ZqmP2f4Mqgoe7vqfUdYgqFs9LiNhky8l4N/fxkBF53SRy8nO1pPHbTaR+lFQR
 ozy2nIiLmtfjURvSd3W8Lc9gtWfeFCc14sA/ioAJiUv4x8oQBU48V465DHxKPm6uYt8m+i13ub7
 SuMQD+qmOw9VJlyN9GDmjXN9ZLBxFSROp3R2dwYdsS0dbeeUWocVE96EGYPxMcLMLW1NDKS+C1D
 3UJZeeLRewR9I9D9Ma6glqJohCDBAXEidMYpaEDC11O9VVVfyatzu/hyTy/u6mcejfQ3MXtyy5f
 e7lp+wLcFDWEguoG1VjoQ9M7u0V/17ajLpiQn/gz1fFO24KaschjrThxNBdtqpnjlKS0W9oB4dk
 J2sGhw92IQL52yrIjbUkG00HOxBtRKB/W+Ty1eGUkhVAFT403oowqrEUl0ipfSDXZ/IEuDmj
X-Authority-Analysis: v=2.4 cv=KYLSsRYD c=1 sm=1 tr=0 ts=6841b360 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gkbNl49xHU_gtnum-JMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MDmK1m5lpJ10jF8joYrN6XDWjNEt9bd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=815 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050131

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
 drivers/iio/adc/ad4851.c                      |   6 +-
 drivers/iio/adc/ad7405.c                      | 259 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  20 +-
 drivers/iio/industrialio-backend.c            |   3 +-
 include/linux/iio/backend.h                   |   3 +-
 8 files changed, 356 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 drivers/iio/adc/ad7405.c

-- 
2.34.1


