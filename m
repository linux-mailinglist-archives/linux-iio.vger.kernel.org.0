Return-Path: <linux-iio+bounces-8837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A2962328
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFA41F2146D
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C8515AACA;
	Wed, 28 Aug 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhxSWHcj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791A1586DB
	for <linux-iio@vger.kernel.org>; Wed, 28 Aug 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836538; cv=none; b=MNG8xvIehyb4sfodLJo/+DVSAMkKBInQ6HdNsvRC39a5f+Bq+wxR6HWODlVRoyoqqgnXjmwDGQmWu4ScXv29kXATH0fFyyDDSdBNYjXTAagrO0DIFv73QgO+/G3m+ZIzNkVWFe5Mpictr7UxsHKlxsHtN2Rj6oa9W9NSc0M18Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836538; c=relaxed/simple;
	bh=xMuenIOm4B2w0JqPnhD+pHJMJJxjxDPS6ls/BS2A7zE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ruk5ssDdfQ+DliRzKqs7cZ/M/n+vQFcZNpbrNOh1pagxOZVsx9wIMwlCLmaYGHr+oDIcZVuUc0D1PS23rghocIQXUsSPne3Y+vSrXADixb6p25n7qfayE3obKlY/Ppguk2SaOUGfxS0HbQrhsTQ58xFm//iho6Z9gti5LM8LQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhxSWHcj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f5064816edso41778801fa.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Aug 2024 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724836535; x=1725441335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xMuenIOm4B2w0JqPnhD+pHJMJJxjxDPS6ls/BS2A7zE=;
        b=MhxSWHcjoIXvSxVlnXU63IIouCkytX7ByDshYFN7eeuuAYwwFtz01bGGnt8udwRR7D
         ZgFIu7Zf58x7gTuVLma6pgjyZ0bS0QgzrBe7dt46dWCFT19wW6XIM+/F8muQwIuVKYlO
         YX3BLpoRFEkr9NQynu+ZF7ONCjcu9/Y5eh/CWOTG9sRzA8h1XoMUMPElAeTSv0kB+lLa
         wEQDQhCUXawi7EzTo6O+YoRqZ6Zf3cW1Nm+lS5+PtfjoiJQVkRU5mR5YAZDZitDQsd4s
         JpOq/lEzXXLSZXqe0CPiB8lHUXdwDu9CvlYziGkaPLHC+iGfWTykphOoHKDzCnW03Wrq
         RyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724836535; x=1725441335;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMuenIOm4B2w0JqPnhD+pHJMJJxjxDPS6ls/BS2A7zE=;
        b=gbdzKfm1AUKYjzOTNUfDFs60ZNAcmZBC+UHhgKX82E6Zt7BFb7Kosqgxgv/lwKJIiT
         JgUOrn4fAkT6MnpDVviiujywbEppNQ/N3zMwm15rDdz+dzPTpwsid21Tpq/vDK2AJuYT
         vR7aAGxL3WL9VCyqfNtFyEgHGoAjTnWALuThQ5U4J+cQDMDV6PbG3y+c9Rjl8gN02+sF
         WI6EbDkyxqY/bIXsTN2DQIBPnLCXj/GIIT5Ta458oXSOYJLkmZLu0IR7jgzeho83kSHQ
         f1nrFbPwq3MQTB7TPpmdWNyfyI9jcZiOKTsP5E+qbdJ3IFs1ySIVGJ/6DjOqYMBtry51
         oG9g==
X-Gm-Message-State: AOJu0Yx1e6/ccI/wNn0ZUs2mZavD/uhTvUyLsVtwp/dwml/geGRCdrEz
	BQZFrLFqJ0l70ddPeio6Bk39xwskA+UQ+ZvBIFACC1vfqjdM/vNutOZTM8zN
X-Google-Smtp-Source: AGHT+IEdTi9MO54BFk5rGKDoYocU6NEH8vVBizyM6CoZ9kUuvW5INR6ikGR8Am8FGaml5gOX43IPNA==
X-Received: by 2002:a05:651c:1545:b0:2f4:50c:ab55 with SMTP id 38308e7fff4ca-2f55b68e37amr10086311fa.16.1724836534385;
        Wed, 28 Aug 2024 02:15:34 -0700 (PDT)
Received: from [192.168.2.180] ([78.187.133.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1e259dsm1980612a12.22.2024.08.28.02.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:15:33 -0700 (PDT)
Message-ID: <f181754981c3130d24a89b271afbf7daaaece4a6.camel@gmail.com>
Subject: Re: iio: trigger: Software Resend of Triggers
From: Ibrahim Bagriyanik <ibrahim.bagriyanikb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Date: Wed, 28 Aug 2024 12:15:32 +0300
In-Reply-To: <20240826122946.2d57911c@jic23-huawei>
References: <20240824190544.5705-1-ibrahim.bagriyanikb@gmail.com>
	 <20240826122946.2d57911c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-26 at 12:29 +0100, Jonathan Cameron wrote:
> > Is there a similar mechanism within IIO, or how do others typically
> > address this problem on slower processors? If there isn't, would
> > implementing such a feature in IIO make sense? I tackled this by
> > simply not using IIO triggers, and only thing I thought to make use
> > of was simply blocking poll calls with synchronization primitives
> > until the former trigger finishes. I would appreciate your thoughts
> > and suggestions.
>=20
> Roughly speaking combination of using level interrupts for
> the hardware irq (so we can come around later if the interrupt
> won't refire on next sample) and being careful with the sequencing
> in the driver.=C2=A0 Also IRQF_ONESHOT typically for the trigger
> to ensure interrupt is only enabled when threads are done
> (so if the level is still true, you immediately retrigger).
> In some more fiddly cases it may be necessary to disable the
> interrupt
> whilst doing handling but that is very rare and usually
> because the device does something bad with the interrupt
> line during data read out.
>=20
> Good to have some more details of how you have tied everything
> together.=20
>=20
> For the trigger, is it using a threaded interrupt, or calling
> iio_trigger_poll() from the non threaded part?

I used a threaded_irq and polled in the threaded part. For me, to use
iio_trigger_generic_data_rdy_poll did not work somehow, neither in irq
nor in threaded_irq. I use 'iio_trigger_poll_chained/nested' for
polling although I have a single consumer. I do the things just like
MAX11410's driver. Using threaded irq but not using hard part, using
trigger but not using top half too. And polling chained/nested.
Whatever I have tried besides of it, it just did not work. Maybe I
couldn't get it done.=C2=A0

I am doing it just how MAX11410's driver does it. But still, I do not
think this scenario will work out if HARDIRQS_SW_RESEND is not set in
case of a device using edge interrupt and does not automatically resets
its drdyout:
https://elixir.bootlin.com/linux/v6.10.6/source/drivers/iio/adc/max11410.c

I got back to device and tried level interrupts. Apparently, last time
I tried I messed things up and blamed level interrupts and has not
tried to use them again. Now I see I was mistaken because it works
great now. Thanks for the advice.

> So I'm assuming you are using the device drdyout as the indicator
> of data.=C2=A0 Are you treating that as an edge interrupt? If so
> you will run into lots of pain. It's a long time since it was
> common to get interrupt controllers that couldn't do level
> interrupts.
> I suspect you want to treat it as a level interrupt with
> IRQF_ONESHOT set to indicate that the interrupt should
> not be reenabled until the thread is done. That thread
> should only be done after all consumers of the trigger
> have completed.=20

Isn't what some portion of IIO devices in kernel do? For example,
ADXL355, calls 'iio_trigger_poll' in hard interrupt context, and it
still works charmingly. It has edge interrupts in YAML documentation.
Maybe I should ask it's maintainers.

Overall, my problems caused by not lack of features, but my lack of
knowledge. Thanks for taking time to answer Jonathan. Also sorry for
bad formatting of my former email. It was my first plain-text email to
kernel.

Best, Ibrahim.

