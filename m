Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F489185E57
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgCOP7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 11:59:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44041 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgCOP7V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 11:59:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id 37so8131159pgm.11;
        Sun, 15 Mar 2020 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2pQp4neBTipoD8jd8hs9nqlVYLeD5zyRoGXYPLNg50g=;
        b=gIEe9+Y2TcJsW8q1FdRacL1/xVfjMXGmzgrbXI49SkaCJbyUs9kk5zFHgyRU1bTBte
         cWwEas4x5A1MqOK2Kh/xvLk2xxBOLIT11OFXm5Oa+O0YTCcNKKBpqzfBffqZF9yADPtk
         7fScdGQuFoDIwVbb3gUuLKZzyxI1HZrdo00o64XUHMecvvPK0cXDR/MBHMz+h9L2WL4d
         ty0sPIaJGoUzhXSFuxGbVcMoqZw8IGTadLQKJLCr/dZkXlASa4nxRcrzgegL80NeHX+z
         KEY/dxY3b0Ec9wpXswimHO8RpRPAdEEqWwwF47+lTdDH0S5Y+f2dBBSPjfreR0tAXkCs
         9M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2pQp4neBTipoD8jd8hs9nqlVYLeD5zyRoGXYPLNg50g=;
        b=FIO2TPwtDnl7kurNt4h7td0oB0R63Vg8W8rRgKmmLA2/RnDOITew1PFyRQgwldkxAT
         fOoQeyxFoC6b7vkc3X4b/0Owsj3jNtsxSA8AQv2DlJG8oLCp6vxN3exTJHo/dQeNUu1n
         wG4fQkwVItWDhQll+LgSXE76DzZRhElUP0ZDor4wmfVnj2QZQ+Ek9GYs7mWURbz31UOs
         tizo+XWV/eH1cN03bxycBVZI1DE5716fODNecN5Uygn/RCGWyZc2BOj+pVYnD6bXHYFI
         /QO642uRFxSYYHPRQ3cWI/y2du/blI9mTOAyOB06covK61o55VUPas1DwBknj+p28cfN
         daHA==
X-Gm-Message-State: ANhLgQ2HRAje5vmILU6IqJDKaZgnpBNHrg8f/XleI3JcOD/9dZY+7vnP
        YFDD3lfur1piQMc11O6a1tw=
X-Google-Smtp-Source: ADFU+vsNho6DWp4+EWWJuoitLhCXhlkw/QHCVopdjSLKNubjamD/45lGeVe07usnoHlq/Q6y1OvTXQ==
X-Received: by 2002:a63:24a:: with SMTP id 71mr23738528pgc.119.1584287958966;
        Sun, 15 Mar 2020 08:59:18 -0700 (PDT)
Received: from SARKAR ([43.224.157.36])
        by smtp.gmail.com with ESMTPSA id 18sm65167319pfj.20.2020.03.15.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 08:59:18 -0700 (PDT)
Message-ID: <5e6e50d6.1c69fb81.f5a45.b961@mx.google.com>
X-Google-Original-Message-ID: <20200315155913.GA16078@rohitsarkar5398@gmail.com>
Date:   Sun, 15 Mar 2020 21:29:13 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, dragos.bogdan@analog.com
Subject: Re: [PATCH v6] iio: adc: max1363: replace uses of mlock
References: <5e6e4e78.1c69fb81.511f5.83ac@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6e4e78.1c69fb81.511f5.83ac@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Pl. ignore this patch, it contains incorrect logic.
Thanks,
Rohit

On Sun, Mar 15, 2020 at 09:19:08PM +0530, Rohit Sarkar wrote:
> Replace usage indio_dev's mlock with either local lock or
> iio_device_claim_direct_mode.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
> Changelog v5 -> v6
> * Minor failure handling fixes
> 
> Changelog v4 -> v5
> * Use local lock too at places where driver state needs to be protected.
> 
> Changelog v3 -> v4
> * Fix indentation
> 
> Changelog v2 -> v3
> * use iio_device_claim_direct when switching modes
> * replace mlock usage in max1363_write_event_config
> 
> Changelog v1 -> v2
> * Fix indentation
> 
>  drivers/iio/adc/max1363.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e..647c99ae9fbe 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -150,6 +150,7 @@ struct max1363_chip_info {
>   * @current_mode:	the scan mode of this chip
>   * @requestedmask:	a valid requested set of channels
>   * @reg:		supply regulator
> + * @lock		lock to ensure state is consistent
>   * @monitor_on:		whether monitor mode is enabled
>   * @monitor_speed:	parameter corresponding to device monitor speed setting
>   * @mask_high:		bitmask for enabled high thresholds
> @@ -169,6 +170,7 @@ struct max1363_state {
>  	const struct max1363_mode	*current_mode;
>  	u32				requestedmask;
>  	struct regulator		*reg;
> +	struct mutex			lock;
>  
>  	/* Using monitor modes and buffer at the same time is
>  	   currently not supported */
> @@ -364,7 +366,11 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	mutex_lock(&st->lock);
> +
> +	if (ret < 0)
> +		goto error_ret;
>  	/*
>  	 * If monitor mode is enabled, the method for reading a single
>  	 * channel will have to be rather different and has not yet
> @@ -372,7 +378,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	 *
>  	 * Also, cannot read directly if buffered capture enabled.
>  	 */
> -	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
> +	if (st->monitor_on) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> @@ -404,8 +410,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  		data = rxbuf[0];
>  	}
>  	*val = data;
> +
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  
>  }
> @@ -705,9 +712,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
>  	if (!found)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	st->monitor_speed = i;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return 0;
>  }
> @@ -810,12 +817,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
>  	int val;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (dir == IIO_EV_DIR_FALLING)
>  		val = (1 << number) & st->mask_low;
>  	else
>  		val = (1 << number) & st->mask_high;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return val;
>  }
> @@ -962,7 +969,12 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  	u16 unifiedmask;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	mutex_lock(&st->lock);
> +
> +	if (ret < 0)
> +		goto error_ret;
> +
>  	unifiedmask = st->mask_low | st->mask_high;
>  	if (dir == IIO_EV_DIR_FALLING) {
>  
> @@ -989,7 +1001,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  
>  	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -1587,6 +1599,7 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  
> +	mutex_init(&st->lock);
>  	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (IS_ERR(st->reg)) {
>  		ret = PTR_ERR(st->reg);
> -- 
> 2.23.0.385.gbc12974a89
> 
