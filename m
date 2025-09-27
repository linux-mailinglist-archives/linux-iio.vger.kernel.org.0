Return-Path: <linux-iio+bounces-24495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A86BA6144
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8C1189679C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBC62E2DCD;
	Sat, 27 Sep 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYWfI5a4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB49238C08;
	Sat, 27 Sep 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758988721; cv=none; b=YSRDfHtc7AT9v5904doCJSxpC0kvO/TLmhlVXuUoi830r4yV1gX1deTT6TLZz7sCDjIA5aPx6U7vlbI08G6CsnhUrphZ97uacxjES54hI9rVj1Q2mbf6LPCBKiwHhvP6HM5rhCfizjnswP6w/G5DUeOp+kuIVVZbkDU4oRDDwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758988721; c=relaxed/simple;
	bh=hZbYs7BmFN6YKKB9p+S2nDQWqzQ+3d3PKXsOx7QAtUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wq9bna1VheM4QU/Ng3YC2UFRCj71Q1pkwtnrJWJHaRSME4Ys25ydtw5iVd1LAQ2cjcpB/g3e1B9eqhfllJkJmWIZrhIb1HG2MQ0k1lxPwuH45/nY24NmamPeOEBc9dKrpBEWZGOwB7bcTUtvFKrPcl6eBwJF05qXVMYePOMCbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYWfI5a4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1003C4CEE7;
	Sat, 27 Sep 2025 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758988720;
	bh=hZbYs7BmFN6YKKB9p+S2nDQWqzQ+3d3PKXsOx7QAtUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WYWfI5a40m98HC/YM8T6LfQN9VjqfMN0Y223oeig9UU5UwmUkqN9YbuKCvQoYhjK+
	 pMlMfhWdkvYCKUWSIe59kBqtuiZOWQuDJNZu2DRQotE3SZNn7tDsicZwpvc9C0TdGk
	 Vxt8rm3ek55CXe2dr4BljXUiQpkp1+3uZYpobmND2+8duteH0k25JhE6oADa6I36Vn
	 lM3/QS80syUNOwEEqGA7vAW8B5cWArO0YXkCmX5P7y7P2aLnIm5poYFCwVrgqtCXYx
	 FedegtQrGmyxevqc0fS3uSeZrcHetp5EntpnqOAyQUuZn5wqYPpHpbZgfp3+l0IKTG
	 vO17g1CpcdQ6w==
Date: Sat, 27 Sep 2025 16:58:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: explain why indio_dev->name
 = dev_name() is wrong
Message-ID: <20250927165832.5ad37428@jic23-huawei>
In-Reply-To: <CAHp75VfkS_geLqSjMz95yb8smNqKTQTfyCA3KeeUGMSg1=EfOw@mail.gmail.com>
References: <20250920-iio-indio_dev-name-wrong-v1-1-d376436abbb6@baylibre.com>
	<CAHp75VfkS_geLqSjMz95yb8smNqKTQTfyCA3KeeUGMSg1=EfOw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 21 Sep 2025 21:33:02 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Sep 20, 2025 at 7:44=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > Add an explanatory comment on why indio_dev->name =3D dev_name(dev) is
> > wrong, and that we can't fix it without breaking userspace.
> >
> > The idea is to prevent future drivers from making the same mistake by
> > copying this code. And if this driver is ever modified again, we can
> > at least make sure any new compatible IDs use the correct name. =20
>=20
> ...
>=20
> > +       /*
> > +        * The device name is supposed to be the "part number", not the=
 kobject
> > +        * name. Do not copy this code for new drivers. We can't "fix" =
this
> > +        * without breaking userspace, so we have to live with it. Howe=
ver, if
> > +        * any new compatible IDs are added, please do something simila=
r to
> > +        * adc/ltc2497-core.c so that at least the new part numbers are=
 correct. =20
>=20
> Please, use the full path from the root of the source tree, i.e.
> drivers/iio/adc/ltc2497-core.c. IIRC the Sphynx might even render the
> links properly (if it ever goes to this deep comment, which is not
> marked as kernel-doc).

Other than that this looks like a good approach to me.
I was thinking maybe a reference to central doc, but that might be a bit fr=
agile
so I think I prefer this approach of stating it fully at each place it matt=
ers.

Thanks,

Jonathan

>=20
> > +        */
> >         indio_dev->name =3D dev_name(&pdev->dev); =20
>=20


