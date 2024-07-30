Return-Path: <linux-iio+bounces-8069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC6941F78
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 20:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE76AB2427D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA418B495;
	Tue, 30 Jul 2024 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/AQuwy/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5918A6A9;
	Tue, 30 Jul 2024 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363707; cv=none; b=OMIGLNE/OkNOnDC+4FDZaljOiJVAIvh7isONkE05PhqiYG4o1+9vpCfLMYOfiI+R9/alhdeDNwcYbY+CSBw/az35l63abDXjxC/Sul2JKxEFLmtl2+rlWT9Jv/oNluO3ofq9+vZCFRyxJjhivx1qtxHEDRoWHfXFu3gtgyQLfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363707; c=relaxed/simple;
	bh=JjAjY9PUjdVhv+rkOwE/alH+xmzy/v1WwqDMl5Ts8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttMBLBHTSjTHTeFii1mpKIBvKhRk+MKfftJwOhS6v05cBH1VasfXA+eOKws4kYQymq3zBc9C+ymPHWlIk8vQTjl2Cuqj+aR4+ZQHhz4Otr4CPdzZYlQlmmFgtKDEgJ7wIe17FjSIKWRfuM3rVu9j3MvPKAr5KoW5rdY6mdIv5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/AQuwy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCB1C32782;
	Tue, 30 Jul 2024 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722363707;
	bh=JjAjY9PUjdVhv+rkOwE/alH+xmzy/v1WwqDMl5Ts8j4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F/AQuwy/VjBpNrZuCl7Z/87ze8ukDAj5U0ttJzM9DTPPPqPZ7zZdO1SK8iw8cTlPq
	 u7kD2BmGN2Z7CLDape1mRfX8oFb/VxRpzDySuniUKo9zUQ+quJ9+Z6IfGJfDPHmsMo
	 yVq/CL9T7JYZF6y7FGqtY+zj8VT/vyMcdxa6D5anlAcH7j8qFbCdm+kOBqn/jl0ubK
	 Uo0gESvzmghZH7hlc4E8mHb6mvqTICtWghelqv/WUyT/WIC9NfGyCdf2dRb67xyN8Q
	 xBQ5Un6Yx1DIrYaQADlvhGcv400meRcknIr/Mi+c9A8x2RKKXVXjujrZxgG/MR60gv
	 +nlhex2vZLz7Q==
Date: Tue, 30 Jul 2024 19:21:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
Message-ID: <20240730192139.063b7a85@jic23-huawei>
In-Reply-To: <CAG=0RqKuhn-WHjMbEqq4bCQOs9ERPKZR_udeCf3noqz+TzULyA@mail.gmail.com>
References: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
	<20240729115056.355466-3-abhashkumarjha123@gmail.com>
	<20240729205329.57390e20@jic23-huawei>
	<CAG=0RqKuhn-WHjMbEqq4bCQOs9ERPKZR_udeCf3noqz+TzULyA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 12:47:10 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> On Tue, Jul 30, 2024 at 1:23=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 29 Jul 2024 17:20:54 +0530
> > Abhash Jha <abhashkumarjha123@gmail.com> wrote:
> > =20
> > > Add new ALS channel and allow reading raw and scale values.
> > > Also provide gain and resolution configuration for ALS channel.
> > > Add automatic mode switching between the UVS and ALS channel
> > > based on which channel is being accessed.
> > > The default mode in which the sensor start is ALS mode.
> > >
> > > Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com> =20
> > Hi Abhash,
> >
> > Patch looks good but one quick question.
> > Why not present an IIO_LIGHT channel?  Needs to be converted
> > to be illuminance (with scale / offset applied) rather than IIO_INTENSI=
TY
> > which we use when the frequency response is different from the requirem=
ents
> > to measure Lux (and the units get very vague!)
> >
> > Looks like what you have here is close, but not quite the right scale
> > factor as not including integration time and the mysterious 0.6 on the =
datasheet. =20
>=20
> Yes, I just noticed it now. I will provide the integration time and
> 0.6 as part of the
> scale calculation in the next version.
>=20
> >
> > If we can provide a signal scaled to illuminance that tends to be a lot
> > more useful for things like screen brightness control because it should
> > be close at least to other light sensors.
> > =20
> Hi Jonathan,
> It did not occur to me that the IIO_LIGHT channel could be used
> directly and hence I
> went with the IIO_INTENSITY approach.
> Yes we could provide the IIO_LIGHT channel and perform lux calculation
> in the driver.
> Would that mean forgoing the IIO_INTENSITY channel? Or do we keep both?

Expose the scaling as _scale for the light channel and don't expose
intensity (as it will be the _raw value anyway).

It's rare to see a linear function for intensity to lux transform but
I think there are one or two others like this.  Mostly the transform
is nonlinear and involves multiple intensity channels which is why
we normally have those and IIO_LIGHT.

Thanks,

Jonathan

>=20
> Abhash
>=20
> > Jonathan =20


