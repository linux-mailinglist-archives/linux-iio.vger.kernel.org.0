Return-Path: <linux-iio+bounces-26577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD3C952AD
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA034328C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797E8283CA3;
	Sun, 30 Nov 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR9Ui4wU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A42AD0C
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764522158; cv=none; b=bfomRYHIchdCrJO6JRWp9XLbJ3V2U5it8Horp1EEfImWoJL7h3ay97BCU5ki4DWLNSJANPnob+hAddsqTG3K281N3+cqHHdmN0per3XLfdcK0ikKJuvYmbAItjoafz4r7nV6OknxmnRG9goK5V42SlwgBlf/NRRtQt/9blh/DsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764522158; c=relaxed/simple;
	bh=iao0i58WkcUxSobbsPx3tEhso4EIfQ9ZgEjMAw4ofjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6AvKH4v2H2vMeNSBfjo3+Ych2UUaz19J6mjAWnSnK2VNyPMUp2xphk5KztcLIMvkcwihjBZLrhm4JHQikCYihoQqcrS5YQD9EYLl1ICq40pRYwgXSSvoseO4xhX9jssDDqtM7QKZUjEQQOwILIDbjEGEWdOVx+0gNosc20Vvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR9Ui4wU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b735b89501fso423823166b.0
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764522155; x=1765126955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KALx4kdQVf++7KhDqXfXQAUzCUzPZ+kCJiPRrP04uh4=;
        b=OR9Ui4wUkRr7GQVvH6E3eHADQ/IYN28ypsJsr26j6EdX2+D0WJbaJXBI/5PEAKTMs4
         UALmcQptp2p8utrecMwYfGwLY5uVh8jtrfRZ6gd8SLdvlrPfLWAEwMNirFXylaohEtuW
         lOpCSISp5schi4L2Tu0s6DWYItF6pMS+CAqW9tpFwsKZQ+3VJtDPGki7E+I2MecBTWy7
         LBu0e9UIYqY23CR+8RKrymCRgn+2KHWrYvBYGmpGbyAeHcawRPi+TWsCc9U8a0cipT4s
         QBifJydmrzHqbTaIfoT0bOtHN2DNhC1QWkLsTuQ4fssaw3AhE7x2oSXcS4aXJvF5Z9Le
         oHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764522155; x=1765126955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KALx4kdQVf++7KhDqXfXQAUzCUzPZ+kCJiPRrP04uh4=;
        b=qPlBtU9Lz0c9oxUHgjWeH+W/hN/HRSxFGK5ilPbUkuG1n/AX1NIxiixMxlR6sbq2HO
         JgS2TcladOtvL/elw/3sGfgLpflxFTyTHVHtLCaQ/LVNp8GcPQ/LbhnD1GwLSyU6WXoX
         DDpmBJVe+eC2EbAjaPoY6PgzBwegvnrlIWQmZtSdGosfLLirXsN7GNh+BwQM/8zIJnhc
         UspTZICnSDSs9MHMDEn5Zlxx2G4cH2tPeLK7sCo6rlyz3OAktdZwSt1cIca74/jujDLv
         yN8hN8EFSYv8TcbGrmwnS4xVh+qrAmhrOC2ylWW7BxDOr8VsNy1nNdBFFWn0IGoC46fG
         mk4w==
X-Forwarded-Encrypted: i=1; AJvYcCVzDuOp4ITqwF8mdIu2vMhmrUUIgC6KgIHB1puo+7p4uFs1USJhTK5S4F6Ne2UyPRJLqnASfZtW1Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SQJWwBSoR5uoAQz93kJ9d0pfT75URLyvK8ufxzTlWvqtQg3A
	DtkWbafD2XFeZqO0KxwmA7RBX8TME5ltvgYy8Nu4sd/nUcueTy7F9HUEgagUAVtIAnCANW2OhRo
	9x7+/kW2mZ5Ir5oajs/oQGmmtTETbOZI=
X-Gm-Gg: ASbGncu+40gPW7VjRGEYpMUC2LCKb75luRbpApjilhR5SUuJENupfLrKQYRCydex7z6
	eNflI3rXjqwFi99Dd2T7l+K/V5OEkU3cKievVJSoyGnBlHpm227o75QENdb9oeWGzkALwlRQ/IV
	cdeCV1ebZA3mJy28wgtCBdl7GWYbQ0w9ZVxA745N+E+Qx4o9o51OixpUEEs8YICqds4apgEiOTO
	9wGLdzxp/EpPhD88hsfufOx9EZVY87kpquVkH+dfjV5NpXz+AO/muebM39jJAGU6rzaxmEOTN0P
	xb8YhSBunc65t1LA4zfwqY5freNVRToMcPxLgTh1unUQBI6clXVK3odioE+X0zWbgwCSwiLl6AD
	Fj2TLwn99eew463QgsQ==
X-Google-Smtp-Source: AGHT+IHgK7JbnEanR7iM7uxDR0pdXt5nA3668PhIQLD31H2jVAJrikhChWzjE5F6ZF5fkakeXov6pG3pVBpfegB4KUA=
X-Received: by 2002:a17:907:2d94:b0:b73:6534:5984 with SMTP id
 a640c23a62f3a-b76c53c302emr2762952166b.16.1764522154734; Sun, 30 Nov 2025
 09:02:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130153712.6792-1-raskar.shree97@gmail.com> <20251130153712.6792-5-raskar.shree97@gmail.com>
In-Reply-To: <20251130153712.6792-5-raskar.shree97@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 19:01:58 +0200
X-Gm-Features: AWmQ_blGPFK7jPykZ-KK9ztwjRGiNa0Xr6-6U0Fb-Nc5SzbeOft0ULn2F1NgUF8
Message-ID: <CAHp75VdE6LMb=7V1iECwQ_GTyjM+2Ffh_3ifa3dsjpgbPHp1Lw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: proximity: rfd77402: Add interrupt handling support
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de, 
	neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 5:38=E2=80=AFPM Shrikant Raskar
<raskar.shree97@gmail.com> wrote:
>
> Add interrupt handling support to enable event-driven data acquisition
> instead of continuous polling. This improves responsiveness, reduces
> CPU overhead, and supports low-power operation by allowing the system
> to remain idle until an interrupt occurs.

...

>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>

> -

Strat blank line removal.

> +#include <linux/interrupt.h>
> +#include <linux/completion.h>

These should be integrated to the block above the (removed) blank line.

>  #include <linux/iio/iio.h>

...

>         struct i2c_client *client;
>         /* Serialize reads from the sensor */
>         struct mutex lock;
> +       /* Completion for interrupt-driven measurements */
> +       struct completion completion;
> +       /* Flag to indicate if interrupt is available */
> +       bool irq_en;

Instead of commenting each field separately, just convert existing to
a kernel-doc format (can be done in a separate change).

...

> +static int rfd77402_wait_for_irq(struct rfd77402_data *data)
> +{
> +       int ret;
> +
> +       ret =3D wait_for_completion_timeout(&data->completion,
> +                                         msecs_to_jiffies(200));

Perhaps a comment on the chosen value for timeout?

> +       if (ret =3D=3D 0)
> +               return -ETIMEDOUT;
> +
> +       return 0;
> +}

...

> -       ret =3D rfd77402_result_polling(client);
> +       if (data->irq_en)
> +               ret =3D rfd77402_wait_for_irq(data);
> +       else
> +               ret =3D rfd77402_result_polling(data->client);

> +

Stray blank line addition. The check below is tightened to the upper if-els=
e.

>         if (ret < 0)
>                 goto err;

...

> -       /* configure INT pad as push-pull, active low */
> -       ret =3D i2c_smbus_write_byte_data(client, RFD77402_ICSR,
> -                                       RFD77402_ICSR_INT_MODE);
> +       if (data->irq_en) {
> +       /*
> +        * Enable interrupt mode:
> +        * - Configure ICSR for auto-clear on read, push-pull output and =
falling edge
> +        * - Enable "result ready" interrupt in IER
> +        */

This should be indented to the ret =3D ... below.

> +               ret =3D rfd77402_config_irq(client,
> +                                         RFD77402_ICSR_CLR_CFG |
> +                                         RFD77402_ICSR_INT_MODE,
> +                                         RFD77402_IER_RESULT);
> +       } else {
> +       /*
> +        * Disable all interrupts:
> +        * - Clear ICSR configuration
> +        * - Disable all interrupt in IER
> +        */

Ditto.

> +               ret =3D rfd77402_config_irq(client, 0, 0);
> +       }

> +

Stray blank line addition.

>         if (ret < 0)
>                 return ret;

...

>         mutex_init(&data->lock);

This should be  converted to devm_mutex_init(). Otherwise the below
can be called on a (potentially) destroyed mutex.

...

> +       data->irq_en =3D false;
> +       if (client->irq > 0) {
> +               /* interrupt mode */
> +               ret =3D devm_request_threaded_irq(&client->dev, client->i=
rq,
> +                                               NULL, rfd77402_interrupt_=
handler,

> +                                               IRQF_TRIGGER_FALLING | IR=
QF_ONESHOT,

What's wrong with the FW description for the IRQ line flags?! Why
can't it be fixed / written correctly to begin with?

> +                                               "rfd77402", data);
> +               if (ret < 0) {

> +                       dev_err(&client->dev,
> +                               "Failed to request IRQ %d: %d\n",
> +                               client->irq, ret);

Drop the dup messages, it will be printed by the above call.

> +                       return ret;
> +               }
> +
> +               data->irq_en =3D true;
> +               dev_info(&client->dev, "Using interrupt mode\n");

> +

Stray blank line addition.

> +       } else {
> +               /* polling mode */
> +               dev_info(&client->dev, "No interrupt specified, using pol=
ling mode\n");
> +       }

--=20
With Best Regards,
Andy Shevchenko

