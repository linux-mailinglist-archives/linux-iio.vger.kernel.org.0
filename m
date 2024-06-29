Return-Path: <linux-iio+bounces-7066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9916B91CECB
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240731F21C1C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B613A24B;
	Sat, 29 Jun 2024 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wCRMcfg6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34908139D12;
	Sat, 29 Jun 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719688079; cv=none; b=MaClflGk10oT5b4aZguEtCYqBvsfPyH/2bs6NXPiIfVNZksjVavFa42IHwdHOO+BPmCUy6FBz3gmM1cDNBCRGK6uL/V6HOCPC0GtvGZ1+/5xgkaDlzyM55sw/eBBJbC/hDDzjwdKzusmxqXUoDSw65QsOwJt2PD1Ej+4/EzZnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719688079; c=relaxed/simple;
	bh=jZ+wcEpx7M4J5I61Wrco+Y735X/oDe0NNCE9YQjxVHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI1ygpIojkUEwmTXO9txXG4hbNok6/9T/QcRKO0WvNrSfVYZHYseIZ9Y1RxvAF2rjeoz+i+9F0AW9Vw/L6awJrI2fLbDfTmBdfwR5P6YxrRM+GVmljzt9AxN3h9HCicBSzt2VfgJGnaHyLPfPFFREcnFA9XCR+3+5ZUg2Feu69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wCRMcfg6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T92iOt003717;
	Sat, 29 Jun 2024 15:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6Dy4X
	Wij/fFaig7Oy0V6YA6ze5sQbhrGy8kvlRZB+fM=; b=wCRMcfg6/FU9/H66h/R6Y
	/vAx8hAJCJPZMT+oG9egM4Jq1ku2hT+rw7LhHoPv2UjfgpA5H1HebQg3+j3fKgE4
	Z20oGSoBUhzivfnzefxRd3hqymjRs8bU2YpBL8m3OZ0VXS4tM7feA/P8rcsEbD8M
	VF3rQZGy5hZXzjW18ZrkTSPOKyvoyvD2XE9ne/E++mhb6oHXXGHQk75JJd1XF/XH
	UG2hj7asH6mqmd/Ou4eS19Z1JoAD0ln6EbyXHlmhQ3wQMF22EgWzhSCDEEe+OUdB
	IrsJyE4OTBFDnPC710G3K6ULsa1IhQiF0CPPWtvriPrCyE98fL89GO+syPCyuFN6
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 402f9u0ysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 15:07:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45TJ7fTs046872
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 15:07:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 29 Jun 2024 15:07:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 29 Jun 2024 15:07:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 29 Jun 2024 15:07:40 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45TJ7OJs001414;
	Sat, 29 Jun 2024 15:07:27 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 7/7] docs: iio: Add documentation for AD4000
Date: Sat, 29 Jun 2024 16:07:23 -0300
Message-ID: <d5f07e2ea4f4aaae1c13ed0b1b0c6abb15492a67.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: y8beMAdU_Eq0-kGTVShPlVk2X9m4cwHN
X-Proofpoint-GUID: y8beMAdU_Eq0-kGTVShPlVk2X9m4cwHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290138

Document wiring configurations for the AD4000 series of ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4000.rst | 131 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 133 insertions(+)
 create mode 100644 Documentation/iio/ad4000.rst

diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
new file mode 100644
index 000000000000..de8fd3ae6e62
--- /dev/null
+++ b/Documentation/iio/ad4000.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4000 driver
+=============
+
+Device driver for Analog Devices Inc. AD4000 series of ADCs.
+
+Supported devices
+=================
+
+* `AD4000 <https://www.analog.com/AD4000>`_
+* `AD4001 <https://www.analog.com/AD4001>`_
+* `AD4002 <https://www.analog.com/AD4002>`_
+* `AD4003 <https://www.analog.com/AD4003>`_
+* `AD4004 <https://www.analog.com/AD4004>`_
+* `AD4005 <https://www.analog.com/AD4005>`_
+* `AD4006 <https://www.analog.com/AD4006>`_
+* `AD4007 <https://www.analog.com/AD4007>`_
+* `AD4008 <https://www.analog.com/AD4008>`_
+* `AD4010 <https://www.analog.com/AD4010>`_
+* `AD4011 <https://www.analog.com/AD4011>`_
+* `AD4020 <https://www.analog.com/AD4020>`_
+* `AD4021 <https://www.analog.com/AD4021>`_
+* `AD4022 <https://www.analog.com/AD4022>`_
+* `ADAQ4001 <https://www.analog.com/ADAQ4001>`_
+* `ADAQ4003 <https://www.analog.com/ADAQ4003>`_
+
+Wiring connections
+------------------
+
+Devices of the AD4000 series can be connected to the SPI host controller in a
+few different modes.
+
+CS mode, 3-wire turbo mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Datasheet "3-wire" mode is what most resembles standard SPI connection which,
+for these devices, comprises of connecting the controller CS line to device CNV
+pin and other SPI lines as usual. This configuration is (misleadingly) called
+"CS Mode, 3-Wire Turbo Mode" connection in datasheets.
+NOTE: The datasheet definition of 3-wire mode for the AD4000 series is NOT the
+same of standard spi-3wire mode.
+This is the only connection mode that allows configuration register access but
+it requires the SPI controller to support the ``SPI_MOSI_IDLE_HIGH`` feature.
+
+Omit the ``adi,sdi-pin`` property in device tree to select this mode.
+
+::
+
+                                         +-------------+
+     + ----------------------------------| SDO         |
+     |                                   |             |
+     |               +-------------------| CS          |
+     |               v                   |             |
+     |    +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD4000   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
+
+CS mode, 3-wire, without busy indicator
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Another wiring configuration supported as "3-wire" mode has the SDI pin
+hard-wired to digital input/output interface supply (VIO). In this setup, the
+controller is not required to support ``SPI_MOSI_IDLE_HIGH`` but register access
+is not possible. This connection mode saves one wire and works with any SPI
+controller.
+
+Set the ``adi,sdi-pin`` device tree property to ``"high"`` to select this mode.
+
+::
+
+                                         +-------------+
+                    +--------------------| CS          |
+                    v                    |             |
+    VIO   +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD4000   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
+
+Alternatively, a GPIO may be connected to the device CNV pin. This is similar to
+the previous wiring configuration but saves the use of a CS line.
+
+::
+
+                                         +-------------+
+                    +--------------------| GPIO        |
+                    v                    |             |
+    VIO   +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD4000   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
+
+CS mode, 4-wire without busy indicator
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In datasheet "4-wire" mode, the controller CS line is connected to the ADC SDI
+pin and a GPIO is connected to the ADC CNV pin. This connection mode may better
+suit scenarios where multiple ADCs can share one CNV trigger.
+
+Set ``adi,sdi-pin`` to ``"cs"`` to select this mode.
+
+
+::
+
+                                         +-------------+
+     + ----------------------------------| CS          |
+     |                                   |             |
+     |               +-------------------| GPIO        |
+     |               v                   |             |
+     |    +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD4000   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 4c13bfa2865c..5df157a44923 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -17,6 +17,7 @@ Industrial I/O Kernel Drivers
 .. toctree::
    :maxdepth: 1
 
+   ad4000
    ad7944
    adis16475
    adis16480
diff --git a/MAINTAINERS b/MAINTAINERS
index f4ffedada8ea..a03b3db9157c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1205,6 +1205,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+F:	Documentation/iio/ad4000.rst
 F:	drivers/iio/adc/ad4000.c
 
 ANALOG DEVICES INC AD4130 DRIVER
-- 
2.43.0


