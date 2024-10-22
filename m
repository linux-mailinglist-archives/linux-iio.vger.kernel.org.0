Return-Path: <linux-iio+bounces-10955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B324F9AB773
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 22:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15529B21F1A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E571CBE80;
	Tue, 22 Oct 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMdem+MG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B819DF40;
	Tue, 22 Oct 2024 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627731; cv=none; b=b10Bs04C/TUiZq9oZcQrVoel/fy/90jFvaKJTC9FPq3GjvIq1zqV4hUCyArR/cIgoUmRCic7tPh2gwSJAvl7y+c5Wx2u0OopuDTJPFk8jMvIRZrK4Em3f7nbrPP+TZAExZ3oWUiQl2Aq+IDEc95fOBN+IwPJLG92+0JM9YiqVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627731; c=relaxed/simple;
	bh=YoW7CCFIeipQdYTS7UG3dvKfo8mBQ5BWSGHbqcQPbbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUDccmiLBGOJ2VjaxSNj/OvbXF/4bmsP6q5QPN0ito9B17GXGJBhcbZZ80kyWoBR8Go6K6dHttTORwnYeNoOT/JyrYW5M1F4VRe0SUiOmmA+wSjCK+vUPSoZWSIe4dovpW9AfjOqc+PntWHtYrwv841vkA3ej07QQC1KHGBBCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMdem+MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89780C4CEC3;
	Tue, 22 Oct 2024 20:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729627731;
	bh=YoW7CCFIeipQdYTS7UG3dvKfo8mBQ5BWSGHbqcQPbbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMdem+MGKsPgy3s9NN9SHTGu+gCxFxfn4XGFnNoHKP8mHMu5hloLGZc2fzMBMBr0S
	 8R5B7k4xxjnix3VvSTmb0bb7+91AYk3RVbuxPrg5eL5tkRDH0nySa6mLrr0H6nF7CM
	 WWfEIJY9v8C9N21khuCD0NgLFhmwfBWXC+4ifE0DRm5StZEHrdOiOMOIxctIyLhXHq
	 a7ArYbtHhxL8825WmtWPlVk6MMRDbvXtyVXtkJ5k/WuJYSBr3TIGGkQfUt0VYbdG1f
	 fzA3yWBgEA4zC4KcoSpLWBvB/sfHLqlnQgwvCRalP4BXNQopdkC9WZ5xl/uxHJ3GDN
	 ANVwztEnTPupA==
Date: Tue, 22 Oct 2024 21:08:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, alexandru.tachici@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Subject: Re: [PATCH] drivers/iio/adc/ad7124.c: fix division by zero in
 ad7124_set_channel_odr()
Message-ID: <20241022210842.2b917750@jic23-huawei>
In-Reply-To: <561655d4b3bd063cb6ee339294ab9c62a5b06d53.camel@gmail.com>
References: <20241022134330.574601-1-quzicheng@huawei.com>
	<561655d4b3bd063cb6ee339294ab9c62a5b06d53.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 16:23:17 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-10-22 at 13:43 +0000, Zicheng Qu wrote:
> > In the ad7124_write_raw() function, parameter val can potentially
> > be zero. This may lead to a division by zero when DIV_ROUND_CLOSEST()
> > is called within ad7124_set_channel_odr(). The ad7124_write_raw()
> > function is invoked through the sequence: iio_write_channel_raw() ->
> > iio_write_channel_attribute() -> iio_channel_write(), with no checks
> > in place to ensure val is non-zero.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> > --- =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
As with the other patch, I fixed up the patch title to match local style.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad7124.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index a5d91933f505..b79c48d46ccc 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -637,7 +637,7 @@ static int ad7124_write_raw(struct iio_dev *indio_d=
ev,
> > =C2=A0
> > =C2=A0	switch (info) {
> > =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		if (val2 !=3D 0) {
> > +		if (val2 !=3D 0 || val =3D=3D 0) {
> > =C2=A0			ret =3D -EINVAL;
> > =C2=A0			break;
> > =C2=A0		} =20
>=20


