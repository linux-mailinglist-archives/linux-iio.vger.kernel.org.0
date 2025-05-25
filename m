Return-Path: <linux-iio+bounces-19897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFE2AC3512
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9021893903
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA861F4626;
	Sun, 25 May 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP0awLqo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A828EA;
	Sun, 25 May 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182284; cv=none; b=WDdfpoZRbhIpAA5a3kBCcnIWyJp1QNyNlFLOh2sroHNPF3Rykq58QeDMz4tJ8xooP+4svGMDcUILVdgwm9ffBo21zn1tlF4YzGw05WpCUXguqTZbilNctb5ggIlg8TRh4bCJ16I+OUrs8W5hsuKFgX1juhmfTUKjSVpgWXwTH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182284; c=relaxed/simple;
	bh=9zFisc4BvkUnb0sacXYazLwTXa3jFFku3wzY2GozKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmVYZ7r7iybiXulQJSYrQPpMae9391wLlOIgD6K+h/GFPT09r8Q1y1ASk2sja3uc3C8h5QM6IEa2muUmoC+ois9NMq5LSFJKC4c775rS9eTriYZYArPIyIaMMBDS06MTqNiF1gvznLGV+Pwqk/8vLUXA/e8xdKvVcgbQWCAEBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP0awLqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332C4C4CEEA;
	Sun, 25 May 2025 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748182284;
	bh=9zFisc4BvkUnb0sacXYazLwTXa3jFFku3wzY2GozKVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dP0awLqoZql0IRsd4pFqgqK1ZePDbBFLGkkWBGwVcj8fYu8uUGZdfJC9mJtDXFcQP
	 yaLkFffuRzksuqys9a4gwPOt3iYIfn4P27TC/fSORhiCyS7hhGlrllqSmjZvxldXNt
	 gThG1d55a87ijAllEe6Udvl2v9jOt9bt9ImQt0NEb9eEpZk6SGwQ1BeRSfC0PpVs7D
	 wPi7phKCX2W4/zJCoYzxaHpTOpfKReDkao1KCtCWvyz0OwFc/1b2mwuRUIUfVhbbku
	 uaPIetXG16dalRnl+8i0bm3gAAqRtLiuh3/2xeCGTseMjxn0OhSR3lTt36Q8lJjNkd
	 i4fzmregzh29A==
Date: Sun, 25 May 2025 15:11:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4080: use lowercase device name
Message-ID: <20250525151118.1384a139@jic23-huawei>
In-Reply-To: <5e0eb8b91062a5622b09c5e32f9e662a224d8d80.camel@gmail.com>
References: <20250520110101.29478-1-antoniu.miclaus@analog.com>
	<5e0eb8b91062a5622b09c5e32f9e662a224d8d80.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 15:08:52 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-05-20 at 14:01 +0300, Antoniu Miclaus wrote:
> > Update the .name field in the ad4080_chip_info struct
> > from "AD4080" to "ad4080" to follow the common convention
> > in IIO drivers of using lowercase names for device identifiers.
> >=20
> > No functional changes are introduced.
Isn't this what is read back from /sys/bus/iio/devices/iio\:device0/name?

changing it is a functional change.  I'd argue it's a fix and deserved
a fixed tag.

> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/adc/ad4080.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > index e8b2e5e7a68a..c36eb41d738a 100644
> > --- a/drivers/iio/adc/ad4080.c
> > +++ b/drivers/iio/adc/ad4080.c
> > @@ -433,7 +433,7 @@ static const struct iio_chan_spec ad4080_channel =
=3D {
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> > -	.name =3D "AD4080",
> > +	.name =3D "ad4080",
> > =C2=A0	.product_id =3D AD4080_CHIP_ID,
> > =C2=A0	.scale_table =3D ad4080_scale_table,
> > =C2=A0	.num_scales =3D ARRAY_SIZE(ad4080_scale_table), =20
>=20


