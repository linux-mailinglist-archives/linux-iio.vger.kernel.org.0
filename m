Return-Path: <linux-iio+bounces-9936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96E298A7D4
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A87E1F246E8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADFA1922F9;
	Mon, 30 Sep 2024 14:53:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CB191F7A;
	Mon, 30 Sep 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707981; cv=none; b=o6YwX9csH4+JH6AGnHxl08KTPYaLmmFbPmqFSwisMSMmQqCoq9czILs8UZiYVcCh7zqut0yZU8bp92FZT+IQ3FtNzaHadITV1v6fWmXhtY0Bnz2Rx54s06GbQIT0vMU2B7wnZMliNMgiEnNW3zGLk7RzDcGrdWWwLi4DJrKWQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707981; c=relaxed/simple;
	bh=xEfx68TKEKbrunn51KUOWGeLB8H7zXoKtykWGpU75XU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQGmvM/MmQS9KEDrch+4vK6HGK/L5sTDY1igtIELtSdTQR8hKLQ3GQDVrhkXG6LKEsVQw0qloaG1TP71SHUfik4+AuFN1JXa/Ut3dM4y9d1qcqKyXG/WgqPds0Shl22JpRLrnneE78otyiG5ljrfyNhZj0kE+i7ZN8fLceQ2IeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XHP8f1q97z6D9rT;
	Mon, 30 Sep 2024 22:48:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A16F140B30;
	Mon, 30 Sep 2024 22:52:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 16:52:55 +0200
Date: Mon, 30 Sep 2024 15:52:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <dlechner@baylibre.com>, Mark Brown
	<broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: dac: axi-dac: add ad3552r
 axi variant
Message-ID: <20240930155254.00004b8e@Huawei.com>
In-Reply-To: <6ce76f0a7c503cc800b4795e682f91c8bfc0bb7a.camel@gmail.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
	<20240929114606.7500ba7e@jic23-huawei>
	<sowmuxfsedwdshyothf7jc6mcrbzqbs2vzw7x4p3tg3iqnlnjt@5qa3kazkce46>
	<6ce76f0a7c503cc800b4795e682f91c8bfc0bb7a.camel@gmail.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Sep 2024 15:15:03 +0200
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-09-30 at 14:52 +0200, Angelo Dureghello wrote:
> > On 29.09.2024 11:46, Jonathan Cameron wrote: =20
> > > On Thu, 19 Sep 2024 11:19:58 +0200
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > >  =20
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Add a new compatible and related bindigns for the fpga-based
> > > > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > > >=20
> > > > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > > > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > > > mainly to reach high speed transfer rates using an additional QSPI =
=20
> > >=20
> > > I'd drop the word additional as I assume it is an 'either/or' situati=
on
> > > for the interfaces.
> > >=20
> > > Do we have other devices using this same IP?=A0 I.e. does it make
> > > sense to provide a more generic compatible as a fallback for this one
> > > so that other devices would work without the need for explicit suppor=
t?
> > >=20
> > >  =20
> > no, actually ad3552r-axi is only interfacing to ad3552r.
> > I could eventually set adi,axi-dac-9.1.b as a fallback, since it
> > is the "gneric" AXI implementation. =20
>=20
> Yes but the generic IP does not have this spi bus implementation so the d=
evice
> would be unusable (unless I'm missing something)
Falling back to the generic IP doesn't make sense as they aren't compatible.

I'd more expect some future device support that happens to need the same
sort of bus support might be able to use this FPGA IP.  Anyhow, it is fine
to fallback to this specific compatible anyway, so lets go with this rather
than trying for a generic name.

Jonathan

>=20
> - Nuno S=E1
>=20
>=20
>=20


