Return-Path: <linux-iio+bounces-7030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0E291C64C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326D7286198
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEA259147;
	Fri, 28 Jun 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqc8rRT+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B474F5FA;
	Fri, 28 Jun 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601375; cv=none; b=dTgMxpdKWvKZftil0reYk8j91gZshgzyZm7iYWkjMAt8tBd8X9/7S77RdbueISwg43AKhgWaJm1N9/g/rhB1d8w0bgmvhDU7cJZ1GwMHP8nDQw7+iSCSbbB/qA+42N4P/RcI+72Sfsk5KZ5Ho+6wmx+oanTgC4yUpz3GPwu5zkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601375; c=relaxed/simple;
	bh=N9t03XZKgQccCItCN7cqx3ors/e3qKc5BJRS16l4OdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyA6fDGfqTDbJIYW83/7KIgrwZ6yQT9e6IJD5uzo3ODynIZK4fm6haD1toqKDbGqwx4rCO0k6AdsU+DMIWIuoIXzDWHJxy9I2TiGVkSlMUPrEGtXxSIsVnL1TRymcDV1AojGjorb++c90TGflnCRI7cwhzt4eKKrJv5Co3Pts2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqc8rRT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE7DC116B1;
	Fri, 28 Jun 2024 19:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719601374;
	bh=N9t03XZKgQccCItCN7cqx3ors/e3qKc5BJRS16l4OdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uqc8rRT+E+dEuSRf1LMFu46ldn2wDeNlGcbaNLP2xEd5uy2x2zJX+3VNnmQN0ive1
	 vj3i9NtqbGXY8EcZWmlOaR/4PXl6zqC7ktciSnIdvvv8xLms2pXljt7Ev+yWQPvnc8
	 Pthtz1fF5CsIGkFW8ZGEPco4bv4xYw4zSAh83lQJbKz0OxlSotSRfwsAk/J+FiziKE
	 DvRzMbxcSPZtKf1SKFcZRZCnTqoqtP9fglEimi+HPKhjLsf/8jzXkwzdtmPF/Yb0c3
	 Zsnj38yGIxHQjdY1wrNoN+UaUkKpp3wzFHu4ZUvjGwGcgMeCtRzR4GCW/dBSNGNDIr
	 dDImIql4s6Xxw==
Date: Fri, 28 Jun 2024 20:02:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Paller, Kim Seer" <KimSeer.Paller@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240628200243.14b5f1b5@jic23-huawei>
In-Reply-To: <20240625-roster-umbrella-3782caa23791@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	<20240619064904.73832-5-kimseer.paller@analog.com>
	<20240619-vanity-crowd-24d93dda47b8@spud>
	<20240623144339.6a5087cf@jic23-huawei>
	<PH0PR03MB71419D55571B07479B4F4FB8F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
	<20240624-untracked-molasses-31e8769dddd3@spud>
	<20240624183753.0000218c@Huawei.com>
	<PH0PR03MB7141EE1309B35372201A6A80F9D52@PH0PR03MB7141.namprd03.prod.outlook.com>
	<20240625-roster-umbrella-3782caa23791@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 17:20:48 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jun 25, 2024 at 03:51:27PM +0000, Paller, Kim Seer wrote:
> > 
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>  
> 
> > > On Mon, 24 Jun 2024 18:00:24 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >   
> > > > On Mon, Jun 24, 2024 at 03:26:26PM +0000, Paller, Kim Seer wrote:  
> > > > >
> > > > >  
> > > > > > From: Jonathan Cameron <jic23@kernel.org>  
> 
> > > > > > Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
> > > > > >
> > > > > >
> > > > > > On Wed, 19 Jun 2024 18:57:59 +0100
> > > > > > Conor Dooley <conor@kernel.org> wrote:
> > > > > >  
> > > > > > > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:  
> > > > > > > > +patternProperties:
> > > > > > > > +  "^channel@[0-4]$":
> > > > > > > > +    type: object
> > > > > > > > +    additionalProperties: false
> > > > > > > > +
> > > > > > > > +    properties:
> > > > > > > > +      reg:
> > > > > > > > +        description: The channel number representing the DAC output  
> > > > > > channel.  
> > > > > > > > +        maximum: 4
> > > > > > > > +
> > > > > > > > +      adi,toggle-mode:
> > > > > > > > +        description:
> > > > > > > > +          Set the channel as a toggle enabled channel. Toggle operation  
> > > > > > enables  
> > > > > > > > +          fast switching of a DAC output between two different DAC  
> > > codes  
> > > > > > without  
> > > > > > > > +          any SPI transaction.
> > > > > > > > +        type: boolean
> > > > > > > > +
> > > > > > > > +      adi,output-range-microamp:
> > > > > > > > +        description: Specify the channel output full scale range.
> > > > > > > > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000,  
> > > > > > 100000000,  
> > > > > > > > +               200000000, 300000000]  
> > > > > > >
> > > > > > > IIO folks, is this sort of thing common/likely to exist on other DACs?  
> > > > > >
> > > > > > Fair point. It is probably time to conclude this is at least moderately  
> > > common  
> > > > > > and generalize it - which will need a dac.yaml similar to the one we have  
> > > for  
> > > > > > ADCs in adc/adc.yaml.  That will need to make this a per channel node  
> > > property  
> > > > > > (same as the adc ones).  
> > > > >
> > > > > Should I proceed with generalizing common DAC properties in this series  
> > > and does  
> > > >
> > > > I think so, yes.  
> > > 
> > > Yes, that would great.  
> > 
> > I was wondering who would be the designated maintainer for new dac.yaml?  
> 
> I'd suggest Jonathan!

Sure.  Though if anyone else wants to maintain this one they'd be welcome :)

> 
> > > > > this mean somehow removing these common properties from existing DAC  
> > > bindings?  
> > > >
> > > > I think that that one is up to Jonathan.  
> > > 
> > > We can deprecate them.  At somepoint we can remove them form the
> > > documented bindings
> > > but we will need to keep them in drivers forever (which won't be costly in this
> > > case).  
> 
> Right. Anything where the name _would change_ needs to be deprecated and
> kept forever. I was thinking more about properties that are defined in
> multiple locations with the same name, e.g. if "output-range-microvolts"
> existed in 6 different bindings.
> 
> Thanks,
> Conor.


