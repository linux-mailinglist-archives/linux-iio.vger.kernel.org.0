Return-Path: <linux-iio+bounces-18037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E26A87144
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCD816EBDF
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3018A6C1;
	Sun, 13 Apr 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O737r7Te"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D89433A0;
	Sun, 13 Apr 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536676; cv=none; b=aZc6Ibjs76bw170rnLjJ/S/haoG5pEWShhG9UzIi2sRc8dNgHBJIjSo5nY/E8rWrmuzGgfHXZb8X5JMf9m0nSmWPkA9YkpeR1Rws93n2Rf5vju8gqiMuqBnjevtKfH90vFX0N4A1PC/Q7jZOyqcn3OKVJROYLqqnCq310z+MscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536676; c=relaxed/simple;
	bh=tYcgxIPGrfJ7qhHGNlRZHboyoj6zGCAl6nkM09/e+AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HADi5VmXdJb2u7wTTtjYslIVm4SBzE3AMi/zkAd6K6hFX4yt/eK0akI5bxMRqaaj+3KceS7NkJCl4t/7f5VicAlm7MlU8iZrQFQ/RSikZCUWTl5w3zOOa/OdYuBSHLpy6bQraLJnfh7GE76P8bO0VfGKYax0ZDpXmSX9L26DOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O737r7Te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2EBC4CEEC;
	Sun, 13 Apr 2025 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536676;
	bh=tYcgxIPGrfJ7qhHGNlRZHboyoj6zGCAl6nkM09/e+AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O737r7TeqOy3wzaP7h0Lt/cZjvf1tV8GTDQQPzqiI+JrKpKS2Uqr79bfm8aZ/Ecfz
	 urHjIQT3X79wiQqOB9RTXQukJ/hK553bvmvjur4Y/kqTTWyeJjINYebVN70OfLy6Cc
	 R9/aj47AWbAZES3FrP4LVzZgONaTMvKn9BKjmYsxS4OKQ7wMyn2/J+fwiVG89KyNoF
	 hbeYyLax4vuX3FiVJNcnrgpFbhsk30cGXRIZHspPDkZ7+ysfF4mJfspfzTlaTf9wb0
	 hHz8G9yANSBntaIz2IXEJVQxUXc/zoJSI79Re+iYN3J5T+GoZkI1RPNZ2d3w14wW5f
	 Ggc7omlW2+86Q==
Date: Sun, 13 Apr 2025 10:31:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <dlechner@baylibre.com>,
 <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <20250413103110.572de81e@jic23-huawei>
In-Reply-To: <20250408-abi-oversampling-events-frequency-v2-1-4059272b7364@analog.com>
References: <20250408-abi-oversampling-events-frequency-v2-1-4059272b7364@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 10:20:29 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> Some devices have an internal clock used to space out the conversion
> trigger for the oversampling filter,
> Consider an ADC with conversion and data ready pins topology:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   ++++    ++++    ++++    ++++    ++++
>   ADC data ready      *       *       *       *       *
> 
> With the oversampling frequency, conversions are spaced:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
>   ADC data ready         *       *       *       *       *
> 
> In some devices and ranges, this internal clock can be used to evenly
> space the conversions between the sampling edge.
> In other devices the oversampling frequency is fixed or is computed
> based on the sampling frequency parameter, and the parameter is
> read only.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
> Some device families such as Analog Device's max1363, ad7606, ad799x, and
> ad4052 contain internal clocks used by monitor modes and oversampling.
> Devices' monitor modes are exposed as IIO events.
> The max1363 driver included the events/sampling_frequency in
> commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
> and ad799x in
> commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
> hysteresis")
> but went undocumented so far.
> 
> The oversampling sampling frequency is a planned feature to be patched
> onto the ad7606 driver.
> In this particular device, it is called oversampling padding.
> The upcoming ad4052 linux driver will utilize both entries,
> it is worth noting, however, there is a single register for both
> options. Since the device is never concurrently in both modes, the
> values will be safely cached on the device state.

This patch looks fine but we will only merge it with first user so
please add it to that series.

Jonathan

> ---
> Changes in v2:
> - Updated oversampling frequency description according to discussion 
> - Don't include already applied
>   commit 3a8fee68faf2 ("Documentation: ABI: add events sampling frequency in sysfs-bus-iio")
> - Link to v1: https://lore.kernel.org/r/20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 722aa989baac43f694076074b307d134867b4533..6f5c4060704742ae5f5672a861271b88084ac8f8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -138,6 +138,23 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Hardware dependent values supported by the oversampling filter.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> +KernelVersion:	6.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Some devices have internal clocks for oversampling.
> +		Sets the resulting frequency in Hz to trigger a conversion used by
> +		the oversampling filter.
> +		If the device has a fixed internal clock or is computed based on
> +		the sampling frequency parameter, the parameter is read only.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> +KernelVersion:	6.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Hardware dependent values supported by the oversampling
> +		frequency.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> 
> ---
> base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
> change-id: 20250321-abi-oversampling-events-frequency-436c64fcece0
> 
> Best regards,


