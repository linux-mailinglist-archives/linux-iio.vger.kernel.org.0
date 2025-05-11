Return-Path: <linux-iio+bounces-19442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD2DAB2965
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C1A18978DE
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E5225C70C;
	Sun, 11 May 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9NHa5Me"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D55259CB8;
	Sun, 11 May 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746977868; cv=none; b=S+MwzceETIM16FoMDtQHE3nBDeuwwrdMSO/numbdrn+IuclgmTbGPiEjRfg0lAIaEZdibths2gxWVxLQQbmPAYAhjmYx7ha+DGq2n/e7N3EurYZkwc4h0+qqTWTunlaBqVEepUkw3+UTA8FG1JDOshZpglWSloUHVVE1gD3kH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746977868; c=relaxed/simple;
	bh=9nNTh6uI2n0PJZ3sXQWFfPFzfXZgtX+EZm6hEopK2K8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAjGxakjk0SS04e0jFGANx/8fNvvR9jFwFCq9mpHJArqJYyqcdc0R/TQXQnzSg174tp8WDZ+eqmNPKyszQk50ERJQNjgMIUilgq3hfbYYuee57yF37PPrAQ4kroSs+omoaF4tQrqTIPmwtwjOAHm7Ax22CV+kKLeysWG353St8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9NHa5Me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156D5C4CEE4;
	Sun, 11 May 2025 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746977867;
	bh=9nNTh6uI2n0PJZ3sXQWFfPFzfXZgtX+EZm6hEopK2K8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E9NHa5MeM64PZa5pdDgGbAnvvhV5Sd55RhREXEDwQE2Lw5bTJzeaeG5ydxLrF5bSV
	 ttAAhphVqawc03QnD+weq3CZSLSzyoMZKW1bBRMcmo5s9v6C1fEQjAWxyJJAShinqK
	 B6WAgdifcIGrpt8UB/LRWIJeZ+8VH/M/SzhfRHirgOoWzGCWNqNw2W5JWGjaYzXzaq
	 L7mJ5d3tah4cnqJZSs7X0moLArLJy/4SND48595JvyvSo/8p+tmiehH4ArJ8T5Mv8h
	 vZ6qZmqF1/cHrjPhKjGoIEa+VgeWMby+V/sUtG8NYveVI+s5RbHFGXE+Z8ZU+gi1ef
	 PzuqZNdBYe1fA==
Date: Sun, 11 May 2025 16:37:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <20250511163739.6612ced4@jic23-huawei>
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-1-91a3f2837e6b@baylibre.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
	<20250508-wip-bl-ad7606-calibration-v4-1-91a3f2837e6b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 May 2025 12:06:05 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add new IIO calibconv_delay documentation.
> 
> The ad7606 implements a phase calibation feature, in nanoseconds.
> Being this a time delay, using the conv_delay suffix.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 190bfcc1e836b69622692d7c056c0092e00f1a9b..9ced916895fbef146d46d17b5fdc932784b4c1df 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -559,6 +559,30 @@ Description:
>  		- a small discrete set of values like "0 2 4 6 8"
>  		- a range specified as "[min step max]"
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay
> +KernelVersion:  6.16
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		Delay of start of conversion in seconds from common reference
> +		point shared by all channels. Can be writable when used to
> +		compensate for delay variation introduced by external filters
> +		feeding a simultaneous sampling ADC.
> +
> +		I.e., for the ad7606 ADC series, this value is intended as a
> +		configurable time delay in seconds, to correct delay introduced

Drop the 'in seconds' here as that is repeating the generic bit above. The rest is
fine subject to formatting Andy noted.

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
> +		is used.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> 


