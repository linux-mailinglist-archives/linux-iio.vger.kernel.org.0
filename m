Return-Path: <linux-iio+bounces-16470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A621A54CE3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D883AF5A5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A541519A6;
	Thu,  6 Mar 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Thri84fb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0DB652;
	Thu,  6 Mar 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269895; cv=none; b=Wr3YZja9chyga/fb4gR3UQpZ0StsYbZx/NDfG9mafeOSaM0xWzAgEkTdT4WEmS4Jfkj1yr/2VigvENY9TM25TOk4S7p0IdUHlBMDOasrPs2XG2qAPD9bVw8HTehDrYmEBQjyk94OTGNeIi1xbP9ypJlAmlvWGLzV0ZVq0bw2DFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269895; c=relaxed/simple;
	bh=24hx6NfTsOcM14rkR4Pj/9Ev59OFZ96eDJYlJXt1Qa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r+xdIm7sVXd/YNZNBqmPRyDMU2q4WbtTznhf89FiHLr1zfj4myJEpOqSLP9jru6NY1YUxzTD2CDMiEVsfQI65m6qMYorMr1/E81aCKJOoefOPVbPhP6/l9DIz0s7u+Uq1VZ80Vbdzyr8MBXw6JXgP5Zte56NsuK/SsH8IR56OjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Thri84fb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526COPY6005057;
	Thu, 6 Mar 2025 09:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=02pPn
	kO7p7f8PYfGgTyQW0NkYpGujTGi9XHt8Up0wI4=; b=Thri84fbV69GfOvmMh5/l
	ztFW2a2l0aKagP8heI6IYTeei2usw74K+fk1m4mkRZd8y6iK3gcRyumf7N4HIvRn
	UJ9YhJvW2aKoEuZf0j4sArUCAx1EXHNlcSLFhPJz+VvsN5eG1WmpsMAbnO0Rjpps
	6KZhZ2HF0e5/FWRRtfBWI4UYz41/+gTMZDFf/xEc8SOivmM+KXgGdo/56OBOUwK5
	1r5cTL84YPYz4kOxTQs3ab0rKLkmGMGhq+4JICsU1A8wGa2ZQ3JoFNMXpQd0k55P
	1vxJLt7n4Wxmxar+n45XEAX0fDhmMXeg4cgKHLOfNK1phSUL6kGQj0E+33g1iHT3
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4577p69mnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:04:31 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 526E4UEw016899
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 09:04:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 09:04:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 09:04:30 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526E4CqU024033;
	Thu, 6 Mar 2025 09:04:23 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Thu, 6 Mar 2025 15:03:16 +0100
Subject: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
In-Reply-To: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741269851; l=3945;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=24hx6NfTsOcM14rkR4Pj/9Ev59OFZ96eDJYlJXt1Qa4=;
 b=YgfxQliUD/P+NPA25ix3iFqu1NnZW+hjRdQVSxn/TZikVuojNsd8vh+uYqJWz6vmc4/jMbDPN
 BjvD/4hIgqsD5q4Ml1+Ra72TK3MnUteu+EDURGyiUn2yaDhSLcvssX9
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: NYbIRKoCZH4MwYbPAFZpRYph17Xot_Js
X-Proofpoint-ORIG-GUID: NYbIRKoCZH4MwYbPAFZpRYph17Xot_Js
X-Authority-Analysis: v=2.4 cv=GNDyEvNK c=1 sm=1 tr=0 ts=67c9ab70 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=qLcM2r4-lCJhFG8HUqIA:9 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060107

This adds a new page to document how to use the ad4052 ADC driver.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4052.rst | 93 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 2 files changed, 94 insertions(+)

diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
new file mode 100644
index 0000000000000000000000000000000000000000..cf0cbd60d0a48ea52f74ea02fde659fcdba61aa1
--- /dev/null
+++ b/Documentation/iio/ad4052.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4052 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4052 and similar devices.
+The module name is ``ad4052``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD4050 <https://www.analog.com/AD4050>`_
+* `AD4052 <https://www.analog.com/AD4052>`_
+* `AD4056 <https://www.analog.com/AD4056>`_
+* `AD4058 <https://www.analog.com/AD4058>`_
+
+Wiring modes
+============
+
+The ADC uses SPI 4-wire mode, and contain two programmable GPIOs and
+a CNV pin.
+
+The CNV pin is exposed as the ``cnv-gpios`` and triggers a ADC conversion.
+GP1 is ADC conversion ready signal and GP0 Threshold event interrupt, both
+exposed as interrupts.
+
+Omit ``cnv-gpios`` and tie CNV and CS together to use the rising edge
+of the CS as the CNV signal.
+
+Device attributes
+=================
+
+The ADC contain only one channels, and the following attributes:
+
+.. list-table:: Driver attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``in_voltage0_raw``
+     - Raw ADC voltage value
+   * - ``in_voltage0_oversampling_ratio``
+     - Enable the device's burst averaging mode to over sample using
+       the internal sample rate.
+   * - ``in_voltage0_oversampling_ratio_available``
+     - List of available oversampling values. Value 0 disable the burst
+       averaging mode.
+   * - ``sample_rate``
+     - Device internal sample rate used in the burst averaging mode.
+   * - ``sample_rate_available``
+     - List of available sample rates.
+
+Threshold events
+================
+
+The ADC supports a monitoring mode to raise threshold events.
+The driver supports a single interrupt for both rising and falling
+readings.
+
+During monitor mode, the device is busy since other transactions
+require to put the device in configuration mode first.
+
+Low-power mode
+==============
+
+The device enters low-power mode on idle to save power.
+Enabling an event puts the device out of the low-power since the ADC
+autonomously samples to assert the event condition.
+
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
+
+When SPI offload is being used, additional attributes are present:
+
+.. list-table:: Additional attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``in_voltage0_sampling_frequency``
+     - Set the sampling frequency.
+   * - ``in_voltage0_sampling_frequency_available``
+     - Get the sampling frequency range.
+
+The scan type is different when the buffer with offload support is enabled.
diff --git a/MAINTAINERS b/MAINTAINERS
index fef8adaee888d59e1aa3b3592dda5a8bea0b7677..312b2cf94b8f06298b1cbe5975ee32e2cf9a74d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1322,6 +1322,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
+F:	Documentation/iio/ad4052.rst
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>

-- 
2.48.1


