Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA997FF39E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 17:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfKPQ0r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 11:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfKPQ0q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 11:26:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB264214DE;
        Sat, 16 Nov 2019 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573921606;
        bh=u+xBCALwba5ux8lkBspkQlgCbUB0P91PtT6vi6b6KE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PYMNe0NsWDQoRleJ+awapTwkV7w48mmVOZRnH7hzc1CE5BHI10gb/HJ2RzsNGcvho
         a16xCTubXSMeU3/Xm+0Zhr6Uh0pebkBRqu/dDDKM6lOWwXtlUCJl3as2cVG+U4r0r0
         Xsdu5ZdggMH7rO5LHhED5VMJAs6vR9CjFvxw5t44=
Date:   Sat, 16 Nov 2019 16:26:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: Enable internal reference
Message-ID: <20191116162641.45c9a557@archlinux>
In-Reply-To: <20191114092426.21631-1-mircea.caprioru@analog.com>
References: <20191114092426.21631-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 11:24:26 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> When the internal reference was selected by a channel it was not enabled.
> This patch fixes that and enables it.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

Probably want to clearly mark this as a fix in the patch title and
give a fixes tag here.

Seems like it would be awfully broken without this!

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index edc6f1cc90b2..3f03abf100b5 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -39,6 +39,8 @@
>  #define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
>  
>  /* AD7124_ADC_CONTROL */
> +#define AD7124_ADC_CTRL_REF_EN_MSK	BIT(8)
> +#define AD7124_ADC_CTRL_REF_EN(x)	FIELD_PREP(AD7124_ADC_CTRL_REF_EN_MSK, x)
>  #define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
>  #define AD7124_ADC_CTRL_PWR(x)		FIELD_PREP(AD7124_ADC_CTRL_PWR_MSK, x)
>  #define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
> @@ -424,7 +426,10 @@ static int ad7124_init_channel_vref(struct ad7124_state *st,
>  		break;
>  	case AD7124_INT_REF:
>  		st->channel_config[channel_number].vref_mv = 2500;
> -		break;
> +		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
> +		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
> +		return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL,
> +				      2, st->adc_control);
>  	default:
>  		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
>  		return -EINVAL;

