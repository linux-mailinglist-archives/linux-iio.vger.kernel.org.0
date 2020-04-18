Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC261AF2D6
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgDRRZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 13:25:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46150 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgDRRZ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 13:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587230726; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJK3SzVpQ1si/reyVxcaxpHREQLlO3j66OLfCZHjFz8=;
        b=ovFlkDngSG/UH+xUeOabMOqk8s3sWsFD3Ajn8VcLM8qAURKHeCHdwIj7x/gJoK4/NpubJI
        myHC+zj7i0mU/gSasdHYFqsLUsoeJGpV/q0y8PqLe2XgILJUB29h+7/8tnQY/LFH+UYumP
        YfxXY+P6PmNPBqiZzfguL8HLsdOb72c=
Date:   Sat, 18 Apr 2020 19:25:15 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH v5 5/5] input: joystick: Add ADC attached joystick
 driver.
To:     Jonathan Cameron <jic23@kernel.org>
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
Message-Id: <32VZ8Q.HWUYPX9U9OKT@crapouillou.net>
In-Reply-To: <20200418152257.5f8a45bd@archlinux>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-5-contact@artur-rojek.eu>
        <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
        <UFBY8Q.ES4D59V22INC1@crapouillou.net>
        <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
        <7CFY8Q.68YMS0V08F992@crapouillou.net>
        <CAHp75VeVvE8LAO8f=-cwfgL6erFZACGwMnriNRaQnfnHw31wkg@mail.gmail.com>
        <0HGZ8Q.TO6FK92GVGIN3@crapouillou.net>
        <CAHp75VdE=xHi8Kn=nZiH+shHvS6O2pc6W=FCs_VwrJq6Bfwx7w@mail.gmail.com>
        <NXJZ8Q.5YQ6OBV5Y9V8@crapouillou.net> <20200418152257.5f8a45bd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le sam. 18 avril 2020 =E0 15:22, Jonathan Cameron <jic23@kernel.org> a=20
=E9crit :
> On Sat, 18 Apr 2020 15:24:58 +0200
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
>>  Le sam. 18 avril 2020 =E0 15:42, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > On Sat, Apr 18, 2020 at 3:10 PM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > wrote:
>>  >>  Le sam. 18 avril 2020 =E0 14:57, Andy Shevchenko
>>  >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  >>  > On Sat, Apr 18, 2020 at 1:48 AM Paul Cercueil
>>  >> <paul@crapouillou.net>
>>  >>  > wrote:
>>  >>  >>  Le sam. 18 avril 2020 =E0 0:49, Andy Shevchenko
>>  >>  >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  >>  >>  > On Sat, Apr 18, 2020 at 12:24 AM Paul Cercueil
>>  >>  >> <paul@crapouillou.net>
>>  >>  >>  > wrote:
>>  >>  >>  >>  Le sam. 18 avril 2020 =E0 0:10, Andy Shevchenko
>>  >>  >>  >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  >>  >>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
>>  >>  >>  >> <contact@artur-rojek.eu>
>>  >>  >>  >>  > wrote:
>>  >
>>  > ...
>>  >
>>  >>  >>  >>  >>  +#include <linux/of.h>
>>  >>  >>  >>  >
>>  >>  >>  >>  > Do you really need this? (See below as well)
>>  >>  >>  >
>>  >>  >>  >>  >>  +static const struct of_device_id
>>  >> adc_joystick_of_match[] =3D
>>  >>  >> {
>>  >>  >>  >>  >>  +       { .compatible =3D "adc-joystick", },
>>  >>  >>  >>  >>  +       { },
>>  >>  >>  >>  >>  +};
>>  >>  >>  >>  >>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
>>  >>  >>  >>  >>  +
>>  >>  >>  >>  >>  +static struct platform_driver adc_joystick_driver=20
>> =3D {
>>  >>  >>  >>  >>  +       .driver =3D {
>>  >>  >>  >>  >>  +               .name =3D "adc-joystick",
>>  >>  >>  >>  >
>>  >>  >>  >>  >>  +               .of_match_table =3D
>>  >>  >>  >>  >> of_match_ptr(adc_joystick_of_match),
>>  >>  >>  >>  >
>>  >>  >>  >>  > Drop this a bit harmful of_match_ptr() macro. It=20
>> should go
>>  >>  >> with
>>  >>  >>  >> ugly
>>  >>  >>  >>  > #ifdeffery. Here you simple introduced a compiler=20
>> warning.
>>  >>  >>  >>
>>  >>  >>  >>  I assume you mean #ifdef around the of_device_id +=20
>> module
>>  >> table
>>  >>  >>  >> macro?
>>  >>  >>  >
>>  >>  >>  > Yes.
>>  >>  >>  >
>>  >>  >>  >>  > On top of that, you are using device property API, OF=20
>> use
>>  >> in
>>  >>  >> this
>>  >>  >>  >> case
>>  >>  >>  >>  > is contradictory (at lest to some extend).
>>  >>  >>  >>
>>  >>  >>  >>  I don't see why. The fact that the driver can work when
>>  >> probed
>>  >>  >> from
>>  >>  >>  >>  platform code
>>  >>  >>  >
>>  >>  >>  > Ha-ha, tell me how. I would like to be very surprised.
>>  >>  >>
>>  >>  >>  iio_map_array_register(),
>>  >>  >>  pinctrl_register_mappings(),
>>  >>  >>  platform_add_devices(),
>>  >>  >>
>>  >>  >>  you're welcome.
>>  >>  >
>>  >>  > I think above has no relation to what I'm talking about.
>>  >>
>>  >>  Yes it does. It allows you to map the IIO channels, set the=20
>> pinctrl
>>  >>  configurations and register a device from platform code instead=20
>> of
>>  >>  devicetree.
>>  >
>>  > I'm not talking about other drivers, I'm talking about this=20
>> driver and
>>  > how it will be instantiated. Above, according to the code, can't=20
>> be
>>  > comprehensive to fulfill this.
>>=20
>>  This is how the platform devices were instanciated on JZ4740 before=20
>> we
>>  switched everything to devicetree.
>>=20
>>  >>  > How *this* driver can work as a platform instantiated one?
>>  >>  > We seems have a conceptual misunderstanding here.
>>  >>  >
>>  >>  > For example, how can probe of this driver not fail, if it is=20
>> not
>>  >>  > backed by a DT/ACPI properties?
>>  >>
>>  >>  platform_device_add_properties().
>>  >
>>  > Yes, I waited for this. And seems you don't understand the (scope=20
>> of)
>>  > API, you are trying to insist this driver can be used as a=20
>> platform
>>  > one.
>>  > Sorry, I must to disappoint you, it can't. Above interface is=20
>> created
>>  > solely for quirks to support (broken) DT/ACPI tables. It's not
>>  > supposed to be used as a main source for the device properties.
>>=20
>>  The fact that it was designed for something else doesn't mean it=20
>> can't
>>  be used.
>>=20
>>  Anyway, this discussion is pointless. I don't think anybody would=20
>> want
>>  to do that.
>>=20
>>  >>  >>  >>  doesn't mean that it shouldn't have a table to probe
>>  >>  >>  >>  from devicetree.
>>  >>  >>  >
>>  >>  >>  > I didn't get what you are talking about here. The idea of
>>  >>  >> _unified_
>>  >>  >>  > device property API is to get rid of OF-centric code in
>>  >> favour of
>>  >>  >> more
>>  >>  >>  > generic approach. Mixing those two can be done only in
>>  >> specific
>>  >>  >> cases
>>  >>  >>  > (here is not the one).
>>  >>  >>
>>  >>  >>  And how are we mixing those two here? The only OF-centric=20
>> thing
>>  >>  >> here is
>>  >>  >>  the device table, which is required if we want the driver to
>>  >> probe
>>  >>  >> from
>>  >>  >>  devicetree.
>>  >>  >
>>  >>  > Table is fine(JFYI the types and sections are defined outside=20
>> of
>>  >> OF
>>  >>  > stuff, though being [heavily] used by it) , API=20
>> (of_match_ptr()
>>  >> macro
>>  >>  > use) is not.
>>  >>
>>  >>  Sorry, but that's just stupid. Please have a look at how
>>  >> of_match_ptr()
>>  >>  macro is defined in <linux/of.h>.
>>  >
>>  > Call it whatever you want, but above code is broken.
>>=20
>>  of_match_ptr() is basically defined like this:
>>=20
>>  #ifdef CONFIG_OF
>>  #define of_match_ptr(x) (x)
>>  #else
>>  #define of_match_ptr(x) NULL
>>  #endif
>>=20
>>  So please, enlighten me, tell me what is so wrong about what's being
>>  done here.
>>=20
>>  > It needs either of:
>>  > - ugly ifdeffery
>>  > - dropping of_match_ptr()
>>  > - explicit dependence to OF
>>  >
>>  > My choice is second one. Because it makes code better and allows=20
>> also
>>  > ACPI to use this driver (usually) without changes.
>>=20
>>  And how is unconditionally compiling the of_match_table make it
>>  magically probe from ACPI, without a acpi_match_table?
>>=20
>>  -Paul
>=20
> Look up PRP0001 ACPI ID.  Magic trick ;)
>=20
> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumeration.ht=
ml?highlight=3DPRP0001
>=20
> It allows you to define an ACPI device in DSDT that is instantiated
> from what is effectively the DT binding including the id table.

So what you're saying, is that the OF table should be present, even=20
though CONFIG_OF is not set, just in case it is probed from ACPI?

-Paul


