Return-Path: <linux-iio+bounces-21635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFBCB03835
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 09:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606881898EF4
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB292376E0;
	Mon, 14 Jul 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EkRSI0NF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519D23717C
	for <linux-iio@vger.kernel.org>; Mon, 14 Jul 2025 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478973; cv=none; b=OFTgc39EJQeY6BavJNGpN8O7EBnyAzePnZitqqGEZ6/DvLDDltIeuiYzHTu0jApbbWA92IQggHL9sp1eEHNct5V14mdAXlg2jhx47kF3V/ielRLnzGoY4B/tuZ7fqBVBIcIYHpY6tPVtt/um8aurxs6WdeJcEcauhkIZROa0xJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478973; c=relaxed/simple;
	bh=DoMzXC+w2zn7qajDwPvOgE/6aneSaT/9dXBHeIbr9l0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iM/vtmIXh/g7e9lRjWt7HwRSwNV3eDzVDY8t/vYi0sy+9yxC3MdUNU5s4iGxOMfdgTXfYiNGwG4rdzP3NnyEwlhvJrQg0aFxLVTiiLspBMUllfz/M0WhWZXkZnvZ8Q3lMJosOSuHAP8KWgyg40pEFxDgsQnIyrDa+4TY+bhK7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EkRSI0NF; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752478969; x=1752738169;
	bh=DoMzXC+w2zn7qajDwPvOgE/6aneSaT/9dXBHeIbr9l0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EkRSI0NFylmF2Nb58uNdI3bksDPKKDUrWVSvCZtDaLQUTBJgC/IYj97EvgTPbDNeh
	 0Eq6UxDqSVVf+FLSWY+2s8cnbY9TddiaFNa/QUEgDDA19jiwe/5HhmJBzHfW2twJYF
	 XeyUXOWiQPcthDG9MQFVArUkMRtOZWAjHSCHh6MA9pj4f6zQpznQ3md14PmSNhhLIx
	 FKKCBW6CyQj3Zto4d3XNtKVSKyfmATvezPD6sD2GzMy+b8ZnGKAHa4+aZ2VPslc4/l
	 pSKPwKItq42iUXmCVh19Snvu9TvmTCY235BK4+0N32B5R21d64Y9dNFOY3XF2TRdiG
	 NdFOGwqBiRKXg==
Date: Mon, 14 Jul 2025 07:42:43 +0000
To: Jonathan Cameron <jic23@kernel.org>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <76fnxeuufv56fmfvq6odi5xz2yjtjxymz24t436zk7rtuyst4s@oihlvsoxhllp>
In-Reply-To: <ie3zr2mvuss2f7prksw6nuc3wonig5ju6y6hqq46upvkhovwpa@vtfc3tqwz3d5>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com> <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com> <20250713152810.4483c786@jic23-huawei> <ie3zr2mvuss2f7prksw6nuc3wonig5ju6y6hqq46upvkhovwpa@vtfc3tqwz3d5>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 95e49975d778b99823cf689602b396181fbc6f0b
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 07:24:57AM +0100, Sean Nyekjaer wrote:
> On Sun, Jul 13, 2025 at 03:28:10PM +0100, Jonathan Cameron wrote:
> > On Wed, 09 Jul 2025 14:35:12 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >=20
> > > Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> > > calls during probe. These are not required when the device is marked
> > > active via pm_runtime_set_active() before enabling pm_runtime with
> > > pm_runtime_enable().
> > >
> > > Also remove the redundant pm_runtime_put_sync() call from the cleanup
> > > path, since the core is not incrementing the usage count beforehand.
> > >
> > > This simplifies the PM setup and avoids manipulating the usage counte=
r
> > > unnecessarily.
> >=20
> > Could we switch directly to using devm_pm_runtime_enable() for this dri=
ver?
> >=20
> > At first glance looks like this code is missing the disable of autosusp=
end
> > that should be there (which devm_pm_runtime_enable() will also handle).
> >=20
>=20
> I have tried to use devm_pm_runtime_enable() but on rmmod it warns
> "unbalanced disables for regulator"
>=20
> If I remove this:
> -=09ret =3D devm_add_action_or_reset(dev, inv_icm42600_disable_vddio_reg,=
 st);
> -=09if (ret)
> -=09=09return ret;
>=20
> Everything seems okay again. I have checked with printk's that
> inv_icm42600_disable_vddio_reg() is called twice with
> devm_pm_runtime_enable() used.
> Does it make sense?
>=20
> /Sean

with pm_runtime_enable():
root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-icm42600-i=
2c.ko
[ 3793.713077] inv-icm42600-i2c 1-0068: no INT1 interrupt defined, fallback=
 to first interrupt
[ 3793.727728] inv-icm42600-i2c 1-0068: mounting matrix not found: using id=
entity...
[ 3793.737660] inv-icm42600-i2c 1-0068: supply vdd not found, using dummy r=
egulator
[ 3793.856891] inv-icm42600-i2c 1-0068: supply vddio not found, using dummy=
 regulator
[ 3793.866872] inv_icm42600_enable_regulator_vddio() enable vddio
[ 3793.920739] inv_icm42600_runtime_suspend() disable vddio
root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
[ 3796.954850] inv_icm42600_runtime_resume() -> inv_icm42600_enable_regulat=
or_vddio()
[ 3796.954910] inv_icm42600_enable_regulator_vddio() enable vddio
[ 3796.985140] inv_icm42600_disable_vddio_reg() disable vddio

with devm_pm_runtime_enable():
root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-icm42600-i=
2c.ko
[ 3852.873887] inv-icm42600-i2c 1-0068: no INT1 interrupt defined, fallback=
 to first interrupt
[ 3852.888715] inv-icm42600-i2c 1-0068: mounting matrix not found: using id=
entity...
[ 3852.898514] inv-icm42600-i2c 1-0068: supply vdd not found, using dummy r=
egulator
[ 3853.016890] inv-icm42600-i2c 1-0068: supply vddio not found, using dummy=
 regulator
[ 3853.026860] inv_icm42600_enable_regulator_vddio() enable vddio
[ 3853.080835] inv_icm42600_runtime_suspend() disable vddio
root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
[ 3854.448461] inv_icm42600_runtime_resume() -> inv_icm42600_enable_regulat=
or_vddio()
[ 3854.448540] inv_icm42600_enable_regulator_vddio() enable vddio
[ 3854.467061] inv_icm42600_runtime_suspend() disable vddio
[ 3854.477170] inv_icm42600_disable_vddio_reg() disable vddio
[ 3854.483835] ------------[ cut here ]------------
[ 3854.483912] WARNING: CPU: 0 PID: 582 at drivers/regulator/core.c:3016 _r=
egulator_disable+0x140/0x1a0
[ 3854.497853] unbalanced disables for regulator

Is the way from here to remove the devm_add_action_or_reset(dev,
inv_icm42600_disable_vddio_reg... ?

/Sean


