Return-Path: <linux-iio+bounces-14442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0578CA15C8E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 12:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545ED1889110
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121E18A959;
	Sat, 18 Jan 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k770SPkq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F568155757;
	Sat, 18 Jan 2025 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737200938; cv=none; b=Cov9ngVnaLY0L/Co0PtUl3tPKNbodVB6rdvXciP0iBEXGxTy4LbQvmhR+MPk0b8EbTvcBwlYJ9sANKFkoYnzewcQwatLhbUwYwLMGuBg/zab9keU/nQJDdykLk1xBZ+25XJZtXDsBnOV8sGeQPgDVKKQYWsHxvPOSKLZ/yO5OpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737200938; c=relaxed/simple;
	bh=b3Vwi+XF2Ta2nU9vcSwCYJ9xZaxTn7sxWh2usC3XLjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zc0pd0dRvuqbT3oZCcCWFEa+Y8bi74a6gKbSxuA57V9sFZt8LUj9riR3j9nmQDEX+10sRL2P4YSNwkkzN2o/fb6RdL7E+RiCSr8mBk7Vi6dQ3TDpvM8fRxJsDhlDfgHFDPEYWn1t8Az5LZ0Q/jQBwfBFWxTgGGZl7ecyk1OpWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k770SPkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F10CC4CED1;
	Sat, 18 Jan 2025 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737200937;
	bh=b3Vwi+XF2Ta2nU9vcSwCYJ9xZaxTn7sxWh2usC3XLjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k770SPkqI1tbX9Pwba+mp4XqGWfB+b0ywtSAZkXei5adlA3xYs8bmYN73DWb13IrY
	 NgTCPc6Y62aNKkad+VNE8kGCQlxwcRodiTo6U5GAPN1PfgSdt+CmIDDzUP6QxeoXxO
	 V6YIQhraqK8wXlyCjWrYIABBu0VAEYxtce2p1HBqFtfmLutzQcflq7vDEr2SsxbbuI
	 0S72Omdum54L9Dz4ZJAKYmW2h6fOHLVfABlDyVyH6G1iJM6qbY/3IRiVOUxsCoTnpk
	 BBvaGSIomTmQLJuw8ojghv8nZydL2xb+zJwoh58TuHzT151I1PmXWjBQihe0x8fQPd
	 pcr1qpmSXjIGw==
Date: Sat, 18 Jan 2025 11:48:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Cc: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Mikael
 Gonella-Bolduc <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20250118114846.78ce0b67@jic23-huawei>
In-Reply-To: <Z4UeCyxgbzCUQtRz@uva.nl>
References: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
	<20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>
	<20250112111059.677f8708@jic23-huawei>
	<Z4UeCyxgbzCUQtRz@uva.nl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 09:07:07 -0500
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> wrote:

> On Sun, Jan 12, 2025 at 11:10:59AM +0000, Jonathan Cameron wrote:
> > On Mon, 06 Jan 2025 17:23:01 -0500
> > Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> >   
> > > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > 
> > > Add device tree bindings for APDS9160
> > > Note: Using alternate email for maintainer
> > > 
> > > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > ---
> > >  .../bindings/iio/light/brcm,apds9160.yaml          | 86 ++++++++++++++++++++++
> > >  1 file changed, 86 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..756d46c2edb171da840ee49a7339cb781fe84ad2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > @@ -0,0 +1,86 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Broadcom Combined Proximity & Ambient light sensor
> > > +
> > > +maintainers:
> > > +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> > > +
> > > +description: |
> > > +  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - brcm,apds9160
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  vdd-supply: true
> > > +
> > > +  ps-cancellation-duration:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Proximity sensor cancellation pulse duration in half clock cycles.
> > > +      This parameter determines a cancellation pulse duration.
> > > +      The cancellation is applied in the integration phase to cancel out
> > > +      unwanted reflected light from very near objects such as tempered glass
> > > +      in front of the sensor.
> > > +    minimum: 0
> > > +    maximum: 63
> > > +    default: 0
> > > +
> > > +  ps-cancellation-current-coarse:  
> > 
> > I've lost track on what we've discussed previously but I'm curious as to whether
> > we can end up with a cleaner binding for this.  We may well see other identical
> > controls in future, so nice to have something more 'generic'.  I'm not suggesting
> > we don't keep it vendor specific though as not sure it will generalize beyond
> > different broadcomm parts.
> > 
> > It is a multiple of nA, so can we just express the combination of
> > this and ps-cancellation-current-fine as a single parameter, probably in pA
> > 
> > The tricky bit being there seem to be holes, so the allowed list would be complex.
> > 
> > Even if we can't do that can we express it as two nA values rather than indexes?  
> 
> Hi Jonathan,
> 
> These holes just have me puzzled on what to do. There's many of them, and the range in value is very large.
> I thought about just having a single more generic parameter in pA but like you said but I found it was confusing to 
> describe the allowed values and confusing as well to just round up or down since the holes are so large.
> 
> Having two values as a multiplier is more straightfoward for this chip since it's just based on what's described in the datasheet.

I would like them in common standard units even if we go this way.

> 
> If you prefer to keep a more generic parameter, I'm open to the idea of going back to just a single one in pA and
> log a warning in the driver if the value provided ends up in a hole and round to the nearest allowed value.

That makes sense to me as the cleanest option.
Just rely on descriptive text to tell writer of DT binding what values are allowed.

> 
> Are you confortable with this plan?
> 
> If so, there's another problem with the above. I don't see any picoamp suffix in the dt bindings property-units.yaml.
> How should I handle this?

Add it.  They tend to get added on first requirement.  Here
nothing above picoamp works for us.

Jonathan.

> 
> Best regards,
> Mikael
> 
> 
> 


