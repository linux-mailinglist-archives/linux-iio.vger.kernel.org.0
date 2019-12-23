Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA52129488
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 12:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLWLCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 06:02:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfLWLCw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 06:02:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 336B2206B7;
        Mon, 23 Dec 2019 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577098971;
        bh=wIMlSyZudQ/lRHdZGot4YB5kkwjSs6MK2vp2syp5DTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BwZhZ+jTDKJ4gTSwF3InXNW77vLZRhXqWcQQharJP3kLw52SGIs6Q34NMk+AEW/L2
         ZN6mQWbMsNoIao0fSUIhxFIKE/d5jVsje5Hg7mBho4ZAvDmtQu54Gb+cmdWOqD1/u+
         WQB5Axtc0GqiEZ/V5vyBUfTRtjU6NFoKwdgZeLa0=
Date:   Mon, 23 Dec 2019 11:02:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH 2/3] iio: frequency: adf4371: Introduce channel child
 nodes
Message-ID: <20191223110246.39e008c3@archlinux>
In-Reply-To: <20191219133755.26109-2-beniamin.bia@analog.com>
References: <20191219133755.26109-1-beniamin.bia@analog.com>
        <20191219133755.26109-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Dec 2019 15:37:54 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> The ADF4371/ADF4372 devices support individual configurations for the
> output channels. Each child node represents a channel for which
> "power-up-frequency" and "output-enable" optional properties are currently
> supported.
> 
> If the "power-up-frequency" is specified for a channel, the driver checks
> if the value provided is in sync with the frequencies set on the other
> channels. This limitation is due to the fact that all the channel
> frequencies are derived from the VCO fundamental frequency.
> 
> If the "output-enable" property is specified, then the channel will be
> enabled, otherwise, the driver will initialize the defaults (RF8x will
> be the only enabled channel).
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
The code looks good.  Question outstanding is the one I raised in review
of the binding doc.  What's this for?

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/adf4371.c | 79 ++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
> index 7d77ebdbea82..e2a599b912e5 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -154,10 +154,16 @@ struct adf4371_chip_info {
>  	const struct iio_chan_spec *channels;
>  };
>  
> +struct adf4371_channel_config {
> +	bool enable;
> +	unsigned long long freq;
> +};
> +
>  struct adf4371_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	struct clk *clkin;
> +	struct adf4371_channel_config channel_cfg[4];
>  	/*
>  	 * Lock for accessing device registers. Some operations require
>  	 * multiple consecutive R/W operations, during which the device
> @@ -175,6 +181,7 @@ struct adf4371_state {
>  	unsigned int mod2;
>  	unsigned int rf_div_sel;
>  	unsigned int ref_div_factor;
> +	bool mute_till_lock_en;
>  	u8 buf[10] ____cacheline_aligned;
>  };
>  
> @@ -480,6 +487,36 @@ static const struct iio_info adf4371_info = {
>  	.debugfs_reg_access = &adf4371_reg_access,
>  };
>  
> +static int adf4371_channel_config(struct adf4371_state *st)
> +{
> +	unsigned long long rate;
> +	int i, ret;
> +
> +	for (i = 0; i < st->chip_info->num_channels; i++) {
> +		if (st->channel_cfg[i].freq == 0)
> +			continue;
> +
> +		rate = adf4371_pll_fract_n_get_rate(st, i);
> +		if (rate == 0) {
> +			ret = adf4371_set_freq(st, st->channel_cfg[i].freq, i);
> +			if (ret < 0)
> +				return ret;
> +		} else if (rate != st->channel_cfg[i].freq) {
> +			dev_err(&st->spi->dev,
> +				"Clock rate for chanel %d is not in sync\n", i);
> +			return -EINVAL;
> +		}
> +		/* Powerup channel if the property was specified in the dt */
> +		if (st->channel_cfg[i].enable) {
> +			ret = adf4371_channel_power_down(st, i, false);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int adf4371_setup(struct adf4371_state *st)
>  {
>  	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
> @@ -497,7 +534,7 @@ static int adf4371_setup(struct adf4371_state *st)
>  		return ret;
>  
>  	/* Mute to Lock Detect */
> -	if (device_property_read_bool(&st->spi->dev, "adi,mute-till-lock-en")) {
> +	if (st->mute_till_lock_en) {
>  		ret = regmap_update_bits(st->regmap, ADF4371_REG(0x25),
>  					 ADF4371_MUTE_LD_MSK,
>  					 ADF4371_MUTE_LD(1));
> @@ -545,7 +582,11 @@ static int adf4371_setup(struct adf4371_state *st)
>  	st->buf[3] = synth_timeout;
>  	st->buf[4] = ADF4371_VCO_ALC_TOUT(vco_alc_timeout);
>  
> -	return regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
> +	ret = regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
> +	if (ret < 0)
> +		return 0;
> +
> +	return adf4371_channel_config(st);
>  }
>  
>  static void adf4371_clk_disable(void *data)
> @@ -555,6 +596,36 @@ static void adf4371_clk_disable(void *data)
>  	clk_disable_unprepare(st->clkin);
>  }
>  
> +static int adf4371_parse_dt(struct adf4371_state *st)
> +{
> +	unsigned char num_channels;
> +	unsigned int channel;
> +	struct fwnode_handle *child;
> +	int ret;
> +
> +	if (device_property_read_bool(&st->spi->dev, "adi,mute-till-lock-en"))
> +		st->mute_till_lock_en = true;
> +
> +	num_channels = device_get_child_node_count(&st->spi->dev);
> +	if (num_channels > st->chip_info->num_channels)
> +		return -EINVAL;
> +
> +	device_for_each_child_node(&st->spi->dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			return ret;
> +
> +		ret = fwnode_property_present(child, "adi,output-enable");
> +		st->channel_cfg[channel].enable = ret;
> +
> +		fwnode_property_read_u64(child,
> +					 "adi,power-up-frequency",
> +					 &st->channel_cfg[channel].freq);
> +	}
> +
> +	return 0;
> +}
> +
>  static int adf4371_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -602,6 +673,10 @@ static int adf4371_probe(struct spi_device *spi)
>  
>  	st->clkin_freq = clk_get_rate(st->clkin);
>  
> +	ret = adf4371_parse_dt(st);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = adf4371_setup(st);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "ADF4371 setup failed\n");

