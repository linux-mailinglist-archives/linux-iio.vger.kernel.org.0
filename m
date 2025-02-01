Return-Path: <linux-iio+bounces-14835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021ADA24A62
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B6318876A7
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365F1C2DC8;
	Sat,  1 Feb 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4FLLJxV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D27208A9;
	Sat,  1 Feb 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427464; cv=none; b=oUxHQ/aA+hlIXFEnr5VG4rAi0L1hMGyojoutsPf1WnS3muyVrImmS4pLYV6rBWmqunpXAZ442PZ5WqP8MiQ+Lj/XpeNnNe8FLE7N5C4VJYldCwrgj5c2vh1ZkheUeb/Q+5awE6DZvJI0/F4U5buqY9VQO1xkMhfSocLa3u+lSgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427464; c=relaxed/simple;
	bh=MQVsCV+rKnGhM+DyLpC+tfup9Av4qyn8X8ziPTES9Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkm7rdIVgM0cIFacLglPouErY6R4le1sUE7x1krpp7VDig8eQ/zVcWbZHz7EdBewHCzXv15gwEHBHtUPdfHrLJuMAABqup85sZnseXjlAGtlaFbppYAupg+JNll9e59QOmKtnFhC7XQ+JjKZY4lYodrLbNDlFOtYn+OWrKNL6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4FLLJxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3277C4CED3;
	Sat,  1 Feb 2025 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738427464;
	bh=MQVsCV+rKnGhM+DyLpC+tfup9Av4qyn8X8ziPTES9Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B4FLLJxV6wErqsmRi2JsDyRToMwuu/8jDvBLXHs4945WFGuxy4aNnf+kq6AUanR/t
	 hUcAVePqCfn4A0gUOdoQWnN4+aAyCY5SSrEVu5osdxMQrQu6aGQrH6VIiwvtdBb6+v
	 V1V6KL8rZrHOX4Uio78ZQXyqYnkouNREJIa0NmzUGN7AMi7r9aPAD/H8yqAXY1QIoh
	 DKvKGSgRvzT8XvTvkWfmCLTL134kJDXWptS+VcHmrZ5mAUueMPmHaTo0SjLjkElkg7
	 IcT3RU5MBLXG4yA0Ii9LrSoNdMphdiUpD5332p9YkqFy5K9AAKL2hwk2166CoLVtZ0
	 /5fMYndlqAOUg==
Date: Sat, 1 Feb 2025 16:30:51 +0000
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
 linux-gpio@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Support ROHM BD79124 ADC/GPO
Message-ID: <20250201163051.1d54cdd7@jic23-huawei>
In-Reply-To: <5cc01bc7-95b7-4a58-86d7-d4293e0e9966@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
	<20250131170840.00002dc8@huawei.com>
	<5cc01bc7-95b7-4a58-86d7-d4293e0e9966@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 17:00:51 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks a ton for the help! :)
> 
> On 31/01/2025 19:08, Jonathan Cameron wrote:
> > On Fri, 31 Jan 2025 15:34:43 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Support ROHM BD79124 ADC.
> >>
> >> Quite usual stuff. 12-bit, 8-channel ADC with threshold monitoring.
> >>
> >> Except that:
> >>   - each ADC input pin can be configured as a general purpose output.
> >>   - manually starting an ADC conversion and reading the result would
> >>     require the I2C _master_ to do clock stretching(!) for the duration
> >>     of the conversion... Let's just say this is not well supported.
> >>   - IC supports 'autonomous measurement mode' and storing latest results
> >>     to the result registers. This mode is used by the driver due to the
> >>     "peculiar" I2C when doing manual reads.
> >>
> >> I sent this as an RFC because I implemented the pin purposing (GPO/ADC)
> >> using pinmux - which I've never done for upstream stuff before. Hence
> >> it's better to ask if this makes sense, or if there is better way to go.
> >> Anyways, resulted drivers spread to 3 subsystems (MFD, pinctrl and IIO)  
> > In principle nothing against pin mux for this.
> > There are other options though if pin mux ends up being too complex.
> > 
> > - provide ADC channels in the binding channel@x etc.
> > Anything else is freely available as a GPIO.
> > Normal GPIO bindings etc for those.
> > 
> > The channel bit is common on SoC ADC anyway where we don't want to
> > expose channels that aren't wired out.  
> 
> Thanks for the insight on how things are usually done :)
> 
> I think the only reason for having all the channels visible in IIO, 
> could be, if there was a need to provide a runtime configuration.
> 
> > For combined ADC GPIO chips we normally don't bother with an MFD.
> > Just host the gpio driver in the ADC one unless there is a strong
> > reasons someone will put this down for GPIO usage only.  
> 
> I don't really know about that. I don't like arguing, yet I seem to do 
> that all the time XD
> 
> I personally like using MFD and having smaller drivers in relevant 
> subsystems, because it tends to keep the drivers leaner - and allows 
> re-use of drivers when some of the hardware blocks are re-used. In some 
> cases this results (much) cleaner drivers.

I'm fully in agreement with MFD being useful, but for very simple
parts of a device it can be overkill. 
> 
> (Let's assume they did "new" ADC, and just dropped the GPO from it. With 
> the MFD the deal is to add new compatible, and have an MFD cell array 
> without the pinctrl/GPO matching this new device. And lets imagine they 
> later add this ADC to a PMIC. We add yet another MFD cell array for this 
> new device, with a cell for the regulators, power-supply and the ADC... 
> The same platform subdevice can be re-used to drive ADC (well, with 
> added register offsets)).
> 
> Allright. I believe you have more experience on this area than I do, but 
> I definitely think MFD has it's merits also for ADCs - they do tend to 
> put ADCs to all kinds of devices (like in PMICs after all, although 
> maybe not with 8 channels and less often without an accumulator).

It's a trade off.  Sometimes we just have a little code duplication
to the need for a more complex design.

Enjoy the rest of Fosdem

Jonathan

