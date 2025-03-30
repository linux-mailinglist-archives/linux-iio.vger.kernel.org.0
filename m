Return-Path: <linux-iio+bounces-17364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2273A75B4F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D871696E9
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CC1D88D7;
	Sun, 30 Mar 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U39vS1EG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EF6F305;
	Sun, 30 Mar 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354808; cv=none; b=TrPKPv3LAI8YCArUQOGi/6B0oOMH7YxY6BVAe5KuBN6FSfJzr79lyZCfJTnMoULhHLAouNReJ+A+/u6YfUz/SFXhcigAIAMBXj6ADoO+OpheRzkv66PrsaErQh2hea/kLDrV+IU+wONWsg4tHEm3+PwiXPLpekDX8Ve6QFeoRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354808; c=relaxed/simple;
	bh=Q0qSpPl1HH6zE++FjNqKOT6fTavVluZWa0aAD+KRXfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfwH832TvroeClqwri63aQNuk+l8hnTr6S99oecXj3RlGfRtNvhB8H7c/ogc/Vi9gkUWu4GJ9PdLozne5QqjgbNXUesjABpqh26DG0MFLwdL0rYhJkMO34u4ya1DqcWM0fMuj/lSHVGruHNDpFaOF0UITsYMjUVEQXnCwaQOxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U39vS1EG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF9EC4CEDD;
	Sun, 30 Mar 2025 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743354808;
	bh=Q0qSpPl1HH6zE++FjNqKOT6fTavVluZWa0aAD+KRXfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U39vS1EGVVfM7r1h6lM8e3x4JuX5FlPcJY+L/ua4/9wy7O+lZ39KA2iAejXtoFvUY
	 vVUUCSRjLNcxfEC56U8xeswNlSxGMLQOp9tygLvpBWsmJ8hto25OtELyTd9R5B2Bae
	 fhCFvnZWYzsY05ytY9K+SsbCzcGToWBjmPkwvUwPd/BG3OCNQS1HmXFB38hZsbhycP
	 JqlprtXAbG5DvVYhI16qilQ0+ABCrnjt4DhMM77Mh7Z4bk+5+iCwIflsmtioXwpcyH
	 AzRwPYvzGT/rn5GmT1fRQknEpYyNFSBGJKPf9fv1tlnUCu/XURAUAkC9mS06NeWuBd
	 i8LtanAcxNsRw==
Date: Sun, 30 Mar 2025 18:13:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <dlechner@baylibre.com>,
 <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <20250330181320.0ec4351c@jic23-huawei>
In-Reply-To: <20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
	<20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 15:50:02 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> Some devices have an internal clock used to space out the conversion
> trigger for the oversampling filter,
> Consider an ADC with conversion and data ready pins topology:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   ++++    ++++    ++++    ++++    ++++
>   ADC data ready      *       *       *       *       *
> 
> With the oversampling frequency, conversions can be evenly space between
> the sampling edge:

I'm not sure what this second example is providing.  Are you suggesting
that if we don't provide oversampling frequency we should assume this
pattern?  i.e. it is the default?

> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
>   ADC data ready         *       *       *       *       *
> 
In general this patch needs to go in with the first driver using it.
I don't think we have any such driver yet?

> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 33c09c4ac60a4feec82308461643134f5ba84b66..2317bacf6a2884691a08725d6f01d18555a96227 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Hardware dependent values supported by the oversampling filter.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> +KernelVersion:	6.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Some devices have internal clocks for the ADC oversampling.
I wonder if we can hint at your diagram above?
Maybe
		Some devices have internal clocks for the ADC oversampling allowing
		the over samples to be bunched up, rather than evenly spread over the
		period set by the sampling frequency.

> +		Sets the resulting sampling frequency to trigger a conversion
> +		used by the oversampling filter.
> +		Can be used to evenly space conversion between the sampling edge
> +		on some devices.
I'd skip this last line, or maybe say something like:

		If not provided, the default assumption is that the oversamples
		are evenly spread over the period of the sample.

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


