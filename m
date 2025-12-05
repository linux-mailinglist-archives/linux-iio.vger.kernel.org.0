Return-Path: <linux-iio+bounces-26806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B7CA832A
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C16C83059885
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B130AD02;
	Fri,  5 Dec 2025 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hv8vpnVq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1FC329C40;
	Fri,  5 Dec 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947597; cv=none; b=uRW8HrQAr7gZ9vNLx0R3BWpklr21KPycGzPn6R37TG/NaK9AuH4ggGdwyV5g0lXB9UKBE8HrB2vn2+8hp8Cg1Q9Nth/ZxGBiz5UOtIXq3xzYoe6gIgPw4JQmPy+9KJs8TmyOxSwAuFfG3UqJTV2RufpnqPc1I+sOdUnSOfaoMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947597; c=relaxed/simple;
	bh=6qh2wtlLEWTYkrzAloYask7uEYo256fObVki6Akbvps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cbw+S7HZOroIFacd8Rq6Sxx5Nk0dXAv4XpWG/qqzarC1k1+zWDi7wVD8q3ZtGmnyniKkUZKBl49u2tHq/jOOlluPGvfZjPpt2jW65ZZk5gJDU1LZU3jCq5mYJyDpiYElYlezMb+kPy10GuwcXmFipdCf7vkm7/m9/Pi/73ea6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hv8vpnVq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5EoKHk172734;
	Fri, 5 Dec 2025 10:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rb4+C
	/sHOjHR+5QvjPfrp1a3niXH95FjdwnHPb9038U=; b=hv8vpnVq2n4NCaYzwJTok
	6dWq4H6zCGNo+H+H5NMaapkjI1wolnVnebptN7778hpS1sALHKOfjkkh2dYzG3dA
	Z0ejVNYBhMMIMGzDttvkOkZ60IzF8vubT32Z2auCEmIlf9J3ZQt4tkjk/3aOXpnw
	EOkz2W9A1cXGYTnDbn5hD3EaM/nbN+PolWTHL4Y/JsLbU2/bmIrPFHFS+a3Xnt1s
	uvEfgtgJ3e2ufApMI2A3Z9oIjODBgK0jxDrrvKPyoDA4ofgCKn4+bR6St/T/j0K7
	9sol6yPw2XsZAU1ibfH5vitG/3oijlUTjSybsAdJlWcqptJlLVgoZMzGaIeU+/1s
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aufyscn6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:50 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCnFP033570
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:49 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 10:12:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:49 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SI029946;
	Fri, 5 Dec 2025 10:12:40 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 5 Dec 2025 16:12:09 +0100
Subject: [PATCH v3 8/9] docs: iio: ad4062: Add GPIO Controller support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-staging-ad4062-v3-8-8761355f9c66@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=1505;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=6qh2wtlLEWTYkrzAloYask7uEYo256fObVki6Akbvps=;
 b=VkaCxQ7cu7eXPTeFdmfJF3lXadw3nH2u3hy2nc+U2YyHrgyEPlVckDJimcaYI8/ap42VoRKPl
 qQDhudY8TMxB8HzK16ymZ3qJt1vbodKMDUFRPgaprjgXcoOUfDIpnVl
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G4cR0tk5 c=1 sm=1 tr=0 ts=6932f672 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=EBGExmvx8FPMp0bAM4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Un8c-NCCPKv4fWiIpmt6iuiEz9WBNZK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDExMCBTYWx0ZWRfX9RNQCy61M//U
 S8ymKPfXS13QkhqWvS0dV3SQ8vLViN9aDdo4tqlD19PxHF6k+Zyd2+dIzmekCzaGFHIwO4N4P1X
 Hmf1JEv6tP8+4fw3Tj+GImrUerRMwUAnrBRBwdIzleKIqYqrcUp+8XjOPzSzZ9J91i8EQWFmRV7
 b5zgETWdYrOEGzQYo+ZOsBYvGo2aUnCo8c4ZohZSR4YTwMF1UFKRsCSpjwMeKNac1UXSjA4TO7K
 rl58mkUulmdEYCtNcV3R+i/HElQ2PrkWgIsjqoVdm5TTbRkrQyM6YEK96dvzhMWrEUt0p0uwqoQ
 iaHqpoUMjX4Nriu69TJ2WT4CPh7OSAd2c6inpw4cjd+BedNMXTpFIzlVPZsP4zx5yx7p80pprEl
 Ky+asBhd01wdnKylD5En1bpfZTGrLQ==
X-Proofpoint-ORIG-GUID: Un8c-NCCPKv4fWiIpmt6iuiEz9WBNZK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050110

Explains the GPIO controller support with emphasis on the mask
depending on which GPs are exposed.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index 5afec4d8c2ddb..78665755ebebc 100644
--- a/Documentation/iio/ad4062.rst
+++ b/Documentation/iio/ad4062.rst
@@ -29,6 +29,9 @@ the devicetree ``interrupt-names`` property:
 - GP0: Is assigned the role of Threshold Either signal.
 - GP1: Is assigned the role of Data Ready signal.
 
+If the property ``gpio-controller`` is present in the devicetree, then the GPO
+not present in the ``interrupt-names`` is exposed as a GPO.
+
 Device attributes
 =================
 
@@ -135,9 +138,17 @@ The following event attributes are available:
    * - ``thresh_rising_value``
      - Set the maximum threshold value.
 
+GPO controller support
+======================
+
+The device supports using GP0 and GP1 as GPOs. If the devicetree contains the
+node ``gpio-controller```, the device is marked as a GPIO controller and the
+GPs not listed in ``interrupt-names`` are exposed as a GPO. The GPIO index
+matches the pin name, so if GP0 is not exposed but GP1 is, index 0 is masked
+out and only index 1 can be set.
+
 Unimplemented features
 ======================
 
 - Trigger mode
 - Averaging mode
-- General purpose output

-- 
2.51.1


