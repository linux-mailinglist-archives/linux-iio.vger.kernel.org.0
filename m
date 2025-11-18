Return-Path: <linux-iio+bounces-26301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1FC6B04B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 18:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8F004E5548
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017DD366DBD;
	Tue, 18 Nov 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uj56So53"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A923570B5;
	Tue, 18 Nov 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487227; cv=none; b=s7nuVYeDMvsE2c8rkeOtMEi1IpkNeGyA33IO/0OhcRutCuXq42Gab9swgh6nnPQb/AQiOGP5zgnJoF02Ncv9y/BhUTmyz/5aij3XYEeb+13slWtGTm2YWawdi6At6mxFN88/sqgXVOy5Itpl7U1XE/KzeVD990g2TF8D7wWMKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487227; c=relaxed/simple;
	bh=HHJjNMzkyNm9+eFvyfLIB9NBXsLMLugJ/Yh/qD3ILHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSc0hUEpQytsqkj1Opjwf9sQf+zQO3Gehn5hS+eSSNXt7T3ZHOzK2XTvdztnS6DjnUW4yI4Og5fjoUUYjMT8D1aoguYdgfVocndEf8pF6Fm3tAHt7/UDMyWBs4z0iv0sSLdjS62ln5gDqqhHGFdXVLSR7xBD2owsnFkQyX6MpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uj56So53; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIH4Ap02367616;
	Tue, 18 Nov 2025 12:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1qes9
	a+k/Joj4ek4Moqp7NAJ7jPKzssVq+1TxZw4cv8=; b=uj56So53v/d+FdljkkOZF
	QYu6ZFUH7wGWhnglKEPVg45bXNApfM3WgY7Bc5W0431uyJvqWzVqPg0hXu2C3p/W
	NAxjZFSvxh2kumZyG/3OjEdn7fQH8kHy+TTvmFfu2EqOEQQDFKb+L5guhMCEoi6n
	eRuhxFFiOewscrHz+aKHNwjtTWlZmcFQa3QZeV976OHqC2jadoJb6XEWP+sHBwXL
	JQY+H+p2R624oi8Cwzl5KQoBjvX1xXykykbthGFRbjlOTdVzb5OOPBEfe9uypIin
	DVhaB1oyoXjLdHobU/JAcitBHlzeHuFUIMkgHe25sUY1aYSoX5D99fpSKw0Eopj9
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aggt2kpt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 12:33:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AIHXExf043299
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Nov 2025 12:33:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Nov 2025 12:33:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Nov 2025 12:33:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 18 Nov 2025 12:33:14 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AIHWxKX007681;
	Tue, 18 Nov 2025 12:33:01 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <cosmin.tanislav@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 3/3] Docs: iio: Add AD4134
Date: Tue, 18 Nov 2025 14:32:58 -0300
Message-ID: <5d51a7a53eac60ff555fe2350fac69fcb7f9e9f2.1763478299.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1763478299.git.marcelo.schmitt@analog.com>
References: <cover.1763478299.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: XAPmJovnoQV6oo0RDSTWPdvmB0FVjqM7
X-Proofpoint-ORIG-GUID: XAPmJovnoQV6oo0RDSTWPdvmB0FVjqM7
X-Authority-Analysis: v=2.4 cv=FsIIPmrq c=1 sm=1 tr=0 ts=691caddc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=B918M15fmQb9CbtuFVMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0MiBTYWx0ZWRfX60KlLUMwCxtL
 kDE21z2BoQj+cSTExKJWcWuT+69flRJq7XIoRdWCWzaalKTrEVpHMMC2srKX6J3lOEd07mYDf3Z
 JowK7F4uq9uiShAjU5Z9PzYdUssxU+pTrh2e6J+Je8PZvTTOKULdBDaW1YcHNIOjsbLuYcKwS8C
 1AztNShou4otxBTxYkjQw2vMjapo3OdPFIpecCAUJz/+On0lx0fctx1WO4jTLz0cpCxTkaIhmTo
 aINZvaBvyghjImvTsyH6tPl/76mltyVeG2fWip2diPVxd60lQo82IeV6S70THD14oRSZfM2i6n3
 OGXxXlYmBsWyGsjuLvM98UAVqq+xfzy9Icu2qYKYDIqeevuXBwgKCT1klmLxvZLZ6NKqTOhVvuQ
 683lntnM2StPspqNh4id9NNG0zzz2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180142

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Now using "~~~~~~~~" to mark fourth level topic.

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


