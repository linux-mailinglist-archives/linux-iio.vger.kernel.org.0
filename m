Return-Path: <linux-iio+bounces-6758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91597913BDF
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E271F222B9
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A7148FE6;
	Sun, 23 Jun 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ8Zhmwi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295B20E6;
	Sun, 23 Jun 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719154879; cv=none; b=qFeQdBPtX0ls6hVmPH8WOb0kk4s3EQvqZiaGS7qYvVWT1NWjTRBxkTZjCwutuNeQNvKrAkLjaYY/xrht0+ni42TfDbYBHBqtEFUskb/jfzhxOsakFx1+nr0MO2vLhMVFraeKn/NgutUW3SmDZQYAX4HvSZ/dHC+3oarKkIA/Xiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719154879; c=relaxed/simple;
	bh=pLL5EMg6eoF8fo4wvsJ8liZlmjZcP3+0z3EaGf28jIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HExg7pHm3TQlojuDegDENI46R1etCbzEBfBRDqDZ1m+qnrDttbl/11G9RrychvSiSsmDGwHPXbqQx4ia9gjnQtZ7BhlNxr4MZvofOKyrBx4FFhfTXQJBTthXPM0ZPlzxN+Lt58O8MbDcwfom/fubH4tIGTAfeHCM3Xo3bYzxsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ8Zhmwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D699C2BD10;
	Sun, 23 Jun 2024 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719154878;
	bh=pLL5EMg6eoF8fo4wvsJ8liZlmjZcP3+0z3EaGf28jIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oZ8Zhmwi++sv43JIaLV3EeEl6tMSMVE08IJQfwF6QpLLYs6I/4wbFsrsOXX5dcEEB
	 XeiTJyJHikVUmlEBINZAFZGwqtpkVL2jTMDlSOooQ/uwCu4hoRcVM7JGy4pg/A/ct0
	 GL4jsvEtLVRY39ou7VzKS5i5eYfxt6nEBWxbciUr6S8lnlnDNnsIdVxjfOFjdiZS1S
	 D9ZE9/YPS/GIttRocC9evp+dqnEB1CE0zWwnqbDDnzQ34aPUyUtKo3Rm+THXS3miKA
	 E+eQmYJEmJJH9F3bELBzlD9KX5ZQp7En6tDmjZanwFN57mZtsrCDdAt0nAGsjZofGQ
	 jSpdPi6fm+qkQ==
Date: Sun, 23 Jun 2024 16:01:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] iio: adc: stm32-dfsdm: adopt generic channels
 bindings
Message-ID: <20240623160111.3a675e0b@jic23-huawei>
In-Reply-To: <20240618160836.945242-7-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	<20240618160836.945242-7-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:08:32 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Move to generic channels binding to ease new backend framework adoption
> and prepare the convergence with MDF IP support on STM32MP2 SoC family.
> 
> Legacy binding:
> DFSDM is an IIO channel consumer.
> SD modulator is an IIO channels provider.
> The channel phandles are provided in DT through io-channels property
> and channel indexes through st,adc-channels property.
> 
> New binding:
> DFSDM is an IIO channel provider.
> The channel indexes are given by reg property in channel child node.
> 
> This new binding is intended to be used with SD modulator IIO backends.
> It does not support SD modulator legacy IIO devices.
> The st,adc-channels property presence is used to discriminate
> between legacy and backend bindings.
> 
> The support of the DFSDM legacy channels and SD modulator IIO devices
> is kept for backward compatibility.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Hi Oliver

A few minor things inline.

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 208 ++++++++++++++++++++++++------
>  1 file changed, 171 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 9a47d2c87f05..69b4764d7cba 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -666,6 +666,64 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
>  	return 0;
>  }
>  
> +static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
> +						struct iio_dev *indio_dev,
> +						struct iio_chan_spec *ch,
> +						struct fwnode_handle *node)
> +{
> +	struct stm32_dfsdm_channel *df_ch;
> +	const char *of_str;
> +	int ret, val;
> +
> +	ret = fwnode_property_read_u32(node, "reg", &ch->channel);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ch->channel >= dfsdm->num_chs) {
> +		dev_err(&indio_dev->dev, " Error bad channel number %d (max = %d)\n",
> +			ch->channel, dfsdm->num_chs);
> +		return -EINVAL;
> +	}
> +
> +	ret = fwnode_property_read_string(node, "label", &ch->datasheet_name);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev,
> +			" Error parsing 'label' for idx %d\n", ch->channel);
> +		return ret;
> +	}
> +
> +	df_ch =  &dfsdm->ch_list[ch->channel];
> +	df_ch->id = ch->channel;
> +
> +	ret = fwnode_property_read_string(node, "st,adc-channel-types", &of_str);
> +	if (!ret) {
> +		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
> +		if (val < 0)
> +			return val;
> +	} else {
> +		val = 0;

Sometimes better to set a default, then override if if the property is read
successfully.
	df_ch->type = 0;
	if (!fwnode_property_read_string()) {
		int val = ...

		df_ch->type = val;
	}
	
etc
	
> +	}
> +	df_ch->type = val;
> +
> +	ret = fwnode_property_read_string(node, "st,adc-channel-clk-src", &of_str);
> +	if (!ret) {
> +		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
> +		if (val < 0)
> +			return val;
> +	} else {
> +		val = 0;
> +	}
> +	df_ch->src = val;
> +
> +	ret = fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch->alt_si);
> +	if (ret != -EINVAL)
> +		df_ch->alt_si = 0;

I'm confused. If it does == EINVAL we just silently carry on with alt_si sort
of undefined. I guess 0?

> +
> +	return 0;
> +}
> +

...

> +static int stm32_dfsdm_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
> +{
> +	int num_ch = indio_dev->num_channels;
> +	int chan_idx = 0, ret = 0;
> +
> +	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
> +		channels[chan_idx].scan_index = chan_idx;
> +		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &channels[chan_idx], NULL);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Channels init failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
return 0;    I don't think it's ever positive and can't get here with it negative.

> +}
> +
> +static int stm32_dfsdm_generic_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
> +{
> +	struct fwnode_handle *child;
> +	int chan_idx = 0, ret;
> +
> +	device_for_each_child_node(&indio_dev->dev, child) {

device_for_each_child_node_scoped() and direct returns should tidy this up a tiny bit.


> +		/* Skip DAI node in DFSDM audio nodes */
> +		if (fwnode_property_present(child, "compatible"))
> +			continue;
> +
> +		channels[chan_idx].scan_index = chan_idx;
> +		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &channels[chan_idx], child);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Channels init failed\n");
> +			goto err;

This is consistent with existing code, but would be nice to make extensive
use of dev_err_probe() in this driver and this is a gone place for that.
			return dev_err_probe(indio_dev->dev, ret, "...);


> +		}
> +
> +		chan_idx++;
> +	}
> +	return chan_idx;
> +
> +err:
> +	fwnode_handle_put(child);
> +
> +	return ret;
>  }
>  


