Return-Path: <linux-iio+bounces-16662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000C9A592CB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE9716B5A9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270E0221573;
	Mon, 10 Mar 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGvZsrnn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA428EA;
	Mon, 10 Mar 2025 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606569; cv=none; b=qQwyZGdfkgYPcZsNRhVSOZoa579EFTmmuHS7o0vxMg3AsjAAaMDVx4F4rafvTAefojxaEq1Gf6d0ADzdJ8TKiGeKAwQtecB08BzPcBsGzV7G3YQ6rpTldNIonO8ucCTaWDFGPI78EvM2r530mG/S8WqOTEJk3ZUoIf1TOiRGbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606569; c=relaxed/simple;
	bh=ArUkuMYyVMyRgyzw49Oucx0cxbpRmb/j4KxfbcZ6zIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/goMz7z360Rl5cPehUwtn+cvFVpnlDv6dRLGJdMspxS+hrLJ+vNt9g32a7t1q5JUUrz+XgckdF9jk8afKZl4VUM9JRP+DT7Ft9cywa9gbrUB9858k/o9HApesWIrWhsoUG0yZPv/w77h4LbbSP+G0V8MqVp3RuitA1d/U+yn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGvZsrnn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac297cbe017so193452566b.0;
        Mon, 10 Mar 2025 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741606566; x=1742211366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8+5USeHmSgmVlekyvx7qsgwmwBwnZMJfqFGewVU4UE=;
        b=eGvZsrnnlNskGj31jlUhnLVf9RhIy1cC9g7ZZlv9HlI1VitedVBaqwpAlbpsi9+KM2
         KFuUKZV3XTmGU+xaUhPJP6q9RxESY9Dkz31agZ3jKLhBUjgDBVx95BLRgtpCIgC+1rqw
         5xPSgx4jSvcUKh/46MeECiVIjMxfXhUYM6Ff6j3VrhcwyqoNoWyNjthZQz1OeoMySfsu
         Qt97w+MBTv2QVFzUEQdbJl27vIlEwioV3FvknkcCfcbExK71abb5f+ITxgbYYTLwKvJ6
         qnA6K1O8F04Kdvfb3Pyn2cm8uetyIhhJZhxsuLQ0uLuzPDD1xuWAtEzQ07tM2JzyojyV
         5Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741606566; x=1742211366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8+5USeHmSgmVlekyvx7qsgwmwBwnZMJfqFGewVU4UE=;
        b=nzJK8a5cCTFHMArD0V+0rxiUnKYmOGdbYh8q5obssdfx7ogL/aBpmFvsu8WOHl1mKH
         OjVe4aXV0WmOEtOO2zRsAVb0cTk2Xa34E7Evn0k+jyPW66dPIqYTQSYdBbzQPz/Wvw4R
         aLNZzRQgTGt+2eO/ScNcxRr4DI8nuuRXEOi++rfUQofFXwDY5Qa7a8Tdm1mjuQscwRI/
         4MdJEQ08Z02oJJlFUVTKQ+GxnnqUC8365Cgum8elMakwxms2oal37FdpJyvKTM4PS3Kx
         UXIwAxtVx7tOGotmQzJIa7qh3SLTAhZ7s/9lxv7NcCYWpnNWJKoSyyzbwXBVInmQq8rS
         kYwA==
X-Forwarded-Encrypted: i=1; AJvYcCUC9do9ZnQ0Dtm29y9iGpckeq375L4PJXvzwlPgucD6H183cNEgSk0AI+ThJAjVJ9KrBCraMUjBUisx@vger.kernel.org, AJvYcCV81inhPUwUZ57vUmu16d9pYf1jqil3SBoNU/ImccbX3BUwR9iy2NR3bRaeHMMxne331T5fcNMTV3j/@vger.kernel.org, AJvYcCVQP+GH9GcXqN31X32f4HZ77zOXKyxDJB27wzIsqmqS+K2wKjqJ02g5DStMBb1lpWBFG5KhW8Mp4DMX6knF@vger.kernel.org, AJvYcCWehe98Z12KRpwYV07v6P8oZVQ3D/1lupc71fRI84zGCKBceF6ysZs8G8ml2Yxqdq1Uokv3tzvevGru@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIuY3ufsmi6iieEO/QnTJdmXf0+BjiiM/LU1EfIRx3e93n8Vb
	IkDqGhZfha3wjuG1L3Wqy7oiG3byeFAiRWeVG0cWTkdf+zmC366Q
X-Gm-Gg: ASbGncvEitd1wTzqgmzg3ltgVWjv+JzYl2NlBxbhHhkmaUcBwYcVPm2O9ZtKjuJtlfs
	5Pgd9qZ93KoMXqSlDKW4HqHNQfDzSOtvXIeeSDL/l2N9hiBbAu6LtSdghZ3hB6nPeE2T1g/jaKy
	RwmAPezFmBjD0vgp6itylL1qC7AsN1Rcgl6LOpOr+/NqRLmFjQqpWMjnt23OVoUmoaCQPox3aOb
	deCEDZUtiQi239NyDtx/2ZOQcZk3nOEp/no5xnDb67b6yrOc62AftRLNz/uVo1sjh6MamAuoGaB
	jxPKC6mRCfuC2vKOTAjFZCJ1Dz8BY3u3pWfJvV1y+Qy0DLpH09ygFLl3wFGi4ocrKAtQ5VfskO+
	SwPWeTQ==
X-Google-Smtp-Source: AGHT+IGt9pk4cOWLU0L9So++JSj6V2Rmf2jxnNguWzT5yBOI36c+FugZzH0ZGjBGx90UzDPn+uYxEw==
X-Received: by 2002:a17:907:cf94:b0:ac1:ecb0:ca98 with SMTP id a640c23a62f3a-ac26cc77b35mr955140566b.26.1741606565955;
        Mon, 10 Mar 2025 04:36:05 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3038:26a:50e7:149f:5ffb:56d9:92cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2811e5b32sm354627066b.159.2025.03.10.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:36:05 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:36:03 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: add support for ad4052
Message-ID: <jotrsravanvshffv7uuqk7ocl7nnabvndjh2aa6dbwsaenmiki@xaqfm6sst4ce>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
 <20250308160257.051395fa@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308160257.051395fa@jic23-huawei>

Hi Jonathan thank you for the review, comments excluded in the reply are
agreed and applied.

> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called ad4130.
> >  
> > +config AD4052
> Aim for alphanumeric order so this should at least be before AD4130
Ups, I got tricked during cherry-pick.
 
> > +#define AD4052_MIN_FLAG			BIT(2)
> > +#define AD4052_EVENT_CLEAR		(AD4052_THRESH_OVERRUN | AD4052_MAX_FLAG | AD4052_MIN_FLAG)
> Wrap the define with \ to break the line.
Deadcode... removed.

> > +};
> > +
> > +static const char *const ad4052_sample_rates[] = {
> > +	"2000000", "1000000", "300000", "100000", "33300",
> > +	"10000", "3000", "500", "333", "250", "200",
> > +	"166", "140", "124", "111",
> Not sure why this can't be done with read_avail and the values above.
Since it is the internal device sample rate, it is an extended
device attribute.
The channel IIO_SAMPLING_FREQUENCY is used for the sampling frequency during
buffer readings.
The macro IIO_ENUM_AVAILABLE is used to reduce redundancy.

The previous integer declaration was unused since the char array index is
used as the register r/w value.

> > +};
> > +
> > +static int ad4052_iio_device_claim_direct(struct iio_dev *indio_dev,
> > +					  struct ad4052_state *st)
> > +{
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return false;
> 
> This might stretch sparses ability to keep track or __acquire / __release.
> Make sure to check that with a C=1 build. If the cond_acquires
> stuff is merged into sparse, this may need a revisit for markings.

You are right!
I also did further fixes caught by sparse.

> > +{
> > +	int ret;
> > +
> > +	if (st->mode == AD4052_SAMPLE_MODE) {
> > +		*val = 0;
> 
> Probably = 1 to reflect no oversampling.
> IIRC the attribute allows either but to me at least a default of 1
> is more logical.
  
Agreed, 1 is now the only no oversampling value.

> > +}
> > +
> > +static int ad4052_assert(struct ad4052_state *st)
> Slighly odd name.  check_ids or something like that.
> 
Went with 'check_ids'.

> > +
> > +	val = be16_to_cpu(st->d16);
> > +	if (val != st->chip->prod_id)
> > +		return -ENODEV;
> 
> Should not be treated as a failure as that breaks the future use of
> fallback compatible values in DT (support new hardware on old kernel)
> Instead just print a message saying it didn't match and carry on as if it did.

Noted, added:

  "Production ID x%x does not match known values", val);

> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	struct device *dev = &st->spi->dev;
> > +	int ret = 0;
> > +
> > +	ret = fwnode_irq_get(dev_fwnode(&st->spi->dev), 0);
> 
> As per the binding review, use named variant as we should
> not be controlling the order, but rather specifying which
> is which in the dt-binding.

Makes more sense indeed.

> > +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> 
> Direction should come from firmware, not be specified here.
> There might be an inverter in the path.  That used to be a common cheap
> way of doing level conversion for interrupt lines and it is handled by
> flipping the sense of the interrupt in the dts.
> 
Agreed, defined the level flags as 0, and kept IRQF_ONESHOT the irq
flag, to dismiss the threaded IRQ with NULL handler needs to be oneshot.


> > +static int ad4052_write_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir,
> > +				     bool state)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	int ret = -EBUSY;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +
> > +	if (st->wait_event == state)
> > +		goto out_release;
> > +
> > +	if (state) {
> > +		ret = pm_runtime_resume_and_get(&st->spi->dev);
> > +		if (ret)
> > +			goto out_release;
> > +
> > +		ret = ad4052_set_operation_mode(st, AD4052_MONITOR_MODE);
> > +		if (ret)
> > +			goto out_err_suspend;
> Given the error handling is different in the two paths, I'd
> split this into two helpers - one each for enable and disable.
> Probably take the direct claim around where they are called.

Yes, that will make it easier to follow.

> > +
> > +	ret = ad4052_update_xfer_offload(indio_dev, indio_dev->channels);
> > +	if (ret)
> > +		goto out_error;
> > +
> > +	disable_irq(st->gp1_irq);
> 
> Add a comment on why.

Added 

   /* SPI Offload handles the data ready irq */

> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +
> > +	/*
> > +	 * REVISIT: the supported offload has a fixed length of 32-bits
> > +	 * to fit the 24-bits oversampled case, requiring the additional
> > +	 * offload scan types.
> > +	 */
> 
> That's an additional feature I think. We don't need to have a comment
> about things we haven't done in the driver.

Removed comment.

> > +	if (IS_ERR(st->cnv_gp))
> > +		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
> > +				    "Failed to get cnv gpio\n");
> > +
> > +	indio_dev->modes = INDIO_BUFFER_HARDWARE | INDIO_DIRECT_MODE;
> > +	indio_dev->num_channels = 1;
> > +	indio_dev->info = &ad4052_info;
> > +	indio_dev->name = chip->name;
> > +
> > +	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);
> > +	ret = PTR_ERR_OR_ZERO(st->offload);
> 
> Use IS_ERR() to detect error and PTR_ERR() to get it if needed (will
> end up calling PTR_ERR() twice but similar anyway.

Ok.

> > +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS, buf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4052_request_irq(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
> > +
> > +	pm_runtime_set_autosuspend_delay(dev, 1000);
> > +	pm_runtime_use_autosuspend(dev);
> 
> These autosuspend things are normally done after enabling runtime pm.
> If nothing else that keeps the devm cleanup as being in opposite
> order of what is set up here.  
> https://elixir.bootlin.com/linux/v6.13.5/source/drivers/base/power/runtime.c#L1548

Makes sense.

> > +	if (ret)
> > +		return ret;
> > +
> > +	fsleep(2000);
> 
> Sleeps like this should ideally have a spec reference as a comment to
> justify why that value is chosen.
> 

This sleep is not needed since there is no timing specification in the
datasheet, removed.

> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops ad4052_pm_ops = {
> > +	RUNTIME_PM_OPS(ad4052_runtime_suspend, ad4052_runtime_resume, NULL)
> Can you allow this to be used for suspend and resume as well?  e.g.
> DEFINE_RUNTIME_DEV_PM_OPS()
> 
> It is a rare case where that isn't safe to do even if there might be
> deeper sleep states available that would be even better.

Yes.

> > +	{}
> Trivial but I'm slowly trying to standardize formatting of these tables
> in IIO and I randomly decided to go with 
> 	{ }
> Please use that for terminating entries in this new driver.

Done on all instances.

I will wait further reviews before resubmitting the patch
If useful for other reviewers, my current head is at
https://github.com/analogdevicesinc/linux/tree/staging/ad4052

Jorge

