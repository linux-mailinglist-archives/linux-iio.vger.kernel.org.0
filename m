Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C318EAB8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCVRWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgCVRWC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:22:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5248920724;
        Sun, 22 Mar 2020 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584897721;
        bh=KJmy5bsJoVg89Nels/TOp/ubxWuuNgw+ojgqy4uch80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dY+gxUCr2dlCMF4TOBPYMe+5Q5CX2vFVgNqBew0X7jcg92e/WEn+5ZBlWCDfud5wo
         hrihh2AmpOtv+iVn03K1YiJ+HV9ubIjtRju3Fk0XmxMAafSVIbFwJxZ8EMSaLE7jVm
         AJK62ZyUzcDSLIQdAYiOYwn2btHDUc+WMJ/37F+8=
Date:   Sun, 22 Mar 2020 17:21:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 4/5] iio: pressure: bmp280: Drop unneeded explicit
 castings
Message-ID: <20200322172156.6c6ffb3b@archlinux>
In-Reply-To: <20200317101813.30829-4-andriy.shevchenko@linux.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
        <20200317101813.30829-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 12:18:12 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In few places the unnecessary explicit castings are being used.
> Drop them for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A passing comment inline, but seems sensible to me.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6c2e47d92a11..5db41b1df7eb 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -337,8 +337,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  	__be32 tmp = 0;
>  	s32 adc_temp, comp_temp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> -			       (u8 *) &tmp, 3);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, &tmp, 3);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read temperature\n");
>  		return ret;
> @@ -377,8 +376,7 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> -			       (u8 *) &tmp, 3);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, &tmp, 3);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read pressure\n");
>  		return ret;
> @@ -400,8 +398,8 @@ static int bmp280_read_press(struct bmp280_data *data,
>  
>  static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  {
> +	__be16 tmp;
>  	int ret;
> -	__be16 tmp = 0;

I haven't checked it but normally that sort of initialization got added
because a compiler got 'clever' and decided that it might be used uninitialized.

However, it's a bit odd in this case as there are lots of other calls
of the same thing that don't bother initializing.  So must not be that...

>  	s32 adc_humidity;
>  	u32 comp_humidity;
>  
> @@ -410,8 +408,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> -			       (u8 *) &tmp, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, &tmp, 2);
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read humidity\n");
>  		return ret;
> @@ -747,14 +744,14 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  
>  static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
>  {
> +	__be16 tmp;
>  	int ret;
> -	__be16 tmp = 0;
>  
>  	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 2);
> +	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 2);
>  	if (ret)
>  		return ret;
>  
> @@ -851,7 +848,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 3);
> +	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 3);
>  	if (ret)
>  		return ret;
>  

