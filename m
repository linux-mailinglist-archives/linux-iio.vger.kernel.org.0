Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE901D85D0
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgERRvo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbgERRvn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 13:51:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDCAC061A0C;
        Mon, 18 May 2020 10:51:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so4531902plt.5;
        Mon, 18 May 2020 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJ3DKY7Zr9PGXQiFNc8d9vTcSjgnnAbCq5O6/G8CCg4=;
        b=TE8I8dQ8Wqs7x5u+poBX2PYL7VHczF4L9tZyWg6xg3w7P79g+iqBbReWmXghjCoR01
         LYy5qDvCnk8MectVa5opXCkC11SatAw583tfW8J6jU1W/RzPyC/AeYqMB5rvfjK90zeP
         PCy8cphadcqrBHoIzn8l7Pg8DKAan7BYZH2XSGT1V05mEQTEAA8SQgXH8alQwL96qiaC
         L6Wv++5GBfGLoEey0OvOFDKd6QiDjTs175byY+ygjaFO5Za76iUzblYpAZKZNq3z4Zyx
         ImH/tR0GZLtvnrlJdaHAdCRbssVr1pIAUX97DeL9UEFZamk+StjYrPMkJYqjBH/ySkld
         dM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJ3DKY7Zr9PGXQiFNc8d9vTcSjgnnAbCq5O6/G8CCg4=;
        b=m8MAY0rZl23B+/3P5WqOnzFliQpTA7ahlyWU7r3YcodRhRCgl6WumvVa8AFTF6/Ub0
         Pa+HPG2V6XUHOYpJD4ScOhc+T/0dm8ESuRAcKR68JUSMnBcTnEf4PdVPzrtuFtoUraNI
         yMw+LYgC/4f+hBruXA7gnzzFBe5jk/OfTuSM8pFTVVeFhBzm7MLSOzKBHMlnZzNEpGmE
         YBgcWyl9hPMhB59k689DDsYlzrHl0FTmsDSMyOKNzLKJ1hv22zk5lTvYKswFHqlnRJ4U
         hpK39GPjwzCUsMiHGqTb9a0ywkjLX1o11Yni546rfczyX9JlQgr7KUS5Pf5V/DtuVL7l
         LTow==
X-Gm-Message-State: AOAM532s+A3BaXH5uDlKidSyCDXIDE89D8r8kfHpAB/KzN5t5bKvtQGp
        u0sKHztd0b+NIbspV53WJv7MUwOdWPsonLE8Ozo=
X-Google-Smtp-Source: ABdhPJyb6Ux94KIQxWhThm1nR3vxSwRgDHR84pJnBiq3Gp6b7lfOJIwcfwHL78kFpu1IMemoj8IrA0sd48dB46iCXHg=
X-Received: by 2002:a17:902:930c:: with SMTP id bc12mr17510090plb.255.1589824301578;
 Mon, 18 May 2020 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
 <20200518133645.19127-4-jonathan.albrieux@gmail.com> <CAHp75VdFJUNOtRyCNEGnvoOCZYoPvyhjC15_iC72JD-1sOavwA@mail.gmail.com>
 <20200518160120.GA21361@ict14-OptiPlex-980> <20200518164317.GL1634618@smile.fi.intel.com>
 <20200518174335.GA6392@jonathan-N53SV>
In-Reply-To: <20200518174335.GA6392@jonathan-N53SV>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 May 2020 20:51:29 +0300
Message-ID: <CAHp75VcJ+LU_T4jRVNDBed50xaALDLNC_8brxszv5FpUGHF7+A@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8975: Add gpio reset support
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 8:43 PM Jonathan Albrieux
<jonathan.albrieux@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 07:43:17PM +0300, Andy Shevchenko wrote:
> > On Mon, May 18, 2020 at 06:01:20PM +0200, Jonathan Albrieux wrote:
> > > On Mon, May 18, 2020 at 05:55:51PM +0300, Andy Shevchenko wrote:
> > > > On Mon, May 18, 2020 at 4:38 PM Jonathan Albrieux
> > > > <jonathan.albrieux@gmail.com> wrote:
> > > >
> > > > > +       gpiod_set_value_cansleep(data->reset_gpiod, 1);
> > > >
> > > > (1)
> > > >
> > > > ...
> > > >
> > > > > +       /*
> > > > > +        * If reset pin is provided then will be set to high on power on
> > > > > +        * and to low on power off according to AK09911 datasheet
> > > > > +        */
> > > >
> > > > Wording is confusing, perhaps you have to use 'asserted / deasserted'.
> > >
> > > Thank you for the suggestion, I'll be working on rewording as soon as
> > > possible.
> > >
> > > > Btw, in (1) it's also "high" (asserted). I barely understand how it's
> > > > supposed to work in all cases?
> > > >
> > > > > +       reset_gpiod = devm_gpiod_get_optional(&client->dev,
> > > > > +                                             "reset", GPIOD_OUT_HIGH);
> > > > > +       if (IS_ERR(reset_gpiod))
> > > > > +               return PTR_ERR(reset_gpiod);
> > > >
> > >
> > > I'm sorry but I'm not sure about what you mean by saying all cases.
> > > Currently  I'm testing this driver on a msm8916 device having AK09911
> > > magnetometer. At the current stage the driver is failing on probe
> > > because reset pin is not connected to VID (as datasheet requires in case
> > > of pin not being used). In case of reset pin not asserted, register's
> > > reset is triggered resulting in empty registers, leading to probe fail.
> > > For this reason pin is asserted during power on in order to have
> > > informations in registers and deasserted before power off triggering
> > > a reset.
> > >
> > > A workaround that gets AK09911 working on device is by setting the
> > > reset pin always high on device tree. This way registers gets reset by
> > > a Power On Reset circuit autonomously and reset pin never triggers the
> > > reset.
> >
> > You need to distinguish electrical level from logical (GPIO flag defines
> > logical). So, I'm talking about active-high vs. active-low case.
> >
> > Now I re-read above, and see that here you assert the reset signal. But where
> > is desertion?
>
> Oh I see, I'll try explaining by points the proposed approach:
> - reset pin is active low
> - during power on gpio is set to 0 so the reset pin is high, thus no reset

deasserted

> - during power off gpio is set to 1 so the reset pin becomes low, thus resetting

asserted

> this is a possible solution but maybe there are other ways to achieve that,
> do you have suggestions on how to get a better approach for solving this issue?

I see now, that at requesting reset you wanted to chip be in reset
state (asserted) till driver calls power_on().

Seems everything you done is correct. Just correct terminology, please.

-- 
With Best Regards,
Andy Shevchenko
