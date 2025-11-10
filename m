Return-Path: <linux-iio+bounces-26144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B3C47ADC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C44188175C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219D2749E4;
	Mon, 10 Nov 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABtXqFWL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2B199939;
	Mon, 10 Nov 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789530; cv=none; b=DG3FyOSRJLEpzXq2wW1MMxnSIwD9rhcvCu4vy4VPLM/H5bP3mGYGWHHVxZBo152nNim73vISKZwN2YAqYegY2XmDcEiFAW7vdOZyxlOGlmpheDTP0MrQxv+9VPs/Jc5PrnYyNr/N6TdBE8dOcVRaY0qoUAHqFDWrYOXlFp6X5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789530; c=relaxed/simple;
	bh=2n36zq1CxHrYLfPgKy50ZPY3hod8lrNllZ/6mW3AS/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YeK6QHk5GVrpbUPI5LKMnIeCrOdQ94sdmwbJCDXY8gKY+fx8nCk/amACcAgV1GPMJkRllb3fLFvZZKTbyOk0S8pKD5WE0+m6LuZZfysfulubW6Ztq8eyQ0lR0mHSP+lmJh/SBZRFNezAAK9dljtmwUig05gaTdjJmBQFog4uCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABtXqFWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F38F6C2BCAF;
	Mon, 10 Nov 2025 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789530;
	bh=2n36zq1CxHrYLfPgKy50ZPY3hod8lrNllZ/6mW3AS/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ABtXqFWLkKafcoMC9uW9uYNCDV9h73o8B00NlE0e8EhGoac0uxsOgSu6HNVvIZ02P
	 F70V2VfHNHwV+jv7ZMZG12g6F4Vyp3+7Tv9exd1ZzOrYzmsq5Whw7+sWWXgYzdLrMn
	 t6NYBSJKtp//5Gi7pNWNTlV857ki2wEmSIp7iihek/Sgk2YpAU7X9T/3rHPI00hXR6
	 uYh+NPo4knrgIX7+oUYilzN/5Jn9kazScE8/nlCOn9Mf8OaLmalyTJ8tq06N9Ip4Fx
	 wIrLbnzCsjZUM/GohhjS4u4VEQkztmSOHG1wZI2Y6nWg9cDtIwtAazvCpW2EbGyJe7
	 MBUTQZDiTJ6Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C3CCF9E3;
	Mon, 10 Nov 2025 15:45:29 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 10 Nov 2025 15:44:46 +0000
Subject: [PATCH 3/3] docs: iio: add documentation for adf41513 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-adf41513-iio-driver-v1-3-2df8be0fdc6e@analog.com>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
In-Reply-To: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762789528; l=14078;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=CEa06klTzZWnce6W7y6zRpHzUOeheQBfElqFjN0BVzI=;
 b=iC9yExOVFcygBYJh3TAf6aNBHoT5k7tZiO6SmiaFu1LpccECSfgw9+9b6OGgZfOAWJScpcQRT
 dcgqjr6BLvPAqHxQ0oeY10AwVW79fdySIxct3NWJN31FIfozidu424u
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

add documentation for adf41513 driver which describes the device
driver files and shows how userspace may consume the ABI for various
tasks

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/iio/adf41513.rst | 377 +++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst    |   1 +
 MAINTAINERS                    |   1 +
 3 files changed, 379 insertions(+)

diff --git a/Documentation/iio/adf41513.rst b/Documentation/iio/adf41513.rst
new file mode 100644
index 000000000000..a2d5425d49c9
--- /dev/null
+++ b/Documentation/iio/adf41513.rst
@@ -0,0 +1,377 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ADF41513 driver
+===============
+
+This driver supports Analog Devices' ADF41513 and ADF41510 PLL frequency
+synthesizers on SPI bus.
+
+1. Supported devices
+====================
+
+* `ADF41510 <https://www.analog.com/ADF41510>`_
+* `ADF41513 <https://www.analog.com/ADF41513>`_
+
+The ADF41513 is an ultralow noise frequency synthesizer that can be used to
+implement local oscillators (LOs) as high as 26.5 GHz in the upconversion and
+downconversion sections of wireless receivers and transmitters. The ADF41510
+is a similar device that supports frequencies up to 10 GHz.
+
+Both devices support integer-N and fractional-N operation modes, providing
+excellent phase noise performance and flexible frequency generation
+capabilities.
+
+Key Features:
+
+- **ADF41513**: 1 GHz to 26.5 GHz frequency range
+- **ADF41510**: 1 GHz to 10 GHz frequency range
+- Integer-N and fractional-N operation modes
+- Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-N)
+- High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
+- 25-bit fixed modulus or 49-bit variable modulus fractional modes
+- Programmable charge pump currents with 16x range
+- Digital lock detect functionality
+- Phase resync capability for consistent output phase
+- Clock framework integration for system clock generation
+
+2. Device attributes
+====================
+
+The ADF41513 driver provides the following IIO extended attributes for
+frequency control and monitoring:
+
+Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+where X is the IIO index of the device. Under these folders reside a set of
+device files that provide access to the synthesizer's functionality.
+
+The following table shows the ADF41513 related device files:
+
++----------------------+-------------------------------------------------------+
+| Device file          | Description                                           |
++======================+=======================================================+
+| frequency            | RF output frequency control and readback (Hz)         |
++----------------------+-------------------------------------------------------+
+| frequency_resolution | Target frequency resolution control (Hz)              |
++----------------------+-------------------------------------------------------+
+| refin_frequency      | Reference input frequency control and readback (Hz)   |
++----------------------+-------------------------------------------------------+
+| powerdown            | Power management control (0=active, 1=power down)     |
++----------------------+-------------------------------------------------------+
+
+2.1 Frequency Control
+----------------------
+
+The ``frequency`` attribute controls the RF output frequency with sub-Hz precision.
+The driver automatically selects between integer-N and fractional-N modes to
+achieve the requested frequency with the best possible phase noise performance.
+
+**Supported ranges:**
+
+- **ADF41513**: 1,000,000,000 Hz to 26,500,000,000 Hz (1 GHz to 26.5 GHz)
+- **ADF41510**: 1,000,000,000 Hz to 10,000,000,000 Hz (1 GHz to 10 GHz)
+
+The frequency is specified in Hz, for sub-Hz precision use decimal notation.
+For example, 12.102000000 GHz would be written as "12102000000.000000".
+
+2.2 Frequency Resolution Control
+--------------------------------
+
+The ``frequency_resolution`` attribute controls the target frequency resolution
+that the driver attempts to achieve. This affects the choice between fixed
+modulus (25-bit) and variable modulus (49-bit) fractional-N modes:
+
+- **Fixed modulus**: Resolution = f_PFD / 2^25 (typically ~3 Hz with 100 MHz PFD)
+- **Variable modulus**: Resolution = f_PFD / 2^49 (µHz resolution possible)
+
+Default resolution is 1 Hz (1,000,000 µHz).
+
+2.3 Reference Input Control
+---------------------------
+
+The ``refin_frequency`` attribute allows control of the reference input frequency
+when using a programmable reference clock. The supported range is 10 MHz to
+800 MHz.
+
+2.4 Power Management
+--------------------
+
+The ``powerdown`` attribute provides software power control:
+
+- **0**: Device active and operational
+- **1**: Device in power-down mode (low power consumption)
+
+3. Operating modes
+==================
+
+3.1 Integer-N Mode
+------------------
+
+When the requested frequency can be achieved as an integer multiple of the PFD
+frequency (within the specified resolution tolerance), the driver automatically
+selects integer-N mode for optimal phase noise performance.
+
+In integer-N mode:
+
+- Phase noise: -235 dBc/Hz normalized floor
+- Frequency resolution: f_PFD (same as PFD frequency)
+- Maximum PFD frequency: 250 MHz
+- Bleed current: Disabled for best performance
+
+3.2 Fractional-N Mode
+---------------------
+
+When sub-integer frequency steps are required, the driver automatically selects
+fractional-N mode using either fixed or variable modulus.
+
+**Fixed Modulus (25-bit)**:
+
+- Used when variable modulus is not required
+- Resolution: f_PFD / 2^25
+- Simpler implementation, faster settling
+
+**Variable Modulus (49-bit)**:
+
+- Used for maximum resolution requirements
+- Resolution: f_PFD / 2^49 (theoretical)
+- Exact frequency synthesis capability
+
+In fractional-N mode:
+
+- Phase noise: -231 dBc/Hz normalized floor
+- Maximum PFD frequency: 125 MHz
+- Bleed current: Automatically enabled and optimized
+- Dithering: Enabled to reduce fractional spurs
+
+3.3 Automatic Mode Selection
+----------------------------
+
+The driver automatically selects the optimal operating mode based on:
+
+1. **Frequency accuracy requirements**: Determined by frequency_resolution setting
+2. **Phase noise optimization**: Integer-N preferred when possible
+3. **PFD frequency constraints**: Different limits for integer vs fractional modes
+4. **Prescaler selection**: Automatic 4/5 vs 8/9 prescaler selection based on frequency
+
+4. Clock framework integration
+==============================
+
+The ADF41513 driver integrates with the Linux Common Clock Framework (CCF) when
+the device tree includes clock provider properties (``#clock-cells = <0>``).
+
+When enabled, the driver registers as a clock provider, allowing other kernel
+drivers to use the synthesizer output as a system clock source.
+
+**Device tree configuration for clock provider**:
+
+.. code-block:: dts
+
+    adf41513@0 {
+        compatible = "adi,adf41513";
+        reg = <0>;
+        /* ... other properties ... */
+        #clock-cells = <0>;
+        clock-output-names = "adf41513_clk";
+    };
+
+**Clock consumer example**:
+
+.. code-block:: dts
+
+    some_device {
+        clocks = <&adf41513>;
+        clock-names = "ref_clk";
+    };
+
+5. Device tree configuration
+============================
+
+See ``Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml`` for
+complete device tree binding documentation.
+
+**Basic configuration example**:
+
+.. code-block:: dts
+
+    adf41513@0 {
+        compatible = "adi,adf41513";
+        reg = <0>;
+        spi-max-frequency = <10000000>;
+        clocks = <&ref_clk>;
+        clock-names = "clkin";
+        vcc-supply = <&vcc_3v3>;
+
+        adi,power-up-frequency = /bits/ 64 <12000000000>;
+    };
+
+6. Performance characteristics
+==============================
+
+6.1 Phase Noise Performance
+----------------------------
+
+The ADF41513 provides excellent phase noise performance:
+
+**Integer-N mode**:
+
+- Normalized phase noise floor: -235 dBc/Hz
+- 1/f noise corner: Typically around 10 kHz offset
+- Best performance mode for integer frequency multiples
+
+**Fractional-N mode**:
+
+- Normalized phase noise floor: -231 dBc/Hz
+- Additional fractional spurs may be present
+- Optimized with automatic bleed current and dithering
+
+6.2 Frequency Ranges and Prescalers
+------------------------------------
+
+The driver automatically selects the appropriate prescaler based on frequency:
+
+**4/5 Prescaler**:
+
+- RF frequency range: 1 GHz to 16 GHz
+- Integer-N: N = 20 to 511
+- Fractional-N: N = 23 to 511
+
+**8/9 Prescaler** (ADF41513 only):
+
+- RF frequency range: 1 GHz to 26.5 GHz
+- Integer-N: N = 64 to 1023
+- Fractional-N: N = 75 to 1023
+
+6.3 Reference Input Requirements
+---------------------------------
+
+- Frequency range: 10 MHz to 800 MHz
+- Input sensitivity: -10 dBm to +8 dBm
+- Slew rate requirement: >320 V/µs (>500 V/µs recommended)
+- With doubler enabled: Maximum 225 MHz reference frequency
+
+7. Usage examples
+=================
+
+7.1 Basic Frequency Setting
+----------------------------
+
+Set output frequency to 12.102 GHz:
+
+.. code-block:: bash
+
+    root:/sys/bus/iio/devices/iio:device0> echo 12102000000 > out_altvoltage0_frequency
+
+Read current frequency:
+
+.. code-block:: bash
+
+    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_frequency
+    12101999999.582767
+
+7.2 High Resolution Frequency Control
+-------------------------------------
+
+Configure for sub-Hz resolution and set a precise frequency:
+
+.. code-block:: bash
+
+    # Set resolution to 0.1 Hz (100,000 µHz)
+    root:/sys/bus/iio/devices/iio:device0> echo 0.1 > out_altvoltage0_frequency_resolution
+
+    # Set frequency to 12.102 GHz (1 µHz precision)
+    root:/sys/bus/iio/devices/iio:device0> echo 12102000000 > out_altvoltage0_frequency
+    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_frequency
+    12101999999.980131
+
+7.3 Reference Frequency Control
+-------------------------------
+
+Change reference input frequency (if using programmable reference):
+
+.. code-block:: bash
+
+    # Set reference to 122.88 MHz
+    root:/sys/bus/iio/devices/iio:device0> echo 122880000 > out_altvoltage0_refin_frequency
+
+    # Verify the change
+    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_refin_frequency
+    122880000
+
+7.4 Power Management
+--------------------
+
+Power down the device:
+
+.. code-block:: bash
+
+    root:/sys/bus/iio/devices/iio:device0> echo 1 > out_altvoltage0_powerdown
+
+    # Power back up
+    root:/sys/bus/iio/devices/iio:device0> echo 0 > out_altvoltage0_powerdown
+
+7.5 Monitor Lock Status
+-----------------------
+
+When lock detect GPIO is configured, check if PLL is locked:
+
+.. code-block:: bash
+
+    # Read frequency - will return error if not locked
+    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_frequency
+
+If the PLL is not locked, the frequency read will return ``-EBUSY`` (Device or resource busy).
+
+8. Advanced features
+====================
+
+8.1 Phase Resync
+-----------------
+
+When enabled in device tree (``adi,phase-resync-enable``), the phase resync
+feature provides a consistent output phase relationship to the reference input.
+This is particularly useful for beamforming applications where phase coherence
+across multiple synthesizers is required.
+
+8.2 Charge Pump Optimization
+-----------------------------
+
+The driver automatically optimizes charge pump settings:
+
+- **Current**: Programmable from 0.45 mA to 7.2 mA
+- **Bleed current**: Automatically calculated and enabled in fractional-N mode
+- **Loop filter integration**: Works with external passive loop filters
+
+8.3 Spurious Performance
+------------------------
+
+The driver includes automatic spur reduction techniques:
+
+- **Integer boundary spur avoidance**: Automatic PFD frequency optimization
+- **Fractional spur reduction**: Automatic dithering and bleed current
+- **Reference spur suppression**: High PFD frequency operation when possible
+
+9. Troubleshooting
+==================
+
+9.1 Common Issues
+-----------------
+
+**"PLL un-locked" errors**:
+
+- Check reference input signal quality and level
+- Verify loop filter design matches charge pump current
+- Ensure VCO tuning range covers target frequency
+- Check power supply voltage and stability
+
+**Frequency accuracy issues**:
+
+- Verify reference frequency accuracy
+- Check frequency_resolution setting
+- Ensure target frequency is within device range
+
+**High spurious content**:
+
+- Verify PCB layout follows ADI recommendations
+- Check loop filter component values and quality
+- Ensure adequate power supply decoupling
+- Verify reference input signal purity
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 315ae37d6fd4..420669af60db 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -29,6 +29,7 @@ Industrial I/O Kernel Drivers
    ad7625
    ad7944
    ade9000
+   adf41513
    adis16475
    adis16480
    adis16550
diff --git a/MAINTAINERS b/MAINTAINERS
index 1bbcff826238..833020f01c3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1607,6 +1607,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
+F:	Documentation/iio/adf41513.rst
 F:	drivers/iio/frequency/adf41513.c
 
 ANALOG DEVICES INC ADF4377 DRIVER

-- 
2.43.0



