Return-Path: <linux-iio+bounces-23690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56767B42648
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7E67B3293
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D192BD5AF;
	Wed,  3 Sep 2025 16:11:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6C1E4AE;
	Wed,  3 Sep 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915875; cv=none; b=JJFlu8hQYHmAQRQmbndIDLHCJVJnZGrTB0dnrn5/pZtOiPR4Vh0gTWQeqBjwWIcWx5d4e2BjHIXZViIrO8rjf9PkBMr1ttLXxSJ6IqvIqN6xf2i5X6BVGJFHXgobrhGkrAblkjyeK0F3brEwYBaaHWtvbA4TowwHwPL6Pe7jqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915875; c=relaxed/simple;
	bh=IbusH9NWKOse/MmWhLMJmjfclKRjhrodSRa7rAqYtKg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWhchvWRM/kUdd2DFkmW0m5daHx609iw2EPt5+1ITCCJsuGjco9Vzo5O6b/VETruLkiUhqmBPBrUpWxn9peuo7lN3jnuTrHANTOZ+Apn9y00sgIYQdpJ/FZBs3pWGOfVr78KMAFdf0c0XKuUaF7yssC4yqIw6ItuJIkx5A3r2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cH6wm3ttyz6M54k;
	Thu,  4 Sep 2025 00:08:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 01B151400D9;
	Thu,  4 Sep 2025 00:11:09 +0800 (CST)
Received: from localhost (10.202.227.251) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 3 Sep
 2025 18:11:07 +0200
Date: Wed, 3 Sep 2025 17:11:05 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>, Ceclan Dumitru
	<dumitru.ceclan@analog.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v10 0/2] Add MAX14001/MAX14002 support
Message-ID: <20250903171105.00003dcd@huawei.com>
In-Reply-To: <dfcdaf9a-1980-4059-9268-2e9ae96831e8@baylibre.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
	<dfcdaf9a-1980-4059-9268-2e9ae96831e8@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)


>=20
> > because of the unique way this device handles communication, such as=20
> > inverting bits before sending a message, updating the write enable regi=
ster=20
> > before writing any other register, and updating it again afterward. How=
ever,=20
> > as I am still new to the IIO kernel code, I may be missing something. I=
f you=20
> > could provide further explanation or an example, I would be grateful.
> >=20
> > Regarding locking, Kim=E2=80=99s original code implemented it, and it r=
emains in=20
> > the driver.
> >=20
> > I still have a question about using _mean_raw (IIO_CHAN_INFO_AVERAGE_RA=
W)=20
> > to read the register containing the latest filtered average ADC reading=
s.=20
> > Should I create a v11 version with a patch to include in_voltageY_mean_=
raw=20
> > in the file /linux/Documentation/ABI/testing/sysfs-bus-iio?  =20
>=20
> There is already "/sys/bus/iio/devices/iio:deviceX/in_Y_mean_raw" which
> I think is intended to cover that.
>=20
> > The idea is to use in_voltageY_mean_raw to return the filtered average =
and=20
> > also to set how many ADC readings (0, 2, 4, or 8) are included in the m=
ean=20

0 is an odd value, I assume 1 given average of 0 readings is effectively un=
defined.

> > calculation. Any feedback on using IIO_CHAN_INFO_AVERAGE_RAW this way w=
ould=20
> > be appreciated.

Sorry I missed this question in earlier versions.  I'm terrible at reading
cover letters!

Definitely don't use the in_voltage_mean_raw value for the control of the a=
veraging
width.  That is too obscure and normal convention is read and write of
sysfs attributes should see effectively the same value (or not all
either read or write)

This is a little unusual as normally when we see this sort of thing it
easily maps to oversampling but in this case it's a moving window average
rather than a downsampling style.

So a few options come to mind.
1. Treat it as a filter on a channel. Describe with 3dB point and type as
   box filter.
   We probably want to describe it as an additional channel to do this or
   we could have assumption that to read unfiltered, you set the
   filter 3dB to inf (see other discussion ongoing about that).

2. Add another attribute to add richer info to the in_voltage_mean_raw
   Something like in_voltage_mean_num.
   Bit of a special case but we have had the mean_raw interface a long time
   so we can't get rid of that and it seems illogical to force use of filter
   ABI to control it.

> >=20
Other stuff from David followed but I have nothing to add to that.

Jonathan


