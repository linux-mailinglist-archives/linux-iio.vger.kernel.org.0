Return-Path: <linux-iio+bounces-6249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B99078F2
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED13DB2366E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD301149C54;
	Thu, 13 Jun 2024 16:58:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC626AF0;
	Thu, 13 Jun 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297914; cv=none; b=GNXadvduh0xD/5NlahLmrRcbS7mCmhIQYo3/4LsxKBSIDxHzuiubturCl3TdOX6M58Q8phEhiIDLWwib6P1jxKk8J2QGQmk+4lvJd9RoUw5u8Klaw1zoHpW1w+vNxHVpNgO7mIZhK6/VPODwKcN3NR455k1pJROyts0LjcQnrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297914; c=relaxed/simple;
	bh=bT3sz1RanAtOG0QsxHVOiCO2oCWoAEMKDaJyL0+iMDY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxgYcGpErSmBzclRHqSmIJgi7C4XZBSHjckdGQzbxoPP+JLm/0InC+d3Ilr2Js0TElj9d0noEaDbHn/h3zJbMaJS8YRJ9OAy2e/HukR3w3AfOcScOsf2caZp4TTJkA/aTJ8C7uKMFefdKXh8ZvNWiCiJZWty/qP/Ly5JqAme/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0TBV4jHqz6K6Wl;
	Fri, 14 Jun 2024 00:58:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DA3F140A70;
	Fri, 14 Jun 2024 00:58:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 17:58:28 +0100
Date: Thu, 13 Jun 2024 17:58:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nuno.sa@analog.com>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] minor fixes and improvements
Message-ID: <20240613175826.000040e7@Huawei.com>
In-Reply-To: <9e21de1f-d0b1-4a00-a73d-9f35d8cedf1b@baylibre.com>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
	<751faef385f81f8a2dd0dcc2acd2d4519bebebe5.camel@gmail.com>
	<20240525180631.13446abc@jic23-huawei>
	<826c3185-74ca-423c-96f2-4fd4cf2481cb@baylibre.com>
	<9e21de1f-d0b1-4a00-a73d-9f35d8cedf1b@baylibre.com>
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

On Wed, 12 Jun 2024 18:35:32 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan, Nuno,
>=20
> just to be sure, is there something else needed from my side
> for this patch-set ?
>=20

All good now.  It's queued up and so just a case of me sending a pull reque=
st
to Greg KH. If he takes that it'll then be in char-misc and Greg will then =
send
pull request to Linus when the merge window opens.

Jonathan

>=20
> Thanks,
> regards,
> angelo
>=20
> On 28/05/24 9:16 PM, Angelo Dureghello wrote:
> > Hi Jonathan,
> >
> > On 25/05/24 7:06 PM, Jonathan Cameron wrote: =20
> >> On Thu, 23 May 2024 14:45:01 +0200
> >> Nuno S=E1 <noname.nuno@gmail.com> wrote:
> >> =20
> >>> On Wed, 2024-05-22 at 17:01 +0200, Angelo Dureghello wrote: =20
> >>>> From: Angelo Dureghello <adureghello@baylibre.com>
> >>>>
> >>>> After testing this driver, add some minor fixes and improvements,
> >>>> as adding single channel variants support (ad3541r, ad3551r), also=20
> >>>> as a
> >>>> preparatory step to bigger future improvements related to fast-rate=
=20
> >>>> mode
> >>>> for this DAC family.
> >>>>
> >>>> Previous patches (v1, 3/3)
> >>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-1-adureghel=
lo@baylibre.org=20
> >>>>
> >>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-2-adureghel=
lo@baylibre.org/=20
> >>>>
> >>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-3-adureghel=
lo@baylibre.org/=20
> >>>>
> >>>>
> >>>> Angelo Dureghello (6):
> >>>> =A0=A0 dt-bindings: iio: dac: fix ad3552r gain parameter names
> >>>> =A0=A0 dt-bindings: iio: dac: add ad35xxr single output variants
> >>>> =A0=A0 iio: dac: ad3552r: add model data structure
> >>>> =A0=A0 iio: dac: ad3552r: add support for ad3541r and ad3551r
> >>>> =A0=A0 iio: dac: ad3552r: change AD3552R_NUM_CH define name
> >>>> =A0=A0 iio: dac: ad3552r: uniform structure names
> >>>>
> >>>> =A0=A0.../bindings/iio/dac/adi,ad3552r.yaml=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0 43 ++++--
> >>>> =A0=A0drivers/iio/dac/ad3552r.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 | 140=20
> >>>> ++++++++++++------
> >>>> =A0=A02 files changed, 128 insertions(+), 55 deletions(-) =20
> >>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >>> =20
> >> This series crossed with a series using
> >> device_for_each_child_node_scoped()
> >>
> >> I've rebased on top of that. Was moderately straightforwards but
> >> given last week I messed a similar change up completely please
> >> check the testing branch of iio.git!
> >>
> >> The mess was all it the patch adding model_data =20
> >
> > i tested the driver from the iio testing beranch,
> > it works as expected.
> > =20
> >> Thanks,
> >>
> >> Jonathan =20
> >
> > Thanks,
> >
> > Regards,
> > angelo
> >
> > =20


