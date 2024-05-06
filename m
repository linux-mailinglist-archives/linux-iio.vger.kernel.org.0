Return-Path: <linux-iio+bounces-4844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0C8BCFD9
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72ADB1F22467
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E6B13CFAD;
	Mon,  6 May 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdr3fCqq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4781211;
	Mon,  6 May 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005057; cv=none; b=EFoq0w6AmUmrvssClcmnXOyYheJikeXsv834NJtg2R07U4xiEppiAYc02OV1v0pmyaKZeme0MuQESkxzFsvqWGHCF0kB7LXCHHYtp2BkMI/jugb1QpCcIkFikSsul0EJkOBwN8WLz5fGCn7UaaGswwxYP2Lpd+2c9DN9JnQV8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005057; c=relaxed/simple;
	bh=UT5jdW+jA0vq5ow16r7/+j8BrvIMxmLSzYl2OnPgLWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIUjqIN4qByhFrbSotp4fyFgd9fjaxzBLNarRYyLjPBLmb+vQiqNQJvjPsu5cxBeYJhRcUj4tMZsYi6P+dIhpaCv3CoQ4tlIWhOgCLn51hETkPMK2+Wqo+SDuezw5iRUfSqbphMdqnOHFt7EJU1+pN4cd7SMv4NhHT1YEaGDpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdr3fCqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555B6C116B1;
	Mon,  6 May 2024 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715005057;
	bh=UT5jdW+jA0vq5ow16r7/+j8BrvIMxmLSzYl2OnPgLWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vdr3fCqqIm0XrYDO7Hi/mGrr+H0sSZjGFu0Xr/Zfk7TzaFjKZUII1SY4yVsrnavOr
	 sW06NjOvE0QWOZYkHs9dg8IxKqVUESLNLT73j3KrLYjfNOwzxnqoGADXDIjB6laeNR
	 bRoaSSgF9RftStvkxRpFhtJcwckfi5uvlM4fu5j0pBQKwf55DNi9l35sMPs4vEG4Sz
	 6/tl91ZVCYeQEZmC8CfH6gUjqWGJb4ndjuO6ZvlU6MPO6ICb9gkGOnN6SCRnrPXf+a
	 SrDBT1OkHCeZiv6rYLvUcwDMYeZfErBWdHa2d1zLTPvo0ZNfJp/IeF9EZ5YDKyBpe5
	 tqH5i6LCYFD+g==
Date: Mon, 6 May 2024 15:17:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 09/10] iio: adc: ad7380: add support for rolling
 average oversampling mode
Message-ID: <20240506151725.10cf025e@jic23-huawei>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 May 2024 16:55:42 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Adds support for rolling average oversampling mode.
> 
> Rolling oversampling mode uses a first in, first out (FIFO) buffer of
> the most recent samples in the averaging calculation, allowing the ADC
> throughput rate and output data rate to stay the same, since we only need
> to take only one sample for each new conversion.
> 
> The FIFO length is 8, thus the available oversampling ratios are 1, 2, 4, 8
> in this mode (vs 1,  2, 4, 8, 16, 32 for the normal average)

Ah. I should have read on!

> 
> In order to be able to change the averaging mode, this commit also adds
> the new "oversampling_mode" and "oversampling_mode_available" custom
> attributes along with the according documentation file in
> Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 since no standard
> attributes correspond to this use case.

This comes to the comment I stuck in the previous patch.

To most people this is not a form of oversampling because the data rate
remains unchanged. It's a cheap low pass filter (boxcar) Google pointed me at:
https://dsp.stackexchange.com/questions/9966/what-is-the-cut-off-frequency-of-a-moving-average-filter

in_voltage_low_pass_3db_frequency would be the most appropriate standard
ABI for this if we do treat it as a low pass filter control.

I'm not necessarily saying we don't want new ABI for this, but I would
like to consider the pros and cons of just using the 3db frequency.

So would that work for this part or am I missing something?

> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 |  38 ++++++
>  MAINTAINERS                                        |   1 +
>  drivers/iio/adc/ad7380.c                           | 143 +++++++++++++++++++--
>  3 files changed, 174 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
> new file mode 100644
> index 000000000000..0a560ef3e32a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
> @@ -0,0 +1,38 @@
> +What: /sys/bus/iio/devices/iio:deviceX/oversampling_mode
> +KernelVersion: 6.9
> +Contact: Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +    Writing this attribute sets the oversampling average mode.
> +    Reading it, shows the configured mode.
> +    Available modes can be displayed using the oversampling_mode_available
> +    attribute.
> +    When writing this attribute to change the oversampling mode, this will
> +    have the following side effects:
Where possible, write ABI docs with the assumption we will generalize
them in future. Annoyingly the documentation system doesn't allow for
multiple descriptions. As such, additional information like this doesn't
belong in the ABI docs.

> +
> +      - soft reset the ADC to flush the oversampling block and FIFO
I think this was already picked up on in another review, but my inclination is
make this something you can't change with the buffer enabled. The results
will be rather unpredictable anyway and it will simplify the handling a little
to just block that corner with a claim (or failure to claim) direct mode
when setting this.

> +
> +      - the available oversampling ratios depend on the oversampling mode
> +        configured so to avoid misconfiguration, changing the mode will disable
> +        the oversampling by setting the ratio to 1.

Better to get a close as possible.  If they've configured it to something we can't
do then it's user error. If they have picked a value that is still possible then
allowing that is a nice usability improvement.

> +
> +      - the list of available ratios (displayed by reading the
> +        oversampling_ratio_available attribute) will be updated when changing
> +        the oversampling mode.

In general an ABI element is allowed to modify any other (because this sort of
chaining is common.)  As such I don't think this needs to be in the ABI docs
but would be a useful detail to add to a chip specific main document elsewhere.

> +
> +What: /sys/bus/iio/devices/iio:deviceX/oversampling_mode_available
> +KernelVersion: 6.9
> +Contact: Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +    Display the available oversampling average modes. The two available modes
> +    are "normal" and "rolling" where "normal" average mode is the default one.
> +
> +      - normal averaging involves taking a number of samples, adding them
> +        together, and dividing the result by the number of samples taken.
> +        This result is then output from the device. The sample data is cleared
> +        when the process completes. Because we need more samples to output a
> +        value, the data output rate decrease with the oversampling ratio.
> +
> +      - rolling oversampling mode uses a first in, first out (FIFO) buffer of
> +        the most recent samples in the averaging calculation, allowing the ADC
> +        throughput rate and output data rate to stay the same, since we only need
> +        to take only one sample for each new conversion.

If we keep this, I wonder if "moving" or "rolling" is the more common term for this.


> +
> +static IIO_DEVICE_ATTR_RW(oversampling_mode, 0);
> +static IIO_DEVICE_ATTR_RO(oversampling_mode_available, 0);
> +
> +static struct attribute *ad7380_attributes[] = {
> +	&iio_dev_attr_oversampling_mode.dev_attr.attr,
> +	&iio_dev_attr_oversampling_mode_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ad7380_attribute_group = {
> +	.attrs = ad7380_attributes,
> +};

Bring the sysfs includes in here rather than in the original driver patch.

Thanks,

Jonathan

