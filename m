Return-Path: <linux-iio+bounces-4442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97928AD30E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637B41F221A6
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B0E153833;
	Mon, 22 Apr 2024 17:06:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06691514E2
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805564; cv=none; b=bvdTWmQcWOWfzGgYSXROXud3eE5wZ5cv16DnZLVgOFkqdHJgMNXB6wmF0vwJitakJZuR2b5udjuITlE1gUUBBqGnN8+qnLTH31srDbaf2ka2V9BZfKYlW9hNVhs6mjYeVi7+xiQUUx2qnPBTOrHjuMHz+/VjveWZ7zhCLKL8tqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805564; c=relaxed/simple;
	bh=aKc8DZhUt6aJpM3Ls1ytddBsxmpPdjJ4cymXii+nUlc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WniwRdl2bc0Rmrf/Sma4YRS2FSNVZMccQYHuPNfCHbxOHmaL0P6FR/wi8m28uktlBdBpqiCaWk04anW9ExN/lCUCDi4r0+fNFaEKeQI5J7zfiRjlRBmUtqcxM0f9W34oiMZwjRrG+bxjZp5WF1mrY+lqtO6ouBSCd+iOX6a8bkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWmY5tbBz6K668;
	Tue, 23 Apr 2024 01:03:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 45EBE140736;
	Tue, 23 Apr 2024 01:05:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 18:05:57 +0100
Date: Mon, 22 Apr 2024 18:05:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hans de Goede <hdegoede@redhat.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Sean Rhodes <sean@starlabs.systems>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers
 and add it to mxc4005
Message-ID: <20240422180556.0000472d@Huawei.com>
In-Reply-To: <CAHp75VcpbQZZtw2ReLuGMoyOYy8sSEuVf7j1dopt6gkWecAoag@mail.gmail.com>
References: <20240417164616.74651-1-hdegoede@redhat.com>
	<ZiYX5JlwS9nGkS2Q@surfacebook.localdomain>
	<81f83cd6-6d17-4e11-97b6-7f1f11bc3078@redhat.com>
	<CAHp75Vfsnffq8J=j9-8w2VWHyMp4e5gw7F11S8XMdMN8TXMwKg@mail.gmail.com>
	<1b497e81-3e2c-4b07-a922-79d92054d6c8@redhat.com>
	<CAHp75VcpbQZZtw2ReLuGMoyOYy8sSEuVf7j1dopt6gkWecAoag@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Apr 2024 15:28:48 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Apr 22, 2024 at 2:45=E2=80=AFPM Hans de Goede <hdegoede@redhat.co=
m> wrote:
> > On 4/22/24 1:33 PM, Andy Shevchenko wrote: =20
> > > On Mon, Apr 22, 2024 at 11:24=E2=80=AFAM Hans de Goede <hdegoede@redh=
at.com> wrote: =20
> > >> On 4/22/24 9:55 AM, Andy Shevchenko wrote: =20
> > >>> Wed, Apr 17, 2024 at 06:46:12PM +0200, Hans de Goede kirjoitti: =20
>=20
> ...
>=20
> > >>> I have briefly looked into this and I like this, except the part of=
 the big
> > >>> function being in the header. Why? Why can't it be in a C-file?
> > >>>
> > >>> Note, 3 users justify very well to me that shared code, should be s=
hared in
> > >>> binary as well. (I.o.w. you may argue that IRL there will be no mor=
e than
> > >>> one of such device connected, but in case of DIY and prototyping it=
 might
> > >>> still be the use case.) =20
> > >>
> > >> It is only 1 function and it is not that big. IMHO the static inline
> > >> in a header solution here is much better then making this a separate=
 .ko
> > >> file with all the associated overhead. =20
> > >
> > > Look how the i8042 RTC header became a disaster. :-)
> > > Nevertheless, this can be part of the IIO core for the ACPI enabled
> > > kernels. Which eliminates a need for a separate module. =20
> >
> > Putting this in the IIO core, with an iio-prefix, so say something like:
> >
> > #ifdef CONFIG_ACPI
> > bool iio_read_acpi_mount_matrix(struct device *dev, struct iio_mount_ma=
trix *matrix, const char *method_name);
> > #else
> > static inline bool
> > iio_read_acpi_mount_matrix(struct device *dev, struct iio_mount_matrix =
*matrix, const char *method_name)
> > {
> >         return false;
> > }
> >
> > in include/linux/iio/iio.h ? =20
>=20
> Yes, like SPI, I=C2=B2C, etc. do in similar cases.
>=20
> > works for me and that also avoids Jonathan's worry about using an acpi_
> > prefix in iio code.
> >
> > Jonathan how does that sound to you ? =20
>=20
Good



