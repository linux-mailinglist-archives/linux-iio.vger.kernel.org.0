Return-Path: <linux-iio+bounces-27143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C5CC787F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A63D13008487
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B73446A8;
	Wed, 17 Dec 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x75ZIWV9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBC342CB0;
	Wed, 17 Dec 2025 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973664; cv=none; b=Zi3wFjndLRCAWd/w7SdWOD3lGnroBZATCx//yXplJv2yGoUfoUCfKP3trw8B6cYt9L1ej6cs8Oti19FnDb3swToifpxa1M3Fcyt4IpECrtqTJ8vW04KlFG+7O5qmHJuqWxf0ZLeg6gpkm59W38xfX73UGilukYMCC2Y2yMIK1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973664; c=relaxed/simple;
	bh=fyI5mimULp3XgcPi56o1DTpa5TxXCpPMzp3xNKiC0zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RIhjT21v+ZSywq9zzEyfZrx+UArK5dd2SZKnhMJpyJqjgSUK8WO2OEZXqhOGxshE5d1vgKk+/gVNTWehFhII904dREM+ns+8l3DCUJXxTsP+OWWBSZyZeBVYq7TyEA5X7fDTTNEL1elKK4t5s9ZDrI1FQoOHGtHjo9eGWvn8fbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x75ZIWV9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH8SXrn3979344;
	Wed, 17 Dec 2025 07:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JbhBG
	99E83UqESzQ32vc9RiIs22UMws2gIJLz89/fyI=; b=x75ZIWV9kOBU4wBxvPfgt
	HvKvmP7Cls/78gIq2aVQaR0V3lJwt8mDUTYH16yzy6MbXAU8WhkXc8I4JK/JqWbq
	Ka9mbJHdJxPlZ9S9KdrFhonjZoTCtFSugSXIvOUtzag5/D34oPQmik1xNCNwOAnV
	Jld3EqgEdYwR8UKiXXt68L0jPmqtYcS/xUvWB9VQS4iSi6bQB3LI4SOYFOVgnVTX
	7Y/BBAPZQKUelrELhG/PhX5SNdZDZUtajxgj7yQJOqeb0CY/iAhPFm+s9VeIVzEP
	4SJIE5k2g16EcUPsLSJJ33gztx+RDw505QIcXMnec2NhyMvKXabbXCFkyeDTPmUn
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b3bbevk6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:14:00 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCDxTO041108
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:13:59 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:59 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:13:59 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUvC014815;
	Wed, 17 Dec 2025 07:13:51 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:29 +0100
Subject: [PATCH v4 6/9] docs: iio: ad4062: Add IIO Events support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-6-7890a2951a8f@analog.com>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
In-Reply-To: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=2816;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=fyI5mimULp3XgcPi56o1DTpa5TxXCpPMzp3xNKiC0zI=;
 b=n+fFm/A4fzfxg4GCV0+SoIdOmW9cqpy+xvpYG2kImHbQV9ZVfISofSc+NuISFYxQnu/rb+Uz6
 HC9DFqkLAFgDOULJyLqpJ2x+WkphOz9gK6EQU66EpBdBK1ASaRLCd+r
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LYtmni-30NM7F9igFN9ubYRqSV7ir1yO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX3a9SgOE/J12a
 Q5lY4BKuxfhu1mmXxgJOkzz5jtTIUNmGIIc/xkzf2Gd/zM3Au/w+dz3xA67zzpj3zGlG/bG3EoA
 O0Zr2RvfbXR5WlnszbWx5qXBKFr0dsd00bd1k6Zl1uVmLhEeWfsAcQTdMcP/Okf0fRyj262NKcA
 dxVW8LQYhqgmX2hHKdXkgIf+pm3b/JVZ+feB+d/jshz5ws47l48Qh1wAy/6XfpEwN5AmLqk4oAD
 l0p4+pcaLFjb+LLYCbiJGxsxzHdN6bSZOZg1WBBmjIsYp3O960GgFtk+47cgZgaDajfPNXezC4j
 9NiZs3QAuWRwDsAAjskuDr29sTTm+v48FOvljLsrYqw/CE0xOWIEya8aJVDI9SdsQ7lm+8wAK3l
 MU10iuLTBCZ8cedbdMGVR8HNuVhQIw==
X-Authority-Analysis: v=2.4 cv=YqsChoYX c=1 sm=1 tr=0 ts=69429e88 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=RvCAy4sPJie4B97SFe0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LYtmni-30NM7F9igFN9ubYRqSV7ir1yO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170095

Explains the IIO Events support.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index 12ac16dfc3028..8d388f9e2f450 100644
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
@@ -97,3 +100,37 @@ The acquisition is sequential and bounded by the protocol timings, software
 latency and internal timings, the sample rate is not configurable. The burst
 averaging mode does impact the effective sample rate, since it increases the
 internal timing to output a single sample.
+
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

-- 
2.51.1


