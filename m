Return-Path: <linux-iio+bounces-25806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D423C28F11
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 13:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7104E5908
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F84414;
	Sun,  2 Nov 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY9v5a2w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3442528FD;
	Sun,  2 Nov 2025 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085731; cv=none; b=sEDdghVauYNo0Y6lEElzLVaMSQJvqvrikmqzElscq6rReEj1zjkQHx/6R5087NakKhspBISBEJy88P7EOL4oXTiKCFIvK5SOYjtRBpNTZ/X+FPQqMfpZdo+JIQWn4HEUDJk5HrSk8bXEoI18qNHskhiqCM4+iEuOmIGPpA0ijKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085731; c=relaxed/simple;
	bh=3k97OTELKzAVCJ9qui84cL+tLyGh4k0aajyBkqcVMDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLuCixuwCf9ss41JLdVrpyYTf+Ek208QGiHG8yukGurO405ogmk3QFQu//eQBHjsm8YuSLX5hMCu3OVh+1BNfJYN0FEz6du3iY7F95cerbvNNcRjCVMURMx4lJ9mB3XKx8SMeAV39VkA6+NPvMZ4j6BAe3ffYWLJ44H4myvYl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY9v5a2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93125C4CEF7;
	Sun,  2 Nov 2025 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762085730;
	bh=3k97OTELKzAVCJ9qui84cL+tLyGh4k0aajyBkqcVMDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TY9v5a2wf7T+BQlpIFHnasE5REPJXcYtG/9R4/cj4nEnmE1FzcC74GQiclyw3DbyJ
	 Es7NvRYumCu8SXJ2FrmjQX80yPCbb3pRwe84uMvOnADUlcaDQicHwrx6MXY+O5jx2H
	 kBPw/TA3f4meltpe7L4VaDElAgWbkDEuagyWXU6Uob8ib0kE8nXUGQo5+MGC7gD2eM
	 MxlB8+9dVgWXN4I9hU/KgKBIcPxEsrjPO/q327hjuygsM2ZY5+Puj/0BygksCMb09m
	 AjeN6TIzyyEuI0QPM6vzfjVGfGYU3MdySzV6Rdr+6lL0bgiz81N0WEXMCd9oLdE3hc
	 VTDw8wHW5oHDA==
Date: Sun, 2 Nov 2025 12:15:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] iio: imu: inv_icm45600: Add a missing return
 statement in probe()
Message-ID: <20251102121524.7f9729ea@jic23-huawei>
In-Reply-To: <FR2PPF4571F02BCBB9894C421F5472EDE968CF8A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <aPi5vEp75jH0imQc@stanley.mountain>
	<20251027142331.29725dfe@jic23-huawei>
	<FR2PPF4571F02BCBB9894C421F5472EDE968CF8A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 09:56:45 +0000
Remi Buisson <Remi.Buisson@tdk.com> wrote:

> >
> >
> >From: Jonathan Cameron <jic23@kernel.org>=20
> >Sent: Monday, October 27, 2025 3:24 PM
> >To: Dan Carpenter <dan.carpenter@linaro.org>
> >Cc: Remi Buisson <Remi.Buisson@tdk.com>; David Lechner <dlechner@baylibr=
e.com>; Nuno S=C3=A1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org=
>; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-janitors=
@vger.kernel.org
> >Subject: Re: [PATCH next] iio: imu: inv_icm45600: Add a missing return s=
tatement in probe()
> >
> >On Wed, 22 Oct 2025 14:=E2=80=8A02:=E2=80=8A20 +0300 Dan Carpenter <dan.=
=E2=80=8Acarpenter@=E2=80=8Alinaro.=E2=80=8Aorg> wrote: > The intention her=
e was clearly to return -ENODEV but the return statement > was missing. It =
would result in an off by one read in i3c_chip_info[]
> >On Wed, 22 Oct 2025 14:02:20 +0300
> >Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > =20
> >> The intention here was clearly to return -ENODEV but the return statem=
ent
> >> was missing.  It would result in an off by one read in i3c_chip_info[]=
 on
> >> the next line.  Add the return statement.
> >>=20
> >> Fixes: 1bef24e9007e ("iio: imu: inv_icm45600: add I3C driver for inv_i=
cm45600 driver")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> ---
> >>  drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers=
/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> >> index b5df06b97d44..9247eae9b3e2 100644
> >> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> >> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> >> @@ -57,7 +57,8 @@ static int inv_icm45600_i3c_probe(struct i3c_device =
*i3cdev)
> >>  	}
> >> =20
> >>  	if (chip =3D=3D nb_chip)
> >> -		dev_err_probe(&i3cdev->dev, -ENODEV, "Failed to match part id %d\n"=
, whoami);
> >> +		return dev_err_probe(&i3cdev->dev, -ENODEV,
> >> +				     "Failed to match part id %d\n", whoami);
> >> =20
> >>  	return inv_icm45600_core_probe(regmap, i3c_chip_info[chip], false, N=
ULL);
> >>  } =20
> >
> >I'm going to apply this but the resulting code is still wrong (even if n=
ot
> >a true bug after this fix).
> >
> >A hard ID match like this breaks use of dt fallback compatibles.
> >What this should do is 'give it a go' on matching, but if there no match=
 it should
> >carry on as if the match was to whatever the compatible that was supplie=
d was.
> >When that happens a dev_info() is appropriate but not error out as this =
does.
> >
> >Remi, if possible could you look at adding such a patch on top of this?
> >
> >Thanks,
> >
> >Jonathan
> > =20
> Thanks Jonathan, the fix is correct.
> The problem is that I3C don't specify any device in the device tree,
> and these sensors cannot be identified by their I3C IDs neither.
> So, the driver cannot fallbacks to any compatible device, other than pick=
ing one, more or less, at random.
> Do you see any way to work around this limitation?

Ah.  I'd missed that. Fair enough, sounds like nothing we can do
if the driver doesn't know the ID.

Jonathan

