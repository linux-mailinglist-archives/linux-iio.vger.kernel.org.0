Return-Path: <linux-iio+bounces-24048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1DB56114
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771757AB106
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083612EDD4C;
	Sat, 13 Sep 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u47l62QA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C7285C97;
	Sat, 13 Sep 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757769667; cv=none; b=BWsulUQX8+OcVF345qHcvLfxuk333vPiyutl29WF1KFqGMuYEG7sytK1OREM8mL6WgeZZ1p19x4G49jWGGOaoEzmBMrF5BanW2f7Tmr6b3jkjgwY2kjT2Vf13R9dCEyoWrhZvf+LA8ueQJv7qmhAc2nnQtQfztr2uc831f/jF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757769667; c=relaxed/simple;
	bh=NFy5BFwgI1BaFJmQCa91idv5aurWAF94mAYy1EKJnjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI1+X6wiTuZvbPiYoDDkmSuXeoUAv5giaZIHHeW3+nBlqbKu7ABoudXy/mogU4U6INhImxerPiHC/26HDvlNvZT43uPrwvcxwPHf1ETJWIcnDhmrAFJQ/aXej+oTL842A/jvK5I6Ss3QbJOwbiCa+yh1N6cBwn1OIT9eHexaYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u47l62QA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A12C4CEEB;
	Sat, 13 Sep 2025 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757769667;
	bh=NFy5BFwgI1BaFJmQCa91idv5aurWAF94mAYy1EKJnjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u47l62QAK8E/EEWHs+xzlJyrw2tXSKhqF7OfvPobT3bkJj3a/yp5iLWXsAJ0rin/V
	 Cb44yD3/qZbS7CabblwdTbsvlH5DIBGj+ayNFN/jE4Znsgh7owqGPsocMGpJ+URAmP
	 oxpnEKAyuU5HDRtr2a+zcaojd8/ACk/nDo1G+Ls0RV87zqqdo9TNR+He7u4avdNcaw
	 3Tyl65ncxv7vNjk5Fu2JA5yPhfO53Wzz4QlR3QHgf4fNyGbjSpCSCSPLiCIiJwiO5X
	 WjIcD5dalpNBh27OFxY+1V2Ed7V6zavElpYURMYwSwBrdaY/C/P8HDFGztZMM3vaLy
	 zQgeqClRDHkZA==
Date: Sat, 13 Sep 2025 14:20:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] docs: iio: add documentation for ade9000 driver
Message-ID: <20250913142059.1122a622@jic23-huawei>
In-Reply-To: <20250908073531.3639-6-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
	<20250908073531.3639-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 07:35:25 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for ade9000 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Please test your docs build and carefully look at the output.
There were a few formatting errors in here that I have fixed up.

Jonathan



> +
> ++---------------------------------------------------+----------------------------------------------------------+
> +| IIO Event Attribute                               | ADE9000 Datasheet Equivalent                             |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_voltage[0-2]_thresh_either_en                  | Zero crossing detection interrupt (ZXVx)                 |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_rising_en           | RMS swell detection interrupt (SWELLx)                   |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_rising_value        | RMS swell threshold (SWELL_LVL register)                 |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_falling_en          | RMS sag/dip detection interrupt (DIPx)                   |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altvoltage[0-2]_rms_thresh_falling_value       | RMS sag/dip threshold (DIP_LVL register)                 |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_current[0-2]_thresh_either_en                  | Current zero crossing detection interrupt (ZXIx)         |
> ++---------------------------------------------------+----------------------------------------------------------+
> +
> +Event directions:

blank line before bulleted list.

> +- ``rising``: Upper threshold crossing (swell detection)
> +- ``falling``: Lower threshold crossing (sag/dip detection)
> +- ``either``: Any threshold crossing (zero crossing detection)
> +- ``none``: Timeout or non-directional events
> +
> +**Note**: Event attributes are only available if the corresponding interrupts
> +(irq0, irq1, dready) are specified in the device tree. The driver works without
> +interrupts but with reduced functionality.
> +
> +5. Device buffers
> +=================
> +
> +This driver supports IIO buffers for waveform capture. Buffer functionality
> +requires the dready interrupt to be connected.
> +
> +The device supports capturing voltage and current waveforms for power quality
> +analysis. The waveform buffer can be configured to capture data from different
> +channel combinations.
> +
> +Supported channel combinations for buffered capture:

blank line before bulleted list.

> +- Phase A: voltage and current (IA + VA)
> +- Phase B: voltage and current (IB + VB)
> +- Phase C: voltage and current (IC + VC)
> +- All phases: all voltage and current channels
> +- Individual channels: IA, VA, IB, VB, IC, VC
> +
> +Usage examples
> +--------------
> +
> +Enable waveform capture for Phase A:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_current0_en
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_voltage0_en
> +
> +Set buffer length and enable:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> echo 100 > buffer/length
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > buffer/enable
> +
> +6. Clock output
> +===============
> +
> +The ADE9000 can provide a clock output via the CLKOUT pin when using an external
> +crystal/clock source. This feature is enabled by specifying ``#clock-cells = <0>``
> +in the device tree. The output clock will be registered as "clkout" and can be
> +referenced by other devices.
> +
> +7. Usage examples
> +=================
> +
> +Show device name:
> +
> +.. code-block:: bash
> +
> +	root:/sys/bus/iio/devices/iio:device0> cat name
> +        ade9000
> +
> +Read voltage measurements:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_voltage0_raw
> +        12345
> +        root:/sys/bus/iio/devices/iio:device0> cat in_voltage0_scale
> +        0.000030517
> +
> +- Phase A voltage = in_voltage0_raw * in_voltage0_scale = 0.3769 V
> +
> +Read power measurements:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_power0_active_raw
> +        5678
> +        root:/sys/bus/iio/devices/iio:device0> cat in_power0_scale
> +        0.000244140
> +
> +- Phase A active power = in_power0_active_raw * in_power0_scale = 1.386 W
> +
> +Configure calibration gains:
> +
> +.. code-block:: bash
> +
> +        # Set current channel 0 calibration gain
> +        root:/sys/bus/iio/devices/iio:device0> echo 0x800000 > in_current0_calibscale
> +        # Set voltage channel 0 calibration gain
> +        root:/sys/bus/iio/devices/iio:device0> echo 0x7FFFFF > in_voltage0_calibscale
> +
> +Configure RMS voltage event thresholds (requires interrupts):
> +
> +.. code-block:: bash
> +
> +        # Set RMS sag detection threshold
> +        root:/sys/bus/iio/devices/iio:device0> echo 180000 > events/in_altvoltage0_rms_thresh_falling_value
> +        # Enable RMS sag detection
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_altvoltage0_rms_thresh_falling_en
> +
> +        # Set RMS swell detection threshold
> +        root:/sys/bus/iio/devices/iio:device0> echo 260000 > events/in_altvoltage0_rms_thresh_rising_value
> +        # Enable RMS swell detection
> +        root:/sys/bus/iio/devices/iio:device0> echo 1 > events/in_altvoltage0_rms_thresh_rising_en
> +
> +8. IIO Interfacing Tools
> +========================
> +
> +See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
> +interfacing tools.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index c106402a91f7..792c815286f4 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -28,6 +28,7 @@ Industrial I/O Kernel Drivers
>     ad7606
>     ad7625
>     ad7944
> +   ade9000
>     adis16475
>     adis16480
>     adis16550


