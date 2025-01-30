Return-Path: <linux-iio+bounces-14734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C96CA2318C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BC9163123
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523071EC01E;
	Thu, 30 Jan 2025 16:10:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712A1E47B7
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253440; cv=none; b=f+9ANti1Q8eKkq9zZBIeabQFFU6zGKeabuXSI4Gk5//JQSffkiLBMiL1FyvRLPcxOctXUEu4EChyj+VcH5pCCPe0kYGneoQTW+AmfH+tlTKoA2CcgqeCTehFx7fooZZRPi/85Yb3EMMrS9cSkkLgM5rGeq4ZJpfH9wios9n6d40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253440; c=relaxed/simple;
	bh=9UsS9yO9mChKslbX5oSPf6QF5kvDZ3Li3S2hwdpzIcA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntZbDVBncUOHRdZKy/yDhHXKLlaaJ/VfYZdC7Ro9cmD+UnwB3ZAy0gg+5cU1mQjYvFKvGK4WYMXmTvBOkaYQSdLgU1i01Ia21rfHquGfb1e1b8OmzAYBIkIZwl1FGaCO9zhCmJNEkqJEcnfsNqascX0T7KdDyPXm4FKXWjrnYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkP7z3lmjz6L4s3;
	Fri, 31 Jan 2025 00:08:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D6B38140523;
	Fri, 31 Jan 2025 00:10:34 +0800 (CST)
Received: from localhost (10.195.245.124) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 17:10:34 +0100
Date: Thu, 30 Jan 2025 16:10:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, David Lechner
	<dlechner@baylibre.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 02/20] io: adc: ina2xx-adc: Fix sign and use aligned_s64
 for timestamp.
Message-ID: <20250130161032.00002e57@huawei.com>
In-Reply-To: <g6jrubgedsti3pi3qretmcvupyvh7lhu4uy3gnmkglb3dpjakf@dciteiogio3h>
References: <20241215182912.481706-1-jic23@kernel.org>
	<20241215182912.481706-3-jic23@kernel.org>
	<g6jrubgedsti3pi3qretmcvupyvh7lhu4uy3gnmkglb3dpjakf@dciteiogio3h>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 30 Jan 2025 16:40:04 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> this patch is in next as 1b54068b5934a871f1895adc5e5ca4355781eeb7.
>=20
> Maybe it's already to late for that, but if not:
>=20
> 	$Subject ~=3D s/io:/iio:/
>=20
> Best regards
> Uwe
>=20

Long gone :( It's in mainline.

Jonathan

