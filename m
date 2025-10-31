Return-Path: <linux-iio+bounces-25762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE8C25E5E
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98CF434FC54
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123C2E62A6;
	Fri, 31 Oct 2025 15:50:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A521FF35
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925821; cv=none; b=YnDcHzlzlvhem9ocq3YzRuW6WzsGxFJcTZMghRBGcmRvP+y/OQTnsgiSMXFRN+6XdJp6JcMBNfAk2qgJMFzknq8ggChGuGCsLSR57lL4C4uvdI8w6x8KRRG5sbdrwOiQBm9Hq4FPNC7J22RI1Mbc20uJ9NATYXR1HDHb19+nHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925821; c=relaxed/simple;
	bh=5B9WvgHjgL985Md9AgrbSfI8j9AjLdP3Z4IB72DZ6O0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5l3yka9ef1c3jI+q8Y65yCHRgNYtYt7yYAIMHPDy9puT1mSnUPLO4omQp9aeXL7R/p5DBlpRe9SSlgjiKaM3ZRQjVL3YAfrVzZZLT3cEGwgnxl0eSEt5yssUKriUseiYPFDGgYQYdRJhIowa1WlnHDHh/8w0he0M9/t/J3RqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cylhY67Hgz6GD5P;
	Fri, 31 Oct 2025 23:46:37 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EDFB1402F3;
	Fri, 31 Oct 2025 23:50:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 15:50:15 +0000
Date: Fri, 31 Oct 2025 15:50:14 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 02/10] iio: dac: ad5446: Use DMA safe buffer for
 transfers
Message-ID: <20251031155014.000018c7@huawei.com>
In-Reply-To: <aQTQtUUQpWY_L5q1@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	<20251031-dev-add-ad5542-v3-2-d3541036c0e6@analog.com>
	<aQS7YIxYH2suDmoS@smile.fi.intel.com>
	<83da9af88f23bc87c558e220d7d1a32a0d91403d.camel@gmail.com>
	<aQTQtUUQpWY_L5q1@smile.fi.intel.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 31 Oct 2025 17:07:33 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Oct 31, 2025 at 03:00:07PM +0000, Nuno S=E1 wrote:
> > On Fri, 2025-10-31 at 15:36 +0200, Andy Shevchenko wrote: =20
> > > On Fri, Oct 31, 2025 at 12:31:23PM +0000, Nuno S=E1 via B4 Relay wrot=
e: =20
>=20
> ...
>=20
> > > > +	union {
> > > > +		__be16 d16;
> > > > +		u8 d24[3]; =20
> > >=20
> > > Why not __be32 d24; ? Yes, it will require explicit size to be provid=
ed, but at
> > > least it will look consistent with the above. OR u8 d16[2]; ? But the=
n it becomes
> > > simply a u8 buf[3] __aligned...; =20
> >=20
> > Because I'm just keeping put_unaligned_be24() as before. In fact I'm ju=
st keeping the
> > same type. Sure we could do __be32 and the cpu_to_be32() with a proper =
shift but=20
> > I'm already doing way too much than I signed up for when sending v1 :) =
=20
>=20
> I think no shift would be needed.

Using a __be32 to me implies things we don't want to imply. In particular
if it's read in to &d24 then if interpreted as a __be32 it would be 256x
too big (I'd not do this for le24 either though which doesn't need the shif=
t)
The u8 [3] makes no such implication.

So I'd prefer sticking to storing be24 in a 3 byte location.

(just picking out this one bit to reply to).


