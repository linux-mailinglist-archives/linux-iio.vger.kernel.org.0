Return-Path: <linux-iio+bounces-27220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA177CD087E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E576030F9AA9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAD33B949;
	Fri, 19 Dec 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GHwkHM60"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3032827D;
	Fri, 19 Dec 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158313; cv=none; b=jLqsG8qx3XcrHoCnBBeGAUOTj+BzEkYtWCeow6dAtHIf0jc6l80dmSKKAPYTZPAlhidipoQm6mFmeLbFnUSnpFRzM+ZtVi3r0hnT6OVaZozyBJ4EeQhKThR09gLWYD2DBBJwsSyKppDmzmgnAylc2f+4QfK2s/6Yi+VySXn2jP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158313; c=relaxed/simple;
	bh=3BSHjfCvIkqe1xouUfBxg8AxFiy9X5C1S9PQ8rapa4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LaP7YPK5O7Q1OZ5KhjMm8ZIr+BJO/D1cv+LdhWkxGlsbBZ3qQ7yf+p2mnXAjqYUCb4P4bNq2eXPfuo1v2fVma2bLO/cDCRDEvPyCoUFP5Qk3kEKItFKEdvEfJjBArIoKBmJyO/6YqNUvxAlxPUC7VRiKjDszCFuZ/jabDMwrmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GHwkHM60; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJETm982185215;
	Fri, 19 Dec 2025 10:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RveE6
	VA8HLFbjSI+3roINka2OZpb+UsHtFNajQRPynE=; b=GHwkHM60U1be5EwyCeqNj
	iA6O9HgMBfgyaxnMwzArseAZorQBpaCIf5GiHrkopXe6ebuzwICcHycaQnA//r2P
	aCoP0nrNu94OAh2pYMECoiua3vxDECGN+snz17vSiFRhnc2KBH6GELb2ZNIK8eqw
	rhkJMR23/jemid+Ams/KIbPihV4jKJ/hUTiw8nrtkUf0urxS5atN9ecMrqFWNXxJ
	l8fDPW+vHiCTEkyCygtMNBQcfctHqRDcMQ83LKVmzX7wt2dFsMGqBnEHQHVeYdEz
	6CUpUa8w2x1lI8n5L9ou/7kLMvtzegyhZGrjDyfeycnCLA2wc42Copto1WGeZKjK
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b4r3ucrvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 10:31:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BJFVW2i051281
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Dec 2025 10:31:32 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 19 Dec 2025 10:31:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 19 Dec 2025 10:31:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 19 Dec 2025 10:31:32 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.88])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BJFVIW4004160;
	Fri, 19 Dec 2025 10:31:28 -0500
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 19 Dec 2025 16:31:16 +0100
Subject: [PATCH 2/3] docs: iio: Add documentation for MAX22007 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251219-max22007-dev-v1-2-242da2c2b868@analog.com>
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
In-Reply-To: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158278; l=5985;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=3BSHjfCvIkqe1xouUfBxg8AxFiy9X5C1S9PQ8rapa4Y=;
 b=g16rfCyKAb97wS2J0bi+SzLy05n/vIk1uhDc/i/XOpjMEXpR6+0qQynj99J/UGqAZla8LxNEi
 Nr6yKMcklxQCyRioKC3i1VFlMpbcjo6tmSqQO5A+x+km3AglsbUWuEw
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69456fd6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=GlV9v06JWbdyGhn1SPMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=9pxso9FRmSwA:10 a=kMJE-xFm7jYA:10
X-Proofpoint-GUID: SjSn17IIXrANeQVuzhQBLs1CWN9m9HVR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEzMCBTYWx0ZWRfX0VagZm69Hk13
 Tz9O2Zf7duNodNxafabH/uFicavn0TGfK2jTgByAs5FSlHIx1O9nmoF3KRIPPYdYZNhNEwKmbfX
 TwDEDAqSydvCx/pUvSWBbldH3aK/Cwfd48yviMzTwKRSMsCnFNx7E/+JDaDN1jVXNieGu8jGqWr
 7v92OxWG063x4hK4G77/S6MD5NHPyzBBEuCz65HrOzrMIZ9KOysk8jMOrT1zTS5QJYKzoQbqehu
 3ViS55qXUUol4hwb/n/tzNVTzpBQBLc2DCQ3TBn8SVnYcI8yAGA950UyEYg/C8JBDxyh8etoaqO
 T+LIFOTNjvvoMAKwXaRn6sGS5bh8lbmkJe+FIg1L5rJd+YPV2SYkUeLkvMAUOMdFvQ5m5IFlb+6
 ZZAvcgILycEnKvfGM5naIoeIHDab9Y3YqResXxvTiKpTX8VPUCrbJyhIKmM8PtsHdrihFAA97o+
 odDExozaxpVfweFdk7A==
X-Proofpoint-ORIG-GUID: SjSn17IIXrANeQVuzhQBLs1CWN9m9HVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190130

Add documentation for MAX22007 driver which describes how the user
can access the driver using dtoverlays

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/iio/index.rst    |   1 +
 Documentation/iio/max22007.rst | 145 +++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   1 +
 3 files changed, 147 insertions(+)

diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 315ae37d6fd4..7601bc2882e7 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -37,4 +37,5 @@ Industrial I/O Kernel Drivers
    adxl345
    bno055
    ep93xx_adc
+   max22007
    opt4060
diff --git a/Documentation/iio/max22007.rst b/Documentation/iio/max22007.rst
new file mode 100644
index 000000000000..e04c563f1fd0
--- /dev/null
+++ b/Documentation/iio/max22007.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+===============
+MAX22007 driver
+===============
+
+Device driver for Analog Devices Inc. MAX22007 quad-channel industrial DAC.
+The module name is ``max22007``.
+
+Supported devices
+=================
+
+* `MAX22007 <https://www.analog.com/en/products/max22007.html>`_
+
+Wiring connections
+==================
+
+The MAX22007 uses a standard SPI interface.
+
+Device Tree Configuration
+=========================
+
+The device supports both global and per-channel configuration through device tree.
+
+Global Properties:
+
+* ``reset-gpios``: GPIO pin for hardware reset (optional, falls back to
+  software reset if not specified)
+* ``vdd-supply``: Low-Voltage Power Supply from +2.7V to +5.5V (optional)
+* ``hvdd-supply``: Positive High-Voltage Power Supply from +8V to (HVSS +24V)
+  for the Output Channels (optional)
+* ``hvss-supply``: Negative High-Voltage Power Supply from -2V to 0V for the
+  Output Channels (optional)
+
+Per-channel properties:
+
+* ``adi,type``: Specify the channel output type - must be either "voltage" or "current" (mandatory)
+
+Note: The driver operates in transparent mode (immediate register-to-output updates).
+Channel mode is determined by the ``adi,type`` property:
+
+* ``adi,type = "current"``: the channel operates in current mode
+* ``adi,type = "voltage"``: the channel operates in voltage mode
+
+Device attributes
+=================
+
+The MAX22007 driver provides IIO DAC interfaces that vary based on the
+configured channel mode. Each channel appears as a separate IIO device
+attribute:
+
+* ``out_voltage_raw`` (voltage mode channels)
+* ``out_current_raw`` (current mode channels)
+* ``out_voltage_scale`` / ``out_current_scale`` (channel scaling factors)
+* ``out_voltage_powerdown`` / ``out_current_powerdown`` (channel power control)
+
+The driver automatically configures the IIO channel type based on the configured
+channel mode from device tree.
+
+Power Mode Control
+==================
+
+Each channel provides standard IIO ``powerdown`` attributes for runtime power
+control:
+
+* Write ``1`` to power down (disable) the channel output
+* Write ``0`` to power up (enable) the channel output
+* Read the attribute to get the current power state (1=powered down, 0=powered up)
+
+This allows individual channels to be powered on/off independently for power
+management and safety purposes.
+
+Usage Examples
+==============
+
+Setting DAC output values:
+
+.. code-block:: bash
+
+   # Set channel 0 (voltage mode) to raw value 655 (≈2V)
+   # Output is updated immediately in transparent mode
+   echo 655 > /sys/bus/iio/devices/iio:deviceX/out_voltage0_raw
+
+   # Set channel 1 (current mode)
+   # Output is updated immediately in transparent mode
+   echo 1024 > /sys/bus/iio/devices/iio:deviceX/out_current1_raw
+
+Controlling channel power modes:
+
+.. code-block:: bash
+
+   # Enable channel 0 (power up)
+   echo 0 > /sys/bus/iio/devices/iio:deviceX/out_voltage0_powerdown
+
+   # Disable channel 1 (power down)
+   echo 1 > /sys/bus/iio/devices/iio:deviceX/out_current1_powerdown
+
+   # Check current power state (0=powered up, 1=powered down)
+   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_powerdown
+
+Reading channel values and scale factors:
+
+.. code-block:: bash
+
+   # Read raw DAC value
+   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_raw
+
+   # Read scale factor (volts per LSB)
+   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_scale
+
+Check available channels:
+
+.. code-block:: bash
+
+   ls /sys/bus/iio/devices/iio:deviceX/out_*_raw
+
+Scale Calculations
+==================
+
+The driver provides accurate scale factors based on the hardware configuration:
+
+**Voltage Mode:**
+
+- Scale = (5 × 2.5V) / 4096 = 0.003051757 V per LSB
+- Range: 0V to 12.5V over 12-bit (0-4095)
+- Formula: Output = Raw_Value × Scale
+
+**Current Mode:**
+
+- Scale = (2.5V / (2 × 50Ω)) / 4096 = 0.000006103515625 A per LSB
+- Range: 0A to 0.025A over 12-bit (0-4095)
+- Formula: Output = Raw_Value × Scale
+
+Driver Architecture
+===================
+
+The driver implements:
+
+* **CRC8 Error Checking**: Always-enabled CRC8 for SPI data integrity
+* **Channel Configuration**: Supports per-channel mode and power configuration
+
+Channel configuration (voltage/current mode) is set via the ``adi,type``
+device tree property and cannot be changed dynamically The driver requires
+proper device tree configuration with mandatory ``adi,type`` property for each
+channel.
diff --git a/MAINTAINERS b/MAINTAINERS
index e1addbd21562..6561455732c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1599,6 +1599,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
+F:	Documentation/iio/max22007.rst
 
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>

-- 
2.43.0


