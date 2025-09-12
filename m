Return-Path: <linux-iio+bounces-24015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8BB55118
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8C17C75F0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF131A57E;
	Fri, 12 Sep 2025 14:21:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A531A058;
	Fri, 12 Sep 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686894; cv=none; b=TuNasoTZ36y5GL3OSaiMNhOPYAv+fu5rlRJLdSbfQH2TbNi1CdDv3J80hJBdTAj5XMQESwkeah24LIed2p+Nlwt6sPiT7IZZpcLkCa3Fq4AXGs0+okGFTB/tIMl6V/8kF8muiuyQNLLbcTV2RCmhxngdIRl24OZl/KR/NfUmHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686894; c=relaxed/simple;
	bh=qXqoxJcbp+qncwtNqhJPGBaUzokhKiJrHtbDDy4M3JM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWlFgqCZ6WRGPRDw8FGzTrIuMq+YWYMwHAlkzfLcWqQVwa3rW0inq5976nNCrWh5t3OOXUQ8l86ttjVuMwrbmavxBDIr0xzyzV4ASeycbfSnJuq/UTxFxfhPRedgMw9e7Wo8bcUN1+WCBLh7TUeiGaYMtlU+Mbu2VF8snGt1m/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNc3r34N7z6M53c;
	Fri, 12 Sep 2025 22:18:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DCED51404D8;
	Fri, 12 Sep 2025 22:21:29 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 16:21:28 +0200
Date: Fri, 12 Sep 2025 15:21:27 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, David Lechner <dlechner@baylibre.com>,
	<jic23@kernel.org>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <s32@nxp.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <chester62515@gmail.com>, <mbrugger@suse.com>,
	<ghennadi.procopciuc@oss.nxp.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20250912152127.000039fe@huawei.com>
In-Reply-To: <5e279cf72409504861c80bb4d2e4e5f6bc59d94c.camel@gmail.com>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
	<20250910155759.75380-3-daniel.lezcano@linaro.org>
	<d53b22d1-35d6-4fb8-ae56-3ba4953b64af@baylibre.com>
	<ea57a466-97b3-49d4-8d1c-142fd49a0da2@linaro.org>
	<CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com>
	<5e279cf72409504861c80bb4d2e4e5f6bc59d94c.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 12 Sep 2025 09:19:43 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-09-12 at 08:38 +0300, Andy Shevchenko wrote:
> > On Fri, Sep 12, 2025 at 2:03=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote: =20
> > > On 11/09/2025 22:10, David Lechner wrote: =20
> > > > On 9/10/25 10:57 AM, Daniel Lezcano wrote: =20
> >=20
> > [ ... ]
> >  =20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* iio_push_to_buffers_with_timestamp should not be called
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * with dma_samples as parameter. The samples will be
> > > > > smashed
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * if timestamp is enabled.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */ =20
> >=20
> > /*
> > =C2=A0* Btw, comment style for multi-line
> > =C2=A0* comments is wrong for this subsystem.
> > =C2=A0* Use this as an example, Also, refer to
> > =C2=A0* the function as func(), i.e. mind the parentheses.
> > =C2=A0*/
> >  =20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 timestamp =3D iio_get_time_ns(indio_dev);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D iio_push_to_buffers_with_timestamp(indio_dev,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 info->buffer,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 timestamp); =20
> > > >=20
> > > > Is it OK to call this with spinlock held? It looks like it can call
> > > > devm_krealloc() which may sleep. =20
> > >=20
> > > It should be ok, devm_krealloc is in the code path of
> > > iio_push_to_buffers_with_ts_unaligned(), not in
> > > iio_push_to_buffers_with_timestamp() =20
> >=20
> > This is a good observation, can we document this in the respective
> > kernel-doc:s please? Also add might_sleep().might_sleep_if() in the
> > appropriate functions. =20
>=20
> That's a good idea!

Agreed. I'd forgotten that hidden allocation was there in the unaligned()
variant.  A might_sleep() seems wise.

>=20
> - Nuno S=C3=A1


