Return-Path: <linux-iio+bounces-5232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051F8CD907
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936671F23494
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4794762C9;
	Thu, 23 May 2024 17:11:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE756E60F;
	Thu, 23 May 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484316; cv=none; b=nDW7WybbJjGbzSwGBF3Hl9zvZq2EP3HapFsvDKs9VzlwQKtkApMsij1UcE+eCqWU7YWvbuNf0X89ofa6+IQ3RlJMZG46W2xHtrlXA30en6+Bf57r4qSbfnZa9R/3AlGicVDHkMXv4d54o6pEvnPjAB7VuXgWzBLyds8uXqzHcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484316; c=relaxed/simple;
	bh=SupGAAz3jB6ZhWvA0wOiVtpP9VcQX4+yHUr+MUJXgfo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fH8Y9cIxdERk4mPFSPJnfJzLRsQTAeY8plFyL0PNuWcbzcSO7Tmu/mVfF7Gfdrhy8zeHXuSZzFbwAg/nxafiFpeafuZBnm9D8SwKYeJF9rxNL4m13ST5F0QiCCryq0SKC6pLtAgSdZJ5ZhoHPbAJ9Io40g11ssdL8Ro4WAnkhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlZSg6DG9z67y8J;
	Fri, 24 May 2024 01:10:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 82E3E140A34;
	Fri, 24 May 2024 01:11:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 18:11:51 +0100
Date: Thu, 23 May 2024 18:11:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<robh@kernel.org>, <nuno.sa@analog.com>
Subject: Re: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240523181150.000064c4@Huawei.com>
In-Reply-To: <c7996393-a2d0-425e-a37a-0f6bf1ac01b9@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
	<20240517074750.87376-10-ramona.bolboaca13@gmail.com>
	<20240519195707.71163f84@jic23-huawei>
	<c7996393-a2d0-425e-a37a-0f6bf1ac01b9@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 22 May 2024 12:51:39 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> On 5/19/24 21:57, Jonathan Cameron wrote:
>=20
> > On Fri, 17 May 2024 10:47:50 +0300
> > Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> > =20
> >> Add support for ADIS1657X family devices in already exiting ADIS16475
> >> driver.
> >>
> >> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com> =20
> > Whilst it's not necessarily vital to support, it I'm curious about
> > what happens to the hardware timestamp? I thought we had one driver
> > still doing hardware timestamps directly to the buffer, but I can't
> > find it so I guess we now deal with alignment in the few devices with
> > this support.  The st_lsm6dsx has this sort of combining of local
> > and fifo timestamps for example.
> >
> > As it stands I think you push the same timestamp for all scans read
> > from the fifo on a particular watermark interrupt?  That isn't
> > ideal given we should definitely be able to do better than that. =20
>=20
> Currently the timestamp is added when the FIFO is read, which does not=20
> equal the sample time.
>=20
> ADI IMU devices do not actually offer a hardware timestamp. The=20
> functionality is as follows:
> - for internal sync / output sync / direct external sync the burst=20
> data returns a data counter (which increments with each sample);
>=20
> - for scaled external sync the burst data returns the 'timestamp',
> which contains the time associated with the last sample in each data
> update relative to the most recent edge of the external clock signal.
> For example, when the value in the UP_SCALE register represents a scale
> factor of 20, DEC_RATE =3D 0, and the external SYNC rate =3D 100 Hz, the
> following time stamp sequence results: 0LSB, 10LSB, 21LSB, 31LSB,=20
> 41LSB, 51LSB, 61LSB, 72LSB, =E2=80=A6, 194LSB for the 20th sample, which=
=20
> translates to 0us, 490us, =E2=80=A6, 9510 us which is the time from the=20
> previous sync edge.

Thanks for info.  I was hopeful for a real clock, but we rarely get
one (and it introduces clock drift issues anyway so they are quite
tricky to handle :(

>=20
> We can make assumptions, and try to better estimate the timestamp,
> based on the sampling frequency.=20
> We can assume that the last sample in the FIFO was sampled when the
> watermark interrupt took place, and then, based on the sample frequency
> we could decrease the timestamp with the according period for each
> sample.

Assume the one that corresponds to the watermark, not the last one as we
may take a while to get to processing it.

> However, I am not sure this assumption is always valid, it depends
> on when the IRQ is actually handled.
>=20
> I can remove the timestamp for devices which use FIFO seeing how it
> does not represent the actual sample time.
I would do that for now as this si tricky to do well.

There are examples in tree of how to get something reasonable.=20
Take a look at common/inv_sensors/inv_sensors_timestap.c
for one example

>=20
> >> +static const struct iio_buffer_setup_ops adis16475_buffer_ops =3D {
> >> +	.postenable =3D adis16475_buffer_postenable,
> >> +	.postdisable =3D adis16475_buffer_postdisable,
> >> +};
> >> +
> >> +static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigne=
d int val)
> >> +{
> >> +	struct adis16475 *st  =3D iio_priv(indio_dev);
> >> +	int ret;
> >> +	u16 wm_lvl;
> >> +
> >> +	adis_dev_lock(&st->adis); =20
> > As a follow up perhaps consider defining magic to use guard() for these=
 as there are
> > enough users that will be simplified to make it worth the effort.	 =20
>=20
> I will do this in another patch series if that is alright.

Sure.

>=20
> > =20
> >> +
> >> +	val =3D min_t(unsigned int, val, ADIS16575_MAX_FIFO_WM);
> >> +
> >> +	wm_lvl =3D ADIS16575_WM_LVL(val - 1);
> >> +	ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS1=
6575_WM_LVL_MASK, wm_lvl);
> >> +	if (ret)
> >> +		goto unlock;
> >> +
> >> +	st->fifo_watermark =3D val;
> >> +
> >> +unlock:
> >> +	adis_dev_unlock(&st->adis);
> >> +	return ret;
> >> +}
> >> + =20
>=20


