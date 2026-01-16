Return-Path: <linux-iio+bounces-27858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E8D32AA0
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A399C3091987
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE20394474;
	Fri, 16 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8lLesOg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC33933F8;
	Fri, 16 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573959; cv=none; b=aNJnZjR0iyei5crJAOZ9Wg6V1LFl6zYYFFl3EV2d9jCfi8gqJ2bVtwsdvoFOE8ptI9m9Cs8G6hWaHDgwKo/czuSrFL+ZcC0/DcN+fMrF4m9+0UNYRyRhJX/4Uqi20/kS4MC7oACMvST5USmKfil6YQRDFsTqZPkJyAVkb+kZIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573959; c=relaxed/simple;
	bh=wV1lJ3hAmgrfMpDghDFRsvcOy0ntYHs3GAJC1s/qKU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r67dWclYPbWuJ+nNfaFsTWSUvDZc6duPK1KzsUzt2DOY6Grbsyj4IWy8EUVbjnE1SfiSGAsSvQf7Fd9pvZxPIp1H81pPV/Z/Hd7aBc91BT4gFjKzAUNJ+QtohrkBQvthYHOeDdxKGTgfXb65aUwHf3+D1+3vJneN7BVOD69O4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8lLesOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E233DC2BCB2;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573959;
	bh=wV1lJ3hAmgrfMpDghDFRsvcOy0ntYHs3GAJC1s/qKU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l8lLesOg0oaaE/EnOdt5nm/N3vT0tUv9kk/QQnY+NwkcEtj7zxv2CLOPDSuUfgFin
	 51bjq+UKxiu3/V76ukIcViiRKj0P/GaRtrGpssmCSU8VAmS6zhkkUMjYO0EaPTGQIW
	 q6cxvoUbJzZVvr9HJk1Hl+CWxB2iL748TQ1cQY41vXPbB5s7XfRXW4jPyWjsOgv9v3
	 EZ1yM5rhelzU5xRkHJpKo9U1tlnuA1ej4QduzBA5ZZuNCQaDzo8rwdGURbQNf7npz3
	 5IjSUhSZdZNB00D+oqYVmTA7Mqjmv9n5iyJnCo6xHHlUF8z8xZ6xCzFciGV55AJWxu
	 M6gDRUJItJvEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8020C982C4;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 16 Jan 2026 14:32:25 +0000
Subject: [PATCH v4 6/7] docs: iio: add documentation for adf41513 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260116-adf41513-iio-driver-v4-6-dbb7d6782217@analog.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
In-Reply-To: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768573956; l=8999;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=LdUplBn7WrSrozazlz+piNGlOKN4hMOIG09vIG8zDR8=;
 b=9GxEtbQr7l3Sz01aOSVMSy03qJW1HwRC16K+kXpYFpHuRmqL5/AirO7jKwnek9I5C0McgKWM9
 P/R82fuKu52Aqnv8ry8BwmX2a9TNQDi8QaPsNabIhqtdSAdLWlbP/ek
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add documentation for ADF41513 driver which describes the device
driver files and shows how userspace may consume the ABI for various
tasks

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/iio/adf41513.rst | 199 +++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst    |   1 +
 MAINTAINERS                    |   1 +
 3 files changed, 201 insertions(+)

diff --git a/Documentation/iio/adf41513.rst b/Documentation/iio/adf41513.rst
new file mode 100644
index 000000000000..4193c825b532
--- /dev/null
+++ b/Documentation/iio/adf41513.rst
@@ -0,0 +1,199 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ADF41513 driver
+===============
+
+This driver supports Analog Devices' ADF41513 and similar SPI PLL frequency
+synthesizers.
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
+- **ADF41510**: 1 GHz to 10 GHz frequency range
+- **ADF41513**: 1 GHz to 26.5 GHz frequency range
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
+| powerdown            | Power management control (0=active, 1=power down)     |
++----------------------+-------------------------------------------------------+
+| phase                | RF output phase adjustment and readback (radians)     |
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
+- **ADF41510**: 1,000,000,000 Hz to 10,000,000,000 Hz (1 GHz to 10 GHz)
+- **ADF41513**: 1,000,000,000 Hz to 26,500,000,000 Hz (1 GHz to 26.5 GHz)
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
+2.3 Phase adjustment
+--------------------
+
+The ``phase`` attribute allows adjustment of the output phase in radians.
+Setting this attribute enables phase adjustment. It can be set from 0 to 2*pi
+radians. Reading this attribute returns the current phase offset of the output
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
+- Bleed current: Disabled
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
+4.3 Monitor Lock Status
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
index ba3e609c6a13..605871765c78 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -30,6 +30,7 @@ Industrial I/O Kernel Drivers
    ad7625
    ad7944
    ade9000
+   adf41513
    adis16475
    adis16480
    adis16550
diff --git a/MAINTAINERS b/MAINTAINERS
index 1edfa6a1c641..e61619af9248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1624,6 +1624,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
+F:	Documentation/iio/adf41513.rst
 F:	drivers/iio/frequency/adf41513.c
 
 ANALOG DEVICES INC ADF4377 DRIVER

-- 
2.43.0



