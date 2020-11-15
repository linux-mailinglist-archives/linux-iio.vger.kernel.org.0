Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD572B3761
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 18:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKORoy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 12:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgKORox (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 12:44:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CD720639;
        Sun, 15 Nov 2020 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605462293;
        bh=2+Ad52muurxk3565GkjLmAqXpv3hcuB8izzIORdCWtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U8JMiDz4gN+o2NEufEq9Y99MRYWbcza4TNzqFThLHaQsgLDsS7jqaWr7EQhluJfrH
         EtsCjp/RMJtVGidKK8rZzZkxC+JJkbbN0oEcq0jKyer3UosRC0wBCSr/DCk/N3MzmT
         zUf/qjP+s/4qSJun0cANjw3kfpvjZ7OUncRozJWg=
Date:   Sun, 15 Nov 2020 17:44:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH]  iio: afe: iio-rescale: Support processed channels
Message-ID: <20201115174408.000b05d4@archlinux>
In-Reply-To: <20201101232211.1194304-1-linus.walleij@linaro.org>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Nov 2020 00:22:11 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> It happens that an ADC will only provide raw or processed
> voltage conversion channels. (adc/ab8500-gpadc.c).
> On the Samsung GT-I9070 this is used for a light sensor
> and current sense amplifier so we need to think of something.
> 
> The idea is to allow processed channels and scale them
> with 1/1 and then the rescaler can modify the result
> on top.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Sorry, I kept leaving this to last as it was in the 'needed thought'
pile - then running out of time and not getting to it.

Anyhow, I think this is the best we can do for the situation
you describe so I'm happy with this.

@Peter, I definitely want your input on this one as well though
before I apply it!

Jonathan


> ---
>  drivers/iio/afe/iio-rescale.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index e42ea2b1707d..ea90034cb257 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -29,6 +29,7 @@ struct rescale {
>  	struct iio_channel *source;
>  	struct iio_chan_spec chan;
>  	struct iio_chan_spec_ext_info *ext_info;
> +	bool chan_processed;
>  	s32 numerator;
>  	s32 denominator;
>  };
> @@ -43,10 +44,27 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		return iio_read_channel_raw(rescale->source, val);
> +		if (rescale->chan_processed)
> +			/*
> +			 * When only processed channels are supported, we
> +			 * read the processed data and scale it by 1/1
> +			 * augmented with whatever the rescaler has calculated.
> +			 */
> +			return iio_read_channel_processed(rescale->source, val);
> +		else
> +			return iio_read_channel_raw(rescale->source, val);
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = iio_read_channel_scale(rescale->source, val, val2);
> +		if (rescale->chan_processed) {
> +			/*
> +			 * Processed channels are scaled 1-to-1
> +			 */
> +			ret = IIO_VAL_FRACTIONAL;
> +			*val = 1;
> +			*val2 = 1;
> +		} else {
> +			ret = iio_read_channel_scale(rescale->source, val, val2);
> +		}
>  		switch (ret) {
>  		case IIO_VAL_FRACTIONAL:
>  			*val *= rescale->numerator;
> @@ -132,8 +150,13 @@ static int rescale_configure_channel(struct device *dev,
>  
>  	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
>  	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> -		dev_err(dev, "source channel does not support raw/scale\n");
> -		return -EINVAL;
> +		if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
> +			dev_info(dev, "using processed channel\n");
> +			rescale->chan_processed = true;
> +		} else {
> +			dev_err(dev, "source channel does not support raw+scale or processed data\n");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |

