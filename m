Return-Path: <linux-iio+bounces-24717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE060BB8ED4
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8850C3C614F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142CD20C463;
	Sat,  4 Oct 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swhG2/at"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281A145B3F;
	Sat,  4 Oct 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588290; cv=none; b=JjS8VTgIDQdM0Ce7Dp/4M74Fhv8PfFBzplyVoDWrPihBPHCQIcFiw6oyW1F/2cv9T9MA7evxf9QtQGqP76Uho11fvoCZ6Co8bjnEK48yvuYKLo2oVQKnGv8V14VCW0pqL4fUpoxFdAjxxwdF1et4s+OGXrQYTLqx1Nw1Cnsvejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588290; c=relaxed/simple;
	bh=7I9cs/CZgED4iFSnKxJlz8RXYc/lFuGyZFexuMMRKWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8BgCuiFK+5YknGh4VUD9LMbmiyBpBO80lPZMyfzFMUuuH7smcs5U9djGQmfmNUi9K/DvD7Mn1PF/WtXpNf6Ai235lXC5p5TpfTFepfBWWCtIsWw/NYhgc6RF1RaOXDdR1b6XJ1YT+D9+jRGoifjSTM2ES19AI7lQOP1JpR3zWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swhG2/at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4E8C4CEF1;
	Sat,  4 Oct 2025 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759588290;
	bh=7I9cs/CZgED4iFSnKxJlz8RXYc/lFuGyZFexuMMRKWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=swhG2/atqORA2zXzxRuCGA5HDC/Y7Y4PcbdiUfUpmVlQbDd+NScOmjRL9MHLrK4H9
	 7CZiDCSw2iH3CzmLDkVvq7kpfRBk1XYA3EvgLQTCloKccWnJNPYKzMqT5o+E8V4g2U
	 VGS61RBSpL6VLP3Uwh5BId7Im5jaadP5yXpm8A3TUCeKzZwaNtJpyQWZmC2G+K6DYy
	 o2E9g15Tz/WjAMi2KiAra9cuWIm/ecBmKPObkiXugNYUjqStN2wrolc9Zdm2mjirLK
	 Pxffe4TnxdeQGtmprcxRS0Xk4AoXZ9/uM98rvJeLMnStxxiTRcpaOz/H3XWcEKRBvH
	 IEVbI7Bk1UHlQ==
Date: Sat, 4 Oct 2025 15:31:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Abhash Jha
 <abhashkumarjha123@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] iio: adc: mt6360: Handle error in cleanup path
 correctly
Message-ID: <20251004153125.2e46b6ff@jic23-huawei>
In-Reply-To: <20250929162453.1203-1-vulab@iscas.ac.cn>
References: <20250929025358.2064-1-vulab@iscas.ac.cn>
	<20250929162453.1203-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 00:24:53 +0800
Haotian Zhang <vulab@iscas.ac.cn> wrote:

> The return value of a regmap_raw_write() and regmap_update_bits()
> in the cleanup path was being ignored.
> 
> Fix this by checking the return value and warn on error.
> 
> Fixes: 1f4877218f7e ("iio: adc: mt6360: Add ADC driver for MT6360")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> 
> ---
> Changes in v2:
>  - Do not propagate cleanup path errors.
>  - Log a warning on failure instead of overwriting the return value, as
>    suggested by the maintainer.

As below. I think dev_err() is appropriate.

>  - Also check the return value of regmap_update_bits() for consistency.
> ---
>  drivers/iio/adc/mt6360-adc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index 69b3569c90e5..9ee7247aacbe 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -70,6 +70,7 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
>  	ktime_t predict_end_t, timeout;
>  	unsigned int pre_wait_time;
>  	int ret;
> +	int cleanup_ret;
>  
>  	mutex_lock(&mad->adc_lock);
>  
> @@ -130,11 +131,16 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
>  out_adc_conv:
>  	/* Only keep ADC enable */
>  	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
> -	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable, sizeof(adc_enable));
> +	cleanup_ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG,
> +				&adc_enable, sizeof(adc_enable));
> +	if (cleanup_ret)
> +		dev_warn(mad->dev, "Failed to reset ADC config: %d\n", cleanup_ret);
Why warn? If this happens it's definite and error and may bite us later.

>  	mad->last_off_timestamps[channel] = ktime_get();
>  	/* Config prefer channel to NO_PREFER */
> -	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> +	cleanup_ret = regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
>  			   MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
> +	if (cleanup_ret)
> +		dev_warn(mad->dev, "Failed to reset prefer channel: %d\n", cleanup_ret);
>  out_adc_lock:
>  	mutex_unlock(&mad->adc_lock);
>  

Maybe it is worth trying to surface the error if nothing else has already gone wrong. That is a little fiddly
to do but something like

	if (cleanup_ret) {
		dev_err()
		ret = ret ?: cleanup_ret;
	}

I'm not sure it is worth the complexity however, so perhaps see if others have comments on this
in next few days before spinning a v3.

Thanks,

Jonathan

