Return-Path: <linux-iio+bounces-26131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC86C46B11
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 13:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9A4188C928
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095930F920;
	Mon, 10 Nov 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zadGmSc1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D630E838;
	Mon, 10 Nov 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778777; cv=none; b=oId22TE8mxB/c2zsn8YRFu129/qeGyJlbzB/yHwWlhOXXasRa5CpXGviYg4EJKZNFNoAPP5g90yNFWgC37EXw1ZDn+1RuXC/i3KEcnw+Dr00GPAD4rI/iCAERSuKpUaQBVrAL/gAFH/VLY81/gsvAHWbcR4pfn3b/AYjHInv0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778777; c=relaxed/simple;
	bh=QrXgwkFS/QXGnT2RRbiuD6Jfv5jebHz15vjXJ4DILEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1/tnutWXngB0z438SOeMWMVXsGDDIK9n7XePksVA3ydkLc0oe3UoJilxSBQVRZBSMvefRrlO2KtM1pC1OtGn55psKUnuarsog6gSaJWm8YMYgmA+RnebSSd20cbOe7TwpstXmr/iRt4C2ZnpaEyUFwPcTC4keME0QCMWReXRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zadGmSc1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8cO8h541765;
	Mon, 10 Nov 2025 07:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QChb4
	CWID+pQmW2BuYFVZhuMmp02Fb8hO9z5It3ks64=; b=zadGmSc1TGMBL1nCKpPHi
	GWGJJCT7OiKSV589TEkr5FtKOKwJ2cH6WL7h8Ku+tugFXD+GKyEDy/PlNTeONAH0
	tkLoAq+RkFFnboJzwqg25FNW91H02PHb2e1q5HvgvzQtiZLOV8p/GqL3ukt5PzUC
	pRezVwCvBdDe1QVCWC7/mzG+5bH8+ZIfLGBcxGyE8/hsuBCgJ0XOmxJjjR7bTapB
	WZTgfXINxtjmSG9dAf1VygFMuv9UfE/0zshLO4Qz+LqtWZELaYlqaLW8tbtVSEFu
	7yEpTFjeNDChfbeONG1dWtZT2e9TNHxYcTwCguvYqF0zSsXKbZFlIRq7G6Kl//Jl
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4abcqf10gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 07:46:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AACkAUF064034
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Nov 2025 07:46:10 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 10 Nov 2025 07:46:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 10 Nov 2025 07:46:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 10 Nov 2025 07:46:09 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AACjtQN000607;
	Mon, 10 Nov 2025 07:45:58 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <cosmin.tanislav@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 3/3] Docs: iio: Add AD4134
Date: Mon, 10 Nov 2025 09:45:55 -0300
Message-ID: <bbb702b6e2cad4bf79b1490c4280ce998b46827b.1762777931.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1762777931.git.marcelo.schmitt@analog.com>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=GYsaXAXL c=1 sm=1 tr=0 ts=6911de93 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=lO61LlJOqjs1HvH3lTEA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMSBTYWx0ZWRfX9MUOWMbU5/UU
 Ndrjj68aS27eHuAfr91Wu+kGiJxVm3Dqdy4XrC+cOZZmqM79QLjwP733A0pjl1TjKHhQGtKvVI1
 Tc93fL6hG6WzOcaCHOTQCO0+jCAETsih21dz03pHe59RnkRT/FrO+68XEkptRB02HcuoNF2UKMe
 ulhL1FR3CO+/2yLUNrStXyOlThZ7s5VFHNoB9pOu9Ebtl31a52pqBcz9iPRM6yi3Ys7xg6bTH2G
 rL9OJVG/wko2ACDXF4kqKD/JHFt4Ss8JpCWYGMCzwcdRBgkBJADTBbdQf+WNbuW2NCuadn6sp4G
 DhFFCI2y82HKzCd1byJEgv+OPX031xducvLh++F4pAHLYnsFlO7NWKwR5tQnFS44Zmn8BsjWMVb
 ft3o00KM9eEn2nTkHEag50KyJs7lFQ==
X-Proofpoint-ORIG-GUID: oL-94zI8_Pm-ADAd7lxRcVtJJrjDkwQt
X-Proofpoint-GUID: oL-94zI8_Pm-ADAd7lxRcVtJJrjDkwQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100111

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4134.rst | 58 ++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  1 +
 MAINTAINERS                  |  1 +
 3 files changed, 60 insertions(+)
 create mode 100644 Documentation/iio/ad4134.rst

diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
new file mode 100644
index 000000000000..fe20ec6f2132
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
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
index e709ec1d6717..80ae2fd4735c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1443,6 +1443,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+F:	Documentation/iio/ad4134.rst
 F:	drivers/iio/adc/ad4134*
 
 ANALOG DEVICES INC AD4170-4 DRIVER
-- 
2.51.0


