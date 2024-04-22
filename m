Return-Path: <linux-iio+bounces-4444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1268AD319
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 19:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456BD1F2160A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A21153BCF;
	Mon, 22 Apr 2024 17:08:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F791153BC1;
	Mon, 22 Apr 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805738; cv=none; b=Pp9ReRJ9xHmo1L8bhtu+25ugO5ItHNjCi9OJessAHkmOoy1/Y4iou+/4DFnJD0FLroAT2COBXyZqCrVKVAHPD9CGyS0z9DFKV5t5Ra7+lD+Lhld1Irni3MjqK7qg4Dy384dQGw2NKRyNEXe3kryP3jL5vhk3dwX7QoNzVBK2oGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805738; c=relaxed/simple;
	bh=IbpS6xzjUAS+OaaRcBZ449Fa8wf7UA3mE8vd05w6YwI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPtHN3oQ3YG+/by4L+2iujbjFoyP77TgxlJjN7sT32LmJza6OLQ/kMcbOqLQ78tDeTGqcVIW1vhlqaKvrJh60LIyfaUvHFhXSpy5Vs4oBrmI6Yg5q1/PZJxGHAUwXs3nkd6zWQqQg1IO29SRYkEo6S4LOy9gN3UcWfqqHfTXTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWqz5J9jz6JBSd;
	Tue, 23 Apr 2024 01:06:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D873140A77;
	Tue, 23 Apr 2024 01:08:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 18:08:53 +0100
Date: Mon, 22 Apr 2024 18:08:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	<devnull+nuno.sa.analog.com@kernel.org>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	<olivier.moysan@foss.st.com>
Subject: Re: [PATCH 7/8] iio: adc: ad9467: cache the sample rate
Message-ID: <20240422180852.00007fad@Huawei.com>
In-Reply-To: <824d8db92adcd1effd9020e4add873b108f087b4.camel@gmail.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-7-3e7628ff6d5e@analog.com>
	<20240420161941.212e92c5@jic23-huawei>
	<824d8db92adcd1effd9020e4add873b108f087b4.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Apr 2024 17:46:02 +0200
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-04-20 at 16:19 +0100, Jonathan Cameron wrote:
> > On Fri, 19 Apr 2024 17:36:50 +0200
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Since we allow to change the sampling frequency and do it with
> > > clk_round_rate(), we can cache it and use on the read_raw() interface.
> > > This will also be useful in a following patch supporting interface
> > > calibration.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> >=20
> > The clk subsystem caches the clock rate in most cases anyway, so
> > I'm not sure why we need this.=A0 Or it the point that you are going
> > to temporarily change it in the next patch?
> >  =20
>=20
> The idea is that in the next patch I want to bail out early if we're not =
changing the
> rate (after clk_round_rate()) because I also don't want to re-run tuning =
in that
> case. Since the rate is not guaranteed to be cached (even though I think =
most clock
> providers don't set the NO_CACHE flag), I went this way. Anyways, this is=
 minor so I
> can stick to clk_get_rate() if you prefer.

I'd make it local by retrieving current clock just before you consider writ=
ing
it.  We can optimize any need to cache it later.

Jonathan

>=20
> > Patch looks fine, but I think a clearer requirements statement is
> > needed.
> >=20
> > Jonathan
> >=20
> >  =20
> > > ---
> > > =A0drivers/iio/adc/ad9467.c | 13 +++++++++++--
> > > =A01 file changed, 11 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 7475ec2a56c72..7db87ccc1ea4b 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> > > @@ -117,6 +117,7 @@ struct ad9467_state {
> > > =A0	struct iio_backend		*back;
> > > =A0	struct spi_device		*spi;
> > > =A0	struct clk			*clk;
> > > +	unsigned long			sample_rate;
> > > =A0	unsigned int			output_mode;
> > > =A0	unsigned int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 (*scales)[2];
> > > =A0
> > > @@ -331,7 +332,7 @@ static int ad9467_read_raw(struct iio_dev *indio_=
dev,
> > > =A0	case IIO_CHAN_INFO_SCALE:
> > > =A0		return ad9467_get_scale(st, val, val2);
> > > =A0	case IIO_CHAN_INFO_SAMP_FREQ:
> > > -		*val =3D clk_get_rate(st->clk);
> > > +		*val =3D st->sample_rate;
> > > =A0
> > > =A0		return IIO_VAL_INT;
> > > =A0	default:
> > > @@ -346,6 +347,7 @@ static int ad9467_write_raw(struct iio_dev *indio=
_dev,
> > > =A0	struct ad9467_state *st =3D iio_priv(indio_dev);
> > > =A0	const struct ad9467_chip_info *info =3D st->info;
> > > =A0	long r_clk;
> > > +	int ret;
> > > =A0
> > > =A0	switch (mask) {
> > > =A0	case IIO_CHAN_INFO_SCALE:
> > > @@ -358,7 +360,12 @@ static int ad9467_write_raw(struct iio_dev *indi=
o_dev,
> > > =A0			return -EINVAL;
> > > =A0		}
> > > =A0
> > > -		return clk_set_rate(st->clk, r_clk);
> > > +		ret =3D clk_set_rate(st->clk, r_clk);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		st->sample_rate =3D r_clk;
> > > +		return 0;
> > > =A0	default:
> > > =A0		return -EINVAL;
> > > =A0	}
> > > @@ -543,6 +550,8 @@ static int ad9467_probe(struct spi_device *spi)
> > > =A0	if (IS_ERR(st->clk))
> > > =A0		return PTR_ERR(st->clk);
> > > =A0
> > > +	st->sample_rate =3D clk_get_rate(st->clk);
> > > +
> > > =A0	st->pwrdown_gpio =3D devm_gpiod_get_optional(&spi->dev, "powerdow=
n",
> > > =A0						=A0=A0 GPIOD_OUT_LOW);
> > > =A0	if (IS_ERR(st->pwrdown_gpio))
> > >  =20
> >  =20
>=20


