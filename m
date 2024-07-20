Return-Path: <linux-iio+bounces-7741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569BC938183
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883CB1C21296
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770E12F365;
	Sat, 20 Jul 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4jvvmfe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF973D0D0;
	Sat, 20 Jul 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482988; cv=none; b=Z+pKGea0E3Gr0expIZxTriMCU3tRnR8PBI3/txMz8G9EK0vvnEoELjK/n1REJW5M7Jo6L4hBu2wo1lU2/xzokt9IWpPdM1Tp7SEDzqyMvO0xeiv2olv/GJTUwZiOo6iuDMp5taTWb4EdXYgjSBHHtP6pNJ4InwUOvy1VNcMB5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482988; c=relaxed/simple;
	bh=CJlspTwYZ5bsL1GJoxY8im8FLb6MO9vMor+WCZsicjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWI0d0Eo+GN8XMgNDN5n8DEKSmRrRza1HVOREyAQXAf/cw3oaetTsLG7ZXSHSO0zHPflWtOg6+YxtN9VoPlBfYuEzbck19z90AZnpxhTi0jlgsbZbJq6vt/V/Ft3cGrBP+QFeqwMHCUqoSEjhzzTAhjOIzC0B7yLkGieOZG5Bpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4jvvmfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691F4C2BD10;
	Sat, 20 Jul 2024 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721482987;
	bh=CJlspTwYZ5bsL1GJoxY8im8FLb6MO9vMor+WCZsicjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4jvvmfewytML0cyDC9ikGO4XAOK2XdIaj3S7VAc0AFNR3bakYKByAg7NVismc2UG
	 WYnEylW9ZpoazH/EzF4FwDIfPbeXipAdV4hA3MVk68MF8rDjkoO1CANj+zSo4PZ5oK
	 13JkMfTFfKuHCjjRG0mGbpmw2jt3HfGs/3IQlKLNeKQC75cjBwMmKBBNMZY1ETkHf4
	 PGk6izkIBQ81781ypKyxcMhggmKwBxkS3sPUeqMihbkye0xbeKaNBxy8V8/rIT+wjT
	 pWJvMq7U1eeKeSwBHEfAKXh1eV/Oc9/BlkUxmADrsPeHXKEQKWTYt5r+3V4NKiUIMA
	 btsecos7Xm2mQ==
Date: Sat, 20 Jul 2024 14:42:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: iio: adc: ad7192: Add clock
 provider
Message-ID: <20240720144257.200b4511@jic23-huawei>
In-Reply-To: <20240718-revisable-penpal-bc06ff6366ab@spud>
References: <20240717212535.8348-1-alisa.roman@analog.com>
	<20240717212535.8348-4-alisa.roman@analog.com>
	<20240718-revisable-penpal-bc06ff6366ab@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 16:14:17 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jul 18, 2024 at 12:25:34AM +0300, Alisa-Dariana Roman wrote:
> > Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> > clock provider to support this functionality when clock cells property
> > is present.
> > 
> > The clock source can be either provided externally or the internal clock
> > is used. Pair of clocks and clock-names property is mutally exclusive
> > with #clock-cells property.
> > 
> > Modify second example to showcase the mode where internal clock is used.
> > 
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7192.yaml     | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > index c3adc32684cf..edfa4378e838 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > @@ -42,13 +42,19 @@ properties:
> >      description:
> >        Optionally, either a crystal can be attached externally between MCLK1 and
> >        MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> > -      pin. If absent, internal 4.92MHz clock is used.
> > +      pin. If absent, internal 4.92MHz clock is used, which can be made
> > +      available on MCLK2 pin.
> >  
> >    clock-names:
> >      enum:
> >        - xtal
> >        - mclk
> >  
> > +  "#clock-cells":
> > +    const: 0
> > +    description:
> > +      If present when internal clock is used, configured as clock provider.
> > +
> >    interrupts:
> >      maxItems: 1
> >  
> > @@ -169,6 +175,8 @@ allOf:
> >        required:
> >          - clocks
> >          - clock-names
> > +      properties:
> > +        "#clock-cells": false  
> 
> Properties before required, otherwise
Tweaked whilst applying.

Thanks,

Jonathan

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 
> >  
> >  unevaluatedProperties: false
> >  
> > @@ -214,8 +222,7 @@ examples:
> >              spi-max-frequency = <1000000>;
> >              spi-cpol;
> >              spi-cpha;
> > -            clocks = <&ad7192_mclk>;
> > -            clock-names = "mclk";
> > +            #clock-cells = <0>;
> >              interrupts = <25 0x2>;
> >              interrupt-parent = <&gpio>;
> >              aincom-supply = <&aincom>;
> > -- 
> > 2.34.1
> >   


