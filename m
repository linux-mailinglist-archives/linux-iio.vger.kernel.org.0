Return-Path: <linux-iio+bounces-25467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE4C0E125
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 624974F9A96
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8623330275F;
	Mon, 27 Oct 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4NAjQC5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70C303CAE;
	Mon, 27 Oct 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571831; cv=none; b=B9LZIG5nKIt/GxDKe1JeUIlTjycpUq6UNgjT/V7ANgNG4+Kb5DtoRcrT77FyPq0BGDV9My6cnlYyWqLkwJUazpR4+JguTNc2bYOm9sKfI7UNaDjsn9QC983tS1eqqFS42YJEh2NATHD2V2A8mSaS36eKZYom8BgJM4hA6jPmmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571831; c=relaxed/simple;
	bh=+Gn+22X1H+YqaLAPSswhI/oCrb2qAnwjX7gTIDiIxwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oK61pR9S/SMlMprlp6b1YkN8tkWLQXpINjdZmn2YzWMSuOvXnWxtYbegQSPsHb/dvEzlUzjfht6kbXttI6S3fzX/S6amgnCzbWpSFEY+zpNFRuhoH4o8D5+oWR/eR2/DND/rKq7/bNYKji49h5leIVjyEUfP84zbt4Dv/9R1TaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4NAjQC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE442C4CEF1;
	Mon, 27 Oct 2025 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761571830;
	bh=+Gn+22X1H+YqaLAPSswhI/oCrb2qAnwjX7gTIDiIxwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4NAjQC5wKgnjSEHN8S+h+W/miYeM0mJ7H9uHu0U3drmJLEmoGNz0J5xvCjdBYcqM
	 frCyAzPSYXO0kfTH9BF8hJFnDy63DPm4NzprAV6US0Pmsfmjee6XT28ndMBQ3/9IhE
	 JZ2brQWKHM0lSFLIjqWsY3ZeUSmok86DH+r9PgmstlTmqGG9uqDdirepqmdV8M7tuX
	 X+XL5e5kN9tA8nceKcfBl39MZfK2iw37RKB9nTp31F2Gr8RAEWOBy3XiyAW+cxWULM
	 nWFe4GO5NMZSwYVMdl3oD1ljCdRWuCbpW5RPlC+PyOBiiupsMdO3J2B9Q5C4ovsaFy
	 ebrJDQeEQHLIg==
Date: Mon, 27 Oct 2025 13:30:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mario Tesi <martepisa@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: st_lsm6dsx: Fixed calibrated timestamp calculation
Message-ID: <20251027133025.542b9653@jic23-huawei>
In-Reply-To: <20251021113544.GA256337@ctocxl9700.cto.st.com>
References: <20251015161619.GA87736@ctocxl9700.cto.st.com>
	<aO_e2DEGsO-kJQFx@lore-desk>
	<20251018202301.2680cc79@jic23-huawei>
	<20251021113544.GA256337@ctocxl9700.cto.st.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Oct 2025 13:35:44 +0200
Mario Tesi <martepisa@gmail.com> wrote:

> On Sat, Oct 18, 2025 at 08:23:01PM +0100, Jonathan Cameron wrote:
> > On Wed, 15 Oct 2025 19:50:16 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >  =20
> > > > The calibrated timestamp is calculated from the nominal value using=
 the
> > > > formula:
> > > >   ts_gain[ns] =E2=89=88 ts_sensitivity - (ts_trim_coeff * val) / 10=
00.
> > > >=20
> > > > The values of ts_sensitivity and ts_trim_coeff are not the same for=
 all
> > > > devices, so it is necessary to differentiate them based on the part=
 name.
> > > > For the correct values please consult the relevant AN.
> > > >=20
> > > > Signed-off-by: Mario Tesi <mario.tesi@st.com>   =20
> > >=20
> > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org> =20
> >=20
> > Fixes tag?  Just reply to this thread with one and I'll pick it up from=
 here.
> > No need for a new version.
> >=20
> > Otherwise seems fine to me.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> Fixes: cb3b6b8e1bc0 ("iio: imu: st_lsm6dsx: add odr calibration feature")
>=20
Thanks. Applied to the fixes-togreg branch of iio.git.
I might hold this back if I get so far as doing a pull request today or
tomorrow just to give it a little time to soak in linux-next.

Thanks,

Jonathan

> Thanks,
> Mario
>=20


