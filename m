Return-Path: <linux-iio+bounces-22504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5DBB1F617
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 21:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CF63B4655
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D7279DA6;
	Sat,  9 Aug 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J63j9qjp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655D1AE877;
	Sat,  9 Aug 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754769466; cv=none; b=RON7v1pirKPL9imD+8nxTXIaKmaDsit7xfaBPTPEbVcIZWju/L6gzjBMZelHMWAbJGeOT+XbbC88ZLaXxfZ20CKE6nri0ocMsAtx6KGGa2PHDdtzk12ZQeziz5DMHQTq8ZyDSc10XKVEH3hJH2hSbnZZeSqypdFxxR/BdtdJ/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754769466; c=relaxed/simple;
	bh=1C4UOcUOwx2TNs+xWMHz0OPNegRcKQh5SFRI/zNpp7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npwDzvPHTLSzXlwjFsQD0SLlhZ1jwVbptRAt/geFN1T5M9io3WDs33f4KYuXL5QKo64EcHkgD2kAn/KJOBq9x7NXNMsZ8+CAHb0wDxVCWzI2C3Ssj6VdR05/l69Iy09Svz3ltDezP2pqRMPDqPkV3G00ajOsxeXS7xfIici7eKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J63j9qjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F9BC4CEE7;
	Sat,  9 Aug 2025 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754769465;
	bh=1C4UOcUOwx2TNs+xWMHz0OPNegRcKQh5SFRI/zNpp7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J63j9qjpKnDyBSJQDeFXWpMrz7VfPySwa9fZWkRBVlRvFPiEt7zCk4+cUhKXBZB3B
	 7MpRT9nTvYgdYRcDQ3AQ3N7KKRj58vSk2wn/W8oZRj8zh301k8yFBBnb8bK2nX1jOn
	 rIfUSjU6CWLalPeI817lH2pUZCWw5obvQMR/eS4ipDEMevG4RcVBQO7wS83xXctM0d
	 NR58vBf9NXbpNiIr0uNBXRuoqSHDp1sjDahnJLNq0mOHnrGqQNL//uNGR4VxcOn/tx
	 O2MZiwPfjUqQgdNA5pf2lI9CXmOEs6oWN63UuujKShp3HyknXSkHdh8HpzCtNVe/0J
	 4mXy8BxYPo4lw==
Date: Sat, 9 Aug 2025 20:57:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Akshay Jindal <akshayaj.lkd@gmail.com>,
 anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
Message-ID: <20250809205736.34b75763@jic23-huawei>
In-Reply-To: <aJcapPt8f5YMUBH3@smile.fi.intel.com>
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
	<CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
	<CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
	<CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
	<20250806161801.000061c0@huawei.com>
	<aJO05BNi2TsYtdwe@smile.fi.intel.com>
	<20250807140401.00006c85@huawei.com>
	<aJcapPt8f5YMUBH3@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Aug 2025 12:53:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Aug 07, 2025 at 02:04:01PM +0100, Jonathan Cameron wrote:
> > On Wed, 6 Aug 2025 23:02:44 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > On Wed, Aug 06, 2025 at 04:18:01PM +0100, Jonathan Cameron wrote: =20
> > > > On Tue, 5 Aug 2025 14:47:32 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:   =20
> > > > > On Tue, Aug 5, 2025 at 6:05=E2=80=AFAM Akshay Jindal <akshayaj.lk=
d@gmail.com> wrote:   =20
> > > > > > On Tue, Aug 5, 2025 at 2:36=E2=80=AFAM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:     =20
>=20
> ...
>=20
> > > > > > > Doesn't sound right to me. HAve you investigated PM runtime p=
aths?     =20
> > > > > > Yes I did investigate and found that PM runtime->suspend() call=
back
> > > > > > co-exists with remove callback.
> > > > > >     =20
> > > > > > > Looking at what the code you added there it sounds to me like=
 a part
> > > > > > > of PM runtime ->suspend() callback.     =20
> > > > > > Yes, part of functionality will always be common, because both =
the
> > > > > > callback implementations put
> > > > > > the device into powered down or low power state which is what h=
as been done here
> > > > > > Both _suspend() and remove are called at different times in the=
 lifecycle of the
> > > > > > driver, but with respect to register setting, they put the devi=
ce into
> > > > > > power down state.     =20
> > > > >=20
> > > > > Are you sure about the remove stage and how it interacts with run=
time
> > > > > PM? Please, check how the device driver core manages PM on the re=
move
> > > > > stage.
> > > > >    =20
> > > > > > Additionally .remove() can have code for:
> > > > > > 1. disable runtime power management (if enabled while device re=
gistration).     =20
> > > > >=20
> > > > > If the device core enables it for you, it will disable it
> > > > > symmetrically. I don't see the issue here, it should be done
> > > > > automatically. If you do that explicitly, use the respective
> > > > > devm_pm_runtime_*() call.
> > > > >    =20
> > > > > > 2. device cleanup (disabling interrupt and cleaning up other co=
nfigs done).     =20
> > > > >=20
> > > > > Wrap them into devm if required.
> > > > >    =20
> > > > > > 2. unregister the device.     =20
> > > > >=20
> > > > > Already done in the original code which your patch reverts, why?
> > > > >    =20
> > > > > > For eg: another light sensor bh1750
> > > > > > static void bh1750_remove(struct i2c_client *client)
> > > > > > {
> > > > > >     iio_device_unregister(indio_dev);
> > > > > >     mutex_lock(&data->lock);
> > > > > >     i2c_smbus_write_byte(client, BH1750_POWER_DOWN);
> > > > > >     mutex_unlock(&data->lock);
> > > > > > }
> > > > > >
> > > > > > static int bh1750_suspend(struct device *dev)
> > > > > > {
> > > > > >     mutex_lock(&data->lock);
> > > > > >     ret =3D i2c_smbus_write_byte(data->client, BH1750_POWER_DOW=
N);
> > > > > >     mutex_unlock(&data->lock);
> > > > > >     return ret;
> > > > > > }     =20
> > > > >=20
> > > > > Correct and where do you see the problem here? Perhaps the proble=
m is
> > > > > in the cleanup aordering and some other bugs vs. devm calls?
> > > > >    =20
> > > > > > In drivers/iio/light, you can find similar examples in pa122030=
01,
> > > > > > rpr0521, apds9960,
> > > > > > vcnl4000, isl29028, vcnl4035. You can find many more examples in
> > > > > > sensors other than light sensors.     =20
> > > > >=20
> > > > > Good, should all they need to be fixed?   =20
> > > >=20
> > > > The complex corners that occur with devm + runtime pm are around
> > > > things that we must not run if we are already in runtime suspend.
> > > > Typically disabling power supplies (as we can underflow counters
> > > > and getting warning prints).  Seeing as this driver is not
> > > > doing that it should be simple to use a devm_add_action_or_reset()
> > > >=20
> > > > Key thing to consider is that runtime pm may not be built.   =20
> > >=20
> > > This will mean that user does not want to handle PM at all at runtime=
, so why
> > > should it be our problem? If device is off, it's not the problem of t=
he driver
> > > to do the power cycle at run time (yes, this might not apply to the s=
ystem
> > > suspend and resume cases, which has to be implemented as well).
> > >  =20
> > > > So the flow should work with those calls doing nothing.  That means=
 that
> > > > if you turn the device on in probe we should make sure to explicitl=
y turn
> > > > it off in the remove flow. That's where devm_add_action_or_reset()
> > > > comes in handy.   =20
> > >=20
> > > I don't think we should do that explicitly in remove. As I pointed ou=
t above,
> > > this the case that driver should not override.  Otherwise there is no=
 point in
> > > having the common runtime PM. User deliberately makes it not compiled=
, so they
> > > should prepare to leave with it. =20
> >=20
> > Hmm. I don't agree. We turned it on so on error or remove I think we
> > should turn it off again.  We do that in many drivers that never made u=
se of
> > any of the standard PM stuff because they only touch enable and disable=
 in
> > probe and remove.  If nothing else I don't like the lack of balance bet=
ween
> > probe and remove if we don't do it. =20
>=20
> We can do it, but this sounds to me like a step back. Implementing proper=
 PM
> runtime callbacks is a step forward.
I entirely agree that runtime PM is good to have and it does a lot more
than just turning the power on and off once per probe / remove cycle.

But runtime_pm is currently optional (system wide) and that's not something
I think we are in a position to change.  We should support runtime pm in
as many drivers as possible but not rely on it for 'correct functionality'.
To me turning a device off at remove that we turned on at probe is something
we should do. Now if it's already off, then sure don't turn it off again if
it has side effects to do so (which is the heart of the underflow warning i=
ssue
with regulators)

>=20
> Doing the former in the existing drivers is not an argument to me because=
 all
> of them avoiding use of the PM APIs. Note, with PM APIs it may also invol=
ve
> devlink and other benefits that device driver core gives us.

We have lots of drivers that do both minimal management at probe and remove
as necessary to function, and if it is enabled, full runtime pm.

Though recently it has shown up that there are some underflow issues if we
aren't careful wrt to regulators being handled by devm.

>=20
> > > > ret =3D regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENS=
OR_ENABLE);
> > > > Is the paired operation with the second disable you add in remove.
> > > > Wrap that in a devm callback.
> > > >=20
> > > > More complex is the interrupt enable as that doesn't pair with
> > > > anything in particular in probe. I'm curious though, do we need
> > > > to disable it given the next operation turns off the sensor and on
> > > > probe we reset the sensor.
> > > >=20
> > > > Is just clearing the enable bit enough?    =20
>=20


