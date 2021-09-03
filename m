Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6340067C
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350309AbhICUWm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 16:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245101AbhICUWm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 16:22:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A9C061575
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 13:21:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m26so396194pff.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hza3u6nI5Tf1G3uJARJU3+31Ql9P+QYMxg3PvLlavq4=;
        b=MLRZ0h9aZsmoEwJjTn5UIKH2aNQwUPbriH1AycVlDlWbN4rXAkrZCJtBpTYdm/5M1x
         KrOrvWAlp+jRV1mS50sb3f6G28S+YWCHC0KkCc/J0nx5GQPoxQkhTyQUYAsSqop9tCyA
         ZYBrURY52QmV91Z+FdEInibMKfJ/GU9zOSQt0VOjC8We9Bel+Fgk3G5tTZYVr3gtqM1o
         7PvRaW+6+sOhBHXuHZxAo7SyUD7JHUvP+CyUyf8p7RBRI5U1Jep/zEnhlmiXWRPk4G8Z
         /E31xQXU5AbV/RZx4pjrbhpOdmxeptSdK+gr7jktRiVkwyFxngN16FI8u1qvdIubTNFe
         6l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hza3u6nI5Tf1G3uJARJU3+31Ql9P+QYMxg3PvLlavq4=;
        b=qmMMVVi9OBK8GZdOzaBWiWboK0uaTIdzTdniFWRJsS5IYK8IjIAcWUUJMdIprRqwd5
         5nCNfiSuPcskl9S6bdJRZFPvtq9UBppk/OCJq+0wHXuykrrR1vhmZZgie5TZ5OINgIOb
         F+3MTrEy9gANBRc0cVNEtbuNAM/7IM9ySOaxdRzBaaeiPMVG2zK64tQXrqZJejZPE2oS
         RMrTxYRPieD3RxWawGTz5zSbFHBwriH6mm41hv3fQMBeIUYXAWgiRDaGz6qLyU69I636
         kS/FCrtveB0JkLxCG3S24pzcNDopKEZegI5IRqdYYD9UB43kLhnv1KaBE+QXBQjcXhXs
         JZqw==
X-Gm-Message-State: AOAM532uguObeTPDPDjcmRTDThxsmgKCV1Gi4RMPIimguB/D6hniZGDx
        +bvj+wpR76mAruBM4APOk9upF0APrbzyi13d8cc=
X-Google-Smtp-Source: ABdhPJwG0EtR5D3VAVOKGQv+dgHkUTaKIZZhTQjQKGYrSfArfI8itrmPk2puv5wFwh6gGE8PjqWfEwiWbo0vG+bMYOI=
X-Received: by 2002:a62:d104:0:b0:3ee:46b:d4ed with SMTP id
 z4-20020a62d104000000b003ee046bd4edmr649308pfg.38.1630700501461; Fri, 03 Sep
 2021 13:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210903144828.497166-1-jacopo@jmondi.org> <20210903144828.497166-3-jacopo@jmondi.org>
 <CAHp75VdX0=JCGDQaqCU5fDGe7vJBNTDTJHu=QOqd_YtGK4Rgdg@mail.gmail.com> <20210903164324.5n7xfo2qw5etwm3c@uno.localdomain>
In-Reply-To: <20210903164324.5n7xfo2qw5etwm3c@uno.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Sep 2021 23:21:05 +0300
Message-ID: <CAHp75VdsMFAx2rb22oyf6NrewomgEdEJOUkuf6g-RONfxARgjw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: chemical: Add Senseair Sunrise 006-0-007 driver
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 3, 2021 at 7:42 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> On Fri, Sep 03, 2021 at 06:36:44PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 3, 2021 at 5:50 PM Jacopo Mondi <jacopo@jmondi.org> wrote:

...

> > > +       mutex_lock(&sunrise->wakeup_lock);
> > > +       sunrise_wakeup(sunrise);
> > > +       ret =3D regmap_read(sunrise->regmap, reg, &val);
> > > +       mutex_unlock(&sunrise->wakeup_lock);
> >
> > Seems to me that you may redefine ->read() for regmap (but double
> > check this, esp. in regard to bulk transfers) with wakeup implied and
> > in that case you probably can use regmap's lock only.
>
> Can you point me to an example where regmap's read is redefined ? I
> failed to find one at a quick look.

Any when struct regmap_config is defined with devm_regmap_i2c_init() call.

This one is not I=C2=B2C, but gives you an idea.
https://elixir.bootlin.com/linux/latest/source/drivers/mfd/intel_soc_pmic_m=
rfld.c#L98

...

> Ugh! I initially had a *dev pointer for the sake of line length in
> error messages in the driver's struct, then I'm asked to remove it,
> then I'm asked to take a pointer to re-shorten the lines.

Up to maintainers then.

...

> > > +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u=
16 data)
> > > +{
> > > +       __be16 be_data =3D cpu_to_be16(data);
> > > +       int ret;
> > > +
> > > +       mutex_lock(&sunrise->wakeup_lock);
> > > +       sunrise_wakeup(sunrise);
> > > +       ret =3D regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> > > +       mutex_unlock(&sunrise->wakeup_lock);
> > > +       if (ret) {
> > > +               dev_err(&sunrise->client->dev,
> > > +                       "Write word failed: reg 0x%2x (%d)\n", reg, r=
et);
> >
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> >
> > return ret;
> >
>
> I can return a positive value for success and change the checks around
> return code to if (ret < 0) but that's driver internal stuff after
> all, does it really matter ? Is this more consistent with the Linux
> i2c API maybe ?  I can change it if it's the case.

I didn't get what this comment has with what I have proposed.

Maybe it wasn't obvious, so I have proposed to change 4 LOCs by 1 LOC, so

if (ret)
  dev_err(...);
return ret;

> > > +}

...

> > > +static ssize_t sunrise_cal_read(const char *buf, size_t len)
> > > +{
> > > +       bool enable;
> > > +       int ret;
> > > +
> > > +       ret =3D kstrtobool(buf, &enable);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (!enable)
> > > +               return len;
> > > +
> > > +       return 0;
> >
> > Why is this a separate function to begin with?
>
> Because it is called from two places where I should have duplicated
> the code otherwise ?

I think what you think about duplication is not and will get even LOC
benefit. Using kstrtobool() directly in the callers is better than
hiding like this.

> > Not sure I have got the logic behind. If enable is true you return 0?!
>
> Yes, so I can
>         if (ret)
>                 return ret;
> in the caller.
>
> > > +}


--=20
With Best Regards,
Andy Shevchenko
