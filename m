Return-Path: <linux-iio+bounces-6775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F47913CBA
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6563828304C
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1F118306E;
	Sun, 23 Jun 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g61aITPV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C91822D6;
	Sun, 23 Jun 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159644; cv=none; b=ql6A6P3ksURW39rubkBwnzHDqMUz6FN1GsbwGQvZVyrqHyAUDDn0ew2v7+plrBGaMzuwQ3knL93a5OSp/mJuHPVYa4uf4oSic96QMSx4XCjapIrz5Qe1KDodHbpNyW8J8TEx2xJ2LUQyVJN25sTNsgeD/KNOfIJ8MMrhK7ammkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159644; c=relaxed/simple;
	bh=ybsa2AlMObRZqjJio+sRTrCAG3J3AotfB3UICIYd5Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsdGvHNoQE4gnOU24JtQTCf6VSbuJvj77zfGNSSpQyDE/IEScajGG1R84zE/7uBBIbLt1EZENrzldL2AyTwmAfL+kYVqIj27GNHy5/PJJWyFfGKhX5mNnn8Clmgc3w+FGSelpED6OpOhqnz3zco5932U6fZJutm1FK/7q8n1W90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g61aITPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6117CC4AF0A;
	Sun, 23 Jun 2024 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719159643;
	bh=ybsa2AlMObRZqjJio+sRTrCAG3J3AotfB3UICIYd5Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g61aITPVmyaQzzfWG7pI0GlENhPnv7Cw9Y5XjHJO8tYOpcoqBmnc7AIHg9n5kCKlj
	 dqZOpS9KgjFAXUd3ChAPh0bCVhObRrY/+22SR7BFKcLxhT/enE5RbgeAk+Ah49WAqX
	 9fCKafOdwttyTQ47U7SrNgscLZ54i0QfJ5audW2FqZB7psCFG/Exq54vqldg6h5ISk
	 3Bc/zktN9Yh1kBTYhlhXcOkgEV6lbpp9ZIWKqsvaYuva/1KFG1ViiRYHIgZEYz2AVY
	 xVOIVc+b4GlcedOlV/rpJBKTV1lrcvHwGBcP3Ad4wU7P4XwqSot24YOqX7BK5JvEeS
	 /ubSvIpwBkkfQ==
Date: Sun, 23 Jun 2024 17:20:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240623172033.4d821cff@jic23-huawei>
In-Reply-To: <20240623-juror-ground-9a44d66a002b@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	<20240619064904.73832-5-kimseer.paller@analog.com>
	<20240619-vanity-crowd-24d93dda47b8@spud>
	<20240623144339.6a5087cf@jic23-huawei>
	<20240623-juror-ground-9a44d66a002b@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 15:03:47 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, Jun 23, 2024 at 02:43:39PM +0100, Jonathan Cameron wrote:
> > On Wed, 19 Jun 2024 18:57:59 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:  
> > > > +patternProperties:
> > > > +  "^channel@[0-4]$":
> > > > +    type: object
> > > > +    additionalProperties: false
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: The channel number representing the DAC output channel.
> > > > +        maximum: 4
> > > > +
> > > > +      adi,toggle-mode:
> > > > +        description:
> > > > +          Set the channel as a toggle enabled channel. Toggle operation enables
> > > > +          fast switching of a DAC output between two different DAC codes without
> > > > +          any SPI transaction.
> > > > +        type: boolean
> > > > +
> > > > +      adi,output-range-microamp:
> > > > +        description: Specify the channel output full scale range.
> > > > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
> > > > +               200000000, 300000000]    
> > > 
> > > IIO folks, is this sort of thing common/likely to exist on other DACs?  
> > 
> > Fair point. It is probably time to conclude this is at least moderately common
> > and generalize it - which will need a dac.yaml similar to the one we have for
> > ADCs in adc/adc.yaml.  That will need to make this a per channel node
> > property (same as the adc ones).  
> 
> Looks like it is already per channel node?

Absolutely - but that is a bit fiddlier to do in a generic file so I just
meant make sure to enforce that in a similar fashion to adc.yaml.
> 
> > I'd also expect it to always take 2 values. In many cases the first will be 0
> > but that is fine.  
> 
> What would that first value represent?
Hmm. For voltage equivalent they are often not zero based so it would be the
negative. I have no idea if there are current dacs that act as both sources and sinks...
So maybe voltage one which should be done in this series as well needs to be 2 value
and current variant maybe not.

Jonathan



