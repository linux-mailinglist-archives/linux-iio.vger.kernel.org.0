Return-Path: <linux-iio+bounces-2514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508FA8534E1
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 16:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CC91C22C03
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9B5EE95;
	Tue, 13 Feb 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yn2JXERZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE65DF3E
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838726; cv=none; b=bwZ3FP3t7HVAQ2NUUjQmY5L8xtKa/5rkdqH5tdWBBgoMmv8+amS3MrPoDbIUV7wfhOz+ESaBGJvfcTkq83TzMaqnydt4t1yljwkEqnf+b8SAcQOJDZdoN1FP7GzlaSf2K16Nulu4dHXP3fgdlSEPgHJtqfXR7T/yR9QexGtLW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838726; c=relaxed/simple;
	bh=86g7mBZ1gyLVRqn1fSL+c/aLee+p5rQTwH1MAWDglwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHI3Vl8tUsZKWqqlIZ8x1eIIpsGCITd+48ddQ2X2IgBtwbURc7QON4BSbM/zUwEibMFChV/O0ipUXepb51BHTE7q9HV6v+SJ551dzAjyxvpJWiPI1y+vIU6WhDexobp2UEMBk63gY6QG5WrtUvlih2r4IDkMszxzTF7ZfEGjqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yn2JXERZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51197ca63f5so1259845e87.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707838721; x=1708443521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHkkMXmQ+H2Scqr8RK34SiIt/9/bIcE8B6ImB3kNnh8=;
        b=yn2JXERZkPREEX1Lto5RggIokxlrBVKyvXUwicAX6P9QYJaHkUv6l0/ECRnRFDh4Ud
         ggEW2Ba6G+7bAZBX2XD6JhvsQDPgDFkMvosOKVgaPzSWTPm/5kMeJgaCpqyPg7i9cMJW
         ZXK9amRZcVqtYg47kljv3QYqI2lO+SFfEkNRKUjFiT2nffCSA9LjRvAbnPHiyCdF9CiF
         vngpKUHv6wiXMP10an3xOeqo8JL0o/lD8G78mQIaX/D59hsZRhGf42ukCDs+VBBqtyIX
         20gyH37rq7G+MP1YjkjpnXm/Vi8d9GImO0NQTJKVFWbCDoiTVSHIX0AiHilbmSc3AVE8
         KXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838721; x=1708443521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHkkMXmQ+H2Scqr8RK34SiIt/9/bIcE8B6ImB3kNnh8=;
        b=QG+OeZ4mTpBXnoCWaDj6FGZrOTHHS1jSeSk/FW9FVWoUqmWr/5mOpKWqpmULtH/Rr5
         IVYjJUd7nojaJcVZUStWDlshsj6IEoATOeGeIF/134pkDhxguaA2jjO5esUcMr0fR26Z
         gWtTD9QtEqLSH7tfUnyAHAvRJUg+a1cZ6ooju4ww1VJLe/reH3kV0+dIgZZZZKqOV3dm
         tXQYlhXgyAva9sYkyaMlTsh/r0W68IXAKf6k93C4u0MCM+eRzdtvO1B32VUqjUad2yzn
         Qrx76+u4QmUK+mYhXPjRBxFa0AvZWM7MilJNzMVhTkrR61brg1EsjG1RxUwIBrfWLZ0h
         msPw==
X-Gm-Message-State: AOJu0YyFDnEOROzh1wsKBauv1aUim/JpIbydkNKEECVYuGxULdn20kbR
	EcjLX11tVJlvoSLxZcWD8aa3zTVaeV1a53ywWHcS9/AhNsRkCs7zAqzbgtfoFd+dpKuvI1Nmu/H
	XoZ+j6a6GC1PTtn7/kbHIiMKlgULmDoShHsIW9A==
X-Google-Smtp-Source: AGHT+IFAle/yy9BICJuoa3itjlHG3HEsxLtFw1BtVgebHN5Q0blSJ7U5zwbbrEpHq5YEC4WKPsTMWQsaG7SfytLbcx8=
X-Received: by 2002:a05:651c:1059:b0:2d0:e45c:5650 with SMTP id
 x25-20020a05651c105900b002d0e45c5650mr18656ljm.11.1707838720936; Tue, 13 Feb
 2024 07:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com> <92e7e0acf6d8746a07729924982acbfea777c468.camel@gmail.com>
In-Reply-To: <92e7e0acf6d8746a07729924982acbfea777c468.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Feb 2024 09:38:29 -0600
Message-ID: <CAMknhBG0LY+xiaK6qXcRj5_UAnTUAk0h36qO1qYWYR-MN5ajzA@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>, 
	David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:50=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote:
> > This adds a new spi_optimize_message() function that can be used to
> > optimize SPI messages that are used more than once. Peripheral drivers
> > that use the same message multiple times can use this API to perform SP=
I
> > message validation and controller-specific optimizations once and then
> > reuse the message while avoiding the overhead of revalidating the
> > message on each spi_(a)sync() call.
> >
> > Internally, the SPI core will also call this function for each message
> > if the peripheral driver did not explicitly call it. This is done to so
> > that controller drivers don't have to have multiple code paths for
> > optimized and non-optimized messages.
> >
> > A hook is provided for controller drivers to perform controller-specifi=
c
> > optimizations.
> >
> > Suggested-by: Martin Sperl <kernel@martin.sperl.org>
> > Link:
> > https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@=
martin.sperl.org/
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/spi/spi.c       | 145 ++++++++++++++++++++++++++++++++++++++++=
++++++-
> > -
> >  include/linux/spi/spi.h |  19 +++++++
> >  2 files changed, 160 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index c2b10e2c75f0..5bac215d7009 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -2106,6 +2106,41 @@ struct spi_message *spi_get_next_queued_message(=
struct
> > spi_controller *ctlr)
> >  }
> >  EXPORT_SYMBOL_GPL(spi_get_next_queued_message);
> >
> > +/**
> > + * __spi_unoptimize_message - shared implementation of
> > spi_unoptimize_message()
> > + *                            and spi_maybe_unoptimize_message()
> > + * @msg: the message to unoptimize
> > + *
> > + * Periperhal drivers should use spi_unoptimize_message() and callers =
inside
> > + * core should use spi_maybe_unoptimize_message() rather than calling =
this
> > + * function directly.
> > + *
> > + * It is not valid to call this on a message that is not currently opt=
imized.
> > + */
> > +static void __spi_unoptimize_message(struct spi_message *msg)
> > +{
> > +     struct spi_controller *ctlr =3D msg->spi->controller;
> > +
> > +     if (ctlr->unoptimize_message)
> > +             ctlr->unoptimize_message(msg);
> > +
> > +     msg->optimized =3D false;
> > +     msg->opt_state =3D NULL;
> > +}
> > +
> > +/**
> > + * spi_maybe_unoptimize_message - unoptimize msg not managed by a peri=
pheral
> > + * @msg: the message to unoptimize
> > + *
> > + * This function is used to unoptimize a message if and only if it was
> > + * optimized by the core (via spi_maybe_optimize_message()).
> > + */
> > +static void spi_maybe_unoptimize_message(struct spi_message *msg)
> > +{
> > +     if (!msg->pre_optimized && msg->optimized)
> > +             __spi_unoptimize_message(msg);
> > +}
> > +
> >  /**
> >   * spi_finalize_current_message() - the current message is complete
> >   * @ctlr: the controller to return the message to
> > @@ -2153,6 +2188,8 @@ void spi_finalize_current_message(struct spi_cont=
roller
> > *ctlr)
> >
> >       mesg->prepared =3D false;
> >
> > +     spi_maybe_unoptimize_message(mesg);
> > +
> >       WRITE_ONCE(ctlr->cur_msg_incomplete, false);
> >       smp_mb(); /* See __spi_pump_transfer_message()... */
> >       if (READ_ONCE(ctlr->cur_msg_need_completion))
> > @@ -4194,6 +4231,99 @@ static int __spi_validate(struct spi_device *spi=
,
> > struct spi_message *message)
> >       return 0;
> >  }
> >
> > +/**
> > + * __spi_optimize_message - shared implementation for spi_optimize_mes=
sage()
> > + *                          and spi_maybe_optimize_message()
> > + * @spi: the device that will be used for the message
> > + * @msg: the message to optimize
> > + * @pre_optimized: whether the message is considered pre-optimized or =
not
> > + *
> > + * Peripheral drivers will call spi_optimize_message() and the spi cor=
e will
> > + * call spi_maybe_optimize_message() instead of calling this directly.
> > + *
> > + * It is not valid to call this on a message that has already been opt=
imized.
> > + *
> > + * Return: zero on success, else a negative error code
> > + */
> > +static int __spi_optimize_message(struct spi_device *spi,
> > +                               struct spi_message *msg,
> > +                               bool pre_optimized)
> > +{
> > +     struct spi_controller *ctlr =3D spi->controller;
> > +     int ret;
> > +
> > +     ret =3D __spi_validate(spi, msg);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (ctlr->optimize_message) {
> > +             ret =3D ctlr->optimize_message(msg);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Not really sure what are the spi core guarantees or what controllers shou=
ld be
> expecting but I'll still ask :). Do we need to care about locking in here=
?
> Mainly on the controller callback? For spi device related data I guess it=
's up
> to the peripheral driver not to do anything weird or to properly protect =
the spi
> message?
>

Currently, it is expected that this operates only on the message
struct and doesn't poke any hardware so no locking is currently
required. And, yes, it is up to peripheral drivers that opt in to
pre-optimization to follow the rules of not touching the message while
it is in the optimized state. For peripheral drivers that don't call
spi_optimized_message(), nothing has really changed.

