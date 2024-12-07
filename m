Return-Path: <linux-iio+bounces-13196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753D9E8135
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539F11662D3
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9411465A1;
	Sat,  7 Dec 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6h+/3GI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514617597;
	Sat,  7 Dec 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591766; cv=none; b=VGtlYq8/O5jQrhN3f7D3vlTLcu6hcR9PicZxyVB2suatprzGfptFvhPBgGZ9YwdR+jy638/5hOp2CEYUbNNkedXf/zFEeRDAyNY6GodY5+QWtx5rCd7MyQu0hP36PU6ALVqwy7sP8UvkmBbTmMZmsP32cs734Qbq5BPuYNIU0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591766; c=relaxed/simple;
	bh=W7pS6SVxvlMhoXmkIb2TW5PYU125Vi5dFmAhQPjs3Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkUvOMRZGOHnsr42NgD/Bwko5jflC1nf8ZyurIpvZCDSnb+sOGxlwHXzhH9qz7MbnlSJonQAANoN2huFTi0AgdvtkHfv8WM8+ZOMc/rRgUX39N02h20ALs8zjaoLG1zNS3SLC4TPHMZXgep/4wh6/8lGCKzcxoFCTXcZd2HuFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6h+/3GI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF04EC4CEDC;
	Sat,  7 Dec 2024 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733591766;
	bh=W7pS6SVxvlMhoXmkIb2TW5PYU125Vi5dFmAhQPjs3Xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E6h+/3GInJc2KSw8kpgGsMbitw8zUUKYB+vhwCbB+XrnwFA91vWTYs44DgUStpYIz
	 6kE0WPjczejWSJf0cOnwHHKb/ECL/7BoeYWob8gl45Q0s+QigQAHXTzcEDXsTa+l32
	 Mfa/qSeCSQ6NSUfBSC9GOPdMSSkQktR9B9erEtSSNElLLPhjpHZ2F1jpBu2YOvia/D
	 aT2hsxq6eDgSs0z01YPeDIFmveHarzSySFQ4Rv5wKS6gmWshPVSJAjjf4Ikz29kXUU
	 fI4/GZpnUh1aspOBqQ7906qeeBRjKx9rQh1mcx2lESfcO69KE1FBbAAf8PhFoAsie6
	 Of88y6ZzPQzVw==
Date: Sat, 7 Dec 2024 17:15:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Guillaume Ranquet <granquet@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: Disable all channels at probe time
Message-ID: <20241207171555.0028f0df@jic23-huawei>
In-Reply-To: <rl5h6oearvxy4dxtqd5kvcoktsyqyhvhw2qccjcbp3gbsxose2@hpuf3xacndyl>
References: <20241104101905.845737-2-u.kleine-koenig@baylibre.com>
	<20241109152438.0135f0c2@jic23-huawei>
	<7did4jkzbsvovlinkjimbn3zdqrwi2mrs2onukfonjeexnumvh@xbzcdad4v7kd>
	<276fcd4d-5066-46b8-8468-f63d35b74894@baylibre.com>
	<rl5h6oearvxy4dxtqd5kvcoktsyqyhvhw2qccjcbp3gbsxose2@hpuf3xacndyl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 17:11:44 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> On Fri, Dec 06, 2024 at 09:35:15AM -0600, David Lechner wrote:
> > On 12/6/24 5:04 AM, Uwe Kleine-K=C3=B6nig wrote: =20
> > > Hello Jonathan,
> > >=20
> > > On Sat, Nov 09, 2024 at 03:24:38PM +0000, Jonathan Cameron wrote: =20
> > >> Sadly this has probably missed 6.12, but I have queued it up as a fix
> > >> for early next cycle and marked it for stable. =20
> > >=20
> > > I interpreted "early next cycle" as "This will go into v6.13-rc1.". B=
ut
> > > that didn't work and didn't hit the mainline yet (as of cdd30ebb1b9f).
> > >=20
> > > This patch was included in next as
> > > 64612ec9b909b699293b7220c634f67a9fc12e06 between next-20241111 and
> > > next-20241128 and then disappeared from there.
> > >=20
> > > What is wrong here?
> > >=20
> > > Best regards
> > > Uwe =20
> >=20
> > FYI, the iio tree is currently missing from linux-next due to [1].
> >=20
> > [1]: https://lore.kernel.org/all/d707cb3b-1569-45d9-bdc3-dcc98eb88bc4@s=
irena.org.uk/ =20
>=20
> I first thought that couldn't be the explanation because that conflict
> happened to late, but indeed next-20241203 is the first next tag after
> next-20241128 and
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg
>=20
> still contains my patch. Thanks for that hint.
>=20
> Masahiro pointed out a merge fix in the linked thread, but I think it's
> incomplete/wrong.
>=20
> When merging the above branch (currently at
> 1694dea95b02eff1a64c893ffee4626df533b2ab) into ceb8bf2ceaa7 ("module:
> Convert default symbol namespace to string literal") I'd do:
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c
> index 215731bd3c7d..ef9875d3b79d 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -100,7 +100,7 @@ const struct regmap_config inv_icm42600_spi_regmap_co=
nfig =3D {
>  	.cache_type =3D REGCACHE_RBTREE,
>  	.use_single_write =3D true,
>  };
> -EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
> =20
>  struct inv_icm42600_hw {
>  	uint8_t whoami;
>=20
> The MODULE_IMPORT_NS line for
> drivers/iio/imu/inv_icm42600/inv_icm42600_core.c was already fixed in=20
> commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> literal").
>=20
> Best regards
> Uwe

Thanks for the heads up. This had passed me by completely....=20
I normally rebase on rc1 whereas these we a tiny bit after.
I've rebased on char-misc/char-misc-next and char-misc/char-misc-linus that
should clean up the dependencies as Greg has dragged in the couple of
changes just after rc1. I'm a little confused why Linus did them then
as opposed to just before tagging rc1. Ah well.

Jonathan


Jonathan


