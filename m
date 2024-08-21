Return-Path: <linux-iio+bounces-8680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F4D95A766
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BD281559
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41A917BB0D;
	Wed, 21 Aug 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcUzpznG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7317107F;
	Wed, 21 Aug 2024 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277487; cv=none; b=Iwrnt82/8F5iRXHXHD/38L2VZPfv1pet1AjmnAz2ZWGTD0xzvXBFqgPsfmwWN2XjM3neg5ltfmG1ijY4FVmus5ar1FHNyuWGHONdqfpZVEFgSSkFnxICwnQvDQR3TOO7APR8UcazFTvTNSVp+9RmETeQAu45OaGiNH/l+XqEgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277487; c=relaxed/simple;
	bh=+SBnayt8I9POGC6Z4kUZdlldRPzdI4LiFSzkUVieduA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0smSrb7pE6RaeUrj1yClcgE286eVYUlWAJSRzjtaZPu5rkfBpTRPkFEa5DMOfe12dURaXB0J5MhFJczVRxJFxZ+qn18exJx8cQ4k6cOJlpADzUXwCdogsegos+CRHxuSVXIENdC9x+l/SwtRCk1kgeefZdrMR2BoTdoD7QhGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcUzpznG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so263082a12.1;
        Wed, 21 Aug 2024 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277484; x=1724882284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4JxLJ3yCZeyzGMpvIB3lGyUgpd8ODQ55Z0OhMRCK9A=;
        b=VcUzpznGcdV/l7EkHnL3riGUjpocmYldGhusVFN8gmsZm9oD6tsP4uEZoqwP1s/ufl
         goEUSamab5BDi4wDlQ1Xslu0NRlL7AvNMhoWC9evy+25WSTdNB8VgJnp+tEu8yVlVyAO
         Iim+h7L3bsAGCGv1V6R66h/xktio7xgv3Ic/f7/98FJXwbV3cb95E7dotgnf7+QdbTAp
         F4ow5VJoSVNj1w0Rf2iEN1ggASgXlgqZ/7yHynkNThik5+PqUR7X0Ja4nZBJbUSEwHIB
         dUt86Fewg0+RZT1HGqMZuc7QluvwRv6cRT7skgihPh+/JHMQM2Su5DkBui2x8ucJrYNl
         2C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277484; x=1724882284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4JxLJ3yCZeyzGMpvIB3lGyUgpd8ODQ55Z0OhMRCK9A=;
        b=FCzhRWT7aEWUyfbzGqM0WJ8FFPjLAXSrjMCiwe9kBmsLkp+3aX7gXtSfNi3+Y90jvp
         uxBIXx39qyNGIWFN6t3bQZdyDHzm5kQwTz984jgfyumMSudcQgjIjJT8vf46d5sr4nMp
         fKXpzca5FtejDS/mYRJGvbFcV1f6jwO2YNpW9NKz2cHS6scDH5ETBIWTdwl/ooEApCRS
         1CTGuewKHD00KX+1sNT8dj6UUDmTY2TJuyiPdIMh9Qaf+2bdHDZujge85kYFIm0hSpPx
         YbZmsSCJvRpwkOvuFcIInVRUvDwaOSe1kA2PLU630tQhpwhsZofhmSVEQ+SHzEMRoGoN
         zPyA==
X-Forwarded-Encrypted: i=1; AJvYcCUg74IJuAsYv0O5WpiE/6UXG+8d8RvRl1s5OE3FnFUsNFPnV5AKI4/sBUwPG4xX+if4cqNSXoL43iHu@vger.kernel.org, AJvYcCVTBiujqCNDtmcMSTipWIPDgEgIzq4wWgvyO6j30W/coDAxIk3wI5OnCtldcj+UB2Ga/f2F+IZWofrXjOzv@vger.kernel.org, AJvYcCWPt3jB0NdcxCP4a7dUlJbmRuK+wLmYnB+F54YALQo5drAOzju60NG4kbMRq2GWQRRNCSKZWJtVr2D4@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkHBOR+Ecri1tbkE5Log+UQdT1cwAwHlzsXMk87jRk+2u40kd
	DEIM3SCZ9pOvdxlV6aXejwTP3VOGBj32KV6Ma5KJNljz3bPcLQspbEm2MOdu
X-Google-Smtp-Source: AGHT+IEaTOzPVxPeOj3quhh16rDx3tH8v0cmgQK+NTc6aeD46cYno0HY4pq5o9h6w8RDWfFkHcgG+A==
X-Received: by 2002:a17:907:96aa:b0:a86:6a26:fec7 with SMTP id a640c23a62f3a-a866f35f3a2mr259475266b.30.1724277483695;
        Wed, 21 Aug 2024 14:58:03 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:1594:887e:30dd:c59e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddc0d0sm83597a12.10.2024.08.21.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:58:03 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 21 Aug 2024 23:58:01 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: pressure bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <20240821215801.GB478206@vamoiridPC>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
 <20240725231039.614536-8-vassilisamir@gmail.com>
 <20240728170915.26b4a01d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728170915.26b4a01d@jic23-huawei>

On Sun, Jul 28, 2024 at 05:09:15PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Jul 2024 01:10:39 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > This commit intends to add the old BMP085 sensor to the new IRQ interface
> > of the sensor consistence. No functional changes intended.
> > 
> > The BMP085 sensor is equivalent with the BMP180 with the only difference of
> > BMP085 having an extra interrupt pin to inform about an End of Conversion.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Trivial comments inline + as the build bot pointed out you can't use data from
> one array to fill the other.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 72 +++++++++++++++++++++++-------
> >  drivers/iio/pressure/bmp280-i2c.c  |  4 +-
> >  drivers/iio/pressure/bmp280-spi.c  |  4 +-
> >  drivers/iio/pressure/bmp280.h      |  1 +
> >  4 files changed, 60 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 4238f37b7805..e4d017358b68 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -3104,13 +3104,19 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
> >  
> >  	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
> >  	if (irq_trig != IRQF_TRIGGER_RISING) {
> > @@ -3120,13 +3126,12 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
> >  
> >  	init_completion(&data->done);
> >  
> > -	ret = devm_request_threaded_irq(dev,
> > -			irq,
> > -			bmp085_eoc_irq,
> > -			NULL,
> > -			irq_trig,
> > -			name,
> > -			data);
> > +	ret = devm_request_irq(dev,
> > +			       irq,
> > +			       bmp085_eoc_irq,
> > +			       irq_trig,
> > +			       indio_dev->name,
> > +			       data);
> Whilst here, put some of those parameters on the same line (staying below
> 80 chars).
> 

Ack. I was aiming for as less intrusive change as possible.

> >  	if (ret) {
> >  		/* Bail out without IRQ but keep the driver in place */
> >  		dev_err(dev, "unable to request DRDY IRQ\n");
> > @@ -3137,6 +3142,44 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +const struct bmp280_chip_info bmp085_chip_info = {
> > +	.id_reg = bmp180_chip_info.id_reg,
> As the build bot has pointed out you can't do this.
> Annoying but just duplicate the original structure with whatever
> changes you need.
> 

Extremely annoying because it is litteraly just one addition in the
new array and everything else stays the same...

Cheers,
Vasilis

