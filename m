Return-Path: <linux-iio+bounces-23526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6452B3D2DD
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEFE17B54C
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520E257852;
	Sun, 31 Aug 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR74TKDc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D41CD15;
	Sun, 31 Aug 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643449; cv=none; b=ns04NOsrQM/T4Dd086iFl+o8PGB97ETfYV2PYVfDTmWpQTwJAQPIZzyJGy6HFoUtUisgwXYSDLen0Mu389pGci4skdy6XIuXF8Bo/oRi4/qcdfRxO1gaUW7VSnp9GXWeU7u4ahAh8V7c53kdtXDbAtjguI2KgDHInGEWXc7xHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643449; c=relaxed/simple;
	bh=R8eLqhlHR7/jOIwbmu0MvYDVty+235CBqHedPu5Xeco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEvCKdkTPT66PyDGYr8YXJejcbDa8qrogHsl83r/rF16HSGrlCaGM1Ee0mrep/cQhMVqDTRpT0jW5BRgRcaQg4PygJRC/5sWDbka4i/eTHo3kkWwJktrqH0upSptYO5ptaYfEceiQmRBGWasXUsB1S+X2PbDMUa0hLcR69fFbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR74TKDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0AFC4CEED;
	Sun, 31 Aug 2025 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756643449;
	bh=R8eLqhlHR7/jOIwbmu0MvYDVty+235CBqHedPu5Xeco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CR74TKDclYSFAjjTFj308sBh+T64w7SYrhqVrmtwp8k6uo1yb/PRRYFWl0oUjuRgS
	 0k3aZ33KXGoWNu59Zmd4bG4cm14oM4gK3wItDR92G38eaIr8V14ZqrOr5lUBKHSZZ7
	 dPCXvFF1OFJ6Sz8NL2TRtNMn8IcatZtHaTKY0Hl8nUkxYwrveE5fEtftv00dgsv6kf
	 3Gba1sezPLixdNbzCobw9XyrLJi0udnt66Q3mEShMAIJZ0vfJ2mJEPPDVaPFiw0DYa
	 RgHyVzjNr3u1/YHAvKFWw7dgCgQxP/gofCOumAxNGR+TiDUvlFq+s1SswRpY6bqD00
	 PzKjIh0I/EAEg==
Date: Sun, 31 Aug 2025 13:30:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 20250825154450.75eedc9b@jic23-huawei.smtp.subspace.kernel.org, Jonathan
 Santos <Jonathan.Santos@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Michael.Hennerich@analog.com, lars@metafoo.de, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <20250831133038.026d56e2@jic23-huawei>
In-Reply-To: <aK50KITsXoPTkRbA@JSANTO12-L01.ad.analog.com>
References: <20250824041013.9872-1-Jonathan.Santos@analog.com>
	<20250825154450.75eedc9b@jic23-huawei>
	<aK50KITsXoPTkRbA@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 23:57:44 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 08/25, Jonathan Cameron wrote:
> > On Sun, 24 Aug 2025 01:10:13 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> >   
> > > Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> > > Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> > > provide a VCM regulator interface.
> > > 
> > > The PGA gain is configured in run-time through the scale attribute,
> > > if supported by the device. PGA is enabled and controlled by the GPIO
> > > controller (GPIOs 0, 1 and 2) provided by the device with the SPI
> > > interface.
> > > 
> > > The AAF gain is defined by hardware connections and should be specified
> > > in device tree.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>  
> > Hi Jonathan
> > 
> > Various minor comments inline.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> ...
> > >  	/* Register VCM output regulator */
> > > -	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> > > -	if (ret)
> > > -		return ret;
> > > +	if (st->chip->has_vcm_regulator) {
> > > +		ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	st->aaf_gain = AD7768_AAF_IN1;
> > > +	ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
> > > +	if (ret && st->chip->has_variable_aaf)
> > > +		dev_warn(&spi->dev, "AAF gain not specified, using default\n");
> > > +
> > > +	if (!ret && !st->chip->has_variable_aaf)
> > > +		dev_warn(&spi->dev, "AAF gain not supported for %s\n", st->chip->name);  
> > 
> > I'm confused.  If you hit this warn, you then go ahead and set it anyway. How does that
> > work?
> >   
> 
> I would be setting a variable that will not be used, so no functional impact.
> I could add another condition to avoid assigning it, or do you believe it
> is better to return error like before? 
Just don't set it to avoid confusion.  Alternative would be a comment that says that
it won't be used, which is probably more complex than the code.

> 
> > > +
> > > +	if (!ret) {  
> > use a local bool for ret here with a suitable name. Carrying on using ret is
> > fragile against later code changes where someone doesn't realise it is still in use.
> >   
> 
> Maybe it is better to handle this in a helper function and apply the
> suggestion.

If that works, sounds good!

J
> 
> > > +		/* If provided, validate and set the gain */
> > > +		switch (val) {
> > > +		case 1000:
> > > +			st->aaf_gain = AD7768_AAF_IN1;
> > > +			break;
> > > +		case 364:
> > > +			st->aaf_gain = AD7768_AAF_IN2;
> > > +			break;
> > > +		case 143:
> > > +			st->aaf_gain = AD7768_AAF_IN3;
> > > +			break;
> > > +		default:
> > > +			return dev_err_probe(&spi->dev, -EINVAL,
> > > +					     "Invalid firmware provided AAF gain\n");
> > > +		}
> > > +	}  
> 
> Regards,
> Jonathan S.
> 


