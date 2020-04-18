Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2709D1AEEAB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgDROXE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 10:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgDROXD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 10:23:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A632076A;
        Sat, 18 Apr 2020 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219782;
        bh=s+OfZ2KxxdZwcrREHXWxU7fS/jeFqZ1DY8WumQSGXtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnt4i4OGusNeVXAFWSFQzSsle8M0t0x38JIt14QVT7YOTCDFfhxhiEoGVtGA6kyB/
         FPI1fbolGsrp6pTbx+71cZBRUtYU2AYY3iM9T33HNvhH+5P/c0pvsnc9JZThm+QL+c
         DsADUEaMTJVEUWSSPe645DaFctjbQduJnc+kKOXE=
Date:   Sat, 18 Apr 2020 15:22:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v5 5/5] input: joystick: Add ADC attached
 joystick driver.
Message-ID: <20200418152257.5f8a45bd@archlinux>
In-Reply-To: <NXJZ8Q.5YQ6OBV5Y9V8@crapouillou.net>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-5-contact@artur-rojek.eu>
        <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
        <UFBY8Q.ES4D59V22INC1@crapouillou.net>
        <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
        <7CFY8Q.68YMS0V08F992@crapouillou.net>
        <CAHp75VeVvE8LAO8f=-cwfgL6erFZACGwMnriNRaQnfnHw31wkg@mail.gmail.com>
        <0HGZ8Q.TO6FK92GVGIN3@crapouillou.net>
        <CAHp75VdE=xHi8Kn=nZiH+shHvS6O2pc6W=FCs_VwrJq6Bfwx7w@mail.gmail.com>
        <NXJZ8Q.5YQ6OBV5Y9V8@crapouillou.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Apr 2020 15:24:58 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Le sam. 18 avril 2020 =C3=A0 15:42, Andy Shevchenko=20
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Sat, Apr 18, 2020 at 3:10 PM Paul Cercueil <paul@crapouillou.net>=20
> > wrote: =20
> >>  Le sam. 18 avril 2020 =C3=A0 14:57, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> a =C3=A9crit : =20
> >>  > On Sat, Apr 18, 2020 at 1:48 AM Paul Cercueil  =20
> >> <paul@crapouillou.net> =20
> >>  > wrote: =20
> >>  >>  Le sam. 18 avril 2020 =C3=A0 0:49, Andy Shevchenko
> >>  >>  <andy.shevchenko@gmail.com> a =C3=A9crit : =20
> >>  >>  > On Sat, Apr 18, 2020 at 12:24 AM Paul Cercueil =20
> >>  >> <paul@crapouillou.net> =20
> >>  >>  > wrote: =20
> >>  >>  >>  Le sam. 18 avril 2020 =C3=A0 0:10, Andy Shevchenko
> >>  >>  >>  <andy.shevchenko@gmail.com> a =C3=A9crit : =20
> >>  >>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek =20
> >>  >>  >> <contact@artur-rojek.eu> =20
> >>  >>  >>  > wrote: =20
> >=20
> > ...
> >  =20
> >>  >>  >>  >>  +#include <linux/of.h> =20
> >>  >>  >>  >
> >>  >>  >>  > Do you really need this? (See below as well) =20
> >>  >>  > =20
> >>  >>  >>  >>  +static const struct of_device_id  =20
> >> adc_joystick_of_match[] =3D =20
> >>  >> { =20
> >>  >>  >>  >>  +       { .compatible =3D "adc-joystick", },
> >>  >>  >>  >>  +       { },
> >>  >>  >>  >>  +};
> >>  >>  >>  >>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
> >>  >>  >>  >>  +
> >>  >>  >>  >>  +static struct platform_driver adc_joystick_driver =3D {
> >>  >>  >>  >>  +       .driver =3D {
> >>  >>  >>  >>  +               .name =3D "adc-joystick", =20
> >>  >>  >>  > =20
> >>  >>  >>  >>  +               .of_match_table =3D
> >>  >>  >>  >> of_match_ptr(adc_joystick_of_match), =20
> >>  >>  >>  >
> >>  >>  >>  > Drop this a bit harmful of_match_ptr() macro. It should go =
=20
> >>  >> with =20
> >>  >>  >> ugly =20
> >>  >>  >>  > #ifdeffery. Here you simple introduced a compiler warning. =
=20
> >>  >>  >>
> >>  >>  >>  I assume you mean #ifdef around the of_device_id + module  =20
> >> table =20
> >>  >>  >> macro? =20
> >>  >>  >
> >>  >>  > Yes.
> >>  >>  > =20
> >>  >>  >>  > On top of that, you are using device property API, OF use  =
=20
> >> in =20
> >>  >> this =20
> >>  >>  >> case =20
> >>  >>  >>  > is contradictory (at lest to some extend). =20
> >>  >>  >>
> >>  >>  >>  I don't see why. The fact that the driver can work when  =20
> >> probed =20
> >>  >> from =20
> >>  >>  >>  platform code =20
> >>  >>  >
> >>  >>  > Ha-ha, tell me how. I would like to be very surprised. =20
> >>  >>
> >>  >>  iio_map_array_register(),
> >>  >>  pinctrl_register_mappings(),
> >>  >>  platform_add_devices(),
> >>  >>
> >>  >>  you're welcome. =20
> >>  >
> >>  > I think above has no relation to what I'm talking about. =20
> >>=20
> >>  Yes it does. It allows you to map the IIO channels, set the pinctrl
> >>  configurations and register a device from platform code instead of
> >>  devicetree. =20
> >=20
> > I'm not talking about other drivers, I'm talking about this driver and
> > how it will be instantiated. Above, according to the code, can't be
> > comprehensive to fulfill this. =20
>=20
> This is how the platform devices were instanciated on JZ4740 before we=20
> switched everything to devicetree.
>=20
> >>  > How *this* driver can work as a platform instantiated one?
> >>  > We seems have a conceptual misunderstanding here.
> >>  >
> >>  > For example, how can probe of this driver not fail, if it is not
> >>  > backed by a DT/ACPI properties? =20
> >>=20
> >>  platform_device_add_properties(). =20
> >=20
> > Yes, I waited for this. And seems you don't understand the (scope of)
> > API, you are trying to insist this driver can be used as a platform
> > one.
> > Sorry, I must to disappoint you, it can't. Above interface is created
> > solely for quirks to support (broken) DT/ACPI tables. It's not
> > supposed to be used as a main source for the device properties. =20
>=20
> The fact that it was designed for something else doesn't mean it can't=20
> be used.
>=20
> Anyway, this discussion is pointless. I don't think anybody would want=20
> to do that.
>=20
> >>  >>  >>  doesn't mean that it shouldn't have a table to probe
> >>  >>  >>  from devicetree. =20
> >>  >>  >
> >>  >>  > I didn't get what you are talking about here. The idea of =20
> >>  >> _unified_ =20
> >>  >>  > device property API is to get rid of OF-centric code in  =20
> >> favour of =20
> >>  >> more =20
> >>  >>  > generic approach. Mixing those two can be done only in  =20
> >> specific =20
> >>  >> cases =20
> >>  >>  > (here is not the one). =20
> >>  >>
> >>  >>  And how are we mixing those two here? The only OF-centric thing
> >>  >> here is
> >>  >>  the device table, which is required if we want the driver to  =20
> >> probe =20
> >>  >> from
> >>  >>  devicetree. =20
> >>  >
> >>  > Table is fine(JFYI the types and sections are defined outside of  =
=20
> >> OF =20
> >>  > stuff, though being [heavily] used by it) , API (of_match_ptr()  =20
> >> macro =20
> >>  > use) is not. =20
> >>=20
> >>  Sorry, but that's just stupid. Please have a look at how=20
> >> of_match_ptr()
> >>  macro is defined in <linux/of.h>. =20
> >=20
> > Call it whatever you want, but above code is broken. =20
>=20
> of_match_ptr() is basically defined like this:
>=20
> #ifdef CONFIG_OF
> #define of_match_ptr(x) (x)
> #else
> #define of_match_ptr(x) NULL
> #endif
>=20
> So please, enlighten me, tell me what is so wrong about what's being=20
> done here.
>=20
> > It needs either of:
> > - ugly ifdeffery
> > - dropping of_match_ptr()
> > - explicit dependence to OF
> >=20
> > My choice is second one. Because it makes code better and allows also
> > ACPI to use this driver (usually) without changes. =20
>=20
> And how is unconditionally compiling the of_match_table make it=20
> magically probe from ACPI, without a acpi_match_table?
>=20
> -Paul

Look up PRP0001 ACPI ID.  Magic trick ;)

https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumeration.html=
?highlight=3DPRP0001

It allows you to define an ACPI device in DSDT that is instantiated
from what is effectively the DT binding including the id table.

Jonathan

>=20
>=20

