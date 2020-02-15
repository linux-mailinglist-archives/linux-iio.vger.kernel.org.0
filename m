Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E677415FF66
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 18:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgBORIJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 12:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgBORII (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 12:08:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CABB2084E;
        Sat, 15 Feb 2020 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581786487;
        bh=BeEiJRU93mnVdW9TOjTggWtMGkZQL7+pZDvoLUw8UXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wGF4uywGfCL9kOBb4n++VKiih8w35IEMrjt5sPWxGEKodAJBxNPdoXH5btKMCkWth
         dtNAwsYzR5p9PvSu2d6xFGHtNITV6X5jUeWxXNPBDDFdv11vmh7zuKfwXfGg3noBNX
         v0rAOfpwgBPCGVV8/8sd7ip3Lu7894my0t80xSks=
Date:   Sat, 15 Feb 2020 17:08:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iio: light: al3320a slightly improve code
 formatting
Message-ID: <20200215170801.668edf1b@archlinux>
In-Reply-To: <20200211191201.1049902-4-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-4-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:11:57 +0100
David Heidelberg <david@ixit.cz> wrote:

> - modified to be in part with al3010 driver
> - cleanup using bitfield, no functionality change intended
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
One issue below. Fixed up and applied.

Thanks,

Jonathan

> ---
> v4
>  - use GENMASK() and bitfields
>  - sort headers
>  - drop init.h unused header
> 
>  drivers/iio/light/al3320a.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index a21aa99e74e4..89b935b4fe9e 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -9,9 +9,9 @@
>   * TODO: interrupt support, thresholds
>   */
>  
> -#include <linux/module.h>
> -#include <linux/init.h>
> +#include <linux/bitfield.h>
>  #include <linux/i2c.h>
> +#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -36,8 +36,7 @@
>  #define AL3320A_CONFIG_DISABLE		0x00
>  #define AL3320A_CONFIG_ENABLE		0x01
>  
> -#define AL3320A_GAIN_SHIFT		1
> -#define AL3320A_GAIN_MASK		(BIT(2) | BIT(1))
> +#define AL3320A_GAIN_MASK		GENMASK(2, 1)
>  
>  /* chip params default values */
>  #define AL3320A_DEFAULT_MEAN_TIME	4
> @@ -90,7 +89,8 @@ static int al3320a_init(struct al3320a_data *data)
>  		return ret;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
> -					AL3320A_RANGE_3 << AL3320A_GAIN_SHIFT);
> +					FIELD_PREP(AL3320A_GAIN_MASK,
> +						   AL3320A_RANGE_3));
>  	if (ret < 0)
>  		return ret;
>  
> @@ -133,7 +133,7 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = (ret & AL3320A_GAIN_MASK) >> AL3320A_GAIN_SHIFT;
> +		ret = FIELD_GET(AL3320A_GAIN_MASK, ret)
Missing semicolon.  I fixed up.


>  		*val = al3320a_scales[ret][0];
>  		*val2 = al3320a_scales[ret][1];
>  
> @@ -152,11 +152,13 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		for (i = 0; i < ARRAY_SIZE(al3320a_scales); i++) {
> -			if (val == al3320a_scales[i][0] &&
> -			    val2 == al3320a_scales[i][1])
> -				return i2c_smbus_write_byte_data(data->client,
> +			if (val != al3320a_scales[i][0] ||
> +			    val2 != al3320a_scales[i][1])
> +				continue;
> +
> +			return i2c_smbus_write_byte_data(data->client,
>  					AL3320A_REG_CONFIG_RANGE,
> -					i << AL3320A_GAIN_SHIFT);
> +					FIELD_PREP(AL3320A_GAIN_MASK, i));
>  		}
>  		break;
>  	}

