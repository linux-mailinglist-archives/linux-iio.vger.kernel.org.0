Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA781DA32C
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgESVDI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 17:03:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52776 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESVDI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 17:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589922186; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYssrVu0EdXtQCut6RKI0Q/slktx5/swJ4iGM1S+aPM=;
        b=F4Aafco/wu2j6SCR/42PO2SWWsZNMwDACorK4ZocGNHgTHLYesolX8x3ADsIjVRcCaeZJw
        a5yXWDDmGEllGmsRIvWGFO92zvZOSpoomh8E/dyp8fSIQ3b84t/y6Kfg9TX/LNQX+pRKwZ
        oPY9+Afv3CTrx52VuqQ3M+tOmXGy35o=
Date:   Tue, 19 May 2020 23:02:54 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v7 7/7] input: joystick: Add ADC attached joystick driver.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <USJLAQ.SNMLIAX3CX1J2@crapouillou.net>
In-Reply-To: <CAHp75VcChHOrxrqBM==-_SaTL4vSojKmRWvkNn-CHLH99pcAuQ@mail.gmail.com>
References: <20200517194904.34758-1-contact@artur-rojek.eu>
        <20200517194904.34758-7-contact@artur-rojek.eu>
        <CAHp75VcChHOrxrqBM==-_SaTL4vSojKmRWvkNn-CHLH99pcAuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Le mar. 19 mai 2020 =E0 23:43, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Sun, May 17, 2020 at 10:49 PM Artur Rojek <contact@artur-rojek.eu>=20
> wrote:
>>=20
>>  Add a driver for joystick devices connected to ADC controllers
>>  supporting the Industrial I/O subsystem.
>=20
> ...
>=20
>>  +static int adc_joystick_handle(const void *data, void *private)
>>  +{
>>  +       struct adc_joystick *joy =3D private;
>>  +       enum iio_endian endianness;
>>  +       int bytes, msb, val, i;
>>  +       bool sign;
>>  +
>>  +       bytes =3D joy->chans[0].channel->scan_type.storagebits >> 3;
>>  +
>>  +       for (i =3D 0; i < joy->num_chans; ++i) {
>>  +               endianness =3D=20
>> joy->chans[i].channel->scan_type.endianness;
>>  +               msb =3D joy->chans[i].channel->scan_type.realbits - 1;
>=20
>>  +               sign =3D=20
>> (tolower(joy->chans[i].channel->scan_type.sign) =3D=3D 's');
>=20
> Do we need tolower()?

I'll answer this one:

The sign can be uppercase to specify that the value is sign-extended in=20
all the storage bits.

-Paul

>>  +
>>  +               switch (bytes) {
>>  +               case 1:
>>  +                       val =3D ((const u8 *)data)[i];
>>  +                       break;
>>  +               case 2:
>>  +                       if (endianness =3D=3D IIO_BE)
>=20
>>  +                               val =3D be16_to_cpu(((const u16=20
>> *)data)[i]);
>=20
> Yeah, you have to provide bitwise types to satisfy sparse.
> Maybe using *_to_cpup() will cure this.
>=20
>>  +                       else if (endianness =3D=3D IIO_LE)
>>  +                               val =3D le16_to_cpu(((const u16=20
>> *)data)[i]);
>>  +                       else /* IIO_CPU */
>>  +                               val =3D ((const u16 *)data)[i];
>>  +                       break;
>>  +               default:
>>  +                       return -EINVAL;
>>  +               }
>>  +
>>  +               val >>=3D joy->chans[i].channel->scan_type.shift;
>>  +               if (sign)
>>  +                       val =3D sign_extend32(val, msb);
>>  +               else
>>  +                       val &=3D GENMASK(msb, 0);
>>  +               input_report_abs(joy->input, joy->axes[i].code,=20
>> val);
>>  +       }
>>  +
>>  +       input_sync(joy->input);
>>  +
>>  +       return 0;
>>  +}
>=20
> ...
>=20
>>  +       /* Count how many channels we got. NULL terminated. */
>>  +       while (joy->chans[joy->num_chans].indio_dev)
>>  +               joy->num_chans++;
>=20
> I don't see how useful this is. Why not simple do below...
>=20
>>  +       bits =3D joy->chans[0].channel->scan_type.storagebits;
>>  +       if (!bits || (bits > 16)) {
>>  +               dev_err(dev, "Unsupported channel storage size");
>>  +               return -EINVAL;
>>  +       }
>>  +       for (i =3D 1; i < joy->num_chans; ++i)
>>  +               if (joy->chans[i].channel->scan_type.storagebits !=3D=20
>> bits) {
>>  +                       dev_err(dev, "Channels must have equal=20
>> storage size");
>>  +                       return -EINVAL;
>>  +               }
>=20
> ...something like
>=20
>   for (i =3D 0; joy->chans[i].indio_dev; i++) {
>     bits =3D joy->chans[i].channel->scan_type.storagebits;
>     if (bits ...) {
>       ...error handling...
>     }
>     if (bits !=3D joy->chans[0].channel->scan_type.storagebits) {
>       ...second level of error handling...
>     }
>  }
>=20
> ...
>=20
>>  +static const struct of_device_id adc_joystick_of_match[] =3D {
>>  +       { .compatible =3D "adc-joystick", },
>=20
>>  +       { },
>=20
> No need comma.
>=20
>>  +};
>=20
> --
> With Best Regards,
> Andy Shevchenko


