Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49EB107EF1
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfKWOr6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfKWOr6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:47:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E744420706;
        Sat, 23 Nov 2019 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574520478;
        bh=o2L+DU/THgfIcoCzBr6/ruVG0fBZcKIphuRhozunvjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KvQsdiw+22yCfvC4vaAvtOscYRvXK79XfvPxn/1qRNMmBAkeRp9uDd8fKmmgYdTar
         dtM3sM3cRaruXv0/CVYVtKhqR/hL0F5bVrDZxUzPZfFfBvd0nDtXoLzRVbIVlrTRoj
         Uo9zqYix5C9ECkJW7OLtdrBdtVBPM/yIpwEzspRY=
Date:   Sat, 23 Nov 2019 14:47:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V3] iio: adc: ad7124: Fix enabling of internal reference
Message-ID: <20191123144753.0f94f043@archlinux>
In-Reply-To: <20191118111948.7414-1-mircea.caprioru@analog.com>
References: <20191118111948.7414-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 13:19:48 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> When the internal reference was selected by a channel it was not enabled.
> This patch fixes that and enables it.
Ah well. I took v2 and it's marked for stable so doubt it matters that
there is no Fix in the title.

Issues like this happen to us all from time to time, please send a quick
reply to the earlier version if you are sending a new one.

I'm a bit random in how I apply patches (particularly when I only have
a few minutes around family stuff) so assume that a series with no replies
is fine to apply if I'm happy with it!

Thanks,

Jonathan

> 
> Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
> 
> Changelog v3:
> - mark this as a fix in the patch title
> 
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

