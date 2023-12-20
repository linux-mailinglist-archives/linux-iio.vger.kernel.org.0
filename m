Return-Path: <linux-iio+bounces-1151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA4381A29D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C071F2576B
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54C3FE2B;
	Wed, 20 Dec 2023 15:31:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFB47774;
	Wed, 20 Dec 2023 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKFBpjv020784;
	Wed, 20 Dec 2023 10:31:18 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v42psr452-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:31:18 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BKFVGg4005285
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Dec 2023 10:31:16 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 20 Dec 2023 10:31:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 20 Dec 2023 10:31:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 20 Dec 2023 10:31:14 -0500
Received: from [127.0.0.1] ([10.44.3.57])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BKFUxX5006998;
	Wed, 20 Dec 2023 10:31:01 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 0/8] iio: add new backend framework
Date: Wed, 20 Dec 2023 16:34:03 +0100
Message-ID: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGsJg2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI2NDI0NL3czMfN2kxOTs1LwU3UTjlGTDRLNE80RTCyWgjoKi1LTMCrBp0bG
 1tQDgujpyXQAAAA==
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703086446; l=4050;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=txvG4Uxjgg/nZaG3hxvp+aYHAuJIYXpouksEugXZOmw=;
 b=U4haUxNZiHsqZ6QQGfQ9t49RiyLqAeL0jbYQanm1wgCqogCRmv/8xg/VhTNhYNEHwsu60gpkI
 RLema6DHRa5DIKNHNSPxEtaAAcR2iJj+lXaZafnCLjuJIcgL9WYoGav
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: IveFMyCzWRV6HUlDjKzI9o4C1vAxauvN
X-Proofpoint-GUID: IveFMyCzWRV6HUlDjKzI9o4C1vAxauvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=984 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200110

v1:
 https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff

v2:
 https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e1@analog.com

v3:
 https://lore.kernel.org/linux-iio/20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com/

Changes in v4:
 - Patch 1:
  * Don't make io-backends mandatory.
- Patch 5:
  * Add helper __devm_iio_backend_get();
  * Add new devm_iio_backend_get_optional();
  * Add new devm_iio_backend_get_from_fwnode_lookup();
  * Convert all dev_ logs to plain pr_ logs so we actually use pr_fmt.
- Patch 6:
  * Implement the fallback backend lookput in case
    devm_iio_backend_get_optional() fails;

So the main difference in this series is to still handle 'adi,adc-dev'
in case 'io-backends' is not given. Hence we don't need to make it
mandatory and break dt ABI for the ad9467 bindings. Rob, it would be
nice if you can take a quick a look on it and let me know if there's a
more efficient way of doing things.

Rob also already expressed that he is ok with the dt ABI breakage as long
as it is properly justified in the commit message. Jonathan, we should
see if we keep things as in this version or rollback. Personally I'm not
that "happy" with that devm_iio_backend_get_from_fwnode_lookup() given
the fact that is not really supposed to be used anymore. OTOH, it's small
and simple... So, let me know your preference and I'll go with that :).

This is likely the last version of this series for this year. If things
go well, I plan to start working on the second user of the framework
right in the beginning of the next year...
 
Keeping the block diagram in v3's cover so we don't have to follow links
to check one of the typical setups. 

                                           -------------------------------------------------------
 ------------------                        | -----------         ------------      -------  FPGA |
 |     ADC        |------------------------| | AXI ADC |---------| DMA CORE |------| RAM |       |
 | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|          |------|     |       |
 |                |------------------------| -----------         ------------      -------       |
 ------------------                        -------------------------------------------------------

---
Nuno Sa (7):
      dt-bindings: adc: ad9467: add new io-backend property
      dt-bindings: adc: axi-adc: deprecate 'adi,adc-dev'
      driver: core: allow modifying device_links flags
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework

Olivier Moysan (1):
      of: property: add device link support for io-backends

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   4 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   4 +-
 MAINTAINERS                                        |   8 +
 drivers/base/core.c                                |  14 +-
 drivers/iio/Kconfig                                |   5 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad9467.c                           | 282 ++++++++-----
 drivers/iio/adc/adi-axi-adc.c                      | 381 +++++------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
 drivers/iio/industrialio-backend.c                 | 456 +++++++++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 ---
 include/linux/iio/backend.h                        |  75 ++++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 15 files changed, 845 insertions(+), 470 deletions(-)
---
base-commit: 2dfef50589aef3b9a2fa2190ae95b328fb664f89
change-id: 20231219-iio-backend-a3dc1a6a7a58
--

Thanks!
- Nuno Sá


