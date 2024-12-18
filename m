Return-Path: <linux-iio+bounces-13614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E99F68AB
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6881883433
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCCC1C5CAA;
	Wed, 18 Dec 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rCZA7kWf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA31BEF60;
	Wed, 18 Dec 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532675; cv=none; b=nGl49Otqtn3rdpPU64vsCHZ8KWLDgUSG7yZDG2B1Y4K3InsZ35YxWvajIEiOZ1DrZA8MpXY5j7aDuSP6e02JzKWxOyfgqNqBW9djf1TzGhcfgev98THu7EkN0kbcnIbXxkJh2lrfpCw4tWui84IxR8IwDQRtgfnZtON5Dnf8IWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532675; c=relaxed/simple;
	bh=SkyQViUioaQ/u7SBq90C/NJ7wfWodFuDFShxs6Bm92k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+3fNagfUkZT8m+1QSMtSOZTnNyt/1eS30bo5gCyiICmhq6L76ft4CTGLBZtgxz2h3RCkgSmcNJFEw5EtplzS1jFexm8Iguw5+lB8UKbkGJli9CPEQTn0+76yb5NcaFfmKhoq93SXezo5UTm/ERcfadw7XCgPTYhI9aWYrtc6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rCZA7kWf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICgBtg005644;
	Wed, 18 Dec 2024 09:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tHU7X
	dwjLErcJWwU0xDzPB1x8UI/aW/hv9mZZcv4OLc=; b=rCZA7kWfR7EAb7T1Buhbk
	hMw6QTS5OmfXhkv7DFOYORYjY6fDYJ6S6E/LtQ1Cf5CO8rxHtro1CbpH8JK9nFay
	e3PEQwqYY0NnfFmRzGS5B2JKU3fGHaxc58usA3g93vsCtA5f0tFaFyePXWNWJ8PD
	sot5GKayqBsOwakOMjujVytBGw+STNjEJbX10QpPAsrX8URp+hqCVTBH+NszG1wP
	Tw+IlongyM5Pikjketyl7v11LTZuQfJR+ZAbHFIexT+xqjJ2knE3/eGEFFpMjrL+
	E9d4vNLIEjpXRMGos3FlURCCI2W/yXwVMwPS1j5iWe2oZRE7/hrihtypeJO0HkPz
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43kxmr0gwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:37:38 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BIEbbS5028652
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Dec 2024 09:37:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 18 Dec
 2024 09:37:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 18 Dec 2024 09:37:37 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BIEbQKG030549;
	Wed, 18 Dec 2024 09:37:29 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ana-Maria Cusco <ana-maria.cusco@analog.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [RFC PATCH 1/4] include: dt-bindings: iio: adc: Add defines for AD4170
Date: Wed, 18 Dec 2024 11:37:26 -0300
Message-ID: <973852b372f8ecf3a62dc7e5b26d75bfaab99a4d.1734530280.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1734530280.git.marcelo.schmitt@analog.com>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 65Lfi6lsnb_RrrIRfkF6B5luoD1zuMns
X-Proofpoint-ORIG-GUID: 65Lfi6lsnb_RrrIRfkF6B5luoD1zuMns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=629 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180114

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

Add defines to improve readability of AD4170 device tree nodes.

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 include/dt-bindings/iio/adc/adi,ad4170.h | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 include/dt-bindings/iio/adc/adi,ad4170.h

diff --git a/include/dt-bindings/iio/adc/adi,ad4170.h b/include/dt-bindings/iio/adc/adi,ad4170.h
new file mode 100644
index 000000000000..a508b37e9a46
--- /dev/null
+++ b/include/dt-bindings/iio/adc/adi,ad4170.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * AD4170 ADC
+ *
+ * Copyright 2024 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef _DT_BINDINGS_IIO_ADC_AD4170_H_
+#define _DT_BINDINGS_IIO_ADC_AD4170_H_
+
+/*
+ * Excitation Current Chopping Control.
+ * Use for adi,chop-iexc
+ */
+#define AD4170_MISC_CHOP_IEXC_OFF	0
+/* Chopping of Iout_A and Iout_B Excitation Currents. */
+#define AD4170_MISC_CHOP_IEXC_AB	1
+/* Chopping of Iout_C and Iout_D Excitation Currents. */
+#define AD4170_MISC_CHOP_IEXC_CD	2
+/* Chopping of Both Pairs of Excitation Currents. */
+#define AD4170_MISC_CHOP_IEXC_ABCD	3
+
+/*
+ * Chopping
+ * Use for adi,chop-adc
+ */
+/* No Chopping. */
+#define AD4170_MISC_CHOP_ADC_OFF		0
+/* Chops Internal Mux. */
+#define AD4170_MISC_CHOP_ADC_MUX		1
+/* Chops AC Excitation Using 4 GPIO Pins. */
+#define AD4170_MISC_CHOP_ADC_ACX_4PIN		2
+/* Chops AC Excitation Using 2 GPIO Pins. */
+#define AD4170_MISC_CHOP_ADC_ACX_2PIN		3
+
+/*
+ * Reference Selection Mode
+ * Use for adi,reference-select
+ */
+#define AD4170_AFE_REFIN_REFIN1		0
+#define AD4170_AFE_REFIN_REFIN2		1
+#define AD4170_AFE_REFIN_REFOUT		2
+#define AD4170_AFE_REFIN_AVDD		3
+
+/*
+ * Definitios for describing channel selections
+ * Use for adi,channel-map
+ */
+#define AD4170_MAP_AIN0			0
+#define AD4170_MAP_AIN1			1
+#define AD4170_MAP_AIN2			2
+#define AD4170_MAP_AIN3			3
+#define AD4170_MAP_AIN4			4
+#define AD4170_MAP_AIN5			5
+#define AD4170_MAP_AIN6			6
+#define AD4170_MAP_AIN7			7
+#define AD4170_MAP_AIN8			8
+#define AD4170_MAP_TEMP_SENSOR_P	17
+#define AD4170_MAP_TEMP_SENSOR_N	17
+#define AD4170_MAP_AVDD_AVSS_P		18
+#define AD4170_MAP_AVDD_AVSS_N		18
+#define AD4170_MAP_IOVDD_DGND_P		19
+#define AD4170_MAP_IOVDD_DGND_N		19
+#define AD4170_MAP_DAC_P		20
+#define AD4170_MAP_DAC_N		20
+#define AD4170_MAP_ALDO			21
+#define AD4170_MAP_DLDO			22
+#define AD4170_MAP_AVSS			23
+#define AD4170_MAP_DGND			24
+#define AD4170_MAP_REFIN1_P		25
+#define AD4170_MAP_REFIN1_N		26
+#define AD4170_MAP_REFIN2_P		27
+#define AD4170_MAP_REFIN2_N		28
+#define AD4170_MAP_REFOUT		29
+
+/*
+ * Definitios for describing excitation current output pin selections
+ * Use for adi,excitation-pin-0/1/2/3
+ */
+#define AD4170_CURRENT_IOUT_AIN0			0
+#define AD4170_CURRENT_IOUT_AIN1			1
+#define AD4170_CURRENT_IOUT_AIN2			2
+#define AD4170_CURRENT_IOUT_AIN3			3
+#define AD4170_CURRENT_IOUT_AIN4			4
+#define AD4170_CURRENT_IOUT_AIN5			5
+#define AD4170_CURRENT_IOUT_AIN6			6
+#define AD4170_CURRENT_IOUT_AIN7			7
+#define AD4170_CURRENT_IOUT_AIN8			8
+#define AD4170_CURRENT_IOUT_GPIO0			17
+#define AD4170_CURRENT_IOUT_GPIO1			18
+#define AD4170_CURRENT_IOUT_GPIO2			19
+#define AD4170_CURRENT_IOUT_GPIO3			20
+
+#endif /* _DT_BINDINGS_IIO_ADC_AD4170_H_ */
-- 
2.45.2


