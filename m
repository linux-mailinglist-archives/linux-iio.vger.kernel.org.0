Return-Path: <linux-iio+bounces-17174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C27A6BD4F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 15:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14E8179673
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC101D63F5;
	Fri, 21 Mar 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoG/qVWS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C71D515A;
	Fri, 21 Mar 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567954; cv=none; b=aGE4hTwOF6vLUWO5xdKKmHov1cdXgV8tOdpmBNVpBEs5j8gY6qv/vzTZYshC+jIqPJR684DXwVuzvsHV7kD2YLv/dwE1U3TY61gUlT81f39bLKzdXCGpTAUj9fDHmEjb9goirVNxLnm+QNMbzaukl0Q4MvMao3AVztshCnblgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567954; c=relaxed/simple;
	bh=9E1pV78/mf6vVtqDaYeDkS74zjzNc4WCPPbdzZoF/JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLppatsoZTQH4R3goLomoRgh/402wnTR2YtuCm2uul8kc9pxhO0JND5/iCYld5z58mFqp2SJpkGLbvauttxYJC2EULPd4pQj0S5kH8YB/F3yf1nd0UA4/X7PqKD5ZYPcBpg41PM0mLmNx9ZOx3sn3vf3/aOy7hfG1fk3vc6ROS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoG/qVWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47EDC4CEE3;
	Fri, 21 Mar 2025 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742567954;
	bh=9E1pV78/mf6vVtqDaYeDkS74zjzNc4WCPPbdzZoF/JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoG/qVWSJdwBWze/jCGblq0SITB3IEuYtzANZoB0pFaayxmIfdtsZkVYKzkeIttq9
	 WPhGfeREyqrrCmCYhFdEEJ+6bFOq740ekv32mkvExZ1fkmYKVW4EUacCeVcDbeLUUl
	 NcMx9VYubTzGPlKhOqWANaFLsxTYfIrKmxmgDJ9/cfVa6Qr9gWEcT7AYiY5P9R37oO
	 njUbKC8LOkiQ2LEaiWnEWMhSyBSiSosx68Clgq12kLg6coTQc6Cp7X0j4JN0wqBe2r
	 DKiZEYQ5+9OwRaSB7JznYwtUz+BKJQlcQGrd1NPGx3G570esk9V1kQAGxCYoQT8ttW
	 awYzNjhhcWWww==
Date: Fri, 21 Mar 2025 09:39:12 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Conor Dooley <conor@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH RESEND v3 03/17] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250321143912.GA3214761-robh@kernel.org>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <4136b5259df75221fc314bcd4a57ecaeeab41a45.1739368121.git.Jonathan.Santos@analog.com>
 <20250213-sympathy-suspend-2c414b383195@spud>
 <Z8DZXAivPexoPJkN@JSANTO12-L01.ad.analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8DZXAivPexoPJkN@JSANTO12-L01.ad.analog.com>

On Thu, Feb 27, 2025 at 06:30:04PM -0300, Jonathan Santos wrote:
> On 02/13, Conor Dooley wrote:
> > On Wed, Feb 12, 2025 at 03:16:16PM -0300, Jonathan Santos wrote:
> > > In addition to GPIO synchronization, The AD7768-1 also supports
> > > synchronization over SPI, which use is recommended when the GPIO
> > > cannot provide a pulse synchronous with the base MCLK signal. It
> > > consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> > > a command via SPI to trigger the synchronization.
> > > 
> > > Add a new trigger-sources property to enable synchronization over SPI
> > > and future multiple devices support. This property references the
> > > main device (or trigger provider) responsible for generating the
> > > SYNC_OUT pulse to drive the SYNC_IN of device.
> > > 
> > > While at it, add description to the interrupts property.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > > v3 Changes:
> > > * Fixed dt-bindings errors.
> > > * Trigger-source is set as an alternative to sync-in-gpios, so we
> > >   don't break the previous ABI.
> > > * increased maxItems from trigger-sources to 2.
> > > 
> > > v2 Changes:
> > > * Patch added as replacement for adi,sync-in-spi patch.
> > > * addressed the request for a description to interrupts property.
> > > ---
> > >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 28 +++++++++++++++++--
> > >  1 file changed, 25 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > index 3ce59d4d065f..4bcc9e20fab9 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > @@ -26,7 +26,19 @@ properties:
> > >    clock-names:
> > >      const: mclk
> > >  
> > > +  trigger-sources:
> > > +    description:
> > > +      Specifies the device responsible for driving the synchronization pin,
> > > +      as an alternative to adi,sync-in-gpios. If the own device node is
> > > +      referenced, The synchronization over SPI is enabled and the SYNC_OUT
> > > +      output will drive the SYNC_IN pin.
> > 
> > Maybe a silly question, but why is self-reference needed here?
> > sync-in-gpios is a required property at present, so why can't you
> > operate under the assumption that neither the trigger-sources when
> > neither are present? Is it because only one of the sources could be
> > external and one internal, or there could be either one or two internal
> > sources? Self-referencing properties always feel like a bit of a
> > mistake.
> > 
> We have one internal synchronization source and two external ones.
> The internal is when /SYNC_OUT drives /SYNC_IN (in this case with self
> referencing). The external sources include using a GPIO to drive the 
> /SYNC_IN (sync-in-gpio case) or using an external /SYNC_OUT, the last one
> is described in the datasheet for multi-devices setup.
> 
> The trigger-sources property is inteded to indicate wheter the /SYNC_OUT
> signal originates from within the device or from another source. currently
> we are only handling the internal case. We are not sure yet how to handle
> the external sources.
> 
> > > +    maxItems: 2

From the above, I don't follow how you have 2 entries. In any case, you 
need to define what each entry is in the schema.

I'm also wondering if adi,sync-in-gpios should be instead represented in 
trigger-sources. This would mean we need a 'gpio-trigger' binding. That 
would make the handling of trigger sources more uniform. But maybe not 
worth the complexity.

Rob

