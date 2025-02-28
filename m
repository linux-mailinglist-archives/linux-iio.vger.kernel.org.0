Return-Path: <linux-iio+bounces-16170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8919A493EF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA757A79D9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2FA253F3B;
	Fri, 28 Feb 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="keMuUWZP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DAD1FE451
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732505; cv=none; b=pK2mnZq6tMKQkdcYj/tGg5UoEQyyPuSm5n3lRPXOr3nF+jd+tArvjvwyJfri2M8Vahkwndtujm+MirOw0aE24m9SM36zk/qgEGdD92U04Df87ySvtT1AehoSvdfo/Ojv21NN3pBTakw2R80sUUi4hRbCUtGhQWsSpEzqgDxm/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732505; c=relaxed/simple;
	bh=5Y4az6HpX0m67GPoqxGohyZ+WCOs21Oqm7I46A/5BDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiusGzZMer1z8vjHue6skbqjtXAh1hQyef2KM/zNrP7LxQj9RPZ72A2SVVihDNJ5GK0uvNISrRepbBpUXcoMSzl4iKL7YjjWRmry/cO/DSqq0DaEpqQ8tOu90FXcAoBGA9IRPfKHc4XFehkY+zzt8l7jqm2sB2cMz70/I+oUlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=keMuUWZP; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=ifGH9TUIXn6Zckh2DlBzL0q10eJHl+qybe+rMqZOb9Y=;
	b=keMuUWZPnJH2Weghw+u/6W/CusmGl770MxkAFbOdTE3rc5Ec7oEIoUcOT6mG6Yew44NWoZTsr2I98
	 SJAGgHbSo2iSz0ZJdRxckwj3l5lgfSAK4zcLDTnU3h4eb5F2JMgGwrMvHofwMXchSSMzr6+4+2nKnA
	 FWBSO2Ry29YUm+30aOt8hbBfO6BaVjvAgTAveROxXTNwQhx+IReOOn+l2EaatGLZPH2KrijO0R20lq
	 pP8Qu/lOD+EFA6jZVyptTIUHgITtSt84nbEzcQK8yQQFscgGZyIaFpXZWhoSK1IWar7O4HWA/US6i0
	 rYwEyE6TvlqckAs5GneTbQrexcsVFfQ==
X-MSG-ID: c1f43f4f-f5b0-11ef-8b43-005056817704
Date: Fri, 28 Feb 2025 09:48:18 +0100
From: David Jander <david@protonic.nl>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
Message-ID: <20250228094818.0aad5491@erd003.prtnl>
In-Reply-To: <20250228-groovy-lyrical-skunk-751ee3@krzk-bin>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-7-david@protonic.nl>
	<20250228-groovy-lyrical-skunk-751ee3@krzk-bin>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Dear Krzysztof,

Thanks for reviewing...

On Fri, 28 Feb 2025 08:11:04 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, Feb 27, 2025 at 05:28:22PM +0100, David Jander wrote:
> [...]
> > +
> > +  enable-supply:
> > +    description: Optional external enable supply to control SLEEPn pin. Can  
> 
> That's odd. regular pins are not supplies. This must be named after
> physical supplies. There is vdd18, vcc, vcp but nothing about enable
> supply in datasheet.
> 
> > +      be shared between several controllers.  
> 
> Second sentence is both redundant and really not relevant to this
> binding. It's not this binding which decides about sharing.

Good point. I think I should drop the whole property, since it is indeed
irrelevant. If extra supplies need to be specified, they always can be, right?

> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - $ref: /schemas/motion/common.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        motor@0 {
> > +            compatible = "adi,tmc5240";
> > +            reg = <0>;
> > +            interrupts-extended = <&gpiok 7 0>;  
> 
> Include header and use standard defines for flags.

Thanks. I didn't know I could include them here... will fix this.

> 
> > +            clocks = <&clock_tmc5240>;
> > +            enable-supply = <&stpsleepn>;
> > +            spi-max-frequency = <1000000>;  
> 
> Where are any other properties from common schema?

The properties in common.yaml are optional. Do I need to explicitly specify
this somehow (they are not listed under "required:")?
In fact, the tmc5240 driver has its own known constants for these properties
that it fills in. One can overrule them here if needed, but I suppose in the
case of the tmc5240 the regular use-case is not to do that. Should I maybe add
a second example that overrules the defaults?

Best regards,

-- 
David Jander


