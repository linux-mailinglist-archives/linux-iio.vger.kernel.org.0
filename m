Return-Path: <linux-iio+bounces-18119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A75A88BE2
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D2F1773C5
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667F2820C1;
	Mon, 14 Apr 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+hrtS9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BE4C74;
	Mon, 14 Apr 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657400; cv=none; b=X/WDis//bU13QnT4fznmKpB9PKV/sNCGJsuNlfMK2HJye5zlKYAsuafH0XyRYCvYGSdSe6jW3NvlsNOJ9PjJxu5RVd/oEH+klG1l0WNcPXC3dqGYxGgQUGbMxBzaJzWSfIG+p8v71t6a6Rd79LBYCDaldz9I6podYpabH9cZmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657400; c=relaxed/simple;
	bh=se/vRsTZaPEhVgAiD0XO6GX4CH2RBgPSUSoyyjeFias=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdKJRZ4V42+/q+SWxfB4skWjq2yT+FC6V+VFxmV7XZ1JogSWJ+9C2ButVYa4z/66VmMAhA+JQUYA3ECc0iwQ4PRWv3iDt/keFqxZKDQRO3+Uy9ef8CJF35f+jTNKLUUzFz7/TujlUQToTPjkMzroW96Qqlm6Jla7pfc89qTuhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+hrtS9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F948C4CEE2;
	Mon, 14 Apr 2025 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744657399;
	bh=se/vRsTZaPEhVgAiD0XO6GX4CH2RBgPSUSoyyjeFias=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+hrtS9p9moVrGAbSthm9AOWFsL58+N/YA+7g572Z/Bu/wkBSKBh3Wi+IhuF+pW2i
	 S1+J5vsFe/fhTdhjALPWu2/7wcRs5fMPGutZnHw4oS5hhlJig6qfxKOJLLhXQGMo+Q
	 1sz20sfHOsuTbUiPAHDS8iKkMHYfF/suuuxt7J8DUCO8DIUqfxNjoGPwNKNlZutAFF
	 +RwFy4kmeZLNekrXhyrmmpBBypjyPah3ZZomV+jqWH6sfDqE68jwIV7xdfnvNkVxvF
	 yOejvymwC8muNksXF01n+680/tZ6ZhfhscYtwwW2HTCbEgv2qEsNBG4qeCB8geFcAe
	 +EaiXTskq47Yg==
Date: Mon, 14 Apr 2025 20:03:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
 Michael.Hennerich@analog.com, lars@metafoo.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH] Documentation: iio: Document ad9832 driver
Message-ID: <20250414200312.0b9eeb10@jic23-huawei>
In-Reply-To: <20250414164811.36879-1-simeddon@gmail.com>
References: <20250414164811.36879-1-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 22:17:49 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> The Analog Devices Inc. AD983X chips will benefit from a detailed
> driver documentation.
>=20
> This documents the current features supported by the driver.

Hi Siddharth,

Whilst I'm fine with better documentation, I'm not keen to merge if for
a staging driver until we have that cleaned up and moved out of staging.

Anyhow, that doesn't stop us reviewing what you have here!

My main comment is that we should be focusing on what is useful to someone
reading the kernel docs rather than providing detailed description of the
device.  If anyone has one of these and wants to know more they can
get the data sheet.  As such most of what you have here is a case
of too much information.=20

Jonathan

>=20
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  Documentation/iio/ad9832.rst | 119 +++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/iio/ad9832.rst
>=20
> diff --git a/Documentation/iio/ad9832.rst b/Documentation/iio/ad9832.rst
> new file mode 100644
> index 000000000000..a3a58569ff89
> --- /dev/null
> +++ b/Documentation/iio/ad9832.rst
> @@ -0,0 +1,119 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AD9832 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Direct Digital Synthesizer driver for Analog Devices Inc. AD9832 and AD9=
835.
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The following chips are supported by this driver:
> +
> +* `AD9832 <https://www.analog.com/AD9832>`_
> +* `AD9835 <https://www.analog.com/AD9835>`_
> +
> +The AD9832 is a numerically controlled oscillator employing

Very short wrap.  For docs keep to a 80 char limit (or over that if=20
necessary for links etc.

> +a phase accumulator, a sine look-up table, and a 10-bit digital-
> +to-analog converter (DAC) integrated on a single CMOS chip.
> +
> +Supported features
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +SPI wiring modes
> +----------------
> +
> +The driver currently supports the following SPI wiring configuration:

This one is very straight forward unidirectional SPI. The only thing docume=
nting
it brings is perhaps to make it clear we can never read anything back from
the device.

We tend to have these diagrams so as to add information relevant to what the
driver does internally and any limitations on what is supported based
on particular wiring.

> +
> +3-wire mode
> +^^^^^^^^^^^
> +
> +In this mode, communication occurs via SCLK, SDATA, and FSYNC signals.
> +
> +.. code-block::
> +
> +    +-------------+         +-------------+
> +    |       FSYNC |<--------| CS/GPIO     |
> +    |             |         |             |
> +    |    AD983X   |         |     HOST    |
> +    |             |         |             |
> +    |       SDATA |<--------| MOSI        |
> +    |        SCLK |<--------| SCK         |
> +    +-------------+         +-------------+
> +
> +
> +Channel configuration
> +---------------------
> +
> +The AD9832 features two frequency registers (FREQ0 and FREQ1) and
> +four phase registers (PHASE0, PHASE1, PHASE2, and PHASE3).
> +The selection of which of these registers is actively used to generate
> +the output waveform can be controlled in two ways: via external pins or
> +via internal control bits.
> +
> +* Pin Control: The ``FSELECT`` pin determines whether FREQ0 REG or FREQ1
> +  REG is used.
> +* The ``PSEL0`` and ``PSEL1`` pins select which of the four PHASE regist=
ers
> +  is active.

This seems to be documenting a mode we don't support in the driver? That
level of extra detail doesn't belong in the kernel documentation.

These docs should focus on what the driver provides rather than the full
scope of what it could provide.  We'll update the docs when we add
new features.


> +* These pins are sampled on the rising edge of the master clock (MCLK).
> +* Bit Control: This is utilized by the driver for the selection of the
> +  frequency and phase registers can be controlled using internal bits.
> +* Bit D11 (within a control word) can select the FREQx REG, and Bits D9 =
and
> +  D10 can select the PHASEx REG.
> +
> +The source of control, whether from the external pins or the internal bi=
ts,
> +is determined by the SELSRC bit (Select Source bit, D12) within a control
> +register.
> +When SELSRC =3D 0, the pins are used for selection, which is the default=
 state
> +after the CLR (Clear) bit is set high. When SELSRC =3D 1,
> +the internal bits are used for selection.
> +
> +Synchronization
> +---------------
> +
> +The SYNC bit (D13) determines how the reading of the FSELECT, PSEL0, and
> +PSEL1 pins (when SELSRC =3D 0) is synchronized with the master clock (MC=
LK):
> +
> +When SYNC =3D 1: The reading of the pins is synchronized with the rising=
 edge
> +of MCLK. This ensures the inputs are valid at the sampling instant, even=
 if
> +the setup and hold times are violated. This mode introduces a latency of=
 8
> +MCLK cycles.
> +When SYNC =3D 0: The sampling occurs asynchronously, and the latency is =
reduced
> +to 6 MCLK cycles if the timing characteristics are met.
> +
> +The SYNC bit is particularly important in applications where the timing =
of
> +register selection changes is critical or when interfacing with control =
systems
> +that may not strictly adhere to the setup and hold time requirements.
> +
> +Power Supply
> +------------
> +
> +The AD9832 supports separate power supply pins for the analog and digital
> +sections via the ``AVDD`` and ``DVDD`` inputs. Both pins support voltage
> +ranges from 2.97V to 5.5V (5V =C2=B110% or 3.3V =C2=B110%).
> +
> +Proper decoupling is critical: both AVDD and DVDD should be decoupled wi=
th
> +0.1=C2=B5F ceramic capacitors in parallel with 10=C2=B5F tantalum capaci=
tors to AGND
> +and DGND respectively.
> +
> +The device also supports a low power sleep mode, reducing current
> +consumption to 350=C2=B5A maximum. When powered down using the power-dow=
n bit,
> +power consumption is reduced to 5mW (5V) or 3mW (3V).

This bit isn't really relevant for kernel docs.  Whoever designed the board
ought to know this.

> +
> +Reference Voltage
> +-----------------
> +
> +The AD9832 supports using either an internal 1.21V reference or an exter=
nal
> +reference voltage via the ``REFIN`` input.
> +
> +If ``refin-supply`` is present, then an external reference of 1.21V nomi=
nal is
> +supplied to the REFIN pin. If not specified, the internal reference is u=
sed
> +and is available at the ``REFOUT`` pin.
> +
> +The internal reference has an accuracy of 1.21V =C2=B17% min/max across =
the full
> +temperature range (-40=C2=B0C to +85=C2=B0C) with a typical temperature =
coefficient of
> +100 ppm/=C2=B0C. The REFOUT pin should be decoupled with a 10nF capacito=
r to AGND.
> +
> +For applications requiring reduced wake-up time at low power supplies and
> +low temperatures, the use of an external reference is recommended.


