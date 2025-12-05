Return-Path: <linux-iio+bounces-26805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F301CA821E
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58F8F304A7F9
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BE350A05;
	Fri,  5 Dec 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hIhvjHil"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AC34EEF5;
	Fri,  5 Dec 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947595; cv=none; b=GR9IjkyjpJhruNoGOtG0Fr4bTbhNmz1vKCY1uJ/yRuJajcxTL7tyv+9f74UPhxO8wwViiiFNsZ9SfzW0gExTj6pzbi4ZUkz/ZeyGLlA+Pl6+N7eVvXgq3Yio/fr0ogBmSOpQLbT46sIDj6QZKraeHNdBXtBzZ5jiM8qqPY0NfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947595; c=relaxed/simple;
	bh=xHwoyhIzRbWGKDaTyQIddc8KJjvj2Dfsz8ghN0EKd3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=k5OG4mjEGCfnRag8CAt8pAx8VLi/eac8gklEcN/KbGviqX/91IZugNTudAYHVGYJzo+SUKjs8Cp56tfPDkOOb2ZAVQZZfKdKhbfdhNJ/PgedNtHIL6l4j7zxcm2bC1st3y56CFP6fimDoTZuZejYYL0J5YL+jG/5fHHaSa09cZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hIhvjHil; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5Em6os172709;
	Fri, 5 Dec 2025 10:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d3+FV
	rAESf8tt7WOmc9s2QHGzplfw/21aGU9TQs1uN0=; b=hIhvjHil2aanzgFnmfbTu
	cs2BiLC8J+F/VnrTuJ4LVkenlGWP2oBeB2c7j/G9bZVwp4lNPwRef/VnUWBhJuS1
	l3hza5UdyKK2ORKsS6yZrx1AmcZtsjCSL7/hBoO6upRruYp1UQv4Dghc/StryXVi
	gHmVSZv4C3KXD3qvEFiyfLWoQEj3GdEaOxghSz1ePNaDYMw5SWvQYlOm33XnB7fi
	mtU6mJL5yb0HM9NJ7SQM8N88PURCIi70NLHfDnltX27LoKEv3iYtpKjlyn/BVVxv
	LSp5CKPHseA89J1tvgysiiUXCgHd+bssJw7tP14hmXzKEuNNOj+gujNGOYlcU6oE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aufyscn5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:43 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCgfZ033557
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 10:12:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:41 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SG029946;
	Fri, 5 Dec 2025 10:12:35 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 5 Dec 2025 16:12:07 +0100
Subject: [PATCH v3 6/9] docs: iio: ad4062: Add IIO Events support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-staging-ad4062-v3-6-8761355f9c66@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=2876;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=xHwoyhIzRbWGKDaTyQIddc8KJjvj2Dfsz8ghN0EKd3k=;
 b=2zlmAASSNDc7k4ubmRDIt6rOomsX2ii4K+I3GHWgJQUVvYNjBuFxj7dWbT+n5Cf/L7o87abdG
 YLKVeIijyodD2KXIhNQ0nbA2hBsDVl8KPgtTMjeFu78/7PDmJ0sYvLv
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G4cR0tk5 c=1 sm=1 tr=0 ts=6932f66b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=RvCAy4sPJie4B97SFe0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HO-SssIcK15iLE6io-NqwH2DNp-MkUQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwOSBTYWx0ZWRfX8yR0zmG5ESFc
 K2EWxxRn2fo1pywih2gv2GeqcteU8eUh2xUqp1e5KP0kGrxrEVWYBdenlz9oNVboaVS/U4Ky9VV
 nD9he9G/vt8vYocy9B19ockKElJY397p2fxOtg2bZWCZHsNRq1Ovzt1KhER3pPqzuLTtQrtR5/3
 1XTpjOajzeWoAy770yZxvMIVqeJlAtq4noWbD4v9CqOiy91G8YIlSpJwzQv4ljZClNU+KVvG6bf
 FzG5ljr+ypNs2C1aFp3qq2w3I1Vfh6d56okvu2rZvkO7EHKHkAUj9KgFUVYY/s8R83wOcojurbU
 9A8eFuVSO3sP33+LApS8iT06Zy2sZZQfuU/y3r/Q/jRDdPU6D+iRK+/rcEVQnrwxvFDdFYduO3h
 2EGZiebcaRmVK+A95TDm0yyDrRCZ8A==
X-Proofpoint-ORIG-GUID: HO-SssIcK15iLE6io-NqwH2DNp-MkUQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050109

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


