Return-Path: <linux-iio+bounces-22454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B0AB1E961
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC4FA0225B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB28C27E05F;
	Fri,  8 Aug 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Ih32wE2e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF027A46E
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660571; cv=none; b=OIOfp1DA0PbTApyW0TDI936z6nae9nQ36d2PSwh3cfbN6LDjyNkgPmkIMnnqC/fuBuXuQMdyRFi2DInZS0r4JS1GScVyRicOh5nHz+DZcSL9/9LMdZAqPj+pwsBBncVcbYXfDLBnajUNqA9y2mWxsOL/tyamdvSmJwZi2KPvHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660571; c=relaxed/simple;
	bh=G4O69/i8OZGm4En//tZynCNe/Yckfif2S6gKR6o1CM8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2dP80wLcw+BBC2GO5Ndbi8iIze8XrjIohwNgy2OhumJ4VUOV2/3X7UGbHfgFiZepaNTI1zkzIwKME6ivze3uxun8cHKYdRcScDXhxZid7s2rZHj8YaMS3+0W7HFd3W7+d0m9w9XzSqqnzLRbGbLzyrxexKsndGgAaAy0+TmCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Ih32wE2e; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754660565; x=1754919765;
	bh=i+mcK+XZU9rkDOczH5+5Bu/4zhsFYEgJwLTXXevJXX0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ih32wE2ePoUAgzxMeSxh7H81z/fdbLSKmi6KBN4Xwh2Jp65FYntrO2WN9tSTSwqVu
	 EtKCyqt9AJVG5oIpDo0M9TqGECpBZo0FR8iFTp3z+nLOWrIadN6y4CdBpefwJFNstb
	 U4GpcF/dJnD1YOFsPwqsk8KLUqvRvPVpm9kmn5CdFBzNcvooQVPrUAgOKsDg2ftrAN
	 evShxFnoTT3GTzKXvXx5jvhMqurvZim2wYPVZNLuENBkQIhr8WI0AZuFD4gY01IRY1
	 8yW4KvP+esdIMBWYHCdkywMJ5Psda4yuomwxMq67fN3pqGBxrKmAPYzOJio5OmFqNN
	 FDTvABoeeqnkQ==
Date: Fri, 08 Aug 2025 13:42:38 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <2tgdl3i4kr3opwomertkq3etp3ckowzazlaihu47u6ydyh4fda@3yf6674skfx7>
In-Reply-To: <20250719143250.6799eb5d@jic23-huawei>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com> <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com> <20250713152810.4483c786@jic23-huawei> <ie3zr2mvuss2f7prksw6nuc3wonig5ju6y6hqq46upvkhovwpa@vtfc3tqwz3d5> <76fnxeuufv56fmfvq6odi5xz2yjtjxymz24t436zk7rtuyst4s@oihlvsoxhllp> <20250716090010.23ea03b6@jic23-huawei> <iwe34sdzsgeqpgqrc7ndbx6n4ef6kiwd4bczbiwbhlfgv3zesx@rnr5l7diy5z7> <20250719124711.42fe1a00@jic23-huawei> <20250719143250.6799eb5d@jic23-huawei>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 7ecfee6aaeeacf6d992160c4e5d93ace4bfc94c1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 02:32:50PM +0100, Jonathan Cameron wrote:
> On Sat, 19 Jul 2025 12:47:11 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Fri, 18 Jul 2025 06:40:50 +0000
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >
> > > On Wed, Jul 16, 2025 at 09:00:10AM +0100, Jonathan Cameron wrote:
> > > > On Mon, 14 Jul 2025 07:42:43 +0000
> > > > Sean Nyekjaer <sean@geanix.com> wrote:
> > > >
> > > > > On Mon, Jul 14, 2025 at 07:24:57AM +0100, Sean Nyekjaer wrote:
> > > > > > On Sun, Jul 13, 2025 at 03:28:10PM +0100, Jonathan Cameron wrot=
e:
> > > > > > > On Wed, 09 Jul 2025 14:35:12 +0200
> > > > > > > Sean Nyekjaer <sean@geanix.com> wrote:
> > > > > > >
> > > > > > > > Remove unnecessary pm_runtime_get_noresume() and pm_runtime=
_put()
> > > > > > > > calls during probe. These are not required when the device =
is marked
> > > > > > > > active via pm_runtime_set_active() before enabling pm_runti=
me with
> > > > > > > > pm_runtime_enable().
> > > > > > > >
> > > > > > > > Also remove the redundant pm_runtime_put_sync() call from t=
he cleanup
> > > > > > > > path, since the core is not incrementing the usage count be=
forehand.
> > > > > > > >
> > > > > > > > This simplifies the PM setup and avoids manipulating the us=
age counter
> > > > > > > > unnecessarily.
> > > > > > >
> > > > > > > Could we switch directly to using devm_pm_runtime_enable() fo=
r this driver?
> > > > > > >
> > > > > > > At first glance looks like this code is missing the disable o=
f autosuspend
> > > > > > > that should be there (which devm_pm_runtime_enable() will als=
o handle).
> > > > > > >
> > > > > >
> > > > > > I have tried to use devm_pm_runtime_enable() but on rmmod it wa=
rns
> > > > > > "unbalanced disables for regulator"
> > > > > >
> > > > > > If I remove this:
> > > > > > -=09ret =3D devm_add_action_or_reset(dev, inv_icm42600_disable_=
vddio_reg, st);
> > > > > > -=09if (ret)
> > > > > > -=09=09return ret;
> > > > > >
> > > > > > Everything seems okay again. I have checked with printk's that
> > > > > > inv_icm42600_disable_vddio_reg() is called twice with
> > > > > > devm_pm_runtime_enable() used.
> > > > > > Does it make sense?
> > > > > >
> > > > > > /Sean
> > > > >
> > > > > with pm_runtime_enable():
> > > > > root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-=
icm42600-i2c.ko
> > > > > [ 3793.713077] inv-icm42600-i2c 1-0068: no INT1 interrupt defined=
, fallback to first interrupt
> > > > > [ 3793.727728] inv-icm42600-i2c 1-0068: mounting matrix not found=
: using identity...
> > > > > [ 3793.737660] inv-icm42600-i2c 1-0068: supply vdd not found, usi=
ng dummy regulator
> > > > > [ 3793.856891] inv-icm42600-i2c 1-0068: supply vddio not found, u=
sing dummy regulator
> > > > > [ 3793.866872] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > > [ 3793.920739] inv_icm42600_runtime_suspend() disable vddio
> > > > > root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
> > > > > [ 3796.954850] inv_icm42600_runtime_resume() -> inv_icm42600_enab=
le_regulator_vddio()
> > > > > [ 3796.954910] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > > [ 3796.985140] inv_icm42600_disable_vddio_reg() disable vddio
> > > > >
> > > > > with devm_pm_runtime_enable():
> > > > > root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-=
icm42600-i2c.ko
> > > > > [ 3852.873887] inv-icm42600-i2c 1-0068: no INT1 interrupt defined=
, fallback to first interrupt
> > > > > [ 3852.888715] inv-icm42600-i2c 1-0068: mounting matrix not found=
: using identity...
> > > > > [ 3852.898514] inv-icm42600-i2c 1-0068: supply vdd not found, usi=
ng dummy regulator
> > > > > [ 3853.016890] inv-icm42600-i2c 1-0068: supply vddio not found, u=
sing dummy regulator
> > > > > [ 3853.026860] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > > [ 3853.080835] inv_icm42600_runtime_suspend() disable vddio
> > > > > root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
> > > > > [ 3854.448461] inv_icm42600_runtime_resume() -> inv_icm42600_enab=
le_regulator_vddio()
> > > > > [ 3854.448540] inv_icm42600_enable_regulator_vddio() enable vddio
> > > > > [ 3854.467061] inv_icm42600_runtime_suspend() disable vddio
> > > >
> > > > As below What is the call path for this final suspend?
> > > > Is it coming from update_autosuspend()?
> > >
> > > Yeah it looks like pm_runtime_dont_use_autosuspend() is calling runti=
me_suspend().
> >
> > ok. So how are we supposed to handle this?  Seems like it would be a fa=
irly common
> > situation.  devm_pm_runtime_set_active_enabled() might be relevant.
> > I get confused by all the reference counter
> > complexity in runtime pm but is devm_pm_runtime_get_noresume() what we =
want?
> > That will decrement the usage count with no action just before we hit t=
he point
> > were the suspend or not decision is made.  So I think that will mean th=
e device
> > things it is already suspended when you hit the path here and so not do=
 it again?
> >
> > There seems to be only one user of this stuff though:
> > https://elixir.bootlin.com/linux/v6.15.6/source/drivers/spi/atmel-quads=
pi.c#L1440
> Note that example does a get in the remove callback().   Seems odd but ma=
ybe
> we need a devm_pm_runtime_*put() that results in an a get in the remove p=
ath to ensure counts
> all match.
>=20

Hi,

For what is worth; It looks like drivers/iio/adc/ti-ads1100.c does same as =
we are trying to do here.
It also fails in rmmod:

root@v4:/data/root# insmod /tmp/ti-ads1100.ko
[   65.778107] ads1100 1-0049: supply vdd not found, using dummy regulator
root@v4:/data/root# rmmod /tmp/ti-ads1100.ko
[   73.625923] ------------[ cut here ]------------
[   73.625976] WARNING: CPU: 0 PID: 299 at drivers/regulator/core.c:3016 _r=
egulator_disable+0x140/0x1a0
[   73.639939] unbalanced disables for regulator-dummy
[   73.644833] Modules linked in: ti_ads1100(-)
[   73.649178] CPU: 0 UID: 0 PID: 299 Comm: rmmod Not tainted 6.16.0-rc1-00=
203-ge84dc7fb9038-dirty #160 VOLUNTARY
[   73.659289] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   73.665479] Call trace:
[   73.665499]  unwind_backtrace from show_stack+0x10/0x14
[   73.673301]  show_stack from dump_stack_lvl+0x54/0x68
[   73.678389]  dump_stack_lvl from __warn+0x7c/0xe0
[   73.683120]  __warn from warn_slowpath_fmt+0x124/0x18c
[   73.688285]  warn_slowpath_fmt from _regulator_disable+0x140/0x1a0
[   73.694494]  _regulator_disable from regulator_disable+0x48/0x80
[   73.700529]  regulator_disable from devres_release_group+0x180/0x1a0
[   73.706925]  devres_release_group from i2c_device_remove+0x34/0x84
[   73.713146]  i2c_device_remove from device_release_driver_internal+0x180=
/0x1f4
[   73.720402]  device_release_driver_internal from driver_detach+0x54/0xa0
[   73.727130]  driver_detach from bus_remove_driver+0x58/0xa4
[   73.732735]  bus_remove_driver from sys_delete_module+0x16c/0x250
[   73.738857]  sys_delete_module from ret_fast_syscall+0x0/0x54
[   73.744627] Exception stack(0xd0d5dfa8 to 0xd0d5dff0)
[   73.749701] dfa0:                   be970e51 be970d2c 00233fbc 00000800 =
0000000a 00233f80
[   73.757896] dfc0: be970e51 be970d2c 00233f80 00000081 00000000 00000001 =
00000002 00233190
[   73.766086] dfe0: b6c87e41 be970aec 000179cb b6c87e48
[   73.771228] ---[ end trace 0000000000000000 ]---

I will try something similar to this:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=
=3D4154e767354140db7804207117e7238fb337b0e7

/Sean


