Return-Path: <linux-iio+bounces-26485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E911EC8A80C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 16:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD53A2E1D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC9305E01;
	Wed, 26 Nov 2025 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSXCaNWK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB71FCF41
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169245; cv=none; b=dDjSAo4aiLrM73nuHTrKESRzk1BTWPj3GL5th4Au4NXkv6VQVnQSnrV3oKy6eGowIfKyHtU67p1wtPeGwk4UrKzCkSNNJ0aVilYdibILBLBZUtRNWFoKUl7MEpHxp0ViEws+Kc5+8YisCpw+bbgO4Fl+HTB3m7omch1YfBbnD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169245; c=relaxed/simple;
	bh=5QJjkgD4Lg0uyQLZFQujwXLTzVMdno/htIphWOU29XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvStHdrB6yXPXL6jvP0kvbQCRtXDwdSip1xzZf2K98ox6fwmNXlQ1qe+yUvbWMGyUambJshQfUNTnKHuC5Dtk989QkkwEZWCBfZ9xsnF8WD7LAcmASsnKxwkTHwLAwcmc74zSjzEA09XY1BwSIF35SV3EOSWPU/+LlJGPUv48cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSXCaNWK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so12244489a12.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 07:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764169242; x=1764774042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz5EmXohUxVRWC4ev9hUhbYDa/f2qaZaDtF0BMtQeAs=;
        b=eSXCaNWKVXBLdRoGqRRTeoNawi6aez0fAFM0ZMWOu5P5EKfVFQ/AIRrO0TEt66SF0g
         Z6sHSuzCuKN0wHb7pDvC6tRgELzwHwzW0VYeEj0WrwnsvBZL1SGysImALIa6DoNQ/GCN
         cIN7vO/DpOVIGk3+oNC6aQOFKcc7rJNcZgc1dPN6fVYIFhguNuxvSCoiMYElx1AkiXxz
         gX20di/K/Qr6ZzOEiECB49KChioqmOJzdHy9GPcy1+WT40zNJcOnU9b6VGzk7J1r/guF
         CEu6j29s9SOVS8qP+dshWPG7juBxGxwCcgAu8tJBmgKLqinoG7AYojTlnldB66c/p/83
         eOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764169242; x=1764774042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz5EmXohUxVRWC4ev9hUhbYDa/f2qaZaDtF0BMtQeAs=;
        b=AYURAdUMH+FzagQ049d7pxrSxplHMp7Wckd7Jalhz4X19uUKi5vkAkqVhMhv6zgVRr
         O5VjaeOiRBn8qFDCng9huH4pgCFCfUjNvGrzd+shpHvqUWtRKRi3fKxyjeM+8tWGS35K
         Fjv1Uf1r1O2Jz1CZJpCcLUFCntr+ovYaRWdE4Kk+dTvzMrrdSajWsSWJuafw/2IFB7N1
         zQKiWvP4yLndJzIoXk04nSS/+aRywBQdCGdzUnwFLYAgeBwJ7aJWj98FiPb5If+SBskd
         FawM4x0reh9Ex99REzeRV3IQ94UzZLAlMvNaY45zi4NBX8MJis3G4jzXWLMd3vmpmEOB
         ZCyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDtAx8kSR8FQbvAMNRYr7S4LcntbTuy6kpIWpwkVrLzGsM3mt+1s2/AWn0nipaAY5ufJ+QUIyE1zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEm0m7drLX5vWi0bcQAjNbYcKNpEQU/qXXx/N/JPfIhU+Nyouq
	UUklyy/vB59OmYcqfXu3NE+ybPagArjWCtkDFsWCI7oGeyt0k2c/3btM
X-Gm-Gg: ASbGncvlkcyo/Lm3xIL2yKGhmIjWv6/hrXobYgQ+UuuihARbcMX5f3CLfMJsn61zPgp
	/uuScNVTV18kpumkHvsUd3Agj7+bW80PjJJ99IRIAYD+pXB+1Z6tdjhpSWu1D8pSEL2taHVQmuc
	yxHKQvECh62Ed/zZNrMzUePGShC++5zJdpxOaj7HOJbvurogiAkVQafPUNSPi0+6p343ZrBo+iq
	Mi2M+ZCLn3QS09t6LR4Xl8fIqA5KZHGUQjdQ4aWxvtFSYgVcVPO9bweJG1WecdGdmYUS2FUiAWj
	TTsmJuCZVW86zRhltYCTirdHc55g087VXjAtMaBVK2GVFWFwqVr40Zf+Z7fd5zqrhfpxbY3QlD0
	METKKiE+jriy2c62soiWi2BILTNRcR28/7ZMCYErk6gzsNC9XG0gBa+9xb18klADJlZ1yimusu+
	qvz7HJ+NE0UiQAwsf5Vf4nvO0SaSy3f7c37kpn11ZDrr7QGN8x6TPZfzPHQprITfD0rtM=
X-Google-Smtp-Source: AGHT+IGMLKBPp/nalJhT5vdwB6WP7zzO2EVVFWVnhy2g0Kthf4gY+u8ks4h7NDw/yjwO6Ns9fkv+5w==
X-Received: by 2002:a05:6402:1ed6:b0:640:9aed:6ab6 with SMTP id 4fb4d7f45d1cf-6455468d38amr15839431a12.24.1764169242005;
        Wed, 26 Nov 2025 07:00:42 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:1025:ba00:55dc:4ccc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ea9sm20379307a12.35.2025.11.26.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 07:00:39 -0800 (PST)
Date: Wed, 26 Nov 2025 16:00:36 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 7/9] iio: adc: ad4062: Add IIO Events support
Message-ID: <zzrtxpcxzqcjxhxmp5miov4f3kx5i3fpzmrt55azvktkgowejm@n6ofgzoaxoxb>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-7-a375609afbb7@analog.com>
 <aSQ0aM2u49qzIZDm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSQ0aM2u49qzIZDm@smile.fi.intel.com>

On Mon, Nov 24, 2025 at 12:33:12PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 24, 2025 at 10:18:06AM +0100, Jorge Marques wrote:
> > Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
> > Either signal, if not present, fallback to an I3C IBI with the same
> > role.
> 
> ...
> 
Hi Andy,
> > +static ssize_t ad4062_events_frequency_store(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	int val, ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +	if (st->wait_event) {
> > +		ret = -EBUSY;
> > +		goto out_release;
> > +	}
> > +
> > +	ret = kstrtoint(buf, 10, &val);
> > +	if (ret < 0)
> > +		goto out_release;
> > +
> > +	st->events_frequency = find_closest_descending(val, ad4062_conversion_freqs,
> > +						       ARRAY_SIZE(ad4062_conversion_freqs));
> > +	ret = 0;
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret ? ret : len;
> 
> 	return ret ?: len;
> 
Ack
> > +}
> 
> ...
> 
> > +static IIO_DEVICE_ATTR(sampling_frequency, 0644, ad4062_events_frequency_show,
> > +		       ad4062_events_frequency_store, 0);
> 
> IIO_DEVICE_ATTR_RW()
> 
Sure
> ...
> 
> >  {
> >  	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
> >  
> > -	if (iio_buffer_enabled(st->indio_dev))
> > -		iio_trigger_poll_nested(st->trigger);
> > -	else
> > -		complete(&st->completion);
> > +	if (st->wait_event) {
> > +		iio_push_event(st->indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_EITHER),
> > +			       iio_get_time_ns(st->indio_dev));
> > +	} else {
> > +		if (iio_buffer_enabled(st->indio_dev))
> > +			iio_trigger_poll_nested(st->trigger);
> > +		else
> > +			complete(&st->completion);
> > +	}
> 
> Less ping-pong:ish if you simply add a new code.
> 
> 	if (st->wait_event) {
> 		iio_push_event(st->indio_dev,
> 			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
> 						    IIO_EV_TYPE_THRESH,
> 						    IIO_EV_DIR_EITHER),
> 			       iio_get_time_ns(st->indio_dev));
> 
> 		return;
> 	}
> 
> >  }
> 
Sure.
> ...
> 
> > +static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
> > +{
> > +	int ret = 0;
> 
> Unneeded assignment.
Ack.
> > +	if (!enable) {
> > +		pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > +		return 0;
> > +	}
> 
> Just split to two functions and drop parameter 'enable',
>
Sure.
> > +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> > +	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4062_conversion_frequency_set(st, st->events_frequency);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4062_set_operation_mode(st, AD4062_MONITOR_MODE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_get_noresume(&st->i3cdev->dev);
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int ad4062_write_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir,
> > +				     bool state)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +	if (st->wait_event == state) {
> > +		ret = 0;
> > +		goto out_release;
> > +	}
> > +
> > +	ret = ad4062_monitor_mode_enable(st, state);
> > +	if (!ret)
> > +		st->wait_event = state;
> 
> Please use regular patter to check for errors first.
> 
> 	if (st->wait_event == state)
> 		ret = 0;
> 	else
> 		ret = ad4062_monitor_mode_enable(st, state);
> 	if (ret)
> 		goto out_release;
> 
> 	st->wait_event = state;
> 
> Always think about readability first and then about size of the source code.
> 
Sure.
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret;
> > +}
> 
> ...
> 
> > +static int ad4062_read_event_value(struct iio_dev *indio_dev,
> > +				   const struct iio_chan_spec *chan,
> > +				   enum iio_event_type type,
> > +				   enum iio_event_direction dir,
> > +				   enum iio_event_info info, int *val,
> > +				   int *val2)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +	if (st->wait_event) {
> > +		ret = -EBUSY;
> > +		goto out_release;
> > +	}
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		ret = __ad4062_read_event_info_value(st, dir, val);
> > +		break;
> > +	case IIO_EV_INFO_HYSTERESIS:
> > +		ret = __ad4062_read_event_info_hysteresis(st, dir, val);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret ? ret : IIO_VAL_INT;
> 
> 	return ret ?: IIO_VAL_INT;
> 
> > +}
Ack.
> 
> ...
> 
> > +static int __ad4062_write_event_info_value(struct ad4062_state *st,
> > +					   enum iio_event_direction dir, int val)
> > +{
> > +	u8 reg;
> > +
> > +	if (val > 2047 || val < -2048)
> > +		return -EINVAL;
> 
> There was already magic '11', perhaps define it and use there and here?
> 
> #define x11	11 // needs a good name
> 
> 	if (val > BIT(x11) || val < -BIT(x11))
> 	
Not magic number, but max and min signed 12-bit, maybe

	if (val != sign_extend32(val, 11))
		return -EINVAL;
to not look like magic numbers, or 
  	if (val < (-BIT(11)) || val > BIT(11) - 1)
  		return -EINVAL;

For Hysteresis I will change from

	if (val >= BIT(7))
to 
	if (val & ~GENMASK(6,0))

I believe iio only passes positive to the hysteresis, but is a little clearer.

> > +	if (dir == IIO_EV_DIR_RISING)
> > +		reg = AD4062_REG_MAX_LIMIT;
> > +	else
> > +		reg = AD4062_REG_MIN_LIMIT;
> > +	put_unaligned_be16(val, st->buf.bytes);
> > +
> > +	return regmap_bulk_write(st->regmap, reg, &st->buf.be16,
> > +				 sizeof(st->buf.be16));
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
Best regards,
Jorge

