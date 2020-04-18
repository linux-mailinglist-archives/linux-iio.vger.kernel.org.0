Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEC1AEC8E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 14:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDRMm2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgDRMm2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 08:42:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020CAC061A0C;
        Sat, 18 Apr 2020 05:42:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o15so1969210pgi.1;
        Sat, 18 Apr 2020 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=msTveBEE/I7WigbRod9wGTghAO8DUZ+Kgh3c4iHP0FE=;
        b=Y3wnFQ8AT/XizL1ztZDKm+4ZYXkLjydtTYVgJfv7Zsajc3/IYcsf7bAa4YwdygSa3s
         V4XsL5LeC/pU8c68g6blcUZwf4dKneKmC+strYrrjBMJnt9ry8eSrjOfHhYb72H22x39
         NKHA1dGDv2osm2qH0rFOnmZyRGXLbtw3iC4u5kUtietmfhmLBlc7HAgbEEWVwdu8apKy
         VuB3UVMf2x2K71w5bVvNaWUi+G6ikDhm6Uh/kHbmAC2KCoL+Pu0guSeZ0O6A8/RX600N
         q3fHlleTE5hBqEv+bD0icM8K8bFvl1dwTHOVN+SHJ4iwKvDCRMzigNZKMtbszf160Aey
         EKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=msTveBEE/I7WigbRod9wGTghAO8DUZ+Kgh3c4iHP0FE=;
        b=QSuZqyr2qz7gJ5xbf4/NoLBO49xac/c1eXDHagHLCwwcDzv0xkmaw+6uDj8qnDbU2M
         v61pGBEhO+Tq3/zm6fCtJ5VL/a36LmPRetmHm8RzoprjH6iXcligfRQ4LRkGZ/FeRCDh
         GTvAzDk8ePk416aTrOKS/mt3XcmQj/IigSHhjSffUx0THsj/bZQhxXBgqYEEvKQYxLZx
         DP6NevDlOVF2jrQr8b2IwU6f/cw/0SyuzmKSERxF+NUPDuUzg8yz6gkCJwpXRByrUK4Z
         JfHhbCiQNq0dA/2rzKLg7QY0EiDL1CVxZdktFcJnpZQRszLDCmNbD25W+mZUPi1zkwgK
         U24w==
X-Gm-Message-State: AGi0PuZ0fj2FQ6fxrWe0NyJHMr70hHyMFoXwiNHguxh+ND/t6F9DWmzL
        le+VdnNc2pDVIBmaVAhTrEHHNy6k12TEPDq90wM=
X-Google-Smtp-Source: APiQypKf2VMHD7rKz0HAHuXSVwB8prRvGVthOHXAroX4Y1+Y5pXFGk/+z0os4Bk0Lz+PLNL39EgkUd9ph8MUZWhKsYA=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr7467742pgb.74.1587213747470;
 Sat, 18 Apr 2020 05:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu>
 <20200417202859.35427-5-contact@artur-rojek.eu> <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
 <UFBY8Q.ES4D59V22INC1@crapouillou.net> <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
 <7CFY8Q.68YMS0V08F992@crapouillou.net> <CAHp75VeVvE8LAO8f=-cwfgL6erFZACGwMnriNRaQnfnHw31wkg@mail.gmail.com>
 <0HGZ8Q.TO6FK92GVGIN3@crapouillou.net>
In-Reply-To: <0HGZ8Q.TO6FK92GVGIN3@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Apr 2020 15:42:16 +0300
Message-ID: <CAHp75VdE=xHi8Kn=nZiH+shHvS6O2pc6W=FCs_VwrJq6Bfwx7w@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 5/5] input: joystick: Add ADC attached joystick driver.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 18, 2020 at 3:10 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le sam. 18 avril 2020 =C3=A0 14:57, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Sat, Apr 18, 2020 at 1:48 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>  Le sam. 18 avril 2020 =C3=A0 0:49, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  > On Sat, Apr 18, 2020 at 12:24 AM Paul Cercueil
> >> <paul@crapouillou.net>
> >>  > wrote:
> >>  >>  Le sam. 18 avril 2020 =C3=A0 0:10, Andy Shevchenko
> >>  >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
> >>  >> <contact@artur-rojek.eu>
> >>  >>  > wrote:

...

> >>  >>  >>  +#include <linux/of.h>
> >>  >>  >
> >>  >>  > Do you really need this? (See below as well)
> >>  >
> >>  >>  >>  +static const struct of_device_id adc_joystick_of_match[] =3D
> >> {
> >>  >>  >>  +       { .compatible =3D "adc-joystick", },
> >>  >>  >>  +       { },
> >>  >>  >>  +};
> >>  >>  >>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
> >>  >>  >>  +
> >>  >>  >>  +static struct platform_driver adc_joystick_driver =3D {
> >>  >>  >>  +       .driver =3D {
> >>  >>  >>  +               .name =3D "adc-joystick",
> >>  >>  >
> >>  >>  >>  +               .of_match_table =3D
> >>  >>  >> of_match_ptr(adc_joystick_of_match),
> >>  >>  >
> >>  >>  > Drop this a bit harmful of_match_ptr() macro. It should go
> >> with
> >>  >> ugly
> >>  >>  > #ifdeffery. Here you simple introduced a compiler warning.
> >>  >>
> >>  >>  I assume you mean #ifdef around the of_device_id + module table
> >>  >> macro?
> >>  >
> >>  > Yes.
> >>  >
> >>  >>  > On top of that, you are using device property API, OF use in
> >> this
> >>  >> case
> >>  >>  > is contradictory (at lest to some extend).
> >>  >>
> >>  >>  I don't see why. The fact that the driver can work when probed
> >> from
> >>  >>  platform code
> >>  >
> >>  > Ha-ha, tell me how. I would like to be very surprised.
> >>
> >>  iio_map_array_register(),
> >>  pinctrl_register_mappings(),
> >>  platform_add_devices(),
> >>
> >>  you're welcome.
> >
> > I think above has no relation to what I'm talking about.
>
> Yes it does. It allows you to map the IIO channels, set the pinctrl
> configurations and register a device from platform code instead of
> devicetree.

I'm not talking about other drivers, I'm talking about this driver and
how it will be instantiated. Above, according to the code, can't be
comprehensive to fulfill this.

> > How *this* driver can work as a platform instantiated one?
> > We seems have a conceptual misunderstanding here.
> >
> > For example, how can probe of this driver not fail, if it is not
> > backed by a DT/ACPI properties?
>
> platform_device_add_properties().

Yes, I waited for this. And seems you don't understand the (scope of)
API, you are trying to insist this driver can be used as a platform
one.
Sorry, I must to disappoint you, it can't. Above interface is created
solely for quirks to support (broken) DT/ACPI tables. It's not
supposed to be used as a main source for the device properties.

> >>  >>  doesn't mean that it shouldn't have a table to probe
> >>  >>  from devicetree.
> >>  >
> >>  > I didn't get what you are talking about here. The idea of
> >> _unified_
> >>  > device property API is to get rid of OF-centric code in favour of
> >> more
> >>  > generic approach. Mixing those two can be done only in specific
> >> cases
> >>  > (here is not the one).
> >>
> >>  And how are we mixing those two here? The only OF-centric thing
> >> here is
> >>  the device table, which is required if we want the driver to probe
> >> from
> >>  devicetree.
> >
> > Table is fine(JFYI the types and sections are defined outside of OF
> > stuff, though being [heavily] used by it) , API (of_match_ptr() macro
> > use) is not.
>
> Sorry, but that's just stupid. Please have a look at how of_match_ptr()
> macro is defined in <linux/of.h>.

Call it whatever you want, but above code is broken.
It needs either of:
- ugly ifdeffery
- dropping of_match_ptr()
- explicit dependence to OF

My choice is second one. Because it makes code better and allows also
ACPI to use this driver (usually) without changes.

--=20
With Best Regards,
Andy Shevchenko
