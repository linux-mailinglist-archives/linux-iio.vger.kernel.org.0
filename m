Return-Path: <linux-iio+bounces-26407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505EC7F91F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1376348995
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB82F693B;
	Mon, 24 Nov 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zIXr4Sq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F402F5465;
	Mon, 24 Nov 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975941; cv=none; b=YbOf4C/9n8oGJSQ37NLJP4NB+RV0ayn+IihFCOs8qsoIRN5uaRnTa/8WA9ioaq4g34Ui4udQ5Pp1blsdLkmMh4rG7JqNNxh3s8O3baB1Wvizwty9UC3y9UVrMMoxPuuX83W+X6zXWU59+BvttBIyGEW1khOk2i1y/QZpsAkqt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975941; c=relaxed/simple;
	bh=xHwoyhIzRbWGKDaTyQIddc8KJjvj2Dfsz8ghN0EKd3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YETlvOokNuqMf4pQUEM1tgHTVaws1WDbp2t1Tho0tGEX2z5R7xHrUzgO+tvolsg25hru1yPqFnhEIpZs4TKhp0zeYRvrhDXSb2pX5JjXm34W4OjEEt1hS1Qyvn9UDUlnOf+qhk6dO2nH12GUBP27IItCs6Adr8r9913+mp2aHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zIXr4Sq3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO688IZ1957860;
	Mon, 24 Nov 2025 04:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d3+FV
	rAESf8tt7WOmc9s2QHGzplfw/21aGU9TQs1uN0=; b=zIXr4Sq3lYlCvC9pd3OFU
	bGJUhigBZ0wxbwAG7pj2R+j+Yb2LwnSUe+6NnJT4nXHU3X+WUQNe9tPOaLdcOFlV
	qCe2xrJg4O34cP1iH3bchgbHbUvUx3nWoXpWueStWITd+7OLZePTW0meQet5PkSo
	CldUz7HDUo7ft00QVJdMsiKz6lhmctY+cdG24G/i158IBjfEJ/eli7kPRCCIDc65
	1XRmeougb0lcg20kPy0pHvZgd07ECqOjsOcQFlA2AAwvs6m+Hy0/EUFaMyxQ9zb6
	umTn/LbjoCsPEFE3kyyD8LX7W9ceKwvrtRaW8PCk5r05GzVZr+3gQ03dAF4HbdhY
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4akay688f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IaYf050939
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:36 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:36 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VP024016;
	Mon, 24 Nov 2025 04:18:31 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:05 +0100
Subject: [PATCH v2 6/9] docs: iio: ad4062: Add IIO Events support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-6-a375609afbb7@analog.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
In-Reply-To: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=2876;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=xHwoyhIzRbWGKDaTyQIddc8KJjvj2Dfsz8ghN0EKd3k=;
 b=BRQz6KOhJlRC4wO3ADCoSCSammX/JuS1nijkafIwLwTLat2RLID51lPWRISl8aG7DkgCo8FEb
 keQ+1CR8ErRDFE+LpIMWguRy2NnsKAYbTCoG6foJ8Tii2rXZemxQr4m
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: x2jNNsDkv2P-nAtRyaOJkEX7Iapu9HIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfX2wl3SitevzYa
 NdKlEXZTwUmxzXacml7hmRVLxWtR+Z7XNXrEssx1jKgy5GqPKtXcwFkZ/ustQIiv4XT0MX3yCY8
 BSKdk2uwWvMaz2rwD9YGujk+PQDsqwYu7fqc6I5+QBRrzwSIPkmOYiTBFxWwhrCHOH3ji7Yo5Zc
 EIgU0Fxwb3xFMGeL8qKeaYP881Qr366o2Il7RtTMuCM31eAEACP/1EK3xcQtf1wW/3L+vjiQ3Vd
 mccs/covWqZI70spcVsgYvnU72wWkMB5l80T4J3VujhAdp0IKl5MnWXDqDxH49F2ip4EpJ2b65z
 G6cJuDLYP0OVFsusf6DJHFKv6faNktmhMnOFvqPLA+onlbvO+cDk170Z2iIq9m5a8EmXrpllK/P
 IYCep7F48bIVyN6w6USM3VD8irvWzQ==
X-Authority-Analysis: v=2.4 cv=f8lFxeyM c=1 sm=1 tr=0 ts=692422ed cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=RvCAy4sPJie4B97SFe0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x2jNNsDkv2P-nAtRyaOJkEX7Iapu9HIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

Explains the IIO Events support.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index 9dda4eb782a02..5afec4d8c2ddb 100644
--- a/Documentation/iio/ad4062.rst
+++ b/Documentation/iio/ad4062.rst
@@ -26,6 +26,7 @@ at the end of the read command.
 The two programmable GPIOS are optional and have a role assigned if present in
 the devicetree ``interrupt-names`` property:
 
+- GP0: Is assigned the role of Threshold Either signal.
 - GP1: Is assigned the role of Data Ready signal.
 
 Device attributes
@@ -74,8 +75,10 @@ Interrupts
 The interrupts are mapped through the ``interrupt-names`` and ``interrupts``
 properties.
 
-The ``interrupt-names`` ``gp1`` entry sets the role of Data Ready signal.
-If it is not present, the driver fallback to enabling the same role as an
+The ``interrupt-names`` ``gp0`` entry sets the role of Threshold signal, and
+entry ``gp1`` the role of Data Ready signal.
+
+If each is not present, the driver fallback to enabling the same role as an
 I3C IBI.
 
 Low-power mode
@@ -98,10 +101,43 @@ latency and internal timings, the sample rate is not configurable. The burst
 averaging mode does impact the effective sample rate, since it increases the
 internal timing to output a single sample.
 
+Threshold events
+================
+
+The ADC supports a monitoring mode to raise threshold events. The driver
+supports a single interrupt for both rising and falling readings.
+
+The feature is enabled/disabled by setting ``thresh_either_en``. During monitor
+mode, the device continuously operates in autonomous mode. Any register access
+puts the device back in configuration mode, due to this, any access disables
+monitor mode.
+
+The following event attributes are available:
+
+.. list-table:: Event attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``sampling_frequency``
+     - Frequency used in the monitoring mode, sets the device internal sample
+       rate when the mode is activated.
+   * - ``sampling_frequency_available``
+     - List of available sample rates.
+   * - ``thresh_either_en``
+     - Enable monitoring mode.
+   * - ``thresh_falling_hysteresis``
+     - Set the hysteresis value for the minimum threshold.
+   * - ``thresh_falling_value``
+     - Set the minimum threshold value.
+   * - ``thresh_rising_hysteresis``
+     - Set the hysteresis value for the maximum threshold.
+   * - ``thresh_rising_value``
+     - Set the maximum threshold value.
+
 Unimplemented features
 ======================
 
-- Monitor mode
 - Trigger mode
 - Averaging mode
 - General purpose output

-- 
2.51.1


