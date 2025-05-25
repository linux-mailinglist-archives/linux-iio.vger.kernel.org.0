Return-Path: <linux-iio+bounces-19893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55DAC3505
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0297B172767
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB71F418D;
	Sun, 25 May 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwrtk6pc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE12F2D;
	Sun, 25 May 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748181418; cv=none; b=OcL+kVAA+N1kapwdQwrGrzEqKwS2u9uAjUvQ4ex31BCWRfSsQ83YSf5l0HyXxgvwlMenRt4ERQ+XNSRAWgoiNjwp/feU26YaQ+B9KInE78qU4exP+pC1L0F8r+fjx5Buvnj+kVhKodSwfUZhY24h1ow1GI7kK+I/oZBft2RMMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748181418; c=relaxed/simple;
	bh=JhqNrMmQUf2aFZpriCISO4mDccniVYW9P2/1tpRlxr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZt4x7xn90A137auojZU5VE5Pglqm/24CQcAEzhwVIiNtOCBYFmyWTbbbFOq3yDqmpg7kSBhrw3SDJTzUGcXpnumViNTsiyFH6VQMNaIX8pp++azLdzcRb9lpkbYDxAeMfNW1WUiDhdoNX6G0hKx9YmpPKaCtWxGl5Li9XSeUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwrtk6pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B0C4CEEA;
	Sun, 25 May 2025 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748181418;
	bh=JhqNrMmQUf2aFZpriCISO4mDccniVYW9P2/1tpRlxr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jwrtk6pcYeIldJzr0xvXX+UX1B1GR1v6cArVfEXzl1Qcy4OEc5Bq03ZtzVIAI0j3O
	 oZG3vg7hlLqWMbHYcFyfA16OvN738u9smLGsvWgBDb8AMyKpeEL0asoFDBGOYnJIs7
	 Wazfel1Apapt15c/W0fhLof9YGtnnvy+/AtGf+5DO9bAw0Qx9xrsy7vGcyxpHP8xPl
	 rq6/JJqBLcwhakquPrxf5vJCw9eddav5nI+Zy7eduR55JdN+4gFIz7dETZEYf1lVVr
	 cnA+ituTDDMhc+wQlwlnBhwo3KG3TMQVL1gjge+PEy0FQ+2l/Wvmp8MSPLSSfsnhw0
	 Tm1iqXxJTiMPA==
Date: Sun, 25 May 2025 14:56:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/6] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <20250525145649.181b4649@jic23-huawei>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-1-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
	<20250522-wip-bl-ad7606-calibration-v6-1-487b90433da0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 15:27:02 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add new IIO calibconv_delay documentation.

This has all gotten somewhat confused. What are we actually using?

> 
> The ad7606 implements a phase calibation feature, in nanoseconds.
> Being this a time delay, using the conv_delay suffix.
This being a time delay, use the convdelay suffix.

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ef52c427a015cf47bb9847782e13afbee01e9f31..cd79c036b2ccdea016dcc17f4e8ac5fdb2d0e465 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -559,6 +559,30 @@ Description:
>  		- a small discrete set of values like "0 2 4 6 8"
>  		- a range specified as "[min step max]"
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Delay of start of conversion from common reference point shared
> +		by all channels. Can be writable when used to compensate for
> +		delay variation introduced by external filters feeding a
> +		simultaneous sampling ADC.
> +
> +		I.e., for the ad7606 ADC series, this value is intended as a

E.g. more appropriate than I.e. as an example, not a 'What we mean is'..

> +		configurable time delay in seconds, to correct delay introduced
> +		by an optional external filtering circuit.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay_available
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available values of convdelay. Maybe expressed as:
> +
> +		- a range specified as "[min step max]"
> +
> +		If shared across all channels, <type>_calibconv_delay_available

It's not called that any more.

> +		is used.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> 


