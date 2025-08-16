Return-Path: <linux-iio+bounces-22847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B131B28F82
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E08188FF30
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C17A2E8DE9;
	Sat, 16 Aug 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU3aUcWJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652E7261C;
	Sat, 16 Aug 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362439; cv=none; b=LIOvCmJGrPsVSKJawuu2hwNgnA+hivrZ9XgYVl47W9Psxk6taKWxZp5u7i44IEjptt9e4ADQucmKkuFMvAYf4DbC/zLPVy6mu84uLqfhp8n4ibiW/XR+QY6ut74L9C+TpAPgYHqo/hpluidQGA9MzTL6xnoKByJ1YuWGkIVZT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362439; c=relaxed/simple;
	bh=n20ZocEQ5b486yxGjR3mzMYx8wP1tNaCNGvSml+GYMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQPoKeBNeS9rcDsFpoKSrsQ/9rJ740Xco4IQD8dWg1hG6zg4gprSs3qkn1fu8GwldKQ/jvQNXpk0+pH49tDbx3yuFZaQrV/CzKwTivTz3BSlEfEDL41bzCmN0736YRkRdIj8Tb2YKo2Alv7yZvuFTon9R+uHWkPtOarSNfltzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU3aUcWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0061C4CEEF;
	Sat, 16 Aug 2025 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755362438;
	bh=n20ZocEQ5b486yxGjR3mzMYx8wP1tNaCNGvSml+GYMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iU3aUcWJe6DVw83sxI/iUaAOuPGuL+xif6/Xdk+fc7dgE8Sgwoge8i76um9RPHFEU
	 5lJz7LBRRDauZoKnlWepDeIEA6UCK65L9Bod3LLA4v1bCdKdOFVDw/2AIlbyNNZcVJ
	 nQK53FnzI2e0WcLOhYsKVG6YDkAE3Gc1Vp0vcE7s2icPCAIGNgwIzyyKPulb7mnS6o
	 xzlVz8/nO6a4AHf6jK2+PUCNYspr5/SvOvfgdH27ny+ml3dGgdOAARnqv0wqkGvAVM
	 57oiyf82Gdskp9O4mJdw5EYn7RufNYAtDYz3NdU9rJjDP955Y0gng4aYV+n97z4/zz
	 U+q3V0AT7EOTw==
Date: Sat, 16 Aug 2025 17:40:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] iio: add power and energy measurement modifiers
Message-ID: <20250816174030.124d280c@jic23-huawei>
In-Reply-To: <20250815095713.9830-3-antoniu.miclaus@analog.com>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
	<20250815095713.9830-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 09:56:35 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add new IIO modifiers to support power and energy measurement devices:
> 
> Power modifiers:
> - IIO_MOD_ACTIVE: Real power consumed by the load
> - IIO_MOD_REACTIVE: Power that oscillates between source and load
> - IIO_MOD_APPARENT: Magnitude of complex power
> - IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency
> - IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)
> 
> Signal quality modifiers:
> - IIO_MOD_RMS: Root Mean Square value
> 
> These modifiers enable proper representation of power measurement
> devices like energy meters and power analyzers.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - add proper KernelVersion and Contact fields to ABI documentation
>  - add detailed description for power factor measurement
>  - add altcurrent RMS measurement support
>  Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++
>  drivers/iio/industrialio-core.c         |  5 +++++
>  include/linux/iio/types.h               |  1 +
>  include/uapi/linux/iio/types.h          |  4 ++++
>  4 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2fb2cea4b192..9d283b23d3c0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -167,7 +167,17 @@ Description:
>  		is required is a consistent labeling.  Units after application
>  		of scale and offset are millivolts.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
> +KernelVersion:	6.15

That was a while back. Will be at least 6.18 unless this was hiding in use in
a driver that I didn't notice.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) RMS voltage measurement from

Spell out RMS so
		Raw (unscaled) Root Mean Square (RMS) voltge measurement from

Also wrapping is odd.  Match rest of file.


> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_powerfactor
> +KernelVersion:	6.15

6.18

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Power factor measurement from channel Y. Power factor is the
> +		ratio of active power to apparent power. The value is unitless.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>  KernelVersion:	3.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -1569,6 +1586,9 @@ Description:

>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_rms_raw
> +KernelVersion:	6.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no bias removal etc.) RMS current measurement from
> +		channel Y. Units after application of scale and offset are milliamps.
As above.

Otherwise all looks good to me.

Jonathan

> +
>  What:		/sys/.../iio:deviceX/in_energy_en
>  What:		/sys/.../iio:deviceX/in_distance_en
>  What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en


