Return-Path: <linux-iio+bounces-24012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A7BB550BF
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7B518939F3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0EA1B043F;
	Fri, 12 Sep 2025 14:17:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458218C933;
	Fri, 12 Sep 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686645; cv=none; b=tX11yk7ZZBu+Dw9/moJGGf5jGq+OaGp2sdIfH/RDl9Y+OZTmUo8J18C4L8xeAhk3h9IbFne1enDeGYKrB6UFMi9lV+sbZbEFT4CK9L7deoqc8hBZcGqAK3wDkSF4nSduM5wyrAuiMbtsrRsHbBOfjRLgsSz/NvcXlCLuoWF3kkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686645; c=relaxed/simple;
	bh=vWyWef9WiM1nBK/W0nbnwpMsl/nNEAkLwjqhNQkndJM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDraWQrsFUGutdzVUCS6LWg8ql6nEvCYd0bRCBY/TIOfAfYFqYqkjUEGOlQ0XBaeqQOuAs/yZXjsujXrervwYqwyCzN66MJ6R2d1rfPTp8N+RF99nHMHGTCGUSy4fBRjtLaJnO+e/tzPegB9gXjMJw6rXZl8qW6sd2mbPHBK/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNc0f0DXBz6GDJ7;
	Fri, 12 Sep 2025 22:16:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 568AC1402EA;
	Fri, 12 Sep 2025 22:17:20 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 16:17:19 +0200
Date: Fri, 12 Sep 2025 15:17:18 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>, Jonathan Cameron
	<jic23@kernel.org>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <s32@nxp.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <chester62515@gmail.com>, <mbrugger@suse.com>,
	<ghennadi.procopciuc@oss.nxp.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20250912151718.00004cf1@huawei.com>
In-Reply-To: <c746e72c-dbd9-4afb-9da4-5d13733fd561@baylibre.com>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
	<20250910155759.75380-3-daniel.lezcano@linaro.org>
	<20250910183212.6640e662@jic23-huawei>
	<b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
	<c746e72c-dbd9-4afb-9da4-5d13733fd561@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 11 Sep 2025 08:26:06 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/11/25 7:55 AM, Daniel Lezcano wrote:
> >=20
> > Hi Jonathan,
> >=20
> > thanks for the review
> >=20
> > On 10/09/2025 19:32, Jonathan Cameron wrote: =20
> >> On Wed, 10 Sep 2025 17:57:56 +0200
> >> Daniel Lezcano <daniel.lezcano@linaro.org> wrote: =20
> >=20
> > [ ... ]
> >  =20
>=20
> ...
>=20
> >  =20
> >>> +=A0=A0=A0 indio_dev->name =3D dev_name(dev); =20
> >>
> >> This should be the 'part number'.=A0 That is a little ill defined
> >> for a SoC integrated ADC, but generally not what we get from dev_name()
> >> on the platform_device. =20
> >=20
> > Sorry, I don't get the comment. If I refer to the different drivers the=
re is not consistency with the iio_dev->name. =20
>=20
> dev_name() will be something like adc@12345678 from the devicetree,
> so not the "part number".
>=20
> >=20
> > rtq6056.c:=A0=A0=A0=A0=A0 indio_dev->name =3D "rtq6056"; =20
>=20
> This style is preferred if there is only one supported part.
>=20
> > rzg2l_adc.c:=A0=A0=A0 indio_dev->name =3D DRIVER_NAME; =20
>=20
> We try to avoid using a macro for the driver name like this.
>=20
> > sc27xx_adc.c:=A0=A0 indio_dev->name =3D dev_name(dev); =20
>=20
> Looks like we missed catching this one in review.

There are a bunch of historical drivers (and maybe some more recent
ones that snuck in). The risk of changing that ABI seemed too high to fix t=
hem
up.  I guess this happens often enough I should add a comment to the ones
that still do this about it being wrong but left alone as the ABI was in us=
e.


>=20
> > mt6359-auxadc.c:=A0 indio_dev->name =3D adc_dev->chip_info->model_name;=
 =20
>=20
> This is preferred if there is more than one part supported in the driver.
>=20
> > mcp3911.c:=A0=A0=A0=A0=A0 indio_dev->name =3D spi_get_device_id(spi)->n=
ame; =20
>=20
> This is fine too in cases where there isn't chip_info.
>=20
> >=20
> > Are you suggesting to use the compatible part number ?
> >=20
> > =A0=A0=A0=A0indio->name =3D "s32g2-sar-adc";
> >  =20
>=20
> That works.
>=20
>=20
>=20


