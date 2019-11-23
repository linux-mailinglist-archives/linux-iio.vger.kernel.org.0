Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C98107EE4
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfKWOis (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWOis (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:38:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC42204FD;
        Sat, 23 Nov 2019 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574519927;
        bh=pc1zIEOYRgv9Kk225bxi47Xudf6VWC6bd/TbCUHewJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=exFpp/uVkER30wvKiUF/oh7UEd5A28YEcOnk3zMMUWuTRH/o54Wq7kOIWMO2XAfRp
         sLEL8Pd/YaIzB9lUA8tm6Vxv2FxxXpcbAAW/Qf6CVzPy7HPpOldm+2k9qcUZZYJJJ5
         u7QWaEpZEzcZ28jmoIxgBXG5LgjWzjIFWM4uQXbM=
Date:   Sat, 23 Nov 2019 14:38:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] iio: adc: ad7124: Enable internal reference
Message-ID: <20191123143842.776f2506@archlinux>
In-Reply-To: <20191118083857.1754-1-mircea.caprioru@analog.com>
References: <20191118083857.1754-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 10:38:57 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> When the internal reference was selected by a channel it was not enabled.
> This patch fixes that and enables it.
> 
> Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan

> ---
> 
> Changelog V2:
> - add fixes tag in commit message
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

