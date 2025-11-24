Return-Path: <linux-iio+bounces-26405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36729C7F90D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 725003440CC
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A52F6162;
	Mon, 24 Nov 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XKGMUC/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A42F4A19;
	Mon, 24 Nov 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975940; cv=none; b=tCbhZNHVzumSWJ52BKp9BVdW2hRAzUdJ7YnQoVf+BWaIHUI3xRh8XaV4QV1mCxfZ3LyWcRIQyeH8sJXqK5JQCbU3x1mCqXe/Wc8hZYE/NITI2J+39I+2ma4YQ902QsaQj99EDlcYitn6GQTlRE4JFr69yRuwEmSrKqL/b7Sy2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975940; c=relaxed/simple;
	bh=6qh2wtlLEWTYkrzAloYask7uEYo256fObVki6Akbvps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WHeOINyhk9fu4h2eSq/Pp5xgjXwm2ymfJ5xyXLSTSPV84E7r1IgSnnpN90EmxztoapBMk5HkJ4Z4D1k7VUJ2urOfT/Bng5VVDLB6BAr1fK7AqemC5AECOuimfYUDcTlkvs4XKu61E7UDATXUA9Go0Duztvr3s604qKMHfZWo+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XKGMUC/n; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO56Tp23692335;
	Mon, 24 Nov 2025 04:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rb4+C
	/sHOjHR+5QvjPfrp1a3niXH95FjdwnHPb9038U=; b=XKGMUC/nYU6NIaTU1OQdz
	bR5A25V1NHh+JN+Ig2xOZO01zfOwjRCHBkNdInC8wVZqtfUFrSkQnbQLLDCpVunI
	mJstSM6/eGgiMYYrFaibSofXs7P3U1BNMsO2kdEUH65d7gbHOt8A4FE21i7OuDmX
	eGKVzOtfbhKtvxB42kiMAmcngYF1E3lSxf0o9TRlx7yigJzEwS4GZJv5jJKdzv5d
	2Jie37JNASiG2QXrBLBtKLbCzjxpopZ9SstXHU5IVNCESth9PIbWuoG2cK7f9Z6k
	1ruYiGy6KS/ATQKvgzogsQpKRALKv0j8yNhZxCCRliAVzhZ3l7oXNj8R8pUKcnX4
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4akvcjmw9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IgIe007666
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 24 Nov
 2025 04:18:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:42 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VR024016;
	Mon, 24 Nov 2025 04:18:35 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:07 +0100
Subject: [PATCH v2 8/9] docs: iio: ad4062: Add GPIO Controller support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-8-a375609afbb7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=1505;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=6qh2wtlLEWTYkrzAloYask7uEYo256fObVki6Akbvps=;
 b=0R1fdzzTVNeXidUMkGgMmuPQrTKIaoVQRKy0pErz/L8OTjEXOXt3JjBZjQ5TaxcfhoZYuf7ZQ
 2WWASughyGNCtCxME819nk+enapikVASnU3OcKOLQ7+hh9RcHi/l0mL
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfX8ZZTHgNxXQBz
 Kb0Mm331JuEVaFgEwX4QhU2hSu4DELP2TaeDjTDumxG6V4PVFvkINQG/9wY8dPgW0LEK0z25yMY
 stV9t7oNzxQ245sll/U3Vzw9FOVnr/GW/TwsXkzIQUdY1JW0b1L3ShWZioOsvygujnkIaS/YXl8
 IRNtfJMzQM7En+cD/Jcwbk+CHG3DZrH+9Q0URxxfAs/qRmzh+MQnevhQBQdwGoRHkkYOWmBf+wU
 qEl2cPAUkV6eoUnw/KY8RJ5Es5tapa4GS5u/r7UjFk4DBm72OS/7H80At26+IDCZ6W2BpKucssX
 Spwq9MUnBit7HvqHts2JMdRSeFond5cKWDM+F/BMMAu9ar+ZFJsyqxz5IuZ0zQehdpmRWFSIGyN
 ky42RczDMFyBeYie9bnx0oUXDHzXCw==
X-Authority-Analysis: v=2.4 cv=EqrfbCcA c=1 sm=1 tr=0 ts=692422f3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=EBGExmvx8FPMp0bAM4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -L3FhltvY4gx2BSYETRcc87Et124Lonu
X-Proofpoint-GUID: -L3FhltvY4gx2BSYETRcc87Et124Lonu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

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


