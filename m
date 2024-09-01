Return-Path: <linux-iio+bounces-8942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367429676FF
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB850281F75
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF84180A76;
	Sun,  1 Sep 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQr26wMk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6214A4FF;
	Sun,  1 Sep 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199745; cv=none; b=Bdi2ggC0q8c14d5ZawXgHwo64pcIWmUJkzedYpQkQNE5tNjzZbuzKuPampF95bZUtS/3ksoydgin0XhQVqK4fOG8oTWgXJJgb1hdve+3f/uVB/WN8sKdcBTR8MOCkm5uV0YvvR2T3FAiOG9pNqttmx8CAOj64a+MKDoqtPM5eK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199745; c=relaxed/simple;
	bh=cILu17DLD+7ctAgpLpk0NPj5l1P/CCVYn9sNr9rE0vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzkxseBiEUIVeft52TLCz9+x15Lt5ylKPT2ru0eZTtnOb2MVyc+3HT3lnHP29LBPUy8HxQnKdAnit8n8IUjCb3+7hlHoVX3G8zjztBPQnEhUhDp0ESuvnpDB40eTYvGzxk4ovYeZ1nA0ZKyKzNxbh7V+9FyG62bndJD3GMZP8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQr26wMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581F3C4CEC3;
	Sun,  1 Sep 2024 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199744;
	bh=cILu17DLD+7ctAgpLpk0NPj5l1P/CCVYn9sNr9rE0vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rQr26wMkyfhc9tuYdGLVMviJaCk3yB8aCgoJS9W45ZDzlkfX5fRVDpQiNsN79qLRg
	 3VaAYgCKtuszkDn1KP7dQcqLonTj9dvCFRU5g1DRe8Tc/9Khy5W9416isj4niIkQa4
	 Yy++4IdnFzCY+nud6VvsMxs7ouOBInKqQ5wictXg7DegRcERFEx3UojKj2XcdP6rM0
	 l+8WwscUUNPVnjVyh91R0ympcx8UdcvKksX3+ApD98HreVCslEFoPnTLWADtb9rjnh
	 rSMb6Jq8RlMVnVdxf2LKdLkyquoSIrL9G7J/76eS2zkEqE+Qyfn0A5pozl7/plf6+8
	 QQ8gE0mALUTEQ==
Date: Sun, 1 Sep 2024 15:08:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, songqiang1304521@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: vl53l0x-i2c: Added continuous mode
 support
Message-ID: <20240901150857.7f130363@jic23-huawei>
In-Reply-To: <CAG=0RqLfjPF2_ebuabo0_ddvRxZkTLmKUAXQZWYHRaKxDaOkew@mail.gmail.com>
References: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
	<20240830201627.298264-3-abhashkumarjha123@gmail.com>
	<20240831134219.3d394c1a@jic23-huawei>
	<CAG=0RqLfjPF2_ebuabo0_ddvRxZkTLmKUAXQZWYHRaKxDaOkew@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 22:12:27 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> > Also, consider if other triggers could be used as if not you need to
> > both document why and add the validation callbacks to stop other triggers
> > being assigned (once you've added one that can be!)
> >
> > Feel free to ask if you have more questions, but your first reference
> > should be other drivers (and I hope we don't have any that do it this way).
> >  
> I used this driver as a reference
> https://github.com/torvalds/linux/blob/master/drivers/iio/adc/vf610_adc.c#L556

ouch.  Whilst that's an ancient driver, its unfortunately handling the buffer
completely wrongly :(  It's old enough that I suspect there will be no interest
in improving that one.

> 
> >
> > ouch, not a write 1 to clear register?  I can't find docs, but this is really
> > nasty bit of interface design if you have to toggle the bit.
> >  
> Actually ST has not provided a register map or any application note
> for the sensor.
> So there's no way to cross reference. Hence I kept the original code.
> But I will try to write 1 to clear register with my sensor.
> 
> > > +             ret = devm_iio_triggered_buffer_setup(&client->dev,
> > > +                                     indio_dev,
> > > +                                     &iio_pollfunc_store_time,  
> >
> > This is odd.  You don't seem to have a function to be called to actually store
> > the data.  Note you also need to consider if other triggers might be used.
> >
> > I'm not sure what reason we have to do that here though as this is a very
> > conventional one interrupt per 'scan' of data device.
> >
> > So you should be registering a trigger, and a buffer then letting the
> > trigger drive the buffer.  
> 
> Why do I need to register a trigger? Would it be fine to let the irq
> fill the buffer
> with data as  it continuously reads it in the poll function?

That is a possibility but it's not nearly as flexible as providing
a trigger so we generally only do that if there is a fifo in the way
so no 'per scan' signal is available.

The model of IIO is that you may associate different triggers
with a device and each trigger can drive capture from multiple devices
allowing reasonable data synchronisation.  There are lots of
devices that don't have a sequencer / 'continuous' mode and we
want the interface to looks the same for those as it does for those
that do have such support.

> 
> So according to my understanding,
> I need to move all the data reading and pushing to the poll function
> and not do it in the irq handler.
> Then register that poll function here during iio_triggered_buffer_setup.
> Is there something that I am missing?

You have it right.

The only other thing is to work out if it is possible to use other
triggers with the device (I can't see why you wouldn't be able to
use this trigger to drive other device).  

Sometimes using other triggers requires a slightly more complex
sequence so you can check if using a devices own trigger or not
and modify what goes on if it is a different trigger.

If multiple trigger support is complex, it is fine to start out
with providing a trigger validation function iio_info->validate_trigger()
and there is an iio_validate_own_trigger() that you can use to
avoid having to code anything. That relies on the iio_trigger
and the iio_device having the same parent (which they should
do here).

Jonathan

> 
> Regards,
> Abhash


