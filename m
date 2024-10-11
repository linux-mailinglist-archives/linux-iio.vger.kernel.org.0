Return-Path: <linux-iio+bounces-10477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18299AC66
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 21:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F48AB27825
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E01C9DC9;
	Fri, 11 Oct 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS3FNF0a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A191A08A4;
	Fri, 11 Oct 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673646; cv=none; b=Rzl9/SGWhf5W4dkECwFycI+N+S63DWSJAe+hMYbgea+qsw+/IcahqE6bigi2sBYChtoOX52h0J8hHbGsQe6T+HaphvXRVOLNcg5b2uHg7n9dkhfwaJ5RKMshhUGGyLHifdQJo1FQy4yOzwvXzB2GnVWvNZNlb81a/iLUQPNrmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673646; c=relaxed/simple;
	bh=d2g9d5JhVOwMn17mm+Qsi9qXxZahUJpQFOPa0Cb0N/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErA6mIjuGSsjEkPiigHg9sr5EqviN8sNo5eHeJO7UTq6E85g5FgVUzrm3vlVvQlpxv7D80J7YBeY6RXnRgKjdOm2+RrNeGZd7kPyBzjrg75ftsb4fRJw1vkG4VHIKoAolyW3pc7UPnOPLIAMxRQK6SXH0fEP0KIfXy3WYw0dhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS3FNF0a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so21597915e9.0;
        Fri, 11 Oct 2024 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728673643; x=1729278443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOA0LA7YZsa2SRSYHALYuA8+jEzzPs7er50SeMEGJ2c=;
        b=kS3FNF0aUtX7aiTPRL+iS7K8wEgS+N0tiywzOIsw8prAMjjqdUfWfD2uIznVzUqFVH
         SE8MFoFAAyDhHUE9S5qiF5EkTVSJCe9TxuBF0GNrX1c+Sw30jtNnxN0GWw7Oo7CXkvU9
         WELZOXrfGu2oKZ8rPvM0888UycYZ8/yYNZvsFjh6hUTz10t1Yflz4M0JBzfqB0e+chaI
         6LpI0LXbr3B6VK6XU8/438TTxVO6G/ktfhh0PfMt+x1ikyx+X/Vj9McMdiWUIS9fj2Uv
         HxST3Z4CT5DA/PeuSEcN4jhp1gkt5mDdazsK1oW6yCJ82f6c4vHB1nPXdD1xsAOVLkq1
         Arkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728673643; x=1729278443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOA0LA7YZsa2SRSYHALYuA8+jEzzPs7er50SeMEGJ2c=;
        b=OrBQsqKLD+ZXQAOlxNMff8SrIOTVLx4EqOcdiO17nHFw49e4WHUONgbkp+QYVFhZ/T
         AmXbOgHlWBNAADR+ruZ6DdZGFn7O4mqPYLQTDXaP9HH38V+gYHTGHAm8sdO4ojejegYW
         x2o3EJ0ho8KkI1DDFm+ZbO8mcwzM+4bb8mi1xc7fNUi8bqGSS6MGAkTC0ZhfxzfHSJli
         CLMhEA0yn4welgTD/QiBEXchPECOQjuwZ9KMTNXkKOim8gxcNhOJ9k4VRXhINTmlDhPK
         AzH4QrkGlT6cgdMbS/tR7FeCqvzjEd1lLvFmg1MF0TxAohfqLJy4kAq3Z4LYwVTnnob8
         qA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUivcft2qYQWqsdhvs2aOuObZnZUYvNzPR28T5qV5KfHW7MpVqjQ58X0OQN2UnLaon4IBOvNV7BgqVC@vger.kernel.org, AJvYcCUsShDOegujwWi9w3Q0Cy+glbMPcAdb/mL8KpFjOACLe4hQ+ufWvPi7w23rsFSSiPlsYsYt+J+NKf4p@vger.kernel.org, AJvYcCVkRcfO0QhgNevnOHmf3VbZ9RnhVxME/7l1IONXfWOV3SOdFnggiWKIf42smksbOKUI2ZwKQ3aZvXK4Sx5G@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmmfgbV+Y/555lrNOR7/cywTmzMAlVgyAI/HaGdRjzo6KyY/7
	9mZbWSzfiwTdhWs9sTGcetjkF/GV+2rIJeM/tM0VBJgTnpyp2ZOf
X-Google-Smtp-Source: AGHT+IEUmaAXk6KOtYxzu8s5HEuadXB3JmAkBwhGr6CxNG6z+VXV3tEUp6YpdNE5862uld3wRArdkg==
X-Received: by 2002:adf:a29a:0:b0:37d:482e:6197 with SMTP id ffacd0b85a97d-37d551b6a4fmr2301211f8f.17.1728673642959;
        Fri, 11 Oct 2024 12:07:22 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a87d3sm4572008f8f.11.2024.10.11.12.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:07:22 -0700 (PDT)
Date: Fri, 11 Oct 2024 21:07:20 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/13] iio: chemical: bme680: Add triggered buffer
 support
Message-ID: <Zwl3aBDFiLN9b0TK@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-13-vassilisamir@gmail.com>
 <ZwkABN9RycsVPRwo@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkABN9RycsVPRwo@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:37:56PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:29PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Add triggered buffer and soft timestamp support. The available scan mask
> > enables all the channels of the sensor in order to follow the operation of
> > the sensor. The sensor basically starts to capture from all channels
> > as long as it enters into FORCED mode.
> 
> ...
> 
> >  	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
> >  	int ambient_temp;
> >  
> > +	u8 buffer[ALIGN(sizeof(s32) * BME680_NUM_CHANNELS, sizeof(s64))
> > +		  + sizeof(s64)] __aligned(sizeof(s64));
> 
> Can it be represented as a structure?
> We also have aligned_s64 for the timestamp.
>

Hi Andy,

The same approach was used also for the bmp280 driver and since I was
working on the bmp280 as well, I did it here. You think the
representation as a struct would look better? Personally I like the
nature of this one because of the ALIGN() but I have no problem of using
a struct here.

> >  	union {
> > -		u8 buf[3];
> > +		u8 buf[15];
> >  		unsigned int check;
> >  		__be16 be16;
> >  		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
> 
> ...
> 
> > +static irqreturn_t bme680_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +	u32 adc_temp, adc_press, adc_humid, comp_press, comp_humid;
> 
> > +	s32 *chans = (s32 *)data->buffer;
> 
> With the structure in place this becomes much more readable.
> 
> > +	u16 adc_gas_res, gas_regs_val;
> > +	s32 t_fine, comp_gas_res;
> > +	s16 comp_temp;
> > +	u8 gas_range;
> > +	int ret;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = bme680_set_mode(data, BME680_FORCED);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = bme680_wait_for_eoc(data);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* Burst read data regs */
> > +	ret = regmap_bulk_read(data->regmap, BME680_REG_MEAS_STAT_0,
> > +			       data->buf, sizeof(data->buf));
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to burst read sensor data\n");
> > +		goto out;
> > +	}
> > +	if (data->buf[0] & BME680_GAS_MEAS_BIT) {
> > +		dev_err(data->dev, "gas measurement incomplete\n");
> > +		goto out;
> > +	}
> > +
> > +	/* Temperature calculations */
> > +	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[5]));
> > +	if (adc_temp == BME680_MEAS_SKIPPED) {
> > +		dev_err(data->dev, "reading temperature skipped\n");
> > +		goto out;
> > +	}
> > +	comp_temp = bme680_compensate_temp(data, adc_temp);
> > +	t_fine = bme680_calc_t_fine(data, adc_temp);
> > +
> > +	/* Pressure calculations */
> > +	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[2]));
> > +	if (adc_press == BME680_MEAS_SKIPPED) {
> > +		dev_err(data->dev, "reading pressure skipped\n");
> > +		goto out;
> > +	}
> > +	comp_press = bme680_compensate_press(data, adc_press, t_fine);
> 
> > +	pr_info("comp_press: %d\n", comp_press);
> 
> No debugging in the production code. Or if you really need that, it should
> use dev_dbg().
> 

ACK. I shouldn't have forgotten those here..

> > +	/* Humidity calculations */
> > +	adc_humid = get_unaligned_be16(&data->buf[8]);
> > +	if (adc_humid == BME680_MEAS_SKIPPED) {
> > +		dev_err(data->dev, "reading humidity skipped\n");
> > +		goto out;
> > +	}
> > +	comp_humid = bme680_compensate_humid(data, adc_humid, t_fine);
> 
> > +	pr_info("comp_humid: %d\n", comp_humid);
> 
> Ditto.
> 

ACK.

> > +
> > +	/* Gas calculations */
> > +	gas_regs_val = get_unaligned_be16(&data->buf[13]);
> > +	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
> > +	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
> > +		dev_err(data->dev, "heater failed to reach the target temperature\n");
> > +		goto out;
> > +	}
> > +	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
> > +	comp_gas_res = bme680_compensate_gas(data, adc_gas_res, gas_range);
> > +	pr_info("comp_gas_res: %d\n", comp_gas_res);
> > +
> > +	chans[0] = comp_temp;
> > +	chans[1] = comp_press;
> > +	chans[2] = comp_humid;
> > +	chans[3] = comp_gas_res;
> > +
> > +	/* Push to buffer */
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> > +					   iio_get_time_ns(indio_dev));
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +	return IRQ_HANDLED;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Cheers,
Vasilis

