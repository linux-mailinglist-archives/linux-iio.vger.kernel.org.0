Return-Path: <linux-iio+bounces-26650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71599C9CF87
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 21:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2973D3A88A3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CA32F744D;
	Tue,  2 Dec 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GDD8XKWF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915421883E;
	Tue,  2 Dec 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708916; cv=none; b=CS+aFBRJ0I0qqdo2FNb9jA8AgJGlvakIK2t9rHRpnQteMCW6S12+iqId2MvsmZHkmxCYz51fhk2ximomLxFBPn7p0vtsK0nzFIPv+nnSBhR/brwkYuBk2BYJ81a4gYBLeSvRLMg4sg+GEsJxAhodNvAH8nUADW8b6mIoTsS+8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708916; c=relaxed/simple;
	bh=QwmHg1uerCfvb5BjF2ztT04EqmS552kUVBsir3CZwAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWGwyGkW2/aaC6+0zAWvspw3yku2ASZ+VM4syQK9/mbGhljnGaEDlyelMHLBGVbM1zWx4cLH8WpM9idSrSRsOgMV62ADr8jLx7We6uBjoNhKGW7UuRZImtdy89EXmxDJbOdjY5TGp5q8Xap4blx6rWueTc8nu3I7pTzIepvQtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GDD8XKWF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2KZNpH2012103;
	Tue, 2 Dec 2025 15:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=wHQMLkTCT4GsC01U7Soy3nm5GvG
	T4g3cXFkV3Et7t90=; b=GDD8XKWFVBuO1hnRM+h7s7Vq9XbHG+B/UMvwxQAFqQB
	4Ys5gIJwetvo8MtA45CkjbFYi6+ogX8UaEpK9SG9ajFDdbBi+HJqdi9GCivXAmG5
	+KvVfdMLO6eA5RQ+MviunfLE8jv2d+mv4UMr7XiyqtNa5o29/eSAaNTINjnGaq/v
	VaUI67jHEZS+4lFzuTdGgZr1Af++mKhhIxN1uti+eB3C0p48fWDK52WD6MmvDOoM
	27dw4UTFZC6fgClc1nZhCMBLbqsF9jBjneqXEsVXSl69fEOp3pmnkYN+d0bZBCRP
	fm7fsu/uoJ+0w3dOkzTemmTeZ3FHXfcHIQfFeLe93og==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4at3bh16ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:55:04 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B2Kt3Ve060140
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Dec 2025 15:55:03 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Dec 2025 15:55:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Dec 2025 15:55:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 2 Dec 2025 15:55:02 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B2KslVW020176;
	Tue, 2 Dec 2025 15:54:49 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 0/3] iio: adc: Add AD4134 minimum I/O support
Date: Tue, 2 Dec 2025 17:54:43 -0300
Message-ID: <cover.1764708608.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE2NCBTYWx0ZWRfXwsrr6cAiVTxN
 EtT8kHmBLnWmR+IGkDhSx0YP65GraFBX5t6au+6RJKfPR4sI1odjNcmWwxvU8SB0jH7H+0PiLOG
 l1eIKadN/9sel210xPx0k4fSs7WNFWOqADwoWiEYcCpL9zKsCUZ5Ktkij0GtH0/byNJv0ZQTSbi
 FfD8rpQ3uGYLCPzS1UnwoMxBJQdKpQf7MFXfRv2RlUehP+1Egm7sdhrnk3icbSBKdKWlyjtsmGd
 g+16sj2XReUvvC/ygomJfH5QB4NiF+IcttPinHLhMIbtBt9MYQQkVU+t34JakuTkV5P7FzZTSpd
 xdK8vpFTmLLpEzHmFKzrOsx3+YkYRabSeMGvrtZ6KJ88KYtxWxYR16n932hhJLDpDE9f4KPOjRN
 rywyW8P3t5jAxa/M4h7NBAp1BA9Y3w==
X-Proofpoint-GUID: m0q8elInaE0S1hRMZculvUYoEjwYtMeb
X-Authority-Analysis: v=2.4 cv=aaBsXBot c=1 sm=1 tr=0 ts=692f5228 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=NTgoPMxxATPlW9ezKIwA:9
X-Proofpoint-ORIG-GUID: m0q8elInaE0S1hRMZculvUYoEjwYtMeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020164

This patch series adds basic support for ad4134. AD4134 is a very flexible
device that can be configured in many different ways. This series aims to
support the simplest way of interfacing with AD4134 which is called minimum I/O
mode in data sheet. This is essentially usual SPI with the addition of an ODR
(Output Data Rate) GPIO which functions as conversion start signal in minimum
I/O mode.

This set provides just one feature:
- Single-shot ADC sample read.

[PATCH 1] Device tree documentation for AD4134.
[PATCH 2] IIO Linux driver for AD4134.
[PATCH 3] Initial IIO documentation.

Change log v2 -> v3:
[device tree]
- fixed typo in powerdown-gpios description.
- picked up Conor's review tag. 
[IIO]
- Dropped leftover dev field from struct ad4134_state.
- Inverted if condition and reduced indentation in ad4134_regulator_setup().
- Use (MICRO / MILLI) for microvolt/milivolt conversion.
- Handled clock deferred probe cases.

Link to v2: https://lore.kernel.org/linux-iio/cover.1763478299.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1762777931.git.marcelo.schmitt@analog.com/

With best regards,
Marcelo

Marcelo Schmitt (3):
  dt-bindings: iio: adc: Add AD4134
  iio: adc: Initial support for AD4134
  Docs: iio: Add AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          | 198 +++++++
 Documentation/iio/ad4134.rst                  |  58 ++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4134.c                      | 503 ++++++++++++++++++
 7 files changed, 781 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
 create mode 100644 Documentation/iio/ad4134.rst
 create mode 100644 drivers/iio/adc/ad4134.c


base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
-- 
2.51.0


