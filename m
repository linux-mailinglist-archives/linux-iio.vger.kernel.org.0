Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCD1B1AD3
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDUAl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDUAl1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 20:41:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936CEC061A0E;
        Mon, 20 Apr 2020 17:41:25 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i3so13196786ioo.13;
        Mon, 20 Apr 2020 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lp6vpDhEt9eyN5A2LThz9ErewFsCdZY3Mzy1abOFyOM=;
        b=cT7c7uhdV9eMRxr29pkmMWATsUGGzY28V+ctNsd8r9ksSQR7IlXpNqh8+eAys81DEa
         i5N7sgF8ngepHsdKae2d8nzgXXhe7BIxm40fdeirDFhOVl/uGkQj7zrRNpARTn/x45XA
         y+9LMQmh0ucSPSBYlcxnPTM7j5JX5Ia3gB5a5q/6FSbEfnquNfm5LX0icdBT0t5z0nGE
         UGflhB48sCNGUQ/pxxe99MfgE3JNcBI7MaNoqeuTKb5I1xpPnwwThfmKzc9z+qPzz0yi
         aeW8KEFZfQddcWic1B7MevZmfAGJBnwOkSFmqWckb+1AToDJTuDYUA+5F2k15uM1I2cK
         nVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lp6vpDhEt9eyN5A2LThz9ErewFsCdZY3Mzy1abOFyOM=;
        b=JNsptscSyGJ6JTxbVSZFuZcubxoAT4QIPLeeoIQkHvx4nII7TcA85Kc8MjOrtQ6F79
         iSR2TCCe/9CHP/pr5NBAYnIVjBA6i6ayj/nIXh08Uz8yqAMNJNOjzT3LR9QWf20iC8aM
         9gWlaINu9thOYCqyYYFe22Fk3NsxuqnFC3CUr3XOO1OX6HAxlqbVZgvmBLBY/W8536yt
         T9g8hTTtloRE7B/gsdnHPHFZdPaF6ARfBjsM93wRglaE1UzG2kRnC0MWAOZtg2qbJOG0
         2jDoxhhpKurxOp2KFkYkfRDZgG/lWycgMWM6RONjuFS5VLbd2h6e13aGHjr1ra29sZ2B
         ALYA==
X-Gm-Message-State: AGi0PuZ1PTr+lbBj6SzAZzSKM5Os2auf7+igGi9l7GVBqnq1NoBH4mjs
        gv91D19yDs8/X+29RKYtHWwxs9qr9vPPPM5Axos=
X-Google-Smtp-Source: APiQypJa/8ktzh53XgWTNmgtLunc8o0bFjpB0e5CpZ50MeLAPsEXoJIMQxsKtx587H9bDXQxhKTI93+8YR1RVJHY904=
X-Received: by 2002:a6b:580e:: with SMTP id m14mr18198504iob.190.1587429684748;
 Mon, 20 Apr 2020 17:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200420084210.14245-1-m.othacehe@gmail.com> <20200420084210.14245-3-m.othacehe@gmail.com>
In-Reply-To: <20200420084210.14245-3-m.othacehe@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 03:41:12 +0300
Message-ID: <CAHp75VektPSwxu3bShk9yQhbNGmYDa2j1Vbapdkrn3rBiaZ0WQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: vcnl4000: Add event support for VCNL4010/20.
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 20, 2020 at 11:43 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
>
> The VCNL4010 and VCNL4020 chips are able to raise interrupts on proximity
> threshold events. Add support for threshold rising and falling events for
> those two chips.

...

> +       ret = (ret & VCNL4000_SELF_TIMED_EN) > 0;

This can be done outside of lock.
And here is type violation. Use bool for the function.

> +end:
> +       mutex_unlock(&data->vcnl4000_lock);
> +
> +       return ret;
> +}

...

> +       ret = (ret & VCNL4010_INT_THR_EN) > 0;
> +
> +end:
> +       mutex_unlock(&data->vcnl4000_lock);
> +
> +       return ret;
> +}

Ditto.

-- 
With Best Regards,
Andy Shevchenko
