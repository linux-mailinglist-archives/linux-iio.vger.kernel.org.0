Return-Path: <linux-iio+bounces-5315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7EB8CF45C
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 15:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86B8281462
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB4DF43;
	Sun, 26 May 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA+CJcb5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C848F6A;
	Sun, 26 May 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716728506; cv=none; b=NmOULs1+h2KA9WFtnzGJYNVUu9G15VmrJ4ckRW1hTSNRHMPqsTLW7gT/qHgdxC3JGkD1z462IKEuMYxgFZdzESJPIvH2sePUHENLZ5m3esI+c5200x0Qw2gNxhLWks+GqMn0LarMsJIZgWD1FhQRvZ+BApVXcrNSYFnJFMwtUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716728506; c=relaxed/simple;
	bh=mUAswdY4bkKjHRY+od08oRhrXZZBaKuBJrPUOu+kkyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfEGlQJtNkWNAV+rV3ldj7+MoAM+lu3X9IRxdpKbNEFfMx+ETISHaih38YvSr5kyomEGyq/ukh1N+JTc6WEF/u7B6DZKVJaMHbEEOXrC8yKqGtqLMHPHiReNSQ/TVqxbJuYPjNt46vfMNVjjePmdgge16BsrtCgYz5SoGlsOlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA+CJcb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B34C2BD10;
	Sun, 26 May 2024 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716728506;
	bh=mUAswdY4bkKjHRY+od08oRhrXZZBaKuBJrPUOu+kkyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PA+CJcb5Gd8Bidlh90pG+Uk1TjcCimjj9/c0tyAt4C5/0A0MCAeIJKMmI1MW/KEw5
	 XXszos+HjQubyM87KxlNwJutTsuiTymdMidKNK05bU+Nzd+zzQrv7Hez3FX7nV82F3
	 928uMZ0H6IUQ4DVZsbGfdmYFnZ1ZFFBTMQmIfO5RqLsww9CSEhoZF67FzNT1PszGOJ
	 xiEVWlHuhqFk/JUh11rGg4I8Bk60uOLOZcXp3Gn2zyO8Bns6GD+9PNm68bSAJuzk/8
	 2ZeyPV3O5EjhtVijflCFVgnJwtuiaqr0cN2PN/s1zJc/sTxnrU+Pk13Cr4l2eYEQlK
	 J318T/De1Ex9w==
Date: Sun, 26 May 2024 14:01:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v4 10/10] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240526140108.0abd1ef5@jic23-huawei>
In-Reply-To: <20240524090329.340810-1-ramona.bolboaca13@gmail.com>
References: <20240524090329.340810-1-ramona.bolboaca13@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 12:03:29 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Add support for ADIS1657X family devices in already exiting ADIS16475
> driver.
> 
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>

Some minor comments seeing as you will be doing a v5.
Many of these I might have just tweaked whilst applying (line breaks etc)
but easier for me if you do it ;)

Jonathan


> +
>  static const struct adis_timeout adis16475_timeouts = {
>  	.reset_ms = 200,
>  	.sw_reset_ms = 200,
> @@ -760,7 +929,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
>  		.sync = adis16475_sync_mode,
>  		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
>  		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts,
> -					    ADIS16475_BURST32_MAX_DATA,
> +					    ADIS16475_BURST32_MAX_DATA_NO_TS32,

Avoid the noise in here by moving the rename to where this was extended in an earlier
patch.  Just add a note there to say why you are naming it NO_TS32
at that point.

>  };

> @@ -1264,20 +1582,30 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
>  	__be16 *buffer;
>  	u16 crc;
>  	bool valid;
> +	u8 crc_offset = 9;
> +	u16 burst_size = ADIS16475_BURST_MAX_DATA;
> +	u16 start_idx = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 2 : 0;
> +
>  	/* offset until the first element after gyro and accel */
>  	const u8 offset = st->burst32 ? 13 : 7;
> 
> +	if (st->burst32) {
> +		crc_offset = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 16 : 15;
> +		burst_size = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ?
> +			     ADIS16575_BURST32_DATA_TS32 : ADIS16475_BURST32_MAX_DATA_NO_TS32;
> +	}
> +
>  	ret = spi_sync(adis->spi, &adis->msg);
>  	if (ret)
> -		goto check_burst32;
> +		return ret;
> 
>  	buffer = adis->buffer;
> 
> -	crc = be16_to_cpu(buffer[offset + 2]);
> -	valid = adis16475_validate_crc(adis->buffer, crc, st->burst32);
> +	crc = be16_to_cpu(buffer[crc_offset]);
> +	valid = adis16475_validate_crc(adis->buffer, crc, burst_size, start_idx);
>  	if (!valid) {
>  		dev_err(&adis->spi->dev, "Invalid crc\n");
> -		goto check_burst32;
> +		return ret;
>  	}
> 
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
> @@ -1337,23 +1665,127 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
>  		}
>  	}
> 
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
> -check_burst32:
> +	if (adis->data->has_fifo)
> +		iio_push_to_buffers(indio_dev, st->data);
> +	else
> +		iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
You could be lazy here and not separate the two cases. I think we are guaranteed
in the has_fifo case that the timestamp will never be turned on. Hence
iio_push_to_buffers_with_timestamp() is effectively identical to
iio_push_to_buffers().

However for reasons of potential tightening on buffer sizing that we have
been talking about (adding checks into the iio_push_to_buffers() family that
enough data is pushed), this may need to come back.  However that set of changes
will require a per driver move to new interfaces anyway.

So if you want to just always call iio_push_to_buffers_with_timestamp()
go ahead but add a comment here that there might not be a timestamp option
for some devices.

> +
> +	return 0;
> +}
> +

> @@ -1367,6 +1799,14 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
>  	u32 sync_mode;
>  	u16 max_sample_rate = st->info->int_clk + 100;
> 
> +	/* if available, enable 4khz internal clock */
> +	if (st->info->int_clk == 4000) {
> +		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16575_SYNC_4KHZ_MASK, (u16)ADIS16575_SYNC_4KHZ(1));
line break in line above.  
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* default to internal clk */
>  	st->clk_freq = st->info->int_clk * 1000;
> 
> @@ -1444,34 +1884,67 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
...
> +	if (st->adis.data->has_fifo) {
> +		/*
> +		 * It is possible to configure the fifo watermark pin polarity.
> +		 * Furthermore, we need to update the adis struct if we want the
> +		 * watermark pin active low.
> +		 */
> +		if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
> +			polarity = 1;
> +			st->adis.irq_flag = IRQF_TRIGGER_HIGH;
> +		} else if (irq_type == IRQ_TYPE_LEVEL_LOW) {
> +			polarity = 0;
> +			st->adis.irq_flag = IRQF_TRIGGER_LOW;
> +		} else {
> +			dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
> +				irq_type);
> +			return -EINVAL;
> +		}
> +
> +		/* Configure the watermark pin polarity. */
> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> +				       ADIS16575_WM_POL_MASK, (u16)ADIS16575_WM_POL(polarity));

Add a line beak in the line above.

> +		if (ret)
> +			return ret;
> +
> +		/* Enable watermark interrupt pin. */
> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> +				       ADIS16575_WM_EN_MASK, (u16)ADIS16575_WM_EN(1));

Line break in line above.

> +		if (ret)
> +			return ret;
> +
>  	} else {


