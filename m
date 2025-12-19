Return-Path: <linux-iio+bounces-27194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A670CCFE52
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8ED313C03C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557C346E58;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X11OMwN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE3346A15;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147694; cv=none; b=tOZZkao4BIzj6j2LOZCHBn51LUjG66friv5XH/V7ZLNasqwka/u7v8DUrUdp9rSPrm8N0uqE4lwSJNhB5sKP0aMDCzOOQoC/yHTTF2dEpnvHcfOFzXsBZw3q1vwHTmbStSi2GUNkDvBeUuWbgdfvolbD0HIS/f+wa/Zt5B1WcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147694; c=relaxed/simple;
	bh=DXqWeIEG6n/3cXXnnGHvEZOBg75yuXC3Um+51x62L+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MciDhdR1h/QXwaUWVrNSA6JceSRCFB9Cr/frJaaCwwhvTZmTI7MprOIILVqaZm5fMHTPmS0jzHFtj8s98WGVDLuld1scSUIH5Njs4DvxPao6u8R/AvTF58eOgbwtoRxG+d5xwOAIjkpbWB+ZmozcuVNz7lbCNQXmClSGfNBAQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X11OMwN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE3C5C2BC87;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766147694;
	bh=DXqWeIEG6n/3cXXnnGHvEZOBg75yuXC3Um+51x62L+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X11OMwN/U6iPcNW+1AeCd8/u0Z5fxxV+G8ku8OBR5kOzrPWRZVuVf3nLR6ueqG5IF
	 3HfV8lFhG1pTv4EKAOzs9JySFg/dMaJ/xMP/Xy7B4Byh4Sv9ywbnCwS0LiHG//7wjC
	 8ftRcj07MSS0rGFSPfcaVQISaj3YHA8AK+zTkMC4NXEUO5ulUdC0ZfpjmFvQUpTFTp
	 +6D/IAd9pavlasWxAVn02ayfqS/EIpNxAji1JSt/0OjBesP8TJd5Jcs4V6CBQwfNNM
	 vR0cH7k9lLHpudlkNACELaTNJ3xk1f/GFvHkBil1Q2X4Yk35c9gfL/GiXFGQ3RsfJK
	 qMeKmrd/4w8sQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4638D7876A;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 12:34:52 +0000
Subject: [PATCH v2 5/6] docs: iio: add documentation for adf41513 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-adf41513-iio-driver-v2-5-be29a83d5793@analog.com>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
In-Reply-To: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766147692; l=10735;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3KJ64wHlgMSeX7BJ0keCBeM//1V6x15c+wA1rFATgcA=;
 b=hBL4ulWSEJGgI2vU3MvX1AeJLt7W1VNFWEgiOV111XcZu/v9eovKJygJ4SY7Fyiw7ZFKB3zXx
 kErEY6eaYH4CoQor7FIQwW2LDtlf/mH25tjArj+EKdQR0EDWeOBfYQH
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

add documentation for ADF41513 driver which describes the device
driver files and shows how userspace may consume the ABI for various
tasks

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/iio/adf41513.rst | 255 +++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst    |   1 +
 MAINTAINERS                    |   1 +
 3 files changed, 257 insertions(+)

diff --git a/Documentation/iio/adf41513.rst b/Documentation/iio/adf41513.rst
new file mode 100644
index 000000000000..568e71bc21e4
--- /dev/null
+++ b/Documentation/iio/adf41513.rst
@@ -0,0 +1,255 @@
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
+| phase                | RF output phase adjustment and readback (degrees)     |
++----------------------+-------------------------------------------------------+
+
+2.1 Frequency Control
+----------------------
+
+The ``frequency`` attribute controls the RF output frequency with sub-Hz
+precision. The driver automatically selects between integer-N and fractional-N
+modes to achieve the requested frequency with the best possible phase noise
+performance.
+
+**Supported ranges:**
+
+- **ADF41513**: 1,000,000,000 Hz to 26,500,000,000 Hz (1 GHz to 26.5 GHz)
+- **ADF41510**: 1,000,000,000 Hz to 10,000,000,000 Hz (1 GHz to 10 GHz)
+
+The frequency is specified in Hz, for sub-Hz precision use decimal notation.
+For example, 12.102 GHz would be written as "12102000000.000000".
+
+2.2 Frequency Resolution Control
+--------------------------------
+
+The ``frequency_resolution`` attribute controls the target frequency resolution
+that the driver attempts to achieve. This affects the choice between integer-N
+and fractional-N modes, including fixed modulus (25-bit) and variable modulus
+(49-bit) fractional-N modes:
+
+- **Integer-N**: Resolution = f_PFD
+- **Fixed modulus**: Resolution = f_PFD / 2^25 (~3 Hz with 100 MHz PFD)
+- **Variable modulus**: Resolution = f_PFD / 2^49 (µHz resolution possible)
+
+Default resolution is 1 Hz (1,000,000 µHz).
+
+2.3 Reference Input Control
+---------------------------
+
+The ``refin_frequency`` attribute allows control of the reference input
+frequency when using a programmable reference clock. The supported range is
+10 MHz to 800 MHz.
+
+2.4 Power Management
+--------------------
+
+The ``powerdown`` attribute provides software power control:
+
+- **0**: Device active and operational
+- **1**: Device in power-down mode (low power consumption)
+
+2.5 Phase adjustment
+--------------------
+
+The ``phase`` attribute allows adjustment of the output phase in degrees.
+Setting this attribute enables phase adjustment. It can be set from 0 to 360
+degrees. Reading this attribute returns the current phase offset of the output
+signal. To create a consistent phase relationship with the reference signal,
+the phase resync feature needs to be enabled by setting a non-zero value to the
+``adi,phase-resync-period-ns`` device property, which triggers a phase
+resynchronization after locking is achieved.
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
+4. Usage examples
+=================
+
+4.1 Basic Frequency Setting
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
+4.2 High Resolution Frequency Control
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
+4.3 Reference Frequency Control
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
+4.4 Power Management
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
+4.5 PFD Frequency Monitoring
+----------------------------
+
+Read the current PFD frequency:
+
+.. code-block:: bash
+
+    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_pfd_frequency
+    100000000.000000
+
+This shows the PFD is operating at 100 MHz, which means the frequency resolution
+in integer-N mode would be 100 MHz steps.
+
+4.6 Monitor Lock Status
+-----------------------
+
+When lock detect GPIO is configured, check if PLL is locked:
+
+.. code-block:: bash
+
+    # Read frequency - will return error if not locked
+    root:/sys/bus/iio/devices/iio:device0> cat out_altvoltage0_frequency
+
+If the PLL is not locked, the frequency read will return ``-EBUSY`` (Device or
+resource busy).
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
index 06ba879a248a..c536c3afc1ae 100644
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



