Return-Path: <linux-iio+bounces-11720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D49B84E1
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03C11C21892
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EFA1BBBC1;
	Thu, 31 Oct 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTOLrK8/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDC13A87C;
	Thu, 31 Oct 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408711; cv=none; b=R0rrTt3eY47354uf9NCCZ0tjkoYi60GyoKQp9x+SNVO9zfxwZ88K4dnubHJSi0u0oIP2NRpbipzA034wFhIexqG+iVNtds3L9F8EkPyxvIjIQ8k6yC2YMmOnLyYl1yZk9XvmxNWE3PUK4qsyrClQQRlUx5uqszCrJSt4yrCoC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408711; c=relaxed/simple;
	bh=mW5IIozQlNT2A5ZHrPGjs33jauF9bNKcg8hGob0g10w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsAuRG3O21rZM/5ebYgejanauPSeDoIDBReOOHAuQfNE5r9+wqFJ2H2yLpj3s4tZgXbIoqhbwnM6sl2ivzib138dpNSkwgfDluBiV1F3EwAOq51wDcmWfH2xdRB1fViZVPUMOucsvKYu6tJSQv9oglP3/R6jNBFaQErBDmcmJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTOLrK8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89407C4CEC3;
	Thu, 31 Oct 2024 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730408710;
	bh=mW5IIozQlNT2A5ZHrPGjs33jauF9bNKcg8hGob0g10w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTOLrK8/JvxYZpf+qH4PUa27ZRSjx02bwZ4Qa6q+kX1s5adPsWHwIMDnKslChXZP1
	 IN5yklFgwkNb1yr/zTN3MFXun5/l2Ylc6sZ2986LpCWOWLBnV3L9GUHwKdR9/c4mPX
	 iVFAZMKlsU9Gi7SMYEJ0N7tMVE0ImDZ+IxmNs89P3hnC2NPp5ZuugQIVVUu/t9NMQ7
	 pLuqY+LasQmLEzcJtO4FtX4V+L9tKtr90CAgZHcCJuhuZ7+SHRlN8WoKlxTlpcECOp
	 cG8ervHvOWibgTJLtYaoci3xWkZ2EErcvXN50Lpup1iL6fD54GgeLjE2ak4nArFOLD
	 6mWAbipNQGi6w==
Date: Thu, 31 Oct 2024 21:05:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Zicheng Qu <quzicheng@huawei.com>, nuno.sa@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, djunho@gmail.com,
 alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com,
 judy.chenhui@huawei.com
Subject: Re: [PATCH v2] iio: adc: ad7923: Fix buffer overflow for tx_buf and
 ring_xfer
Message-ID: <20241031210501.3da82113@jic23-huawei>
In-Reply-To: <4760ad42ae34ea53ffb98995d65c5f1d6a6b3f9e.camel@gmail.com>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
	<20241029134637.2261336-1-quzicheng@huawei.com>
	<4760ad42ae34ea53ffb98995d65c5f1d6a6b3f9e.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 15:20:24 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-10-29 at 13:46 +0000, Zicheng Qu wrote:
> > The AD7923 was updated to support devices with 8 channels, but the size
> > of tx_buf and ring_xfer was not increased accordingly, leading to a
> > potential buffer overflow in ad7923_update_scan_mode().
> >=20
> > Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad79=
18/ad7928")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20

Confusing one. I'll fix the authorship up for your analog address

Zicheng, usually a Suggested-by after checking with the author if it's
a patch in a review thread.

You can't really give someone elses' SoB without them explicitly sending it.
If Nuno let you know that was fine off the list, then just mention that und=
er
---

This time I'm going to take Nuno's RB as fine to indicate no objection
to the SoB. Nuno, feel free to shout if you want to handle this differently.

Applied.

Jonathan


> > v2:
> > - Fixed: Addressed buffer overflow in ad7923_update_scan_mode() due to=
=20
> > insufficient tx_buf and ring_xfer size for 8-channel devices.
> > - Issue: Original patch attempted to fix the overflow by limiting the=20
> > length, but did not address the root cause of buffer size mismatch.
> > - Solution: Increased tx_buf and ring_xfer sizes recommended by Nuno to=
=20
> > support all 8 channels, ensuring adequate buffer capacity.
> > - Previous patch link:=20
> > https://lore.kernel.org/linux-iio/20241028142357.1032380-1-quzicheng@hu=
awei.com/T/#u
> > =C2=A0drivers/iio/adc/ad7923.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 09680015a7ab..acc44cb34f82 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -48,7 +48,7 @@
> > =C2=A0
> > =C2=A0struct ad7923_state {
> > =C2=A0	struct spi_device		*spi;
> > -	struct spi_transfer		ring_xfer[5];
> > +	struct spi_transfer		ring_xfer[9];
> > =C2=A0	struct spi_transfer		scan_single_xfer[2];
> > =C2=A0	struct spi_message		ring_msg;
> > =C2=A0	struct spi_message		scan_single_msg;
> > @@ -64,7 +64,7 @@ struct ad7923_state {
> > =C2=A0	 * Length =3D 8 channels + 4 extra for 8 byte timestamp
> > =C2=A0	 */
> > =C2=A0	__be16				rx_buf[12] __aligned(IIO_DMA_MINALIGN);
> > -	__be16				tx_buf[4];
> > +	__be16				tx_buf[8];
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct ad7923_chip_info { =20
>=20


