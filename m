Return-Path: <linux-iio+bounces-6180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A909890422E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 19:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB73D1C236D3
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09A64502B;
	Tue, 11 Jun 2024 17:11:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80E57CB5;
	Tue, 11 Jun 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125885; cv=none; b=m2wj67R9oSfvn8DK7IkCG/bpQZtBMsnA+hCplaToFyqAwEoamIstKuipAWiqnRoY2DtpMKiJ6aNSR0If/CJnGnp349HeX1Yo5DIfG5qdO8QIvnPSlLmIQA4dqxzVUnc1wi/NagOAjTxn5ToGy/nY+nBTy5MZdG5qFDTERg5KH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125885; c=relaxed/simple;
	bh=nJV+AWdoa5PG31ek6YOa8xLuzY1feaTl5am+McYuui8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxe1PlyplA97iVcEVFDbEJldhA3BCqUIh6BFoR4UeluWtAzfR+cKUQnKVGJ7yO7dg9LMmmv36qmbA0I34LaYgZYrs6E5n5/0W+1H02Rw9WwKeJrqjDSS2RaXktt1xBueeIgeoozKVi9JPQrwfXs/pMVcAzwum1P9xNF1Lh/9NO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzFT16J1nz6JB4v;
	Wed, 12 Jun 2024 01:06:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B7C841404FC;
	Wed, 12 Jun 2024 01:11:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 18:11:21 +0100
Date: Tue, 11 Jun 2024 18:11:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, "Petr
 Mladek" <pmladek@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, "Olivier
 Moysan" <olivier.moysan@foss.st.com>, Jyoti Bhayana <jbhayana@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Chris Down
	<chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Andi Shyti
	<andi.shyti@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
Message-ID: <20240611181120.00002193@Huawei.com>
In-Reply-To: <2d7164356496ab910bdbcac471f91d874b9e075d.camel@gmail.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	<20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
	<20240608190600.622dfd7f@jic23-huawei>
	<2d7164356496ab910bdbcac471f91d874b9e075d.camel@gmail.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 10 Jun 2024 09:11:28 +0200
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-06-08 at 19:06 +0100, Jonathan Cameron wrote:
> > On Thu, 6 Jun 2024 09:22:38 +0200
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >  =20
> > > Use dev_err_probe() (and variants) in the probe() path. While at it, =
made
> > > some simple improvements:
> > > =A0* Explicitly included the err.h and errno.h headers;
> > > =A0* Removed some unnecessary line breaks;
> > > =A0* Removed a redundant 'else';
> > > =A0* Added some missing \n to prink.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > --- =20
> >=20
> >  =20
> > > @@ -1296,8 +1268,8 @@ static int ltc2983_reg_access(struct iio_dev
> > > *indio_dev,
> > > =A0
> > > =A0	if (readval)
> > > =A0		return regmap_read(st->regmap, reg, readval);
> > > -	else
> > > -		return regmap_write(st->regmap, reg, writeval);
> > > +
> > > +	return regmap_write(st->regmap, reg, writeval);
> > > =A0} =20
> >=20
> > Unrelated.
> >=20
> > Otherwise updates look correct to me. =20
>=20
> Yeah, I know. It was simple enough that I sneaked it in and did mentioned=
 it in
> the commit message hoping it would make the change acceptable in here :)
>=20
lol. I didn't read the commit message.  Fair enough.

> - Nuno S=E1
>=20
>=20


