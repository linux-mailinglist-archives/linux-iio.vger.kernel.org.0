Return-Path: <linux-iio+bounces-12573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65C09D71D5
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 14:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECB9B3AE0C
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D441A2C04;
	Sun, 24 Nov 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP3E+set"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309C18BC0F;
	Sun, 24 Nov 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453918; cv=none; b=axe6plOPFOW4PUC41aB+XgJAVOFZ07Gf3puXLFT/O5eDbMErWK6c+GesWtV70FezQP+N4PcdK+1V1FeTZENpeg5nU58zRIp7fvKhWWmz8dI+gs6nQ+4ct4yspAYyXcvkPNU2CyNpVitmdKCcP/cAibFp3vpeS//FFhv/vfQpmxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453918; c=relaxed/simple;
	bh=zi1Nik3oVB0GVhoCU7U+pD67YTGF2NyJviA5EqMdlbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAXjvfe6m/giGvOaYTJCBhwCEgKJGSyotfvO9rH5kpPd0TtayfpjI6aBKXopIKatB9Z1FhXTMHT+qjxAOrxxufCj34vh4s0wExJEsX9Nmk0uAm+NZGzVOFtb9M6mzLmVbP3J+ZRzyroPujNNRD1rHbGopnKMbbgkKqKjPNNmCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP3E+set; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F12C4CECC;
	Sun, 24 Nov 2024 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732453917;
	bh=zi1Nik3oVB0GVhoCU7U+pD67YTGF2NyJviA5EqMdlbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cP3E+setDamTQY6Tn6cU3xggQdt/ukF2pA4bH8ulNFtMf7sv48NoidFHz5d4OXt89
	 /V0uHtq2ypYyH4SbmHHjemrqexHECRJHNTKa/R/H2vlKf9S+D9hoNNnICDTjSqU/sN
	 BoRd+GQBnB/u26J2RZaXGdpZIPQY+7gqB3vUV/CAqU2NusOD3hcmY7tai/GYj8p3he
	 ujy7Km2geDpqYA+0NAjbrv8LDfcyI0qGuCBktOiIlfzUIkY2/T2R2JaAswKhE5kD8c
	 lSbs+2OLYPUw7x6xdd92gTdyYf15kG9tIgWS2+R0yX21sEd7g3LrIDtIhllnWmPSch
	 BvyAR5+4Z7oPg==
Date: Sun, 24 Nov 2024 13:11:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <20241124131147.0d616f82@jic23-huawei>
In-Reply-To: <ZzuGtvdrD6D06rEp@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
	<a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
	<0b8a2d07-feea-409f-a850-7ee0c752a949@baylibre.com>
	<Zzsj9_HVBO5wrJv_@debian-BULLSEYE-live-builder-AMD64>
	<ZzuGtvdrD6D06rEp@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 15:25:58 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 11/18, Marcelo Schmitt wrote:
> > On 11/15, David Lechner wrote:  
> > > On 11/14/24 5:50 PM, Marcelo Schmitt wrote:  
> > > > Extend the AD4000 series device tree documentation to also describe
> > > > PulSAR devices.
> > > > 
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > ---
> > > >  .../bindings/iio/adc/adi,ad4000.yaml          | 115 +++++++++++++++++-
> > > >  1 file changed, 114 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > > index e413a9d8d2a2..35049071a9de 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > > > @@ -19,6 +19,21 @@ description: |
> > > >      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> > > >      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> > > >      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7694.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf  
> > > 
> > > It would be nice to sort these lowest number first.  
> > 
> > Ack
> >   
> Actually, I didn't get how I'm expected to sort those.
> Isn't ad4000 < ad7685?
> Or did you mean to put adaq at the end?
> 
> ad4000-4004-4008.pdf
> ...
> ad4020-4021-4022.pdf
> ad7685.pdf
> ...
> ad7988-1_7988-5.pdf
> adaq4001.pdf
> adaq4003.pdf
> 
> 
> [...]
> >   
> > > And with this many chips, it can be easy to overlook a small difference
> > > in one chips, like ad7694 not having VIO pin, so is it really fallback
> > > compatible? Easier to just avoid the question and not have fallbacks.
> > >   
> > The absence of a VIO pin does not change how the driver handles the devices.
> > They are compatible from software perspective.
> >   
> [...]
> > > >  
> > > >  allOf:
> > > > +  # AD7694 doesn't have a VIO pin  
> > > 
> > > It sounds like using not: could make this if: a lot shorter.  
> > 
> > Ack
> >   
> > > 
> > > Also, it looks like ad7983 doesn't have the pin either.  
> > 
> > Ack  
> 
> I forgot the ad4000 driver fails if VIO is not provided so I was wrong when I
> said AD7694 was software compatible with the other ADCs.
> I see now AD7694 also doesn't have SDI pin.
> Aside from the VIO and SDI pins, AD7694 is similar to AD7685 both being 16-bit
> precision 250kSPS pseudo-differential ADCs.
> The AD7683 part you mentioned is similar to AD7988-1, both 16-bit
> pseudo-differential 100kSPS.
> To avoid complicating things, I'm dropping support for AD7694.
> AD7685 and AD7988-1 are the parts with features similar to AD7694 and AD7683,
> respectively.

General rule is that fallbacks only work if a part is a strict subset
functionality wise or identical.   If we get it wrong, then that's fine
as the more specific compatible allows us to fix things up even for
dt files that are in products, but if we know there are incompatibilities
or things we want to check for in the binding then don't do fallbacks in
the first palce.   E.g. if there is a pin that is only on a fancy device
then even if it will work fine with a driver binding to the simpler one, we
may want to not use a fallback because we want the dt-binding to verify
the pin is only provided for the more sophisticated device.

Gets fuzzy however in some cases!

Usually what DT maintainers are looking for is a clear statement of how
the devices are different.

Jonathan



