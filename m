Return-Path: <linux-iio+bounces-20073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D5AC9BA1
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E16189ED23
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C981156C79;
	Sat, 31 May 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9wFa3tv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D7DF42;
	Sat, 31 May 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748707655; cv=none; b=oV26+ai0X0KKLllNIq/lp+rW8PkntTkh9DfTBLbCeiiEYlaKsuqe4m8WqbUXlx5KTZteZWvmhro6pBwur4t6d2lMykmX9H2Mu/fCdeDBfqv1zHUmZtOJV+XgQU9acUm4e29PoraYneY6C43BtKcXzWixRDOL6JwacjTZ/WC5D78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748707655; c=relaxed/simple;
	bh=1FC4MvVxMQ36EngaozUWlCkIiO99uwphbqFgEWrruRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoJpfd/l4xPZRXSvwL3Ep9J+49oHjML0jWfmvscZbQQ0mRaCEdLv88xF47UeWQcl8NnYHmlufLo/b65BJKRcV0VhBiQsImUUtcDA6TlJHmMcQmCNusUVtB41/wAG88GFThavyzhro1WVxMSziAOkcAu1XHErgB96s5CN09YOuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9wFa3tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19746C4CEE3;
	Sat, 31 May 2025 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748707654;
	bh=1FC4MvVxMQ36EngaozUWlCkIiO99uwphbqFgEWrruRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9wFa3tvHznaSClIqfzBwnBZqBdeA9+lYZOHWXLSLE5sjUWAfFBs2dyOj+I6LHDck
	 prTql7KGRScldruTcEDeqD3in9ZgHaTWsmRbHoCpCoNGljDs8Yzh/kKPMb6dIRqBsN
	 7swqrhUqBwlYhxMFNU0wSIkGFMq58KzHPyxVAsE2Cq3akxBrichUenH4bCxK4jrXMc
	 NBJ/RpdH4bcXsfTjvR84N58ZiaoYNcwDJr98xycIcSvVsUqWtZtRTXBjx4CV56yIVa
	 L9p0Fz3hD0sr9VAMYR5g3w5RY94oxU2wuEfj4ANxOaQgRSLqmE43tIiNx48wEUfGLJ
	 3xe3JICeiA7hg==
Date: Sat, 31 May 2025 17:07:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/6] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <20250531170724.12373532@jic23-huawei>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-1-b487022ce199@baylibre.com>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
	<20250526-wip-bl-ad7606-calibration-v7-1-b487022ce199@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 12:03:16 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add new IIO "convdelay" documentation.
That's not what the patch title says... It's called calibconv_delay still
there.

I'd fix that and version number, but looks like you are going to be doing
a v8 anyway based on David's feedback on patch 6.

Jonathan

> 
> The ad7606 implements a phase calibation feature, in nanoseconds.
> Being this a time delay, using the convdelay suffix.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ef52c427a015cf47bb9847782e13afbee01e9f31..7e59cbd5acb85fd0909c1d56f9d76a84933d418a 100644
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
> +		E.g., for the ad7606 ADC series, this value is intended as a
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
> +		If shared across all channels, <type>_convdelay_available
> +		is used.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> 


