Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0113F2917E8
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgJROpG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgJROpG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 10:45:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C4C0613CE
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 07:45:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q9so9956383iow.6
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrCZWZA0UVya5CuPPyhpa5lbMQk3lp10Nm0RYvAmhhE=;
        b=0ExDp7zvhXzjH9J95aWKMjyhbpuxZqHlzGRpYnBwhWwS6PHLFivaTBXgNy8bsGwkJw
         EhRSSwMozB6YchvZ3vYtHTh8WmJLXBz2ii0tAliTHgSWk5TWCYSn1CTSr2JqLJ0EShO+
         B+5I/TcYuHu7HQ/3sfQMv31Wyw4tu/VSoCQaSlQ5uilsml3sp/sbYEtki1KCFq+NTCGk
         UIbMmjXtUME/w9o3kAhoB6Z6CHnm1mgLQUK7aAJN/OWoR3dl69RYvSIf7x9flQhg2dVu
         dLUgMF6FOm1ufodVmTo3CdIVPZdGd4XQfkkCAID8j7CsNh3l+kkORIQxZtuN1WmSYoUE
         +ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrCZWZA0UVya5CuPPyhpa5lbMQk3lp10Nm0RYvAmhhE=;
        b=QMY1gp7QcXC2webolR2k0imxhwZ5NTzQ5SIJ3qSD5jyEgu9KE+gY4YZGLIN1vQiXlX
         qqQu3EBSWQN2rUNSeE9LO3wScwdOe8/h72YuIIRVyDKOFb9PFrFbzmu4T+l/443ExhCF
         WJAeY1iAgUoqG6zCyAosLRNyPP6wkT4crNt9FK8U6EfzMszX8pZ+DpaaN7G/G8dkrJRY
         02y3DKebhBMv+7JZ73/sgxbfQlPb+vPGqOePvrC+tzuiY7WwrD8hHuoLG/qcZ+GAUPky
         aJhvow5hdj8QZuO0JaOT7pV7CVdW+8FJWcMEW/EkXZsRBy4kgmEXh+8lXk1g11rM9lIZ
         fmWw==
X-Gm-Message-State: AOAM531JhnWCUpEF1eLtGxJB5JuoD10vVBtHa08NyUleXfGsLNQMgxYL
        w+A5jWC2otivldlPczAjCOInLRNIpBCx9BcIdyfN
X-Google-Smtp-Source: ABdhPJyiAloapWIrnwfz2nCPMT1fjjgM8dATaztc6hdbBPZeggS+9NOHGwsQ6TJ187aqxcomekakPyYkbfZ9iGu0n84=
X-Received: by 2002:a6b:bfc7:: with SMTP id p190mr8033630iof.121.1603032305238;
 Sun, 18 Oct 2020 07:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201018032543.GA27580@ubuntu> <20201018123535.7fdd3ee5@archlinux>
In-Reply-To: <20201018123535.7fdd3ee5@archlinux>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Sun, 18 Oct 2020 20:14:54 +0530
Message-ID: <CALudOK6z6W4najGF-rZo1TgdXEhx5menqLP+Y__H6B1+jMxBLw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: tsl2563 change of_property_read to device_property_read
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        nish.malpani25@gmail.com,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 5:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 18 Oct 2020 08:55:43 +0530
> Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> > replace the of_property_read_u32 for reading the amstaos,cover-comp-gain
> > property with device_property_read_u32,allows the driver to
> > get the properties information using the more generic device_property_*
> > helpers and opens the possibility of passing the properties during
> > platform instantiation of the device by a suitably populated
> > struct property_entry.
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Please tidy up that description in a similar fashion to I've suggested in
> other reviews.  Code looks fine.
>
> On another day I might have just fixed that description whilst applying but
> we have lots of time at this point in the cycle, hence I'm bouncing
> them back to you ;)
>
> Thanks,
>
> Jonathan
>
Thank you Jonathan for the review, sorry about missing to notify after
sending the v2 patch(and repeating the same mistake a few times), will
make sure that it won't happen again. I have sent a v3 patch updated with
all the suggested changes : https://lore.kernel.org/patchwork/patch/1322194/

Thanks and Regards,
Vaishnav
> > ---
> >  v2:
> >       - fix commit message
> >  drivers/iio/light/tsl2563.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> > index abc8d7db8dc1..1f1b8b7cefa4 100644
> > --- a/drivers/iio/light/tsl2563.c
> > +++ b/drivers/iio/light/tsl2563.c
> > @@ -703,7 +703,6 @@ static int tsl2563_probe(struct i2c_client *client,
> >       struct iio_dev *indio_dev;
> >       struct tsl2563_chip *chip;
> >       struct tsl2563_platform_data *pdata = client->dev.platform_data;
> > -     struct device_node *np = client->dev.of_node;
> >       int err = 0;
> >       u8 id = 0;
> >
> > @@ -738,13 +737,14 @@ static int tsl2563_probe(struct i2c_client *client,
> >       chip->calib0 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
> >       chip->calib1 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
> >
> > -     if (pdata)
> > +     if (pdata) {
> >               chip->cover_comp_gain = pdata->cover_comp_gain;
> > -     else if (np)
> > -             of_property_read_u32(np, "amstaos,cover-comp-gain",
> > -                                  &chip->cover_comp_gain);
> > -     else
> > -             chip->cover_comp_gain = 1;
> > +     } else {
> > +             err = device_property_read_u32(&client->dev, "amstaos,cover-comp-gain",
> > +                                            &chip->cover_comp_gain);
> > +             if (err)
> > +                     chip->cover_comp_gain = 1;
> > +     }
> >
> >       dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
> >       indio_dev->name = client->name;
>
