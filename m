Return-Path: <linux-iio+bounces-26875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68989CAB52F
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99003050377
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585F2F25F0;
	Sun,  7 Dec 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIf13hZc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080562EF65F;
	Sun,  7 Dec 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765113214; cv=none; b=Ri6lev3fKeeBlMgd8oL+/7WKRAAfq+/yh/SaYFp2cz7Q/1K32xIuw2MjFtf64hlCnSVMJZhyt9yKzX4gonIiagmVsLpvi9vJ/Layb1N7qKtf9tkcFfmRMpHsyymMmUxptsOQz/xCitJm/Us1+zfPQeT7S+ofwykoyx6jVeLVfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765113214; c=relaxed/simple;
	bh=nSRVRlvH2TOmH+q56OrUc1tG4J8RyYZQf5RQUQu98cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Toncd/lApZLsFF9j+qvEenjpUcFyjYozSA5EZaVW+9+kfFFJ+J8mBpMft9EAXBXMP6CPTxF0PPCp94yQZA8Y+6JEn04XyUMtZS6NPThh7uEB0tVy+H7RBnmOya2iO95/ut2q7oZy9UxeOXdTh86S1rawyU9lYbUP1jvZWMJJ7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIf13hZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20106C4CEFB;
	Sun,  7 Dec 2025 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765113213;
	bh=nSRVRlvH2TOmH+q56OrUc1tG4J8RyYZQf5RQUQu98cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LIf13hZcwkl50m/zh7glJSM3jpmsdEcsYyEsN7SQdRZvVnwNMWfBSu9c7jdy7/xqw
	 qYIrn7TBmHxkqSFPFACNadnsJth9/v0MeNyitEnIjVJwIrMBWwgwf5/o3dX4ZI7Rk5
	 0XUQAGQtgEPDI5j737ZGQVnJJBQSER1J2fP8iOxaA1mDOs1lYEsyM5u421nR0iVccg
	 Qbb++6jE6Folgq/SRrvp8n1490pR3rIbhEM4K/PBpLuBUrIeQaRA/2lrHvGassnxC5
	 x7q9OMBM1y5jjAxqXajf0oxOY+p7+tj7ESv08V4CeSccmLIOAJm5Z56SV9FzVCknTk
	 Xhs5eob/O/97w==
Date: Sun, 7 Dec 2025 13:13:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add AD4134
Message-ID: <20251207131322.3b270a18@jic23-huawei>
In-Reply-To: <aTLVAAQH-I8Rc372@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
	<06d7be2af0f6520c23f612fa0249ff6a26655cb7.1764708608.git.marcelo.schmitt@analog.com>
	<95dfb96e-f7b8-45df-a704-2984bd0a2946@vaisala.com>
	<aTLVAAQH-I8Rc372@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 09:50:08 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/05, Tomas Melin wrote:
> > Hi,
> > 
> > On 02/12/2025 22:55, Marcelo Schmitt wrote:  
> > > Add device tree documentation for AD4134 24-Bit, 4-channel simultaneous
> > > sampling, precision ADC.
> > > 
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Change log v2 -> v3:
> > > - fixed typo in powerdown-gpios description.
> > > - picked up Conor's review tag. 
> > > 
> > >  .../bindings/iio/adc/adi,ad4134.yaml          | 198 ++++++++++++++++++  
> ...
> > > +description: |
> > > +  The AD4134 is a quad channel, low noise, simultaneous sampling, precision
> > > +  analog-to-digital converter (ADC).
> > > +  Specifications can be found at:
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4134.pdf
> > > +
> > > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +    maxItems: 1
> > > +
> > > +  adi,asrc-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    description:
> > > +      Asynchronous Sample Rate Converter (ASRC) operation mode control input.
> > > +      Describes whether the MODE pin is set to a high level (for master mode
> > > +      operation) or to a low level (for slave mode operation).
> > > +    enum: [ high, low ]
> > > +    default: low  
> > Since minimim I/O mode is only one currently supported, this should
> > always be low, right? Is the property needed at this point?  
> 
> Correct, it is expected that adi,asrc-mode will always be low for minimum I/O mode.
> The property is not _needed_ but, according to dt-binding guidelines [1], it is
> desired.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.18#n17
> 
> >   
> > > +
> > > +  adi,dclkio:
> > > +    description:
> > > +      DCLK pin I/O direction control for when the device operates in Pin Control
> > > +      Slave Mode or in SPI Control Mode. Describes if DEC0/DCLKIO pin is at a
> > > +      high level (which configures DCLK as an output) or to set to a low level
> > > +      (configuring DCLK for input).
> > > +    enum: [ out, in ]
> > > +    default: in
> > > +
> > > +  adi,dclkmode:
> > > +    description:
> > > +      DCLK mode control for when the device operates in Pin Control Slave Mode
> > > +      or in SPI Control Mode. Describes whether the DEC1/DCLKMODE pin is set to
> > > +      a high level (configuring the DCLK to operate in free running mode) or
> > > +      to a low level (to configure DCLK to operate in gated mode).
> > > +    enum: [ free-running, gated ]
> > > +    default: gated  
> > In minimum I/O mode datasheet mentions this should always be gated.
> > Perhaps this and adi,dclkio can be left out and added when driver gains
> > other support than I/O mode?  
> 
> Yes, that's also correct. A few properties are actually not needed for minimum
> I/O mode (i.e. can have their values inferred from the minimum I/O mode requirements).
> Sure, from developer's perspective it's easier to document only what the driver
> uses. adi,dclkio, adi,dclkmode, adi,asrc-mode, powerdown-gpios, regulators, could
> all be left to a latter time. Fine by me if dt maintainers agree with that.

Add as much as you are sure about to the binding now.  Sometimes
we will add properties later (with defaults) to cover things that are
complex enough that they will delay the initial binding merge.

Jonathan

> 
> With best regards,
> Marcelo


