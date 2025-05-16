Return-Path: <linux-iio+bounces-19590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC09AB9AA3
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 12:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F603A961F
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EECB2367D7;
	Fri, 16 May 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MHq343bu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A323644F;
	Fri, 16 May 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747393153; cv=none; b=hAHuy+1T7FXxfFTxBiA51BUm77sNAYKqGS8oCpYDCIZVpBGIC01g8wxD4geAe0ZIzdyAEUP47+1DNq39WHTxmWnfy7GbB+UeIBC69q+MhdKTI6O6MgnnuD+74vXLzAucDz8lRMF10T9ewb2q+33RnpfUdvjLGcEI+pMd/CnTi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747393153; c=relaxed/simple;
	bh=WXEEY/jtj9XEdd885skj8JnvFWD7bqG59SBp8cC1zMI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hgl2wmvpH0pNSw/uOfs3jk1gQL1pTN19irNrtbtfV5nJr0NlayedWJw7o2P6WxxW82n72bCjpRzS1rJEKuQ+/ffCor8vTxPKUNguEcmxPTWuC6IGYLLmSXK7LoBMEQ1b4CZAgPk6G4dZFFqfD0ApFzl7ipjNW76mWJ3IWj1nBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MHq343bu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GAC2C6016352;
	Fri, 16 May 2025 06:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=cs9Bu9Yw2OGXP3ylCvTo/xFCZPj
	dnadOIj752mI5jjc=; b=MHq343bu57fIfdOOa2GB90oOmlBSj11YraC9wUGCX+n
	0sOfKuw2EWjijOM8aC+tmjm/jcDaqtI2MSqWV8Q7LI+fr4Ja5kGP7vDPYygjAtg/
	iAFWQj4PTZU7jSPwzfR9SrdltCxifFg6I2KG2JyuxeMGsjHi+RVfB0gIAOBLqu1m
	SQt+r+w7JCao8hEluOLnMxP/XhiN6icp9uaYu19uOZlYqZOnSOTIUI1SkNMO5oCO
	/WBNur/eg18gcr0094C07sV7epkJINo8C+LZjOh5crZkzUkZKBK5GKnQMr6R6dxX
	SVFiI2lBLB/H67v4N0+xmBZDvHE6L6P9E/cHEjMySww==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46mn655jsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 06:58:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54GAwkIm050031
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 06:58:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 06:58:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 06:58:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 06:58:46 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54GAwRHu006196;
	Fri, 16 May 2025 06:58:30 -0400
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
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Ramona Alexandra Nechita
	<ramona.nechita@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Add support for AD7405/ADUM770x
Date: Fri, 16 May 2025 13:58:00 +0300
Message-ID: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
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
X-Proofpoint-GUID: In3dMVmB9_A8qE1VJHuIOMgaoV1dNBas
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwNCBTYWx0ZWRfX79L7NUQI1XYj
 JoiDgHfMkdJOYzeitOyLJKi8B1BhSqmJJ5n61peMmkQJOrWIHN9YEVeXezM2aOrv14xl51/aPuG
 JrXbTGjvssG3in1tiF4x3FW7EO3JWFj1cU/v2RJuBX4SPjDPw5zb8QFQNV+8GT6UWzXG6XeMXrx
 g27GhAn+q44zHi+wcIfG3BVNRSSHPFFXJZ7GNW3hX0GFRDX5N+/126lJubOzeI6TN4xbf4IMxgR
 lmIFN8SMx1JTouyHo6IQJYBTH+a830xYZG3MwYwSs7AQZ1dLN/OShRI3KO85TGcuqy1mCcoL1mu
 BKMdri37S3uvy87vH8ADFavYjUgxWyVq0AiX2w/v0v1RUBNduKhUZZUjmyjMXrNNPCSRx/RlGwe
 MrrPRgu487A8XTUYyqsrb1NPOMrdH8YUfGuXFeCrRfrUAb05X7w+OhFi2GeWqKBzvQKc+TTH
X-Authority-Analysis: v=2.4 cv=SZL3duRu c=1 sm=1 tr=0 ts=68271a68 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gkbNl49xHU_gtnum-JMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: In3dMVmB9_A8qE1VJHuIOMgaoV1dNBas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=840 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160104

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

Pop Ioan Daniel (4):
  iio: backend: update iio_backend_oversampling_ratio_set
  iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
  dt-bindings: iio: adc: add ad7405
  iio: adc: ad7405: add ad7405 driver

 .../bindings/iio/adc/adi,ad7405.yaml          |  60 ++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4851.c                      |   6 +-
 drivers/iio/adc/ad7405.c                      | 276 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  20 +-
 drivers/iio/industrialio-backend.c            |   3 +-
 include/linux/iio/backend.h                   |   3 +-
 8 files changed, 373 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 drivers/iio/adc/ad7405.c

-- 
2.34.1


