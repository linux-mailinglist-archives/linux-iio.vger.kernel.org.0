Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D11E97CC
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgEaNQY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:16:24 -0400
Received: from myself5.de ([5.230.26.43]:44428 "EHLO myself5.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaNQX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=myself5.de; s=mail;
        h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version; bh=W5ccVW+obt9r0Rj4hDU2tzQGUcviXyWVszf00wL5UM4=;
        b=apLKFY6vQBDns1ttcn9ZbFXfOlSyYAYpWFSBVX5WgtPQAHPc2iInUu1cymGSor8AHMaxIQgOZzZHQkg+lDfMlp8GBNhhrAq9PYc98K18ymnDilOkgT9GRU2JEMLYqr+hLcELafbYYjlVO9vWvNR6m7hVlHpVDh65tfJCN4Th5APIfJKwfG8G+Gi1pVekqolK/bp/XwAT6A8ZWUnHB6Btg9U81T24k2adnBNYeiAbhHfK5glLJaMuMlTjcAXU3brHBUceoXe3Qj1fEeKBJyO/EBkbJ6nJIQtLUzXDQSQAcepnuNQovnsC2dvr/OQlGFUsyIDdMXkBXOZxMWY5/imTeg==;
Received: from mail-lj1-f180.google.com ([209.85.208.180])
        by myself5.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <me@myself5.de>)
        id 1jfNp6-0001pq-A5; Sun, 31 May 2020 15:16:20 +0200
Received: by mail-lj1-f180.google.com with SMTP id c11so4822626ljn.2;
        Sun, 31 May 2020 06:16:20 -0700 (PDT)
X-Gm-Message-State: AOAM530Dzhs5LK79fzj/usbvPRrjxjzQlnhK5j2q0GbK6NC3+hqVvFE5
        ULJCswqOj/yiOEaSzHq98hJA0BNRoaPxaAoohws=
X-Google-Smtp-Source: ABdhPJxUc33ZdqMVMyjmcRr5W6QxwLX6WSExkqzZQC2FYFvtcwIwQ+3Dhet7lJ9RTjgfD2zbfAR46N7J5mAHpPVFygA=
X-Received: by 2002:a2e:9242:: with SMTP id v2mr8762909ljg.41.1590930974288;
 Sun, 31 May 2020 06:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200529200550.357118-1-me@myself5.de> <20200531112951.085507de@archlinux>
In-Reply-To: <20200531112951.085507de@archlinux>
From:   Christian Oder <me@myself5.de>
Date:   Sun, 31 May 2020 15:16:00 +0200
X-Gmail-Original-Message-ID: <CAO6HPN1OfyJBxGO-8-jL6BNqxRfZzDkOkytNLpqAJam=2MPJ8w@mail.gmail.com>
Message-ID: <CAO6HPN1OfyJBxGO-8-jL6BNqxRfZzDkOkytNLpqAJam=2MPJ8w@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: mxc4005: add support for mxc6655
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Christian Oder <me@myself5.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

I tested the sensor on a Chuwi Hi10 X and only went by what I've seen in other
commits before[1].

I just ran another test to see what entry is necessary and it appears the sensor
still works when removing the i2c entry, but is not working anymore when
removing the ACPI match. I got the ACPI IDs from udevadm info -e[2].
Would that mean, that I should remove the i2c entry given it's working fine
with ACPI on its own then, or am I missing something?

I'm also successfully using the ACPI ID for the touchscreen orientation quirk
in systemd[3].

> Adding an explicit DT binding table would also be
> good if that is method you are using to probe this (or PRP0001
> from acpi which uses the dt bindings table)

Frankly, I have no idea how to do that or if that would still be required when
using ACPI. Can you point me in a rough direction in case it's still needed?

Regards,
Christian

---

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/iio/accel/mxc6255.c?h=v5.6.15&id=06777c562a50a09c4a2becfb2bf63c762a45df17

[2]
P: /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:22/MXC6655:00
L: 0
E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:22/MXC6655:00
E: SUBSYSTEM=acpi
E: MODALIAS=acpi:MXC6655:MXC6655:
E: USEC_INITIALIZED=5319671
E: ID_VENDOR_FROM_DATABASE=The Linux Foundation

P: /devices/pci0000:00/0000:00:16.0/i2c_designware.0/i2c-0/i2c-MXC6655:00
L: 0
E: DEVPATH=/devices/pci0000:00/0000:00:16.0/i2c_designware.0/i2c-0/i2c-MXC6655:00
E: SUBSYSTEM=i2c
E: MODALIAS=acpi:MXC6655:MXC6655:

[3]
https://github.com/systemd/systemd/commit/5e0676c2cad60b1ea029b9bfb9737e1967abb93a

On Sun, May 31, 2020 at 12:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 29 May 2020 22:05:49 +0200
> Christian Oder <me@myself5.de> wrote:
>
> > The mxc6655 is fully working with the existing mxc4005 driver.
> > Add support for it.
> >
> > Signed-off-by: Christian Oder <me@myself5.de>
>
> One query on ACPI bindings.  What is there already may
> be missleading :(
>
>
> > ---
> >  drivers/iio/accel/mxc4005.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> > index 3d5bea651923..3b8614352cb4 100644
> > --- a/drivers/iio/accel/mxc4005.c
> > +++ b/drivers/iio/accel/mxc4005.c
> > @@ -474,12 +474,14 @@ static int mxc4005_probe(struct i2c_client *client,
> >
> >  static const struct acpi_device_id mxc4005_acpi_match[] = {
> >       {"MXC4005",     0},
> > +     {"MXC6655",     0},
>
> Do we have a reference for these ACPI bindings?  While they may seem
> obvious, memsic don't have a registered PNP or ACPI ID that I can
> find.  If these are in the wild (i.e. in shipping firmware) then we
> can take them as defacto bindings, otherwise we should avoid making
> them so by putting them in the driver.
>
> Quite a few similar bindings got in a while back that I should have
> noticed, but I wasn't so familiar with ACPI back then.  Some
> scrubbing of these has gone on recently, but there are lots still
> left in IIO.
>
> If we aren't sure, then drop the ACPI addition and just leave the
> i2c one below.  Adding an explicit DT binding table would also be
> good if that is method you are using to probe this (or PRP0001
> from acpi which uses the dt bindings table)
>
> Thanks,
>
> Jonathan
>
>
> >       { },
> >  };
> >  MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
> >
> >  static const struct i2c_device_id mxc4005_id[] = {
> >       {"mxc4005",     0},
> > +     {"mxc6655",     0},
> >       { },
> >  };
> >  MODULE_DEVICE_TABLE(i2c, mxc4005_id);
>
