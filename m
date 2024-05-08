Return-Path: <linux-iio+bounces-4872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07518BFBED
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BFD283740
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 11:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2F81ADA;
	Wed,  8 May 2024 11:26:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B9763EC;
	Wed,  8 May 2024 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167564; cv=none; b=Xkk5QWNdv3Yrgi+4UWwuKdumLFOs74awJuNyGJkvY1+sAtxxHyLmzYGAluGNEaYAQ/Q6GrXVYlqvf5/iFmrM0fLDxKHLSTi6JiIfv9kmJ/M+lj+gpNJE/9KGY6CheLanENlKyMw+jL26jfTR2amKBzj/nqfMULGwmS1vgeHcNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167564; c=relaxed/simple;
	bh=qm/H/Coqs9tjdAzYf9iqc0Y4L26GcbCvPj+NsxUvvDo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qx+p+BoGU7KGcoFtlqcyofcrNdDCZhGA+0jnzKK87qToPFkhW6CGbGO0Mo2BZfIkNghx+ZXVZoGvgwjdVLsfU/Q9PrFo8rAsu6F8C0j8Ilnkm+0xtJa/o1Zr8O6bFC3NUZw7+Xot7yh5thcWXiN3HRxDR5w4gLWKbaJ4v/MGaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZCS326vtz6J9St;
	Wed,  8 May 2024 19:22:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A347F140CF4;
	Wed,  8 May 2024 19:25:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 May
 2024 12:25:58 +0100
Date: Wed, 8 May 2024 12:25:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Julien Stephan
	<jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel test
 robot <lkp@intel.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 09/10] iio: adc: ad7380: add support for rolling
 average oversampling mode
Message-ID: <20240508122556.00005f71@Huawei.com>
In-Reply-To: <CAMknhBFx-KVPRbm1xmKeU8ZaA7qt_c0_6eiUT-5kqTWVAvf3hw@mail.gmail.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com>
	<20240506151725.10cf025e@jic23-huawei>
	<CAMknhBFx-KVPRbm1xmKeU8ZaA7qt_c0_6eiUT-5kqTWVAvf3hw@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 6 May 2024 10:04:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Mon, May 6, 2024 at 9:17=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Wed, 01 May 2024 16:55:42 +0200
> > Julien Stephan <jstephan@baylibre.com> wrote:
> > =20
> > > Adds support for rolling average oversampling mode.
> > >
> > > Rolling oversampling mode uses a first in, first out (FIFO) buffer of
> > > the most recent samples in the averaging calculation, allowing the ADC
> > > throughput rate and output data rate to stay the same, since we only =
need
> > > to take only one sample for each new conversion.
> > >
> > > The FIFO length is 8, thus the available oversampling ratios are 1, 2=
, 4, 8
> > > in this mode (vs 1,  2, 4, 8, 16, 32 for the normal average) =20
> >
> > Ah. I should have read on!
> > =20
> > >
> > > In order to be able to change the averaging mode, this commit also ad=
ds
> > > the new "oversampling_mode" and "oversampling_mode_available" custom
> > > attributes along with the according documentation file in
> > > Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 since no standard
> > > attributes correspond to this use case. =20
> >
> > This comes to the comment I stuck in the previous patch.
> >
> > To most people this is not a form of oversampling because the data rate
> > remains unchanged. It's a cheap low pass filter (boxcar) Google pointed=
 me at:
> > https://dsp.stackexchange.com/questions/9966/what-is-the-cut-off-freque=
ncy-of-a-moving-average-filter
> >
> > in_voltage_low_pass_3db_frequency would be the most appropriate standard
> > ABI for this if we do treat it as a low pass filter control.
> >
> > I'm not necessarily saying we don't want new ABI for this, but I would
> > like to consider the pros and cons of just using the 3db frequency.
> >
> > So would that work for this part or am I missing something?
> > =20
>=20
> I like the idea. But from the link, it looks like the 3dB frequency
> depends on the sampling frequency which is unknown (e.g. could come
> from hrtimer trigger).
>=20
> Would it be reasonable to calculate the 3db frequency at the max
> sample rate that the chip allows and just use those numbers?
>=20
Ah. So looking at datasheet the normal average oversampling is
self clocked, but this version is not.

So, I'll ask the dumb question.  What is this feature for?
We have to pump the SPI bus anyway why not just do the maths in
userspace?  Oversampling is normally about data rate reduction
with a bonus in precision obtained.

Jonathan







