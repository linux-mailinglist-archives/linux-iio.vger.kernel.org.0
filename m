Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E044D877
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhKKOp0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 09:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKOp0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 09:45:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7050C061766
        for <linux-iio@vger.kernel.org>; Thu, 11 Nov 2021 06:42:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w1so25112786edd.10
        for <linux-iio@vger.kernel.org>; Thu, 11 Nov 2021 06:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kDg41lEmKZLNV+ba6/XUqj+CHGsXr9mTNWa49sW5OGE=;
        b=FQLiBp0TicgyWwewWMfUi0OIjIr7w/QJF+7uvtkbVjtuZF3zB7z4EN4KSpTMYZMLuf
         IhlLct0uhwwW4sPQ/+fzI5ZoVz5xCIEFVwBB4cSJiOhBYhdTlKkxkH+RYaztvVuxuA8+
         olbsxevFFD9Lkx1uJ0WAfdPC5S2Ig5oNFjS+SyXsXhnYPLGa89Ui/g/ZT+wuLwRFUKc1
         3BCfiKN+6vyUFML3oNxHNZZrsgPPXhptpXan9blHUN4jv912IqQ3jMuwR0Zh/jximPKX
         va866ccmMy7GkWawEMB+edh0nTgHp4WfOm6BEQxqDzF3ofHt76sV7Y4tNbooZECV0I2W
         OLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kDg41lEmKZLNV+ba6/XUqj+CHGsXr9mTNWa49sW5OGE=;
        b=QKoMyydONV0/DasyIo8HX6EvRLhrXHEaZR3SY3G0Ni5qEL/AGgQ1xkSD++zB2rRWBT
         EJxdjWNxlXIFjP4D60FI1rS6Xzax7wK9aZ3c4XXDv3g4yYpObeFl2OMKMGT5us1P3BIL
         +tm6AiJnannR6/HEkulVvIX+Rt7g50y9otiM90c4Zg+MfUfLhiZLYq7af26cuDklOEdz
         VQwAjwH+0SKKEkBgUHRYSGhl4dtOBXmeSmTB0+RT8qsvieQC+DyQWqT182Pmdkfa1qST
         GJEObOf8buDb77XytzhFaGQ+dOelH5jKUNcWMIhviTxbiRv4NBpSMzylyU7i7N4nLW4/
         UWgQ==
X-Gm-Message-State: AOAM531vL2PmbUKUQN6X043qCrl2eX5M6LAYXqSWFRYIoroSBg+772+Z
        S7NhJ1Ha+s6IvwOV8JGPvuujg4QD7wRsVuwuLZ4=
X-Google-Smtp-Source: ABdhPJzqB15q8wcu0paP+PAaJSI1URGG7SRNdymQj1k9AfSVe1mleDr+3jvvEjUJU35zBtsPf1fkg681rw8KDcVMSzs=
X-Received: by 2002:a05:6402:207c:: with SMTP id bd28mr10724765edb.240.1636641755158;
 Thu, 11 Nov 2021 06:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20211111110043.101891-1-nuno.sa@analog.com> <20211111110043.101891-2-nuno.sa@analog.com>
 <CAHp75Ve3ZfFz5g4qH6HhuqaLKgqd058Jj-xY4=-e3ciG67cfRg@mail.gmail.com> <PH0PR03MB6366576BD3950F5F5D2A403599949@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB6366576BD3950F5F5D2A403599949@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 16:41:51 +0200
Message-ID: <CAHp75VfsMa7n8BVJvN36N02u+LKLO36tZNx4rdEzSGZ4HGGoMA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] iio: dac: add support for ltc2688
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 11, 2021 at 4:30 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Thursday, November 11, 2021 2:49 PM
> > On Thu, Nov 11, 2021 at 1:01 PM Nuno S=C3=A1 <nuno.sa@analog.com>
> > wrote:

...

> > > +static const int ltc2688_off_tbl[LTC2688_SPAN_RANGE_MAX] =3D {
> > > +       [LTC2688_SPAN_RANGE_0V_5V] =3D 0,
> > > +       [LTC2688_SPAN_RANGE_M10V_10V] =3D -32768,
> > > +       [LTC2688_SPAN_RANGE_M15V_15V] =3D -32768,
> >
> > > +       [LTC2688_SPAN_RANGE_0V_10V] =3D 0,
> > > +       [LTC2688_SPAN_RANGE_M5V_5V] =3D -32768
> >
> > + Comma
> >
> > Isn't it more natural to move them up by two lines?
>
> There's a reason for this to be ordered like this.

I understand that for enum, but here it doesn't make any sense to me
since you are addressing them by indices.

>  Anyways,
> as I said in the cover letter I will probably remove all of these things
> used to validate scale + offset pairs. I think is a bit overdone...

> > > +};

...

> > > +                       if (off =3D=3D ltc2688_off_tbl[i]) {
> > > +                               break;
> >
> > > +                       } else if (i < LTC2688_SPAN_RANGE_0V_10V) {
> >
> > Redundant 'else'.
>
> Why? Note that I really (where possible) want to make a distinction
> between the errors...

while () {
  if ()
    ...
    break;
  } else {
    ...
  }
}

Isn't it obvious?

Same with

if ()
  return
else
  ...

> > > +                       }

...

> > > +               ret =3D fwnode_property_read_u32(child, "reg", &reg);
> > > +               if (ret) {
> > > +                       fwnode_handle_put(child);
> >
> > > +                       return dev_err_probe(&st->spi->dev, ret,
> > > +                                            "Failed to get reg prope=
rty\n");
> >
> > One line.
> >
> > > +               } else if (reg >=3D LTC2688_DAC_CHANNELS) {
> >
> > Redundant 'else'.
>
> Do you mean?
>
> if (ret)
>  ...
>
> if (reg >=3D LTC2688_DAC_CHANNELS)
>  ....

Yes.

> > > +               }

...

> > > +               chan->overrange =3D fwnode_property_read_bool(child,
> > > +                                                           "adi,over=
range");
> >
> > One line?
>
> It will pass the 80 col limit. AFAIR, Jonathan prefers to keep it when it
> does not hurt readability...

I believe it will increase readability being located on one line.

...

> > > +       if (gpio) {
> > > +               usleep_range(1000, 1200);
> > > +               /* bring device out of reset */
> > > +               gpiod_set_value_cansleep(gpio, 0);
> >
> > > +       } else {
> >
> > I'm wondering why 'else'? Can't it be both? Why not?
>
> Well, if we have the reset pin, then we reset using it. If there's
> no pin, we use the SW reset. It's a common pattern that we already use
> for example in the ADIS devices.

Perhaps a comment in the code is needed.

> > > +               ret =3D regmap_update_bits(st->regmap,
> > LTC2688_CMD_CONFIG_REG,
> > > +                                        LTC2688_CONFIG_RST,
> > > +                                        LTC2688_CONFIG_RST);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +       }

...

> > > +       /* ignoring the no op command */
> > > +       .max_register =3D U16_MAX - 1
> >
> > Really?! Have you ever considered what burden you bring with this to
> > one who accidentally or on purpose tries to dump registers via
> > debugfs?
>
> Ups, this is completely wrong!! It should be U8_MAX...

Ah, that explains!

...

> > > +       st->regmap =3D devm_regmap_init(&spi->dev, NULL, st,
> > &ltc2688_regmap_config);
> >
> > I'm wondering why it's not a regmap SPI?
>
> The problem is on the read side... In the first transfer we write the com=
mand/register
> to read, then we need to release the CS pin so that the device executes t=
he command,
> and only then we read the data. AFAIK, the regmap spi implementation won'=
t work like
> this. I think CS is kept asserted the whole time...

I believe it's configurable, no? Like the cs_change flag somewhere.
Can you double check?

--=20
With Best Regards,
Andy Shevchenko
