Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B644C228F44
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 06:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgGVEiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 00:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgGVEiX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 00:38:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33601C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 21:38:23 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p205so1182700iod.8
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 21:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6dpV1Yac8bKIvaNxDh/vvjPXWatCVdJyiZfqcerbqI=;
        b=pSZht23KX3xziGK1kW06j3HAkO+BdtGuZlgPZgJbc84AUpdl5no8dRsUVd+7QzJwRD
         Zxg2kmgvyOoVB9XCweAjDGJvU1p0syWdjBoiAIYX9cFdcWTOUT3qzbeM2/Tewt/klUHl
         VKLk/VopsRtpTeUZaWSSAPbJOKmmFesKSpNGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6dpV1Yac8bKIvaNxDh/vvjPXWatCVdJyiZfqcerbqI=;
        b=YFj7Bk64l0d5UKCGsnws/8KTOsaYAak7hY0uxqsF/T5u7GtHsijtVRl2Ztr/HH7Ezc
         6/FpFM2zQnJ+Y1J14Sy9sTDERghbo/wB7rA+naGnKcJW5YPkBc+lD+zTi6JgnP/PNO4m
         3/m+3EKzC3uMx4ksO6vON+TwdvQ8XBc8oH+5GLUF+auFcLIsjCcsoQOQADBw8ASkctlR
         uITcpwcTRdWcLC3PnG77yJCmPS31eJMwDCc/RyxNUXS2mVxg1omADxBocx+LyivjAI1t
         gH9+e6wkrg1YmE7AI3+J7s3HDonBHob2ae4KpdjpsX+VpE/TrR0Wxdbpl+Hx/ePUOFVV
         WWEA==
X-Gm-Message-State: AOAM533gpSs8Ac/MLpDUluiojpdXj+VJsc8z4xkyeHYqKLP+vGnoxI9/
        EsVATZKvjCiKuuMQ0E1zOV3/Dh6TAV8fk1mPyYHZFA==
X-Google-Smtp-Source: ABdhPJyQ2kfUo+OaiI+8dnUCdZKD7OUekjJPmBgz+kCmudYWkGqOYsLx10zDXnqWSClmjVj10wCmmUxgYkN2gmb+nZ0=
X-Received: by 2002:a6b:bc41:: with SMTP id m62mr29372666iof.95.1595392702563;
 Tue, 21 Jul 2020 21:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
 <20200720070330.259954-4-matt.ranostay@konsulko.com> <CAHp75VcuwLoX5Xxb-BGPKE6BWnDJq=O5knV6u8wWXYsLHfGL9Q@mail.gmail.com>
In-Reply-To: <CAHp75VcuwLoX5Xxb-BGPKE6BWnDJq=O5knV6u8wWXYsLHfGL9Q@mail.gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 21 Jul 2020 21:38:11 -0700
Message-ID: <CAJCx=g=+zunxptnoLva7VGXqkU0Kwn9xxkTjKeO0F1VeXwSTTw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: chemical: atlas-ezo-sensor: add support for
 O2 sensor
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 11:46 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 20, 2020 at 10:05 AM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> >
> > Add support for the Atlas EZO O2 chemical sensor which required
> > some refactoring of the driver and parsing of i2c transfer.
> >
> > Sensor data is converted by the scaling value from percent to
> > IIO_CONCENTRATION.
>
> ...
>
> > +static void atlas_ezo_sanitize(char *buf)
> > +{
> > +       char *ptr = strchr(buf, '.');
> > +
> > +       if (!ptr)
> > +               return;
> > +
> > +       for (; *ptr; ptr++)
> > +               *ptr = *(ptr + 1);
> > +}
>
> NIH of memmove()? Why?

Mainly since I forgot that POSIX function. I'll fix it up when possible

- Matt

>
> And actually to avoid strlen() you may do it other way around, i.e
> shift integer part one character right and return new buffer pointer.
>
>
> if (!ptr)
>   return buf;
>
> memmove(buf + 1, buf, ptr - buf);
> return buf + 1;
>
> --
> With Best Regards,
> Andy Shevchenko
