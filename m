Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE11AEC50
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgDRMK1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 08:10:27 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60176 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgDRMK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 08:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587211824; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8uyfORoWpoopNQAQRiFt0F12jT9ut5sphQKhCFCQnI=;
        b=GnQ9Xu4NTvPUquR8iR0VIKLtACsC6IM+aIypTrEzV5CVG1YA9XS7UYVNec1wHO8ZKdcTBK
        9jiuRA7KEcZet3Im5oH5sODW8CWKMPTHaQfOuCf/FqwNTQNly/9hTNGk47WsflgImO0Ob/
        xS7TkvnoGiiaz2OKA8kw9JfZek7dLyk=
Date:   Sat, 18 Apr 2020 14:10:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH v5 5/5] input: joystick: Add ADC attached joystick
 driver.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Message-Id: <0HGZ8Q.TO6FK92GVGIN3@crapouillou.net>
In-Reply-To: <CAHp75VeVvE8LAO8f=-cwfgL6erFZACGwMnriNRaQnfnHw31wkg@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-5-contact@artur-rojek.eu>
        <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
        <UFBY8Q.ES4D59V22INC1@crapouillou.net>
        <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
        <7CFY8Q.68YMS0V08F992@crapouillou.net>
        <CAHp75VeVvE8LAO8f=-cwfgL6erFZACGwMnriNRaQnfnHw31wkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le sam. 18 avril 2020 =E0 14:57, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Sat, Apr 18, 2020 at 1:48 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>=20
>>=20
>>  Le sam. 18 avril 2020 =E0 0:49, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > On Sat, Apr 18, 2020 at 12:24 AM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > wrote:
>>  >>  Le sam. 18 avril 2020 =E0 0:10, Andy Shevchenko
>>  >>  <andy.shevchenko@gmail.com> a =E9crit :
>>  >>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek
>>  >> <contact@artur-rojek.eu>
>>  >>  > wrote:
>>  >
>>  > ...
>>  >
>>  >>  >>  +#include <linux/of.h>
>>  >>  >
>>  >>  > Do you really need this? (See below as well)
>>  >
>>  >>  >>  +static const struct of_device_id adc_joystick_of_match[] =3D=20
>> {
>>  >>  >>  +       { .compatible =3D "adc-joystick", },
>>  >>  >>  +       { },
>>  >>  >>  +};
>>  >>  >>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
>>  >>  >>  +
>>  >>  >>  +static struct platform_driver adc_joystick_driver =3D {
>>  >>  >>  +       .driver =3D {
>>  >>  >>  +               .name =3D "adc-joystick",
>>  >>  >
>>  >>  >>  +               .of_match_table =3D
>>  >>  >> of_match_ptr(adc_joystick_of_match),
>>  >>  >
>>  >>  > Drop this a bit harmful of_match_ptr() macro. It should go=20
>> with
>>  >> ugly
>>  >>  > #ifdeffery. Here you simple introduced a compiler warning.
>>  >>
>>  >>  I assume you mean #ifdef around the of_device_id + module table
>>  >> macro?
>>  >
>>  > Yes.
>>  >
>>  >>  > On top of that, you are using device property API, OF use in=20
>> this
>>  >> case
>>  >>  > is contradictory (at lest to some extend).
>>  >>
>>  >>  I don't see why. The fact that the driver can work when probed=20
>> from
>>  >>  platform code
>>  >
>>  > Ha-ha, tell me how. I would like to be very surprised.
>>=20
>>  iio_map_array_register(),
>>  pinctrl_register_mappings(),
>>  platform_add_devices(),
>>=20
>>  you're welcome.
>=20
> I think above has no relation to what I'm talking about.

Yes it does. It allows you to map the IIO channels, set the pinctrl=20
configurations and register a device from platform code instead of=20
devicetree.

> How *this* driver can work as a platform instantiated one?
> We seems have a conceptual misunderstanding here.
>=20
> For example, how can probe of this driver not fail, if it is not
> backed by a DT/ACPI properties?

platform_device_add_properties().

>=20
>>  >>  doesn't mean that it shouldn't have a table to probe
>>  >>  from devicetree.
>>  >
>>  > I didn't get what you are talking about here. The idea of=20
>> _unified_
>>  > device property API is to get rid of OF-centric code in favour of=20
>> more
>>  > generic approach. Mixing those two can be done only in specific=20
>> cases
>>  > (here is not the one).
>>=20
>>  And how are we mixing those two here? The only OF-centric thing=20
>> here is
>>  the device table, which is required if we want the driver to probe=20
>> from
>>  devicetree.
>=20
> Table is fine(JFYI the types and sections are defined outside of OF
> stuff, though being [heavily] used by it) , API (of_match_ptr() macro
> use) is not.

Sorry, but that's just stupid. Please have a look at how of_match_ptr()=20
macro is defined in <linux/of.h>.

-Paul


