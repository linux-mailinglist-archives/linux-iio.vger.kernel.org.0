Return-Path: <linux-iio+bounces-6777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4122913CBE
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E44F1F2284A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01D1822F6;
	Sun, 23 Jun 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhYxECAz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345627453;
	Sun, 23 Jun 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159985; cv=none; b=MZ2+jBekR8JgQhYG9Swgk/pSIIWVapjvuZkpkiVPjhkBUrhbMGRyYSS8C/gimO0tIAqw22Z1NrzbZiY+WhpXLGLgis7JWPP07gA6czsHsif2rwiK+6EOleC4JUuF2+/Gd0W7r60DoFi0u7SyeAiZcJG01nbxoK0iscYgm3zzumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159985; c=relaxed/simple;
	bh=q9WIgL8LdLkTd1T79DoVi1Pm+3puHs7bQUNI4ky/kNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfYZ4jkfDVKwkWDtRaaMeYbalm3lDw+kO51HlVTkbzdcqFcX0fmVSnRbyGCSPAo2wryFTrfH/APYJSZXYuYw2ZVad++kdVUVbSdkabSa1HC65s3djt+a48uZkm+HLmRw0GUNtIIv+CXMZOtavxMlkHd3ol6IX0rrSSysHA+Zhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhYxECAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B43CC2BD10;
	Sun, 23 Jun 2024 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719159984;
	bh=q9WIgL8LdLkTd1T79DoVi1Pm+3puHs7bQUNI4ky/kNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mhYxECAzj9D+XmT7o+C3dJps4MQ4/jd5l5QAM2i8pYjiTyT9wCZghBhLjfVm0ZkSC
	 Ovhm84fVxf+ikMkT2G1gW+Qx4WdPg6f3ubD1L7LqqbVah78RDH79545tmH54bbJ7gA
	 zhC0UKfJM38K21pczEwFvWtk3AXECII3leU76Fq5Cn/lkGgamxCoWA05EM6gW3cJVe
	 hZS9oC+Et9G+vOhOWhf1SkKVrLXHjpHpsIFv25NcVMbdL+MN1PTVHxqtvLS6Z53E0x
	 XrV+VvdDYPtrnCDsoeChtO1ga1/RMy4B4cOxuR2XAMBg0jzsc+VB7T2Srdwl7xuidj
	 sk5QwYfgQDnZA==
Date: Sun, 23 Jun 2024 17:26:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Rizkalla
 <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 3/3] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240623172615.2123a9c0@jic23-huawei>
In-Reply-To: <20240622140911.GA130946@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
	<20240617230540.32325-4-vassilisamir@gmail.com>
	<20240622104039.6bb4033b@jic23-huawei>
	<20240622140911.GA130946@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 16:09:11 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sat, Jun 22, 2024 at 10:40:39AM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Jun 2024 01:05:40 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> > > temperature, pressure and humidity readings. This facilitates the
> > > use of burst/bulk reads in order to acquire data faster. The
> > > approach is different from the one used in oneshot captures.
> > > 
> > > BMP085 & BMP1xx devices use a completely different measurement
> > > process that is well defined and is used in their buffer_handler().
> > > 
> > > Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > Link: https://lore.kernel.org/r/20240512230524.53990-6-vassilisamir@gmail.com
> > > ---  
> > The sign extend in buffered path doesn't make much sense as we should be
> > advertising the correct bit depth for the channel and making that a userspace
> > problem.
> > 
> > I'd failed to notice you are doing endian conversions just to check
> > the skipped values. Ideally we'd leave the channels little endian
> > and include that in the channel spec.
> > 
> > Hmm. I guess this works and if we have to do the endian conversion
> > anyway isn't too bad.  It does provide slightly wrong information
> > to userspace though.
> > 
> > So even with this in place I think these channels should be real_bits 24.
> > 
> > 
> >   
> > > +static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct bmp280_data *data = iio_priv(indio_dev);
> > > +	s32 adc_temp, adc_press;
> > > +	int ret;
> > > +
> > > +	guard(mutex)(&data->lock);
> > > +
> > > +	/* Burst read data registers */
> > > +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> > > +			       data->buf, BMP280_BURST_READ_BYTES);  
> 
> With the bulk read here, we have 24 bits of temperature and 24 bits 
> of pressure, so in total 6 bytes. The only way I can see to not do
> the endian conversion is that I memcpy the first 3 bytes to the
> data->sensor_data[1], and the last 3 bytes to the data->sensor_data[0].
> 
> If you can see any other better way please let me know, otherwise the
> other solution is to use get_unaligned_24(). Still, we won't do the
> skipping part.

If you return in cpu endian because it's convenient that is fine, but
still set the number of realbits to 24 or whatever is appropriate.

Or as you say memcpy the 3 bytes.  There is probably an arch out there
in which that is much more efficient than the endian fun, but I
can't be bothered to figure out how ;)

Jonathan

