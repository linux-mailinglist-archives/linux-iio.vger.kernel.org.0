Return-Path: <linux-iio+bounces-26653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E0C9CFB4
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 21:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C7D4E5201
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5F2F746C;
	Tue,  2 Dec 2025 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Jl5f6yBL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F72F745C;
	Tue,  2 Dec 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708960; cv=none; b=AkpA38F75hJV7noFpGCN5lcGlI5Tre8U2b0fD60ib4I3W0Kp9bInaRiJBnG6bJ10Aj1FVjH5fy21Da8o6VGyxIccvsgJl9ntizSurtojTWL9H5yUkngs7x0Q5U8+oZzMtYRInzILu5hLbG3NYXo6Q5DuLVXldca34V7ZLPPN/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708960; c=relaxed/simple;
	bh=UHsT6ieCOUsgotlbuaIbUrEMYHjVW3Yws/xKqqxhPZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Khrjh9GXxZ1xhZ82jzFv6RcSBaJ/uVjWK8BB22DiGsX4X5KpK8l2T42S3wxKdqcQ27Yq+BsVymTKEcbfPlFs86T/cEQJzY2bWD5zXkOkpO1eH8QrTcdDHH3F+I/FpqE4cWo4y+h0og3BOdhOuTygSm2EjjBhNOa5iYrdt2uSbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Jl5f6yBL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2JIC7F2129365;
	Tue, 2 Dec 2025 15:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9DJtt
	fG1jUB9uOjk8WT4iUslHYS+BUPeVFFH2Iraq/g=; b=Jl5f6yBLtDQOyYMjfEG89
	6XXq9N+DMoOXqFGrKsM/R1x7NgzeAeLcZa7umEBuLbF2w3uLpSdMNorpZqZp9cRM
	sIE0lhwrANAv3JXBBF1oCObFrXBLbbuabz0NrkZGDrLLVm8pJ0dMTYafFTiyao9m
	Z24pEOI6k+9KtwbBGLYOuE1x1IJJQt+zky1VQ0gSrwkf/++hivctyAjnggXNxipZ
	MYHn4ky//KYNSiedb3LGEtlteGDXkfkOY0/7l9G2dYdMuHo8PV8zFCyzclMstJ/x
	vaSXx8G6mUXbnI25Yrxm03+8RcjUv+71J0wAR6zi8u2P+cqSdxawV/wVkU+YOhmC
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4at2vd1ccf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:55:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B2Ktrp4060262
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Dec 2025 15:55:53 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Dec 2025 15:55:51 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Dec 2025 15:55:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 2 Dec 2025 15:55:51 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B2Ktco1020236;
	Tue, 2 Dec 2025 15:55:40 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 3/3] Docs: iio: Add AD4134
Date: Tue, 2 Dec 2025 17:55:37 -0300
Message-ID: <69b230190abb4cd76ad9eb25e2bde51caaa23d9a.1764708608.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1764708608.git.marcelo.schmitt@analog.com>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE2NCBTYWx0ZWRfX67G+G66LDX1W
 H5h8/CGi3XyTI06cjR1nUHjE8ETM5Wv4nTa+646130Odn5iA6XRl298jBsuFaL5U0fjlB/OuKwi
 1zR142ibSW+GibKgGaiUJtM8En+6vjaadUuW1yic24sefq2EbNQzTTt0gNIaROlbT0eGHNsMBUI
 kXx+J1JzO8gMeW//S7uSfeJ5MGCob9ACQkDYlZ9WJjoY9x6jnBIS0fDzcpiQqEU5Eqy6HO70d99
 wlvY67J5+CD5MNTXAuEx3JiXnWPNAeWINN+XpxKUeHaf7/LxjMbf5o5KzXwTP1YEra6MhDtjos6
 yEQbni4qz38f5RzdidC5p/77p15lotpcKmn8FHeajalosSmUpCwn4nmF7fzR/laQpDVV1EDDAAr
 g0zqvUUYDyUfm+fcb9RMff1ldowr8A==
X-Proofpoint-ORIG-GUID: kSbIugn0G4-VIcnvvAMEDLV2zbYBBQxk
X-Proofpoint-GUID: kSbIugn0G4-VIcnvvAMEDLV2zbYBBQxk
X-Authority-Analysis: v=2.4 cv=KeffcAYD c=1 sm=1 tr=0 ts=692f525a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=B918M15fmQb9CbtuFVMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512020164

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes from v2 to v3.

 Documentation/iio/ad4134.rst | 58 ++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  1 +
 MAINTAINERS                  |  1 +
 3 files changed, 60 insertions(+)
 create mode 100644 Documentation/iio/ad4134.rst

diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
new file mode 100644
index 000000000000..fa44a05e6793
--- /dev/null
+++ b/Documentation/iio/ad4134.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4134 driver
+=============
+
+Device driver for Analog Devices Inc. AD4134 and similar ADCs.
+
+Supported devices
+=================
+
+* `AD4134 <https://www.analog.com/AD4134>`_
+* `AD7134 <https://www.analog.com/AD7134>`_
+
+Wiring connections
+------------------
+
+AD4134 and similar ADCs can operate in a few different wiring configurations.
+
+Minimum I/O mode (SPI control mode)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The minimum I/O mode wiring allows AD4134 register and data access with the
+conventional set of SPI bus lines. The hardware configuration settings for using
+AD4134 in minimum I/O mode are:
+
++----------------------------+----------------------+--------------------+
+| Pin Function               |         Level        | Description        |
++============================+======================+====================+
+| PIN/SPI                    |         High         | SPI control mode   |
++----------------------------+----------------------+--------------------+
+| MODE                       |         Low          | ASRC slave mode    |
++----------------------------+----------------------+--------------------+
+| DCLKIO                     |         Low          | DCLK input         |
++----------------------------+----------------------+--------------------+
+| DCLKMODE                   |         Low          | Gated DCLK         |
++----------------------------+----------------------+--------------------+
+
+A possible connection schema that sets AD4134 digital interface for minimum I/O
+mode is:
+
+::
+
+                                 IOVDD
+      +------------------------+   |
+      |                PIN/SPI |<--+     +-------------+
+      |                        |         |     HOST    |
+      |                   DCLK |<--+     |             |
+      |           FORMAT1/SCLK |<--+---- | SCLK        |
+      |   AD4134      DEC2/SDI |<--------| SDO         |
+      |               DEC3/SDO |-------->| SDI         |
+      |                    ODR |<--------| GPIO        |
+      |             FORMAT0/CS |<--+     |             |
+      |                   MODE |<--+     +-------------+
+      |            DEC0/DCLKIO |<--+
+      |          DEC1/DCLKMODE |<--+
+      +------------------------+   |
+                                  GND
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 315ae37d6fd4..d4ed782c93a6 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -22,6 +22,7 @@ Industrial I/O Kernel Drivers
    ad3552r
    ad4000
    ad4030
+   ad4134
    ad4695
    ad7191
    ad7380
diff --git a/MAINTAINERS b/MAINTAINERS
index a1541cf3967b..b2c101598636 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1455,6 +1455,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+F:	Documentation/iio/ad4134.rst
 F:	drivers/iio/adc/ad4134.c
 
 ANALOG DEVICES INC AD4170-4 DRIVER
-- 
2.51.0


