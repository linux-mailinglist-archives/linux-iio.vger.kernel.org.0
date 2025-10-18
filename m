Return-Path: <linux-iio+bounces-25228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EB0BED27E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 848C04E69BC
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F422A1D4;
	Sat, 18 Oct 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY3MXu2r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6421CFEF;
	Sat, 18 Oct 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800881; cv=none; b=NQG0mR3ujKz7xZBaFrZLP0dcPJtwGC8hjicjzmsRUV20M+vLLdwthZxL9tdN88qJTopjzu5a1SWHthV5qdTJUuQBpKSN2fLOc+inwcqwiyxa5iToL4yZgeQkNOehek4PyI3q/pC4o4ZdAYgBp4+UfZqI9xJX3cJA97QAa0w4W4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800881; c=relaxed/simple;
	bh=vVYZl4oCLGwM7SQGP//U+44wtpZOiDFyOu33ohtCr0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJclOGhXCwL/GnHO0+FYAMf56THivJHjkoGX+A2GFDQfegZqesgnz34vq3YZj/BHn6RBGTlK9qPB6E4l7SSaM4DuXgTv8kONGZV/ODbToZeDcjPcnMQSAdIWxoWpvq2MXG++FipWnmNzPWKLJX15MAE5I8Wf/XnmoUHa5uFEzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY3MXu2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70D3C4CEF8;
	Sat, 18 Oct 2025 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760800880;
	bh=vVYZl4oCLGwM7SQGP//U+44wtpZOiDFyOu33ohtCr0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DY3MXu2r0KYyVn2cLnp7wVLtb7YgesBYzYVYeu9Sr9VELnZCcds6AwnUbUhJy7qNo
	 cQf9numgiNhd7IfTcL0h8/FtyhCvnk67DfsKd6DhITjx4K1krWVr2LHcc/fcS75ga0
	 fP0wLRRZyBIpB/mlE8Ulr12xbbvbBRwcrp7ste4RUS30Gf1plu81WcJpW7agdIe3YW
	 rlib9LNwnCOWkmxNX9yNf3q3X385/mCd5AYDW3soo1rvvc9tzClZNw6iPL5UA+NO/C
	 QYxeSRqXlYVxjAyq9tHUCfm2amnWQRrSXtWfSHBG8prKAsyjQLAJ0LGEpeRDCB0eCS
	 6n0PhnDbUPmnA==
Date: Sat, 18 Oct 2025 16:21:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/7] docs: iio: New docs for ad4062 driver
Message-ID: <20251018162113.002d92f7@jic23-huawei>
In-Reply-To: <20251013-staging-ad4062-v1-2-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-2-0f8ce7fef50c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 09:28:00 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> This adds a new page to document how to use the ad4062 ADC driver.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jorge,

Various comments inline.

Thanks,

Jonathan

> ---
>  Documentation/iio/ad4062.rst | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                  |  1 +
>  2 files changed, 90 insertions(+)
> 
> diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..b486d7fe1916d2963c94581be3696cf58d51ca48
> --- /dev/null
> +++ b/Documentation/iio/ad4062.rst
> @@ -0,0 +1,89 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4062 driver
> +=============
> +
> +ADC driver for Analog Devices Inc. AD4060/AD4062 devices. The module name is
> +``ad4062``.
> +
> +Supported devices
> +=================
> +
> +The following chips are supported by this driver:
> +
> +* `AD4060 <https://www.analog.com/AD4060>`_
> +* `AD4062 <https://www.analog.com/AD4062>`_
> +
> +Wiring modes
> +============
> +
> +The ADC is interfaced through an I3C bus, and contains two programmable GPIOs.
This raises a question on whether it makes sense for the binding to support providing
gpios from the start (as alternative to interrupts).  Seems like the two pins
are completely interchangeable so one might well be 'left' for use by some other
device that needs a gpio pin.

I don't mind that much if we want to leave the binding support for that for later
but in the ideal case we'd have it from the start (even if the driver doesn't
support it until we have a user).

> +
> +The ADC convert-start happens on the SDA rising edge of the I3C stop (P) bit
> +at the end of the read command.
> +
> +The two programmable GPIOS are optional and have a role assigned if present in
> +the devicetree:
> +
> +- GP1: Is assigned the role of Data Ready signal.

I assume that's only the case if GP1 is provided?  If GP0 is the only one
we should allow use that for data ready.  As long as the DT allows that it is
permissible for the driver to not do so for now.

> +
> +Device attributes
> +=================
> +
> +The ADC contains only one channel with following attributes:
> +
> +.. list-table:: Channel attributes
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Description
> +   * - ``in_voltage_calibscale``
> +     - Sets the scale factor to multiply the raw value.
That's confusing.  This should be hardware 'tweak' to compensate for
calibration or similar.  The text doesn't make it clear where that multiply
is happening. Sounds too much like _scale.

> +   * - ``in_voltage_oversampling_ratio``
> +     - Sets device's burst averaging mode to over sample using the
> +       internal sample rate. Value 1 disable the burst averaging mode.
> +   * - ``in_voltage_oversampling_ratio_available``
> +     - List of available oversampling values.
> +   * - ``in_voltage_raw``
> +     - Returns the raw ADC voltage value.
> +   * - ``in_voltage_scale``
> +     - Returs the channel scale in reference to the reference voltage

Spell check needed.  Also this describes why it might take different values
but not the bit users care about which is the standard ABI thing of
Real value in mV = _raw * _scale 

> +       ``ref-supply``.
> +
> +Also contain the following device attributes:
> +
> +.. list-table:: Device attributes
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Description
> +   * - ``samling_frequency``

Check these.. sampling_frequency.

> +     - Sets the sets the device internal sample rate, used in the burst
> +       averaging mode.

It's not use otherwise?  That's unusual ABI.  I'd expect it to give
the right value at least when burst mode isn't used. Or is burst mode
the only way we do buffered capture?

> +   * - ``sampling_frequency_available``
> +     - Lists the available device internal sample rates.
> +
> +Interrupts
> +==========
> +
> +The interrupts are mapped through the ``interrupt-names`` and ``interrupts``
> +properties.
> +
> +The ``interrupt-names`` ``gp1`` entry sets the role of Data Ready signal.
> +If it is not present, the driver fallback to enabling the same role as an
> +I3C IBI.

It feels like it should be easy to use the other GPO pin in this case if that
is present. 

> +
> +Low-power mode
> +==============
> +
> +The device enters low-power mode on idle to save power. Enabling an event puts
> +the device out of the low-power since the ADC autonomously samples to assert
> +the event condition.
> +
> +Unimplemented features
> +======================
> +
> +- Monitor mode
> +- Trigger mode
> +- Averaging mode
> diff --git a/MAINTAINERS b/MAINTAINERS
> index afbfaeba5387b9fbfa9bf1443a059c47dd596d45..ce012c6c719023d3c0355676a335a55d92cf424c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1405,6 +1405,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> +F:	Documentation/iio/ad4062.rst
>  
>  ANALOG DEVICES INC AD4080 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> 


