Return-Path: <linux-iio+bounces-18441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5DA9519D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CCD189448C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4F265CB0;
	Mon, 21 Apr 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2I+URoJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62B1362;
	Mon, 21 Apr 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241939; cv=none; b=jv5PpOIxTfrqF5Y8cpkx3OFZm+hXf6d3ugRt+gH8EM0DcjKB0ZihOysQ405nN0sV6PrVWmv0cdeRPigYdcFBtSDtB2QH6Pca4hvkJs5J7KjAz+JiiLo9qnc9SGrqXZ1myZdNQZ4YNSJjbB4nrT7FduOrP1Bk2t4SHKHsF+BTVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241939; c=relaxed/simple;
	bh=YOSwvpc5o4zUuV51/RFhiEJvm46Amg7yyu8rhIMsmWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug3gvbqXss5pCtWmzf+hCJU17smwGzS4uJri7FVyxWfYSfMnTYvZ3nwYcm3oJEGEpv2ETtPNg/mJg35F7UXbr82Gl4Hl2M7m79iLVsre8BgsYsej/LsduEWDCGxz9yCE2LQyoJH1aF6Jo4FpsNBYWMjewykCO5/mIslL8LXKaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2I+URoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FBFC4CEE4;
	Mon, 21 Apr 2025 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745241939;
	bh=YOSwvpc5o4zUuV51/RFhiEJvm46Amg7yyu8rhIMsmWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M2I+URoJVxcJxCBdt5Rn/jLcR7uoBUPhQ6U8J1ooy+PUJd7w37l6Z1wo+06uKnuGS
	 dD3LSRwY6xbEWxLzfXnQF6fmDTF2NyugihPoUUIXNnJjU3bOcIlczSQYH0xNAffBag
	 p2U1P843lu5nmCLrB9olmjeRh7B9xIcVf2qJjACb3Wcx2EmQFP0m6rkuvk4ARYe1GO
	 j3zTfLIFlVG4kNXja9Zytx2Z04yOaqMA5A5fI997xnd6ghizfEj6Xsb9HNRT/Ab22f
	 RN9EA2Sc/k1LigErTFfiqmCQ5bPeieSBOR69Svu4upNQ7EuVOpiLIgMtcS4CXLyaww
	 8SyqHSnhXoSkg==
Date: Mon, 21 Apr 2025 14:25:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Gyeyoung Baek <gye976@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <20250421142531.2084092e@jic23-huawei>
In-Reply-To: <CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com>
References: <20250420181015.492671-1-gye976@gmail.com>
	<20250420181015.492671-4-gye976@gmail.com>
	<CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
	<CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Apr 2025 22:23:57 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Apr 20, 2025 at 10:21=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Apr 20, 2025 at 9:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com=
> wrote: =20
>=20
> ...
>=20
> > > --- a/drivers/iio/chemical/Makefile
> > > +++ b/drivers/iio/chemical/Makefile =20
>=20
> > >  obj-$(CONFIG_SPS30_I2C) +=3D sps30_i2c.o
> > >  obj-$(CONFIG_SPS30_SERIAL) +=3D sps30_serial.o
> > >  obj-$(CONFIG_VZ89X)            +=3D vz89x.o
> > > +obj-$(CONFIG_WINSEN_MHZ19B) +=3D mhz19b.o =20
> >
> > Preserve order. =20
>=20
> Ah, I see it's ordered but by Kconfig, Why do you have WINSEN in the
> option and no such thing in the filename? I would drop that from the
> config option.
>=20
> Jonathan, what do you think about this? Which order (in case of
> misalignment between module name and configuration option) should be
> taken?
>=20

Hmm.. No idea.  It think just dropping it from the CONFIG name
is the right way to avoid the question ;)

Jonathan



