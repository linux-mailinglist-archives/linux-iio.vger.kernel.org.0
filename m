Return-Path: <linux-iio+bounces-8657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CE95A5CB
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 22:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610F21C219FD
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DB16FF5F;
	Wed, 21 Aug 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmvOeEnw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E728DCB;
	Wed, 21 Aug 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271976; cv=none; b=Hq+M8kNivQjbnux3uYfXwcE4WMjvNio4OZ2C9dhtOMLvxjI/HaQ4trvBNSagPfRfix3yBpjgqDZrJ5cu2nEnNfxEN4EAz194VPRtAB3d3BQ7duv3jh/goZdwnlxL260yWTE2fQ7ddE4K8YGVbHzO0buFbKr3Dx+vsl2x9TBbsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271976; c=relaxed/simple;
	bh=KZFoIuBUAwRsEE9EPLeC3SQ7BG3/6K63CDdgv2nlwKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYZz6hNei3iyO126Zf6lmKAiMWg9R59QIiKt68g2yezzLu7HS9gASQnFwPKkMF/ckrgGsWTSh7Mnfz01xodf68bWPUZ1V8YvsZLiF8+YsIf2AVGT52wgDka2Pt6C698J4Sw4aSDYaxXhbhBjBT8ReBySB22KMGkFvHeeob+E+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmvOeEnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929CFC32781;
	Wed, 21 Aug 2024 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724271975;
	bh=KZFoIuBUAwRsEE9EPLeC3SQ7BG3/6K63CDdgv2nlwKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmvOeEnwljbsiucDHUL3T8XfEaD4nQRYqXD0IGMR8ZluLJ//VEfCh8yYji8neYl+f
	 sNWa3hYpgjMbw/32lHAYUNm3WYrQYvoHgE2BNRquloZ2UXrQq/lnmAc7NBvNYqxsn7
	 o7LlXRzC2GrMulmX8mpk1TA0qQiMRmyyhD2W8v/eKP5EhUMdzYQo8fvMrQQTi5ld5R
	 Zz5GggXs9CzlNlkfUONfzRO7kFjh5ia8p2tQtPZYVczhQ6Wf+9c1ltWe77Pg5X5TqN
	 EGcVPrnrxsBM7YlxiJtIMPCod12GdjqTWnXe7yDkllrQ5vCOlDOL0ZTFk+2+2PXtWw
	 K+10uYCUzdFeg==
Date: Wed, 21 Aug 2024 21:26:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH 6/7] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
Message-ID: <20240821212606.6981eae1@jic23-huawei>
In-Reply-To: <CA+GgBR_V8r0Vz1PeKxwD6ovwHXxGM6=Z6XVd03ehokT5C3zjnQ@mail.gmail.com>
References: <20240819064721.91494-1-aardelean@baylibre.com>
	<20240819064721.91494-7-aardelean@baylibre.com>
	<zuvwoy5wtdel7qgkz6wa6valwjwajpwoqnizyoooiawghrxvc3@cuoswu32h4fl>
	<CA+GgBR_V8r0Vz1PeKxwD6ovwHXxGM6=Z6XVd03ehokT5C3zjnQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +    type: object
> > > +    $ref: adc.yaml
> > > +    unevaluatedProperties: false
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: The channel number.
> > > +        minimum: 0
> > > +        maximum: 7
> > > +
> > > +      diff-channel:
> > > +        description: Channel is bipolar differential.  
> >
> > There is diff-channels property, why do we need one more?  
> 
> Yeah, I wanted to use that.
> Maybe I will try another spin at that.
> The thing with "diff-channels" is that it requires 2 ints.
> So,  diff-channels = <0 0>.
> To use it here, a rule would need to be put in place where  "reg ==
> diff-channels[0] && reg == diff-channels[1]".
> That also works from my side.
> Part of the reason for this patchset, was to also get some feedback
> (if this is the correct direction).
> 
So I 'think' this is a datasheet matching thing.
In many cases, even for strictly differential devices, the pin
naming allows for a clear A - B channel description. Here
in the non differential modes, the negative pins are effectively
not used (from a really quick look at the datasheet)

So we 'could' introduce magic channels (give them high numbers) for
the negative ends. I think we may want to do that for the
userspace ABI (0-0 on the few times it has come up has been a
calibration / self check mode not what you have here - it
wires the actual inputs together).  Alternative is just present
them as a simple voltage and don't worry about the differential aspect
as it's not hugely different to bipolar (where the zero level is
effectively the negative input of a differential ADC.

For the binding I'm fine with the binding using A, A as you suggest
with an update to adc.yaml to cover this corner.

We never (I think) have bindings for the self check case where the input
is wired to both sides. It's just a mode that is applied to
any inputs that are wired. 

> >  
> > > +        type: boolean
> > > +
> > > +      bipolar:
> > > +        description: |
> > > +          Channel is bipolar single-ended. If 'diff-channel' is set, then
> > > +          the value of this property will be ignored.  
> >
> > Then provide here allOf:if:then which makes it false if diff-channel(s)
> > is present. And then drop entire property, because you duplicate what's
> > in adc.yaml.  
> 
> Ack.

