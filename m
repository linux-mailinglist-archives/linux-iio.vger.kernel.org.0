Return-Path: <linux-iio+bounces-27140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B02CC78E1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAC06308FC28
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0C342527;
	Wed, 17 Dec 2025 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="csHaW6Bj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6638933E35D;
	Wed, 17 Dec 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973661; cv=none; b=DmW3g01JgWUBVhczUm4ar6/1UwliJCYApuhSx3lSVVzlWvRQpVqCaoXup0b9e2bUdaNiyRWZeZ6oDKV94imtO5WFZkPHryGbrjgjQ3bIRUSexO3ioSZbU7hIYfzcFFY3h0aFh8KDENlCVVF2r08ipYmSTnFArWiCT4znuGFuEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973661; c=relaxed/simple;
	bh=/w7oOA/B3dH9ls50EHLd2kMvf7DHQF62+nmV4V79E9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q972U+2OJuaEZzvgR8fGTAhbTNeQSZZK11bzIay8r5zIqosC/4lauqm24SGHgQd8iLvIe83OZh5Fy35G3+uIVWf49oJykrntitogpbZLRKiP+XYGdtRJdVQT8/9XqdU40KBBMEPIUAifNz/9d58Y2JP3bo3WoSQtZ5RFtas0Mhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=csHaW6Bj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH9aYqb964276;
	Wed, 17 Dec 2025 07:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VoM28
	YD60AjeHkEDvz/99VVhXnynVtIRpAhzO0y5exw=; b=csHaW6BjOCGHE+Ojt21C+
	n2kxb1ROT2yAT1uWBokKdicua0vMGHt1v27DBmmpIvOGFtJkR2g1c7Qg+ypiZRH0
	dfdQono/Akxm6OMt4zgWtxxsUh320ZCku7ay0Yt+uYl2FUzx/9x9VjALPwHNwlO7
	ALER4NffGlXJ6sGDo97B3M3Dmc0ZmRpi+d65U/+6pkei+JbfABj191oXIlx2pVA6
	GRs1pbAjDOkJOiLMx2MUeU+J6ErYP3nt9VetQL2PtxZGVBYcRJPgX0mng8baMv+I
	ZpoifuKJdPiygKGodJGmpCAsezLaqhnPCOeOWbK98OZu5At0hpuVpkO6N9muJxDn
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jt2thq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:13:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCDtbW041094
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:13:55 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:55 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:13:55 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUvA014815;
	Wed, 17 Dec 2025 07:13:47 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:27 +0100
Subject: [PATCH v4 4/9] docs: iio: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-4-7890a2951a8f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=1228;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=/w7oOA/B3dH9ls50EHLd2kMvf7DHQF62+nmV4V79E9Q=;
 b=OEhJeotjHPWVNgYu1dSZtU4is61Sx88gHvWLYJah+jUIpm2o4q36UxPu1wcyhhOcwyh4j+Jda
 BvNbY4s43HKBjoALeQbuxtUbZtO5uIeaiDaqBM9Fr4FfYuATvvXXpCF
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: G5pfLfbyNduPZfNqf72_IS0femo9dXOt
X-Authority-Analysis: v=2.4 cv=Ct6ys34D c=1 sm=1 tr=0 ts=69429e84 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=pTCSo2s0eJJONGnsYSsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: G5pfLfbyNduPZfNqf72_IS0femo9dXOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX7wfrNohDFFQ1
 5bpUtsoo5jyE0a9B345KaUQKs2HBYyeo8tMyQMctBudGe70mnenPWX607EfC22kmNwmDaNeOrn2
 PiQXb9qjL/sW13Li0gSdosEh+iQcX7RZhIsUxViCXNrFvvMg3+gSkGX6yvdcnblfM01lZ9RovQj
 7gnpFqP6/N7N4es3tnweZXUmlJyJ6zt+4m/ZDVTGeucKOJEJZl1x6UBI17yfCy5LP7fYfyeIC4E
 sZ8qLXGuDdVaGYlN/Qw/e0XdsABIZmbMXaHLovGBuwgk4ULFUhyMju1POkUmoDuWQG2Ofh31x+L
 NkAoqoa1cQHFyvQyMxy4kC/fFgh5jtbC6j75eiJ4Sr+xdWzwA1F9MAS2wV6T5jHk44vCLyrY7VI
 a+1LLsrmBltQqc5EOxuIBC7PWDn1yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170095

Explains the IIO Trigger support and timings involved.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index 30200adf90c38..12ac16dfc3028 100644
--- a/Documentation/iio/ad4062.rst
+++ b/Documentation/iio/ad4062.rst
@@ -84,3 +84,16 @@ Low-power mode
 The device enters low-power mode on idle to save power. Enabling an event puts
 the device out of the low-power since the ADC autonomously samples to assert
 the event condition.
+
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

-- 
2.51.1


