Return-Path: <linux-iio+bounces-26544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC86C9288E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39091342B82
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9493314D4;
	Fri, 28 Nov 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iordjL9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F9331230
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346019; cv=none; b=BDcNf351aXLm1GagU8WTl0uar7GBs4brIEfd3oxEaG4VQc5Lm808HnrMU0YlMnH9FTYnb3bBpIiaz9Zd24dHJ7Z1MY01H6GM29M/jonEua50cGg0r0mevyYRUrYNWjG9fz/lYXurml7Dw9vb5H9e0gguBUId+JenB7ZcAS0Bc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346019; c=relaxed/simple;
	bh=+XNRveZYx4pZqARFqxEgHOejSyZET7D2UZAv8GTCH6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE5bK0LDfNBW/AqDvd8lJWBF1ZXQvE+pqM/AD0dqavoZYs+qjnnU05zx4+fFQpnGD/RlHeAhUCidZ/EeiOoHmWGWrR4ZSiNp5GUBjnxvhNalwx/nXTKiul+JSTByAQRAY3ZPuBnV0VKTD7DBs0JyVp2iiS4l1qkryfsLYYy0GTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iordjL9T; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b7370698a8eso104121366b.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764346015; x=1764950815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1o5g0vSaU70RhLYZ7B+DWVUfgzWu3JhrXwtWGhtC4s=;
        b=iordjL9TQmbMDmspiTJe8kvHIuJ9gbrvSMfwa5ECSSQk3uy3/ICGffSqIfrOQ1nFwv
         k4tidFm2U2Gyohdv58HqFrYQTwUvCKeyStTi6rdcGRWWOJCA4ZwrYG9J0T8HxHo+5uRP
         bAKkoM/Dj7TjsrvbYJRg5CVRLEersdEWtYb5PWjxLrfzIq8D3EsxPH6hbvaWa5I51izE
         s+LI5Bv69VqH+wSlVviMiDJpaVDsog9hC896gs+v4nJ9clQs0dVl7aLp5/iWNKjHMh5K
         UN/NgR5o3w0yrTHNc9gPul2glDg/24vy/bcUimlb4iXK76AJzwGJVIScNceywhglrmd0
         ffkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346015; x=1764950815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1o5g0vSaU70RhLYZ7B+DWVUfgzWu3JhrXwtWGhtC4s=;
        b=oJqt/hWvfXXkacromDsgUEg6+KZtJlZhCryBDGXLTdJx7kX/fMzxnXbErhN8zYmNkT
         KPGYxsoWS2pAsX/UJofGlu/FeCaYToD7v1D0rbN4o4vi1gpecoIhpQljEb6oBOHciBfg
         6dj/Fg/ncufJLZyv48s0UHjdZfpHkJauHvixHHH3Lce0hmDd1qPrupHBxyyqAjmS6ETK
         Vs9ZUG628HCDtRweern9SF4S6NUSJc6XYWpk3MnLgwG0fKW7slGGKWSYe+T6Vb2h9Rai
         yUI/i9Z0MsvNspqfeFBMgPp2WkmNsWX4ae+ugv70kxJVwPl/t+P40W1zJH+44I8NvD93
         cDLg==
X-Forwarded-Encrypted: i=1; AJvYcCXMJrcBnUXIjkXm9zm+N0A27maZ0ARJ1q3b0s9mBI0baRl1/w3vlcXM72LvCl/C507xGKCdr5DvWzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH29I1zIbxyoJRcP/5Hv3ECwRVExDNaP1Z+tY/XV7NvHbuo+ZY
	eylrCuB+2vHQp42XwsAIhQB/rjXocju75UXLkmFkut3ueZ8sdY5cVARzVS8V7F/qXMJDfTlnsKO
	KUdmuJgRQoDMGr8NX8cnu7lRO76KzUYM=
X-Gm-Gg: ASbGnct3w2QFlpezzW/XwvCLsD4gYuvdvV7BwgpyFZnQlmd6Jh4z6op4/xGD98MQLf7
	8HU0xVyzvtLL5G1SIpho3aKqtTnl0/iG0XREuhDrZUPeLLSewVXZvaPePydsZvsIWiQ1edi/2aR
	evMPZ5n10pm3ilFEd35OoSjg8kV63R+QVpzZf+jgT9q8pOPNyU05L+W72GtILD53Qj/l7tPApIb
	jOzHVp1pqidySeY4rD3bWaI+eCliHpnETYuZ5Ijcwede70hLjR7GMONeZSxpdwJcjhWlyE=
X-Google-Smtp-Source: AGHT+IEI3VNRff9VO8vTEBTDo7uxAU6C/mVJQbEpPfMkIuxLxn5S+pBTLhRAl9UY8ROCPgC7OMHcg/CFRwSQL6LemvM=
X-Received: by 2002:a17:907:cd0e:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b76718aab40mr3181044566b.52.1764346014938; Fri, 28 Nov 2025
 08:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
 <20251126031440.30065-4-raskar.shree97@gmail.com> <aSatqG9UEqkH0Glw@smile.fi.intel.com>
In-Reply-To: <aSatqG9UEqkH0Glw@smile.fi.intel.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Fri, 28 Nov 2025 21:36:43 +0530
X-Gm-Features: AWmQ_bkxfyjnjo5lTo92Q2QQmKRO2D0ZMmxnBP8Ut477GZINSUCiiqSyaBdQDOA
Message-ID: <CAHc1_P5pgBGiHpyNBGMf8yDKZttVG0XoC0Bb5mWCeGyKbc6q7Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: proximity: rfd77402: Add interrupt handling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de, 
	neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Nov 26, 2025 at 08:44:40AM +0530, Shrikant Raskar wrote:
> > Add interrupt handling support to enable event-driven data acquisition
> > instead of continuous polling. This improves responsiveness, reduces
> > CPU overhead, and supports low-power operation by allowing the system
> > to remain idle until an interrupt occurs.
>
> ...
>
> >  #include <linux/module.h>
> >  #include <linux/i2c.h>
> >  #include <linux/delay.h>
> > -
>
> Stray removal of blank line.
>
> > +#include <linux/interrupt.h>
> > +#include <linux/completion.h>
>
> > +#include <linux/of.h>
>
> Please, avoid using of.h in a new code.
>
> >  #include <linux/iio/iio.h>
>
> ...
>
> > +static irqreturn_t rfd77402_interrupt_handler(int irq, void *dev_id)
> > +{
> > +     struct rfd77402_data *data =3D dev_id;
> > +     int ret;
>
> > +     /* Check if the interrupt is from our device */
>
> This comment only for the second part and I would split the condition to =
make
> it clearer.
>
> > +     ret =3D i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
> > +     if (ret < 0 || !(ret & RFD77402_ICSR_RESULT))
> > +             return IRQ_NONE;
>
>         ret =3D i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
>         if (ret < 0)
>                 return IRQ_NONE;
>
>         /* Check if the interrupt is from our device */
>         if (!(ret & RFD77402_ICSR_RESULT))
>                 return IRQ_NONE;
>
> > +     /* Signal completion of measurement */
> > +     complete(&data->completion);
> > +     return IRQ_HANDLED;
> > +}
>
> ...
>
> > -     while (tries-- > 0) {
> > -             ret =3D i2c_smbus_read_byte_data(client, RFD77402_ICSR);
> > -             if (ret < 0)
> > +     if (data->irq_en) {
> > +             /* Wait for interrupt-driven completion */
> > +             ret =3D wait_for_completion_timeout(&data->completion,
> > +                                               msecs_to_jiffies(200));
> > +             if (ret =3D=3D 0) {
> > +                     ret =3D -ETIMEDOUT;
> >                       goto err;
> > -             if (ret & RFD77402_ICSR_RESULT)
> > -                     break;
> > -             msleep(20);
> > -     }
> > -
> > -     if (tries < 0) {
> > -             ret =3D -ETIMEDOUT;
> > -             goto err;
> > +             }
> > +     } else {
> > +             /* Fallback to polling mode */
> > +             while (tries-- > 0) {
> > +                     ret =3D i2c_smbus_read_byte_data(client, RFD77402=
_ICSR);
> > +                     if (ret < 0)
> > +                             goto err;
> > +                     if (ret & RFD77402_ICSR_RESULT)
> > +                             break;
> > +                     msleep(20);
> > +             }
> > +
> > +             if (tries < 0) {
> > +                     ret =3D -ETIMEDOUT;
> > +                     goto err;
> > +             }
> >       }
>
> Instead, move the current code into a helper (in a separate patch) and al=
ter it
> here with new conditional. So in the result it will be something like
>
>         if (...)
>                 ret =3D call_new_helper_for_irq();
>         else
>                 ret =3D call_old_helper_for_polling();
>
> ...
>
> > +     if (data->irq_en) {
> > +             /* Configure ICSR: auto-clear on read, push-pull, falling=
 edge */
> > +             ret =3D i2c_smbus_write_byte_data(client, RFD77402_ICSR,
> > +                                             RFD77402_ICSR_CLR_CFG |
> > +                                             RFD77402_ICSR_INT_MODE);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             /* Enable 'new data available' interrupt in IER */
> > +             ret =3D i2c_smbus_write_byte_data(client, RFD77402_IER,
> > +                                             RFD77402_IER_RESULT);
> > +             if (ret < 0)
> > +                     return ret;
> > +     } else {
> > +             /* Disable interrupts */
> > +             ret =3D i2c_smbus_write_byte_data(client, RFD77402_ICSR, =
0);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D i2c_smbus_write_byte_data(client, RFD77402_IER, 0=
);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
>
> This can be also factored out to a helper(s). Something like this, perhap=
s
>
>         if (irq_en)
>                 ret =3D call_a_helper(client, $CSR, $ER);
>         else
>                 ret =3D call_a_helper(client, 0, 0);
>
> ...
>
> > +     /* Check if interrupt is mentioned in device tree */
> > +     data->irq_en =3D false;
> > +     if (client->irq > 0) {
> > +             ret =3D devm_request_threaded_irq(&client->dev, client->i=
rq,
> > +                                             NULL, rfd77402_interrupt_=
handler,
> > +                                             IRQF_TRIGGER_FALLING | IR=
QF_ONESHOT,
> > +                                             "rfd77402", data);
> > +             if (ret =3D=3D 0) {
> > +                     data->irq_en =3D true;
> > +                     dev_info(&client->dev, "Using interrupt mode\n");
> > +             } else {
> > +                     dev_warn(&client->dev,
> > +                              "Failed to request IRQ %d, using polling=
 mode: %d\n",
> > +                              client->irq, ret);
>
> If we asked for interrupt and didn't get it due to "linux" errors, we sho=
uld
> not fallback. No need to work around bugs in the DT, the DT description m=
ust
> be fixed instead.
>
> > +             }
> > +     } else {
> > +             dev_info(&client->dev, "No interrupt specified, using pol=
ling mode\n");
> > +     }
>
Thank you for the detailed feedback. I will update the code as per
feedback and will share the v2 of the patch.

Regards,
Shrikant

