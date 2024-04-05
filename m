Return-Path: <linux-iio+bounces-4079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B34F899AFD
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 12:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D4F1F214F7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3A136660;
	Fri,  5 Apr 2024 10:36:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE428E34
	for <linux-iio@vger.kernel.org>; Fri,  5 Apr 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313388; cv=none; b=NWrdxdFzapozKtwAHpimwBVVhh8NMj4EoJeLvPA1c+GgECjAFKByHNbkIpJWXNp7g3wn3bPkpS/2P0xC6TaUg9XlHCWzqblZxgbi/NuFy7GdLYdSAjEPWH3WIWTZk7ORl1uPTpfw4Hp/MMoaFr+09z5+oNEKDV+tZAlHyHDq0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313388; c=relaxed/simple;
	bh=8efIKHAsN4AF0hZ8yIRyMgJRXnh4qtzOKk7TlE7odzM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjrQHfN1doZ86ov55JwhXEBaulVknpbvr0CTBi1bvoxgGpNcInZ5H70HEzjdvSI6sROhuIxbos5mWMtlWalx8uiIFVw7Df7d5m2VUh+9IlZbOO7EkNnv/1kOpecUJJuslgyVUoLAvZqBKownbGCdbHVzjwM5f3oWDAa+7ODnUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9vxx30Pgz6J6hn;
	Fri,  5 Apr 2024 18:35:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CCDC71400D1;
	Fri,  5 Apr 2024 18:36:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 11:36:23 +0100
Date: Fri, 5 Apr 2024 11:36:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Marius
 Cristea" <marius.cristea@microchip.com>, Mihail Chindris
	<mihail.chindris@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>, Dumitru Ceclan
	<mitrutzceclan@gmail.com>, Cosmin Tanislav <demonsingur@gmail.com>, Nuno Sa
	<nuno.sa@analog.com>
Subject: Re: [PATCH 1/8] iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
Message-ID: <20240405113622.00000896@Huawei.com>
In-Reply-To: <CACRpkdZzOi5vv6yxqheqGZAZYBLTEL-uB=dt-i6ByDEhF6H0Kw@mail.gmail.com>
References: <20240330190849.1321065-1-jic23@kernel.org>
	<20240330190849.1321065-2-jic23@kernel.org>
	<CACRpkdZzOi5vv6yxqheqGZAZYBLTEL-uB=dt-i6ByDEhF6H0Kw@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 4 Apr 2024 13:36:15 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Mar 30, 2024 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
>=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The dependencies on various ab8500 components prevent this driver
> > being useful but they don't seem to prevent it being built.
> > Improve build coverage by allowing COMPILE_TEST.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
>=20
> ...but I think AB8500_CORE is a hard requirement because
> <linux/mfd/abx500.h> does not provide register accessor stubs?
>=20
hmm. I clearly didn't test enough.  Ah well, I'll drop this one.
> Yours,
> Linus Walleij


