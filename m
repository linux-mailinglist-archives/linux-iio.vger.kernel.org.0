Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD14B233FC0
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 09:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgGaHLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 03:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731478AbgGaHLI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 03:11:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056D2C061574;
        Fri, 31 Jul 2020 00:11:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so6537150pjd.3;
        Fri, 31 Jul 2020 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaOPDNqjlm4nruE9qKEP8Z3VW1xQ5LCsXpfkCN21JRE=;
        b=dKvXRzJsQKtOQv7KK4UDiBM5e6YE5z64JNUw9iv/8GlNkOxAI2Ibc8u8dTUvhH/o8M
         hH7/AZtnc8zBtpdRy0rSAqSv+bzdUMJ4VfGOovJJEusJbckaabT21pKZemphdG1QFyPo
         rx6W0qS+Q9/EKussZkJFlw58peNu+3GWQPA4ypH52z1FPgUGfOJP1A047xuz5XogIFYl
         caTyv1aV7FfdNxd477u8pl9YVcrLBKrKgA499lbFttHUs3wHuoySxU4cHDQBV0+tyUua
         k/DMWBabpI+w8le+fUrmQMog8lNa54ZKaTW1WnqV+SEmi0WCXJu5v0ygtihotHawaVdq
         Tbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaOPDNqjlm4nruE9qKEP8Z3VW1xQ5LCsXpfkCN21JRE=;
        b=PBrhHhlt9VQjeploTATbo8p5FpKhqTx6zQWOWT//QuFYl9p5kNPRhV/e2F2zttcqxD
         SanS0mzIWHqeD0SrK1oXTPDLQGPMJCr4cfbNBuenzquVQ4E98Qfjj2kogdhg1+T4HSfI
         z2psZma0rTOpBukTDd1gmpmQzxsmn+23/lrFbVkECwvVH2eTRdCyPomfCVEeMf8FJt2B
         K0p1pKfH8BnvLv6oDR9h9C+KlY91EB7AFH9V59n4MOw2TiL0QbMKiuHU9Xu70ofeSl4Q
         hsZJjq4YpmqAnfjoSNHXuSdvpRY/+7riIaTatJOe3SGhwLkmEoIjVgxSbdmla5WZjtO8
         c+eQ==
X-Gm-Message-State: AOAM532STQpoI9uzsgjoSJDmW+Xjbbqe7m55GWSnOpa4mh6WXuLmiF/k
        uaCuJxvDXwnm6sx0g2T1low7wyJQmTy0tYxErDpFivWK
X-Google-Smtp-Source: ABdhPJzWtWQ3kY9p9w+tHgE1+rPR0H9UvL1RWpHen0xZlB2m3aCIVG8nj504a99egS3aWtYo/qzZmlJntp7aY3w1dzU=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr2849315pjp.228.1596179467430;
 Fri, 31 Jul 2020 00:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200730104946.39148-1-ceggers@arri.de> <20200730104946.39148-3-ceggers@arri.de>
 <CAHp75VeXqFgqiGUkS71B1xCD-60iQFS4EKJwVFX-L_dTUFMc6A@mail.gmail.com> <6453117.yIeBT9JUrU@n95hx1g2>
In-Reply-To: <6453117.yIeBT9JUrU@n95hx1g2>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 10:10:50 +0300
Message-ID: <CAHp75VcO=Gx-G53otdD4QMuzPWBetyFOE1P2uyg8zz7w8fnQwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 31, 2020 at 9:55 AM Christian Eggers <ceggers@arri.de> wrote:
> On Thursday, 30 July 2020, 13:31:31 CEST, Andy Shevchenko wrote:
> > On Thu, Jul 30, 2020 at 1:52 PM Christian Eggers <ceggers@arri.de> wrote:

...

> > > + * @buffer: Buffer for triggered measurements.

> > Actually Jonathan is correct -- the above has kernel doc issues.
> That's correct (the description for @buffer has to be removed). I didn't figure
> out how to automatically check for this. When building with V=1 C=1, I only get
> the message "as73211.c:76: info: Scanning doc for struct as73211_data".

W=1 (not V=1) runs kernel doc validation script.

...

> > > +static unsigned int as73211_gain(struct as73211_data *data)
> > > +{
> > >
> > > +       return BIT(0xb - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
> >
> > Magic!
> Similarly it's difficult to find an eligible alias for the 0xb as the
> whole expression is constructed from viewing tables on the data sheet. I added
> some comment.

For this and the rest, descriptive comment is okay.

...

> > > +               if (val < 0 || (freq_kHz * 1000) != val || val2)
> >
> > Ditto.
> I switched to existing defined where possible. But I wouldn't like to introduce
> this for every possible physical unit. Please check again in v4.

I'll do check.

-- 
With Best Regards,
Andy Shevchenko
