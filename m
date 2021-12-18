Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA63D479C89
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 21:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhLRUS0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 15:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhLRUSZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 15:18:25 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94968C061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:18:25 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id eq6so5657141qvb.7
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=je+PCD5tjRlXqdwyftDvVm0We2tcZ0dCr5G4YhS6hbY=;
        b=Ftkk1+QEBOnDxfMX04/F7Q/ntbMMkd4Zpja+48yxQLOwz9/nv1Y1eqLGc1iA4KG3n4
         jffCfJ3GL13u/HaAilX4659ssPmcx1o/Qbknh+Ijd+nd6D6H7om3okxZo/1QWjiO08wA
         DOkMk//4KVY6Cwo1EZhi4NMNIfwcCeOVGpGjRtfhKE03fwcuxVMO+UeIN8dqBHNuOz8m
         xQzYE1cc59r1+pPmXGDBOoD7NdyDWZ7gw7hNMGFp4DUwz/VK/81BpXpt/5FUZs5+Dr3Y
         4weKM/98aeEOmi0KZbSMGglWO5BdY3TmNKtyFaOV4wdnYJU5QhtobPOiiSPtwuOSraJn
         dEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=je+PCD5tjRlXqdwyftDvVm0We2tcZ0dCr5G4YhS6hbY=;
        b=wAp11CDJ5uP/mtDsO2fj/HxVV26iLd1/9UOSevEPU4OCkc7SlXk9uKw/hEoNk3lh6B
         OYSz3s2d5kOaSZxdrrIH4pwYD23YP6cXDHlwr+wXx9dB4mFHoganoCIU9VkmYp42KTnY
         ZUaQOiUqpE5UtgUVCHImT2f80xSvSJcIkp5/mfnCz/jN+9/313pNj/I+WxLuf40Kkn6Q
         hsqAbr9Q0fRvIsMi1FG+k3StJrrrDzWYiYnr1cH20rcj9Qq2ivhGS+BnRBJn6EDxLKdb
         EjI0cA+Zn7KJpnIVl+MG3OE5P0STvBOcDEf9mTzXtPgo7hnfLil3eErITMmuZAN/ElLQ
         xlSQ==
X-Gm-Message-State: AOAM532bp4EzwzehFlf4peZqs/Wb6Wrr3oLq+pDaPS/3KWN+n6GaOx14
        ETHYPWifyO8m2yX05fpayQw=
X-Google-Smtp-Source: ABdhPJx9AV7/0s12s9yhpU2XP8OZ9/U1GLOzORvmAFtPpm2P/lyi2A0N1l0J0xcXH0cPS2PI8j/Amw==
X-Received: by 2002:a05:6214:19e1:: with SMTP id q1mr5995682qvc.115.1639858704613;
        Sat, 18 Dec 2021 12:18:24 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id o4sm7356574qkh.107.2021.12.18.12.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:18:24 -0800 (PST)
Date:   Sat, 18 Dec 2021 17:18:21 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 08/17] staging:iio:adc:ad7280a: Drop unused timestamp
 channel.
Message-ID: <Yb5CDWYR2ir4ORSe@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-9-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-9-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The driver doesn't support buffered mode, so a timestamp channel that
> is entirely hidden from userspace without buffer mode is rather pointless.
> Drop it.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 032d6430bebf..58bddd07df0c 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -613,16 +613,6 @@ static void ad7280_total_voltage_channel_init(struct iio_chan_spec *chan,
>  	chan->scan_type.storagebits = 32;
>  }
>  
> -static void ad7280_timestamp_channel_init(struct iio_chan_spec *chan, int cnt)
> -{
> -	chan->type = IIO_TIMESTAMP;
> -	chan->channel = -1;
> -	chan->scan_index = cnt;
> -	chan->scan_type.sign = 's';
> -	chan->scan_type.realbits = 64;
> -	chan->scan_type.storagebits = 64;
> -}
> -
>  static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
>  {
>  	int addr, ch, i;
> @@ -650,7 +640,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  {
>  	int dev, cnt = 0;
>  
> -	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 2,
> +	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 1,
>  				    sizeof(*st->channels), GFP_KERNEL);
>  	if (!st->channels)
>  		return -ENOMEM;
> @@ -659,8 +649,6 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  		ad7280_init_dev_channels(st, dev, &cnt);
>  
>  	ad7280_total_voltage_channel_init(&st->channels[cnt], cnt, dev);
> -	cnt++;
> -	ad7280_timestamp_channel_init(&st->channels[cnt], cnt);
>  
>  	return cnt + 1;
>  }
> -- 
> 2.34.1
> 
