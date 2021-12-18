Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62569479C91
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 21:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhLRUaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 15:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhLRUaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 15:30:11 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5AC061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:30:11 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t83so5659206qke.8
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OFA1ACO21Kg/lT7gwqHmmNx2hqrDX0lFk0ujsciMYpI=;
        b=iDd24YuBjWym2fwE0m6QbQUydF4gyWkn6XeJvjdD2IO2E7j4fDfzUOiR+TBz86aApP
         PeITw3Ew935Et+fMKnk+08UNlGmWXEWZr/MKJSJKhvWff35yHkf0r9satqJb86iDWgtM
         spcmD+rOuNpvO3/oneH/ZlML/WDsdMpdkpaARYw/eI1mVg7oczEyDDy+oAv5/R/KmnH1
         wb7XbX75cPvb9kDy8OiqwSBT7wCqk7LLFua2ZdXOnPYCLrxSGpIsijsUZqLxh+FqBW5d
         kJwd9Kb0gEfSos00f4i8fCI6kAoD10zSlERcJDyZx0j+WjOV9miJ5R0DxoDxZpYTgwg6
         SHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OFA1ACO21Kg/lT7gwqHmmNx2hqrDX0lFk0ujsciMYpI=;
        b=4EpDLdkMSjop6kO7QwJAP5O1tuy1HN5qMazpJOQ1IDG6jrCWw3FAZwww5y+HqD3ELx
         F6xZxiroEPGuJKgWHlSuJrw5ZrloS8fpIQPWZ4oVxwTMcaAz1JkwhGFukN6hD4F4/Xnn
         jdc1sLvZ0tEtDOTwSyxcO+qC16TVZvSuYsQiJV1FNAWX2m//HI2iyjndggqIm3Pd5BIb
         1vJ8NLUCdi8G/dpZPjn/89q7c1Chce6U51WyuCS2HLSNX+hbSF0GL+PD2cc12hMu3vvS
         Fxva5SIjWvdh5S4POIQ+1Mwp9No4KHaI/T3nkPacfU1g7y7AH2qy/eVDPPTEnPZ3V5Gn
         GijA==
X-Gm-Message-State: AOAM532dndJk4VlVPZwCpDSWeJ8HCIYFxmNKHQQwMFs4auoxVVLr/8l0
        /2klsYuweDFgKdZ0/UvRb0U=
X-Google-Smtp-Source: ABdhPJwTHGZvSt7UwlCPRWrsIM6fadD7r3MBLx8R/XhyJqyabrH9Hc/cw3H5yS365ropbPRi3xg8Jw==
X-Received: by 2002:a05:620a:288c:: with SMTP id j12mr5571585qkp.66.1639859410158;
        Sat, 18 Dec 2021 12:30:10 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id bq43sm7681968qkb.32.2021.12.18.12.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:30:09 -0800 (PST)
Date:   Sat, 18 Dec 2021 17:30:06 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 12/17] staging:iio:ad7280a: Reflect optionality of irq
 in ABI
Message-ID: <Yb5Ezoa2mHoONp7J@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-13-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-13-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Not much confident about the attributes of ad7280_info_no_irq.
With that seen:
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Given the irq is optional, let us remove the interfaces related to
> events when it is not present.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 48 +++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 7f9e2276e41a..b4ba6da07af9 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -579,23 +579,29 @@ static const struct iio_event_spec ad7280_events[] = {
>  	},
>  };
>  
> -static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i)
> +static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i,
> +					bool irq_present)
>  {
>  	chan->type = IIO_VOLTAGE;
>  	chan->differential = 1;
>  	chan->channel = i;
>  	chan->channel2 = chan->channel + 1;
> -	chan->event_spec = ad7280_events;
> -	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> +	if (irq_present) {
> +		chan->event_spec = ad7280_events;
> +		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> +	}
>  	chan->ext_info = ad7280_cell_ext_info;
>  }
>  
> -static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i)
> +static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i,
> +				     bool irq_present)
>  {
>  	chan->type = IIO_TEMP;
>  	chan->channel = i;
> -	chan->event_spec = ad7280_events;
> -	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> +	if (irq_present) {
> +		chan->event_spec = ad7280_events;
> +		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> +	}
>  }
>  
>  static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
> @@ -629,7 +635,8 @@ static void ad7280_total_voltage_channel_init(struct iio_chan_spec *chan,
>  	chan->scan_type.storagebits = 32;
>  }
>  
> -static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
> +static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt,
> +				     bool irq_present)
>  {
>  	int addr, ch, i;
>  	struct iio_chan_spec *chan;
> @@ -639,10 +646,10 @@ static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
>  
>  		if (ch < AD7280A_AUX_ADC_1_REG) {
>  			i = AD7280A_CALC_VOLTAGE_CHAN_NUM(dev, ch);
> -			ad7280_voltage_channel_init(chan, i);
> +			ad7280_voltage_channel_init(chan, i, irq_present);
>  		} else {
>  			i = AD7280A_CALC_TEMP_CHAN_NUM(dev, ch);
> -			ad7280_temp_channel_init(chan, i);
> +			ad7280_temp_channel_init(chan, i, irq_present);
>  		}
>  
>  		addr = ad7280a_devaddr(dev) << 8 | ch;
> @@ -652,7 +659,7 @@ static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
>  	}
>  }
>  
> -static int ad7280_channel_init(struct ad7280_state *st)
> +static int ad7280_channel_init(struct ad7280_state *st, bool irq_present)
>  {
>  	int dev, cnt = 0;
>  
> @@ -662,7 +669,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
>  		return -ENOMEM;
>  
>  	for (dev = 0; dev <= st->slave_num; dev++)
> -		ad7280_init_dev_channels(st, dev, &cnt);
> +		ad7280_init_dev_channels(st, dev, &cnt, irq_present);
>  
>  	ad7280_total_voltage_channel_init(&st->channels[cnt], cnt, dev);
>  
> @@ -920,6 +927,11 @@ static const struct iio_info ad7280_info = {
>  	.write_event_value = &ad7280a_write_thresh,
>  };
>  
> +static const struct iio_info ad7280_info_no_irq = {
> +	.read_event_value = &ad7280a_read_thresh,
> +	.write_event_value = &ad7280a_write_thresh,
Think this should be
	.read_raw = ad7280_read_raw,
	.write_raw = ad7280_write_raw,

> +};
> +
>  static const struct ad7280_platform_data ad7793_default_pdata = {
>  	.acquisition_time = AD7280A_ACQ_TIME_400ns,
>  	.thermistor_term_en = true,
> @@ -973,18 +985,12 @@ static int ad7280_probe(struct spi_device *spi)
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = ad7280_channel_init(st);
> +	ret = ad7280_channel_init(st, spi->irq > 0);
>  	if (ret < 0)
>  		return ret;
>  
>  	indio_dev->num_channels = ret;
>  	indio_dev->channels = st->channels;
> -	indio_dev->info = &ad7280_info;
> -
> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	if (spi->irq > 0) {
>  		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
>  				   AD7280A_ALERT_REG, 1,
> @@ -1008,9 +1014,13 @@ static int ad7280_probe(struct spi_device *spi)
>  						indio_dev);
>  		if (ret)
>  			return ret;
> +
> +		indio_dev->info = &ad7280_info;
> +	} else {
> +		indio_dev->info = &ad7280_info_no_irq;
>  	}
>  
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad7280_id[] = {
> -- 
> 2.34.1
> 
