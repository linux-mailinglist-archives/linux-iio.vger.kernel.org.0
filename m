Return-Path: <linux-iio+bounces-25428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9011AC07CBE
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 20:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FF88566B57
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA4346E77;
	Fri, 24 Oct 2025 18:41:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABA1E98EF;
	Fri, 24 Oct 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331282; cv=none; b=aG7F1HLd3/vXlTah3rGDz7OWuht/bqPbFaim3OEbJ9qvduA7b5sEE/0qy7FEdHeh7LVSO9ScOBal5eRUw4Oq2Jz6v+PPpVVClptygqFYOdJcbQruDqbL+PUC9N/iG2Q8YjFtXt0DYABkMX0Av4sNdUOVnwkZfhTI+Fkzeu7E/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331282; c=relaxed/simple;
	bh=w1ujWxhmWuxUYS66/jXKPhJDpr15LDEM7NOuWwwpbr0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiFP4wXt9wNd5xgXcMbieHtWrtfdoETbq7kTgwqb97+LYadwjbUkW2tOgYw6IVDeepjuJKMlfPAA67VIdJHUPOr3eHgg/x9vpExXCV+8qmD0WoFWiDrZr5ZWr1bxM1+NqJ1vV5cQiDOyXB1R/E1XFiQAUJ243ibNPwvWZkkVfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctWsZ0CC3z6L59C;
	Sat, 25 Oct 2025 02:39:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9780F14014B;
	Sat, 25 Oct 2025 02:41:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 19:41:16 +0100
Date: Fri, 24 Oct 2025 19:41:15 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: dac: ad5456: Add missing DT compatibles
Message-ID: <20251024194115.000054bd@huawei.com>
In-Reply-To: <aPupTHhbvvMq4c7I@smile.fi.intel.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
	<20251023-ad5446-bindings-v2-2-27fab9891e86@analog.com>
	<aPupTHhbvvMq4c7I@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 24 Oct 2025 19:29:00 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Oct 23, 2025 at 02:01:38PM +0300, Nuno S=E1 wrote:
> > Add missing of_device_id compatibles for the i2c and spi drivers. =20
>=20
> How does it work at all? Is there an ugly ifdeferry?=20

Exactly that.

> No module should have two
> module_*_driver() and other stuff.
>=20
Indeed, hence not using that infrastructure.

I wouldn't mind more significant refactors...

J



