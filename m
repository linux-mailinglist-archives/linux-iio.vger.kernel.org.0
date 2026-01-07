Return-Path: <linux-iio+bounces-27520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6E2CFE6CD
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B9B93135CC2
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF934BA4E;
	Wed,  7 Jan 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tnt2BUiZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6634B678;
	Wed,  7 Jan 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797269; cv=none; b=UUZs1CTR0QCHQclHWUnZ57qD3XZWdby1ma7k2kiQIpcZ4h4omzqNYBOmo0JJi+ZiAktBPhCh4oH6xEaT52gNOBUh3joNFPTKOxLXSlppbBFeJuW7rgpAGrZ6y1d4Zcrr/dzvlbwiZ1lXmNOc2bcSqfmFlHpwht15dCEfaawLTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797269; c=relaxed/simple;
	bh=w/5nqfLwXQnUvjh6G/vwbhNnQUqrvZz1c09dFvxYP4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QZbh4UgIHA+JzSOdJtVKMlCDDTspSQuDtCjgrMKmX7fMIOSACaYf1/RgdhDv/KkjnkhIO2/T8vTkPar4Gvhy3E+dNRUPLwt6FNK7mwMOVEvS1pHCo9bu80zXqSSicuf3lCM2Br3fINb9BO/1qCah6WMMBa8uzHQppsVfpXWXzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tnt2BUiZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607ETo2q3431458;
	Wed, 7 Jan 2026 09:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=hyN7AL59FBoyA6SQhM0g1JiHErP
	7t5jRsUw3eG4zGoM=; b=tnt2BUiZEB6rE1R404TUsbvIUlKnDb0LlbQOUGLxJJ8
	v2PkfDh3DbJVC3iT84Ol+B7k4yPste2nAw0ol/n6Ul+ExsonnZBAgLfxkuOwIaAM
	dPo2e7r/hR+2000qa/RWEJUbuHi4r0Fyp3oIPChfCVrOtMBBkTpM/X0DmcR81B3T
	P90AmSS6ArwEcwJkHVycqZyrjsy25oVqmIl3pfJcdU+DHg32nrUC19CCMe5eEg9o
	o4XGIlQ3SNmOlHg2e4QQ+E8k8soG6bVm0l30EJJ6EhIyeOioNCuoI9o9Zwb1svCS
	0tA9I/saYk3p/u4i6e4AJBQPOFbaM/VfcPG6A/Lqw1g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bhgcgk1cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 09:47:36 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 607ElZGO065355
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Jan 2026 09:47:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 7 Jan
 2026 09:47:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 7 Jan 2026 09:47:34 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 607ElHFv004187;
	Wed, 7 Jan 2026 09:47:19 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <tomas.melin@vaisala.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 0/2] iio: adc: Add AD4134 minimum I/O support
Date: Wed, 7 Jan 2026 11:47:14 -0300
Message-ID: <cover.1767795849.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDExNCBTYWx0ZWRfXy4auZKU4QqkS
 iVBkoLhNBcMfXaFimEbEAv+DYyUhHgOc9gqBslv+P1XOQQ/kGdWZ83+OytOfpH2nMG4l7HcIzLI
 5pM2dbEX9W0oaW4t01rHj5YUTICyUGeUXh6eK4LfUib8WOowdhthhwhk1Zgj9OKkOOdmCuyUHfm
 sTL0RsL495AdnHsauvptmA21cHOasPA0kJkyyAXI+x0whb/70+C8sX9iFH8goJamX5wbfe0/x9F
 DcXu7heoFeTK2OL5vWhoXvVVtmlpt8qmaCLb4vgM5V5joIsScxW+KLVueNb+RCeGtYFKE/vj1HV
 Ptu6TH0nne4/0TOuIOOJSc/W39SvfOC5XB1g2ELjvHkK+Or+Ot567UFbGj+b7i24GPaqvbtpvDt
 HH3B2oY5zxSQ02jGEgc3dWcWecGilrfE85VrIoDLEk7hu2f5V7ZtvgZmmvaj6Kgu6MhDe6SweGP
 qAOF4zo5Y+dvx7Lu2GA==
X-Proofpoint-ORIG-GUID: Qmo0M1XiDmauYGg1kda06XMHcj9DYDQn
X-Authority-Analysis: v=2.4 cv=VsYuwu2n c=1 sm=1 tr=0 ts=695e7208 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=XzlQ4CuMUiEqox3nm_8A:9
X-Proofpoint-GUID: Qmo0M1XiDmauYGg1kda06XMHcj9DYDQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070114

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

Change log v3 -> v4:
[device tree]
- Renamed clock option "xtal1-xtal2" to "xtal" (making it similar to other bindings).
- Use oneOf for ldoin-supply choice.
- Dropped properties set to their defaults from the example.
[IIO]
- Added comment about minimum ODR high time.
- Split array of regulator names
- Updated to check for "xtal" clock name.
- Simplified voltage regulator initialization logic.
- Use reset framework to get and deassert device reset.
- Dropped ad4134 IIO documentation.

Link to v3: https://lore.kernel.org/linux-iio/cover.1764708608.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1763478299.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1762777931.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (2):
  dt-bindings: iio: adc: Add AD4134
  iio: adc: Initial support for AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          | 191 +++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4134.c                      | 501 ++++++++++++++++++
 5 files changed, 712 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
 create mode 100644 drivers/iio/adc/ad4134.c


base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
-- 
2.51.0


