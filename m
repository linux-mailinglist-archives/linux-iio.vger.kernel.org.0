Return-Path: <linux-iio+bounces-23589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF19B3EC44
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA14207AD5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDFA2EC080;
	Mon,  1 Sep 2025 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnOdDwrb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936D32F763;
	Mon,  1 Sep 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744608; cv=none; b=bTGLfp2/ihDTv4LFLBitr0RjPxb0alWXPQLw/i2KJoqOoxir3jzYKqouFk75enEW8olJk6qqdaSAEIez6k0SZde0C6yNLxsafScORolSrKwJvHXt0d0BUnz2uxcE5abPQjRcXiyj/jIGkSKYqm2ZQjXMqJnv367YQ8IgEfW3tUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744608; c=relaxed/simple;
	bh=+adGjPjuWElbo7erZI12XRnebHe+Uz1Eo5NY0qX5MFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqPBxeiA3s1GVdQV9tCXKKnLZpVpQMB1foh6efIzub4xw5ZpcjC1Sx7pfxUk5rbn02bzpjcaXb2ZlgHgx1uHRRUUvwmjV41U75ZlaAioeTZnxz/jKYvNzUJ5Wr5b6ohmV0fxgIxhfwOHXQSPFOpZDr6VojSdoAw9En8TrVmkT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnOdDwrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884A2C4CEF0;
	Mon,  1 Sep 2025 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756744606;
	bh=+adGjPjuWElbo7erZI12XRnebHe+Uz1Eo5NY0qX5MFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AnOdDwrb4sOpgC3CsaFlq+FFXBbRjTD6CdzFgxWsQAblVnIsYa7z7Z3UszWd0MSEa
	 jV+LtLt8D1MPAWr/J0GPXjFWiklEESc6HfBC/IZG7EM4plyAaAdlvCI5ndZaVFva1V
	 6sBkWe3o8q4ETuQY6m06UO4/cBM4htpgEk7r5b6CzIK3VWKp9kBMQKL6f05aoJnYTI
	 E7vDeCfluIiz4ceQB1aOuwosj6xTnTOQq4Hi4BPLiXgDM8+zaa2tAx21aWTK5Pr1V6
	 XV+xHNMY06AY2wqxMs05of4QBsgUZSgC79D9JUy7OLDfIhCNkBEHjKeKoKK6Xz8e2C
	 tb4bD6Rdm+WcA==
Date: Mon, 1 Sep 2025 17:36:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250901173638.5a61d342@jic23-huawei>
In-Reply-To: <CAE3SzaRncowQSu4DDT6020hBJiJs0GGkNkjzi8CPxJ5kukoFPw@mail.gmail.com>
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
	<20250830192538.3b508c5c@jic23-huawei>
	<CAE3SzaSezCtZ24vz4_qSmLow_MfU3p7XgdVUBKD3Yj7LcAK-6g@mail.gmail.com>
	<20250831161149.27547d16@jic23-huawei>
	<CAE3SzaRncowQSu4DDT6020hBJiJs0GGkNkjzi8CPxJ5kukoFPw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Sep 2025 01:41:33 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> On Sun, Aug 31, 2025 at 8:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 31 Aug 2025 11:09:26 +0530
> > Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> > =20
> > > On Sat, Aug 30, 2025 at 11:55=E2=80=AFPM Jonathan Cameron <jic23@kern=
el.org> wrote: =20
> > > >
> > > > On Sat, 30 Aug 2025 17:05:00 +0530
> > > > Akshay Jindal <akshayaj.lkd@gmail.com> wrote: =20
> > > > >  static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
> > > > >                                               unsigned int reg, u=
nsigned int writeval,
> > > > >                                               unsigned int *readv=
al)
> > > > >  {
> > > > >       struct ltr390_data *data =3D iio_priv(indio_dev);
> > > > > +     struct device *dev =3D &data->client->dev;
> > > > > +     int ret;
> > > > >
> > > > > -     guard(mutex)(&data->lock);
> > > > > +     ret =3D pm_runtime_resume_and_get(dev); =20
> > > >
> > > > So this makes me wonder.  I'd been assuming our disable was only tu=
rning the
> > > > sensor off, not register access?  Seeing as it's controlled by a re=
gister
> > > > we can clearly access at least some.
> > > >
> > > > If that's the case why do we need to runtime resume for debug regis=
ter
> > > > read/write?  We shouldn't care if the sensors are reading or not. I=
n fact
> > > > if we do turn the power on we changed the state we are debugging wh=
ich is
> > > > probably not a good plan. =20
> > > Are you suggesting to remove pm_runtime_* calls from all the function=
s or
> > > just the debugfs function? =20
> >
> > All the ones where it's not needed.  So as far as I can see it is only
> > needed when actually grabbing date. =20
>=20
> These are the functions where I have used it currently.
> static const struct iio_info ltr390_info =3D {
>         .read_raw =3D ltr390_read_raw,----> reads sensor data, scale,
> int_time, samp_frequency from register
>         .write_raw =3D ltr390_write_raw,-------> writes sampling
> frequency, scale, int_time into register.
>         .read_avail =3D ltr390_read_avail, ----------------> no reg read
>         .read_event_value =3D ltr390_read_event_value,-----> reads
> interrupt threshold value from register
>         .read_event_config =3D ltr390_read_event_config,----> reads
> INT_CFG register
>         .write_event_value =3D ltr390_write_event_value,------> writes
> threshold value into register
>         .write_event_config =3D ltr390_write_event_config,-----> writes
> into INT_CFG register
>         .debugfs_reg_access =3D ltr390_debugfs_reg_access,-->
> reads/writes into all registers
> };
>=20
> Going by your comment, I think I need it only in read_raw and
> write_event_config.

Yes, I think so but you should test that nothing fails  on the other calls
without it.

> There is a similar sensor, ltrf216a (same company, liteon). There only
> read_raw has
> these pm_runtime_* calls. Let me know your thoughts. I will make the chan=
ge and
> include updated testing details.
>=20
> Thanks,
> Akshay
>=20


