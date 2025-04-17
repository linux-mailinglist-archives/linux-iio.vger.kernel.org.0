Return-Path: <linux-iio+bounces-18201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB53A922F6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECCE4633A2
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DD254B0B;
	Thu, 17 Apr 2025 16:47:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0525290D;
	Thu, 17 Apr 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908471; cv=none; b=u/fuAHdNRIpYzZmK2t3go7Cdu3JXhl1YDoBtXUx8iNiq+ODERPLZlBhKHollx9/bGInJLnvR3nr0OJ3LT4KNEXrjukCCXsZjvx0n6pVhBG1HR/moh8/uCQdqrhZ+j5yxFDPRaiYRiGgiHkxSj9D4Fbdbfx8eYmPV8naVUNYRFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908471; c=relaxed/simple;
	bh=nWrQDIlA8rQPuxUJkMr95BwMdVJ0m+hXPuyEJovSlKg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGlGsMbRBSfsr8IRwbznEUCccIl5hbbC59dpbm3AjIch/CXbcyqR03XXywfVU/yJVIMrL+ixxcYycgRA1LBnZQ6AmSpKwLPWP3/jwV5GiYBiynRMSXgIV/q41YArCqa3Aj26mtWRjf+QL2XzjGfWUCoEeYTys0mWurCeMBZxSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZdkH468gxz6K9Nk;
	Fri, 18 Apr 2025 00:43:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 58361140146;
	Fri, 18 Apr 2025 00:47:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 18:47:45 +0200
Date: Thu, 17 Apr 2025 17:47:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Charalampos Mitrodimas <charmitro@posteo.net>
CC: Gabriel Shahrouzi <gshahrouzi@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linux.dev>, <gregkh@linuxfoundation.org>,
	<jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
	<Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: frequency:: Remove unused parameter from data
 documentation
Message-ID: <20250417174744.00007ea6@huawei.com>
In-Reply-To: <2cc70f19c1b001ea7f2cf0632618d060f69faef0.camel@posteo.net>
References: <20250417143220.572261-1-gshahrouzi@gmail.com>
	<56edfb88d3f31939fb343149bfad436f24671f9d.camel@posteo.net>
	<2cc70f19c1b001ea7f2cf0632618d060f69faef0.camel@posteo.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 15:57:48 +0000
Charalampos Mitrodimas <charmitro@posteo.net> wrote:

> On Thu, 2025-04-17 at 15:53 +0000, Charalampos Mitrodimas wrote:
> > On Thu, 2025-04-17 at 10:32 -0400, Gabriel Shahrouzi wrote: =20
> > > The AD9832 driver uses the Common Clock Framework (CCF) to obtain
> > > the
> > > master clock (MCLK) frequency rather than relying on a frequency
> > > value
> > > passed from platform data.
> > >=20
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > ---
> > > =A0drivers/staging/iio/frequency/ad9832.h | 1 -
> > > =A01 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/drivers/staging/iio/frequency/ad9832.h
> > > b/drivers/staging/iio/frequency/ad9832.h
> > > index 98dfbd9289ab8..d0d840edb8d27 100644
> > > --- a/drivers/staging/iio/frequency/ad9832.h
> > > +++ b/drivers/staging/iio/frequency/ad9832.h
> > > @@ -13,7 +13,6 @@
> > > =A0
> > > =A0/**
> > > =A0 * struct ad9832_platform_data - platform specific information
> > > - * @mclk:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0master clock in H=
z =20
> >=20
> > Hi Gabriel,
> >=20
> > This seems to be a leftover from
> > 566564e80b0ed23ffa4c40f7ad4224bf3327053a ("staging: iio: ad9832: use
> > clock framework for clock reference") =20
>=20
> That said, a Fixes: tag might be helpful?

Not for a documentation fix in a staging driver.  A reference
in the commit message is fine though.

Fixes tags tend to make people look at is as a possible thing to backport
and this is not something where that makes sense.

Jonathan

>=20
> >=20
> >=20
> >  =20
> > > =A0 * @freq0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0power up freq0 tu=
ning word in Hz
> > > =A0 * @freq1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0power up freq1 tu=
ning word in Hz
> > > =A0 * @phase0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0power up phase0 val=
ue [0..4095] correlates
> > > with 0..2PI =20
> >=20
> >  =20
>=20
>=20


