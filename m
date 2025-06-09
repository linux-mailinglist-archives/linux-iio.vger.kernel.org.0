Return-Path: <linux-iio+bounces-20329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3CAD1ACB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC65B163B9C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B124EF88;
	Mon,  9 Jun 2025 09:39:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40791E51FE
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461960; cv=none; b=soujSPPCbJs0siWCD5Tn79PSVQ/ETQNOe2xJQRIss4fQlf92oKgYGf6Fo8sDpl2s2AgnuIIWFoEL56eeEFK98DITZI9uvOHplWvKn52FstE651ECVmqYs/9JRoJPersDrZ04Gc3Jy21eErPfwWI3xuiHDWi83g8l5nR6gI1YFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461960; c=relaxed/simple;
	bh=CJEe92pdBLcL90uVY9SgLzBeqCedPDSU1I9+DZAm8Bo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaJBSXiz9HNReOOzneeOPuvkWjW9x8rcpMWnYNvM48Ph71KPZbk/oAD53ZNNJWObT07uf2zscLDckVlwtepyLoo0yhjMuZQfqt7mn33fcEXduPj2UCvfhjNFG8qzAjwB836NICBVbBI/AVZoCxHLgVonRdmWo9/HnIVjAGNJWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bG6LZ5xkWz6M4qF;
	Mon,  9 Jun 2025 17:38:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EE562140519;
	Mon,  9 Jun 2025 17:39:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 11:39:07 +0200
Date: Mon, 9 Jun 2025 10:39:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: dummy: Drop unused export.h include.
Message-ID: <20250609103905.00004bee@huawei.com>
In-Reply-To: <CAHp75Vdovs=REuauj_zU3V_aw+zUjWY-pKV5sEuayJb9By1JkQ@mail.gmail.com>
References: <20250609070616.3923709-1-jic23@kernel.org>
	<20250609070616.3923709-3-jic23@kernel.org>
	<CAHp75Vdovs=REuauj_zU3V_aw+zUjWY-pKV5sEuayJb9By1JkQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Jun 2025 12:27:33 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 9, 2025 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Resolves:
> >   warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> i=
s present =20
>=20
> While this true...
>=20
> >  #include <linux/kernel.h> =20
>=20
> ...I prefer a full and not half-baked solution, i.e. revisiting all
> headers and esp. replacing kernel.h with what is used.
>=20
> > -#include <linux/export.h>
> >  #include <linux/slab.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h> =20
>=20
> While doing that, the headers may be sorted (in the same or preparatory p=
atch).
>=20

Whilst I agree that more work is need, I also don't like the time it might
take to get to it and the warnings that might mean more significant issues =
get
missed in the wash in the meantime.

Jonathan

