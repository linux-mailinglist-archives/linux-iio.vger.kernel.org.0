Return-Path: <linux-iio+bounces-9288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB719702E8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC772841FD
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7315D5AB;
	Sat,  7 Sep 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+oVUUX5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A50134B1;
	Sat,  7 Sep 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725722554; cv=none; b=sKMt1Zwk4Nf5M+goPFpnIqvIJr/u4loLgMXb5NL4DsDZPcyMdxwCthrRz2kjEBUOnDhN9f7Dn/f2MChIAIEhM03AxPtrrZCRnEMnQzGbh0XzzYp59ydK+Yj7vO1XWPWjyAGqQ85N/oeVgrTKrmgg+MOigbvjdLc+RQuqCmEI5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725722554; c=relaxed/simple;
	bh=/xoS0KLcsD6th5CKrXDqMl+P3JjyyA0HfpOnHXW8ETo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgyhGH1SoBIJLxNUb2FYXkSgQG6S6IGP6XbKth6TjHpks6LvhgXdJ7ghLTxuF9qn9iek/dcmu9/j7w/EUkQjCukpoVqGavfdEMRIy3tGZSxNR7KnwQnPruZdKg419MuXZYYo6MUzSsXpYDutMrQdbrm/Tb4i2juV6+WXu8cfAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+oVUUX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E117C4CEC2;
	Sat,  7 Sep 2024 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725722554;
	bh=/xoS0KLcsD6th5CKrXDqMl+P3JjyyA0HfpOnHXW8ETo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+oVUUX59EP0zFLzTloBipHC5+yUQSx0zWgxulpGGtv3vKFeW7o/jNFFHf5JDw6or
	 5iy06SZv6iS+/VPQGIXJICZHXChB7e95BQSXEXZgZUhss85mc3hjHvg+2ktVa9cjBz
	 O4lQGGoXN2FE2k4653o0vWxS6NHuRxwTiF5Wq5xvVBK/F2bBR8k2UAeTTCXZyYW5SB
	 g2OuJaKdM8udMRA8vNPlziXzyy3THetx0E3BsrzP2G4Y9x9sneFT2N4ZB+Jfeq+VWI
	 gyWJsfPFtN2L35aQTe4LyFAVpleAkQXrCVe5G43v0H2d11wWzu9pRmzbV+vR+qNfy5
	 +dvTR4GyohuEg==
Date: Sat, 7 Sep 2024 16:22:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74xxx: Constify struct iio_chan_spec
Message-ID: <20240907162227.16fc102e@jic23-huawei>
In-Reply-To: <da291278e78b983ea2e657a25769f7d82ea2a6d0.1725717045.git.christophe.jaillet@wanadoo.fr>
References: <da291278e78b983ea2e657a25769f7d82ea2a6d0.1725717045.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Sep 2024 15:51:07 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct iio_chan_spec' are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   35749	   5879	    384	  42012	   a41c	drivers/iio/addac/ad74115.o
>   32242	   3297	    384	  35923	   8c53	drivers/iio/addac/ad74413r.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   39109	   2519	    384	  42012	   a41c	drivers/iio/addac/ad74115.o
>   33842	   1697	    384	  35923	   8c53	drivers/iio/addac/ad74413r.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Looks obviously correct.  Hopefully looks are not being deceiving.

Applied.  Note this is probably next cycle material now given timing.
Jonathan

> ---
> Compile tested only
> ---
>  drivers/iio/addac/ad74115.c  | 18 +++++++++---------
>  drivers/iio/addac/ad74413r.c | 21 +++++++++++----------
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> index 12dc43d487b4..bdbdd67536ff 100644
> --- a/drivers/iio/addac/ad74115.c
> +++ b/drivers/iio/addac/ad74115.c
> @@ -191,7 +191,7 @@ enum ad74115_gpio_mode {
>  };
>  
>  struct ad74115_channels {
> -	struct iio_chan_spec		*channels;
> +	const struct iio_chan_spec	*channels;
>  	unsigned int			num_channels;
>  };
>  
> @@ -1295,46 +1295,46 @@ static const struct iio_info ad74115_info = {
>  	_AD74115_ADC_CHANNEL(_type, index, BIT(IIO_CHAN_INFO_SCALE)	\
>  					   | BIT(IIO_CHAN_INFO_OFFSET))
>  
> -static struct iio_chan_spec ad74115_voltage_input_channels[] = {
> +static const struct iio_chan_spec ad74115_voltage_input_channels[] = {
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
>  };
>  
> -static struct iio_chan_spec ad74115_voltage_output_channels[] = {
> +static const struct iio_chan_spec ad74115_voltage_output_channels[] = {
>  	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_MAIN),
>  	AD74115_ADC_CHANNEL(IIO_CURRENT, AD74115_ADC_CH_CONV1),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
>  };
>  
> -static struct iio_chan_spec ad74115_current_input_channels[] = {
> +static const struct iio_chan_spec ad74115_current_input_channels[] = {
>  	AD74115_ADC_CHANNEL(IIO_CURRENT, AD74115_ADC_CH_CONV1),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
>  };
>  
> -static struct iio_chan_spec ad74115_current_output_channels[] = {
> +static const struct iio_chan_spec ad74115_current_output_channels[] = {
>  	AD74115_DAC_CHANNEL(IIO_CURRENT, AD74115_DAC_CH_MAIN),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
>  };
>  
> -static struct iio_chan_spec ad74115_2_wire_resistance_input_channels[] = {
> +static const struct iio_chan_spec ad74115_2_wire_resistance_input_channels[] = {
>  	_AD74115_ADC_CHANNEL(IIO_RESISTANCE, AD74115_ADC_CH_CONV1,
>  			     BIT(IIO_CHAN_INFO_PROCESSED)),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
>  };
>  
> -static struct iio_chan_spec ad74115_3_4_wire_resistance_input_channels[] = {
> +static const struct iio_chan_spec ad74115_3_4_wire_resistance_input_channels[] = {
>  	AD74115_ADC_CHANNEL(IIO_RESISTANCE, AD74115_ADC_CH_CONV1),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
>  };
>  
> -static struct iio_chan_spec ad74115_digital_input_logic_channels[] = {
> +static const struct iio_chan_spec ad74115_digital_input_logic_channels[] = {
>  	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_COMPARATOR),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV2),
>  };
>  
> -static struct iio_chan_spec ad74115_digital_input_loop_channels[] = {
> +static const struct iio_chan_spec ad74115_digital_input_loop_channels[] = {
>  	AD74115_DAC_CHANNEL(IIO_CURRENT, AD74115_DAC_CH_MAIN),
>  	AD74115_DAC_CHANNEL(IIO_VOLTAGE, AD74115_DAC_CH_COMPARATOR),
>  	AD74115_ADC_CHANNEL(IIO_VOLTAGE, AD74115_ADC_CH_CONV1),
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 2410d72da49b..1e2f6d9804e3 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -45,8 +45,8 @@ struct ad74413r_channel_config {
>  };
>  
>  struct ad74413r_channels {
> -	struct iio_chan_spec	*channels;
> -	unsigned int		num_channels;
> +	const struct iio_chan_spec	*channels;
> +	unsigned int			num_channels;
>  };
>  
>  struct ad74413r_state {
> @@ -1138,34 +1138,34 @@ static const struct iio_info ad74413r_info = {
>  	AD74413R_ADC_CHANNEL(IIO_CURRENT,  BIT(IIO_CHAN_INFO_SCALE)	\
>  			     | BIT(IIO_CHAN_INFO_OFFSET))
>  
> -static struct iio_chan_spec ad74413r_voltage_output_channels[] = {
> +static const struct iio_chan_spec ad74413r_voltage_output_channels[] = {
>  	AD74413R_DAC_CHANNEL(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE)),
>  	AD74413R_ADC_CURRENT_CHANNEL,
>  };
>  
> -static struct iio_chan_spec ad74413r_current_output_channels[] = {
> +static const struct iio_chan_spec ad74413r_current_output_channels[] = {
>  	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
>  	AD74413R_ADC_VOLTAGE_CHANNEL,
>  };
>  
> -static struct iio_chan_spec ad74413r_voltage_input_channels[] = {
> +static const struct iio_chan_spec ad74413r_voltage_input_channels[] = {
>  	AD74413R_ADC_VOLTAGE_CHANNEL,
>  };
>  
> -static struct iio_chan_spec ad74413r_current_input_channels[] = {
> +static const struct iio_chan_spec ad74413r_current_input_channels[] = {
>  	AD74413R_ADC_CURRENT_CHANNEL,
>  };
>  
> -static struct iio_chan_spec ad74413r_current_input_loop_channels[] = {
> +static const struct iio_chan_spec ad74413r_current_input_loop_channels[] = {
>  	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
>  	AD74413R_ADC_CURRENT_CHANNEL,
>  };
>  
> -static struct iio_chan_spec ad74413r_resistance_input_channels[] = {
> +static const struct iio_chan_spec ad74413r_resistance_input_channels[] = {
>  	AD74413R_ADC_CHANNEL(IIO_RESISTANCE, BIT(IIO_CHAN_INFO_PROCESSED)),
>  };
>  
> -static struct iio_chan_spec ad74413r_digital_input_channels[] = {
> +static const struct iio_chan_spec ad74413r_digital_input_channels[] = {
>  	AD74413R_ADC_VOLTAGE_CHANNEL,
>  };
>  
> @@ -1270,7 +1270,8 @@ static int ad74413r_setup_channels(struct iio_dev *indio_dev)
>  {
>  	struct ad74413r_state *st = iio_priv(indio_dev);
>  	struct ad74413r_channel_config *config;
> -	struct iio_chan_spec *channels, *chans;
> +	const struct iio_chan_spec *chans;
> +	struct iio_chan_spec *channels;
>  	unsigned int i, num_chans, chan_i;
>  	int ret;
>  


