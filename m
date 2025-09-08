Return-Path: <linux-iio+bounces-23878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D676B48577
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83B81B2169F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60712E9ED5;
	Mon,  8 Sep 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rzMIgrny"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C12E7BDD;
	Mon,  8 Sep 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316977; cv=none; b=LM+ecuNknykF+dpIGq+rMgSsRHcixSH77uoBZLgYtuW+RbyjiuIkP7JhsUn/NhaIQOAqBhG2Hy8bo//P8R+BMXf0bCzeRXyRBY+f7WJ17B7c21t+A3xzMTfYiT1YGR1J/WYLcOVf9Ztg6N1Dmz+9j1F+x8pNzOYyyfRmJfaxRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316977; c=relaxed/simple;
	bh=RZdypEBMSKk8qtJMq+BfweRWBMoWQdLzOlE8jdpw0mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVf1kOBVfOaidi6hNy2baLJ9/a72Zm8NSYo9j5vgNLOrAo5kjtIG8U3VwScz4nQasfPzVHtH6JnQ2ICNi6qfotTEYR4l4g1RHqp/ZYb+1I6FxGIDLK/sEWzZdvG/huYlp0m+QMiDmDW28gEDN+0fbsye6Jor9IP0GbTvded9xBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rzMIgrny; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58863o3c019421;
	Mon, 8 Sep 2025 03:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UoZCL
	5TkBS0qk2hT+xmyqWBzEwqui/66oQ1ZCv973r0=; b=rzMIgrnyUB2d/CncElLu4
	mPzlN7hpM7k4mNyjghud9Jeuv6WrIe94R2M3ADUxsuJOMX6wybLGlvzjzMqWR5j2
	DOJtkYcJ7CtX+Oy91Y0Qbd5W6byrrAOQHk+wB6FjEblvOsk1vJdpMS8unvRCASk1
	lwvp9xqpmX+fzcbzp9YLa3TQBYPhMGCIMqS7yHNdf4LaWnuA4t3EzBidpcodIUiQ
	tuaNEjatBV0YqwxAnUz/E9kVjY1UihqMK3V2ThopHpn6ZjwwdJwvVLPbECWaVv+K
	X6PTz8x1wzR2bkR/0Gq8HLIJqAkcv+2HBGQRQ+O2PQ6htH5oZUccPc6/vBiro/jo
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 491h0m29xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 03:36:12 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5887aBDA036472
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Sep 2025 03:36:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 03:36:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 03:36:11 -0400
Received: from Ubuntu.ad.analog.com ([10.132.255.227])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5887ZpEh004718;
	Mon, 8 Sep 2025 03:36:04 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 5/6] docs: iio: add documentation for ade9000 driver
Date: Mon, 8 Sep 2025 07:35:25 +0000
Message-ID: <20250908073531.3639-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908073531.3639-1-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: b53jOJ34ymfK1B6A0rnuOPSNL39_Xn3j
X-Proofpoint-GUID: b53jOJ34ymfK1B6A0rnuOPSNL39_Xn3j
X-Authority-Analysis: v=2.4 cv=MKFgmNZl c=1 sm=1 tr=0 ts=68be876c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=jBZNeLu39LLBpTe4D9EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDIxMiBTYWx0ZWRfX/mwkPsfQTR34
 DKE+8EfJwLYrl1STz2ZCsb2Ys9aFkNgHdAcqM//12dk1LJGDm4Ss7pj5Uasquyvz66yy3038mgt
 VJ0rP0718GgP1G7zP5o7wrgJ6KO5ezlDsN8KaHT8I/KxfqAlknTNb0fLguTwl/VbOCDeLzrJ6Zt
 18fx4UKK/xln2RPKiE+70pGpjia7HTkiNi2QzJ2MfFgGPhwV89O0gaEn2VqVMgdBo5PFwm6R67q
 mYb0RpQmi75hxfFItbv/lOahTAmoSBr+3MiszTFiUGplVT9hxqFQSmD7hSDoHjN1pPWQQ29oay6
 DltA47ZZcS57ZCOIWMPaJNulxjmFF7ZkVlkOruBnf44YVu0yrgSBA/MLD8lJf5jSG5D62aeyzXG
 /viIpF+z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509070212

Add documentation for ade9000 driver which describes the driver
device files and shows how the user may use the ABI for various
scenarios (configuration, measurement, etc.).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - remove PGA gain documentation section
 - remove frequency configuration section
 - remove scale and frequency attributes from device-level attributes table
 - update examples to remove PGA gain and frequency configuration
 Documentation/iio/ade9000.rst | 265 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 266 insertions(+)
 create mode 100644 Documentation/iio/ade9000.rst

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
new file mode 100644
index 000000000000..163d36a56be3
--- /dev/null
+++ b/Documentation/iio/ade9000.rst
@@ -0,0 +1,265 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ADE9000 driver
+===============
+
+This driver supports Analog Device's ADE9000 energy measurement IC on SPI bus.
+
+1. Supported devices
+====================
+
+* `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
+
+The ADE9000 is a highly accurate, fully integrated, multiphase energy and power
+quality monitoring device. Superior analog performance and a digital signal
+processing (DSP) core enable accurate energy monitoring over a wide dynamic
+range. An integrated high end reference ensures low drift over temperature
+with a combined drift of less than ±25 ppm/°C maximum for the entire channel
+including a programmable gain amplifier (PGA) and an analog-to-digital
+converter (ADC).
+
+2. Device attributes
+====================
+
+Power and energy measurements are provided for voltage, current, active power,
+reactive power, apparent power, and power factor across three phases.
+
+Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+where X is the IIO index of the device. Under these folders reside a set of
+device files, depending on the characteristics and features of the hardware
+device in question. These files are consistently generalized and documented in
+the IIO ABI documentation.
+
+The following tables show the ADE9000 related device files, found in the
+specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
+
++---------------------------------------------------+----------------------------------------------------------+
+| Current measurement related device files          | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_current[0-2]_raw                               | Raw current measurement for phases A, B, C.              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_current[0-2]_scale                             | Scale for current channels.                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_current[0-2]_calibscale                        | Calibration gain for current channels (AIGAIN reg).      |
+| in_altcurrent[0-2]_rms_raw                        | RMS current measurement for phases A, B, C.              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altcurrent[0-2]_rms_scale                      | Scale for RMS current channels.                          |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altcurrent[0-2]_rms_calibbias                  | RMS offset correction for current channels (IRMSOS reg). |
++---------------------------------------------------+----------------------------------------------------------+
+
++---------------------------------------------------+----------------------------------------------------------+
+| Voltage measurement related device files          | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage[0-2]_raw                               | Raw voltage measurement for phases A, B, C.              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage[0-2]_scale                             | Scale for voltage channels.                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage[0-2]_calibscale                        | Calibration gain for voltage channels (AVGAIN reg).      |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage[0-2]_frequency                         | Measured line frequency from instantaneous voltage.      |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_raw                        | RMS voltage measurement for phases A, B, C.              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_scale                      | Scale for RMS voltage channels.                          |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_calibbias                  | RMS offset correction for voltage channels (VRMSOS reg). |
++---------------------------------------------------+----------------------------------------------------------+
+
++---------------------------------------------------+----------------------------------------------------------+
+| Power measurement related device files            | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_active_raw                          | Active power measurement for phases A, B, C.             |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_active_scale                        | Scale for active power channels.                         |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_active_calibbias                    | Calibration offset for active power (xWATTOS regs).      |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_active_calibscale                   | Calibration gain for active power (APGAIN reg).          |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_reactive_raw                        | Reactive power measurement for phases A, B, C.           |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_reactive_scale                      | Scale for reactive power channels.                       |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_reactive_calibbias                  | Calibration offset for reactive power (xVAROS regs).     |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_apparent_raw                        | Apparent power measurement for phases A, B, C.           |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_apparent_scale                      | Scale for apparent power channels.                       |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_powerfactor                         | Power factor for phases A, B, C.                         |
++---------------------------------------------------+----------------------------------------------------------+
+
++---------------------------------------------------+----------------------------------------------------------+
+| Energy measurement related device files           | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_energy[0-2]_active_raw                         | Active energy measurement for phases A, B, C.            |
++---------------------------------------------------+----------------------------------------------------------+
+| in_energy[0-2]_reactive_raw                       | Reactive energy measurement for phases A, B, C.          |
++---------------------------------------------------+----------------------------------------------------------+
+| in_energy[0-2]_apparent_raw                       | Apparent energy measurement for phases A, B, C.          |
++---------------------------------------------------+----------------------------------------------------------+
+
++------------------------------+------------------------------------------------------------------+
+| Shared device attributes     | Description                                                      |
++------------------------------+------------------------------------------------------------------+
+| name                         | Name of the IIO device.                                          |
++------------------------------+------------------------------------------------------------------+
+| filter_type                  | Waveform buffer filter type (sinc4, sinc4+lp).                   |
++------------------------------+------------------------------------------------------------------+
+| filter_type_available        | Available filter types for waveform buffer.                      |
++------------------------------+------------------------------------------------------------------+
+
+3. Calibration and scaling
+===========================
+
+The ADE9000 provides multiple levels of gain and offset correction:
+
+**Calibration Gain (per-channel)**
+  Fine-tuning calibration gains applied in the digital domain for each channel type.
+  Controlled via ``calibscale`` attributes (AIGAIN, AVGAIN, APGAIN registers).
+
+**Calibration Bias (per-channel)**
+  Hardware calibration offsets applied by the device internally:
+
+  - Power measurements: Controlled via ``calibbias`` attributes for power channels (xWATTOS, xVAROS registers).
+  - RMS measurements: Controlled via ``calibbias`` attributes for RMS channels (IRMSOS, VRMSOS registers).
+
+  These are internal chip calibrations, not userspace-applied offsets.
+
+4. Event attributes
+===================
+
+The ADE9000 provides various interrupts that are mapped to IIO events.
+Event functionality is only available if the corresponding interrupts are
+connected in the device tree.
+
++---------------------------------------------------+----------------------------------------------------------+
+| IIO Event Attribute                               | ADE9000 Datasheet Equivalent                             |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage[0-2]_thresh_either_en                  | Zero crossing detection interrupt (ZXVx)                 |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_thresh_rising_en           | RMS swell detection interrupt (SWELLx)                   |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_thresh_rising_value        | RMS swell threshold (SWELL_LVL register)                 |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_thresh_falling_en          | RMS sag/dip detection interrupt (DIPx)                   |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_thresh_falling_value       | RMS sag/dip threshold (DIP_LVL register)                 |
++---------------------------------------------------+----------------------------------------------------------+
+| in_current[0-2]_thresh_either_en                  | Current zero crossing detection interrupt (ZXIx)         |
++---------------------------------------------------+----------------------------------------------------------+
+
+Event directions:
+- ``rising``: Upper threshold crossing (swell detection)
+- ``falling``: Lower threshold crossing (sag/dip detection)
+- ``either``: Any threshold crossing (zero crossing detection)
+- ``none``: Timeout or non-directional events
+
+**Note**: Event attributes are only available if the corresponding interrupts
+(irq0, irq1, dready) are specified in the device tree. The driver works without
+interrupts but with reduced functionality.
+
+5. Device buffers
+=================
+
+This driver supports IIO buffers for waveform capture. Buffer functionality
+requires the dready interrupt to be connected.
+
+The device supports capturing voltage and current waveforms for power quality
+analysis. The waveform buffer can be configured to capture data from different
+channel combinations.
+
+Supported channel combinations for buffered capture:
+- Phase A: voltage and current (IA + VA)
+- Phase B: voltage and current (IB + VB)
+- Phase C: voltage and current (IC + VC)
+- All phases: all voltage and current channels
+- Individual channels: IA, VA, IB, VB, IC, VC
+
+Usage examples
+--------------
+
+Enable waveform capture for Phase A:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_current0_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_voltage0_en
+
+Set buffer length and enable:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 100 > buffer/length
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > buffer/enable
+
+6. Clock output
+===============
+
+The ADE9000 can provide a clock output via the CLKOUT pin when using an external
+crystal/clock source. This feature is enabled by specifying ``#clock-cells = <0>``
+in the device tree. The output clock will be registered as "clkout" and can be
+referenced by other devices.
+
+7. Usage examples
+=================
+
+Show device name:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat name
+        ade9000
+
+Read voltage measurements:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_voltage0_raw
+        12345
+        root:/sys/bus/iio/devices/iio:device0> cat in_voltage0_scale
+        0.000030517
+
+- Phase A voltage = in_voltage0_raw * in_voltage0_scale = 0.3769 V
+
+Read power measurements:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_power0_active_raw
+        5678
+        root:/sys/bus/iio/devices/iio:device0> cat in_power0_scale
+        0.000244140
+
+- Phase A active power = in_power0_active_raw * in_power0_scale = 1.386 W
+
+Configure calibration gains:
+
+.. code-block:: bash
+
+        # Set current channel 0 calibration gain
+        root:/sys/bus/iio/devices/iio:device0> echo 0x800000 > in_current0_calibscale
+        # Set voltage channel 0 calibration gain
+        root:/sys/bus/iio/devices/iio:device0> echo 0x7FFFFF > in_voltage0_calibscale
+
+Configure RMS voltage event thresholds (requires interrupts):
+
+.. code-block:: bash
+
+        # Set RMS sag detection threshold
+        root:/sys/bus/iio/devices/iio:device0> echo 180000 > events/in_altvoltage0_rms_thresh_falling_value
+        # Enable RMS sag detection
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_altvoltage0_rms_thresh_falling_en
+
+        # Set RMS swell detection threshold
+        root:/sys/bus/iio/devices/iio:device0> echo 260000 > events/in_altvoltage0_rms_thresh_rising_value
+        # Enable RMS swell detection
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_altvoltage0_rms_thresh_rising_en
+
+8. IIO Interfacing Tools
+========================
+
+See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+interfacing tools.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index c106402a91f7..792c815286f4 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -28,6 +28,7 @@ Industrial I/O Kernel Drivers
    ad7606
    ad7625
    ad7944
+   ade9000
    adis16475
    adis16480
    adis16550
-- 
2.43.0


