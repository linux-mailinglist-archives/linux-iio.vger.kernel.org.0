Return-Path: <linux-iio+bounces-22796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC087B28D57
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73031CC04F1
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6A2C0F77;
	Sat, 16 Aug 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxnA0JpT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576023D281;
	Sat, 16 Aug 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755343044; cv=none; b=romDy3oE+vqpx+Z7wD4MlwG+HsZPOX3azUYAgYYm+DwGausdHY1Jgr6Px+VHnyj56YlOBajkXPqwVEL/zPiBN6APu9GGbuPaIwMgrfvdhjkKMdX1XIDx1VmJBdnSpOfRLdmetTSzb3JvsikhK+OXuOVoT+7FdhVl/2TU1e8GWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755343044; c=relaxed/simple;
	bh=3ERxZaRS4qcwh/mtcVTYLz86jmNS0EKbfeCWGsT0/LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp+HlpukjsZ3+tJ8A8CQwKNVe1J8hohgpUjAGkhbbicNQlFy4BWGnHz4TUiLtgoyVmqygfn6XaOUkETzNYxtLgE+lkzVi/MExI4ffk286KtjoBuI2LK2FP3ZD/1W18ezjvmM82QBvxsF7bcHVTI5wL4oAzS/ZXgEc9pnKBwFiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxnA0JpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E93C4CEEF;
	Sat, 16 Aug 2025 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755343043;
	bh=3ERxZaRS4qcwh/mtcVTYLz86jmNS0EKbfeCWGsT0/LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WxnA0JpTQqtIDZt0Bf6hj3C37sfWBpU0RIjETATjD816dw/9cRyttfTuVDN84mviu
	 OG9aKvSLMlDzzS0BkSk5zzSKHNhsN+BQYVzIlCSOVt3KgVmAlAxlQtDQkmc2WaJXuA
	 J1GESMK+miOW9N6HDJR2ZZ8NEGGH7stIjqxPTZjV14DXTxEENAbD+AdCoOa275tUOg
	 Ve8t5tCGWLw9366AAijhB/NGMkxzllWACwktVaGwG2LpFDjCUiD9Dc6NL+T53VV1Cw
	 eonFHCmFw4MrWWQ6LSa1z+lXIbnHoV2sjZBRUuDRvZlNif9sUCbnjC4FpwHs9evMI3
	 cjLs96QzUyqhg==
Date: Sat, 16 Aug 2025 12:17:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] iio: imu: inv_icm45600: add buffer support in
 iio devices
Message-ID: <20250816121713.48c01e62@jic23-huawei>
In-Reply-To: <FR2PPF4571F02BCAEF9767DFCEAC0031CB08C28A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
	<20250710-add_newport_driver-v2-3-bf76d8142ef2@tdk.com>
	<20250717153340.33eb92b4@jic23-huawei>
	<FR2PPF4571F02BCAEF9767DFCEAC0031CB08C28A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 14:13:54 +0000
Remi Buisson <Remi.Buisson@tdk.com> wrote:

> >
> >
> >From: Jonathan Cameron <jic23@kernel.org>=20
> >Sent: Thursday, July 17, 2025 4:34 PM
> >To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
> >Cc: Remi Buisson <Remi.Buisson@tdk.com>; David Lechner <dlechner@baylibr=
e.com>; Nuno S=C3=A1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org=
>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;=
 Conor Dooley <conor+dt@kernel.org>; linux-kernel@vger.kernel.org; linux-ii=
o@vger.kernel.org; devicetree@vger.kernel.org
> >Subject: Re: [PATCH v2 3/8] iio: imu: inv_icm45600: add buffer support i=
n iio devices
> >On Thu, 10 Jul 2025 08:57:58 +0000
> >Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrot=
e:
> > =20
> >> From: Remi Buisson <remi.buisson@tdk.com>
> >>=20
> >> Add FIFO control functions.
> >> Support hwfifo watermark by multiplexing gyro and accel settings.
> >> Support hwfifo flush.
> >>=20
> >> Signed-off-by: Remi Buisson <remi.buisson@tdk.com> =20
> >Hi Remi,
> >
> >Sorry for delay - hectic week.
> >
> >Jonathan =20
> No problem, thanks for the review ! (and sorry for my late reply)
> > =20
> >> ---
> >>  drivers/iio/imu/inv_icm45600/Makefile              |   1 +
> >>  drivers/iio/imu/inv_icm45600/inv_icm45600.h        |   4 +
> >>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 514 ++++++++++++=
+++++++++
> >>  drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h |  99 ++++
> >>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 137 +++++- =20
> >We used to do the buffer / core split a lot but it often ends up more tr=
ouble
> >that it is worth and we no longer make buffer support a build time optio=
n (which was
> >what motivated the separate files)  Consider how much simplification you=
'd get by squashing them into
> >one file.   =20
> I understand the point.
> However merging files will allow to remove 5 lines at most,
> while the length of the core file will increase a lot.
> I'm not sure of the benefit in the end, but=20
> please let me know if you really want me to proceed with the merge.

It's only a combined 1.5k. That would be fine even if the savings are fairl=
y small.

It's not something I care that much about though.





> >> +const struct iio_buffer_setup_ops inv_icm45600_buffer_ops =3D {
> >> +	.preenable =3D inv_icm45600_buffer_preenable,
> >> +	.postenable =3D inv_icm45600_buffer_postenable,
> >> +	.predisable =3D inv_icm45600_buffer_predisable,
> >> +	.postdisable =3D inv_icm45600_buffer_postdisable,
> >> +};
> >> +
> >> +int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
> >> +				  unsigned int max) =20
> >What is max here?  Seems to be passed 0 in the only caller. =20
> Function call with max > 0 is implemented later in the same patch
> (in 4/8, from inv_icm45600_buffer_hwfifo_flush).

Maybe push the parameter being introduced to ther.

> >> +{
> >> +	const ssize_t packet_size =3D INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE;
> >> +	__le16 *raw_fifo_count;
> >> +	size_t fifo_nb, i;
> >> +	ssize_t size;
> >> +	const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
> >> +	const __le16 *timestamp;
> >> +	const s8 *temp;
> >> +	unsigned int odr;
> >> +	int ret;
> >> +
> >> +	/* Reset all samples counters. */
> >> +	st->fifo.count =3D 0;
> >> +	st->fifo.nb.gyro =3D 0;
> >> +	st->fifo.nb.accel =3D 0;
> >> +	st->fifo.nb.total =3D 0;
> >> +
> >> +	/* Read FIFO count value. */
> >> +	raw_fifo_count =3D &st->buffer.u16;
> >> +	ret =3D regmap_bulk_read(st->map, INV_ICM45600_REG_FIFO_COUNT,
> >> +			       raw_fifo_count, sizeof(*raw_fifo_count)); =20
> >
> >For IIO drivers at least we still operated under some guidance the regma=
p maintainer
> >gave years ago to never assume regmap (for busses that otherwise require=
 DMA safe
> >buffers) will always bounce the data.  So bulk reads with SPI buffers ne=
ed
> >DMA safe buffers. Easiest is usually an __aligned(IIO_DMA_MINALIGN) buff=
er
> >(or set of buffers) at the end of st.
> >
> >In practice last time I checked regmap doesn't bother with the zero copy
> >optimization that would need this safety so you won't actually hit this
> >issue. =20
> From my understanding, alignment of &st->buffer.u16 is correct because th=
e union is aligned,
>=20
> 	union {
> 		u8 buff[2];
> 		__le16 u16;
> 	} buffer __aligned(IIO_DMA_MINALIGN);
>=20
> Please let me know if my answer is not correct.
Ah. I probably just missed that.  can't remember!

> > =20

