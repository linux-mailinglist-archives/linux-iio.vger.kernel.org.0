Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A306A291FF2
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 22:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgJRUmP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 16:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgJRUmO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 16:42:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93266C0613CE
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 13:42:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b15so6792506iod.13
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+KpZMs+OqXMYvOBeyOsZl9b7vVG7Kgiax4wh9UFch4=;
        b=JAbHfe/fxHnGEpThMPsb62zas4/7ZLvMIerwwWbMXk28kOB1mNpQGnv+kYXJwegmOd
         hBVmk5kOnY1jrSLHt9kLrMSoR3KsmYrOzV0ddGYgLtX2pmq96NfXmFdgLTSSnEN5E9aG
         MfvXVBeNWtlSruLPLS4Dc4S14v2eyUdkOxYXoaydR+hQgeTrHNXDByNx9vpxPlxsbbHf
         KTVGLE/M/14NWszTVX7Jzt4TD7jPA7NOh/tEfqKO72OUM6EQ5eVBVP6OtdmxQlCMhrbF
         v6/03DXZCMoWM6eeFibIHpqAdJlmaJi9x20w5KnellvXPdrtt1maIifCWy5zPMhW3/62
         E7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+KpZMs+OqXMYvOBeyOsZl9b7vVG7Kgiax4wh9UFch4=;
        b=VfC/meH54UKdWnDq3fhwfR1F5SJFFhPcJn13Fqio8jzrOrbqPXJYgSjtpxKRlbCplu
         g18EXZwkL7rcn7lSt0zriIJjGQ1HH1aVguPOoC4UBk7d4n8Cl7/QFm1Vn1Bc5Hcio9gq
         Fhe7uV0KVG8ozdgOVdHZz0UT43ZwmyNwP3mkXP4OZSEju24A+rvGHPXVcz15Q9mWWeaK
         COKdDsyNIyyJ0u0b24z7Sc0kXHERyjpdGW+of0fvSAEPv1c19HFLhrmXeoa3gNMZmMo9
         lY3/CTJYn9naOvQyhR8nn2cTVtI6EsmYGCRHCormiAVZReaP3we71y384eYSHaDvLkLW
         PXZQ==
X-Gm-Message-State: AOAM530Xu+nbG/W5jCPWB0HaAG8pgRaEMCwJKXM8xLmIMejuNH4dWJPU
        W6B56bd5entTxroGIvlCRlhWs7F/nGhyJ6Z+aZXT
X-Google-Smtp-Source: ABdhPJyJZJyx/SI9vkySU5+35w3C+Wuh8+wAXLzABnWOkqurEubVhGNWTEs+YjoyNZSFNECArwuS7uhzk9VQmdiUeJg=
X-Received: by 2002:a6b:9108:: with SMTP id t8mr1323876iod.206.1603053733983;
 Sun, 18 Oct 2020 13:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201018032543.GA27580@ubuntu> <20201018123535.7fdd3ee5@archlinux>
 <CALudOK6z6W4najGF-rZo1TgdXEhx5menqLP+Y__H6B1+jMxBLw@mail.gmail.com>
In-Reply-To: <CALudOK6z6W4najGF-rZo1TgdXEhx5menqLP+Y__H6B1+jMxBLw@mail.gmail.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Mon, 19 Oct 2020 02:12:02 +0530
Message-ID: <CALudOK64hPQjYH--_us5qaguhEDMewWU8n1jABQkFf8YUDQ7GA@mail.gmail.com>
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

On Sun, Oct 18, 2020 at 8:14 PM Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> On Sun, Oct 18, 2020 at 5:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun, 18 Oct 2020 08:55:43 +0530
> > Vaishnav M A <vaishnav@beagleboard.org> wrote:
> >
> > > replace the of_property_read_u32 for reading the amstaos,cover-comp-gain
> > > property with device_property_read_u32,allows the driver to
> > > get the properties information using the more generic device_property_*
> > > helpers and opens the possibility of passing the properties during
> > > platform instantiation of the device by a suitably populated
> > > struct property_entry.
> > >
> > > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> > Please tidy up that description in a similar fashion to I've suggested in
> > other reviews.  Code looks fine.
> >
> > On another day I might have just fixed that description whilst applying but
> > we have lots of time at this point in the cycle, hence I'm bouncing
> > them back to you ;)
> >
> > Thanks,
> >
> > Jonathan
> >
> Thank you Jonathan for the review, sorry about missing to notify after
> sending the v2 patch(and repeating the same mistake a few times), will
> make sure that it won't happen again. I have sent a v3 patch updated with
> all the suggested changes : https://lore.kernel.org/patchwork/patch/1322194/
>
> Thanks and Regards,
> Vaishnav
Updated v4 patch submitted considering comments from Andy Shevchenko
on a different patch to refer to the functions like function() and updated the
commit title to a shorter one, similar to one used for similar changes
within the subsystem, like in 00fa493b9989
("iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors")
https://lore.kernel.org/patchwork/patch/1322221/
> > > ---
> > >  v2:
> > >       - fix commit message
> > >  drivers/iio/light/tsl2563.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> > > index abc8d7db8dc1..1f1b8b7cefa4 100644
> > > --- a/drivers/iio/light/tsl2563.c
> > > +++ b/drivers/iio/light/tsl2563.c
> > > @@ -703,7 +703,6 @@ static int tsl2563_probe(struct i2c_client *client,
> > >       struct iio_dev *indio_dev;
> > >       struct tsl2563_chip *chip;
> > >       struct tsl2563_platform_data *pdata = client->dev.platform_data;
> > > -     struct device_node *np = client->dev.of_node;
> > >       int err = 0;
> > >       u8 id = 0;
> > >
> > > @@ -738,13 +737,14 @@ static int tsl2563_probe(struct i2c_client *client,
> > >       chip->calib0 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
> > >       chip->calib1 = tsl2563_calib_from_sysfs(CALIB_BASE_SYSFS);
> > >
> > > -     if (pdata)
> > > +     if (pdata) {
> > >               chip->cover_comp_gain = pdata->cover_comp_gain;
> > > -     else if (np)
> > > -             of_property_read_u32(np, "amstaos,cover-comp-gain",
> > > -                                  &chip->cover_comp_gain);
> > > -     else
> > > -             chip->cover_comp_gain = 1;
> > > +     } else {
> > > +             err = device_property_read_u32(&client->dev, "amstaos,cover-comp-gain",
> > > +                                            &chip->cover_comp_gain);
> > > +             if (err)
> > > +                     chip->cover_comp_gain = 1;
> > > +     }
> > >
> > >       dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
> > >       indio_dev->name = client->name;
> >
