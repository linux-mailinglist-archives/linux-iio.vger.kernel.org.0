Return-Path: <linux-iio+bounces-16174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE22A494C2
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 10:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC997A918A
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5172561B4;
	Fri, 28 Feb 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="BB53on2S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4E1EDA2F
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734527; cv=none; b=sMVNPv2qjbrVrN1UrFsAJFZBsmAcpdyBUN52eKuaae0oDxZgaVECO9/3GSAQbIDm7XvvQnTwevOwNWMZ3xJqIkGZG1Ri/t8kbhVKc3kUJMCIyIT8FsubSclzcCogezsDKIUgsztiuNdVXgeV9G3weXNen+ELlLSC1RuAjc4Mdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734527; c=relaxed/simple;
	bh=9h4g6Xq7+qt9vrg/isJrzGdIn31jXKxf7V2H9WCRPMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASyj5QFzwcbM4WqZ9hmHUFcrdHGa+/Qi3uVSbBg4omS91SK7uZHWEWQcMbo+8TyMF5LLKajqOtr8fARYhYvhYaxbaSn9ErqCGwfaLIkx7/afaRoolWCUBwU6ZfVmV+MYNKCT/VAy1zO5uyAAHUUtKIUbcjwV9No5yyeNV4FeXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=BB53on2S; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=WBBTkblEXBxFsJYPymXDFJAe/vnTFzbtnD/Nx9Tb6DY=;
	b=BB53on2SKjQ6lG8RncsKGcVUMiRWDwUMORrFQSRaB6f4E7+Yr5nvFrgn4QFlwANrO/R8gmTzPDu4Q
	 r7jbsdhNvocmYu6nET+d3a7xgifWVXpT4rq44nm5gYXuipymgo1ttyVUlwH418ywCcVed0rFxACq2D
	 VWPsW2myVCJLismtgz83aTo+MXgod3YTEE4hpDtgNr2DDhyu2Enf6A2DWQdB+caXIaYnJ+r0zhsscX
	 9gQKxjSCJXC+4qUKgl2bQ4wiZniQKIWQdpDg9xZTuC81vxVh70oSp3aN2i5+ibUkyFWzXfeXvoY4ag
	 9ZcVM/tQyFo6xHo5PH6KHDld1Y04KuA==
X-MSG-ID: 77ece18d-f5b5-11ef-a39b-00505681446f
Date: Fri, 28 Feb 2025 10:22:01 +0100
From: David Jander <david@protonic.nl>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
Message-ID: <20250228102201.590b4be6@erd003.prtnl>
In-Reply-To: <20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-8-david@protonic.nl>
	<20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
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

On Fri, 28 Feb 2025 08:12:45 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, Feb 27, 2025 at 05:28:23PM +0100, David Jander wrote:
> [...]
> > +description: |  
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +   Simple motor control device based on 1 or 2 PWM outputs  
> 
> Your schema does not allow 1. Test it.

Ok, that came as a surprise to me. Thanks!

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - motion-simple-pwm
> > +
> > +  pwms:
> > +    maxItems: 2  
> 
> List and describe items instead.
> 
> > +
> > +  pwm-names:
> > +    maxItems: 2  
> 
> List items instead.

Will do in next iteration. Thanks.

> > +
> > +  motion,pwm-inverted:
> > +    $ref: /schemas/types.yaml#/definitions/flag  
> 
> And PWM flag does not work?

I have seen PWM controllers that don't seem to support the
PWM_POLARITY_INVERTED flag and those where it just doesn't work. Should all
PWM controller drivers always support the PWM_POLARITY_INVERTED flag, even if
it needs to be inverted in software? If so, there are some drivers that need
fixing.

> Anyway, there is no "motion" company.

Got it. Dropped all the "motion," prefixes.

> > +    description:
> > +      If present, this flag indicates that the PWM signal should be inverted.
> > +      The duty-cycle will be scaled from 100% down to 0% instead 0% to 100%.
> > +
> > +required:
> > +  - compatible
> > +  - pwms
> > +
> > +allOf:
> > +  - $ref: /schemas/motion/common.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    // This example shows how to use the TI DRV8873 or similar motor controllers
> > +    // with this driver
> > +    motion-simple-pwm0 {  
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> e.g. motor {

Will change. Thanks.

Best regards,

-- 
David Jander

