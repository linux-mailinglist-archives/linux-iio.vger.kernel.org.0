Return-Path: <linux-iio+bounces-24492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F13CBA60FB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5E4383DD1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35C22E1F00;
	Sat, 27 Sep 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKvGRzND"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D984C9D;
	Sat, 27 Sep 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987225; cv=none; b=XsgaAnIz6rhVnfme9Fge9Sr7VxJiaUmYPuNF/ouG0iIWybcW+4hWSppyAcqELwCG50GGGtI9onJuz5DpISa8Hv1ysrDa6fcqp9kdBHr1DMgqYCKlkeUVgXdJS2D28AiRrJCyZUx5JPreIuIh8S/wHEKkgxDZhZ91zO13rO9Kv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987225; c=relaxed/simple;
	bh=YP9XMHyMUiFPIIDHrpJNhaTLyQxop7Ve8HoR8OOr+xM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqzNtZflNEw9uMKZsZtIBlmcnFqWD9NYnPPTxquLvnPkJ2TKnEXBTUjOkyCqmbOQvFK1gLz2Dau8kI6FBj3FRcbcR2scCvT0MsykpblhIzNaHLPWU0DRkpFXbmU/PyId0wHzM5IKjefTt9JTybwYV51HnpelG5MHKQqko47YHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKvGRzND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89A2C4CEE7;
	Sat, 27 Sep 2025 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758987225;
	bh=YP9XMHyMUiFPIIDHrpJNhaTLyQxop7Ve8HoR8OOr+xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uKvGRzNDS9jYjMcVd+pc5wMr3QM22v44//bBx7gOLY6rWWAKjqlbZM8jnaKyloz1I
	 IQpmtkWHO+mBtjCXCp6Ra/uph6kCwtx4rFrIsBH3OYOygl6WALBYHXLW4uAZLcf+V/
	 t6+kjfJtUqEr3S/DuG7ZEQhI0Nd+WBoxC6X2KtY+oFyTbSY15MUfyMEW8xVJUqpMwm
	 teoeMigCDa7TGKw0OpGZzX4xKoIVUu41Xr8omfZDoBo6Pj6LzXObcnHMhxPQBWtFW3
	 uGUuPSTZBiI9Sgm8ej45bYy6aEjAUa9R9GEhN3/rbBcbQD/85oS95fQdeMgtn1ckoZ
	 mwIf+VC/k8wCA==
Date: Sat, 27 Sep 2025 16:33:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20250927163333.55d94113@jic23-huawei>
In-Reply-To: <20250921-unadvised-uninjured-cdd7a6e6f326@spud>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
	<2d6bca62056e1254f91b45f70f4ba4614e659c1c.1758214628.git.marcelo.schmitt@analog.com>
	<20250919-unsure-mounted-0fc49ce72216@spud>
	<aM3HJY0GWJmP8-do@debian-BULLSEYE-live-builder-AMD64>
	<20250921-unadvised-uninjured-cdd7a6e6f326@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 23:20:01 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Sep 19, 2025 at 06:12:05PM -0300, Marcelo Schmitt wrote:
> > On 09/19, Conor Dooley wrote:  
> > > On Thu, Sep 18, 2025 at 02:39:29PM -0300, Marcelo Schmitt wrote:  
> > > > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> > > > PGA (programmable gain amplifier) that scales the input signal prior to it
> > > > reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> > > > and A1) that set one of four possible signal gain configurations.
> > > > 
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > ---
> > > > Change log v1 -> v2
> > > > - Use pattern to specify devices that require gain related properties.
> > > > - Disallow gain related properties for devices that don't come with embedded PGA.
> > > > - Documented VDDH and VDD_FDA supplies for ADAQ4216 and ADAQ4224.
> > > > - Updated PGA gain constants.
> > > > 
> > > >  .../bindings/iio/adc/adi,ad4030.yaml          | 65 +++++++++++++++++--
> > > >  1 file changed, 60 insertions(+), 5 deletions(-)
> > > >   
> > ...  
> > > >  
> > > > +  pga-gpios:
> > > > +    description:
> > > > +      A0 and A1 pins for gain selection. For devices that have PGA configuration
> > > > +      input pins, pga-gpios should be defined if adi,gain-milli is absent.
> > > > +    minItems: 2
> > > > +    maxItems: 2
> > > > +
> > > > +  adi,pga-value:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32  
> > > 
> > > How come this is "value" rather than "gain"?  
> > 
> > Because, for this one, I drew inspiration from ad7191 bindings [1] in the hopes
> > of avoiding creating new properties or using discontinued/deprecated
> > nomenclature [2].
> > 
> > The thing is, we now have ADC chips coming with PGA circuitry in front of ADC
> > inputs. Those PGAs are usually set/configured through hardware connections
> > (e.g. dedicated GPIOs or pin-strapped) and have been described in dt-bindings.
> > Though, since these added PGAs don't follow a pattern with respect to the
> > provided gain, different properties began to appear. ad7380 and ad4000 use
> > adi,gain-milli to describe PGA gain [3, 4], ad7191 uses adi,pga-value and,
> > more recently, adaq7768-1 has been proposed with adi,aaf-gain-bp [5].
> > adaq7768-1 is arguably a slightly different case since the signal gain stems
> > from an anti-aliasing filter, but it nevertheless results in signal attenuation
> > much like some PGAs.
> > 
> > I personally like the -milli (or even -permille) nomenclature because 4 digits
> > have been more than enough to describe the gains (at least so far). Though, I
> > acknowledge the base points suffix (-bp) which is documented in
> > property-units.yaml [6]. The only thing I don't like much about -bp for
> > describing PGA gain is that PGA gains are often described in terms of unitless
> > scale factors, while bp implies the value to be described as a percent.
> > 
> > Anyways, whatever property name is chosen, it will probably be better settle to
> > something rather than arguing about property names each time a new ADC comes
> > with an integrated PGA.  
> 
> If PGA gains are common, then ye it would make sense to have a standard
> property. I guess one of the problems with doing so is that there isn't
> a standard/common binding for adcs themselves, so without making one
> it'd involve reviewers pushing people to the standard one. I suppose the
> current adc.yaml could be made into adc-channel.yaml and adc.yaml
> repurposed. I bet there are more properties than just PGA gain that
> could go there.
> 
> My personal objection to "pga-value" is that it doesn't communicate by
> itself what aspect of the pga it actually controls. I don't really care
> what "unit" qualifier is used that much or if one is used at all. That's
> more of a thing for yourself and other IIO developers to handle.
> 
> Part of me is bothered though that all these gains are not in dB! But
> I'd imagine there are not really any ADCs where the registers don't
> deal in unitless gain and using dB would be nothing more than an
> additional headache for software developers.

To me this problem isn't really about PGAs at all.  What it is really
about is cases where a pin on a chip is either tied to a gpio or pin strapped.
Can we provide a solution at that layer?

i.e. A way to say this GPIO input is tied high so you can't control it
but you can still read what it's current value is. Maybe there is already
a clean way to do this.

Jonathan

> 
> > [1] Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> > [2] https://lore.kernel.org/linux-iio/510f6efb-ada3-4848-ac8e-16fa5d1b5284@kernel.org/
> > [3] Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > [4] Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > [5] https://lore.kernel.org/linux-iio/46842d4cf2c1149bd64188f94c60ce5e4f3b2beb.1757001160.git.Jonathan.Santos@analog.com/
> > [6] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> >   
> > >   
> > > > +    description: |
> > > > +      Should be present if PGA control inputs are pin-strapped. The values
> > > > +      specify the gain per mille. For example, 333 means the input signal is
> > > > +      scaled by a 0.333 factor (i.e. attenuated to one third of it's original
> > > > +      magnitude). Possible values:
> > > > +      Gain 333 (A1=0, A0=0)
> > > > +      Gain 555 (A1=0, A0=1)
> > > > +      Gain 2222 (A1=1, A0=0)
> > > > +      Gain 6666 (A1=1, A0=1)
> > > > +      If defined, pga-gpios must be absent.
> > > > +    enum: [333, 555, 2222, 6666]
> > > > +  
> > 
> > Thanks,
> > Marcelo  


