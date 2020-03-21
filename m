Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6CE18E3BB
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgCUSni (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 14:43:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45853 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUSnh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 14:43:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id j10so5146000pfi.12;
        Sat, 21 Mar 2020 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yRcLkteyX6PlC1Vm2e1Pax2AHd9o6wiG1snjmj+oGxk=;
        b=A2jHP2XnccTjVNIPvy0XT63cZVksWDKO2+FU+Yzk8ybgFn3cg695kgKrGA+DJdZSLt
         aQdr7UlGUe3IgGT/Nm4m5vpq/yoBFyspcoWP38tRC208c7lBbms3+HaXmVKeWUqkDSlH
         ocVjE2tKhePOJVysyMPoA0vwFbFOOLQVOJTvdlTLwRhKYvDSQw8Qof/Ufi21RDmL0aY+
         6XfTJVOnepR2NA0BcBDXJRprwnzLQrlE2Qoa6ctb+mrL27Z4SkDN363NOu22l05Kz2sI
         /t8C5+qCa5Pnk2//r5yBPuQOtvG10otTLpuyWHpRsK4SynEYUCRCqehvvnmvMuE77cTk
         MhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRcLkteyX6PlC1Vm2e1Pax2AHd9o6wiG1snjmj+oGxk=;
        b=KfPWceXjRMdL/ZQSHYTv7wb8Q+wCSbQICRqtqm5pFEfEdeLb1Lb4FWDxTw6nMNAC8G
         aOelFx46Ghyc/XT8qH7c7YNjatK7haiCnbbJqrdB553dChnli9KK99VAIMrIhiHGB16h
         sDPLGComT4YOOfr3rkoBgZBq+YorLIhl9FBavDvb1QHDVm3C0YP8GH0wUTpJDLhH6Tuz
         f6/BSmJ0p4GkRke0wJHIWUHCmvaHr1bB3cdQShk94jf41zfNVKV4YzxXCH+Oc1ASJbFY
         QpKooQfEk6NGuaLe63HFrD40OHkjcSkSBWYgMYzJfb8+ZOFwwi3RBkQBXxf47knM+l++
         0Oiw==
X-Gm-Message-State: ANhLgQ3An6g7PGd1UJuzzYCj+/DTfeNiYU8ZHbnnfNJYs0jRdLxZVVAF
        O2JY+3zMRngHuVJolAbn6mitZCUl
X-Google-Smtp-Source: ADFU+vvkGl9qxAFdRG4hK7oBMzQSoFQPdeBPeBd6QW3hOi+39SP8/ltnO6dJWjRfu0nKspP1yfspCA==
X-Received: by 2002:a62:1a03:: with SMTP id a3mr16284219pfa.171.1584816216757;
        Sat, 21 Mar 2020 11:43:36 -0700 (PDT)
Received: from SARKAR ([49.207.56.153])
        by smtp.gmail.com with ESMTPSA id w4sm8058003pgg.2.2020.03.21.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:43:36 -0700 (PDT)
Message-ID: <5e766058.1c69fb81.a65ff.d2eb@mx.google.com>
X-Google-Original-Message-ID: <20200321184332.GA10817@rohitsarkar5398@gmail.com>
Date:   Sun, 22 Mar 2020 00:13:32 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, dragos.bogdan@analog.com
Subject: Re: [PATCH v7] iio: adc: max1363: replace uses of mlock
References: <5e6e522d.1c69fb81.10f54.f95c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6e522d.1c69fb81.10f54.f95c@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey,
Does this look fine? Wondering if this was missed during review
Thanks,
Rohit

On Sun, Mar 15, 2020 at 09:34:58PM +0530, Rohit Sarkar wrote:
> Replace usage indio_dev's mlock with either local lock or
> iio_device_claim_direct_mode.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
> Changelog v6 -> v7
> * Fix failure handling logic
> 
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
>  drivers/iio/adc/max1363.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e..12d72bf3f12a 100644
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
> @@ -364,7 +366,13 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +	mutex_lock(&st->lock);
> +
> +	if (ret < 0)
> +		goto error_ret;
>  	/*
>  	 * If monitor mode is enabled, the method for reading a single
>  	 * channel will have to be rather different and has not yet
> @@ -372,7 +380,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	 *
>  	 * Also, cannot read directly if buffered capture enabled.
>  	 */
> -	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
> +	if (st->monitor_on) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> @@ -404,8 +412,10 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  		data = rxbuf[0];
>  	}
>  	*val = data;
> +
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
> +	iio_device_release_direct_mode(indio_dev);
>  	return ret;
>  
>  }
> @@ -705,9 +715,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
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
> @@ -810,12 +820,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
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
> @@ -962,7 +972,14 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  	u16 unifiedmask;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +	mutex_lock(&st->lock);
> +
> +	if (ret < 0)
> +		goto error_ret;
> +
>  	unifiedmask = st->mask_low | st->mask_high;
>  	if (dir == IIO_EV_DIR_FALLING) {
>  
> @@ -989,7 +1006,8 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  
>  	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
>  }
> @@ -1587,6 +1605,7 @@ static int max1363_probe(struct i2c_client *client,
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
