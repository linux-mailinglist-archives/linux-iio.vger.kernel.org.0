Return-Path: <linux-iio+bounces-23728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C7B44C3F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 05:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA4FA47081
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602422441A6;
	Fri,  5 Sep 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhLMFc35"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D992EEBD;
	Fri,  5 Sep 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042765; cv=none; b=Fw/TERSC1y1Mu+a/m8PI5vcycRIgfVbwfQ2CXjMMMVJJYtu1PLXChh6RYAB2fFXwJJnkkPTFjZidDJR+3Emjreq5l8hc7ePkd8Ik1Lq5g32Q0hzNIK6XRhSMy5cz6rnfFxhzxiGMJgkF3Gkhs8+5vZbXpm2he7HhYcZVP8fhzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042765; c=relaxed/simple;
	bh=vt85HB5HOKLb5brvjST25VFftyujIsGjUdImucIiq/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsTDS0nNHhBKZsXaZvBVSUS9VRAQEFkz4OOmqlxHVw7OWaXrKL6YIl5lt8fQh6lJwo5yAjjl7L5qXn6Oz6HsF+Jn3A2bR4rJ51uGWBPJQ0MveiSBa99Qnf2866/zHAx19hmYEc3s6jMpAhSRHpdWq0dPNrFbWZPhSU3v8d9Stbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhLMFc35; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f716e25d9so1676272e87.1;
        Thu, 04 Sep 2025 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757042761; x=1757647561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4wkxgqQYmgvfMw5VZu3mV4oIOirEoA3LG2XgF4vwYA=;
        b=OhLMFc35J0hLmrvLGYDLO18nQYXxcapdG5ZMe1QnLIREcXINUsV4mxzK5kVNffdKTn
         Nz5wH4fxSqmqsGHql2mxkOF3Zv+h3zKS8+SeqOUsMUGtCAhf+UTTjm3MiU/J06W2CUkI
         vuSGHDH2YiYvxTIjHVjE9w29P0ZHv5py20oZE4Nr1x4VgJMnWT8Rp2oJoBvmmp5dbROl
         tpkN1+hm0goMXPqNbRn5aKRaj82WsAKjHSYXuTOyAtV3g1NcpSLay/Arl3peylovLwwd
         RNOK3LQhF159Na6LjfeqiKWNZAhzcjP1MQxWhseyTYMUsXoj0tkeL/QJsGqtm27jnbDl
         +nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757042761; x=1757647561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4wkxgqQYmgvfMw5VZu3mV4oIOirEoA3LG2XgF4vwYA=;
        b=SYZQFpdNdzEUShwrTaVBaR9KK5y8gZrOYI5ZSkxtAQqjwMQismlsf04xOhEJUtA+rK
         kdEMPNDb+Ih+qRYI9uA1iqhZAz0bKKYRrCetYCkXzXWUq8BDFJJckl8xvgJzxl0YfrXq
         4StWFeVFt3uVsg68FPONy+6d41/x1I3YsSBjrE3osCom543TxodkU/ZilTcgj8nSP0Wr
         F2Jtm+llBXsUCSr0fKv6o+51L7RL5gm/lOm5P7bCm0E03Fouu775UOq/HD6uMFYTBCVf
         DO2EbQfRHQ/hZ/geZOa2Ofdnq+zV3IDITW68QpPSfEnS4NGUJUgSJGvkd13BlBBvoSLv
         wX9g==
X-Forwarded-Encrypted: i=1; AJvYcCWc6tpSjdnhus94BWObGSf5dmX2S7HP8hUUMU5FV4I4jW96zS4e3DdO1ASuCvJWqpclZZqW+t1mjLU=@vger.kernel.org, AJvYcCXLusRihyoqTdRi3/BtfqlK97UKwk6V+9tO9djUg0iohxqQp8ssZM4z6LIIkNdZzQZWQktaqH2ledk8/c3O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz712vB7f1GKgn9F3VIYfwV5q5DrQudM2liq7P8UhmF1ClYC/6g
	pCYlTZTiRPh4hk+NhMv4kmLBAnM4YypBlYaFuJnbnIPMgUtJB4QfdcBGzGq9UZS7uGnW2j8bV2S
	2gftZ0ptGnGSaxNR2SQLTnlI13xmf/lE=
X-Gm-Gg: ASbGncuTg6/y1d3iz7DKOwboBMbuG4QIF8w/Ak3KLisIIT6ak5gx2TeAuKx2KqlrYLC
	Z8hbKfppLf7eiOsGR8jKciUx2SSl68bJAzeSUK0UWtKPZ28SJ7x6d8Nf0A/v0BLtt0p5x6oZj/n
	WS1HGZDetJdMqxHZDRoxeCErB1IyBBFBjBEG1pGHol11qvTnTmK77OnsHaUX7D4eRr2shef+RrJ
	9TxPLkPMu3xVkCfzF51TpX1l655KJjzJ2dz2BxikA==
X-Google-Smtp-Source: AGHT+IFo8Oswbo6HyJs+N/eoDMVpsfmONhmHT2Cjzmhf6nWe++vf7UESCaxvj0kWCiGiHyM74dK6HHGy6LIi3+MFTLs=
X-Received: by 2002:a05:651c:23c2:20b0:337:e975:e81 with SMTP id
 38308e7fff4ca-337e9751054mr36111951fa.9.1757042761093; Thu, 04 Sep 2025
 20:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903112648.11972-1-akshayaj.lkd@gmail.com> <aLlHRYPC-bPLQe-N@smile.fi.intel.com>
In-Reply-To: <aLlHRYPC-bPLQe-N@smile.fi.intel.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Fri, 5 Sep 2025 08:55:48 +0530
X-Gm-Features: Ac12FXxAe4pFQLn-tutsiJDR8voTRBGK0NpKi7qBMJLKXyWVt2bATv39qWGq6mY
Message-ID: <CAE3SzaRiG9xv+DjfjMQtSEs6xdM90C3K2x2z3s5UNsm9Mn9tuQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Sep 03, 2025 at 04:56:43PM +0530, Akshay Jindal wrote:
> > Implement runtime power management for the LTR390 sensor. The device
> > autosuspends after 1s of idle time, reducing current consumption from
> > 100 =E6=B8=99 in active mode to 1 =E6=B8=99 in standby mode as per the =
datasheet.
> >
> > Ensure that interrupts continue to be delivered with runtime PM.
> > Since the LTR390 cannot be used as a wakeup source during runtime
> > suspend, therefore increment the runtime PM refcount when enabling
> > events and decrement it when disabling events or powering down.
> > This prevents event loss while still allowing power savings when IRQs
> > are unused.
>
> ...
>
> > -static int ltr390_read_raw(struct iio_dev *iio_device,
> > -                        struct iio_chan_spec const *chan, int *val,
> > -                        int *val2, long mask)
> > +
> > +static int ltr390_do_read_raw(struct iio_dev *iio_device,
> > +                     struct iio_chan_spec const *chan, int *val,
> > +                     int *val2, long mask)
>
> The new indentation is broken.
Will fix.
>
> static int ltr390_do_read_raw(struct iio_dev *iio_device,
>                               struct iio_chan_spec const *chan,
>                               int *val, int *val2, long mask)

> > -static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > +static int ltr390_do_event_config(struct iio_dev *indio_dev,
> >                               const struct iio_chan_spec *chan,
> >                               enum iio_event_type type,
> >                               enum iio_event_direction dir,
>
> You forgot fixing an indentation of the parameters.
Will fix.

> > +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > +                             const struct iio_chan_spec *chan,
> > +                             enum iio_event_type type,
> > +                             enum iio_event_direction dir,
> > +                             bool state)
>
> Broken indentation.
Will fix.
>
> ...
>
> > +     ret =3D devm_pm_runtime_set_active_enabled(dev);
> > +     if (ret)
>
> > +             return dev_err_probe(dev, ret,
> > +                                  "failed to enable runtime PM\n");
>
> It's exactly one line of 80 characters!
Will make it 1 line.
>
> ...
>
> > +     /* default value of irq_enabled is false*/
>
> Missing space
>
Will fix.

Hi Andy, thank you for the review. Will fix the parametric indentations
in all the places.

Will you be able to take another look in case there is more feedback?
Would love to include them as well in v6.

Thanks,
Akshay

