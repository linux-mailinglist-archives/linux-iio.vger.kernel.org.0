Return-Path: <linux-iio+bounces-23156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C795B32026
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872149E39C5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F1285C91;
	Fri, 22 Aug 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PC6Y/Ye7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAD280014;
	Fri, 22 Aug 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878558; cv=none; b=nYZ0UOJgcD5mk6qczmRcQf9aTbpv+Br2oBUGtWU/gx1fKcQ2DSldJJFr2xHKRaabVJJ8cXh5cXU74/sFD9sHHhJjCmBaaw9gKTFLjAiAJKMobb0DTQac436ZFi9fOzWC9mcHfgQ5g+Tiw4BJUK5BfbW5SWMbMeZhXc47OJa8je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878558; c=relaxed/simple;
	bh=SQbiB8uO8628rxzOTyRua8rtuPwWT9plWJGuCVe9VHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ylh36dZm72BTKo+KEF8WJq8YzxRQIPW+cForrdjno5MQ6ntrdxCcksysnPr9XhVBuu8BI2Rl6DFQRwJBpBj2gxLctWbo4wHgCe3uVzSvoPg5tx5vUWwex+3yzJXgn17PC0FJNszR7fMWIuNnCmvnRcc9n2thHhp1FQVKRL+ZxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PC6Y/Ye7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MENmHT023389;
	Fri, 22 Aug 2025 12:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fgh5F
	3qIah2mCV7tWs6yuuwic/sSKDNJ77mR7gFa/Lg=; b=PC6Y/Ye7GrW1v29x9jQFL
	612NpEFk/7iIwGTS0I3dtgVjYrmAb95M32iQwkvCEE3mczGASM2Xbrz4l4PJAuYb
	FtQG83aG//hJ56749L/nqv/7G5H9LX/+3NxTr6lkw+Z4Z40xA8YTm0j3yIKT6s5o
	z+mTMJYx02HPrVYEFvioidginnsyGGgy8fOZg4ImR7R/fmyYujBoEznVRQnT/vF/
	sHTtM+XULyrddiAvkdSqkDyblTxD/zIefjECHEw3CCxAJuX/RkcUu+icTSEKnnFT
	qz9OLR/Vdr+W/mPCEwCDDW//3NPxWZn81FlZ+CZRAxaQq2FWoA8JmFZE5muTUef2
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48ppn3sgmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:02:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57MG2PMR058866
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Aug 2025 12:02:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 Aug 2025 12:02:24 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57MG263Q000568;
	Fri, 22 Aug 2025 12:02:18 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 5/6] docs: iio: add documentation for ade9000 driver
Date: Fri, 22 Aug 2025 16:01:54 +0000
Message-ID: <20250822160157.5092-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822160157.5092-1-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDA5NiBTYWx0ZWRfXxXSo8AYQVRzq
 nMIs+RUGMSfgDnMMWfoqfzO3yFreWoATstmYNcVTCsp1BdFUlHZJuoBXVk+A/NBLgrFwnfIoQWQ
 sKhiGKbI3YrQa9/j9rw8SjE2wT+HjN9h4ce9ULHDEW4d4CAygpB/CIQ5z45g4R6yU+i+Waa3qru
 3dQmOlFiNdMHHM71m4Z3BIGZjkGd+uoehmFniu5LNL76MVSf9k1TBWxdLR8nzURM6zbPfbdYUsH
 I8UrPVKThh+tNOdciIHNsH1mmgzpLkjJA5i1/pWbm+y/bcz+hJ6mTdt3SM5CBWU2gqNXmgUQsK2
 7eTrQ3bWhRcPQgm9g8O6mhK8Y23zquD7TrbK50UT3uhluHobx8KIhpCPwJI+8yFsh+fA/XVd5xt
 nJKzvopAHLPU1A2NhhKhIAsGVVuN9w==
X-Authority-Analysis: v=2.4 cv=frWFpF4f c=1 sm=1 tr=0 ts=68a89492 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=2qi_iXrO6zYP4lLD778A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: jeS5JDanRh8EnTzgBZtm2_NIE5rFOeys
X-Proofpoint-ORIG-GUID: jeS5JDanRh8EnTzgBZtm2_NIE5rFOeys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508220096

Add documentation for ade9000 driver which describes the driver
device files and shows how the user may use the ABI for various
scenarios (configuration, measurement, etc.).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/iio/ade9000.rst | 286 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 287 insertions(+)
 create mode 100644 Documentation/iio/ade9000.rst

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
new file mode 100644
index 000000000000..fcb4a36c0282
--- /dev/null
+++ b/Documentation/iio/ade9000.rst
@@ -0,0 +1,286 @@
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
++---------------------------------------------------+----------------------------------------------------------+
+| in_current[0-2]_offset                            | Offset correction for current channels (IRMSOS reg).     |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altcurrent[0-2]_rms_raw                        | RMS current measurement for phases A, B, C.              |
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
+| in_voltage[0-2]_offset                            | Offset correction for voltage channels (VRMSOS reg).     |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage[0-2]_frequency                         | Measured line frequency for phases A, B, C.              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_altvoltage[0-2]_rms_raw                        | RMS voltage measurement for phases A, B, C.              |
++---------------------------------------------------+----------------------------------------------------------+
+
++---------------------------------------------------+----------------------------------------------------------+
+| Power measurement related device files            | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_raw                                 | Raw active power measurement for phases A, B, C.         |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_active_raw                          | Active power measurement for phases A, B, C.             |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_reactive_raw                        | Reactive power measurement for phases A, B, C.           |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_apparent_raw                        | Apparent power measurement for phases A, B, C.           |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_powerfactor                         | Power factor for phases A, B, C.                         |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_scale                               | Scale for power channels.                                |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_calibscale                          | Calibration gain for power channels (APGAIN reg).        |
++---------------------------------------------------+----------------------------------------------------------+
+| in_power[0-2]_calibbias                           | Calibration offset for power channels (xWATTOS regs).    |
++---------------------------------------------------+----------------------------------------------------------+
+
++---------------------------------------------------+----------------------------------------------------------+
+| Energy measurement related device files           | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_energy[0-2]_raw                                | Raw energy measurement for phases A, B, C.               |
++---------------------------------------------------+----------------------------------------------------------+
+| in_energy[0-2]_scale                              | Scale for energy channels.                               |
++---------------------------------------------------+----------------------------------------------------------+
+
++------------------------------+------------------------------------------------------------------+
+| Shared device attributes     | Description                                                      |
++------------------------------+------------------------------------------------------------------+
+| name                         | Name of the IIO device.                                          |
++------------------------------+------------------------------------------------------------------+
+| frequency                    | System line frequency configuration (50Hz/60Hz).                |
++------------------------------+------------------------------------------------------------------+
+| scale                        | Shared PGA gain setting (1x, 2x, 4x) affecting all channels.   |
++------------------------------+------------------------------------------------------------------+
+
+3. Calibration and scaling
+===========================
+
+The ADE9000 provides multiple levels of gain and offset correction:
+
+**PGA Gain (shared)**
+  The programmable gain amplifier affects the analog input stage for all channels.
+  Controlled via the shared ``scale`` attribute with values 1, 2, or 4.
+
+**Calibration Gain (per-channel)**
+  Fine-tuning calibration gains applied in the digital domain for each channel type.
+  Controlled via ``calibscale`` attributes (AIGAIN, AVGAIN, APGAIN registers).
+
+**Calibration Offset (per-channel)**
+  Hardware calibration offsets applied by the device for power measurements.
+  Controlled via ``calibbias`` attributes for power channels.
+
+**Correction Offsets (per-channel)**
+  RMS offset corrections for current and voltage measurements.
+  Controlled via ``offset`` attributes (IRMSOS, VRMSOS registers).
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
+| in_voltage0_thresh_either_en                      | Zero crossing detection interrupt (ZXVA)                 |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage0_thresh_rising_en                      | Swell detection interrupt (SWELLA)                       |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage0_thresh_falling_en                     | Sag/dip detection interrupt (DIPA)                       |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage0_thresh_none_en                        | Zero crossing timeout interrupt (ZXTOVA)                 |
++---------------------------------------------------+----------------------------------------------------------+
+| events_mag_none_en                                | Energy ready interrupt (EGYRDY)                          |
++---------------------------------------------------+----------------------------------------------------------+
+| events_change_none_en                             | Sequence error interrupt (SEQERR)                        |
++---------------------------------------------------+----------------------------------------------------------+
+| events_thresh_none_value                          | Zero crossing timeout threshold (ZXTOUT register)        |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage0_thresh_falling_value                  | Sag/dip threshold (DIP_LVL register)                     |
++---------------------------------------------------+----------------------------------------------------------+
+| in_voltage0_thresh_rising_value                   | Swell threshold (SWELL_LVL register)                     |
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
+Configure PGA gain (affects all channels):
+
+.. code-block:: bash
+
+        # Set PGA gain to 2x
+        root:/sys/bus/iio/devices/iio:device0> echo 2 > scale
+        # Read current gain setting
+        root:/sys/bus/iio/devices/iio:device0> cat scale
+        2
+
+Configure line frequency:
+
+.. code-block:: bash
+
+        # Set to 60Hz operation
+        root:/sys/bus/iio/devices/iio:device0> echo 60 > frequency
+        # Read current frequency setting
+        root:/sys/bus/iio/devices/iio:device0> cat frequency
+        60
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
+Configure voltage event thresholds (requires interrupts):
+
+.. code-block:: bash
+
+        # Set sag detection threshold
+        root:/sys/bus/iio/devices/iio:device0> echo 180000 > events/in_voltage0_thresh_falling_value
+        # Enable sag detection
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_voltage0_thresh_falling_en
+
+        # Set swell detection threshold
+        root:/sys/bus/iio/devices/iio:device0> echo 260000 > events/in_voltage0_thresh_rising_value
+        # Enable swell detection
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_voltage0_thresh_rising_en
+
+8. IIO Interfacing Tools
+========================
+
+See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+interfacing tools.
\ No newline at end of file
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


