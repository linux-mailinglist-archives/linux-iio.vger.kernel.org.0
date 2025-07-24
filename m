Return-Path: <linux-iio+bounces-21973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A7CB10B2B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E081CE36AD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D02D63FB;
	Thu, 24 Jul 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3PubcQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0802D5C6A;
	Thu, 24 Jul 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362915; cv=none; b=DAdDPlq0ay6SbpPuyzjzIRScTqqpomD1qMU+FrIRQbzOK9m/7ldTCaDLd+PDuew4GSth20VXvDCV1TQMpCiwZ6AoyGant7XzuWHDXXdXxaCnhorOC8LvweeILaUs6bRAFCXTOiTo72GNiMB9LtDGrIF35rTfjrS2A6wAbYCEDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362915; c=relaxed/simple;
	bh=WpEm0G2WPt0qGBC7eUSDmcnp3zVE+Ir8y4qppegwJB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZHaxaS825NBw6fCAvoWrykz3wrFRGtwaBbpXm7fXFm/JWK4qWJuEWkBCf0DpfNKGcWjkaNdKeUgkehPQ7IZKI8fYpF6dgYzMAdWnxdmgMoVjA9S2AodiSyuSec1QL64zCZf5jFOj1rhm0GC3p1ZU7CFFBzuoMV1AS3hz4OceXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3PubcQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542D4C4CEED;
	Thu, 24 Jul 2025 13:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362914;
	bh=WpEm0G2WPt0qGBC7eUSDmcnp3zVE+Ir8y4qppegwJB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s3PubcQcX3gix1fbHz+czqjrBmqkq2V6x/FgKiA+FvmtUxn8A3QOFNnLvovqwYcvS
	 2T+WWtKugD5Vzixzufspq9fc0Sqiv1l/1wQB64il3xtWYKGcA85H+bRAzk2j/MiJ1a
	 8Z8To2rEWvBO0kBxRrC93q+GnjhsoWtG1cTutz7QDSHrEs87FbV9IdwEqdR2kbzF3U
	 rqjWtk/W1phQug6xwkZInL6WyMwi3XEP9wXH8Dcoco+aYSDdEjFWlUoS55BZc/Txjh
	 IOKIFC6nlor8+aIWHcS2/5GaBEh3YkQBqudpSYTKYCfu6V6f4xWQ8d36dWyb8QC+8w
	 YXK4odHgk+HPA==
Date: Thu, 24 Jul 2025 14:15:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: ad7173: rename odr field
Message-ID: <20250724141507.4ed285d2@jic23-huawei>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-2-acffe401c4d2@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
	<20250710-iio-adc-ad7137-add-filter-support-v1-2-acffe401c4d2@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 17:39:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Rename odr to sinc5_odr_index in the channel setup structure. In a
> following commit, we will be adding a separate odr field for when the
> sinc3 filter is used instead so having sinc5 in the name will help
> avoid confusion. And _index makes it more clear that this is an index
> of the sinc5_data_rates array and not the output data rate itself.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
This one can't be applied until the fixes has worked it's way back.
Looks fine though.

> ---
>  drivers/iio/adc/ad7173.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 5daf21c6ba5637b2e47dcd052bdd019c3ecbb442..01d78d531d6c024dd92fff21b8b2afb750092b66 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -205,7 +205,7 @@ struct ad7173_channel_config {
>  	struct_group(config_props,
>  		bool bipolar;
>  		bool input_buf;
> -		u8 odr;
> +		u8 sinc5_odr_index;
>  		u8 ref_sel;
>  	);
>  };
> @@ -582,13 +582,13 @@ static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
>  		      sizeof(struct {
>  				     bool bipolar;
>  				     bool input_buf;
> -				     u8 odr;
> +				     u8 sinc5_odr_index;
>  				     u8 ref_sel;
>  			     }));
>  
>  	return cfg1->bipolar == cfg2->bipolar &&
>  	       cfg1->input_buf == cfg2->input_buf &&
> -	       cfg1->odr == cfg2->odr &&
> +	       cfg1->sinc5_odr_index == cfg2->sinc5_odr_index &&
>  	       cfg1->ref_sel == cfg2->ref_sel;
>  }
>  
> @@ -650,7 +650,7 @@ static int ad7173_load_config(struct ad7173_state *st,
>  		return ret;
>  
>  	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
> -			       AD7173_FILTER_ODR0_MASK & cfg->odr);
> +			       AD7173_FILTER_ODR0_MASK & cfg->sinc5_odr_index);
>  }
>  
>  static int ad7173_config_channel(struct ad7173_state *st, int addr)
> @@ -1183,7 +1183,7 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		reg = st->channels[chan->address].cfg.odr;
> +		reg = st->channels[chan->address].cfg.sinc5_odr_index;
>  
>  		*val = st->info->sinc5_data_rates[reg] / MILLI;
>  		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO / MILLI);
> @@ -1229,7 +1229,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
>  				break;
>  
>  		cfg = &st->channels[chan->address].cfg;
> -		cfg->odr = i;
> +		cfg->sinc5_odr_index = i;
>  		cfg->live = false;
>  		break;
>  
> @@ -1655,7 +1655,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan_st_priv->cfg.bipolar = false;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> -		chan_st_priv->cfg.odr = st->info->odr_start_value;
> +		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
>  		chan_st_priv->cfg.openwire_comp_chan = -1;
>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  		if (st->info->data_reg_only_16bit)
> @@ -1727,7 +1727,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan->scan_index = chan_index;
>  		chan->channel = ain[0];
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
> -		chan_st_priv->cfg.odr = st->info->odr_start_value;
> +		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
>  		chan_st_priv->cfg.openwire_comp_chan = -1;
>  
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> 


