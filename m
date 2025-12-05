Return-Path: <linux-iio+bounces-26804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA39CA81FA
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E103046F15
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9834F265;
	Fri,  5 Dec 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cmV9TXxu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B03164D4;
	Fri,  5 Dec 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947592; cv=none; b=qpmD9ql2DAeh5NE9ka/HFIROVY8JDHaq66H3ca0tBISgx1tYhqknr5C2HD/MLa2a8QZagUuhYM7QtXKV8sc+byfS2y22xzZzoVCzmu5u+TiIDdBHH2Q7kQwPL/bxehdkFnrr3+uWIvYInI6laji2g9yt8i+5eGlKRJDAo57K6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947592; c=relaxed/simple;
	bh=k24J9SVSpBNTE0t7Rk8CGprxFuIseSx9ccE+WbjYn5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PB0+KorHJ5X76aQFA3cR02XwbMx7slinTTtdWZDArdB0cvMQrDbm47FD5+MmdJ9PFxAoR/iZz+Uid8RfUgvKmhZz18QWJXap5+DD8cSAq9q/2iEJ0o8w23B29G5UDVG1iY5XBhoFekFls7IBuzm1r1k9LGYS6oC0nH0mnzJ6syQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cmV9TXxu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5CU8sR3489325;
	Fri, 5 Dec 2025 10:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LcuBF
	z0e1njXZW4JimsU1D5rhEqnojcDga+gDFRgqmA=; b=cmV9TXxuuzaO27Fk2qS9z
	n3I4sRNzXKLxdwU19p1lIGvFDUBgRwJbWMs53cKLKsVQUGFPnCMN622l45fYSlOI
	AH1EOHYEyBz9ifwtw+l83i/yIc4kaj0L0+4qBFNWXub4mojFT8xJnbu4vSDDe149
	Mwkfdc0XltG1j9EQEJgW/i0IYppW5rr2R1YuQCBO+yEahrD8cRpg4KV+opE6wc+2
	OROSYxQgogtAV0MXpPrZYcREip7MXTg6KiiC9g9b0HWFE/R0sJ7oO8gWj6M4jB4s
	ngZWsqHaJVzbuFSpGoiwbPfgJhNxmdeuzga4E9nPyNGQEpus20cPOtRKOZOxKMbG
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4auhvuv2hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:41 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCct8033551
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:38 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 10:12:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:38 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SE029946;
	Fri, 5 Dec 2025 10:12:29 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 5 Dec 2025 16:12:05 +0100
Subject: [PATCH v3 4/9] docs: iio: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-staging-ad4062-v3-4-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
In-Reply-To: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=1267;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=k24J9SVSpBNTE0t7Rk8CGprxFuIseSx9ccE+WbjYn5c=;
 b=ZufQ4g8T0W2WQJ1cSLD/OAJN8gN04X9FP3hHYipfJK1Sdy7K4otjLqxcHlM5n/MjVa6BymjWz
 0ponVMzrFzwDSX5+WO+abMHimsLlA+CRWG89Fe4qSBjREKPDKg2/IhT
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwOSBTYWx0ZWRfXwNlsDFmXgKkD
 yEPMGBHG0lrtVgWU7wdUiGbTGO7pxiZ4VaVy0gIsMsD/KfWehkUrlqnyxWCfvL+Iyq9uZMBmMDH
 z35kiPvaX/UEYlpzeze+135qdSbKUtL9tLSlDvj1VCbK2i2wJ3RuTlvW9MNFEH1ab/eVXT8Lp/s
 RXE70xVDK30PfBqKp+sGMl4HRBIO1HBIVDXVTD9vgEgyfeX4Wc9OPXMqnXHU6M+bbRwTOL5R10o
 6kLTJW6EFF4ccEW8U7PICat5Uhzr93cKqPscjkhncK+rbKE00s/IpMj0TqhNMnZOqILsTBzH5ME
 A6rTnLx/cBl0lVtWXaA2F7y/X/S4IsFqCMN8BtR50/FQuEOMbobC4w0X+23xiEJd9gUzr0HeVYf
 1+vgMgCX9znu5QH/kJa5X83O04LUIA==
X-Authority-Analysis: v=2.4 cv=Q+nfIo2a c=1 sm=1 tr=0 ts=6932f669 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=pTCSo2s0eJJONGnsYSsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lYlMoNKm0JAhbtTlBbq7zmvfcPg_X7r6
X-Proofpoint-GUID: lYlMoNKm0JAhbtTlBbq7zmvfcPg_X7r6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050109

Explains the IIO Trigger support and timings involved.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index e6bcca2bef24b..9dda4eb782a02 100644
--- a/Documentation/iio/ad4062.rst
+++ b/Documentation/iio/ad4062.rst
@@ -85,6 +85,19 @@ The device enters low-power mode on idle to save power. Enabling an event puts
 the device out of the low-power since the ADC autonomously samples to assert
 the event condition.
 
+IIO trigger support
+===================
+
+An IIO trigger ``ad4062-devX`` is registered by the driver to be used by the
+same device, to capture samples to a software buffer. It is required to attach
+the trigger to the device by setting the ``current_trigger`` before enabling
+and reading the buffer.
+
+The acquisition is sequential and bounded by the protocol timings, software
+latency and internal timings, the sample rate is not configurable. The burst
+averaging mode does impact the effective sample rate, since it increases the
+internal timing to output a single sample.
+
 Unimplemented features
 ======================
 

-- 
2.51.1


