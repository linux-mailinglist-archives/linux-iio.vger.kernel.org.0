Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F461AE720
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDQVFF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:05:05 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49538 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgDQVFE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587157502; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwwZLSGVJur6LaUyd5egp9oHyObYEUxgSPJSaKMnHDs=;
        b=of25Kvc4pVxp/KwaBZNmu03Ftp1b0TRe3KlXFFsYvbjO8e6K3BO7lR0mMCttX7Hf+OGRv+
        dLV9xBGI2nk4F724zfcDJqTVqkQ0mHbEiqCbMEY4N5zmg0ge/seJMmsX7A1MuKU0Byfemm
        rExSBUKULDJWJdpjIxauV5jnAdqDaQs=
Date:   Fri, 17 Apr 2020 23:04:51 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
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
Message-Id: <3KAY8Q.NNI6X4F9QRIX1@crapouillou.net>
In-Reply-To: <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
        <20200417202859.35427-3-contact@artur-rojek.eu>
        <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Le ven. 17 avril 2020 =E0 23:59, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek <contact@artur-rojek.eu>=20
> wrote:
>>=20
>>  The SADC component in JZ47xx SoCs provides support for touchscreen
>>  operations (pen position and pen down pressure) in single-ended and
>>  differential modes.
>>=20
>>  Of the known hardware to use this controller, GCW Zero and Anbernic=20
>> RG-350
>>  utilize the touchscreen mode by having their joystick(s) attached=20
>> to the
>>  X/Y positive/negative input pins.
>>  GCW Zero comes with a single joystick and is sufficiently handled=20
>> with the
>>  currently implemented single-ended mode. Support for boards with two
>>  joysticks, where one is hooked up to Xn/Yn and the other to Xp/Yp=20
>> channels
>>  will need to be provided in the future.
>>=20
>>  The touchscreen component of SADC takes a significant time to=20
>> stabilize
>>  after first receiving the clock and a delay of 50ms has been=20
>> empirically
>>  proven to be a safe value before data sampling can begin.
>>=20
>>  All the boards which probe this driver have the interrupt provided=20
>> from
>>  devicetree, with no need to handle a case where the irq was not=20
>> provided.
>=20
> Device Tree
> IRQ
>=20
> ...
>=20
>>  +               .scan_type =3D {
>>  +                       .sign =3D 'u',
>>  +                       .realbits =3D 12,
>=20
>>  +                       .storagebits =3D 16
>=20
> It's slightly better to leave comma in such cases.
>=20
>>  +               },
>=20
>>  +               .scan_type =3D {
>>  +                       .sign =3D 'u',
>>  +                       .realbits =3D 12,
>=20
>>  +                       .storagebits =3D 16
>=20
> Ditto.
>=20
>>  +               },
>=20
> ...
>=20
>>                  .indexed =3D 1,
>>                  .channel =3D INGENIC_ADC_AUX,
>>  +               .scan_index =3D -1
>=20
> Ditto. You see above? Isn't it nice that you didn't touch that line?
> So, perhaps next developer can leverage this subtle kind of things.
>=20
>>                  .indexed =3D 1,
>>                  .channel =3D INGENIC_ADC_BATTERY,
>>  +               .scan_index =3D -1
>=20
> Ditto.
>=20
>>                  .indexed =3D 1,
>>                  .channel =3D INGENIC_ADC_AUX2,
>>  +               .scan_index =3D -1
>=20
> Ditto.
>=20
> ...
>=20
>>  +static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
>>  +{
>>  +       struct ingenic_adc *adc =3D iio_priv(iio_dev);
>>  +
>=20
>>  +       clk_enable(adc->clk);
>=20
> Error check?
>=20
>>  +       /* It takes significant time for the touchscreen hw to=20
>> stabilize. */
>>  +       msleep(50);
>>  +       ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK,
>>  +                              JZ_ADC_REG_CFG_SAMPLE_NUM(4) |
>>  +                              JZ_ADC_REG_CFG_PULL_UP(4));
>>  +       writew(80, adc->base + JZ_ADC_REG_ADWAIT);
>>  +       writew(2, adc->base + JZ_ADC_REG_ADSAME);
>=20
>>  +       writeb((u8)~JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_CTRL);
>=20
> Why casting?
>=20
>>  +       writel(0, adc->base + JZ_ADC_REG_ADTCH);
>>  +       ingenic_adc_enable(adc, 2, true);
>>  +
>>  +       return 0;
>>  +}
>=20
>>  +       irq =3D platform_get_irq(pdev, 0);
>=20
> Before it worked w/o IRQ, here is a regression you introduced.

Before it simply did not need the IRQ, which is provided by the=20
devicetree anyway. No regression here.

-Paul

>=20
>>  +       if (irq < 0) {
>=20
>>  +               dev_err(dev, "Failed to get irq: %d\n", irq);
>=20
> Redundant message.
>=20
>>  +               return irq;
>>  +       }
>=20
> --
> With Best Regards,
> Andy Shevchenko


