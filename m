Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3386890AB
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfHKIct (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 04:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfHKIct (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Aug 2019 04:32:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C442173C;
        Sun, 11 Aug 2019 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565512368;
        bh=bhEWn2cJHLvZ3bN1Q/kwRHMbOyW232kkKU7xamqw9CA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M6Ad9+pXvoEJLz8d6sIdT99WBgmz/Z/ZxtDhyPrsfLehfIVrz4bJgZsJQikPbwws5
         h/sDCSyaXka6Qs18ah7QB4mJ0X8YqurPvr0sCrpQ5srjOgwbVOKqfE1Hkx5vBvmvPM
         aVLZSYtUvPG6dpTS3p0195hyQROZlVbl5IDLwxzg=
Date:   Sun, 11 Aug 2019 09:32:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dpfrey@gmail.com, mike.looijmans@topic.nl
Subject: Re: [PATCH] iio: chemical: bme680: Fix pressure and humidity ABI
 mismatch
Message-ID: <20190811093243.6e08a12d@archlinux>
In-Reply-To: <20190808154350.9693-1-himanshujha199640@gmail.com>
References: <20190808154350.9693-1-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  8 Aug 2019 21:13:50 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Standard ABI for reporting pressure is kilopascal and for
> relative humidity it is millipercent.
> 
> What:           /sys/bus/iio/devices/iio:deviceX/in_pressureY_input
> What:           /sys/bus/iio/devices/iio:deviceX/in_pressure_input
> KernelVersion:  3.8
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Scaled pressure measurement from channel Y, in kilopascal.
> 
> What:           /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
> KernelVersion:  3.14
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Scaled humidity measurement in milli percent.
> 
> Currently pressure is reported in hectopascal(hPa) and relative humidity
> in percent. Hence fix this ABI mismatch conforming to the standard ABI.
> 
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Hopefully any users will cope with their scripts getting broken
by this.

I'm going to let this one sit for a little longer to give others time
to take a look.

Give me a poke if it looks like I've lost it down the back of the sofa
in a week or two.

Thanks,

Jonathan


> ---
> 
> While cleaning this mess I wonder about the gas channel and there
> exists no `in_resistance_input` in standard ABI :-(
> 
> We only have:
> 
> What:           /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
> What:           /sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
> What:           /sys/bus/iio/devices/iio:deviceX/out_resistance_raw
> What:           /sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
> KernelVersion:  4.3
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Raw (unscaled no offset etc.) resistance reading that can be processed
>                 into an ohm value.
> 
> The sensor outputs processed value which is reported as is.
> 
> So, does it need a new ABI ?

New documentation as the ABI is clearly already there.   Good for completeness
but that description for _raw makes it obvious what the units will be etc so
hopefully we don't have any disagreement between drivers.


> 
>  drivers/iio/chemical/bme680_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index ccde4c65ff93..28cc96d1e3c8 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -670,7 +670,7 @@ static int bme680_read_press(struct bme680_data *data,
>  	}
>  
>  	*val = bme680_compensate_press(data, adc_press);
> -	*val2 = 100;
> +	*val2 = 1000;
>  	return IIO_VAL_FRACTIONAL;
>  }
>  
> @@ -704,7 +704,7 @@ static int bme680_read_humid(struct bme680_data *data,
>  	comp_humidity = bme680_compensate_humid(data, adc_humidity);
>  
>  	*val = comp_humidity;
> -	*val2 = 1000;
> +	*val2 = 1000000;
>  	return IIO_VAL_FRACTIONAL;
>  }
>  

