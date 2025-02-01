Return-Path: <linux-iio+bounces-14834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD8A24A5B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD093A4FBE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4A1C5D66;
	Sat,  1 Feb 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV3YMCpE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C31C1F1F;
	Sat,  1 Feb 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427204; cv=none; b=SNVEvHi24zwzehOXmr6GcFz9K5RDnSea6K0xmDNl+mnpWkg5hjjsJPMglRXgECYp0mTvAS1xFPFwDcWrOIlDOpc2ZMW7qTN8DLqfSU46b05TzeqKE29YZNbrVysWF2QPztwjFYc7j5WNs2+wI55000L7k3961Gbu5wLcKTNxZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427204; c=relaxed/simple;
	bh=GrQn/vAlhRLico+evNaO6oFN5ihzECkatA5KFLG8epU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5bmonTfeOlBJBcHlt2VXexceWMBeYmJfQGkeCmv6TYgRrgDeS+CHgVVtR3iQ4D3yjYphHLk4G6PNMDa3wP2dyuDOjtdej2TDUSduRenjdOy9wk3QoP8VKlXCEubhR84Zs6eHXyUQj9dTXi/J1JvQjGOEXHp5QDdWZb36kTR44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV3YMCpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EBBC4CED3;
	Sat,  1 Feb 2025 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738427203;
	bh=GrQn/vAlhRLico+evNaO6oFN5ihzECkatA5KFLG8epU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HV3YMCpE0fMsqjf8JOo6uBiUl/hLYUT2UK7xHIh/quoXBmLxDhdAlCvSJ7/VngWUm
	 wfi6eCv/X4YMj4fnF3ASioL4EHzw21SaW/NEcEDOGLzNwAfBCkqMy7wUVqaPWvCG8o
	 6KMkbk9+Gon4xhivbE6NlCydzbuwGDhbSgZ9+rB9NGvQ6rN8wzznF0P6gKg5zYk9+u
	 d/ZKs46jep5fZ/3yfrMH/nCvqCyQtaQU9WYZb3v0pi86Gg2SAyMuvMPoQrqaavUe6z
	 89mxzLm2Qf7A032mg11iy/2U1FdZm9tO0GT3jss2NnDxRffVrkKFXt/7D1mb737rNl
	 1zyGf4iwbJN1A==
Date: Sat, 1 Feb 2025 16:26:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus
 Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-gpio@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH 3/5] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250201162631.2eab9a9a@jic23-huawei>
In-Reply-To: <566f15dc-8901-4377-8407-8eac8a54bfe4@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
	<e44851669ce7e91d1295ab7352535c93b89d35bf.1738328714.git.mazziesaccount@gmail.com>
	<20250131174118.0000209a@huawei.com>
	<566f15dc-8901-4377-8407-8eac8a54bfe4@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 17:38:20 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 31/01/2025 19:41, Jonathan Cameron wrote:
> > On Fri, 31 Jan 2025 15:37:48 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> >> an automatic measurement mode, with an alarm interrupt for out-of-window
> >> measurements. The window is configurable for each channel.
> >>
> >> The I2C protocol for manual start of the measurement and data reading is
> >> somewhat peculiar. It requires the master to do clock stretching after
> >> sending the I2C slave-address until the slave has captured the data.
> >> Needless to say this is not well suopported by the I2C controllers.  
> > 
> >  From what I recall that is in the I2C spec, so in theory should be supported.
> > Ah well.  
> 
> Could be I am mistaken then. Or, maybe I just misused the term "master 
> to do clock stretching".
> 
> I know that it is not rare the slave device is keeping the clock down 
> for extended period (in this case so that the measurement would be 
> completed) - but at least I am not aware of any APIs which could be used 
> to cause the _master_ side to keep the SCL low for an extended period 
> after receiving the ACK (after sending the slave address). In this case 
> it would require this driver to be able to set a time for how long the 
> master would keep SCL low after sensing the slave address, before 
> sending the "command" bytes.
> 
> |S|ADDRESS+R|a|STRETCH|8-bit-i2c-frame|A|8-bit-i2c-frame|A|STRETCH|8-bit-i2c...
> 
> Above denotes this "master stretching". CAPITALs are initiated by 
> master, lowercase by slave. S, is start, a is ack and R is read-bit.

Ah. That is indeed more unusual. You were correct that i was thinking
of the client side doing the stretching!

> 
> If there is a standard way to implement this in Linux side, then I might 
> consider using it as it'd allowed much higher capture rates.
Not that I'm aware of. 

Wolfram, have you seen anything like this?

> 
> >> It is worth noting that the ADC input pins can be also configured as
> >> general purpose outputs. The pin mode should be configured using pincmux
> >> driver.  
> > 
> > We shouldn't be presenting channels that are configure for GPIOs as
> > ADC channels.  It is very rare that there is a usecase for any
> > dynamic switching.  
> 
> Thanks :) If the dynamic switching is rare, then you're definitely 
> right. I need to see if using the pinmux still makes sense, and if we 
> can implement this while using (separate) pinmux driver.
> 
> > Normally it's a case of what is wired and
> > so static.  
> 
> I should implement a device which can be controlled via it's analog 
> output line :) If nothing else then a device shutting down when it's 
> output is pulled low ;)
> 
> ...Well, I have no real use-case for dynamic config either.
> 
> >  Hence build the iio_chan_spec array for just the
> > channels you want, not the the lot.  Channel sub nodes in the
> > DT are how we most commonly specify what is wired.  
> 
> Hmm. That'd mean the ADC channels _must_ be defined in DT in order to be 
> usable(?) Well, if this is the usual way, then it should be well known 
> by users. Thanks.

Yes. We basically have two types of binding wrt to channels.
1) Always there - no explicit binding, but also no way to describe
   anything specific about the channels.
2) Subnode per channel with stuff from adc.yaml and anything device
   specific.  Only channels that that have a node are enabled.

There are a few drivers that for historical reasons support both
options with 'no channels' meaning 'all channels'.

J

