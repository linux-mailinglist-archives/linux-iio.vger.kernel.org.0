Return-Path: <linux-iio+bounces-6929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4CA9173EA
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07991C218B9
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4A180A62;
	Tue, 25 Jun 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dyaM9Bn7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A601802A7;
	Tue, 25 Jun 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352595; cv=none; b=Xr2r4Uw+ip9uNV8DwJza1IXptt/W99/HN44LIWZKkYanYE7DtjBDKxsjQ/mgKAR+Gh0gU5o50vuy7DQCb/I4DYsIVLvNav93hWYVC3WOpvX+upc99VtETCjKKLyDhIhg3cgyicHXxZ13oWYz1VZbK76sbGUqm2yk2ifQ9OzfjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352595; c=relaxed/simple;
	bh=jZ+wcEpx7M4J5I61Wrco+Y735X/oDe0NNCE9YQjxVHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLmjh/8gUh44dEJFtro5xaXVvp5YSPB9DapcvrsCYN6xG9FBjnxRVpJVSqxTffh/MU9tPriNKsOPGxGIjVQXOtMYt2vS0JPotjKRxHRIlVrIQOuNuv0LKWdnzWjhScQI/N/EKmMrGDjo3bI2KwvxwQk8PePpmLaUvhvoCyNN4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dyaM9Bn7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PFnB26000313;
	Tue, 25 Jun 2024 17:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6Dy4X
	Wij/fFaig7Oy0V6YA6ze5sQbhrGy8kvlRZB+fM=; b=dyaM9Bn7D5v6EGNCoCAVY
	+xJrJul83rFtaOf7wJ/CER66fExcwGeWq9ZwxLPbZHZwZ4U7aHZnry5RE+cFoF7O
	AYKFZu875MmG36T9N2E+JCsGEx82k3pk/oObh34V0P2lQfjAlKcL8IZ5vtviBVqG
	AnzD/SYaYyCOis8nbm9EIdRb48NIYw4MySBXpjt6V8zmpuoCKmisKK4sJOuArcLm
	uGSaOprDi47ztJ+RxiwEdbm6ZhIokgXQnQVATQ2q69NivVRSn2qS03KOwXRhpIaE
	zHmEuh61lmTjHPoOzo4ug60VQPCTNMU5gcqPOmFtxqNc8L8W9LqhCxvPRhGBecr6
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ywuh2m7af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:56:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45PLuH4G003619
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 17:56:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:56:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:56:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Jun 2024 17:56:16 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45PLu0ww013888;
	Tue, 25 Jun 2024 17:56:03 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 7/7] docs: iio: Add documentation for AD4000
Date: Tue, 25 Jun 2024 18:55:59 -0300
Message-ID: <e553a7c6ba88b3d8ae2db0963212fdce0919805a.1719351923.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -KU6iPVqN3MRnq7ENWTZcMRmFV-ji0c0
X-Proofpoint-ORIG-GUID: -KU6iPVqN3MRnq7ENWTZcMRmFV-ji0c0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250163

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


