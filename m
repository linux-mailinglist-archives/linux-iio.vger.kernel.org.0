Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D419C14B
	for <lists+linux-iio@lfdr.de>; Thu,  2 Apr 2020 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgDBMmP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Apr 2020 08:42:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43723 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbgDBMmP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Apr 2020 08:42:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id g20so1772269pgk.10;
        Thu, 02 Apr 2020 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TKbIydpRklueBEw0/i7UhJyiz9MBbmx3hB6XV9W11U=;
        b=O3BUPwQDQwBS+6J+YlsV09c9cKEHQLZe73JS3s7YGP2Kv64RmM45GyNeegXSiCso6R
         mZ+hhIpJmOogGb4LTnMjOaX45KTLoMTMlb8uPz0ZqhnkADaWg9l9+oaIh5Kb/RTwT/oN
         T641VF7lvajtaYVc7/3LDiJQKCVhDjbVQvKSaiBVi/OI5pal0oTMlbYD5vKqWb3TCRJR
         mmpPatlwxXXaA3aqLCrPMBZ5a6/EHz7L/xPXyVcCTXfn3m5KP8Lh1eWEnRCJFdc7VOIj
         rVRm1eLiYeq3WIVshWJ++ZN7fLuyyiOqbdVgiW3R0dr/ENKW84WmnL1Z9JGqoH1hxyIU
         yJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TKbIydpRklueBEw0/i7UhJyiz9MBbmx3hB6XV9W11U=;
        b=cgB3zhxWW43booFZ11ckiy/ZnhbMiPblil3aYH++FpYkkbiIkQRI2dmmAPC5gb9HPc
         tKqKjRG7SNiO5bc67hp4B7xr4vBLfte5eaadql3ojHd8adumU8n/Yf3aMUiD4iB9Ztmy
         MGPlEhZ5u3plcTvMmZDsyUD0e9Fu4dAp+zVERjBIpeiDbez8tVwuoPG6JVHufw2Nl59X
         eSAoe9lTx/m1453pfv1ny+k4Q2HneVQp/78MGPPxlBMAeIp2l1XX7vFssxMHkrotqeqG
         o5uyqR21oAr646AVaTTl3WkFFwoBGLyv/yFPznuF6dM6gNNfsJ5I0YOIsn6NTnk9yQTp
         oebg==
X-Gm-Message-State: AGi0PuY6Hl91nZqk7HsyRw4uu+ydxEX7D2VNJQAUQaldz0ROlDk7ja5P
        QBPXKYHVaOMkXaGtnX8Zjj6pN088NSm7Z17HLBg=
X-Google-Smtp-Source: APiQypIyT3haLQJS3HQyLJlfdstDioiAxnqAB0Fi0gof1uU4cZvsPDlN6HR1+gsSdxg2Hdx1qT9ZUYHH+OPb+t3rYwo=
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr3120589pgc.4.1585831333750;
 Thu, 02 Apr 2020 05:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200401162416.24474-1-i.mikhaylov@yadro.com> <20200401162416.24474-3-i.mikhaylov@yadro.com>
 <CAHp75VcdDR-owtFuFMqNLFh_-L902fXODG14_6Dh416tTwjidA@mail.gmail.com> <1e2c9b590a3626abee330a28cca86cbae7affb39.camel@yadro.com>
In-Reply-To: <1e2c9b590a3626abee330a28cca86cbae7affb39.camel@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Apr 2020 15:42:02 +0300
Message-ID: <CAHp75VdaM_pumyWyeHJxCQXrKUAW=ktJme1uYxH0w4e9an0X2A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 2, 2020 at 11:24 AM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> On Wed, 2020-04-01 at 19:35 +0300, Andy Shevchenko wrote:
> > On Wed, Apr 1, 2020 at 7:24 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > > Proximity sensor driver based on light/vcnl4000.c code.
> > > For now supports only the single on-demand measurement.
> > >
> > > The VCNL3020 is a fully integrated proximity sensor. Fully
> > > integrated means that the infrared emitter is included in the
> > > package. It has 16-bit resolution. It includes a signal
> > > processing IC and features standard I2C communication
> > > interface. It features an interrupt function.
> >
> > Thank you for an update, my comments below.
> >
> > ...
> >
> > > +static int get_and_apply_property(struct vcnl3020_data *data, const char
> > > *prop,
> > > +                                 u32 reg)
> > > +{
> > > +       int rc;
> > > +       u32 val;
> > > +
> > > +       rc = device_property_read_u32(data->dev, prop, &val);
> > > +       if (rc)
> > > +               return 0;
> > > +
> > > +       rc = regmap_write(data->regmap, reg, val);
> > > +       if (rc)
> > > +               dev_err(data->dev, "Error (%d) setting property (%s)",
> > > +                       rc, prop);
> >
> > This requires {} according to the coding style
>
> checkpatch.pl doesn't say anything bad on this spot. Do you mean to make
> something like this?
>
> rc = regmap_write(data->regmap, reg, val);
> if (rc) {
>         dev_err(data->dev, "Error (%d) setting property (%s)",
>                 rc, prop);
> }

Yes. Checkpatch is neither strict nor fully comprehensive tool.

> In previous notes you said to remove them.

When it's one line, it fine, otherwise you need {} surround.

https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

> > > +       return rc;
> > > +}
> >
> > ...
> >
> > > +static int vcnl3020_probe(struct i2c_client *client)
> > > +{
> > > +       indio_dev->name = VCNL_DRV_NAME;
> >
> > It's definitely not a driver name. You have to put part number here.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/tsl4531.c?h=v5.6#n199
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/max44009.c?h=v5.6#n507
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/vl6180.c?h=v5.6#n515

Let's Jonathan speak up.

-- 
With Best Regards,
Andy Shevchenko
