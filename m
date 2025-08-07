Return-Path: <linux-iio+bounces-22400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDFB1D881
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 15:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540303A2FBB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C424728B;
	Thu,  7 Aug 2025 13:04:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40216F8E9;
	Thu,  7 Aug 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571851; cv=none; b=KkHzSJq8KhvZxhT/21qtmLwH0y0HpxKUS5nW3NMHawoWocB0+lp95vCMVZl1+QowBsX0YPnYFLgaviA6iY0PlAwNslRxTeS9PYF44InayqzZFGslJ+wBNFz3ecuIMXEhtoO4ILjudf15I+BO9R6VnLTQSFDsndVSAkEqLUWN5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571851; c=relaxed/simple;
	bh=SZx3WWRlETC/lMz7nxxWiqYKZY8aVdRs1qOUlWxwmU0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFHUp0dz4RmVhIe36dp5adSuKwp6fW1rk+j/fNjEaHUFmgGjiwRhNFAHhVDmzS69/Z9WGHmSTNxhCskSAuWbqHwuhsWM4AN4oFr7M0SrTob7lzyNkg4c4yL8dNgT5LoXaHhpDnsfHufVhAVdZtWcAlENyj3g2GLxoOCJnfqrPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4byS3V2js7z6L53t;
	Thu,  7 Aug 2025 21:01:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 18EF5140121;
	Thu,  7 Aug 2025 21:04:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Aug
 2025 15:04:03 +0200
Date: Thu, 7 Aug 2025 14:04:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>, Akshay Jindal
	<akshayaj.lkd@gmail.com>, <anshulusr@gmail.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<shuah@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
Message-ID: <20250807140401.00006c85@huawei.com>
In-Reply-To: <aJO05BNi2TsYtdwe@smile.fi.intel.com>
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
	<CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
	<CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
	<CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
	<20250806161801.000061c0@huawei.com>
	<aJO05BNi2TsYtdwe@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 6 Aug 2025 23:02:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 06, 2025 at 04:18:01PM +0100, Jonathan Cameron wrote:
> > On Tue, 5 Aug 2025 14:47:32 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > On Tue, Aug 5, 2025 at 6:05=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gm=
ail.com> wrote: =20
> > > > On Tue, Aug 5, 2025 at 2:36=E2=80=AFAM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:   =20
>=20
> ...
>=20
> > > > > Doesn't sound right to me. HAve you investigated PM runtime paths=
?   =20
> > > > Yes I did investigate and found that PM runtime->suspend() callback
> > > > co-exists with remove callback.
> > > >   =20
> > > > > Looking at what the code you added there it sounds to me like a p=
art
> > > > > of PM runtime ->suspend() callback.   =20
> > > > Yes, part of functionality will always be common, because both the
> > > > callback implementations put
> > > > the device into powered down or low power state which is what has b=
een done here
> > > > Both _suspend() and remove are called at different times in the lif=
ecycle of the
> > > > driver, but with respect to register setting, they put the device i=
nto
> > > > power down state.   =20
> > >=20
> > > Are you sure about the remove stage and how it interacts with runtime
> > > PM? Please, check how the device driver core manages PM on the remove
> > > stage.
> > >  =20
> > > > Additionally .remove() can have code for:
> > > > 1. disable runtime power management (if enabled while device regist=
ration).   =20
> > >=20
> > > If the device core enables it for you, it will disable it
> > > symmetrically. I don't see the issue here, it should be done
> > > automatically. If you do that explicitly, use the respective
> > > devm_pm_runtime_*() call.
> > >  =20
> > > > 2. device cleanup (disabling interrupt and cleaning up other config=
s done).   =20
> > >=20
> > > Wrap them into devm if required.
> > >  =20
> > > > 2. unregister the device.   =20
> > >=20
> > > Already done in the original code which your patch reverts, why?
> > >  =20
> > > > For eg: another light sensor bh1750
> > > > static void bh1750_remove(struct i2c_client *client)
> > > > {
> > > >     iio_device_unregister(indio_dev);
> > > >     mutex_lock(&data->lock);
> > > >     i2c_smbus_write_byte(client, BH1750_POWER_DOWN);
> > > >     mutex_unlock(&data->lock);
> > > > }
> > > >
> > > > static int bh1750_suspend(struct device *dev)
> > > > {
> > > >     mutex_lock(&data->lock);
> > > >     ret =3D i2c_smbus_write_byte(data->client, BH1750_POWER_DOWN);
> > > >     mutex_unlock(&data->lock);
> > > >     return ret;
> > > > }   =20
> > >=20
> > > Correct and where do you see the problem here? Perhaps the problem is
> > > in the cleanup aordering and some other bugs vs. devm calls?
> > >  =20
> > > > In drivers/iio/light, you can find similar examples in pa12203001,
> > > > rpr0521, apds9960,
> > > > vcnl4000, isl29028, vcnl4035. You can find many more examples in
> > > > sensors other than light sensors.   =20
> > >=20
> > > Good, should all they need to be fixed? =20
> >=20
> > The complex corners that occur with devm + runtime pm are around
> > things that we must not run if we are already in runtime suspend.
> > Typically disabling power supplies (as we can underflow counters
> > and getting warning prints).  Seeing as this driver is not
> > doing that it should be simple to use a devm_add_action_or_reset()
> >=20
> > Key thing to consider is that runtime pm may not be built. =20
>=20
> This will mean that user does not want to handle PM at all at runtime, so=
 why
> should it be our problem? If device is off, it's not the problem of the d=
river
> to do the power cycle at run time (yes, this might not apply to the system
> suspend and resume cases, which has to be implemented as well).
>=20
> > So the flow should work with those calls doing nothing.  That means that
> > if you turn the device on in probe we should make sure to explicitly tu=
rn
> > it off in the remove flow. That's where devm_add_action_or_reset()
> > comes in handy. =20
>=20
> I don't think we should do that explicitly in remove. As I pointed out ab=
ove,
> this the case that driver should not override.  Otherwise there is no poi=
nt in
> having the common runtime PM. User deliberately makes it not compiled, so=
 they
> should prepare to leave with it.

Hmm. I don't agree. We turned it on so on error or remove I think we
should turn it off again.  We do that in many drivers that never made use of
any of the standard PM stuff because they only touch enable and disable in
probe and remove.  If nothing else I don't like the lack of balance between
probe and remove if we don't do it.

Jonathan

>=20
> > ret =3D regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_E=
NABLE);
> > Is the paired operation with the second disable you add in remove.
> > Wrap that in a devm callback.
> >=20
> > More complex is the interrupt enable as that doesn't pair with
> > anything in particular in probe. I'm curious though, do we need
> > to disable it given the next operation turns off the sensor and on
> > probe we reset the sensor.
> >=20
> > Is just clearing the enable bit enough?  =20
>=20


