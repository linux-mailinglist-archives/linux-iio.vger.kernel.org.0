Return-Path: <linux-iio+bounces-19119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCEDAA98C7
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F45188424E
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9431F4188;
	Mon,  5 May 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEFjgyDa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7861865E3
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462289; cv=none; b=MF05J9YTNcXa5tMA9QmcymAR94DJqps5I1X665Edkm667XZCSYezvtJX1YHJUAjdYb7310BsuCVPpjOD6Y3LPTvYS7FyCsDSPd6RI7Z58EsUNpLglAe0ycXkrOZQ4VEJY356GGLiuFj4tStPxoEC3F4isPb2Dy4KzUw6BI+4pcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462289; c=relaxed/simple;
	bh=SSFkXo+ypPrgNIUknBNtwIy0LF10pP1LidJc+qQFLX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOD2g4wXhCJ4jWiTVe9z7a26hROHB1W/6G/Cy+hD3bMX0nrgfz6uR5ofB/WsPMAFNQ3kPCqBeKWND3ffCPYlF9Wujs9JAA951BAl32A+/JDqhF7Ndx65UTIQyXtQCrvPPdOVdoyXLiP9ASrmi1y1ohCWJDcshsnPEd2LuNLb2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEFjgyDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97CBC4CEE4;
	Mon,  5 May 2025 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746462288;
	bh=SSFkXo+ypPrgNIUknBNtwIy0LF10pP1LidJc+qQFLX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEFjgyDatb6JM0cIWt4N/yM2FcYpZTqfJ0ZGuHy362BbW0m6mDdX10aYphVBCdF1/
	 TYufF/Su10JzO+4/1WBBxSo8PaOQGtX5Ne4hGf6eIO2FOxu48RtOj2NbGfLadQmFoy
	 Ts1IzAM8QFPoOG9/h+8Re6dxyfz/ydrFYyV0hAyZMNa12UZkPQTNi3KIAupRp2jDIx
	 15qlCFtpaQTywEfApyVNoaLZnLMo41dzpn8q75CiumG3zOzEzR+AZaH2Bj1FjVb+wJ
	 UHc5oK/ewCDiTDR3ajtSG+1ECdZkRLNW6NZQdawyeTi7XEjPWnmLuoQ+kcV0nIaLUo
	 KYfr2l8vj61Mg==
Date: Mon, 5 May 2025 17:24:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Geraldino <gabrielgeraldinosouza@gmail.com>
Cc: orsonzhai@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nicolas Borsari <nicborsari@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sc27xx: Refactor sc27xx_adc_scale_init to
 reduce duplication
Message-ID: <20250505172442.4d555967@jic23-huawei>
In-Reply-To: <20250428034222.318898-1-gabrielgeraldinosouza@gmail.com>
References: <20250428034222.318898-1-gabrielgeraldinosouza@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 05:42:22 +0200
Gabriel Geraldino <gabrielgeraldinosouza@gmail.com> wrote:

> Simplify the sc27xx_adc_scale_init() function by refactoring scale ratio
> initialization logic for SC2720, SC2730, and SC2731 PMICs. This removes
> code duplication by using a data structure to represent channel/scale
> mapping.
> 
> This change improves readability and maintainability without changing
> functional behavior.
> 
> Signed-off-by: Gabriel Geraldino <gabrielgeraldinosouza@gmail.com>
> Co-developed-by: Nicolas Borsari <nicborsari@usp.br>
> Signed-off-by: Nicolas Borsari <nicborsari@usp.br>
Hi Gabriel, Nicolas,

A few comments inline, but overall I'm not sure the code reduction
is sufficiently to cover the resulting loss of readability.
Sometimes a switch is simply clear than a partial look up table.

So nice idea, but I'm not seeing it as being a good move for this particular code.
I'd be slightly interested to see the optimized output of the two approaches, but
this is far from a high performance path so we care a lot more about readability here.


Thanks,

Jonathan


> ---
>  drivers/iio/adc/sc27xx_adc.c | 90 +++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 2535c2c3e..a8312859d 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -407,78 +407,52 @@ static int sc2731_adc_get_ratio(int channel, int scale)
>  /*
>   * According to the datasheet set specific value on some channel.
>   */
> +struct adc_channel_scale {
> +	int channel;
> +	int scale;
> +};
> +
> +static void sc27xx_adc_scale_init(struct sc27xx_adc_data *data,
> +	const struct adc_channel_scale *table,
> +	int table_len,
> +	int default_scale)

Style wise, I'd prefer these aligned after the (
I don't think this will even go over 80 chars but if it did that would
be fine if it doesn't go over by much.

> +{
> +	int j;
> +
> +	for (j = 0; j < sizeof(data->channel_scale); j++)
> +		data->channel_scale[j] = default_scale;
> +
> +	for (j = 0; j < table_len; j++)
> +		data->channel_scale[table[j].channel] = table[j].scale;
> +}
> +
>  static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
>  {
> -	int i;
> -
> -	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> -		switch (i) {
> -		case 5:
> -			data->channel_scale[i] = 3;
> -			break;
> -		case 7:
> -		case 9:
> -			data->channel_scale[i] = 2;
> -			break;
> -		case 13:
> -			data->channel_scale[i] = 1;
> -			break;
> -		case 19:
> -		case 30:
> -		case 31:
> -			data->channel_scale[i] = 3;
> -			break;
> -		default:
> -			data->channel_scale[i] = 0;
> -			break;
> -		}
> -	}
> +	static const struct adc_channel_scale sc2720_table[] = {
> +		{5, 3}, {7, 2}, {9, 2}, {13, 1}, {19, 3}, {30, 3}, {31, 3}

Spaces after { and before }

> +	};
> +	sc27xx_adc_scale_init(data, sc2720_table, ARRAY_SIZE(sc2720_table), 0);
>  }
>  
>  static void sc2730_adc_scale_init(struct sc27xx_adc_data *data)
>  {
> -	int i;
> -
> -	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> -		switch (i) {
> -		case 5:
> -		case 10:
> -		case 19:
> -		case 30:
> -		case 31:
> -			data->channel_scale[i] = 3;
> -			break;
> -		case 7:
> -		case 9:
> -			data->channel_scale[i] = 2;
> -			break;
> -		case 13:
> -			data->channel_scale[i] = 1;
> -			break;
> -		default:
> -			data->channel_scale[i] = 0;
> -			break;
> -		}
> -	}
> +	static const struct adc_channel_scale sc2730_table[] = {
> +		{5, 3}, {10, 3}, {19, 3}, {30, 3}, {31, 3},
> +		{7, 2}, {9, 2}, {13, 1}
> +	};
> +	sc27xx_adc_scale_init(data, sc2730_table, ARRAY_SIZE(sc2730_table), 0);
>  }
>  
>  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  {
> -	int i;
>  	/*
>  	 * In the current software design, SC2731 support 2 scales,
>  	 * channels 5 uses big scale, others use smale.
>  	 */
> -	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> -		switch (i) {
> -		case 5:
> -			data->channel_scale[i] = 1;
> -			break;
> -		default:
> -			data->channel_scale[i] = 0;
> -			break;
> -		}
> -	}
> +	static const struct adc_channel_scale sc2731_table[] = {
> +		{5, 1}
> +	};
> +	sc27xx_adc_scale_init(data, sc2731_table, ARRAY_SIZE(sc2731_table), 0);
>  }
>  
>  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,


