Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFD51AE865
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 00:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgDQWsX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 18:48:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45918 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgDQWsX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 18:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587163700; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnplkmtOlg6aQqRCemm0gncKeNcs1kJkULgCp1NFj8E=;
        b=KYbtDyHW2xDF6OLyMVpHR10Oag/ONw+OglyvIRFt/kuSblQQMcP2nlwdF6bkil3V0JDzLX
        ESBoxn9n5e/VmVDypGgtv244VnvAgS5G3LCDC/Lh1yOL76sviZpFuRfBB1MnlYvocjwVYC
        /cErR2JFf+OjWI9xIBlN+ZVlnOQ5DS4=
Date:   Sat, 18 Apr 2020 00:48:07 +0200
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
Message-Id: <7CFY8Q.68YMS0V08F992@crapouillou.net>
In-Reply-To: <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-5-contact@artur-rojek.eu>
        <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
        <UFBY8Q.ES4D59V22INC1@crapouillou.net>
        <CAHp75VfEAtqucMPdkygfBhojTJoHO5vFk_o0suiyf7i2JCMw9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le sam. 18 avril 2020 =E0 0:49, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Sat, Apr 18, 2020 at 12:24 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>  Le sam. 18 avril 2020 =E0 0:10, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek=20
>> <contact@artur-rojek.eu>
>>  > wrote:
>=20
> ...
>=20
>>  >>  +#include <linux/of.h>
>>  >
>>  > Do you really need this? (See below as well)
>=20
>>  >>  +static const struct of_device_id adc_joystick_of_match[] =3D {
>>  >>  +       { .compatible =3D "adc-joystick", },
>>  >>  +       { },
>>  >>  +};
>>  >>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
>>  >>  +
>>  >>  +static struct platform_driver adc_joystick_driver =3D {
>>  >>  +       .driver =3D {
>>  >>  +               .name =3D "adc-joystick",
>>  >
>>  >>  +               .of_match_table =3D
>>  >> of_match_ptr(adc_joystick_of_match),
>>  >
>>  > Drop this a bit harmful of_match_ptr() macro. It should go with=20
>> ugly
>>  > #ifdeffery. Here you simple introduced a compiler warning.
>>=20
>>  I assume you mean #ifdef around the of_device_id + module table=20
>> macro?
>=20
> Yes.
>=20
>>  > On top of that, you are using device property API, OF use in this=20
>> case
>>  > is contradictory (at lest to some extend).
>>=20
>>  I don't see why. The fact that the driver can work when probed from
>>  platform code
>=20
> Ha-ha, tell me how. I would like to be very surprised.

iio_map_array_register(),
pinctrl_register_mappings(),
platform_add_devices(),

you're welcome.

>>  doesn't mean that it shouldn't have a table to probe
>>  from devicetree.
>=20
> I didn't get what you are talking about here. The idea of _unified_
> device property API is to get rid of OF-centric code in favour of more
> generic approach. Mixing those two can be done only in specific cases
> (here is not the one).

And how are we mixing those two here? The only OF-centric thing here is=20
the device table, which is required if we want the driver to probe from=20
devicetree.

-Paul

>=20
> --
> With Best Regards,
> Andy Shevchenko


