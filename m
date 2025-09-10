Return-Path: <linux-iio+bounces-23928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B9B514B6
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 13:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3468A7A6641
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F96270568;
	Wed, 10 Sep 2025 11:02:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2A18FC97;
	Wed, 10 Sep 2025 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502172; cv=none; b=qRqOc+0uFdB1VfhOVov8ykvrMEMc1sb/FzgM2Nj9DyGVIxcFOUNo/CItLBcb4sanW/RozoZbhh1UnaJP9nnnbAxKnAUYVpL/piACmnGMuoXz4I5Vji7tsGjDThbXrb9ZjaTulKQ3iHust3WLeVZoyibgJwi1cOqdgFtGfWYBgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502172; c=relaxed/simple;
	bh=c7k/zFpzngO3aqcF545jov8y2kcnfuYLbJz9COdjuwk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSyldC/UExIbcgn3iuHdJybKUenlzeywdGh5WnwcV7BcEW0FPplUSf7Th7K93LLHaqGXZiiH1vWiODuWs++GzImeQvH45QskOamdh6FAkGglJQcHpyinPTGOcdxHkljM0mEi4lnXSyuLoD6TQtg33GS5yYkpfIyGlzoFt3Nsg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMHnC3kDRz6L5V1;
	Wed, 10 Sep 2025 19:01:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1C4F1400C8;
	Wed, 10 Sep 2025 19:02:47 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 13:02:47 +0200
Date: Wed, 10 Sep 2025 12:02:45 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Akshay Jindal <akshayaj.lkd@gmail.com>, <anshulusr@gmail.com>,
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <shuah@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250910120245.000033e8@huawei.com>
In-Reply-To: <CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
	<CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 10:17:00 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Sep 9, 2025 at 10:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> >
> > Implement runtime power management for the LTR390 sensor. The device
> > autosuspends after 1s of idle time, reducing current consumption from
> > 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the data=
sheet.
> >
> > Ensure that interrupts continue to be delivered with runtime PM.
> > Since the LTR390 cannot be used as a wakeup source during runtime
> > suspend, therefore increment the runtime PM refcount when enabling
> > events and decrement it when disabling events or powering down.
> > This prevents event loss while still allowing power savings when IRQs
> > are unused. =20
>=20
> ...
>=20
> > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > +                          struct iio_chan_spec const *chan, int *val,
> > +                          int *val2, long mask) =20
>=20
> Isn't the mask unsigned long? Jonathan, do we get this fixed already?

Whilst it could (and probably should) be unsigned, it's not actually a mask.
That naming is a historical mess up / evolution thing - long ago it was a b=
itmap.
It is now the index of a bit in the mask.  So this is unrelated(ish) to the
recent fixes around the actual bitmaps/bitmasks.

Changing this one is a lot more painful than the recent fix to the infomask
as it means changing the signature in every driver.
I'm doubtful on whether this one is worth the churn.

>=20
> Also logical split might be better, i.e. putting val and val2 on the
> same line. Then mask will be on the next one
>=20
> ...
>=20
> >  static void ltr390_powerdown(void *priv)
> >  {
> >         struct ltr390_data *data =3D priv;
> > +       struct device *dev =3D &data->client->dev;
> > +       int ret;
> >
> >         guard(mutex)(&data->lock);
> >
> >         /* Ensure that power off and interrupts are disabled */
> > -       if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > -                               LTR390_LS_INT_EN) < 0)
> > -               dev_err(&data->client->dev, "failed to disable interrup=
ts\n");
> > +       if (data->irq_enabled) {
> > +               ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CFG,=
 LTR390_LS_INT_EN);
> > +               if (ret < 0)
> > +                       dev_err(dev, "failed to disable interrupts\n");=
 =20
>=20
> In event_config we assure that IRQ is enabled.
>=20
> > +               data->irq_enabled =3D false; =20
>=20
> Here we may lie about the facts. What will the driver do, if the IRQ
> is triggered just before this line?
>=20
> > +               pm_runtime_put_autosuspend(&data->client->dev); =20
>=20
> You have dev, use it.
>=20
> But where is the symmetrical pm_runtime_get*()?
>=20
> > +       }
> > +
> > +       ret =3D regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR39=
0_SENSOR_ENABLE);
> > +       if (ret < 0)
> > +               dev_err(dev, "failed to disable sensor\n");
> > +} =20
>=20
>=20


