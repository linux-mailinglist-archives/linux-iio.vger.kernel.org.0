Return-Path: <linux-iio+bounces-8764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E1295DDBE
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 14:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C87A282239
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F81714B0;
	Sat, 24 Aug 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYDH3U+v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B32154C1E;
	Sat, 24 Aug 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501259; cv=none; b=iKga+NoSGKK5joaUR0i+k1+hZ2S+EaYWR2be09ktRcroDuiVRL4BlQOARVie7ZQ1dI93ngz8KXS76YrMVV1kw4s3EpuUWj7gBXwtXRpFyaobqzh6VGohvZAxRIxX97wrLY2Cp7GfhpblQmiJpvsIVtVjkgubPFdVFuky08MZ2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501259; c=relaxed/simple;
	bh=4FX4gq8ZjS+y/IT0nfGeXpZskKk6x/iV7+djBUBkN88=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyVzRVaBaVXwqBZ+RsUgvM9I55mbVVRRlsAcjFkTrHXAEpfMBNYXRucVSmOwaRqK9C1CykCtrvnxkVhK7zVBOfWrNQ1t4amdlFykmNJ8JfZQzauqNYUiJoWbMUZXyDI6hcDdbVbVu7KRnsJ/cMI/6t5EDSDyquobCer8n0o1AuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYDH3U+v; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so3429528a12.1;
        Sat, 24 Aug 2024 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724501256; x=1725106056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLxf00W2rWvLg4JHdwCMK0lX3uw7Ej0dcTwkQtQansQ=;
        b=TYDH3U+vH8avUH2vytTrqasrXWFjUlYITFuKZgMBPOHMeiKJvLLHQ+PbvC/UNFJt0d
         zcr8Gixm1PCD/wSXZbVtLjp4SbvfLilAHScI6cguXz+OqGaYym27IUAjo1KVEshR1ynA
         vlIF9fZaTINQHTYDCN4W8D+PrFAJrAt6V2gXsg7ihTaF+JV2hmELStXkd7nZpVnnUIiJ
         s765Vuvy/O7u8xa6KsoPDLcMHcbmyyD+8MHzpKbZ6mzJ/J4WxGgUOhnuP8lKbN+NTkAX
         gwJiAgHOrfvK3QdjVL82g6nVAcKWSDwC0nNdGQ5G5seSivrf69QaKKXmd0zjXuI8j/CL
         WdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724501256; x=1725106056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLxf00W2rWvLg4JHdwCMK0lX3uw7Ej0dcTwkQtQansQ=;
        b=JDcTm2eFxnDjorKusiY5fUR28xbiAg8ogw380RD0GuvmsqeWpJODkxEnfDIq9lwmsU
         aPj+6y4fWCY6WQk9uD19MgjRKHuZFCZIJxcx4h4IEYKtWf/ILT8vix/RnuaLmPEQPYVm
         ZzKOsn6QdVBlpSsxOE1ty7WBIbGF+4beQCAwhSF3jQbEgHss2T//+Waa6rfEz8a6S1oh
         cW8AwvjT5OcLKax1luTPwaA52D0x0QGjWAa8GztxdeAJMMqfJrv0W5EQ2ztK8icDldIs
         QR7pDzYYFv11BfWv1KH29tbP7SEY1LZYtbnEW2/XW4fBrLda7KKhzNyuJKhAE/HJTlRh
         eESg==
X-Forwarded-Encrypted: i=1; AJvYcCUVi/TlDOaXSPc0MkxCJkfeRfshB3gzddJxRzUdkT2Df0ct19poPS7C7AZt/VatqGBG6kzCikkrpzmw@vger.kernel.org, AJvYcCUnUoXI/We6LlCWNCGQnqnz5NaPLEDwPTfqItrml/30t3NIquCDmpWId/j1KfO6wqGJOFKhK9dzv+GAuzSu@vger.kernel.org, AJvYcCX0kq32NQUBz9hZ9N68ZiYBIIm+BwO/NXQ2/0Me4C+fnbzrg7ZGLfRRjQ4Ue8TDjAortL5RiKdfnTBN@vger.kernel.org
X-Gm-Message-State: AOJu0YySznFRxBRZecmKNGY6OwKcgRyH3A364Kcd0LwTFiD/oYV7eJNg
	MSDFtexLVjKmyKxEuy9viCflMiI/I8B+wdg8quMZc/aaFwD5JFt2
X-Google-Smtp-Source: AGHT+IGIDBgoJLCA7PFFI03mN9NQEosUmWDV/kWqGwMrhi40HYiNBRKPZc6ay+MB7+T8UEljlcDVWw==
X-Received: by 2002:a05:6402:40ce:b0:5be:f3ae:b9d1 with SMTP id 4fb4d7f45d1cf-5c0891a1070mr3811766a12.23.1724501254968;
        Sat, 24 Aug 2024 05:07:34 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cb04csm3231276a12.31.2024.08.24.05.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 05:07:34 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 14:07:32 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: pressure: bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <20240824120732.GH9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-8-vassilisamir@gmail.com>
 <20240824110242.1de08d96@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824110242.1de08d96@jic23-huawei>

On Sat, Aug 24, 2024 at 11:02:42AM +0100, Jonathan Cameron wrote:
> On Fri, 23 Aug 2024 20:17:14 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > This commit intends to add the old BMP085 sensor to the new IRQ interface
> > of the sensor consistence. No functional changes intended.
> 
> interface of the driver for consistence
>
 
ACK.

> > 
> > The BMP085 sensor is equivalent with the BMP180 with the only difference of
> > BMP085 having an extra interrupt pin to inform about an End of Conversion.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 68 ++++++++++++++++++++++--------
> >  drivers/iio/pressure/bmp280-i2c.c  |  4 +-
> >  drivers/iio/pressure/bmp280-spi.c  |  4 +-
> >  drivers/iio/pressure/bmp280.h      |  1 +
> >  4 files changed, 56 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index f5268a13bfdb..1d27777d8a2c 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -3058,13 +3058,19 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -static int bmp085_fetch_eoc_irq(struct device *dev,
> > -				const char *name,
> > -				int irq,
> > -				struct bmp280_data *data)
> > +static int bmp085_trigger_probe(struct iio_dev *indio_dev)
> >  {
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	struct device *dev = data->dev;
> > +	struct fwnode_handle *fwnode;
> >  	unsigned long irq_trig;
> > -	int ret;
> > +	int ret, irq;
> > +
> > +	fwnode = dev_fwnode(data->dev);
> > +	if (!fwnode)
> > +		return -ENODEV;
> > +
> > +	irq = fwnode_irq_get(fwnode, 0);
> 
> Should check this + as Andy pointed out in earlier review this
> call will return an error if fwnode not present anyway so can skip
> earlier check.
> see fwnode_call_int_op() definition.
> 
> Otherwise, Andy has given some detailed review. I wouldn't suggest
> applying the style cleanup to existing code but he's entirely
> correct that we can make the stuff being touched anyway easier
> to read.
> 
> The more functional stuff maybe needs to be looked at in other
> drivers though.
> 
> Jonathan


Hi Jonathan,

Thanks for the feedback. Indeed Andy has given a very detailed
review feedback, I will also check what you said.

Cheers,
Vasilis

