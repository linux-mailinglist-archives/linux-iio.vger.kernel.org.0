Return-Path: <linux-iio+bounces-26404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0EDC7F90A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 424DA4E5A96
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6982F60A3;
	Mon, 24 Nov 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lPqxYHS7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5A246335;
	Mon, 24 Nov 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975940; cv=none; b=SaiTTT8jWlF/4TtJmMCQpg3HNAijdsShD2zRNiBA6oi3p/Icifg2IiNS+XQHEOr9NUrcQZqV1PAvO+SJq7HpFdPDqDG/ItiJKciP7C2rUl82YHBZ5T8w3tDLjo+AzqgjDYmX4QDS6n/9A50Yr2UeVbk5XOueGHNs2WTaqTCOR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975940; c=relaxed/simple;
	bh=k24J9SVSpBNTE0t7Rk8CGprxFuIseSx9ccE+WbjYn5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RdW02majGMDgPorCJ2i6n5cpWEBnmh+yjOfqMM77bhz8BlrZrzX/if4PiuU1kfCtEbVobCr/L7P2Rez9DG+LTPPCr/JM9cCeay9AkLBVsgkXvBtQ3/iVLjkYldcRN0gWsM4DELNJggRnECdVTAptkjMF80rSKhKxI5oecVxN9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lPqxYHS7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO5529b1958717;
	Mon, 24 Nov 2025 04:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LcuBF
	z0e1njXZW4JimsU1D5rhEqnojcDga+gDFRgqmA=; b=lPqxYHS7sDviL12QI4ZhD
	rBiYgllMp+wACtE9e8CCKFx05+PnbSZaOXtkaul1ItCM4T82kLbR6FJtvVmqaz9N
	kp5PhzZLz0V29vpRYRbcEZacC5LRWK0ATCZyp6nUyjGDtrPVZ6xyC+qmMUIEYK7u
	AIBlu3mIUWFOy/flWORhADDM8huQe+fMmKkA6vqRBgwHXgourlx8GrX0L3Neqk1E
	xwYaUsA+J/AonU6J3KmT7jcqCWE0NTZnM2RpGBtljHkmSk88m9t38hkQ4pg0PT5e
	EwM6EQVYX59MIWMlMrIurLJ9nmHn4X1UYqNvDoNRgZ/8t26wfwTzRgLfXKQgFeBy
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4akay688ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:34 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IXaI050917
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 24 Nov
 2025 04:18:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:33 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VN024016;
	Mon, 24 Nov 2025 04:18:25 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:03 +0100
Subject: [PATCH v2 4/9] docs: iio: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-4-a375609afbb7@analog.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
In-Reply-To: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=1267;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=k24J9SVSpBNTE0t7Rk8CGprxFuIseSx9ccE+WbjYn5c=;
 b=IDMnU3cR86/zfAqCJ1c5MFBmbGRKk2a/cXJBcVAm1YiLuB12QmklExod60gxgKpWxffLB9SHy
 Jb5aVq+9uaCAFka8s/B9KvuT/YS+T01nSa8twd9XIc6WhkF4lKiZphC
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 26VU68WNwjcoHsTbwaT_MfR8YZO6n4i3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfX5AbTjT4GITZz
 qW5XyFFiymJ1LVT/W0OlpRNHuwDWMF8I+fjRzDQ98hikVxQYdKpWYLCNFEyc4QkZ6PoAUazzmdh
 tufPNESCGlnF6kwJVnbtm/Nn0KFCXavVLLxeHT6APr+2CcpNFNEZo734O+X+CsB+/kOmuINsYjM
 9aV7pm3103NAjfdNmy/foasIDMvbFJqdJgNX13+Y1ZoXINNuPvGXRIbNG6RqNvq4x/jggg5h6BQ
 bcO5TTl/7L9pDDvD44gwhMATbtGyLvyYiyzfI1UA9d7Rr97nFKv8ro0WwkmppfiHcF6H+JMEPku
 osKYeZ11sczD4hgPXUHufLwI9GvMIURduT5oQsZOnZTkkt014yRQOSYLDusaL1rZaB3oszp88ex
 v5Szqptg6DomeERuoFlK6mec8DRmBg==
X-Authority-Analysis: v=2.4 cv=f8lFxeyM c=1 sm=1 tr=0 ts=692422ea cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=pTCSo2s0eJJONGnsYSsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 26VU68WNwjcoHsTbwaT_MfR8YZO6n4i3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

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


