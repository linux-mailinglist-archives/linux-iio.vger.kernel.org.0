Return-Path: <linux-iio+bounces-13830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C49F9FDAC0
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963153A1325
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BDB14AD3D;
	Sat, 28 Dec 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exrw+0Uo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621C382;
	Sat, 28 Dec 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735393581; cv=none; b=jElDWt3nPndxrTkdgGMeNPSAzuO550sXdqwXIyEKYBYeHwLqCWeTsucj1G4TnG925fmNNQ4E7ghc5habZcrfAAId8h/XhXffsieolhvAwhKrCCDDui4RyAshHSjZS8opR9ScEVzv8nmsEVlWHv9L4DjF2b192Lti+LK7tipB+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735393581; c=relaxed/simple;
	bh=sPNMAUa6zaIi6/CjfPs+wC02gmcaaGewaAKcC4h92Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgYIceAKFhyawTS2VX9ZGYtI3YP9zymehRQ68jhHCAnYLT7V5QKZFJ5L7DxZxF4O/15cIg4978couvmcYbq4KZs2NtL1tNqx9N7b/1OJzgXr32daPnWFnDUdI1R3t5z/GNDk4CtHmM5IVpgIU5jS4gF5HncOsOtuiS1Y0cIOLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exrw+0Uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201B0C4CECD;
	Sat, 28 Dec 2024 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735393580;
	bh=sPNMAUa6zaIi6/CjfPs+wC02gmcaaGewaAKcC4h92Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=exrw+0UoKTWbefo3jhjh3AtjH/FZiuB7Ecm31Z13jm1Ycdx9BP0SdwTVXJmtcOpKj
	 G8kY8z0Bkt1603LmYGan52wZpDgq2V1eDAf/ttOMoMInj7GoBCeT6ON0AuwHrnzH6O
	 r4tLzqZ6b4MKFjAGbPmIFwZRk0u/oCVYF5V1I7caUnapWsjEUDG9ldtN1SnfVEvusL
	 lfHdCjcPxT5vwSWubeC4npyoMd1hqJP17AtqFfVtQsa7lmBNfP2lwhYdwvR5xIp+x/
	 r1Tee6BULbdHffVEc4/qMsETWdcMvKhIdei+fRuTdyer0zTRDol2b94tfoAhj/UXu2
	 9hzOLg7aeuczg==
Date: Sat, 28 Dec 2024 13:46:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Julien Stephan <jstephan@baylibre.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 Andreas Dannenberg <dannenberg@ti.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Message-ID: <20241228134609.30d62192@jic23-huawei>
In-Reply-To: <PN3P287MB2845E6B3A390BE3741CFBF13FF0D2@PN3P287MB2845.INDP287.PROD.OUTLOOK.COM>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
	<20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
	<Z2rRnBGd4qqJXAb5@smile.fi.intel.com>
	<PN0P287MB2843562E6C965196D05E2BCFFF0C2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
	<Z2wJ9BLsrLeDD-zb@smile.fi.intel.com>
	<PN3P287MB2845E6B3A390BE3741CFBF13FF0D2@PN3P287MB2845.INDP287.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2024 06:14:59 +0000
Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io> wrote:

> Hi Andy
> 
> > On Wed, Dec 25, 2024 at 09:56:36AM +0000, Hardevsinh Palaniya wrote:  
> > > > On Tue, Dec 24, 2024 at 11:43:16AM +0530, Hardevsinh Palaniya wrote:  
> >  
> 
> ...
> 
> > > > > Add Support for OPT3004 Digital ambient light sensor (ALS) with
> > > > > increased angular IR rejection  
> > > >
> > > > Missing period here.  
> >  
> > > > > The OPT3004 sensor shares the same functionality and scale range as
> > > > > the OPT3001. This Adds the compatible string for OPT3004, enabling
> > > > > the driver to support it without any functional changes.
> > > > >
> > > > > Datasheet: https://www.ti.com/lit/gpn/opt3004  
> > > >  
> > > > >  
> > > >
> > > > This blank line is not needed.  
> > 
> > You left two above comments unanswered while Acking the rest, it's a bit confusing.
> > Are you agree on them or not?  
> 
> Apologies for overlooking those comments. They seemed straightforward, so I
> assumed your review was accurate, and I planned to address them directly in the
> next version without explicitly responding.
> 
> Regarding the second comment:
> The blank line was added to differentiate between the commit message and the
> SoB tag. Are you sure it should be removed?
> 
> ...
> 
> > > > >  static const struct of_device_id opt3001_of_match[] = {
> > > > >       { .compatible = "ti,opt3001", .data = &opt3001_chip_information },
> > > > >       { .compatible = "ti,opt3002", .data = &opt3002_chip_information },
> > > > > +     { .compatible = "ti,opt3004", .data = &opt3001_chip_information },
> > > > >       { }
> > > > >  };  
> > > >
> > > > I'm always puzzled why do we need a new compatible for the existing driver
> > > > data? Is this hardware has an additional feature that driver does not (yet)
> > > > implement?  
> > >
> > > OPT3001 and OPT3004 sensors are functionally identical, and there are no
> > > additional features in the OPT3004 that require separate handling in the driver.
> > >
> > > The new compatible string for the OPT3004 is being added, which will allow the
> > > driver to recognize and support this sensor in the same way it handles the OPT3001.  
> > But why? I understand if you put two compatible strings into the DT to make it
> > explicit in case of the future developments of the driver, but new compatible
> > in the driver makes only sense when you have either quirk(s) or feature(s) that
> > are different to the existing code. Since you haven't added either, what's the
> > point?  
> 
> Understood.
> 
> I also found a similar case with the ADXL346, which is identical to the ADXL345.
> In the mainline kernel, a compatible string was added as a fallback in the bindings
> but was not added to the driver itself.

There is a small difference. The ADXL346 at least has a different ID from the ADXL345.
The driver may sanity check that. It shouldn't reject an ID it doesn't recognise but
it may well print a message as sometimes this indicates a wrong DT.

The ADXL346 also has additional registers, so whilst it is backwards compatible with
the ADXL345 additional features may be support in future that need the distinction
to be in DT.

Jonathan


Jonathan

> 
> Thanks for the insight.
> 
> In the next version, I will drop this patch and only submit the bindings for the OPT3004.
> using the fallback mechanism.
> 
> Best Regards,
> Hardev

