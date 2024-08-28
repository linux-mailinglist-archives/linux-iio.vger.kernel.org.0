Return-Path: <linux-iio+bounces-8841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF1962893
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 15:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D3528239E
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B081185E6A;
	Wed, 28 Aug 2024 13:26:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B02181328
	for <linux-iio@vger.kernel.org>; Wed, 28 Aug 2024 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851587; cv=none; b=E0Nvc1H1ZIaeUvDnv7HZLmBFYkW4sDxJIGqRVt4K1Rf7foXwjhrhxCK+BgOEBXEx8XcHb00KxHiKdi8NveGw4+EOkGrCvSsC5R/iqW164o/VT4w8NsZXFRyU8rmzzeO05rT3IJeIPra0cC86z7m2ECEVayXZkqBy4it2nA7JO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851587; c=relaxed/simple;
	bh=8RHQvoqCw1z2FzcwJDs42+qq80qjJ1pyszR1Q2sBpFI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQlSOQy9Yr4oDlHenWydbONeTOaQ0Jbq0WRf+PawFb2wo3OJv+oXeTHU7S723EK4Eod6J1KpgLyQBDLa2DOTF6diYoaos/Wj32+m4AOHSjLpA6A+fKP+eMaADimV2TvblcsUZHwTCZhudv2LDBZhIxReu2xhr2JIi+hKkOqauUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv4pt3jVXz6K5vW;
	Wed, 28 Aug 2024 21:23:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C0E61140CB1;
	Wed, 28 Aug 2024 21:26:20 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:26:20 +0100
Date: Wed, 28 Aug 2024 14:26:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ibrahim Bagriyanik <ibrahim.bagriyanikb@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: iio: trigger: Software Resend of Triggers
Message-ID: <20240828142619.00007358@Huawei.com>
In-Reply-To: <f181754981c3130d24a89b271afbf7daaaece4a6.camel@gmail.com>
References: <20240824190544.5705-1-ibrahim.bagriyanikb@gmail.com>
	<20240826122946.2d57911c@jic23-huawei>
	<f181754981c3130d24a89b271afbf7daaaece4a6.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 12:15:32 +0300
Ibrahim Bagriyanik <ibrahim.bagriyanikb@gmail.com> wrote:

> On Mon, 2024-08-26 at 12:29 +0100, Jonathan Cameron wrote:
> > > Is there a similar mechanism within IIO, or how do others typically
> > > address this problem on slower processors? If there isn't, would
> > > implementing such a feature in IIO make sense? I tackled this by
> > > simply not using IIO triggers, and only thing I thought to make use
> > > of was simply blocking poll calls with synchronization primitives
> > > until the former trigger finishes. I would appreciate your thoughts
> > > and suggestions. =20
> >=20
> > Roughly speaking combination of using level interrupts for
> > the hardware irq (so we can come around later if the interrupt
> > won't refire on next sample) and being careful with the sequencing
> > in the driver.=A0 Also IRQF_ONESHOT typically for the trigger
> > to ensure interrupt is only enabled when threads are done
> > (so if the level is still true, you immediately retrigger).
> > In some more fiddly cases it may be necessary to disable the
> > interrupt
> > whilst doing handling but that is very rare and usually
> > because the device does something bad with the interrupt
> > line during data read out.
> >=20
> > Good to have some more details of how you have tied everything
> > together.=20
> >=20
> > For the trigger, is it using a threaded interrupt, or calling
> > iio_trigger_poll() from the non threaded part? =20
>=20
> I used a threaded_irq and polled in the threaded part. For me, to use
> iio_trigger_generic_data_rdy_poll did not work somehow, neither in irq
> nor in threaded_irq. I use 'iio_trigger_poll_chained/nested' for
> polling although I have a single consumer. I do the things just like
> MAX11410's driver. Using threaded irq but not using hard part, using
> trigger but not using top half too. And polling chained/nested.
> Whatever I have tried besides of it, it just did not work. Maybe I
> couldn't get it done.=A0
>=20
> I am doing it just how MAX11410's driver does it. But still, I do not
> think this scenario will work out if HARDIRQS_SW_RESEND is not set in
> case of a device using edge interrupt and does not automatically resets
> its drdyout:
> https://elixir.bootlin.com/linux/v6.10.6/source/drivers/iio/adc/max11410.c

That does look problematic and HARDIRQS_SW_RESEND is not a valid fix
as it's a workaround for an interrupt controller issue as I understand it.

>=20
> I got back to device and tried level interrupts. Apparently, last time
> I tried I messed things up and blamed level interrupts and has not
> tried to use them again. Now I see I was mistaken because it works
> great now. Thanks for the advice.

No problem.  I remember a lot of pain I had years ago with
an interrupt controller that only supported edge interrupts.
I tried for a long time to get a device that produced level interrupts
(like yours) to work reliably and never managed to reliably close
the race :(  Even had some discussions at the time about whether
we could add something generic to Linux for that case but it is really
tricky to get right so it never happened.

>=20
> > So I'm assuming you are using the device drdyout as the indicator
> > of data.=A0 Are you treating that as an edge interrupt? If so
> > you will run into lots of pain. It's a long time since it was
> > common to get interrupt controllers that couldn't do level
> > interrupts.
> > I suspect you want to treat it as a level interrupt with
> > IRQF_ONESHOT set to indicate that the interrupt should
> > not be reenabled until the thread is done. That thread
> > should only be done after all consumers of the trigger
> > have completed.  =20
>=20
> Isn't what some portion of IIO devices in kernel do? For example,
> ADXL355, calls 'iio_trigger_poll' in hard interrupt context, and it
> still works charmingly. It has edge interrupts in YAML documentation.
> Maybe I should ask it's maintainers.

That device has an 'autoclear' function that means that if we miss
an interrupt it will just send one on the next reading.

>=20
> Overall, my problems caused by not lack of features, but my lack of
> knowledge. Thanks for taking time to answer Jonathan. Also sorry for
> bad formatting of my former email. It was my first plain-text email to
> kernel.

No problem.

Good luck and I hope you send your code upstream when you are ready!

Jonathan

>=20
> Best, Ibrahim.
>=20


