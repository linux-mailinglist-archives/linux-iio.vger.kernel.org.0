Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E180C1AE783
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgDQVYK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:24:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36796 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDQVYJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587158647; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WccMFp68EcyAjhnWK/SjfcUdqGevziF5O9dUK1eEzlQ=;
        b=rC9lFw3KxDac/HzVkuO4Xp5GHw2P36PAJvhmT8SvYFcSxpbGdyJR9appFMoVeRieN3htVa
        +8Aa42oVc1T8A/wV4nPoHkHACAc1LHnqfbyVmEmAF7tacR37/5ztZqV+/epmIzxgqrffpd
        HgfFpjo4/1f9td3khMaNjj1K/HO176g=
Date:   Fri, 17 Apr 2020 23:23:54 +0200
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
Message-Id: <UFBY8Q.ES4D59V22INC1@crapouillou.net>
In-Reply-To: <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-5-contact@artur-rojek.eu>
        <CAHp75VfRbnnuUhfyXpu+5dp4TutHSrHus=sX_vG_5F0dX4k0fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Le sam. 18 avril 2020 =E0 0:10, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek <contact@artur-rojek.eu>=20
> wrote:
>>=20
>>  Add a driver for joystick devices connected to ADC controllers
>>  supporting the Industrial I/O subsystem.
>=20
> ...
>=20
>>  +#include <linux/of.h>
>=20
> Do you really need this? (See below as well)
>=20
> ...
>=20
>>  +               sign =3D=20
>> (tolower(joy->chans[i].channel->scan_type.sign) =3D=3D 's');
>=20
> Too many parentheses. But here it's up to you,
>=20
> ...
>=20
>>  +               case 2:
>=20
>>  +                       val =3D ((const u16 *)data)[i];
>=20
> Can't you do this in each branch below?
>=20
>>  +                       if (endianness =3D=3D IIO_BE)
>>  +                               val =3D be16_to_cpu(val);
>>  +                       else if (endianness =3D=3D IIO_LE)
>>  +                               val =3D le16_to_cpu(val);
>>  +                       break;
>=20
> ...
>=20
>>  +       device_for_each_child_node(dev, child) {
>>  +               ret =3D fwnode_property_read_u32(child, "reg", &i);
>>  +               if (ret || i >=3D num_axes) {
>>  +                       dev_err(dev, "reg invalid or missing");
>>  +                       goto err;
>>  +               }
>>  +
>>  +               if (fwnode_property_read_u32(child, "linux,code",
>>  +                                            &axes[i].code)) {
>>  +                       dev_err(dev, "linux,code invalid or=20
>> missing");
>>  +                       goto err;
>>  +               }
>>  +
>>  +               if (fwnode_property_read_u32_array(child,=20
>> "abs-range",
>>  +                                                  axes[i].range,=20
>> 2)) {
>>  +                       dev_err(dev, "abs-range invalid or=20
>> missing");
>>  +                       goto err;
>>  +               }
>=20
>>  +       }
>>  +
>>  +       joy->axes =3D axes;
>>  +
>>  +       return 0;
>>  +
>>  +err:
>>  +       fwnode_handle_put(child);
>=20
>>  +       return -EINVAL;
>=20
> Can we avoid shadowing the actual error code?
>=20
> ...
>=20
>>  +       bits =3D joy->chans[0].channel->scan_type.storagebits;
>=20
>>  +       if (!bits || (bits >> 3) > 2) {
>=20
> Wouldn't be clear to use simple 'bits > 16'?
>=20
>>  +               dev_err(dev, "Unsupported channel storage size");
>>  +               return -EINVAL;
>>  +       }
>=20
> ...
>=20
>>  +static const struct of_device_id adc_joystick_of_match[] =3D {
>>  +       { .compatible =3D "adc-joystick", },
>>  +       { },
>>  +};
>>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
>>  +
>>  +static struct platform_driver adc_joystick_driver =3D {
>>  +       .driver =3D {
>>  +               .name =3D "adc-joystick",
>=20
>>  +               .of_match_table =3D=20
>> of_match_ptr(adc_joystick_of_match),
>=20
> Drop this a bit harmful of_match_ptr() macro. It should go with ugly
> #ifdeffery. Here you simple introduced a compiler warning.

I assume you mean #ifdef around the of_device_id + module table macro?

> On top of that, you are using device property API, OF use in this case
> is contradictory (at lest to some extend).

I don't see why. The fact that the driver can work when probed from=20
platform code, doesn't mean that it shouldn't have a table to probe=20
from devicetree.

-Paul

>=20
>>  +       },
>>  +       .probe =3D adc_joystick_probe,
>>  +};
>=20
> --
> With Best Regards,
> Andy Shevchenko


