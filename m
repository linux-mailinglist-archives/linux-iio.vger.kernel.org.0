Return-Path: <linux-iio+bounces-6059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACD901240
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302A51C209C7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008E17967A;
	Sat,  8 Jun 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es2cKYpq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59797178CE7;
	Sat,  8 Jun 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859723; cv=none; b=CkfRyb/iMzc+TVJvFk0vt8ZnoiYqNl8dbuNHJ2Q/QHEqNsIkoGTvZSyIy3rp20SjViriwl52WqmHdCwweMWtrRqVOdNPZul3ldORKlDIlPqPvlTuHPGMMivrSz9OBMLek+Nkz8rXGafAqY1ZMdzIOGpPk/34yw9bbwA7rIHwpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859723; c=relaxed/simple;
	bh=Dq79I902q9exPmiSAnvDmzqMgzP5nRk6iLkzhlmkOFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqk0RaAkqT9oglsv5LRp2CmgoDu6xoJ34BLmQcVPH3fapKbmtYla61pOEf83wpUnovjFyhhhSbHXb8+vQrgne+2KmdB7AWC6hevNdXmgt3g6XHZodgD8HMq73iecIWQkFnuSxg6I5xRSCtXoXE/v3NEb1VHDy91jLwR14J/6JXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es2cKYpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B12C32786;
	Sat,  8 Jun 2024 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717859723;
	bh=Dq79I902q9exPmiSAnvDmzqMgzP5nRk6iLkzhlmkOFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Es2cKYpq2PNqJQlPsjYFxNwVcQeGwUSZe/4hO+sFhsngrWlYIkusqI0xCPFIzM52/
	 jBiDBKA1zr4T9qEBGbzoMvX892Td82lY3PK7SbElKwf5fRgw5qy6siLnG0GojOXSbr
	 kpb26pGpp/VzlXguN96AUIoPZTS7wcugByHFbPytNfVJyKXl+fjkvHFS/5HxU/YiAW
	 71hkIn5ObSkY5MTVzMFk1XtLFRjfbt3DjFcE7Y068U4jJOCZtB/yw30weQ5gkda9j6
	 HCpOMLJ6EtPANdFqqVb4VcKtcuTdygt+tKy75KuP2NdEsh2rLwrWfNkH0V8wjEuGXS
	 H25Y+kUxpFy2w==
Date: Sat, 8 Jun 2024 16:15:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: frequency: adf4350: add clk provider
Message-ID: <20240608161515.0d63a803@jic23-huawei>
In-Reply-To: <20240607095806.3299-2-antoniu.miclaus@analog.com>
References: <20240607095806.3299-1-antoniu.miclaus@analog.com>
	<20240607095806.3299-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 12:57:53 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add clk provider feature for the adf4350.
> 
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
> 
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - rework commit title
>  drivers/iio/frequency/adf4350.c | 129 ++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 4abf80f75ef5..1eb8bce71fe1 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -19,6 +19,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <asm/div64.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -31,11 +32,21 @@ enum {
>  	ADF4350_PWRDOWN,
>  };
>  
> +struct adf4350_output {
I can't see why this is needed.  Looks to me like you only ever
go from hw here to the state. Use container_of to do that.
> +	struct clk_hw hw;
> +	struct iio_dev *indio_dev;

I wouldn't expect this clk_hw path to need the generic iio structure.
I think you only did this to make the lookup of adf4350_state possible?
If so, as above, container_of() is your friend.

> +};
> +
> +#define to_output(_hw) container_of(_hw, struct adf4350_output, hw)
> +
>  struct adf4350_state {
>  	struct spi_device		*spi;
>  	struct gpio_desc		*lock_detect_gpiod;
>  	struct adf4350_platform_data	*pdata;
>  	struct clk			*clk;
> +	struct clk			*clkout;
> +	const char			*clk_out_name;
> +	struct adf4350_output		output;
>  	unsigned long			clkin;
>  	unsigned long			chspc; /* Channel Spacing */
>  	unsigned long			fpfd; /* Phase Frequency Detector */
> @@ -264,6 +275,10 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
>  	mutex_lock(&st->lock);
>  	switch ((u32)private) {
>  	case ADF4350_FREQ:
> +		if (st->clkout) {
> +			ret = clk_set_rate(st->clkout, readin);
> +			break;
> +		}
>  		ret = adf4350_set_freq(st, readin);
>  		break;
>  	case ADF4350_FREQ_REFIN:
> @@ -381,6 +396,115 @@ static const struct iio_info adf4350_info = {
>  	.debugfs_reg_access = &adf4350_reg_access,
>  };
>  
> +static void adf4350_clk_del_provider(void *data)
> +{
> +	struct adf4350_state *st = data;
> +
> +	of_clk_del_provider(st->spi->dev.of_node);
> +}
> +
> +static unsigned long adf4350_clk_recalc_rate(struct clk_hw *hw,
> +					     unsigned long parent_rate)
> +{
> +	struct iio_dev *indio_dev = to_output(hw)->indio_dev;

You have the output in the state, so use container_of() to get to the
containing structure.

> +	struct adf4350_state *st = iio_priv(indio_dev);
> +	unsigned long long tmp;
> +
> +	tmp = (u64)(st->r0_int * st->r1_mod + st->r0_fract) * st->fpfd;
> +	do_div(tmp, st->r1_mod * (1 << st->r4_rf_div_sel));
> +
> +	return tmp;
> +}

