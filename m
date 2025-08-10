Return-Path: <linux-iio+bounces-22521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FDB1FBA9
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1761899AD3
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32652727E6;
	Sun, 10 Aug 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw6kDkH2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26272475C3;
	Sun, 10 Aug 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754850348; cv=none; b=XK49OERZWJWJpZ90Dd8XFF8ikHC1P665lcvL8jLBJQl/7dcv5O+MbTDHgE031yZInv1Ai80Jzh1DCltwL8mEgUz+SpLerQp1fXHaR91i8oJCGB4eS5IlktzfsjARvujuXEChMbg5cWSKvunJkNcH3tf9ZyLL6vSrYgA5UgezavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754850348; c=relaxed/simple;
	bh=cHUvKE0uzLE5GpEm+b1ft6VrM0liU5poatPyQlzQxHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYIxlN8aK6AyT1mTnvhzwRBTL6mOhBbBgj0yEdvvJ0EoUOQZXRyMW/wuY0/FKio2HgdhY2i5ubdCPn+lvzviC+T3hjCpqr499TShEIvOS+OeBh6/mn6Ev8UQEJDycuKqXT+dNu4LUic6jzPhVfm6ZBJA5Ei6cY7jZd1SJsFg6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw6kDkH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3637DC4CEF1;
	Sun, 10 Aug 2025 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754850348;
	bh=cHUvKE0uzLE5GpEm+b1ft6VrM0liU5poatPyQlzQxHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cw6kDkH2/KD0DYq15pzE8EGOWPy9fKAZ5O6yi+T6p6SnFQl0AhoxVEo3xc+ZRJOvW
	 qY9Nlmdi1qjwHLJCa7UlE1O/pN54rpqbywBqbI1v3Bny20UukQiun9ZbYb7A0uyGtJ
	 ak8R61rJNy0COLr8blPYxwArd9yPfoKIodHPwpt0gjxc8ubUQ+4t0+DvEZDKgzMFpe
	 z7qGVxYcc/NX2PXeQOnkVb3h4mwz27rZsI/2wpA78OvarWy7P9M8fZKFWyD5LNYkXz
	 9pmSKQ5ITydkWHtFz7wbIkym2XIzHfGZlJ9CavUjfhNKxEXM0QC5gMyewrnVVX/ERC
	 Qu8h/xZXrzfyg==
Date: Sun, 10 Aug 2025 19:25:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lothar Rubusch
 <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <20250810192542.1443ecb5@jic23-huawei>
In-Reply-To: <raapwni4cn2lmazn7n2yvmjocmgntwram4wj2guvo5vwslhjbl@ni3elcf4ptn7>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
	<20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
	<aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
	<aHYIBReTFqJMtiXW@smile.fi.intel.com>
	<vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
	<aHd2s987EMCdgdrJ@smile.fi.intel.com>
	<20250724162227.065d20a0@jic23-huawei>
	<aIKlC-HlP3nX-ERA@smile.fi.intel.com>
	<20250727164909.1833c4bc@jic23-huawei>
	<20250802125821.2ae1b17b@jic23-huawei>
	<raapwni4cn2lmazn7n2yvmjocmgntwram4wj2guvo5vwslhjbl@ni3elcf4ptn7>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Aug 2025 19:26:03 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> On Sat, Aug 02, 2025 at 12:58:21PM +0100, Jonathan Cameron wrote:
> > >  =20
> > I got lost in this thread, so perhaps am assuming there is a v5 to come.
> >=20
> > Maybe just send one anyway even if no changes as it'll jump up my list =
to look at.
> >=20
> > Jonathan
> >  =20
>=20
> Hi Jonathan,
>=20
> Yes, I=E2=80=99ve yet to send v5. Just a quick reminder: patches 1 and 2 =
from
> this series were already accepted as of v3.
>=20
> Regarding v5, would it make sense to split it into two separate patches:
> one for the motion events and another for the ABI documentation?

I'm a bit lost (and short on time, after a garage door crisis - always
have spare cables and helpful friends - both of which I did :)

Anyhow, if ABI is custom in same patch as the code that implements it.
If documenting new or existing (docs missing) then separate patch.

Jonathan

