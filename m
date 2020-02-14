Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9425215D866
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 14:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBNN1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 08:27:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNN1r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 08:27:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426112187F;
        Fri, 14 Feb 2020 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581686866;
        bh=q7zFLlgCZclM5sFYyA8KYNBUblqhp1Y3AD1Zg/QPYdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VLS0Cbos9+4kdlBWQS6nAdOHRU2ZoU1MG0Qv/VP0IE56CaXsjFzHGxFIb6FERzIPp
         xqnGM5PUv9129QP5CgNXeYcNpmfbfwJAZEFjXX60lHPccySOauErEmR5kErldoBaix
         sSKRXesuDsIFC2Igeoe25Pcg4QWsFaGSBsFNQ1fk=
Date:   Fri, 14 Feb 2020 13:27:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: chemical: atlas-sensor: allow probe without
 interrupt line
Message-ID: <20200214132743.04d6d12d@archlinux>
In-Reply-To: <09D15D9D-2EBD-4BFF-A5BA-FA0B25F0E750@konsulko.com>
References: <20200208163943.098ba614@archlinux>
        <09D15D9D-2EBD-4BFF-A5BA-FA0B25F0E750@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 8 Feb 2020 18:12:03 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> > On Feb 8, 2020, at 08:39, Jonathan Cameron <jic23@kernel.org> wrote:
> >=20
> > =EF=BB=BFOn Wed,  5 Feb 2020 22:13:30 -0800
> > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> >  =20
> >> Sensors don't actually need a interrupt line to give valid readings,
> >> and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
> >> the required check for interrupt, and continue along in the probe
> >> function. =20
> >=20
> > Basic aim is good, but if you don't have an interrupt doesn't make
> > sense to register the trigger either.
> >=20
> > The interrupt enable / disable is also tied up with the buffer whereas
> > it should probably be done via the trigger enable callback or am I
> > missing something? =20
> =20
> It was for allowing sysfs and hrtimer triggers. But just remembered most =
these sensors have a low refresh rate. I can go either way on having it or =
not. Thoughts?
I'm a bit confused.   With sysfs and hrtimer triggers why would we
need the interrupt enabled?  As things stand it will be as it's done
in the buffer setup.  I was suggesting moving it to the trigger
setup so we only deal with the interrupt if we are actually using
the data ready trigger.

So move it the atlas_set_interrupt call from pre / post enable to
the trigger state callback.

Jonathan
>=20
> - Matt
>=20
>=20
> >=20
> > Jonathan
> >  =20
> >>=20
> >> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> >> ---
> >> drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
> >> 1 file changed, 12 insertions(+), 15 deletions(-)
> >>=20
> >> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemica=
l/atlas-sensor.c
> >> index 2f0a6fed2589..2e34c82cb65d 100644
> >> --- a/drivers/iio/chemical/atlas-sensor.c
> >> +++ b/drivers/iio/chemical/atlas-sensor.c
> >> @@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
> >>    if (ret)
> >>        return ret;
> >>=20
> >> -    if (client->irq <=3D 0) {
> >> -        dev_err(&client->dev, "no valid irq defined\n");
> >> -        return -EINVAL;
> >> -    }
> >> -
> >>    ret =3D chip->calibration(data);
> >>    if (ret)
> >>        return ret;
> >> @@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
> >>=20
> >>    init_irq_work(&data->work, atlas_work_handler);
> >>=20
> >> -    /* interrupt pin toggles on new conversion */
> >> -    ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> >> -                    NULL, atlas_interrupt_handler,
> >> -                    IRQF_TRIGGER_RISING |
> >> -                    IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >> -                    "atlas_irq",
> >> -                    indio_dev);
> >> -    if (ret) {
> >> -        dev_err(&client->dev, "request irq (%d) failed\n", client->ir=
q);
> >> -        goto unregister_buffer;
> >> +    if (client->irq <=3D 0) {
> >> +        /* interrupt pin toggles on new conversion */
> >> +        ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> >> +                NULL, atlas_interrupt_handler,
> >> +                IRQF_TRIGGER_RISING |
> >> +                IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >> +                "atlas_irq",
> >> +                indio_dev);
> >> +
> >> +        if (ret)
> >> +            dev_warn(&client->dev,
> >> +                "request irq (%d) failed\n", client->irq);
> >>    }
> >>=20
> >>    ret =3D atlas_set_powermode(data, 1); =20
> >  =20

