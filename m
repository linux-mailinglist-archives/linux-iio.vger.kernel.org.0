Return-Path: <linux-iio+bounces-6784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E3913D1D
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 19:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E2C1F21D9F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1260183093;
	Sun, 23 Jun 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QktmtB9j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8F3C38;
	Sun, 23 Jun 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163192; cv=none; b=NN+UvoWxRkqcqT8ULZrtEo8NGiZHZi3EYQCJSm0drE53sTjSeq5BrjRzKZiJwBMbF9quhqsEgWunrn64vxFoyCVAVEvOLArYukfx4qQY7sLQ5DZP1Y4yqlI5jsWhzDtIWQn9RBNK7+5K0GkiGVtDvvq2yCTCRyzZnAXdc+hgxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163192; c=relaxed/simple;
	bh=ZJeNRAY0mxU3YeO9azYgC8XGAJ5E9aMKHNqSub6VXm4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yia2QH9aCPPCIaP/QDz2GMKswPIcg1pTDUTbpadMWxO1vZa4dyZ97r9zMJCug8aOTWZqX2Q2hRBijQ5mLx7t7R0LE6fOs3m90Zcuio4hEREgQMj2QV8fxEr7vhTzkCWAdlVYunWu4OAkrBq6lCt4tIs4YaxOQrDeWPXslfkSWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QktmtB9j; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso4466988a12.3;
        Sun, 23 Jun 2024 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719163189; x=1719767989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSoO5GD7ocyCXev3Nzy7ZgYMX1737f5xnuz+qUV4fHM=;
        b=QktmtB9jF11lrdkjNLtTk/MlpG2rIzG0bcs0sFXfRgSlcB3OTjCbJyrHkb+KJOrZt8
         ywNn9YiKeOG0Z8xkdE0D030+K4FVm4wWvhIwxwYg7/Fa1Jt3BnpbGh1dSrP02XM1Y98f
         +3zrll5CmQI/a6001YznyLdP/uSQwX+IS78kc08zpsKtf16dKvhnTRd8WPY4FazgZlu9
         YrxBPvppT57B/Dmu4xRpFGTPQ7S4zyrbXs8XXemDYtO13K5phDnnM1hiEIwHfjO61lMY
         o0RS9fVcf9zV1JrXnQtr33SIcab1ma1g+ppizm3KFCCaUproxJJDNHbSSWTBHBI7+R+2
         dxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719163189; x=1719767989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSoO5GD7ocyCXev3Nzy7ZgYMX1737f5xnuz+qUV4fHM=;
        b=ldFxuXrk298leXqlbqC8pfwTfl3S/i+fUdFTuqDBbwiOKAPYU3SqHGOmSqwgqAZL/j
         YBD/I6+6SMTrt503jpTJzKhvEayqLizP+u6C7crcGqiBkJKb5elwvbUVYiFrQc6lWKqy
         90eFHgh8G6wAyJYBzChop8guR5v7GWwsjAcJ9z35XYZKonZGyByzIu7KcsfOv/nGdYJc
         qcZ2gLXC0mLy99ltJIHzt0zQ+9so98UmdfMxNWIoNRzDq+ih/jgZBNlynTVygrBj9aCF
         Qtw/wlxW2Um1bteOA4UKQdGc8C2PjAG/8xm34lP3kUfUVtVp5OLkquH+y+yuDfPnxf3K
         GOtA==
X-Forwarded-Encrypted: i=1; AJvYcCWSO8MpKNBUa7SG99B22hWbs6GMnkVji5rCP2Zr+KEksFM2WtM5GxrqFM91FvUymZwx0L5dxyYLACnsh8X8FupSLgTo3PCgCTW+0aD8sS3Y2tYYcd9gFSmHZvINp3S9IbBxEm4QHdIG
X-Gm-Message-State: AOJu0YwsZndxfglg+WCWZxcp9AxUGS2blajWQc07ZnryRhOAWa+wW46p
	77EaLceGfc4z8TAPXvdnA11OtZEMGolGttx2iHHzkaJ2m4fJrgbC
X-Google-Smtp-Source: AGHT+IEVx/jDxLkgRvSdIFoGaLWCql90gvaum1Wfc5ZibRDkt+FKhC6A5F/HHJN0FZzrq1DCrvLrfQ==
X-Received: by 2002:a50:a6d9:0:b0:57c:571f:e52d with SMTP id 4fb4d7f45d1cf-57d4a2e9bfamr2249770a12.36.1719163188976;
        Sun, 23 Jun 2024 10:19:48 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:ebc6:e177:f5e2:6440])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048b92esm3815115a12.57.2024.06.23.10.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:19:48 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 23 Jun 2024 19:19:46 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adam Rizkalla <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 3/3] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240623171946.GB202685@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
 <20240617230540.32325-4-vassilisamir@gmail.com>
 <20240622104039.6bb4033b@jic23-huawei>
 <20240622140911.GA130946@vamoiridPC>
 <20240623172615.2123a9c0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623172615.2123a9c0@jic23-huawei>

On Sun, Jun 23, 2024 at 05:26:15PM +0100, Jonathan Cameron wrote:
> On Sat, 22 Jun 2024 16:09:11 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Sat, Jun 22, 2024 at 10:40:39AM +0100, Jonathan Cameron wrote:
> > > On Tue, 18 Jun 2024 01:05:40 +0200
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > >   
> > > > BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> > > > temperature, pressure and humidity readings. This facilitates the
> > > > use of burst/bulk reads in order to acquire data faster. The
> > > > approach is different from the one used in oneshot captures.
> > > > 
> > > > BMP085 & BMP1xx devices use a completely different measurement
> > > > process that is well defined and is used in their buffer_handler().
> > > > 
> > > > Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > Link: https://lore.kernel.org/r/20240512230524.53990-6-vassilisamir@gmail.com
> > > > ---  
> > > The sign extend in buffered path doesn't make much sense as we should be
> > > advertising the correct bit depth for the channel and making that a userspace
> > > problem.
> > > 
> > > I'd failed to notice you are doing endian conversions just to check
> > > the skipped values. Ideally we'd leave the channels little endian
> > > and include that in the channel spec.
> > > 
> > > Hmm. I guess this works and if we have to do the endian conversion
> > > anyway isn't too bad.  It does provide slightly wrong information
> > > to userspace though.
> > > 
> > > So even with this in place I think these channels should be real_bits 24.
> > > 
> > > 
> > >   
> > > > +static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> > > > +{
> > > > +	struct iio_poll_func *pf = p;
> > > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > > +	struct bmp280_data *data = iio_priv(indio_dev);
> > > > +	s32 adc_temp, adc_press;
> > > > +	int ret;
> > > > +
> > > > +	guard(mutex)(&data->lock);
> > > > +
> > > > +	/* Burst read data registers */
> > > > +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> > > > +			       data->buf, BMP280_BURST_READ_BYTES);  
> > 
> > With the bulk read here, we have 24 bits of temperature and 24 bits 
> > of pressure, so in total 6 bytes. The only way I can see to not do
> > the endian conversion is that I memcpy the first 3 bytes to the
> > data->sensor_data[1], and the last 3 bytes to the data->sensor_data[0].
> > 
> > If you can see any other better way please let me know, otherwise the
> > other solution is to use get_unaligned_24(). Still, we won't do the
> > skipping part.
> 
> If you return in cpu endian because it's convenient that is fine, but
> still set the number of realbits to 24 or whatever is appropriate.
> 
> Or as you say memcpy the 3 bytes.  There is probably an arch out there
> in which that is much more efficient than the endian fun, but I
> can't be bothered to figure out how ;)
> 
> Jonathan

Well, thanks for the advice :)

Cheers,
Vasilis

