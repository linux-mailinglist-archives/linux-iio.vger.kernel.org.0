Return-Path: <linux-iio+bounces-19293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67932AAFA05
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2DB9C334E
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E7225417;
	Thu,  8 May 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mDVw/Hh3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373222332B;
	Thu,  8 May 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707544; cv=none; b=j+6Oe9bKLS2e8e6NKFqZQkIuooBJQsfCzONyEktmpsoBYVakFXAnEsLQkv6jh+TQr8Ijm69IGZp1d7lui+pI3MdDn+37LT0g2emt9IEGSE8Ti5fXwP56kopw1TxLnO9A61kWTi7HMNzM9zw2FxtkeUqYJgqJWzWBqHH88MfoRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707544; c=relaxed/simple;
	bh=FfWX/IeclzWuUy2UMLpj5NDXkcVqdLqLvzGQ7lL5iek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=glfb1ix7LYxE/17/QJ5E8HMkT8R/6I07lQIc//iSZwECG1L1pG10ulVwWv6AnWt6C6JnlEN3z8x/HoJZCASnIjgJm+8N6MS6SVorrYJsuGzIBPZAKUXqwcSrZtmJtPphMl99k0fsdx7QjsaMjOA1R6+06xLG5w+ha2Z6bdzm2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mDVw/Hh3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5489YIRW024036;
	Thu, 8 May 2025 08:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=UIMfvjD8VG3LsqikLeso4LvFkme
	urOmcl7jcar7/N6w=; b=mDVw/Hh3KI2y8zzl6Qrh+QESnGOw+L6mF2FjeSZ2GNw
	o4a3UgiI3qHgUOYQthUmvxzh3RQ2kpZhdaXj+2XB5w5mUjQU+4XNVI3k1nYIkAR5
	ucRb4K6EP0Q7S/Ono3in14wxPP2PK15Cn420bOklOEI+2w6o386yrBH7ZlhXdGNA
	GKhA9TE+FLPizL200sda/L8O0j9+X24wvcePp8ffcEtTPXNN9UCPXvMiw3mo69w8
	kiwnbyPdB4EM3bTb3S3eTTU4q7ygEjV9v2bK3UzOGBMfI7Y0kc1n73R+mqOb9jXF
	FdMLlQyuSN3bTBsJ6y1R43LXxpqTEpLf9NGo0pMXGAw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpct9tum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:31:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 548CVcGY019167
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 08:31:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 08:31:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 08:31:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 08:31:38 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548CVFtc002317;
	Thu, 8 May 2025 08:31:18 -0400
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
        Trevor Gamblin <tgamblin@baylibre.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Ioan
 Daniel" <pop.ioan-daniel@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Add support for AD7405/ADUM770x
Date: Thu, 8 May 2025 15:30:53 +0300
Message-ID: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEwMyBTYWx0ZWRfX4yItV59vM5xH
 n1Cg5sz7MGwGgVVYvjIXLLD8WX2yoWlVMXn4vVkkN//AKGlmE0NRINEaZ94jtiohZd/IIfZ/sXa
 KT4HbKuxO0ueyBKJkr8nOIqBas9Og4EW9BgIy1P6pnuILXZRI87KwZhvU8J99aemVnMpU3p90ue
 QXG2z4pTVPf6U3rQ9eKfcgRvK9F1uCAF0KHKno/LaLs9fdEafxFYQP48YsOdH61pLA6KWA+6s2/
 vYqiYS3QHjK+WI0QEO+YrlOR2CIzo0URSM/BZDL0BBuz8QyKIgYnIm4ySZOvzQmRoCrozEG0YS3
 jLTW9253xP2jUpdlA1P4LL2Y5flBRNl7SWaQaR5Gxpvpsv44Xr+ULW0OoGA0MmBhPu9kWD2O1Fo
 FfqHDQA+gMMTTBz+r36UpDKl9Ri14i8AsZiobLnHI0dEDCCCeTGGpHbHUhR9JggooJTnrwaI
X-Authority-Analysis: v=2.4 cv=Ur5jN/wB c=1 sm=1 tr=0 ts=681ca42b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=-b-aYdi1BcR_ETs2v9YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jOJbrgviCdB-g03iIsXEQGmW3TP-zJ_8
X-Proofpoint-ORIG-GUID: jOJbrgviCdB-g03iIsXEQGmW3TP-zJ_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=856 clxscore=1011 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080103

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
  iio: adc: adi-axi-adc: add set decimation rate
  dt-bindings: iio: adc: add ad7405
  iio: adc: ad7405: add ad7405 driver

 .../bindings/iio/adc/adi,ad7405.yaml          |  60 ++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4851.c                      |   2 +-
 drivers/iio/adc/ad7405.c                      | 264 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  18 +-
 drivers/iio/industrialio-backend.c            |   3 +-
 include/linux/iio/backend.h                   |   3 +-
 8 files changed, 357 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 drivers/iio/adc/ad7405.c

-- 
2.34.1


