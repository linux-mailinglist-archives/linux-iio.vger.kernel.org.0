Return-Path: <linux-iio+bounces-12065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9BB9C2D74
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43444282493
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDACF154BF5;
	Sat,  9 Nov 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcdNo9/o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874951BC3F;
	Sat,  9 Nov 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157493; cv=none; b=j5xOUbKrC0hOzh0EHsjZhef7SI2PGoyX5ebjUFfQnbg/+7wy5J5aCunJ+bU4+GEb+V28OlVNkJnOFgHnaEqWB8VMAL70fsV52YGPSWVRPxsZ2Ro+1Bsfa1ApA74J+SXUjgLOPBLc5/xm74O5y8nYklE8bmXLv7ViWFuo3+807NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157493; c=relaxed/simple;
	bh=xgxh8ha4d+E+jMCTEqN7OUugPni+lhJgobrkZDBk7E0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtFxCO9OVfKKNIIaPStPitLz2V9vL2emgbUSBQ3RrXzF+9xjoDRZhaPCNBagrRayJFUfzT4lP+Lau93bfs8el4ooogVmFC2g8qMzsJo4Tvx4ZMkLApl+GuSzAFMwdj/7OCZAtxIZAxS7gOaTa3SNos+p9u37qyFgGTusJEw3tqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcdNo9/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC1CC4CECE;
	Sat,  9 Nov 2024 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731157493;
	bh=xgxh8ha4d+E+jMCTEqN7OUugPni+lhJgobrkZDBk7E0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcdNo9/olGK9RpMagF/ky3OSDETIxSzLpa5NpEX27nGxNjIRwbWJ2PDmk5+cqGhvu
	 EtwDYVefL64hOJkYl0wWJayEaFhWaOBVN4s+ubvwDu2kC+4wHvzcpeAPt1y5MOBseA
	 TjQ4P9hXmqtNR7bFDOzYkcDtdiFtKd46wCl0QqA7yfMnnjR88IbrmCuXVF2brtNT3A
	 c1rIy5dlVVbgSGWj2buas0vX+RjKzwwEOIV8vV9BlM7CFl3RKdLRh8KXtHqVURk+F2
	 1jCDEX4ob4Xr/peupOZz/4s0m7PApL4OqhizmxvpxJyjRKZi+EDK6sljp9bqaDufM+
	 IrEjPQl/odCSQ==
Date: Sat, 9 Nov 2024 13:04:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Haibo Chen
 <haibo.chen@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <20241109130444.78e4c1ec@jic23-huawei>
In-Reply-To: <Zy5inVdA4xy1qyrT@lizhi-Precision-Tower-5810>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
	<4bd12695-075d-474c-b720-d295cc6028ce@wanadoo.fr>
	<Zy0Z3wIsgX+O4DEw@lizhi-Precision-Tower-5810>
	<8e52cc9a-0da0-4393-af66-6dac092148ef@wanadoo.fr>
	<Zy5inVdA4xy1qyrT@lizhi-Precision-Tower-5810>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Nov 2024 14:12:29 -0500
Frank Li <Frank.li@nxp.com> wrote:

> On Fri, Nov 08, 2024 at 07:13:20AM +0100, Christophe JAILLET wrote:
> > Le 07/11/2024 =C3=A0 20:49, Frank Li a =C3=A9crit=C2=A0: =20
> > > On Thu, Nov 07, 2024 at 08:38:20PM +0100, Christophe JAILLET wrote: =
=20
> > > > Le 07/11/2024 =C3=A0 20:18, Frank Li a =C3=A9crit=C2=A0: =20
> > > > > Use devm_* and dev_err_probe() simplify probe function and remove
> > > > > vf610_adc_remove(). Change type of 'vref_uv' to int because
> > > > > regulator_get_voltage() return type is int.
> > > > >
> > > > > Reviewed-by: Haibo Chen <haibo.chen-3arQi8VN3Tc-XMD5yJDbdMReXY1tM=
h2IBg@public.gmane.org>
> > > > > Signed-off-by: Frank Li <Frank.Li-3arQi8VN3Tc-XMD5yJDbdMReXY1tMh2=
IBg@public.gmane.org>
> > > > > --- =20
> >
> > ...
> > =20
> > > > =20
> > > > >    	info->vref =3D devm_regulator_get(&pdev->dev, "vref"); =20
> > > >
> > > > With the change to devm_regulator_get_enable_read_voltage(), is it =
still
> > > > needed? =20
> > >
> > > Suspend function need vref to disable regulator. =20
> >
> > Ok.
> >
> > But why switch to devm_regulator_get_enable_read_voltage() then?
> > Shouldn't keeping regulator_get_voltage() be enough and simpler? =20
>=20
> Avoid goto err after devm_regulator_get_enable_read_voltage(), if use
> regulator_enable(), it needs regulator_disable() in err handle branch aft=
er
> it.

Don't get the same regulator twice - that works but is likely to be error
prone in the long run and is a bit too subtle.

This isn't an appropriate use of devm_regulator_get_enable_read_voltage()
Instead just use a local callback and
devm_add_action_or_reset() to disable the regulator in the devm tear down p=
ath.

Jonathan

>=20
> Frank
>=20
> >
> > CJ
> > =20
> > > =20
> > > >
> > > > CJ
> > > > =20
> > > > >    	if (IS_ERR(info->vref))
> > > > >    		return PTR_ERR(info->vref);
> > > > > -	ret =3D regulator_enable(info->vref);
> > > > > -	if (ret)
> > > > > -		return ret;
> > > > > -
> > > > > -	info->vref_uv =3D regulator_get_voltage(info->vref);
> > > > > +	info->vref_uv =3D devm_regulator_get_enable_read_voltage(&pdev-=
>dev, "vref");
> > > > > +	if (info->vref_uv < 0)
> > > > > +		return info->vref_uv;
> > > > >    	device_property_read_u32_array(dev, "fsl,adck-max-frequency",=
 info->max_adck_rate, 3); =20
> > > >
> > > > ...
> > > > =20
> > >
> > > =20
> > =20


