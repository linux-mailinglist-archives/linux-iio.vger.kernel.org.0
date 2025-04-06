Return-Path: <linux-iio+bounces-17660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0782A7CD9F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 12:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B420188D488
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856019C546;
	Sun,  6 Apr 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr5Ff5x4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FF1C27
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743936866; cv=none; b=oTH/Z2V7Fejf9YPE7fnzhlvV5BXA+IBNvnb0rHo89E3sZLXmVqYn575A4nUaeKJCNV7rrCO071wn/Z6xilf+3ZLz+J6sMCtDFKXCN3YcLnSl0j5RBtFVzIZrYTnafxDa1Cq9JW6gbLzpH397pNKTHdAsRo7O4ofOC5nu5ZnOeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743936866; c=relaxed/simple;
	bh=AI3VwxhC48ab58YuPeSp4QwxNjpNQsANwom2Wa6mlbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIM0nzYRbb8VQ1gvzOhtuneM4GbDlts8j9dCh/EyvRpCKfT9x7CYPJ2Dq6ZiLwCZ+Wvkm8HEyE7A7ZJE8TgglWnIeMXwc6MvhbmVzaVkwkMjknt/Wy8InyoYGbE6yBA8FlrG5AZw3B6NDOJAQ2HjxBNGzxj95idVNDkcND1ZJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr5Ff5x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF80C4CEE3;
	Sun,  6 Apr 2025 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743936865;
	bh=AI3VwxhC48ab58YuPeSp4QwxNjpNQsANwom2Wa6mlbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fr5Ff5x4b8Hn0F3TDh5vhwKzwBB4T8h8nUI6sgzolzE0UQZpjoBvksUPeTqLk4lg3
	 UgajN1Xv0DFpPwhJnXs5lT+L6GQg4UPlAhHXvfO/BjBfl0W11QRepTTsKM+n1beSfl
	 nf9X5rDizpcXWkDV9m5P5QdiDy/N1xzE5IFSs/ZcOfAzXDtAp1N2PH4Q3vyfe+rVsW
	 /K2Jm5wjqhG7kddDNmz/jW+ENp5Nt7IOv1LvW3LA9/wl5BxdX5hbzy2DAEnL6pdfiY
	 ZvtNejS9L14heoku9xi8o7kRSuY9sBReV1/4mh5p3s9gFLVTmsAYFjOm0X9LW9DRVp
	 7OjJptAyMlHVA==
Date: Sun, 6 Apr 2025 11:54:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: adc: ad7124: Fix 3dB filter frequency
 reading
Message-ID: <20250406115418.47f2d397@jic23-huawei>
In-Reply-To: <20250331110214.1eec2513@jic23-huawei>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
	<20250317190031.22c822c4@jic23-huawei>
	<fgd3vr46ijt3kr6onvtulmfulgbr2jpshcyk3dr2pvz7vqs2fq@mka4q2zqmpwe>
	<20250331110214.1eec2513@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Mar 2025 11:02:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 24 Mar 2025 10:44:52 +0100
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > Hello Jonathan,
> >=20
> > On Mon, Mar 17, 2025 at 07:00:31PM +0000, Jonathan Cameron wrote: =20
> > > On Mon, 17 Mar 2025 12:52:46 +0100
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
> > >    =20
> > > > Hello,
> > > >=20
> > > > (implicit) v1 of this patch set is available at
> > > > https://lore.kernel.org/linux-iio/cover.1741801853.git.u.kleine-koe=
nig@baylibre.com
> > > > .
> > > >=20
> > > > Changes since then:
> > > >=20
> > > >  - Reorder patches to have the cleanup ("Make register naming
> > > >    consistent") last
> > > >  - Drop write support for the filter_low_pass_3db_frequency property
> > > >    which is completely broken.
> > > >  - trivially rebase to todays iio/togreg
> > > >=20
> > > > I wonder if there is a way to remove the writable permission of the
> > > > filter_low_pass_3db_frequency sysfs file instead of erroring out wh=
en a
> > > > value is written. Hints welcome.   =20
> > >=20
> > > Unfortunately not. With a lot of hindsight that is a flaw in the way
> > > we generate sysfs attributes. IIRC when hwmon added similar they
> > > avoided that trap.  To retrofit it onto IIO now we'd have to have
> > > some form of complex permissions query or duplicate all the masks
> > > to allow r and w separately.   =20
> >=20
> > OK, fine for me, so I didn't miss anything :-)
> >=20
> > I have another patch in my queue for ad7124. For that it would be great
> > to know if you intend to apply this patch set. If yes, I continue to
> > build on top of this stack. =20
>=20
> Sorry for slow reply.  Bunch of travel (and being a tourist on either end
> of the work bit ;)
>=20
> Subject to the question on patch 1 from Marcelo I'm fine with this.
>=20
> I'll probably take all 3 for next merge window though as patch 1 is
> a minor fix I think in something that people probably haven't really=20
> been using and splitting it makes for a messy cycle.
>=20
Not sure how I managed it, but I had patch 2 already on my tree. Anyhow
backed that out and applied the whole series to the testing branch of iio.g=
it.

Thanks,

Jonathan

> Jonathan
>=20
>=20
>=20
> >=20
> > Best regards
> > Uwe =20
>=20
>=20


