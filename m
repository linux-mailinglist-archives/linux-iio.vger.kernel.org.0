Return-Path: <linux-iio+bounces-22497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E484BB1F5C2
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 20:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFFAE4E1164
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE62BD598;
	Sat,  9 Aug 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqNbQEqJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C917276058;
	Sat,  9 Aug 2025 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754762775; cv=none; b=EpHefuEXGZSOEEuNKE2A9tBUlDqF8j1o4EQH/yv2detYC7N9EbhXGYDEzx8yVZdluUiLqx0Gc6r4oqyeBUnawgOUK/ozMgDlO+/DIJIQnvz6N7HhEHv+et19oEMH4u1V8LZxFIdgOzbsTADeh9qxYt/NPpf3vAZcuouxjEVicwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754762775; c=relaxed/simple;
	bh=OWQOb5Wv6YQJrRHXG8/0NDloufLu93A2qR9hQYvfMjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxGrZyS0dCNCTlnctHzrXUyRbJOkf02y6wM6pAOEFvGwp+UX4ztsySvCBT92nvM2ymdgO8Q6PQUasuIT4WF2SXu13ueXTW2dc3y0ag8Wa2xgkabgra8bdEnXu4YGGGvB5jphNtTvRuSrDTbI8Pgqvp7gnmokFZtRoVJuwZL3LlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqNbQEqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2F2C4CEE7;
	Sat,  9 Aug 2025 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754762774;
	bh=OWQOb5Wv6YQJrRHXG8/0NDloufLu93A2qR9hQYvfMjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XqNbQEqJqxkipxn8r7otRCRmHoApwspj80PhUKkhiaXnK59vdMDWW6VYGCpP3Db2L
	 bJbJqORv300DBZNpiTmdKAgA+t1QCWXbkxEv3CzxS27+dyDb4btyJkHlrHzf3ZUEhf
	 oXcHX9BdqakSJSJefZ0kEp3234T50P+QNQmg/JyErzJBwAwJ0U31R2Q3DM4CRB8jwr
	 cBMej77vbvfs6Rg11HLCNB9zQMWhfB4ozwAldHdHjRTxxUh0zH39Blyg5alXgdD1I6
	 chm91J13W4mAEsmzRJEoyoRamDVv8F30iFFAsZPriO2HK3Uh4eY+rCBPB0G78OThMI
	 lP+IVt/pnFvJA==
Date: Sat, 9 Aug 2025 19:06:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime
 setup
Message-ID: <20250809190609.4fef9df7@jic23-huawei>
In-Reply-To: <CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com>
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
	<20250808-icm42pmreg-v2-1-a480279e7721@geanix.com>
	<CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 23:37:51 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.com> wr=
ote:
> >
> > Rework the power management in inv_icm42600_core_probe() to use
> > devm_pm_runtime_set_active_enabled(), which simplifies the runtime PM
> > setup by handling activation and enabling in one step.
> > Remove the separate inv_icm42600_disable_pm callback, as it's no longer
> > needed with the devm-managed approach.
> > Using devm_pm_runtime_enable() also fixes the missing disable of
> > autosuspend.
> > Update inv_icm42600_disable_vddio_reg() to only disable the regulator if
> > the device is not suspended i.e. powered-down, preventing unbalanced
> > disables.
> > Also remove redundant error msg on regulator_disable(), the regulator
> > framework already emits an error message when regulator_disable() fails.
> >
> > This simplifies the PM setup and avoids manipulating the usage counter
> > unnecessarily. =20
>=20
> ...
>=20
> > +       struct device *dev =3D regmap_get_device(st->map);
> >
> > +       if (!pm_runtime_status_suspended(dev))
> > +               regulator_disable(st->vddio_supply); =20
>=20
> I would rather use positive conditional as it seems to me more scalable
Hi Andy,
>=20

To potentially save time when Sean looks at this.  I don't follow. Do you m=
ean
something like
	if (pm_runtime_status_suspended(dev))
		return;

	regulator_disable(st->vddio_supply);

?

If so I'm not seeing why we'd want this to scale as it's a single use
devm_set_action_or_reset() callback doing just one thing.

Jonathan

> >  } =20
>=20
>=20


