Return-Path: <linux-iio+bounces-12888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DCA9DF2BD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C81162D4B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA781A9B42;
	Sat, 30 Nov 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh6VdmDj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CC132103;
	Sat, 30 Nov 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993603; cv=none; b=IPMc4rQevvY2TZ56SlHyt6uUBHCEF/ONQBIROIUaSPIIJnZq2rIM+YpkgBLyn6VDM8LDEdd716BnGEh/5EkREmvsFWFoyYcCuySp7iDX5xYHQpMjl4Bl5Ds3P8zZt16pqFMS9Bu22CVkoLWr5OF9swqEv99E7g9VTEGPYiTXoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993603; c=relaxed/simple;
	bh=k8M+6H2Ej7owqhe2CTFOEGvZgjli0JoJ1iFZHtwqqB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bg2aUpcqbKVf/LYd98PQOjpbdOAbfYPPROXMdf+WdHj+Vjuj1SglRtdM9gWv8C83+KUfb8nSRogcIg5BGyFIAj4U3lpPi8nKxqztbwW7cOO/wotHslaO0lEX4N25/8WK3X7Z3xba8xEruliqmBUITYynvvK7K5D4v6IGPAS8250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh6VdmDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECC4C4CECC;
	Sat, 30 Nov 2024 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732993602;
	bh=k8M+6H2Ej7owqhe2CTFOEGvZgjli0JoJ1iFZHtwqqB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xh6VdmDjUbG/SCLj1APQhRdP2yGV1/QuoPIOUYos5Z3ts+8IsPbrhwOLXYjRXmPWl
	 Zd6YnadOzhoodJ/8t3kSKIacKpr5DsVY1CsBHON/Xmwt/Jz1sB2T4W9K8fv86boJ4r
	 xJDKnuWFz3XUB+hkPuGiPCjrZGlMGvibYeONWGzEnodRBP3HnVC2l9qR9sgp+gsomf
	 uEx8dgPChBKolRiV9xnYz+lU9GJvCHzIF9VEU5394ELhrXAtNkxIn4fH11r1um4PxT
	 LtLrevsll+Fw54JiMOnoaS0mcgghE8mzNKcGxDOnFQS02GNAO6SWHa/cv1Wsy//KW1
	 wdR+Ilp2rM9LQ==
Date: Sat, 30 Nov 2024 19:06:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad-sigma-delta: Document ABI for sigma
 delta adc
Message-ID: <20241130190633.34489853@jic23-huawei>
In-Reply-To: <20241127-ad411x_calibration-v2-2-66412dac35aa@baylibre.com>
References: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
	<20241127-ad411x_calibration-v2-2-66412dac35aa@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 10:06:14 +0100
Guillaume Ranquet <granquet@baylibre.com> wrote:

> Add common calibration nodes for sigma delta adc.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Hi Guillaume.

I think there are some issues with the old docs that should be tidied up whilst
we are here :(

Just fix them up in this patch then mention it in the patch description.
Or if you prefer move and then fix in separate patches.


Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   | 23 +++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 | 24 ----------------------
>  2 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
> new file mode 100644
> index 0000000000000000000000000000000000000000..c2c55a966163736aea8d46fc5089c08dac747b84
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
> @@ -0,0 +1,23 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
in_voltageY_sys_calibration

(as indices are capital letters and X is used earlier).


> +KernelVersion:
Make an estimate of this I'll never remember to fill them in whilst applying.

It should make the next merge window I hope!

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, initiates the system calibration procedure. This is done on a
> +		single channel at a time. Write '1' to start the calibration.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, returns a list with the possible calibration modes.
> +		There are two available options:
> +		"zero_scale" - calibrate to zero scale
> +		"full_scale" - calibrate to full scale
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, sets up the calibration mode used in the system calibration
> +		procedure. Reading returns the current calibration mode.
> +		Writing sets the system calibration mode.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> index f8315202c8f0df2bd4b7216f5cf8d3c2780fcf3f..28be1cabf1124ac7593392e17e4759ddfac829e8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -19,33 +19,9 @@ Description:
>  		the bridge can be disconnected (when it is not being used
>  		using the bridge_switch_en attribute.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
Huh.  That would explain the x above. I assume it is per channel?

> -KernelVersion:
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Initiates the system calibration procedure. This is done on a
> -		single channel at a time. Write '1' to start the calibration.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
>  KernelVersion:
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Measure voltage from AIN2 pin connected to AIN(+)
>  		and AIN(-) shorted.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
> -KernelVersion:
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Reading returns a list with the possible calibration modes.
> -		There are two available options:
> -		"zero_scale" - calibrate to zero scale
> -		"full_scale" - calibrate to full scale
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
> -KernelVersion:
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Sets up the calibration mode used in the system calibration
> -		procedure. Reading returns the current calibration mode.
> -		Writing sets the system calibration mode.
> 


