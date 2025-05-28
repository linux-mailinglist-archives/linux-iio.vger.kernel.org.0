Return-Path: <linux-iio+bounces-19996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5AEAC6EAC
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E263B6351
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F87288505;
	Wed, 28 May 2025 17:03:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CA1F0E56;
	Wed, 28 May 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451791; cv=none; b=LfGD6fBA55n6gKF6OIJ03e2Et3tmzRemIrZySvwqqmM8UIqvQg4lWutN9PYEO6l5D3UUr2xu1DC8vX00/He6n4M/gKYYIQ6h6kXRt5aASzN3eHxAatBTqiJgV6tVoPDf1yiOFXV7rbNp2fLluHKDPQc3Tleofw2MEJTcA+xuczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451791; c=relaxed/simple;
	bh=bYK9PvdbqxMVeFW9Ouqyb6CdE/trj8IRlYQZ9eKOgUA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdZymtfZ9FFVUpN4/YXsmCOBm+vibjKXJ/kaIaoin3Q9QjLMcPB4LPPFNjOEEnIXVlIKMQD2IK/co9MkHM16+UAOwbJBko3Nd09BnR1ceWKG3xHVLKPdsMSxcrLwztyuOpuTbMOwcU7oj6TbUUkUWE1yS11m3ZAjjhPoPrvysQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6whh5GtSz6L5N9;
	Thu, 29 May 2025 00:59:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1CB4140113;
	Thu, 29 May 2025 01:03:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 May
 2025 19:03:06 +0200
Date: Wed, 28 May 2025 18:03:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gyeyoung Baek <gye976@gmail.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: trigger: Avoid data race
Message-ID: <20250528180305.000079b7@huawei.com>
In-Reply-To: <CAKbEznv+GCBOaWxkgcufJrX4knYT=JKQC3iekowFThs7b7CuXw@mail.gmail.com>
References: <20250528080119.9380-1-gye976@gmail.com>
	<CAHp75VdhgftCKAuBuoDJ4d9HcKLqkGJ+bdx5gxQmkCSWO7SBAw@mail.gmail.com>
	<CAKbEznv+GCBOaWxkgcufJrX4knYT=JKQC3iekowFThs7b7CuXw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 28 May 2025 22:27:25 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> On Wed, May 28, 2025 at 6:22=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, May 28, 2025 at 10:01=E2=80=AFAM Gyeyoung Baek <gye976@gmail.co=
m> wrote: =20
> > >
> > > A data race could occur between `atomic_read()` and `atomic_set()`.
> > > Use `atomic_cmpxchg_relaxed()` to group them atomically.
> > >
> > > Previously the main logic was executed when `use_count` was 0.
> > > Now it returns early when `use_count` was not 0. =20
> >
> > This needs Fixes tag, otherwise LGTM,
> > Reviewed-by: Andy Shevchenko <andy@kernel.org> =20
>=20
> Yes, then I'll send v3, thanks!
Slow down :)

Reply to v1. In general don't rush new versions out so quickly.

>=20
> > --
> > With Best Regards,
> > Andy Shevchenko =20
>=20


